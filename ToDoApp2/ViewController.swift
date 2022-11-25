//
//  ViewController.swift
//  ToDoApp2
//
//  Created by Anusha on 20/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    var items = [Model]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
       
    }
    
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem){
        
        var noteTextField = UITextField()
        var dateTextField = UITextField()
        
        let alert = UIAlertController(title: "Enter the note", message: "" , preferredStyle:.alert)
        
        let cancel = UIAlertAction(title: "Cancel", style: .default){
          
                (cancel) in
     
        }
        let save = UIAlertAction(title: "Add", style: .default){
            (save) in
            
            self.items.append(Model(dates: dateTextField.text! , note: noteTextField.text! ))
            self.tableView.reloadData()
            
        }
        
        alert.addTextField{(text) in
            noteTextField = text
            noteTextField.placeholder = "Add new item"
        }
        
        alert.addTextField{(text) in
            dateTextField = text
            dateTextField.placeholder = "Enter Date"
        }
        
        alert.addAction(cancel)
        alert.addAction(save)
        
        self.present(alert, animated: true, completion: nil)
        
    }


}

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"toDoCell" , for: indexPath)
        cell.textLabel?.text = items[indexPath.row].dates + "  " + items[indexPath.row].note
        return cell
        
    
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"noteDisplay") as! DisplayViewController
        vc.note = items[indexPath.row].note
        vc.date = items[indexPath.row].dates
        present(vc, animated:true, completion: nil)
        
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if(editingStyle == .delete){
            
            items.remove(at: indexPath.row)
            tableView.deselectRow(at: [indexPath.row], animated: true)
            tableView.reloadData()
            
        }else if(editingStyle == .insert){
                
                let storyBoard = UIStoryboard(name: "Main", bundle:nil)
                let vc = storyBoard.instantiateViewController(withIdentifier:"noteDisplay") as! DisplayViewController
                vc.note = items[indexPath.row].note
                vc.date = items[indexPath.row].dates
                present(vc, animated:true, completion: nil)
        
            }
        }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { (action, indexPath) in
            let storyBoard = UIStoryboard(name: "Main", bundle:nil)
            let vc = storyBoard.instantiateViewController(withIdentifier:"noteDisplay") as! DisplayViewController
            self.present(vc, animated:true, completion: nil)
         })
        
         editAction.backgroundColor = UIColor.blue

         
         let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
             self.items.remove(at: indexPath.row)
             tableView.deselectRow(at: [indexPath.row], animated: true)
             tableView.reloadData()
         })
        
         deleteAction.backgroundColor = UIColor.red

         return [editAction, deleteAction]

    }

           
        

}

