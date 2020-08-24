//
//  RecordCell.swift
//  Covic 19 Recorder
//
//  Created by Appnap WS04 on 24/8/20.
//  Copyright © 2020 Appnap WS04. All rights reserved.
//

import UIKit
import CoreData

class RecordCell: UITableViewCell {
    
    @IBOutlet weak var affected: UILabel!
    @IBOutlet weak var relief: UILabel!
    @IBOutlet weak var death: UILabel!
    @IBOutlet weak var titleDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
