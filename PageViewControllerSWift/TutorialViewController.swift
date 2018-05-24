//
//  ViewController.swift
//  PageViewControllerSWift
//
//  Created by cuongnv on 5/24/18.
//  Copyright © 2018 cuongnv. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tutorialPageViewController = segue.destination as? TutorialPageViewController {
            tutorialPageViewController.tutorialDelegate = self
        }
    }
}

extension TutorialViewController: TutorialPageViewControllerDelegate {
    
    func tutorialPageViewController(viewController: TutorialPageViewController, didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func tutorialPageViewController(viewController: TutorialPageViewController, didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }
    
    
}
