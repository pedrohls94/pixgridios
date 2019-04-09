//
//  ColorPickerCollectionView.swift
//  PixGrid
//
//  Created by Pedro Lenzi on 08/04/19.
//  Copyright © 2019 Ogygia. All rights reserved.
//

import UIKit

protocol ColorPickerDelegate {
    func didPickColor(_ color: UIColor)
}

class ColorPickerCollectionView: UICollectionView {
    var colors = [UIColor]()
    var layout: UICollectionViewFlowLayout!
    var colorPickerDelegate: ColorPickerDelegate!
    
    func prepare(with layout: UICollectionViewFlowLayout, and colorPickerDelegate: ColorPickerDelegate) {
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        layout.itemSize = CGSize(width: frame.size.width, height: frame.size.width * 0.85)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        self.layout = layout
        
        register(UINib(nibName: "ColorPickerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ColorCell")
        delegate = self
        dataSource = self
        self.colorPickerDelegate = colorPickerDelegate
        
        colors.append(UIColor.black)
        colors.append(UIColor.lightGray)
        colors.append(UIColor.red)
        colors.append(UIColor.orange)
        colors.append(UIColor.yellow)
        colors.append(UIColor.green)
        colors.append(UIColor.cyan)
        colors.append(UIColor.blue)
        colors.append(UIColor.magenta)
        colors.append(UIColor.brown)
        
        reloadData()
    }
}

extension ColorPickerCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: "ColorCell", for: indexPath) as! ColorPickerCollectionViewCell
        cell.color = colors[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = cellForItem(at: indexPath) as! ColorPickerCollectionViewCell
        colorPickerDelegate.didPickColor(cell.color)
    }
}
