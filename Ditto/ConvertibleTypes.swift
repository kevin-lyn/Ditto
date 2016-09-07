//
//  ConvertibleTypes.swift
//  Ditto
//
//  Created by Kevin Lin on 7/9/16.
//  Copyright © 2016 Kevin. All rights reserved.
//

import Foundation

/**
 DefaultConvertible simply return the current object.
 */
public protocol DefaultConvertible: Convertible {}

extension DefaultConvertible {
    public func convert() -> Any {
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

extension Int8: Convertible {
    public func convert() -> Any {
        return NSNumber(value: self)
    }
}

extension Int16: Convertible {
    public func convert() -> Any {
        return NSNumber(value: self)
    }
}

extension Int32: Convertible {
    public func convert() -> Any {
        return NSNumber(value: self)
    }
}

extension Int64: Convertible {
    public func convert() -> Any {
        return NSNumber(value: self)
    }
}

extension UInt8: Convertible {
    public func convert() -> Any {
        return NSNumber(value: self)
    }
}

extension UInt16: Convertible {
    public func convert() -> Any {
        return NSNumber(value: self)
    }
}

extension UInt32: Convertible {
    public func convert() -> Any {
        return NSNumber(value: self)
    }
}

extension UInt64: Convertible {
    public func convert() -> Any {
        return NSNumber(value: self)
    }
}

extension URL: Convertible {
    public func convert() -> Any {
        return self.absoluteString
    }
}

extension NSURL: Convertible {
    public func convert() -> Any {
        return self.absoluteString
    }
}
