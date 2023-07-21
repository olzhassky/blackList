//
//  singleton.swift
//  blackList
//
//  Created by Olzhas Zhakan on 21.07.2023.
//

import Foundation
import Foil

class AppDefaults {
    static let shared = AppDefaults()
    
    @WrappedDefault(key: "shoppingList")
    var shoppingList: [String] = []
    private init() {
        
    }
    
}
