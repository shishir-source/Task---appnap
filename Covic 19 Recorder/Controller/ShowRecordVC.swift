//
//  ShowRecordVC.swift
//  Covic 19 Recorder
//
//  Created by Appnap WS04 on 24/8/20.
//  Copyright © 2020 Appnap WS04. All rights reserved.
//

import UIKit
import CoreData

class ShowRecordVC: UIViewController {
    
    //MARK:: - Properties

    @IBOutlet weak var showTable: UITableView!
    
    var covidInfo: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext =
            appDelegate.persistentContainer.viewContext

        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Covid")

        do {
            covidInfo = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error)")
        }
        showTable.reloadData()

    }
    
}

//MARK:: - TableView DataSource And Delegate

extension ShowRecordVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return covidInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =
        tableView.dequeueReusableCell(withIdentifier: "Cell",
                                      for: indexPath) as! RecordCell
        
        let data = covidInfo[indexPath.row]
        
        cell.affected.text = data.value(forKeyPath: "affected") as? String
        cell.relief.text = data.value(forKeyPath: "relief") as? String
        cell.death.text = data.value(forKeyPath: "death") as? String
        if let date = data.value(forKeyPath: "date"){
            cell.titleDate.text = "\(date)"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title: "Alert", message: "What do you want to do.", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: { action in
            
            let update = UIStoryboard(name: "Edit", bundle:nil)
            let view = update.instantiateViewController(withIdentifier: "Edit") as! EditVC
            view.covidInfo = self.covidInfo[indexPath.row]
            self.navigationController?.pushViewController(view, animated:true)

        }))
        
        alert.addAction(UIAlertAction(title: "Delete", style: .cancel, handler: { action in
            self.deleteData(indexPath)
        }))

        self.present(alert, animated: true)
         
    }
    
    func deleteData(_ indexPath: IndexPath) {
        let entity = "Covid"
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let covid = covidInfo[indexPath.row]
        
        context.delete(covid)
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Error While Deleting Note: \(error.userInfo)")
        }
        
        //Code to Fetch New Data From The DB and Reload Table.
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        
        do {
            covidInfo = try context.fetch(fetchRequest) as! [Covid]
            showTable.reloadData()
        } catch let error as NSError {
            print("Error While Fetching Data From DB: \(error.userInfo)")
        }
    }
    
    
}
