//
//  ManagerDetailsViewController.swift
//  CoreDataWithRelationship
//
//  Created by iFlame on 10/11/17.
//  Copyright © 2017 iflame. All rights reserved.
//

import UIKit

class ManagerDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    
    @IBOutlet weak var Tableview: UITableView!
    var selManager:Manager? = nil

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Manager Details"
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (self.selManager?.employee?.count)!
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let objEmployee = self.selManager?.employee?.allObjects[indexPath.row] as! Employee
        cell.textLabel?.text = objEmployee.name
        return cell
    }
    
    @IBAction func BtnClick(_ sender: UIButton)
    {
        performSegue(withIdentifier: "ShowEmployeeList", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "ShowEmployeeList"
        {
            let nextVC = segue.destination as! EmployeeListViewController
            nextVC.selManager = self.selManager
        }
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
