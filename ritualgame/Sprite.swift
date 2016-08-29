//
//  Sprite.swift
//  ritualgame
//
//  Created by Abdulhakim Ajetunmobi on 30/01/2016.
//  Copyright © 2016 5to9 Studios. All rights reserved.
//

import SpriteKit

class sprite{
    var sprite = SKSpriteNode()
    var currNote = 0
    var rightNote = 0
    
    init(sprite: SKSpriteNode, currNote: Int, rightNote: Int){
        self.sprite = sprite
        self.currNote = currNote
        self.rightNote = rightNote
    }
}
