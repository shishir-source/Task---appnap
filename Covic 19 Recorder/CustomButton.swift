//
//  CustomButton.swift
//  Covic 19 Recorder
//
//  Created by Appnap WS04 on 24/8/20.
//  Copyright © 2020 Appnap WS04. All rights reserved.
//


import UIKit

@IBDesignable
class RoundButton: UIButton {
    
    @IBInspectable var cornerRadious:CGFloat = 0 {
        didSet{
            self.layer.cornerRadius = cornerRadious
        }
    }
    
    @IBInspectable var borderWidth:CGFloat = 0 {
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor:UIColor = UIColor.clear {
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
}
