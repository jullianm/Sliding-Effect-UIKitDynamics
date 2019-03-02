//
//  ViewController.swift
//  PanGesture
//
//  Created by jullianm on 2019-02-10.
//  Copyright © 2019 jullianm. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var settingsView: SettingsView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingsView = Bundle.main.loadNibNamed("SettingsView", owner: self)?.first as? SettingsView
        settingsView.frame = CGRect(x: 0, y: -view.frame.size.height + 66, width: view.frame.width, height: view.frame.height)
        
        view.addSubview(settingsView)
        
        settingsView.setup()
        
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

