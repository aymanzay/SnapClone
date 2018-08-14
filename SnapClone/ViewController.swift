//
//  ViewController.swift
//  SnapClone
//
//  Created by Ayman Zeine on 8/14/18.
//  Copyright © 2018 Ayman Zeine. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var view1: ViewOneVC = ViewOneVC(nibName: "ViewOneVC", bundle: nil)
        var view2: ViewTwoVC = ViewTwoVC(nibName: "ViewTwoVC", bundle: nil)
        var view3: ViewThreeVC = ViewThreeVC(nibName: "ViewThreeVC", bundle: nil)
        
        self.addChildViewController(view1)
        self.scrollView.addSubview(view1.view)
        view1.didMove(toParentViewController: self)
        
        self.addChildViewController(view2)
        self.scrollView.addSubview(view2.view)
        view2.didMove(toParentViewController: self)
        
        self.addChildViewController(view3)
        self.scrollView.addSubview(view3.view)
        view3.didMove(toParentViewController: self)
        
        var view2Frame: CGRect = view1.view.frame
        view2Frame.origin.x = self.view.frame.width
        view2.view.frame = view2Frame
        
        var view3Frame: CGRect = view3.view.frame
        view3Frame.origin.x = (self.view.frame.width) * 2
        view3.view.frame = view3Frame
        
        self.scrollView.contentSize = CGSize(width:self.view.frame.width * 3, height:self.view.frame.height)
    }


}

