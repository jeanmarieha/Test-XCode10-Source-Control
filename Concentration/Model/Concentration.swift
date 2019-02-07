//
//  Concentration.swift
//  Concentration
//
//  Created by Jean-Marie on 2019-02-06.
//  Copyright © 2019 Hamaoui, Jean-Marie. All rights reserved.
//

import Foundation

class Concentration {
    var cards = Array<Card>()
    var points = 0
    
    var indexOfOneAndOnlyFaceUpCard: Int?{
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp{
                    if foundIndex == nil {
                        foundIndex = index
                    }
                    else{
                        return nil
                    }
                }
            }
            
            return foundIndex
        }
        set(newValue){
            for index in cards.indices {
                cards[index].isFaceUp = ( index == newValue )
            }
        }
    }
    
    func chooseCard(at index: Int){
        if !cards[index].isMatched {
            
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                //check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    //we have a match
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    points += 2
                    checkGameEnd()
                }
                else{
                    // we dont have a match
                    if cards[index].hasBeenSeen {
                        points -= 1
                    }
                    
                    if cards[matchIndex].hasBeenSeen {
                        points -= 1
                    }
                }
                
                cards[matchIndex].hasBeenSeen = true
                cards[index].hasBeenSeen = true
                
                cards[index].isFaceUp = true
            }
            else {
                indexOfOneAndOnlyFaceUpCard = index
            }
            
            
        }
    }
    
    func checkGameEnd(){
        for card in cards{
            if !card.isMatched {
                return
            }
        }
        
        for index in cards.indices{
            cards[index].isFaceUp = true
        }
    }
    
    init(numberOfPairsOfCards: Int){
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards.append(card)
            cards.append(card)
        }
        // TODO: Shuffle cards
        //
        //cards.shuffle()
        
        //Alternatively for loop + arc4random swap each pos in array
        
        for cardIndex in cards.indices{
            let randomIndex = cards.count.arc4random()
            let tmp = cards[cardIndex]
            
            cards[cardIndex] = cards[randomIndex]
            cards[randomIndex] = tmp
        }
        
    }
}
