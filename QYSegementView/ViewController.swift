//
//  ViewController.swift
//  QYSegementView
//
//  Created by Joggy on 16/2/11.
//  Copyright © 2016年 NUPT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.automaticallyAdjustsScrollViewInsets = false
        setViewControllers()
        let segement = QYSegementView(navigationBar: self.navigationController!.navigationBar, view: self.view, delegate: self)
        segement.titleNormalColor = UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1)
        segement.titleSelectedColor = UIColor(red: 74/255, green: 181/255, blue: 226/255, alpha: 1)
        segement.viewAdded()
    }
    
    func setViewControllers() {
        let v1 = O1ViewController()
        v1.title = "教育"
        self.addChildViewController(v1)
        
        let v2 = O2ViewController()
        v2.title = "科学"
        self.addChildViewController(v2)
        
        let v3 = O3ViewController()
        v3.title = "游戏"
        self.addChildViewController(v3)
        
        let v4 = O4ViewController()
        v4.title = "视频"
        self.addChildViewController(v4)
        
        let v5 = O5ViewController()
        v5.title = "新闻"
        self.addChildViewController(v5)
        
        let v6 = O6ViewController()
        v6.title = "娱乐"
        self.addChildViewController(v6)
        
        let v7 = O7ViewController()
        v7.title = "音乐"
        self.addChildViewController(v7)
        
        let v8 = O8ViewController()
        v8.title = "电影"
        self.addChildViewController(v8)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: QYSegementViewDelegate {
    func numberOfSegement(segement: QYSegementView) -> Int {
        return self.childViewControllers.count;
    }
    
    func QYSegementViewControllers(segement: QYSegementView, index: Int) -> UIViewController {
        return self.childViewControllers[index]
    }
}

