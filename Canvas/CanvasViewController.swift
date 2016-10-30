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
    
    var newlyCreatedFace: UIImageView!
    
    var newlyCreatedFaceOriginalCenter: CGPoint!
    
    
    
    
    
    
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
    
    
    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
        
        // Get the Translation from the Pan Gesture Recognizer
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            
            // imageView now refers to the face that you panned on
            var imageView = sender.view as! UIImageView
            
            // Create a new image view that has the same image as the one you're currently panning
            newlyCreatedFace = UIImageView(image: imageView.image)
            
            // Add the new face to the main view
            view.addSubview(newlyCreatedFace)
            
            // Initialize the position of the new face
            newlyCreatedFace.center = imageView.center
            
            // Since the original face is in the tray, but the new face is in the main view, you have to offset the coordinates
            newlyCreatedFace.center.y += trayView.frame.origin.y
            
            // create another variable at the top of the file to capture the initial center of the new face
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            
        } else if sender.state == .changed {
            
            // pan the position of the newlyCreatedFace
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
            
        } else if sender.state == .ended {
         
        }

    }

}
