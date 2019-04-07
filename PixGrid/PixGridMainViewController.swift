//
//  PixGridMainViewController.swift
//  PixGrid
//
//  Created by Pedro Lenzi on 06/04/19.
//  Copyright © 2019 Ogygia. All rights reserved.
//

import UIKit

class PixGridMainViewController: UIViewController {
    @IBOutlet weak var toolBarWidth: NSLayoutConstraint!
    
    @IBOutlet weak var gridCollectionView: UICollectionView!
    @IBOutlet weak var gridCollectionViewLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var gridWidth: NSLayoutConstraint!
    @IBOutlet weak var gridHeight: NSLayoutConstraint!
    @IBOutlet weak var gridTrailing: NSLayoutConstraint!
    @IBOutlet weak var gridLeading: NSLayoutConstraint!
    @IBOutlet weak var gridTop: NSLayoutConstraint!
    @IBOutlet weak var gridBottom: NSLayoutConstraint!
    
    var gridPixelHorizontalCount: UInt!
    var gridPixelVerticalCount: UInt!
    var pixelWidth: UInt!
    
    var pixelColor = [IndexPath: UIColor]()
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeLeft
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gridPixelHorizontalCount = 10
        gridPixelVerticalCount = 6
        pixelWidth = 30
        
        initCollectionView()
    }

    private func initCollectionView() {
        gridCollectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        gridCollectionViewLayout.minimumLineSpacing = 0
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        longPressGestureRecognizer.minimumPressDuration = 0.01
        gridCollectionView.addGestureRecognizer(longPressGestureRecognizer)
        
        gridCollectionView.register(UINib(nibName: "UICollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CommonCell")
        gridCollectionView.delegate = self
        gridCollectionView.dataSource = self
    }
    
    @objc func longPress(gestureRecognizer: UILongPressGestureRecognizer) {
        switch gestureRecognizer.state {
        case .possible:
            return
        case .began:
//            voiceNoteLongPressStartingPoint = gestureRecognizer.location(in: view)
            break
        case .changed:
//            let point = gestureRecognizer.location(in: view)
            break
        case .failed:
            fallthrough
        case .cancelled:
            fallthrough
        case .ended:
            break
        }
    }
}

extension PixGridMainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(gridPixelVerticalCount * gridPixelHorizontalCount)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommonCell", for: indexPath)
        cell.contentView.backgroundColor = pixelColor[indexPath] ?? UIColor.white
        return cell
    }
}

