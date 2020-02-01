//
//  ViewController.swift
//  TimedEggs
//
//  Created by Bartek on 1/31/20.
//  Copyright © 2020 Bartek. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressLabel: UIProgressView!
    //Dictionary
    let eggTimer = ["Soft": 300, "Medium": 420, "Hard": 720]
    
    
    var secondsPassed = 0
    var totalTime = 0
    var timer = Timer()

    override func viewDidLoad() {
        
        super.viewDidLoad()

    }


    
    @IBAction func hadrnessSelected(_ sender: UIButton) {
       
        
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        
        totalTime = eggTimer[hardness]!
        //putting it below eggtimer because its after you select the progress type
        //wanna start both of these over after picking a new egg hah
        progressLabel.progress = 0.0
        secondsPassed = 0
        //will let you see what type of egg youre making
        titleLabel.text = hardness
        
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
        
        }
    var player: AVAudioPlayer?

    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
     @objc func updateCounter() {
        //example functionality
    
        if secondsPassed <= totalTime{
            let percentageProgress = Float(secondsPassed) / Float(totalTime)
            progressLabel.progress = percentageProgress
            secondsPassed += 1
        } else {
            //Once timer is complete Title will change
            timer.invalidate()
            playSound()
            titleLabel.text = "DONE!"
            
        }
    }
        
    }
   




