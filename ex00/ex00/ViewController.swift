//
//  ViewController.swift
//  ex00
//
//  Created by Shira Broderick on 6/20/21.
//  Copyright © 2021 Shira Broderick. All rights reserved.
//

import UIKit

let CannotAccesToImageNotification = "CannotAccesToImageNotification"

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
	
	var collectionView: UICollectionView!
	let id = "Cell"
	var imageErrorText = ""
		
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.navigationItem.title = "Images"

		let flowLayout = UICollectionViewFlowLayout()
		
		
		NotificationCenter.default.addObserver(self, selector: #selector(failLoadImage), name: NSNotification.Name(rawValue: CannotAccesToImageNotification), object: nil)
		
		
		let frame = self.view.bounds
		collectionView = UICollectionView(frame: frame, collectionViewLayout: flowLayout)
		collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: id)
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.backgroundColor = .systemGray4
		collectionView.autoresizingMask = .flexibleWidth
		
		self.view.addSubview(collectionView)
		
    }
	
	override func viewDidDisappear(_ animated: Bool) {
		NotificationCenter.default.removeObserver(self)
		
//		NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: CannotAccesToImageNotification), object: nil)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		if !imageErrorText.isEmpty {
			let alert = UIAlertController(title: "Error", message: "Cannot acces to \(imageErrorText)", preferredStyle: .alert)
			
			let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
			alert.addAction(alertAction)
			self.present(alert, animated: true) {
				
			}
		}
	}
	
	@objc func failLoadImage(nc: Notification) {
		imageErrorText = nc.userInfo!["URL"] as! String
	}
    
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		4
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

		let imageView = collectionView.cellForItem(at: indexPath)!.backgroundView!
		let scrollViewController = ScrollViewController(image: imageView.largeContentImage!)
		self.navigationController?.pushViewController(scrollViewController, animated: false)
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath)
		
//		for view in cell.subviews {
//			if view.isKind(of: UIImageView.self) {
//				view.removeFromSuperview()
//			}
//		}
		
		let imageView = UIImageView(frame: cell.bounds)
		
		imageView.imageFromServerURL(urlString: Images.images[indexPath.row])
		
		imageView.contentMode = UIImageView.ContentMode.scaleAspectFit

		cell.backgroundView = imageView
		cell.backgroundColor = .black
		return cell
		
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let size = (self.view.bounds.width < self.view.bounds.height) ? self.view.bounds.width / 2 - 10 : self.view.bounds.height / 2 - 10
		return CGSize(width: size, height: size)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
	}
	
}

extension UIImageView {
	
	public func imageFromServerURL(urlString: String) {
		
		let activitiIndicator = UIActivityIndicatorView(style: .medium)
		activitiIndicator.startAnimating()
		activitiIndicator.color = .cyan
		activitiIndicator.center = self.center
		
		self.addSubview(activitiIndicator)
		
		activitiIndicator.startAnimating()
		
		URLSession.shared.dataTask(with: URL(string: urlString)!) { (data, response, error) in
			if error != nil {
				//				print(error ?? "Error")
				NotificationCenter.default.post(name: NSNotification.Name(rawValue: CannotAccesToImageNotification), object: nil, userInfo: ["URL":urlString])
				return
			}
			
			DispatchQueue.main.async {
				let image = UIImage(data: data!)
				self.image = image
				activitiIndicator.stopAnimating()
				activitiIndicator.removeFromSuperview()
			}
		}.resume()
	}
}
