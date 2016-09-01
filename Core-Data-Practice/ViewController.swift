//
//  ViewController.swift
//  Core-Data-Practice
//
//  Created by Kevin Hou on 8/31/16.
//  Copyright © 2016 KevinHou. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet var tableView: UITableView! // Main table view
    var people = [NSManagedObject]() // Initialize array of Core Data objects
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "\"The List\"" // Set title
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate // Get App Delegate
        let managedContext = appDelegate.managedObjectContext // Get the managed object context
        
        let fetchRequest = NSFetchRequest(entityName: "Person") // Get the entity objects from Core Data
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest) // Fetch results
            people = results as! [NSManagedObject] // Store locally
        } catch let error as NSError { // Catch errors
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addName(sender: AnyObject) {
        let alert = UIAlertController(title: "New name", message: "Add a new name", preferredStyle: .Alert)
        
        /****** Actions for alert ******/
        let saveAction = UIAlertAction(title: "Save", style: .Default, handler: { (action: UIAlertAction) -> Void in
            
            let textField = alert.textFields!.first // Retrive text field from alert
            self.saveName(textField!.text!) // Save the name to Core Data
            
            self.tableView.reloadData() // Refresh table
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction) -> Void in
            // Do nothing on cancel
            print("Cancelled name input")
        })
        
        alert.addTextFieldWithConfigurationHandler({ (textField: UITextField) -> Void in
            // Do nothing
        })
        
        alert.addAction(saveAction) // Add action to the alert
        alert.addAction(cancelAction)
        
        presentViewController(alert, animated: true, completion: nil) // Present the alert
        
    }
    
    func saveName(name: String) { // Save to Core Data
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate // Access the app delegate in order to save to Core Data
        let managedContext = appDelegate.managedObjectContext // Get managed object context
        
        let entity = NSEntityDescription.entityForName("Person", inManagedObjectContext: managedContext) // Identify the entity
        
        // Create a new instance of Core Data and store temporary on the managedContext
        let person = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        person.setValue(name, forKey: "name") // Set an attribute
        
        do {
            try managedContext.save() // Save the temporary data to Core Data
            print("Saved to core data")
            people.append(person) // Also add to local data so don't have to be constantly reading Core Data
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let rowIndex = indexPath.row // Store row index
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        
        let person = people[rowIndex]
        
        cell!.textLabel?.text = person.valueForKey("name") as? String // Set text of cell
        
        return cell!
    }

}

