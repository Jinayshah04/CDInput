//
//  ViewController.swift
//  CDInput
//
//  Created by Admin on 28/11/24.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var idTF: UITextField!
    
    
    @IBOutlet weak var pTF: UITextField!
    
    
    @IBOutlet weak var uTF: UITextField!
    
    
    @IBOutlet weak var btnSave: UIButton!
    
    
    @IBOutlet weak var btnData: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func btnSend(_ sender: Any) {
        performSegue(withIdentifier: "NavigateToDetials", sender: nil)
    }
    
    
    @IBAction func SaveToCD(_ sender: Any) {
        let vPTF:String = pTF.text!
        let vUTF:String = uTF.text!
        let vidTF:Int32 = Int32("\(idTF.text!)")!
        let user = UserModel(id: vidTF, username: vUTF, password: vPTF)
        CoreDataManager().addToCoreData(userObject:user)
            }
    
   
}

