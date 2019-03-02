//
//  SlidingBehavior.swift
//  PanGesture
//
//  Created by jullianm on 2019-02-16.
//  Copyright © 2019 jullianm. All rights reserved.
//

import UIKit



class SlidingBehavior: UIDynamicBehavior {
    
    private var targetView: SettingsView
    private var collisionBehavior: UICollisionBehavior!
    var dynamicItemBehavior: UIDynamicItemBehavior!
    var gravityBehavior: UIGravityBehavior!
    var gravityDirection: GravityDirection!
    
    enum GravityDirection {
        case up
        case down
    }
    
    init(targetView: SettingsView) {
        self.targetView = targetView
        super.init()
        install()
    }
    
    private func install() {
        dynamicItemBehavior = UIDynamicItemBehavior(items:  [targetView])
        dynamicItemBehavior.allowsRotation = false
        
        gravityBehavior = UIGravityBehavior(items: [targetView])
        
        // setup collision behavior
        collisionBehavior = UICollisionBehavior(items: [targetView])
        
        setCollisionBoundaries()
        
        addChildBehavior(gravityBehavior)
        addChildBehavior(dynamicItemBehavior)
        addChildBehavior(collisionBehavior)
        
    }
    
    private func setCollisionBoundaries() {
        
        let boundaryWidth = UIScreen.main.bounds.size.width
        
        collisionBehavior.addBoundary(
            withIdentifier: "upper" as NSCopying,
            from: CGPoint(x: 0, y: -targetView.frame.size.height + 66),
            to: CGPoint(x: boundaryWidth, y: -targetView.frame.size.height + 66)
        )
        
        let boundaryHeight = UIScreen.main.bounds.size.height
        
        collisionBehavior.addBoundary(
            withIdentifier: "lower" as NSCopying,
            from: CGPoint(x: 0, y: boundaryHeight),
            to: CGPoint(x: boundaryWidth, y: boundaryHeight)
        )
        
    }
    
    func setGravity(direction: GravityDirection) {
        
        gravityDirection = direction
        
        gravityBehavior.gravityDirection  = CGVector(dx: 0, dy: direction == .up ? -2.5: 2.5)
        
    }

}
