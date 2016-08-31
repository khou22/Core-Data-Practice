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

