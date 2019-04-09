//
//  ColorPickerCollectionViewCell.swift
//  PixGrid
//
//  Created by Pedro Lenzi on 08/04/19.
//  Copyright © 2019 Ogygia. All rights reserved.
//

import UIKit

class ColorPickerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var colorView: UIView!
    var color: UIColor! {
        didSet {
            colorView.backgroundColor = color
        }
    }
}
