//
//  KeepRecordVC.swift
//  Covic 19 Recorder
//
//  Created by Appnap WS04 on 24/8/20.
//  Copyright © 2020 Appnap WS04. All rights reserved.
//

import UIKit
import CoreData

class KeepRecordVC: UIViewController {

    @IBOutlet weak var dateTitle: UIDatePicker!
    @IBOutlet weak var affectedTxt: UITextField!
    @IBOutlet weak var deathTxt: UITextField!
    @IBOutlet weak var reliefTxt: UITextField!
    
    var dateData = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
        
    @IBAction func datePickerChanged(_ sender: Any) {
        dateData = dateTitle.date
    }
    
    @IBAction func submitBtnPressed(_ sender: Any) {
        
        guard let affected = affectedTxt.text else { return }
        guard let death = deathTxt.text else { return }
        guard let relief = reliefTxt.text else { return }
        
        self.saveData(dateEntry: dateData, affected: affected, death: death, relief: relief)
    }
    
    func saveData(dateEntry: Date, affected: String, death: String, relief: String) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Covid", in: context)
        let data = NSManagedObject(entity: entity!, insertInto: context)
        
        let identifier = UUID()
        
        data.setValue(identifier, forKey: "identifier")
        data.setValue(dateEntry, forKey: "date")
        data.setValue(affected, forKey: "affected")
        data.setValue(death, forKey: "death")
        data.setValue(relief, forKey: "relief")
        
        do {
            
            try context.save()
            
            print("Saved successfully")
            navigationController?.popViewController(animated: true)
            
        } catch {
            
            print("Failed saving")
        }
        
    }
    
}
