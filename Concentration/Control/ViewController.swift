//
//  ViewController.swift
//  Concentration
//
//  Created by Hamaoui, Jean-Marie on 2019-02-01.
//  Copyright © 2019 Hamaoui, Jean-Marie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var pointCounter: UILabel!
    @IBOutlet var cardsArray: [UIButton]!
    
    lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    var themes =  Array<Theme>()
    var currentTheme: Theme!
    
    var emojiDictionary =  Dictionary<Int,String>()
    
    var numberOfPairsOfCards: Int {
        return (cardsArray.count+1)/2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        themes.append(Theme(UIColor.black, UIColor.orange, ["👻", "🎃", "🦇", "😈", "🍎", "🍭", "😱", "🤕", "💀", "🙀"]))
        themes.append(Theme(UIColor.blue, UIColor.cyan, ["🐟", "🦐", "🦈", "🐬", "🍤", "🍣", "🐡", "🐠", "🐙", "🐳"]))
        themes.append(Theme(UIColor.orange, UIColor.red, ["🐷", "🐨", "🦅", "🐗", "🐤", "🐶", "🐭", "🐹", "🐰", "🦊"]))
        themes.append(Theme(UIColor.yellow, #colorLiteral(red: 1, green: 0.7675977349, blue: 0.9948129058, alpha: 1), ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍈", "🍓"]))
        //themes.append(Theme(UIColor.black, UIColor.orange, ["", "", "", "", "", "", "", "", "", ""]))
        //themes.append(Theme(UIColor.black, UIColor.orange, ["", "", "", "", "", "", "", "", "", ""]))
        
        changeCardsColor(UIColor.clear)
        pointCounter.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        
        for button in cardsArray {
            button.layer.cornerRadius = 5
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func startNewGame(_ sender: UIButton) {
        
        currentTheme = themes[themes.count.arc4random()]
        changeCardsColor(currentTheme.foregroundColor)
        pointCounter.textColor = currentTheme.foregroundColor
        self.view.backgroundColor = currentTheme.backgroundColor
        
        
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        updateViewFromModel()
    }
    
    func changeCardsColor(_ color: UIColor){
        for card in cardsArray{
            card.backgroundColor = color
        }
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        
        if let cardNumber = cardsArray.index(of:sender), currentTheme != nil{
            print("Card array index of \(cardNumber)")
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    func updateViewFromModel(){
        for index in cardsArray.indices{
            let button = cardsArray[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for:card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
            else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor =  card.isMatched ? #colorLiteral(red: 0.9400686579, green: 0.8991832508, blue: 1, alpha: 0) : currentTheme.foregroundColor
            }
            
            pointCounter.text = "Point Count: \(game.points)"
        }
    }
    
    
    func emoji(for card: Card) -> String {
        if emojiDictionary[card.identifier] == nil, currentTheme.emojis.count > 0 {
            let randomIndex = currentTheme.emojis.count.arc4random()
            emojiDictionary[card.identifier] = currentTheme.emojis.remove(at: randomIndex)
            
        }
        return emojiDictionary[card.identifier] ?? "?"
    }
}

extension Int {
    func arc4random() -> Int{
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        }
        else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }
        else {
            return 0
        }
    }
}
