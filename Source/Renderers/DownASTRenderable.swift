//
//  DownASTRenderable.swift
//  Down
//
//  Created by Rob Phillips on 5/31/16.
//  Copyright © 2016-2019 Down. All rights reserved.
//

import Foundation
import libcmark

public protocol DownASTRenderable: DownRenderable {
    func toAST(_ options: DownOptions) throws -> UnsafeMutablePointer<cmark_node>
}

extension DownASTRenderable {
    /// Generates an abstract syntax tree from the `markdownString` property
    ///
    /// - Parameter options: `DownOptions` to modify parsing or rendering, defaulting to `.default`
    /// - Returns: An abstract syntax tree representation of the Markdown input
    /// - Throws: `MarkdownToASTError` if conversion fails
    public func toAST(_ options: DownOptions = .default) throws -> UnsafeMutablePointer<cmark_node> {
        return try DownASTRenderer.stringToAST(markdownString, options: options)
    }
}

public struct DownASTRenderer {
    
    private static let parser: UnsafeMutablePointer<cmark_parser>? = {
        let extensions: [String] = [
            "table",
            "autolink",
            "strikethrough"
        ]
        
        cmark_gfm_core_extensions_ensure_registered()
        
        let newParser = cmark_parser_new(0)
        guard let parser = newParser else {
            return nil
        }
        
        for extName in extensions {
            let ext = extName.withCString { utf8 in
                cmark_find_syntax_extension(utf8)
            }
            
            if let ext = ext {
                cmark_parser_attach_syntax_extension(parser, ext)
            } else {
                print("Failed loading extension \(extName)")
            }
        }
        
        return parser
    }()
    
    
    /// Generates an abstract syntax tree from the given CommonMark Markdown string
    ///
    /// **Important:** It is the caller's responsibility to call `cmark_node_free(ast)` on the returned value
    ///
    /// - Parameters:
    ///   - string: A string containing CommonMark Markdown
    ///   - options: `DownOptions` to modify parsing or rendering, defaulting to `.default`
    /// - Returns: An abstract syntax tree representation of the Markdown input
    /// - Throws: `MarkdownToASTError` if conversion fails
    public static func stringToAST(_ string: String, options: DownOptions = .default) throws -> UnsafeMutablePointer<cmark_node> {
        
        guard let parser = parser else {
            throw DownErrors.markdownToASTError
        }
        
        var tree: UnsafeMutablePointer<cmark_node>?
        
        string.withCString {
            let stringLength = Int(strlen($0))
            cmark_parser_feed(parser, $0, stringLength)
            
            tree = cmark_parser_finish(parser)
        }

        guard let ast = tree else {
            throw DownErrors.markdownToASTError
        }
        return ast
    }
}
