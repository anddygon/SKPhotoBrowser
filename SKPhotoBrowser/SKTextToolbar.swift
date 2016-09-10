//
//  SKToolbar.swift
//  SKPhotoBrowser
//
//  Created by 鈴木 啓司 on 2016/08/12.
//  Copyright © 2016年 suzuki_keishi. All rights reserved.
//

import Foundation

// helpers which often used
private let bundle = NSBundle(forClass: SKPhotoBrowser.self)

class SKTextToolbar: SKBaseToolbar {
    var toolPageControl: UIPageControl!
    var toolCounterButton: UIBarButtonItem!
    
    private weak var browser: SKPhotoBrowser?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, browser: SKPhotoBrowser) {
        self.init(frame: frame)
        self.browser = browser
        
        setupApperance()
        setupCounterLabel()
        setupToolbar()
    }
    
    override func updateToolbar(currentPageIndex: Int) {
        guard let _ = browser else { return }
        toolPageControl.currentPage = currentPageIndex
        
//        
//        if browser.numberOfPhotos > 1 {
//            toolCounterLabel.text = "\(currentPageIndex + 1) / \(browser.numberOfPhotos)"
//        } else {
//            toolCounterLabel.text = nil
//        }
//        
//        toolPreviousButton.eled = (currentPageIndex < browser.numberOfPhotos - 1)
    }
}

private extension SKTextToolbar {
    func setupApperance() {
        backgroundColor = .clearColor()
        clipsToBounds = true
        translucent = true
        setBackgroundImage(UIImage(), forToolbarPosition: .Any, barMetrics: .Default)
        
        // toolbar
        if !SKPhotoBrowserOptions.displayToolbar {
            hidden = true
        }
    }
    
    func setupToolbar() {
        guard let _ = browser else { return }
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil)
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        
        if SKPhotoBrowserOptions.displayCounterLabel {
            items.append(flexSpace)
            items.append(toolCounterButton)
            items.append(flexSpace)
        } else {
            items.append(flexSpace)
        }
        items.append(flexSpace)
        
        setItems(items, animated: false)
    }
    
    
    func setupCounterLabel() {
        guard let browser = browser else { return }
        toolPageControl = UIPageControl(frame: CGRect(x: 0, y: 0, width: 95, height: 40))
        toolPageControl.numberOfPages = browser.numberOfPhotos
        toolCounterButton = UIBarButtonItem(customView: toolPageControl)
    }
    
}
