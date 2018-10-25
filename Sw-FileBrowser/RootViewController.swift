//
//  RootViewController.swift
//  Sw-FileBrowser
//
//  Created by Steven Senger on 10/11/18.
//  Copyright © 2018 Steven Senger. All rights reserved.
//

import UIKit

class RootViewController: UITableViewController {

  let sectionNames = ["Creation Date", "Modification Date", "Contents"]
  
  var detailPath = "/"
  var subDirs = [String]()
  var attributes = [FileAttributeKey:Any]()
    
  // Mark: UITableViewDataSource Protocol Methods
  override func numberOfSections(in tableView: UITableView) -> Int {
    // return number of sections
    return sectionNames.count
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // use a switch on the section number
    switch( section ){
        case 0:
            return 1;
        case 1:
            return 1;
        case 2:
            return subDirs.count
        default:
            return 1
    }
    // sections 0 and 1 have 1 row, sections 2 has a row for each sub directory
    
    }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //convert the creation date and modification date from an NSDate to a String
    let createDate = attributes[FileAttributeKey.creationDate]
    let modifyDate = attributes[FileAttributeKey.modificationDate]
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd-MM-yyyy hh:mm:ss +0000"
    let stringCreateDate: String = dateFormatter.string(from: createDate as! Date)
    let stringModifyDate: String = dateFormatter.string(from: modifyDate as! Date)
    //---------------------------------------------------------------------------
    var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
    if cell == nil {
      cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
      cell?.accessoryType = .disclosureIndicator
    }
    // use a switch on the section number
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
            cell?.textLabel?.text = subDirs[indexPath.row]
            break;
        default:
            return cell!
    }
    return cell!
  }
  
  // Mark: UITableViewDelegate Methods
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // if section is not 2 there is nothing to do
    if( indexPath.section == 2 ){
        let oldPath = detailPath
        let nextStep = subDirs[indexPath.row]
        var newPath = oldPath + "/" + nextStep
        //determine whether the next path is a directory or one file
        var isDirectory = ObjCBool(true)
        let exists = FileManager.default.fileExists(atPath: newPath, isDirectory: &isDirectory)
        let isDir = exists && isDirectory.boolValue
    // if selected row is a subdirectory entry then create new RootViewController
        if( isDir ){
            newPath = oldPath + nextStep + "/"
            let newRoot: RootViewController = RootViewController()
            newRoot.detailPath = newPath
            print("IS A SUBDIRECTORY ", nextStep)
            // in both cases set detailPath on controller and tell navigationController to push it
            self.navigationController?.pushViewController(newRoot, animated: true)
        }
        else{
            newPath = oldPath + "/" + nextStep
            // if selected row is a file entry then create new FileViewcontroller
            let newFile: FileViewController = FileViewController()
            newFile.detailPath = newPath
            //newFile.attributes = self.attributes
            // in both cases set detailPath on controller and tell navigationController to push it
            self.navigationController?.pushViewController(newFile, animated: true)
        }
    }
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    // return the section name
    return sectionNames[section]
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //keep the user from scrolling down to far when all of the contents are displayed
    tableView.bounces = false
    // set self.title from detailPath last component
    self.title = detailPath
    // make an array of subdirectories of detailPath, exclude things that start with "."
    subDirs = try! FileManager.default.contentsOfDirectory(atPath: detailPath)
    //filter directories that start with "."
    subDirs = subDirs.filter{ $0.prefix(1) != "." }
    //DEBUG subDirs
    //for name in subDirs{
    //    print(name)
    //}
    // get attributes of detailPath
    attributes = try! FileManager.default.attributesOfItem(atPath: detailPath)
    //DEBUG subDirs
    //for keys in attributes{
    //    print( keys )
    //}
  }

}

