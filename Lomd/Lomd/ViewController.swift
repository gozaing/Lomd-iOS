//
//  ViewController.swift
//  Lomd
//
//  Created by tobaru on 2016/01/09.
//  Copyright © 2016年 tobaru. All rights reserved.
//
import UIKit

class ViewController: UIViewController {
    
    var info: String?
    @IBOutlet weak var infoLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.infoLabel?.text = self.info
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}



