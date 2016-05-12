import Foundation
import CloudKit
import UIKit

class CloudKitHelper : NSObject, UITableViewDataSource, UITableViewDelegate{
    
    var container : CKContainer
    var publicDB : CKDatabase
    let privateDB : CKDatabase
    
    var tableView : UITableView = UITableView()
    
    static var todos : [String] = [String]()
    
    override init() {
        container = CKContainer.defaultContainer()
        publicDB = container.publicCloudDatabase
        privateDB = container.privateCloudDatabase
    }
    
    func saveRecord(todo : NSString) {
        let todoRecord = CKRecord(recordType: "ToDo")
        todoRecord.setValue(todo, forKey: "todotext")
        publicDB.saveRecord(todoRecord, completionHandler: { (record, error) -> Void in
            NSLog("Saved to cloud kit")
        })
    }
    func fetchToDos() {
        
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: "ToDo",
                            predicate:  predicate)
        
        publicDB.performQuery(query, inZoneWithID: nil) {
            results, error in
            if error == nil {
                CloudKitHelper.todos.removeAll()
                for record in results!{
                    CloudKitHelper.todos.append(record.objectForKey("todotext") as! String)
                }
                self.tableView.reloadData()
                return
            }
            return
        }
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CloudKitHelper.todos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")!
        cell.textLabel?.text = CloudKitHelper.todos[indexPath.row]
        return cell
    }
    


}
