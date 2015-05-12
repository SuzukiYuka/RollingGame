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
    
    var motionManager: CMMotionManager!
    var imageView: UIImageView!
    var speedX: Double = 0.0
    var speedY: Double = 0.0
    
    @IBOutlet var fieldView: UIView!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var stopBt: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
       
        var image = UIImage(named: "mizubuu2")!
        imageView = UIImageView(frame: CGRect(x: self.fieldView.center.x, y: self.fieldView.center.y, width: 40, height: 35))
        imageView.image = image
        
        self.view.addSubview(imageView)
        
        // MotionManagerを生成.
        motionManager = CMMotionManager()
        
        // 更新周期を設定.
        motionManager.accelerometerUpdateInterval = 0.02
        
        self.startMotionManager()
        
    }
    
    func startMotionManager() {
        // 加速度の取得を開始.
        motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: {(accelerometerData:CMAccelerometerData!, error:NSError!) -> Void in
            self.speedX += accelerometerData.acceleration.x
            self.speedY += accelerometerData.acceleration.y
            
            var posX = self.imageView.center.x + CGFloat(self.speedX)
            var posY = self.imageView.center.y - CGFloat(self.speedY)
            
            self.imageView.center = CGPointMake(posX, posY);
            self.checkGameOver()
        })
    }
    
    func checkGameOver() {
        if !CGRectContainsPoint(fieldView.frame, imageView.center) {
            statusLabel.text = "GameOver"
            if (motionManager.accelerometerActive) {
                motionManager.stopAccelerometerUpdates()
            }
            self.stopBt.enabled = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func stop() {
        if (motionManager.accelerometerActive) {
            statusLabel.text = "Stop"
            motionManager.stopAccelerometerUpdates()
            stopBt.setTitle("Start", forState: .Normal)
        } else {
            statusLabel.text = ""
            self.startMotionManager()
            stopBt.setTitle("Stop", forState: .Normal)
        }
    }
    
    @IBAction func retry() {
        //GameOverを消す
        statusLabel.text = ""
        imageView.frame.origin = self.fieldView.center
        self.speedX = 0.0
        self.speedY = 0.0
        //加速度センサが停止してたらstartさせる
        if !motionManager.accelerometerActive {
            self.startMotionManager()
        }
        self.stopBt.enabled = true
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
