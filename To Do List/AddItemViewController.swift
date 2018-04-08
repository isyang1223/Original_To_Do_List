//
//  AddItemViewController.swift
//  To Do List
//
//  Created by Ian Yang on 3/16/18.
//  Copyright © 2018 Ian Yang. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {
    weak var delegate: AddItemViewControllerDelegate?
    
    var t: String?
    var desc: String?
    var date: Date?
    var buttonText: String?
    var indexPath: NSIndexPath?
    
    @IBOutlet weak var updateButton: UIButton!
    
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var descTextField: UITextView!
    
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        delegate?.addListItem(title: titleTextField.text!, desc: descTextField.text!, date: datePicker.date, at: indexPath)
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        delegate?.cancelButtonPressed(by: self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.descTextField.layer.borderWidth = 1.0
        self.titleTextField.text = t
        if let wrappedinput = date as? Date{
            self.datePicker.date = wrappedinput
        }
        self.descTextField.text = desc
        if buttonText != nil {
            updateButton.setTitle(buttonText, for: .normal)
        }
        

        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
