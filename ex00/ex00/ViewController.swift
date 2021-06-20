//
//  ViewController.swift
//  ex00
//
//  Created by Shira Broderick on 6/20/21.
//  Copyright © 2021 Shira Broderick. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
	
	var collectionView: UICollectionView!
	let id = "Cell"

    override func viewDidLoad() {
        super.viewDidLoad()

		let flowLayout = UICollectionViewFlowLayout()
		collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
		collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: id)
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.backgroundColor = .systemGray4
		
		self.view.addSubview(collectionView)
		

    }
    
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		4
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath)
		
		
		let url = URL(string: Images.images[indexPath.row])
	
		if let data = NSData(contentsOf: url!) {
			let image = UIImage(data: data as Data)
			let imageView = UIImageView(image: image)
			imageView.contentMode = UIImageView.ContentMode.scaleAspectFit
		
			cell.backgroundView = imageView
		} else {
			print("ERR")
		}
		
		cell.backgroundColor = .black
		return cell
		
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let size = self.view.bounds.width / 2 - 10
		return CGSize(width: size, height: size)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		
		
		return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
	}
	
}
