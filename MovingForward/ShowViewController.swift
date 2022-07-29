//
//  ShowViewController.swift
//  MovingForward
//
//  Created by 林辰澤 on 2022/7/29.
//

import UIKit

class ShowViewController: UIViewController {

    @IBOutlet weak var lyricLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.systemOrange
        lyricLabel.text = lyrics[index]
        timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { _ in
            self.nextLyric()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            
            timer?.invalidate()
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
