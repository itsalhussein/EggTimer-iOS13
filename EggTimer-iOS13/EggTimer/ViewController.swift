//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var bigTitle: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var player : AVAudioPlayer?

    
    
    var eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    var countTimer:Timer!
    var totalTime = 0
    var secondsPassed = 0
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        //countTimer.invalidate()
        let hardness = sender.currentTitle!
        
        progressBar.progress = 0.0
        bigTitle.text = hardness
        secondsPassed = 0
        
        self.countTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        totalTime = eggTimes[hardness]!
        
    }
    
    @objc func fireTimer() {
        if secondsPassed <= totalTime {
            
            var percentageProgress = Float(secondsPassed) / Float(totalTime)
            secondsPassed += 1
            progressBar.progress = Float(percentageProgress)
            
        } else {
            
            countTimer.invalidate()
            //progressBar.progress = 1.0
            bigTitle.text = "Done!"
            
            playSound(soundName: "alarm_sound")
            
//             DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
//                sender.alpha = 1.0
//            }
        }
    }
    
    func playSound(soundName: String) {
        
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player?.play()
    }
    
}

