//
//  GameViewController.swift
//  RollingGame
//
//  Created by nagata on 5/11/15.
//  Copyright (c) 2015 nagata. All rights reserved.
//

import UIKit
import CoreMotion

class GameViewController: UIViewController {
    
    var myMotionManager: CMMotionManager!
    var imageView: UIImageView!
    var speedX: Double = 0.0
    var speedY: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
       
        var image = UIImage(named: "mizubuu2")!
        imageView = UIImageView(frame: CGRect(x: self.view.center.x, y: self.view.center.y, width: 40, height: 35))
        imageView.image = image
        
        self.view.addSubview(imageView)
        
        // MotionManagerを生成.
        myMotionManager = CMMotionManager()
        
        // 更新周期を設定.
        myMotionManager.accelerometerUpdateInterval = 0.02
        
        // 加速度の取得を開始.
        myMotionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: {(accelerometerData:CMAccelerometerData!, error:NSError!) -> Void in
            self.speedX += accelerometerData.acceleration.x
            self.speedY += accelerometerData.acceleration.y
            
            var posX = self.imageView.center.x + CGFloat(self.speedX)
            var posY = self.imageView.center.y - CGFloat(self.speedY)
            if (posX < 0.0) {
                posX = 0.0;
                
                self.speedX *= -0.4;
            } else if (posX > self.view.bounds.size.width) {
                posX = self.view.bounds.size.width;
                
                self.speedX *= -0.4;
            }
            if (posY < 0.0) {
                posY = 0.0;
                
                self.speedY *= -0.4;
            } else if (posY > self.view.bounds.size.height) {
                posY = self.view.bounds.size.height;
                
                self.speedY *= -0.4;
            }
            self.imageView.center = CGPointMake(posX, posY);
        })
        

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
