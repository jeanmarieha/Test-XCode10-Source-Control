//
//  Theme.swift
//  Concentration
//
//  Created by Hamaoui, Jean-Marie on 2019-02-07.
//  Copyright © 2019 Hamaoui, Jean-Marie. All rights reserved.
//

import Foundation
import UIKit

struct Theme {
    var backgroundColor: UIColor
    var foregroundColor: UIColor
    
    var emojis: Array<String>
    
    init(_ backgroundColor: UIColor, _ foregroundColor: UIColor, _ emojis: Array<String>){
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.emojis = emojis
    }
    
}
