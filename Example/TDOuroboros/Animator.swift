//
//  Animator.swift
//  TDOuroboros_Example
//
//  Created by Michael Open Source on 9/3/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import Foundation
import TDOuroboros

class Animator {
    static func performJumpAnimation(forView view: UIView,
                                     withDistance distance: CGFloat,
                                     withDuration duration: Double,
                                     withDamping damping: CGFloat,
                                     withInitVelocity initVelocity: CGFloat,
                                     withScale scale: CGFloat,
                                     complete: (() -> Void)?) {
        
        // Task queue instance
        let taskQueue = TDTaskQueueManager()
        
        // Scale up
        taskQueue.enqueue {
            UIView.animate(withDuration: duration,
                           delay: 0.0,
                           usingSpringWithDamping: damping,
                           initialSpringVelocity: initVelocity,
                           options: .curveLinear,
                           animations: {
                            view.transform = CGAffineTransform(scaleX: scale, y: scale)
            }, completion: { (result) in
                taskQueue.taskCompleted()
            })
        }
        
        // Scele down
        taskQueue.enqueue {
            UIView.animate(withDuration: duration,
                           delay: 0.0,
                           usingSpringWithDamping: damping,
                           initialSpringVelocity: initVelocity,
                           options: .curveLinear,
                           animations: {
                            view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: { (result) in
                taskQueue.taskCompleted()
                complete?()
            })
        } // Scale down
    } // performJumpAnimation
} // Animator
