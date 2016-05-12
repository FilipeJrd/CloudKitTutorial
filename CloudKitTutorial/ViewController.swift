//
//  ViewController.swift
//  CloudKitTutorial
//
//  Created by Filipe Jordão on 5/12/16.
//  Copyright © 2016 Filipe Jordão. All rights reserved.
//

import UIKit
import CloudKit

class ViewController: UIViewController{
    let cloudkit : CloudKitHelper = CloudKitHelper()

    

    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cloudkit.tableView = tableview
        tableview.delegate = cloudkit
        tableview.dataSource = cloudkit
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBOutlet weak var input: UITextField!

    @IBAction func update(sender: AnyObject) {
        cloudkit.fetchToDos()
      }
    
    @IBAction func manda(sender: AnyObject) {
        cloudkit.saveRecord(input.text!)
        
    }
}

