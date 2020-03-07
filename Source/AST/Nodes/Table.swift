//
//  File.swift
//  
//
//  Created by Brandon Asuncion on 3/6/20.
//

import Foundation


public class Table: BaseNode {
    public private(set) lazy var literal: String? = cmarkNode.literal
    public private(set) lazy var fenceInfo: String? = cmarkNode.fenceInfo
}

extension Table: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "Table - content: \(literal)"
    }
}


public class TableRow: BaseNode {
    public private(set) lazy var literal: String? = cmarkNode.literal
    public private(set) lazy var fenceInfo: String? = cmarkNode.fenceInfo
}

extension TableRow: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "TableRow - content: \(literal)"
    }
}


public class TableCell: BaseNode {
    public private(set) lazy var literal: String? = cmarkNode.literal
    public private(set) lazy var fenceInfo: String? = cmarkNode.fenceInfo
}

extension TableCell: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "TableCell - content: \(literal)"
    }
}
