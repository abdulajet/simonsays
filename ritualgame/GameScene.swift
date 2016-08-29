//
//  GameScene.swift
//  ritualgame
//
//  Created by Abdulhakim Ajetunmobi on 30/01/2016.
//  Copyright (c) 2016 5to9 Studios. All rights reserved.
//

import SpriteKit
import AVFoundation

var keys: [String] = ["a", "b", "c note", "c octv", "d", "e", "f", "g"]
var URLs = Array<NSURL>(count: 8, repeatedValue: NSURL())
var notes = Array<AVAudioPlayer>(count: 8, repeatedValue: AVAudioPlayer())
var monk1 = sprite(sprite: SKSpriteNode(), currNote: 0, rightNote: 0)
var monk2 = sprite(sprite: SKSpriteNode(), currNote: 3, rightNote: 0)
var monk3 = sprite(sprite: SKSpriteNode(), currNote: 7, rightNote: 0)
var numberOfMonks = 3
var numberOfNotes = 8
var sequencePlay = SKLabelNode(text: "play sequence")
var userSequencePlay = SKLabelNode(text: "check if correct")
var sequence = ""
var sprite1Add = SKSpriteNode()
var sprite2Add = SKSpriteNode()
var sprite3Add = SKSpriteNode()
var sprite1Sub = SKSpriteNode()
var sprite2Sub = SKSpriteNode()
var sprite3Sub = SKSpriteNode()
let bg = SKSpriteNode(imageNamed: "bg")
var sprNoteNum1 = SKLabelNode()
var sprNoteNum2 = SKLabelNode()
var sprNoteNum3 = SKLabelNode()
let action = SKAction.rotateByAngle(CGFloat(2 * M_PI), duration:1)
var gameOver = false


class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        //background
        bg.size = CGSizeMake(frame.width, frame.height)
        bg.position = CGPointMake(frame.width / 2, frame.height / 2)
        bg.zPosition = -1
        bg.alpha = 1
        
        //sets up note urls
        for (var i = 0; i <= 7; i += 1){
            URLs[i] = NSBundle.mainBundle().URLForResource(keys[i], withExtension: "wav")!
        }
        
        //sets up note sounds
        for (var i = 0; i <= 7; i += 1){
            do {
                notes[i] = try AVAudioPlayer(contentsOfURL: URLs[i], fileTypeHint: nil)
            }catch let error as NSError {
                print(error.description)
            }
            notes[i].numberOfLoops = 0
            notes[i].prepareToPlay()
        }
       
        
        //sets up monks
        monk1.sprite = SKSpriteNode(imageNamed:"sprite")
        monk1.sprite.setScale(1)
        monk1.sprite.position = CGPointMake(frame.width/2 - 300, frame.height / 2)
        
        monk2.sprite = SKSpriteNode(imageNamed:"sprite")
        monk2.sprite.setScale(1)
        monk2.sprite.position = CGPointMake(frame.width / 2 , frame.height / 2)
        
        monk3.sprite = SKSpriteNode(imageNamed:"sprite")
        monk3.sprite.setScale(1)
        monk3.sprite.position = CGPointMake(frame.width/2 + 300, frame.height / 2)
        
        
        //play buttons
        sequencePlay.fontName = "Arial"
        sequencePlay.fontColor = UIColor.blackColor()
        sequencePlay.fontSize = 60
        sequencePlay.position = CGPointMake(monk1.sprite.position.x, frame.height / 2 + 200)
        userSequencePlay.fontName = "Arial"
        userSequencePlay.fontColor = UIColor.blackColor()
        userSequencePlay.fontSize = 60
        userSequencePlay.position = CGPointMake(monk3.sprite.position.x, frame.height / 2 + 200)
        
        
        
        //plus and subtract btns & labels
        sprite1Add = SKSpriteNode(imageNamed:"addBtn")
        sprite1Add.position = CGPointMake(monk1.sprite.position.x + 100 ,frame.height / 2 - 200)
        sprite1Add.setScale(0.5)
        sprite2Add = SKSpriteNode(imageNamed:"addBtn")
        sprite2Add.position = CGPointMake(monk2.sprite.position.x + 100, frame.height / 2 - 200)
        sprite2Add.setScale(0.5)
        sprite3Add = SKSpriteNode(imageNamed:"addBtn")
        sprite3Add.position = CGPointMake(monk3.sprite.position.x + 100, frame.height / 2 - 200)
        sprite3Add.setScale(0.5)
        
        sprite1Sub = SKSpriteNode(imageNamed:"subBtn")
        sprite1Sub.position = CGPointMake(monk1.sprite.position.x - 100, frame.height / 2 - 200)
        sprite1Sub.setScale(0.5)
        sprite2Sub = SKSpriteNode(imageNamed:"subBtn")
        sprite2Sub.position = CGPointMake(monk2.sprite.position.x - 100, frame.height / 2 - 200)
        sprite2Sub.setScale(0.5)
        sprite3Sub = SKSpriteNode(imageNamed:"subBtn")
        sprite3Sub.position = CGPointMake(monk3.sprite.position.x - 100, frame.height / 2 - 200)
        sprite3Sub.setScale(0.5)
        
        sprNoteNum1.text = "Note: \(monk1.currNote + 1)"
        sprNoteNum1.fontName = "Arial"
        sprNoteNum1.fontColor = UIColor.redColor()
        sprNoteNum1.position = CGPointMake(monk1.sprite.position.x ,frame.height / 2 - 210)
        sprNoteNum2.text = "Note: \(monk2.currNote + 1)"
        sprNoteNum2.fontName = "Arial"
        sprNoteNum2.fontColor = UIColor.redColor()
        sprNoteNum2.position = CGPointMake(monk2.sprite.position.x ,frame.height / 2 - 210)
        sprNoteNum3.text = "Note: \(monk3.currNote + 1)"
        sprNoteNum3.fontName = "Arial"
        sprNoteNum3.fontColor = UIColor.redColor()
        sprNoteNum3.position = CGPointMake(monk3.sprite.position.x ,frame.height / 2 - 210)
        
        self.addChild(sprNoteNum1)
        self.addChild(sprNoteNum2)
        self.addChild(sprNoteNum3)
        self.addChild(sprite1Add)
        self.addChild(sprite2Add)
        self.addChild(sprite3Add)
        self.addChild(sprite1Sub)
        self.addChild(sprite2Sub)
        self.addChild(sprite3Sub)
        self.addChild(sequencePlay)
        self.addChild(userSequencePlay)
        self.addChild(monk1.sprite)
        self.addChild(monk2.sprite)
        self.addChild(monk3.sprite)
        self.addChild(bg)
        
        createSequence(numberOfMonks)
        
     
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            if (nodeAtPoint(location) == bg){
                
            }
            
            if(nodeAtPoint(location) == sequencePlay){
                playSequence()
            }
            
            if(nodeAtPoint(location) == userSequencePlay){
                verifyUserSequence()
            }
            
            if(nodeAtPoint(location) == monk1.sprite){
                notes[monk1.currNote].play()
            }
            
            if(nodeAtPoint(location) == monk2.sprite){
                notes[monk2.currNote].play()
            }
            
            if(nodeAtPoint(location) == monk3.sprite){
                notes[monk3.currNote].play()
            }
            
            if(nodeAtPoint(location) == sprite1Add){
                if (monk1.currNote < 7){
                    monk1.currNote += 1
                    sprNoteNum1.text = "Note: \(monk1.currNote + 1)"
                    print("1 curr: \(monk1.currNote)")
                    
                }
            }
            if(nodeAtPoint(location) == sprite2Add){
                if (monk2.currNote < 7){
                    monk2.currNote += 1
                    sprNoteNum2.text = "Note: \(monk2.currNote + 1)"
                    print("2 curr: \(monk2.currNote)")
                    
                }
            }
            if(nodeAtPoint(location) == sprite3Add){
                if (monk3.currNote < 7){
                    monk3.currNote += 1
                    sprNoteNum3.text = "Note: \(monk3.currNote + 1)"
                    print("3 curr: \(monk3.currNote)")
                    
                }
            }
            
            if(nodeAtPoint(location) == sprite1Sub){
                if (monk1.currNote > 0){
                    monk1.currNote -= 1
                    sprNoteNum1.text = "Note: \(monk1.currNote + 1)"
                    print("1 curr: \(monk1.currNote)")
                }
            }
            if(nodeAtPoint(location) == sprite2Sub){
                if (monk2.currNote > 0){
                    monk2.currNote -= 1
                    sprNoteNum2.text = "Note: \(monk2.currNote + 1)"
                    print("2 curr: \(monk2.currNote)")
                }
            }
            if(nodeAtPoint(location) == sprite3Sub){
                if (monk3.currNote > 0){
                    monk3.currNote -= 1
                    sprNoteNum3.text = "Note: \(monk3.currNote + 1)"
                    print("3 curr: \(monk3.currNote)")
                }
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if (sequence == "fail"){
            sequence = ""
            createSequence(numberOfMonks)
        }
        
        if (gameOver){
            //transition
            gameOver = false
            let transition = SKTransition.fadeWithDuration(1)
            
            let scene = EndScene(size: self.size)
            scene.scaleMode = SKSceneScaleMode.AspectFill
            
            self.view?.presentScene(scene, transition: transition)
        }
    }
    
    func createSequence(numberOfNotes: Int){
        sequence = ""
        for (var i = 0; i < numberOfMonks; i += 1){
            let randomInt = arc4random_uniform(UInt32(numberOfNotes))
            
            if(randomInt == 1){
                if (i == numberOfNotes - 1) {
                    i -= 1
                }else{
                    sequence += "1"
                    let randomBInt = arc4random_uniform(UInt32(3))
                    switch randomBInt{
                        
                    case (0):
                        i += 1
                        sequence += "3"
                        break
                        
                    case (1):
                        i += 1
                        sequence += "4"
                        break
                        
                    case (2):
                        i += 1
                        sequence += "5"
                        break
                        
                    default:
                        break
                    }
                }
            }else{
                sequence += String(randomInt)
            }
        }
        
        
        var tempStr = sequence.substringWithRange(0, location: 1)
        monk1.rightNote = Int(tempStr)!
        
        tempStr = sequence.substringWithRange(1, location: 1)
        monk2.rightNote = Int(tempStr)!
        
        tempStr = sequence.substringWithRange(2, location: 1)
        monk3.rightNote = Int(tempStr)!
        print("sequence: \(sequence)")
        
        
//        if(monk1.rightNote == monk2.rightNote || monk2.rightNote == monk3.rightNote){
//            print("dupe: \(sequence)")
//            sequence = "fail"
//        }
    }
    
    func playSequence(){
        print("sequence: \(sequence)")
        
        let delay = 1 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        let delay2 = 2 * Double(NSEC_PER_SEC)
        let time2 = dispatch_time(DISPATCH_TIME_NOW, Int64(delay2))
        
        dispatch_after(0, dispatch_get_main_queue()) {
            notes[monk1.rightNote].play()
        }
        
        dispatch_after(time, dispatch_get_main_queue()) {
            notes[monk2.rightNote].play()
        }
        
        dispatch_after(time2, dispatch_get_main_queue()) {
            notes[monk3.rightNote].play()
            
        }
    }
    
    func verifyUserSequence(){
        print("user sequence: \(monk1.currNote, monk2.currNote, monk3.currNote)")
        if((monk1.currNote == monk1.rightNote) && (monk2.currNote == monk2.rightNote) && (monk3.currNote == monk3.rightNote)){
            playSequence()
            monk1.sprite.runAction(action)
            monk2.sprite.runAction(action)
            monk3.sprite.runAction(action)
            
            let delay = 1 * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            
            dispatch_after(time, dispatch_get_main_queue()) {
                self.removeAllChildren()
                self.removeAllActions()
                gameOver = true
            }
            

            
        }else{
            let delay = 1 * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            
            let delay2 = 2 * Double(NSEC_PER_SEC)
            let time2 = dispatch_time(DISPATCH_TIME_NOW, Int64(delay2))
            
            
            dispatch_after(0, dispatch_get_main_queue()) {
                notes[monk1.currNote].play()
            }
            
            dispatch_after(time, dispatch_get_main_queue()) {
                notes[monk2.currNote].play()
            }
            
            dispatch_after(time2, dispatch_get_main_queue()) {
                notes[monk3.currNote].play()
                
            }
        }
    }
}
