//
//  ConvertibleTypes.swift
//  Ditto
//
//  Created by Kevin Lin on 7/9/16.
//  Copyright © 2016 Kevin. All rights reserved.
//

import Foundation

// MARK: DefaultConvertible

/**
 DefaultConvertible simply return the current object.
 */
public protocol DefaultConvertible: Convertible {}

extension DefaultConvertible {
    public func convert() -> Any? {
        return self
    }
}

extension String: DefaultConvertible {}
extension Int: DefaultConvertible {}
extension UInt: DefaultConvertible {}
extension Float: DefaultConvertible {}
extension Double: DefaultConvertible {}
extension Bool: DefaultConvertible {}
extension NSString: DefaultConvertible {}
extension NSNumber: DefaultConvertible {}

// MARK: Frequently used convertible types

extension Int8: Convertible {
    public func convert() -> Any? {
        return NSNumber(value: self)
    }
}

extension Int16: Convertible {
    public func convert() -> Any? {
        return NSNumber(value: self)
    }
}

extension Int32: Convertible {
    public func convert() -> Any? {
        return NSNumber(value: self)
    }
}

extension Int64: Convertible {
    public func convert() -> Any? {
        return NSNumber(value: self)
    }
}

extension UInt8: Convertible {
    public func convert() -> Any? {
        return NSNumber(value: self)
    }
}

extension UInt16: Convertible {
    public func convert() -> Any? {
        return NSNumber(value: self)
    }
}

extension UInt32: Convertible {
    public func convert() -> Any? {
        return NSNumber(value: self)
    }
}

extension UInt64: Convertible {
    public func convert() -> Any? {
        return NSNumber(value: self)
    }
}

extension URL: Convertible {
    public func convert() -> Any? {
        return self.absoluteString
    }
}

extension NSURL: Convertible {
    public func convert() -> Any? {
        return self.absoluteString
    }
}

extension NSNull: Convertible {
    public func convert() -> Any? {
        return nil
    }
}

extension Array: Convertible {
    public func convert() -> Any? {
        return convertSequence(sequence: self)
    }
}

extension NSArray: Convertible {
    public func convert() -> Any? {
        return convertSequence(sequence: self)
    }
}

extension Dictionary: Convertible {
    public func convert() -> Any? {
        var jsonObject = JSONObject()
        for (key, value) in self {
            guard let key = key as? String else {
                continue
            }
            jsonObject[key] = convertAny(any: value)
        }
        return jsonObject
    }
}

extension Optional: Convertible {
    public func convert() -> Any? {
        switch self {
        case let .some(value):
            if let value = convertAny(any: value) {
                return value
            } else {
                return nil
            }
        default:
            return nil
        }
    }
}

// MARK: Helpers

private func convertAny(any: Any) -> Any? {
    if let convertible = any as? Convertible {
        return convertible.convert()
    } else if let serializable = any as? Serializable {
        return serializable.serialize()
    } else {
        return nil
    }
}

private func convertSequence<T: Sequence>(sequence: T) -> [Any] {
    var convertedArray = [Any]()
    for element in sequence {
        if let element = convertAny(any: element) {
            convertedArray.append(element)
        }
    }
    return convertedArray
}
