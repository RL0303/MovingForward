//
//  ShowViewController.swift
//  MovingForward
//
//  Created by 林辰澤 on 2022/7/29.
//

import UIKit
import SpriteKit
import AVFoundation



class ShowViewController: UIViewController {
    
    var looper: AVPlayerLooper?

    @IBOutlet weak var lyricLabel: UILabel!
    
    @IBOutlet weak var bear1ImageView: UIImageView!
    
    @IBOutlet weak var bear2ImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //        view.backgroundColor = UIColor.systemOrange
        setupGradientBackground()
        
        // music Moving Forward 2019
        if let url = URL(string: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/d7/a1/6d/d7a16d00-c910-ee8d-4201-761a3626be8a/mzaf_9150141223009538380.plus.aac.p.m4a") {
            let player = AVQueuePlayer()
            let item = AVPlayerItem(url: url)
            looper = AVPlayerLooper(player: player, templateItem: item)
            player.play()
        }
        
        
        //        lyrics
        lyricLabel.text = lyrics[index]
        timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { _ in
            self.nextLyric()
        }
        
        // bearGIF
        guard let data = NSDataAsset(name: "animated-bear-image-260")?.data else { return }
        let cfData = data as CFData
        CGAnimateImageDataWithBlock(cfData, nil) { (_, cgImage, _) in

            self.bear1ImageView.image = UIImage(cgImage: cgImage)
            self.bear2ImageView.image = UIImage(cgImage: cgImage)
        }
        
        // particle
        let skView = SKView(frame: view.frame)
        view.insertSubview(skView, at: 0)
        skView.backgroundColor = UIColor.clear
        
        let scene = SKScene(size: skView.frame.size)
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        scene.backgroundColor = UIColor.clear
        
        let emitterNode = SKEmitterNode(fileNamed: "MyParticle")
        scene.addChild(emitterNode!)
        skView.presentScene(scene)
        view.addSubview(skView)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        timer?.invalidate()
    }
    
    func setupGradientBackground() {
         let gradientLayer = CAGradientLayer()
         gradientLayer.frame = view.bounds
         gradientLayer.colors = [
            CGColor(srgbRed: 1, green: 1, blue: 1, alpha: 1),
            CGColor(srgbRed: 255/255, green: 153/255, blue: 51/255, alpha: 1)
         ]
         view.layer.insertSublayer(gradientLayer, at: 0)
    }

    
    func nextLyric() {
            index = (index + 1) % lyrics.count
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = .push
            transition.subtype = .fromTop
            lyricLabel.text = lyrics[index]
            lyricLabel.layer.add(transition, forKey: "nextLyric")
    }
    
    var index = 0
    let lyrics = [
        "求的不是頭銜",
        "終究都會被遺忘",
        "只求不留下遺憾",
        "Oh 再會吧",
        "Oh 什麼都不怕",
        "Oh 再會吧",
        "Oh 向前走",
        "回到此時此刻",
        "忘了全世界",
        "內心沒有自負",
        "也沒有自卑",
        "我已心如止水"
    ]
    var timer: Timer?

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
