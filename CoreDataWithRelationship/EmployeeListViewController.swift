//
//  EmployeeListViewController.swift
//  CoreDataWithRelationship
//
//  Created by iFlame on 10/11/17.
//  Copyright © 2017 iflame. All rights reserved.
//

import UIKit
import CoreData

class EmployeeListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    @IBOutlet weak var Tableview: UITableView!
    
    var arr = [Employee]()
    
    var selManager:Manager? = nil
    var employeeSelected = [Bool]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Employee List"
        fetch()
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        self.Tableview.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.arr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if employeeSelected[indexPath.row] == true
        {
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryType.none
        }
        
        cell.textLabel?.text = self.arr[indexPath.row].name
//        cell.textLabel?.text = arr[indexPath.row].company
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let objEmployee = self.arr[indexPath.row]
        self.selManager?.addToEmployee(objEmployee)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        if employeeSelected[indexPath.row] == true
        {
            employeeSelected[indexPath.row] = false
        }
        else
        {
            employeeSelected[indexPath.row] = true
        }
        self.Tableview.reloadData()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func fetch()
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do
        {
            self.arr = try context.fetch(Employee.fetchRequest())
            
            var index = 0
            while index < self.arr.count
            {
                employeeSelected.append(false)
                index += 1
            }
        }
        catch
        {
            print(error.localizedDescription)
        }
    }
}
