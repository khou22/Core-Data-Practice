//
//  ViewController.swift
//  Core-Data-Practice
//
//  Created by Kevin Hou on 8/31/16.
//  Copyright © 2016 KevinHou. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet var tableView: UITableView! // Main table view
    var names = [String]() // Initialize empty array with type String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "\"The List\"" // Set title
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
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
            self.names.append(textField!.text!) // Add to list of names
            print("Added \(textField!.text!) to the list")
            
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let rowIndex = indexPath.row // Store row index
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        
        cell!.textLabel?.text = names[rowIndex] // Set text of cell
        
        return cell!
    }

}

