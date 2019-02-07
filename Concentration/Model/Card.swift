//
//  Card.swift
//  Concentration
//
//  Created by Jean-Marie on 2019-02-06.
//  Copyright © 2019 Hamaoui, Jean-Marie. All rights reserved.
//

import Foundation

struct Card{
    var isFaceUp = false
    var isMatched = false
    var hasBeenSeen = false
    var identifier: Int
    
    static var identifierCount = 0
    
    static func getUniqueIdentifier() -> Int{
        identifierCount += 1
        return identifierCount
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
