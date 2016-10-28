//
//  CanvasViewController.swift
//  Canvas
//
//  Created by Sophia KC on 27/10/2016.
//  Copyright © 2016 Sophia KC. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var trayView: UIView!
    
    
    var trayOriginalCenter: CGPoint!
    
    
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // The didPan: method will be defined in Step 3 below.
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(sender:)))
        
        // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
        trayView.isUserInteractionEnabled = true
        trayView.addGestureRecognizer(panGestureRecognizer)
        
        trayDownOffset = 160
        trayUp = trayView.center
        trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset)

        
    }
    
    
    
    @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
//        let translation = sender.translation(in: view)
    }
    
    
    func didPan(sender: UIPanGestureRecognizer) {
        let location = sender.location(in: view)
        let velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
        

        
        
        if sender.state == .began {
            print("Gesture began")
            trayOriginalCenter = trayView.center
            
        } else if sender.state == .changed {
            print("Gesture is changing")
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
            
        } else if sender.state == .ended {
            print("Gesture ended")
            if velocity.y > 0 {
                UIView.animate(withDuration:0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                    self.trayView.center = self.trayDown
                }, completion: nil)
            } else {
                UIView.animate(withDuration:0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                    self.trayView.center = self.trayUp
                }, completion: nil)
            }
            
        }
    }

    
}
