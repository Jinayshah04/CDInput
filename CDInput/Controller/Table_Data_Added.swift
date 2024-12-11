//
//  Table Data Added.swift
//  CDInput
//
//  Created by Admin on 28/11/24.
//

import UIKit

class Table_Data_Added: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var userArr:[UserModel]=[]
    
    @IBOutlet weak var tableVC: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        self.tableVC.reloadData()
        userArr = CoreDataManager().readfromCD()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        
        
        // Do any additional setup after loading the view.
    }
    
    func setupTable(){
        tableVC.register(UINib(nibName: "UserDetail", bundle: nil), forCellReuseIdentifier: "UserDetails")
        tableVC.delegate=self
        tableVC.dataSource=self
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserDetails", for: indexPath) as! UserDetail
        cell.username.text = userArr[indexPath.row].username
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, sourceView, completionHandler in
            CoreDataManager().deletefromCD(usr: self.userArr[indexPath.row])
            self.userArr.remove(at: indexPath.row)
            self.tableVC.reloadData()
        }
        
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") {
                    (action, sourceView, completionHandler) in
            self.performSegue(withIdentifier: "NavigateToUpdate", sender: self.userArr[indexPath.row])
                }

        
        let swipeConfig = UISwipeActionsConfiguration(actions: [deleteAction,editAction])
        swipeConfig.performsFirstActionWithFullSwipe = true
        return swipeConfig
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let details = segue.destination as? UpdateVC, let joke = sender as? UserModel {
                details.userToUpdate=joke
            }
        }
}
