//
//  QYSegementView.swift
//  QYSegementView
//
//  Created by Joggy on 16/2/11.
//  Copyright © 2016年 NUPT. All rights reserved.
//

import UIKit

class QYSegementView: UIView {
    
    private let kWidth = UIScreen.mainScreen().bounds.width
    private let kHeight = UIScreen.mainScreen().bounds.height
    private let QYInsert1: CGFloat = 18
    private let QYInsert2: CGFloat = 22
    
    private var navigationBar: UINavigationBar!
    private var view: UIView!
    private var delegate: QYSegementViewDelegate!
    
    private var titleScroll: UIScrollView!
    private var titleIndicator: UIView!
    private var contentScroll: UIScrollView!
    private var numOfViewControllers: Int!
    private var titleButtons = [UIButton]()
    
    var titleNormalColor: UIColor?
    var titleSelectedColor: UIColor?
    
    init(navigationBar: UINavigationBar, view: UIView, delegate: QYSegementViewDelegate) {
        super.init(frame: CGRectMake(0, 0, kWidth, 44))
        self.frame = super.frame
        self.navigationBar = navigationBar
        self.navigationBar.addSubview(self)
        self.view = view
        self.delegate = delegate
        numOfViewControllers = delegate.numberOfSegement(self);
    }
    
    func viewAdded() {
        prepareTitles()
        if titleNormalColor != nil {
            for but in titleButtons {
                but.setTitleColor(titleNormalColor, forState: UIControlState.Normal)
            }
        }
        prepareViewControllers()
        setSelectedBut(0)
    }
    
    private func prepareTitles() {
        titleScroll = UIScrollView(frame: CGRectMake(QYInsert1, 0, kWidth - QYInsert1*2, 44))
        titleScroll.showsHorizontalScrollIndicator = false
        for i in 0...numOfViewControllers - 1 {
            let but = UIButton(type: UIButtonType.System);
            but.setTitle(delegate.QYSegementViewControllers(self, index: i).title, forState: UIControlState.Normal)
            but.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            but.tag = i
            but.addTarget(self, action: "selectedBut:", forControlEvents: UIControlEvents.TouchUpInside)
            but.sizeToFit()
            if i == 0 {
                but.frame.origin = CGPointMake(0, QYInsert2/2)
            }
            else {
                but.frame.origin = CGPointMake(titleButtons[i - 1].frame.origin.x + titleButtons[i - 1].frame.width + QYInsert2, QYInsert2/2)
            }
            titleButtons.append(but)
            titleScroll.addSubview(but)
        }
        titleScroll.contentSize = CGSizeMake(titleButtons.last!.frame.origin.x + titleButtons.last!.frame.width, titleScroll.frame.height)
        self.addSubview(titleScroll)
        self.navigationBar.addSubview(self)
        titleIndicator = UIView(frame: CGRectMake(0, titleScroll.frame.height - 2, titleButtons.first!.frame.width, 6))
        titleIndicator.layer.cornerRadius = 3
        titleIndicator.backgroundColor = UIColor.blueColor()
        titleScroll.addSubview(titleIndicator)
    }
    
    private func prepareViewControllers() {
        contentScroll = UIScrollView(frame: CGRectMake(0, 64, kWidth, kHeight - 64))
        contentScroll.contentSize = CGSizeMake(kWidth*CGFloat(numOfViewControllers), contentScroll.frame.height)
        contentScroll.pagingEnabled = true
        contentScroll.showsHorizontalScrollIndicator = false
        contentScroll.delegate = self
        for i in 0...numOfViewControllers - 1 {
            let v = delegate.QYSegementViewControllers(self, index: i).view
            v.frame = CGRectMake(CGFloat(i)*kWidth, 0, kWidth, contentScroll.frame.height)
            contentScroll.addSubview(v)
        }
        self.view.addSubview(contentScroll)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: --事件方法
    
    func selectedBut(button: UIButton) {
        setSelectedBut(button.tag)
    }
    
    private func setSelectedBut(index: Int) {
        if titleNormalColor != nil {
            for but in titleButtons {
                but.setTitleColor(titleNormalColor, forState: UIControlState.Normal)
            }
        }
        else {
            for but in titleButtons {
                but.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            }
        }
        if titleSelectedColor != nil {
            titleButtons[index].setTitleColor(titleSelectedColor, forState: UIControlState.Normal)
            titleIndicator.backgroundColor = titleSelectedColor
        }
        else {
            titleButtons[index].setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        }
        UIView.animateWithDuration(0.3) { () -> Void in
            self.titleIndicator.frame.origin.x = self.titleButtons[index].frame.origin.x
            self.titleIndicator.frame.size.width = self.titleButtons[index].frame.width
        }
        adjustTitleScroll(index)
        presentView(index)
    }
    
    private func adjustTitleScroll(index: Int) {
        titleScroll.scrollRectToVisible(CGRectMake(titleButtons[index].layer.position.x - titleScroll.frame.width/2, 0, titleScroll.frame.width, titleScroll.frame.height), animated: true)
    }
    
    private func presentView(index: Int) {
        contentScroll.scrollRectToVisible(CGRectMake(CGFloat(index)*kWidth, 0, kWidth, contentScroll.frame.width), animated: true)
    }

}

extension QYSegementView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        setSelectedBut(Int(scrollView.contentOffset.x/kWidth))
    }
}

//MARK: --代理

protocol QYSegementViewDelegate {
    func numberOfSegement(segement: QYSegementView) -> Int;
    func QYSegementViewControllers(segement: QYSegementView, index: Int) -> UIViewController;
}







