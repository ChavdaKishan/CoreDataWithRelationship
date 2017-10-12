//
//  AddPositionViewController.swift
//  CoreDataWithRelationship
//
//  Created by iFlame on 10/11/17.
//  Copyright © 2017 iflame. All rights reserved.
//

import UIKit
import CoreData

enum PositionType : Int
{
    case EmployeeType = 0
    case ManagerType
}

class AddPositionViewController: UIViewController
{
    @IBOutlet weak var TxtName: UITextField!
    @IBOutlet weak var TxtCompany: UITextField!
    @IBOutlet weak var Segment: UISegmentedControl!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
    }
    
    // MARK: - BtnClick
    @IBAction func SaveBtn(_ sender: UIButton)
    {
        if Segment.selectedSegmentIndex == PositionType.EmployeeType.rawValue
        {
            let objEmployee = Employee(context: context)
            objEmployee.name = TxtName.text
            objEmployee.company = TxtCompany.text
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        }
        else
        {
            let objManager = Manager(context: context)
            objManager.name = TxtName.text
            objManager.company = TxtCompany.text
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        }
        print("Saved")
    }
    
    @IBAction func Delete(_ sender: UIButton)
    {
        if Segment.selectedSegmentIndex == PositionType.EmployeeType.rawValue
        {
            let fetchData : NSFetchRequest<Employee> = Employee.fetchRequest()
            do
            {
                let tmp = try context.fetch(fetchData)
                for dis in tmp as [NSManagedObject]
                {
                    context.delete(dis)
                    (UIApplication.shared.delegate as! AppDelegate).saveContext()
                }
            }
            catch
            {
                print(error)
            }
        }
        else
        {
            let fetchData : NSFetchRequest<Manager> = Manager.fetchRequest()
            do
            {
                let tmp = try context.fetch(fetchData)
                for dis in tmp as [NSManagedObject]
                {
                    context.delete(dis)
                    (UIApplication.shared.delegate as! AppDelegate).saveContext()
                }
            }
            catch
            {
                print(error)
            }
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
