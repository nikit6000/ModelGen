//
//  Filters.swift
//  ModelGen
//
//  Created by Heberti Almeida on 2017-05-15.
//  Copyright © 2017 ModelGen. All rights reserved.
//

import Foundation

/// Convert string to TitleCase
///
/// - Parameter string: Input string
/// - Returns: Transformed string
func titlecase(_ string: String) -> String {
    guard let first = string.unicodeScalars.first else { return string }
    return String(first).uppercased() + String(string.unicodeScalars.dropFirst())
}

/// Generates/fixes a variable name in sentence case with the first letter as lowercase.
/// Replaces invalid names and swift keywords.
/// Ensures all caps are maintained if previously set in the name.
///
/// - Parameter variableName: Name of the variable in the JSON.
/// - Returns: A generated string representation of the variable name.
func fixVariableName(_ variableName: String) -> String {
    var name = replaceKeywords(variableName)
    name.replaceOccurrencesOfStringsWithString(["-", "_"], " ")
    name.trim()

    var finalVariableName = ""
    for (index, var element) in name.components(separatedBy: " ").enumerated() {
        element = index == 0 ? element.lowerCaseFirst() : element.uppercaseFirst()
        finalVariableName.append(element)
    }
    return finalVariableName
}

/// Cross checks the current name against a possible set of keywords, this list is no where
/// extensive, but it is not meant to be, user should be able to do this in the unlikely
/// case it happens.
///
/// - Parameter currentName: The current name which has to be checked.
/// - Returns: New name for the variable.
func replaceKeywords(_ currentName: String) -> String {
    let keywordsWithReplacements = [
        "class": "classProperty",
        "struct": "structProperty",
        "enum": "enumProperty",
        "internal": "internalProperty",
        "default": "defaultValue"]
    if let value = keywordsWithReplacements[currentName] {
        return value
    }
    return currentName
}

func backticksReservedWords(input: Any?) -> Any? {
    guard let string = input as? String else {
        return nil
    }
    
    let reservedWords = ["associatedtype", "class", "deinit", "enum", "extension", "fileprivate", "func", "import", "init", "inout", "internal", "let", "open", "operator", "private", "precedencegroup", "protocol", "public", "rethrows", "static", "struct", "subscript", "typealias", "var", "associativity", "convenience", "didSet", "dynamic", "final", "get", "indirect", "infix", "lazy", "left", "mutating", "none", "nonmutating", "optional", "override", "postfix", "precedence", "prefix", "Protocol", "required", "right", "set", "some", "Type", "unowned", "weak", "willSet", "Any", "as", "catch", "false", "is", "nil", "rethrows", "self", "Self", "super", "throw", "throws", "true", "try", "break", "case", "catch", "continue", "default", "defer", "do", "else", "fallthrough", "for", "guard", "if", "in", "repeat", "return", "throw", "switch", "where", "while"
    ]
    
    if reservedWords.contains(string) {
        return "`\(string)`"
    } else {
        return string
    }
}

func replaceSnakeSize(input: Any?) -> Any? {
    guard
        let string = input as? String,
        let regex = try? NSRegularExpression(pattern: "([0-9])_([0-9])", options: .caseInsensitive)
    else {
        return nil
    }
    
    return regex.stringByReplacingMatches(
        in: string,
        options: [],
        range: NSRange(location: 0, length: string.count),
        withTemplate: "$1x$2"
    )
}
