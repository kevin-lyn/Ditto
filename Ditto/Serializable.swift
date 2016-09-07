//
//  Serializable.swift
//  Ditto
//
//  Created by Kevin Lin on 6/9/16.
//  Copyright © 2016 Kevin. All rights reserved.
//

public typealias JSONObject = [String: Any]
public typealias JSONArray = [JSONObject]

/// Mapping defines how a object field should be mapped to JSON object field.
public typealias Mapping = [String: String]

/**
 Serializable defines the common behaviors of serializing a object.
 Default implementation of `serialize` is provided.
 */
public protocol Serializable {
    
    /**
     Serialize the current object to a JSON object.
     Non-convertible field of the current object will be ignored.
     
     - important: Please do not override this function if it's not neccesary.
     - returns: `JSONObject`
     */
    func serialize() -> JSONObject
    
    /**
     Mapping from the current object field to JSON object field.
     Auto mapping is provided with built-in mapping styles, please refer to `AutoMapping`.
     
     Example:
     ```
     [
        "fisrtName": "first_name",
        "lastName": "last_name"
     ]
     ```
     
     - returns: `Mapping`
     */
    func serializableMapping() -> Mapping
}

private protocol OptionalProtocol {}
extension Optional: OptionalProtocol {}

extension Serializable {
    public func serialize() -> JSONObject {
        let mapping = self.serializableMapping()
        let mirror = Mirror(reflecting: self)
        var jsonObject = JSONObject()
        for child in mirror.children {
            guard let label = child.label else {
                continue
            }
            guard let jsonField = mapping[label] else {
                continue
            }
            
            let value: Any?
            if child.value is OptionalProtocol {
                value = unwrapOptional(of: child.value)
            } else {
                value = child.value
            }
            
            guard let unwrappedValue = value else {
                continue
            }
            if let serializable = unwrappedValue as? Serializable {
                jsonObject[jsonField] = serializable.serialize()
            } else if let convertible = unwrappedValue as? Convertible {
                jsonObject[jsonField] = convertible.convert()
            }
        }
        return jsonObject
    }
    
    private func unwrapOptional(of value: Any) -> Any? {
        let mirror = Mirror(reflecting: value)
        if mirror.displayStyle != .optional {
            return value
        }
        if mirror.children.count == 0 {
            return nil
        }
        return mirror.children.first?.value
    }
}

extension Array where Element: Serializable {
    func serialize() -> JSONArray {
        var jsonArray = JSONArray()
        for serializable in self {
            jsonArray.append(serializable.serialize())
        }
        return jsonArray
    }
}
