//
//  PageControlVC.swift
//  DemoMaterialDesign
//
//  Created by Yudiz Solutions Pvt. Ltd. on 01/08/18.
//  Copyright © 2018 Yudiz Solution Pvt Ltd. All rights reserved.
//

import UIKit
import MaterialComponents

/// Class for page control vc
class PageControlVC: UIViewController {
    
    @IBOutlet var scrollView: UIScrollView!
    let pageControl = MDCPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageControl()
    }
    
    /// This method set up Page control
    func setupPageControl() {
        self.title = "Page Control"
        pageControl.numberOfPages = 3
        let pageControlSize = pageControl.sizeThatFits(view.bounds.size)
        pageControl.frame = CGRect(x: 0, y: view.bounds.height - pageControlSize.height, width: view.bounds.width, height: pageControlSize.height)
        pageControl.addTarget(self, action: #selector(didChangePage), for: .valueChanged)
        pageControl.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        view.addSubview(pageControl)
    }
    
    /// Change page control
    ///
    /// - Parameter sender: MDCPageControl
    @objc func didChangePage(sender: MDCPageControl){
        var offset = scrollView.contentOffset
        offset.x = CGFloat(sender.currentPage) * scrollView.bounds.size.width;
        scrollView.setContentOffset(offset, animated: true)
    }
}

// MARK: - Extension for scroll view delegate
extension PageControlVC: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.scrollViewDidScroll(scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.scrollViewDidEndDecelerating(scrollView)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pageControl.scrollViewDidEndScrollingAnimation(scrollView)
    }
}
