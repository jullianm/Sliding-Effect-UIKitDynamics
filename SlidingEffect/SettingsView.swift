//
//  SettingsView.swift
//  PanGesture
//
//  Created by jullianm on 2019-02-13.
//  Copyright © 2019 jullianm. All rights reserved.
//

import UIKit

class SettingsView: UIView {
    
    private var offset: CGPoint = .zero
    private var animator: UIDynamicAnimator!
    private var slidingBehavior: SlidingBehavior!
    private var snap: UISnapBehavior!
    private var panGestureReconizer: UIPanGestureRecognizer!
        
    func setup () {
        
        // setup pan gesture
        panGestureReconizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(pan:)))
        panGestureReconizer.cancelsTouchesInView = false
        addGestureRecognizer(panGestureReconizer)
        
        // setup dynamic animator
        animator = UIDynamicAnimator(referenceView: superview!)
        
        // setup snap behavior
        snap = UISnapBehavior(
            item: self,
            snapTo: CGPoint(x: superview!.frame.size.width / 2, y: -superview!.frame.size.height + 66)
        )
        
        animator.addBehavior(snap)
        
        // setup custom sliding behavior (children behaviors: gravity + collision + dynamicItem)
        slidingBehavior = SlidingBehavior(targetView: self)
        
        animator.addBehavior(slidingBehavior)
        
    }
    
    @objc private func handlePan(pan : UIPanGestureRecognizer) {
        var location = pan.location(in: superview!)
        
        switch pan.state {
            
        case .began:
            
            let center = self.center
            offset.y = location.y - center.y
            
        case .ended:
            
            panGestureEnded()
            
        default:
            
            removeSnap()
            
            // Bound the item position inside the reference view.
            location.x = superview!.frame.width / 2
            // Apply the initial offset.
            location.y -= offset.y
            
            // Apply the resulting item center.
            addSnap(at: location)
    
        }
        
    }
    
    private func panGestureEnded() {
        removeSnap()
        
        let velocity = slidingBehavior.dynamicItemBehavior.linearVelocity(for: self)
        
        if abs(Float(velocity.y)) > 1500 {
            
            if velocity.y < 0 {
                slidingBehavior.setGravity(direction: .up)
            } else {
                slidingBehavior.setGravity(direction: .down)
            }
            
        } else {
            
            let superviewHeight = superview!.bounds.size.height
            
            if (frame.origin.y + bounds.height) > superviewHeight / 2 {
                slidingBehavior.setGravity(direction: .down)
            } else {
                slidingBehavior.setGravity(direction: .up)
            }
            
        }
    }
    
    
    func removeSnap() {
        animator.removeBehavior(snap)
    }
    
    func addSnap(at location: CGPoint) {
        snap = UISnapBehavior(item: self, snapTo: location)
        animator.addBehavior(snap)
    }
    
    @IBAction func onShowDetailsPressed(_ sender: UIButton) {
        
        removeSnap()
        
        let newDirection: SlidingBehavior.GravityDirection
        
        if let currentDirection = slidingBehavior.gravityDirection {
            newDirection = currentDirection == .up ? .down: .up
        } else {
            newDirection = .down
        }
        
        slidingBehavior.setGravity(direction: newDirection)
        
    }

}

