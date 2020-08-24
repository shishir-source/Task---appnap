//
//  EditVC.swift
//  Covic 19 Recorder
//
//  Created by Appnap WS04 on 24/8/20.
//  Copyright © 2020 Appnap WS04. All rights reserved.
//

import UIKit
import CoreData

class EditVC: UIViewController {
    
    @IBOutlet weak var dateTitle: UIDatePicker!
    @IBOutlet weak var affectedTxt: UITextField!
    @IBOutlet weak var deathTxt: UITextField!
    @IBOutlet weak var reliefTxt: UITextField!
    
    var dateData = Date()
    
    var getid: UUID!
    
    var covidInfo: NSManagedObject!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = covidInfo{
            guard let affected = data.value(forKey: "affected") as? String else{return}
            guard let death = data.value(forKey: "death") as? String else{return}
            guard let relief = data.value(forKey: "relief") as? String else{return}
            guard let newId = data.value(forKey: "identifier") as? UUID else{return}
            guard let newDate = data.value(forKey: "date") as? Date else{return}
            
            getid = newId
            
            affectedTxt.text = affected
            deathTxt.text = death
            reliefTxt.text = relief
            dateTitle.date = newDate
        }
    }
    
    @IBAction func datePickerChanged(_ sender: Any) {
        dateData = dateTitle.date
    }
    
    @IBAction func submitBtnPressed(_ sender: Any) {
        
        guard let affected = affectedTxt.text else { return }
        guard let death = deathTxt.text else { return }
        guard let relief = reliefTxt.text else { return }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Covid", in: context)
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.entity = entity
        let predicate = NSPredicate(format: "(identifier = %@)", getid! as CVarArg)
        request.predicate = predicate
        
        do {
            let results =
                try context.fetch(request)
            let objectUpdate = results[0] as! NSManagedObject
            objectUpdate.setValue(affected, forKey: "affected")
            objectUpdate.setValue(death, forKey: "death")
            objectUpdate.setValue(relief, forKey: "relief")
            objectUpdate.setValue(dateData, forKey: "date")
            do {
                try context.save()
                navigationController?.popViewController(animated: true)

            }catch let error as NSError {
                print(error)
            }
        }
        catch let error as NSError {
            print(error)
        }
        
        
    }

}
