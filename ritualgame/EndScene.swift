//
//  EndScene.swift
//  ritualgame
//
//  Created by Abdulhakim Ajetunmobi on 31/01/2016.
//  Copyright © 2016 5to9 Studios. All rights reserved.
//

import SpriteKit

let infoLabel = SKLabelNode()
let infoLabel2 = SKLabelNode()
var replaylabel = SKLabelNode()

class EndScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        infoLabel.text = "Thanks for playing. "
        infoLabel2.text = "Reach me at: 5to9studios.com"
        replaylabel.text = "Play again?"
        infoLabel.position = CGPointMake(frame.width / 2, frame.height / 2)
        infoLabel2.position = CGPointMake(frame.width / 2, frame.height / 2 + 60)
        replaylabel.position = CGPointMake(frame.width / 2, frame.height / 2 - 120)
        infoLabel.fontSize = 60
        infoLabel2.fontSize = 60
        replaylabel.fontSize = 60

        
        self.addChild(infoLabel)
        self.addChild(infoLabel2)
        self.addChild(replaylabel)

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)

            if nodeAtPoint(location) == replaylabel {
                let transition = SKTransition.fadeWithDuration(1)
                
                let scene = GameScene(size: self.size)
                scene.scaleMode = SKSceneScaleMode.AspectFill
                
                self.removeAllChildren()
                self.view?.presentScene(scene, transition: transition)
            }
        }
        
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        
    }
    
    
}