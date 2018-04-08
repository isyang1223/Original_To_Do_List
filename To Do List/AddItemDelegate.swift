//
//  AddItemDelegate.swift
//  To Do List
//
//  Created by Ian Yang on 3/16/18.
//  Copyright © 2018 Ian Yang. All rights reserved.
//

import Foundation

protocol AddItemViewControllerDelegate: class {
    func addListItem(title: String, desc: String, date: Date, at indexPath: NSIndexPath?)
    func cancelButtonPressed(by controller: AddItemViewController)
}
