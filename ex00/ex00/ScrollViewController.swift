//
//  ScrollViewController.swift
//  ex00
//
//  Created by Shira Broderick on 6/28/21.
//  Copyright © 2021 Shira Broderick. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController, UIScrollViewDelegate {
	
	
	
	var scrollView: UIScrollView!
	var image: UIImage!
	var imageView: UIImageView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.view.backgroundColor = .systemGray3
		
		scrollView = UIScrollView(frame: self.view.frame)
		scrollView.delegate = self
	
		scrollView.contentSize = image.size
		scrollView.minimumZoomScale = 1.0
		scrollView.maximumZoomScale = 10.0
		imageView = UIImageView(image: image)
		imageView.isUserInteractionEnabled = true
		imageView.backgroundColor = .yellow
		scrollView.addSubview(imageView)
		
		self.view.addSubview(scrollView)
    }
	
	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return self.imageView
	}
	
	func sendImage(img: UIImage) {
		self.image = img
	}
	
	init(image: UIImage) {
		self.image = image
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	

}

