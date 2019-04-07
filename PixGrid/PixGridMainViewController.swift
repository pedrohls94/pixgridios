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
    
    @IBOutlet weak var gridScrollView: UIScrollView!
    @IBOutlet weak var gridCollectionView: UICollectionView!
    @IBOutlet weak var gridCollectionViewLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var gridWidth: NSLayoutConstraint!
    @IBOutlet weak var gridHeight: NSLayoutConstraint!
    @IBOutlet weak var gridTrailing: NSLayoutConstraint!
    @IBOutlet weak var gridLeading: NSLayoutConstraint!
    @IBOutlet weak var gridTop: NSLayoutConstraint!
    @IBOutlet weak var gridBottom: NSLayoutConstraint!
    
    var gridPixelHorizontalCount: CGFloat!
    var gridPixelVerticalCount: CGFloat!
    var pixelWidth: CGFloat!
    var pixelSpacing: CGFloat!
    
    var pixelColor = [IndexPath: UIColor]()
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeRight
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gridPixelHorizontalCount = 10
        gridPixelVerticalCount = 6
        pixelWidth = 30
        pixelSpacing = 0.5
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initCollectionView()
        updateCollectionViewSize()
    }

    private func initCollectionView() {
        gridCollectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        gridCollectionViewLayout.itemSize = CGSize(width: pixelWidth, height: pixelWidth)
        gridCollectionViewLayout.minimumInteritemSpacing = 0
        gridCollectionViewLayout.minimumLineSpacing = pixelSpacing
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        longPressGestureRecognizer.minimumPressDuration = 0.01
        longPressGestureRecognizer.cancelsTouchesInView = false
        gridCollectionView.addGestureRecognizer(longPressGestureRecognizer)
        
        gridCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CommonCell")
        gridCollectionView.delegate = self
        gridCollectionView.dataSource = self
        gridCollectionView.isScrollEnabled = false
    }
    
    private func updateCollectionViewSize() {
        let width = (gridPixelHorizontalCount * pixelWidth) + ((gridPixelHorizontalCount - 1) * pixelSpacing)
        let height = (gridPixelVerticalCount * pixelWidth) + ((gridPixelVerticalCount - 1) * pixelSpacing)
        
        let horizontalSpacing = max(pixelWidth, (gridScrollView.frame.size.width - width) / 2)
        let verticalSpacing = max(pixelWidth, (gridScrollView.frame.size.height - height) / 2)
        gridLeading.constant = horizontalSpacing
        gridTrailing.constant = horizontalSpacing
        gridTop.constant = verticalSpacing
        gridBottom.constant = verticalSpacing
        
        gridWidth.constant = width
        gridHeight.constant = height
        
        gridCollectionViewLayout.itemSize = CGSize(width: pixelWidth, height: pixelWidth)
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
        gridCollectionView.reloadData()
    }
    
    private func paintPixelAt(_ indexPath: IndexPath, with color: UIColor) {
        pixelColor[indexPath] = color
        if let cell = gridCollectionView.cellForItem(at: indexPath) {
            cell.contentView.backgroundColor = color
        }
    }
    
    @objc func longPress(gestureRecognizer: UILongPressGestureRecognizer) {
        switch gestureRecognizer.state {
        case .possible:
            return
        case .began:
            let tapLocation = gestureRecognizer.location(in: gridCollectionView)
            if let indexPath = gridCollectionView.indexPathForItem(at: tapLocation) {
                paintPixelAt(indexPath, with: UIColor.black)
            }
        case .changed:
            let tapLocation = gestureRecognizer.location(in: gridCollectionView)
            if let indexPath = gridCollectionView.indexPathForItem(at: tapLocation) {
                paintPixelAt(indexPath, with: UIColor.black)
            }
        case .failed:
            fallthrough
        case .cancelled:
            fallthrough
        case .ended:
            break
        }
    }
    
    @IBAction func penTool(_ sender: Any) {
        
    }
    
    @IBAction func increaseGridSizeTap(_ sender: Any) {
        gridPixelHorizontalCount += 1
        gridPixelVerticalCount += 1
        updateCollectionViewSize()
    }
    
    @IBAction func decreaseGridSizeTap(_ sender: Any) {
        gridPixelHorizontalCount -= 1
        gridPixelVerticalCount -= 1
        updateCollectionViewSize()
    }
    
    @IBAction func zoomInTap(_ sender: Any) {
        pixelWidth += 5
        updateCollectionViewSize()
    }
    
    @IBAction func zoomOutTap(_ sender: Any) {
        pixelWidth -= 5
        updateCollectionViewSize()
    }
    
    @IBAction func clearTap(_ sender: Any) {
        pixelColor = [IndexPath: UIColor]()
        gridCollectionView.reloadData()
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        paintPixelAt(indexPath, with: UIColor.black)
    }
}



