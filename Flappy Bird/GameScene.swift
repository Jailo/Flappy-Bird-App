//
//  GameScene.swift
//  Flappy Bird
//
//  Created by Jaiela London on 10/6/17.
//  Copyright © 2017 Jaiela London. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var bird = SKSpriteNode()
    
    var background = SKSpriteNode()
    
    enum ColliderTypes: UInt32 {
    
        case Bird = 1
        
        case Object = 2
        
        case Gap = 4
    }
    
    var gameOver = false
    
    var gameOverLabel = SKLabelNode()
    
    var scoreLabel = SKLabelNode()
    
    var score = 0
    
    var timer = Timer()
    
    func makePipes() {
        
        
        //Adds randomized gap between upper and lower pipes
        
        let movePipes = SKAction.move(by: CGVector(dx: -2 * self.frame.width, dy: 0), duration:TimeInterval(self.frame.width / 100))
        
        let gapHeight = bird.size.height * 5 // normal = 5 Jeshua mode = 13
        
        let movementAmount = arc4random() % UInt32(self.frame.height / 2)
        
        let gapOffset = CGFloat(movementAmount) - self.frame.height / 4
        
        
        //Upper Pipe
        
        let pipeTexture = SKTexture(imageNamed: "pipe1.png")
        
        let pipe1 = SKSpriteNode(texture: pipeTexture)
        
        pipe1.position = CGPoint(x: self.frame.midX + self.frame.width, y: self.frame.midY + pipeTexture.size().height / 2 + gapHeight / 2 + gapOffset)
        
        pipe1.zPosition = -1
        
        pipe1.run(movePipes)
        
        pipe1.physicsBody = SKPhysicsBody(rectangleOf: pipeTexture.size())
        
        pipe1.physicsBody!.isDynamic = false
        
        pipe1.physicsBody!.contactTestBitMask = ColliderTypes.Object.rawValue
        
        pipe1.physicsBody!.categoryBitMask = ColliderTypes.Object.rawValue
        
        pipe1.physicsBody!.collisionBitMask = ColliderTypes.Object.rawValue
        
        self.addChild(pipe1)
        
        
        // Lower Pipe
        
        let pipeTexture2 = SKTexture(imageNamed: "pipe2.png")
        
        let pipe2 = SKSpriteNode(texture: pipeTexture2)
        
        pipe2.position = CGPoint(x: self.frame.midX + self.frame.width, y: self.frame.midY - pipeTexture2.size().height / 2 - gapHeight / 2 + gapOffset)
        
        pipe2.zPosition = -1
        
        pipe2.run(movePipes)
        
        pipe2.physicsBody = SKPhysicsBody(rectangleOf: pipeTexture2.size())
        
        pipe2.physicsBody!.isDynamic = false
        
        pipe2.physicsBody!.contactTestBitMask = ColliderTypes.Object.rawValue
        
        pipe2.physicsBody!.categoryBitMask = ColliderTypes.Object.rawValue
        
        pipe2.physicsBody!.collisionBitMask = ColliderTypes.Object.rawValue
        
        self.addChild(pipe2)
        
        let gap = SKNode()
        
        gap.position = CGPoint(x: self.frame.midX + self.frame.width, y: self.frame.midY + gapOffset)
        
        gap.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: pipeTexture.size().width, height: gapHeight))
        
        gap.physicsBody!.isDynamic = false
        
        gap.run(movePipes)
        
        gap.physicsBody!.contactTestBitMask = ColliderTypes.Bird.rawValue
        gap.physicsBody!.categoryBitMask = ColliderTypes.Gap.rawValue
        gap.physicsBody?.collisionBitMask = ColliderTypes.Gap.rawValue
        
        self.addChild(gap)
        
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if gameOver == false {
            
        if contact.bodyA.categoryBitMask == ColliderTypes.Gap.rawValue || contact.bodyB.categoryBitMask == ColliderTypes.Gap.rawValue {
            
            score += 1
            
            scoreLabel.text = String(score)
            
       
        } else {
        
            gameOver = true
        
            self.speed = 0
            
            timer.invalidate()
            
            gameOverLabel.fontName = "Helvetica"
            
            gameOverLabel.fontSize = 50
            
            gameOverLabel.text = "Game Over! Tap to retry"
            
            gameOverLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
            
            self.addChild(gameOverLabel)
            
            }
        
        }
    }

    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        setupGame()
    }
    
    
    func setupGame() {
        
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.makePipes), userInfo: nil, repeats: true)
        
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
            
            background.zPosition = -2
            
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
        
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().width / 2)
        
        bird.physicsBody?.isDynamic = false
        
        bird.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        bird.physicsBody!.contactTestBitMask = ColliderTypes.Object.rawValue
        
        bird.physicsBody!.categoryBitMask = ColliderTypes.Bird.rawValue
        
        bird.physicsBody!.collisionBitMask = ColliderTypes.Bird.rawValue
        
        self.addChild(bird)
        
        
        //Ground barrier
        
        let ground = SKNode()
        
        ground.position = CGPoint(x: self.frame.midX, y: -self.frame.height / 2)
        
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width, height: 1))
        
        ground.physicsBody!.isDynamic = false
        
        ground.physicsBody!.contactTestBitMask = ColliderTypes.Object.rawValue
        
        ground.physicsBody!.categoryBitMask = ColliderTypes.Object.rawValue
        
        ground.physicsBody!.collisionBitMask = ColliderTypes.Object.rawValue
        
        self.addChild(ground)
        
        
        //score label
        
        scoreLabel.fontName = "Helvetica"
        
        scoreLabel.fontSize = 60
        
        scoreLabel.color = UIColor.white
        
        scoreLabel.text = "0"
        
        scoreLabel.position = CGPoint(x: self.frame.midX, y: self.frame.height / 2 - 70)
        
        self.addChild(scoreLabel)
        

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
       
        //Makes bird jolt upwards when tapped
        
        if gameOver == false {
        
            bird.physicsBody?.isDynamic = true
       
            bird.physicsBody!.velocity = CGVector(dx: 0, dy: 0)

            bird.physicsBody!.applyImpulse(CGVector(dx: 0, dy: 170))
        
        } else {
            
            gameOver = false
            
            score = 0
            
            self.speed = 1
            
            self.removeAllChildren()
            
            setupGame()
            
            
            
        }
        
    }
    

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
     
        
        
    }
}
