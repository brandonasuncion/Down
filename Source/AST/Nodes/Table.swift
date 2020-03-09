//
//  File.swift
//  
//
//  Created by Brandon Asuncion on 3/6/20.
//

import Foundation


public class Table: BaseNode {
    public private(set) lazy var literal: String? = cmarkNode.literal
    
    public var columns: Int {
        cmark_gfm_extensions_get_table_columns(cmarkNode)
    }

    public var alignments: UInt8 {
        cmark_gfm_extensions_get_table_alignments(cmarkNode)
    }
}

public class TableRow: BaseNode {
    public private(set) lazy var literal: String? = cmarkNode.literal

    public var isHeader: Bool {
        cmark_gfm_extensions_get_table_row_is_header(cmarkNode) != 0
    }
}

public class TableCell: BaseNode {
    public private(set) lazy var innerText: String = cmarkNode.literal ?? ""
    public private(set) lazy var innerLength: Int = literal.count
    public private(set) lazy var maxWordLen: Int = literal
        .split(separator: " ")
        .compactMap { String($0).count }
        .max() ?? 0
}





extension Table: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "Table - content: \(literal)"
    }
}

extension TableRow: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "TableRow - content: \(literal)"
    }
}

extension TableCell: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "TableCell - content: \(literal)"
    }
}
