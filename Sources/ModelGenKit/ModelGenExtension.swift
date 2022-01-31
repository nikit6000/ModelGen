//
//  ModelGenExtension.swift
//  ModelGen
//
//  Created by Nikita on 31.01.2022.
//

import Stencil

class ModelGenExtensions: Extension {
    
    override init() {
        super.init()
        registerDefaultFilters()
    }
    
    private func registerDefaultFilters() {
        registerFilter("backticksReservedWords", filter: backticksReservedWords)
        registerFilter("replaceSnakeSize", filter: replaceSnakeSize)
    }
}
