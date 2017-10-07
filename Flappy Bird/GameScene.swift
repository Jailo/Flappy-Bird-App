//
//  GameScene.swift
//  Flappy Bird
//
//  Created by Jaiela London on 10/6/17.
//  Copyright © 2017 Jaiela London. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var bird = SKSpriteNode()
    
    var background = SKSpriteNode()

    
    override func didMove(to view: SKView) {
        
        
        //background
        
        let backgroundTexture = SKTexture(imageNamed: "bg.png")
        
        background = SKSpriteNode(texture: backgroundTexture)
        
        background.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        background.size = CGSize(width: self.frame.width, height: self.frame.height)
        
        let backgroundAnimation = SKAction.move(by: CGVector(dx: -1, dy: 0), duration: 0.1)
        let moveBackgroundAnimation = SKAction.repeatForever(backgroundAnimation)
        
        background.run(moveBackgroundAnimation)
        
        self.addChild(background)
        
        
        //flappy bird
        
        let birdTexture = SKTexture(imageNamed: "flappy1.png")
        
        let birdTexture2 = SKTexture(imageNamed: "flappy2.png")
        
        bird = SKSpriteNode(texture: birdTexture)
        
        bird.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        let flapAnimation = SKAction.animate(with: [birdTexture, birdTexture2], timePerFrame: 0.4)
        let flyingAnimation = SKAction.repeatForever(flapAnimation)
        
        bird.run(flyingAnimation)
        
        self.addChild(bird)
        
      
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
     
        
        
    }
}
