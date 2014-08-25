//
//  GameScene.swift
//  SpriteDemo
//
//  Created by Lanston Peng on 8/20/14.
//  Copyright (c) 2014 Vtm. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    let fieldMask : UInt32 = 0b1
    let categoryMask: UInt32 = 0b1
    let canvasWidth: UInt32 = 800
    let canvasHeight: UInt32 = 800
    
    let fieldNode: SKFieldNode
    let blackNode: SKShapeNode
    
    var midPt:CGPoint {
        println(frame)
        return CGPoint( x: CGRectGetMidX(frame), y: CGRectGetMidY(frame))
    }
    
    var fieldPos:CGPoint {
        var mid = midPt
            mid.x += (mid.x * 0.25)
            return mid
    }
    var emitterPos:CGPoint {
        var mid = midPt
            mid.x -= (mid.x * 0.40)
            return mid
    }
    required init(coder aDecoder: NSCoder) {
        
        fieldNode = SKFieldNode.magneticField()
        fieldNode.physicsBody = SKPhysicsBody(circleOfRadius: 80)
        fieldNode.categoryBitMask = categoryMask
        fieldNode.strength = 28
        fieldNode.enabled = true
        fieldNode.physicsBody.charge = 10000
        
        blackNode = SKShapeNode(circleOfRadius: 10)
        blackNode.fillColor = UIColor.blackColor()
        
        super.init(coder: aDecoder)
        fieldNode.position = emitterPos
        blackNode.position = emitterPos
    }
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        self.addChild(fieldNode)
        self.addChild(blackNode)
        
        //fucking important!
        //case you will get the fucking default -.98 gravity
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame);
        self.physicsBody.friction = 0.00
        
        self.backgroundColor = SKColor.whiteColor()
        let cross:CGMutablePathRef = CGPathCreateMutable();
        CGPathMoveToPoint(cross, nil, 0, CGRectGetMidY(self.frame))
        CGPathAddLineToPoint(cross, nil, CGRectGetMaxX(self.frame), CGRectGetMidY(self.frame))
        CGPathMoveToPoint(cross, nil, CGRectGetMidX(self.frame), 0)
        CGPathAddLineToPoint(cross, nil, CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame))
        
        let crossShape:SKShapeNode = SKShapeNode()
        crossShape.strokeColor = UIColor.blackColor()
        crossShape.path = cross
        addChild(crossShape)
        
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
            makeNode()
    }
    override func touchesMoved(touches: NSSet!, withEvent event: UIEvent!) {
        let touch:UITouch = touches.anyObject() as UITouch
        
        let location = touch.locationInNode(self)
        
        let newPoint:CGPoint  = CGPointMake(location.x + 50 , location.y + 50);
        blackNode.position = newPoint;
        fieldNode.position = newPoint;
    }
    
    func makeNode() -> SKNode
    {
        //var node = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width:20,height:20))
        var node = SKShapeNode(circleOfRadius: 10)
        node.fillColor = UIColor.orangeColor()
        node.position = emitterPos
        node.physicsBody = SKPhysicsBody(rectangleOfSize:CGSize(width:10,height:10))
        node.physicsBody.dynamic = true
        node.physicsBody.charge = 10000
        node.physicsBody.mass = 0.1
        node.physicsBody.allowsRotation = true
        node.physicsBody.affectedByGravity = false
        node.physicsBody.friction = 0
        node.physicsBody.linearDamping = 0
        addChild(node)
        return node
    }
    func makeFieldNode() -> SKFieldNode
    {
        
        let fieldNode = SKFieldNode.magneticField()
        fieldNode.physicsBody = SKPhysicsBody(circleOfRadius: 80)
        fieldNode.strength = 2.8
        fieldNode.enabled = true
        fieldNode.position = CGPointZero
        return fieldNode
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
