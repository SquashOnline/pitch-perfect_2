//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Benjamin Uliana on 2015-04-08.
//  Copyright (c) 2015 SquashOnline. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
        //GLOBAL VARIABLES
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathURL, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathURL, error: nil)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        //OPERATION: BUTTONS
    @IBAction func slowRecording(sender: UIButton) {
        //OPERATION: PLAY SLOW AUDIO HERE
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.rate = 0.5
        playAudio()
                }

    @IBAction func fastRecording(sender: UIButton) {
        //OPERATION: PLAY FAST AUDIO HERE
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.rate = 1.5
        playAudio()
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        //OPERATION: USE OF FUNC TO ADJUST PITCH FOR CHIPMUNK
        playAudioWithVariablePitch(1000)
    }
    
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        //OPERATION: USE OF FUNC TO ADJUCT PITCH FOR DARTHVADER
        playAudioWithVariablePitch(-750)
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        audioPlayer.stop()
    }

        //FUNCTIONS:
    func playAudio (){
        audioPlayer.stop()
        audioPlayer.currentTime = 0.0
        audioPlayer.play() }
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil);
        
        audioPlayerNode.play()
    }
}
