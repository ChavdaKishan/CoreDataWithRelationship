//
//  ManagerListViewController.swift
//  CoreDataWithRelationship
//
//  Created by iFlame on 10/11/17.
//  Copyright © 2017 iflame. All rights reserved.
//

import UIKit
import CoreData

class ManagerListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate
{
    @IBOutlet weak var Tableview: UITableView!
    var arr = [Manager]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Manager List"
        fetchData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        Tableview.reloadData()
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = arr[indexPath.row].name
//        cell.textLabel?.text = arr[indexPath.row].company
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: "ShowManagerDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "ShowManagerDetails"
        {
            if let selectedIndexPath = Tableview.indexPathForSelectedRow
            {
                let selectedManager = self.arr[selectedIndexPath.row]
                let nextVC = segue.destination as! ManagerDetailsViewController
                nextVC.selManager = selectedManager
            }
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchData()
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do
        {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Manager")
            
            let sort = NSSortDescriptor(key: "name", ascending: true)
            fetchRequest.sortDescriptors = [sort]
            
            arr = try context.fetch(fetchRequest) as! [Manager]
        }
        catch
        {
            
        }
    }
}
