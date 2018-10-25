//
//  FileViewController.swift
//  Sw-FileBrowser
//
//  Created by Steven Senger on 10/11/18.
//  Copyright © 2018 Steven Senger. All rights reserved.
//

import UIKit

class FileViewController: UITableViewController {
  
  let sectionNames = ["Creation Date", "Modification Date", "Size"]
  var detailPath = ""
  var attributes = [FileAttributeKey:Any]()
  
  // Mark: UITableViewDataSource Protocol Methods
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // return number of sections
    return sectionNames.count
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // some sections have a single row, contents sections for directories have several rows
    return 1
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //convert the creation date and modification date from an NSDate to a String
    let createDate = attributes[FileAttributeKey.creationDate]
    let modifyDate = attributes[FileAttributeKey.modificationDate]
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd-MM-yyyy hh:mm:ss +0000"
    let stringCreateDate: String = dateFormatter.string(from: createDate as! Date)
    let stringModifyDate: String = dateFormatter.string(from: modifyDate as! Date)
    //convert the size of the file to a string to set the label
    let size = attributes[FileAttributeKey.size]
    let sizeCopy = size.debugDescription
    //---------------------------------------------------------------------------
    // get a cell either reuseable from table or newly created
    var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
    if cell == nil {
        cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell?.accessoryType = .disclosureIndicator
    }
    // use switch on section
    switch(indexPath.section) {
        // set the cell.accessoryType and cell.textLabel.text
        // accessoryType is either UITableViewCell.AccessoryType.none or UITableViewCell.AccessoryType.disclosureIndicator
    // text either comes from attributes or sub directories
    case 0:
        cell?.accessoryType = UITableViewCell.AccessoryType.none
        cell?.textLabel?.text = stringCreateDate
        break;
    case 1:
        cell?.accessoryType = UITableViewCell.AccessoryType.none
        cell?.textLabel?.text = stringModifyDate
        break;
    case 2:
        cell?.accessoryType = UITableViewCell.AccessoryType.none
        cell?.textLabel?.text = formSizeString(str: sizeCopy)
        print("SIZE OF FILE: ", detailPath)
        break;
    default:
        return cell!
    }
    // textLabel text comes from attributes
    // return the cell
    return cell!
  }
  
  // Mark: UITableViewDelegate Methods
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    // return the section name
    return sectionNames[section]
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // set self.title from detailPath last component
    var detailCopy: NSString = detailPath as NSString
    detailCopy = detailCopy.lastPathComponent as NSString
    self.title = detailCopy as String
    // get attributes of detailPath
    attributes = try! FileManager.default.attributesOfItem(atPath: detailPath)
  }
  
  //Helper method to remove the "Optional( )" part of the size text
  func formSizeString( str: String ) -> String {
    var str2 = str.replacingOccurrences(of: "Optional(", with: "")
    str2 = str2.replacingOccurrences(of: ")", with: "")
    return str2
  }
    

}
