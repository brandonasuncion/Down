//
//  File.swift
//  
//
//  Created by Brandon Asuncion on 3/6/20.
//

import Foundation


public class Strikethrough: BaseNode {
    public private(set) lazy var literal: String? = cmarkNode.literal
}

// MARK: - Debug

extension Strikethrough: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        return "Strikethrough - \(literal ?? "nil")"
    }
}
