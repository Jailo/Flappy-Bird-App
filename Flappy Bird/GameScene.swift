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
    
    func makePipes() {
        
        
        //Adds randomized gap between upper and lower pipes
        
        let movePipes = SKAction.move(by: CGVector(dx: -2 * self.frame.width, dy: 0), duration:TimeInterval(self.frame.width / 100))
        
        let gapHeight = bird.size.height * 5
        
        let movementAmount = arc4random() % UInt32(self.frame.height / 2)
        
        let pipeOffset = CGFloat(movementAmount) - self.frame.height / 4
        
        
        //Upper Pipe
        
        let pipeTexture = SKTexture(imageNamed: "pipe1.png")
        
        let pipe1 = SKSpriteNode(texture: pipeTexture)
        
        pipe1.position = CGPoint(x: self.frame.midX + self.frame.width, y: self.frame.midY + pipeTexture.size().height / 2 + gapHeight / 2 + pipeOffset)
        
        pipe1.run(movePipes)
        
        self.addChild(pipe1)
        
        
        // Lower Pipe
        
        let pipeTexture2 = SKTexture(imageNamed: "pipe2.png")
        
        let pipe2 = SKSpriteNode(texture: pipeTexture2)
        
        pipe2.position = CGPoint(x: self.frame.midX + self.frame.width, y: self.frame.midY - pipeTexture2.size().height / 2 - gapHeight / 2 + pipeOffset)
        
        pipe2.run(movePipes)
        
        self.addChild(pipe2)
        
    }

    
    override func didMove(to view: SKView) {
        
        _ = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.makePipes), userInfo: nil, repeats: true)
        
        //background
        
        let backgroundTexture = SKTexture(imageNamed: "bg.png")
        
        let backgroundAnimation = SKAction.move(by: CGVector(dx: -backgroundTexture.size().width, dy: 0), duration: 5)
        let shiftBackgroundAnimation = SKAction.move(by: CGVector(dx: backgroundTexture.size().width, dy: 0), duration: 0)
        let moveBackgroundAnimationForever = SKAction.repeatForever(SKAction.sequence([backgroundAnimation, shiftBackgroundAnimation]))
        
        var i: CGFloat = 0
        
        while i < 3 {
            
            background = SKSpriteNode(texture: backgroundTexture)
            
            background.position = CGPoint(x: backgroundTexture.size().width * i, y: self.frame.midY)
            
            background.size.height = self.frame.height
            
            background.run(moveBackgroundAnimationForever)
            
            background.zPosition = -1
            
            self.addChild(background)
            
            i += 1
            
        }
        
       
        
        
        //flappy bird
        
        let birdTexture = SKTexture(imageNamed: "flappy1.png")
        
        let birdTexture2 = SKTexture(imageNamed: "flappy2.png")
        
        bird = SKSpriteNode(texture: birdTexture)
        
        let flapAnimation = SKAction.animate(with: [birdTexture, birdTexture2], timePerFrame: 0.4)
        let flyingAnimation = SKAction.repeatForever(flapAnimation)
        
        bird.run(flyingAnimation)
        
        bird.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        self.addChild(bird)
        
        
        //Ground barrier
        
        let ground = SKNode()
        
        ground.position = CGPoint(x: self.frame.midX, y: -self.frame.height / 2)
        
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width, height: 1))
        
        ground.physicsBody!.isDynamic = false
        
        self.addChild(ground)
        
      
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //Makes bird jolt upwards when tapped
        
        let birdTexture = SKTexture(imageNamed: "flappy1.png")
        
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().width / 2)
        
        bird.physicsBody!.velocity = CGVector(dx: 0, dy: 0)

        bird.physicsBody!.applyImpulse(CGVector(dx: 0, dy: 180))

        
        
    }
    

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
     
        
        
    }
}
