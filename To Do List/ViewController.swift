//
//  ViewController.swift
//  To Do List
//
//  Created by Ian Yang on 3/16/18.
//  Copyright © 2018 Ian Yang. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController, AddItemViewControllerDelegate {
    var items = [ListItem]()
    

    
    let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    let manageObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        items[indexPath.row].completed = !items[indexPath.row].completed
        appDelegate.saveContext()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//
//        let item = items[indexPath.row]
//        manageObjectContext.delete(item)
//        do {
//            try manageObjectContext.save()
//        } catch {
//            print("\(error)")
//        }
//        items.remove(at: indexPath.row)
//        tableView.reloadData()
//    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            
            let item = self.items[indexPath.row]
            self.manageObjectContext.delete(item)
            do {
                try self.manageObjectContext.save()
            } catch {
                print("\(error)")
            }
            self.items.remove(at: indexPath.row)
            tableView.reloadData()
        }
        
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
            self.performSegue(withIdentifier: "editItemSegue", sender: indexPath )
        }
        
        edit.backgroundColor = UIColor.blue
        
        return [delete, edit]

    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCellTableViewCell
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        let item = items[indexPath.row]
        
        cell.titleLabel.text = item.title
        cell.dateLabel.text = dateFormatter.string(from: item.date!)
        cell.descLabel.text = item.desc
        
        cell.accessoryType = item.completed ? .checkmark : .none

        return cell
    }
    

    
    func fetchAllItems(){
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ListItem")
        do {
            let result = try manageObjectContext.fetch(request)
            items = result as! [ListItem]
        } catch {
            print("\(error)")
        }
        
    }
    
    func addListItem(title: String, desc: String, date: Date, at indexPath: NSIndexPath?) {
        
        if let ip = indexPath {
            let item = items[ip.row]
            item.title = title
            item.desc = desc
            item.date = date
            
        } else {
            
        let item = NSEntityDescription.insertNewObject(forEntityName: "ListItem", into: manageObjectContext) as! ListItem
        item.title = title
        item.desc = desc
        item.date = date
        item.completed = false
        
        items.append(item)
        
        appDelegate.saveContext()
        }
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    
    }
    
    func cancelButtonPressed(by controller: AddItemViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let addItemViewController = segue.destination as! AddItemViewController
        addItemViewController.delegate = self
        
        if let indexPath = sender as? NSIndexPath {
            let item = items[indexPath.row]
            addItemViewController.desc = item.desc
            addItemViewController.t = item.title
            addItemViewController.date = item.date
            addItemViewController.indexPath = indexPath
            addItemViewController.buttonText = "Edit Item"
    
            
            }
    }
    
    
    
    
}

