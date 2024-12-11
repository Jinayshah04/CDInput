//
//  CoreDataManager.swift
//  CDInput
//
//  Created by Admin on 28/11/24.
//

import Foundation
import CoreData
import UIKit

final class CoreDataManager{
    
    func addToCoreData(userObject:UserModel){
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext=delegate.persistentContainer.viewContext
        
        guard let Userentity = NSEntityDescription.entity(forEntityName: "Userentity", in: managedContext) else { return }
        
        let user = NSManagedObject(entity: Userentity, insertInto: managedContext)
        
        user.setValue(userObject.id, forKey: "id")
                user.setValue(userObject.username, forKey: "username")
                user.setValue(userObject.password, forKey: "password")
                
                do {
                    try managedContext.save()
                    debugPrint("Saved to CD Successfully")
                    
                } catch let err as NSError {
                    debugPrint("could not save to CoreData. Error: \(err)")
                }
        
    }
    
    
    func readfromCD() -> [UserModel] {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        
        let managedContext=delegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Userentity")
        var usr:[UserModel]=[]
        do{
            
            let res = try managedContext.fetch(fetchRequest)
            for data in res as! [NSManagedObject]{
                let id = data.value(forKey: "id") as! Int32
                let username = data.value(forKey: "username") as! String
                let pwd = data.value(forKey: "password") as! String
                
                let usrMod = UserModel(id: id , username: username , password: pwd)
                
                usr.append(usrMod)
                
            }
            print("Fetched Data")
            
        }catch let err as NSError{
            print("\(err)")
        }
        
        return usr
    }
    
    
    func deletefromCD(usr:UserModel){
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext=delegate.persistentContainer.viewContext
        
        let usrFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Userentity")
        print(usr)
        usrFetch.predicate = NSPredicate(format: "id == %d", usr.id)
        
        do{
            let result = try managedContext.fetch(usrFetch)
            guard let fetchedUsr = result.first else {
                print("User Not Found")
                      return  }
            managedContext.delete(fetchedUsr as! NSManagedObject)
            try managedContext.save()
        }catch let err as NSError {
            print("Failed To Delete User:\(err)")
            }
    }
    
    
    func updatefromCD(usr:UserModel){
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext=delegate.persistentContainer.viewContext
        
        let usrFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Userentity")
        
        usrFetch.predicate = NSPredicate(format: "id == %d", usr.id)
        
        do{
            let rawData = try managedContext.fetch(usrFetch)
            
            let objUpdate = rawData.first as! NSManagedObject
            objUpdate.setValue(usr.username, forKey: "username")
            objUpdate.setValue(usr.password, forKey: "password")
            
            print("obj=\(objUpdate)")
            try managedContext.save()
        }catch let error as NSError{
            print("\(error)")
        }
    }
}
