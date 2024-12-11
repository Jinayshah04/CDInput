//
//  UpdateVC.swift
//  CDInput
//
//  Created by Admin2 on 07/12/24.
//

import UIKit
import CoreData
class UpdateVC: UIViewController {

    @IBOutlet weak var tid: UITextField!
    
    
    @IBOutlet weak var tusername: UITextField!
    
    
    @IBOutlet weak var tpassword: UITextField!
    
    var userToUpdate: UserModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = userToUpdate{
            tid.text = "\(user.id)"
            tusername.text = user.username
            tpassword.text = user.password
        }
       
    }

    @IBAction func updateToCD(_ sender: Any) {
        let gt = UserModel(id: Int32(tid.text!)!, username: tusername.text!, password: tpassword.text!)
        CoreDataManager().updatefromCD(usr: gt)
        navigationController?.popViewController(animated: true)
    }
    
}
