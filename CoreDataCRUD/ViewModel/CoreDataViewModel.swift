//
//  CoreDataViewModel.swift
//  CoreDataCRUD
//
//  Created by mac on 02/02/23.
//

import Foundation
import UIKit

class coreDataModel{
    
    var view : ViewControllerProtocol!
    
    
    func setupUI(){
        view.controller.addBtn.roundedButton(height: 5.0)
    }
    
    func ShowUserAlert(_ userData:User?,index:Int) {
        //1. Create the alert controller.
        var user :User?
        if index != -1{
            user = view.controller.details?[index]
        }
        let alert = UIAlertController(title: "Registering", message: "You are successfully register, please sign in", preferredStyle: .alert)
        alert.addTextField { (username) in
            username.text = index != -1 ? user?.name ?? "" : ""
            username.placeholder = "User Name"
        }
        alert.addTextField(configurationHandler: { (ageField) in
            ageField.text =  index != -1 ? String(user?.age ?? 0) : ""
            ageField.placeholder = "Age"
        })
        alert.addTextField(configurationHandler: { (genderField) in
            genderField.text = index != -1 ? user?.gender ?? "" : ""
            genderField.placeholder = "Gender"
        })
      
        let confirmAction = UIAlertAction(title: "OK", style: .default, handler: { [self](_ action: UIAlertAction) -> Void in
            if index != -1{
                do {
                    user?.name = alert.textFields?[0].text ?? ""
                    user?.age = Int64(alert.textFields?[1].text ?? "") ?? 0
                    user?.gender = alert.textFields?[2].text ?? ""
                    try self.view.controller.context.save()
                    fetchData()
                }catch{
                    view.controller.view.makeToast("No data found")
                }
            }else{
            if !(alert.textFields?[0].text?.isEmptyOrWhitespace() ?? false) && !(alert.textFields?[1].text?.isEmptyOrWhitespace() ?? false) && !(alert.textFields?[2].text?.isEmptyOrWhitespace() ?? false){
                saveData(Name: alert.textFields?[0].text ?? "", Age: alert.textFields?[1].text ?? "", Gender: alert.textFields?[2].text ?? "")
                fetchData()
            }else{
                view.controller.view.makeToast("Please Enter Data")
            }
            }
        })
        alert.addAction(confirmAction)
        self.view.controller.present(alert, animated: true, completion: nil)
    }
    
    
    func fetchData(){
        do {
            self.view.controller.details = try view.controller.context.fetch(User.fetchRequest())
            
            DispatchQueue.main.async { [self] in
                view.controller.DataTableView.reloadData()
            }
        }catch{
            print("No data found")
        }
    }
    
    
    func saveData(Name:String,Age:String,Gender:String){
        let user = User(context: self.view.controller.context)
        user.age = Int64(Age) ?? 0
        user.gender = Gender
        user.name = Name
        
        do {
            try self.view.controller.context.save()
            DispatchQueue.main.async { [self] in
                view.controller.DataTableView.reloadData()
            }
        }catch{
            print("No data found")
        }
    }
    
    
    func deleteData(index:Int){
            let usertoRemove = view.controller.details?[index]
            view.controller.context.delete(usertoRemove!)
        
        do {
            try self.view.controller.context.save()
        }catch{
            self.view.controller.view.makeToast("No data found")
        }
        fetchData()
    }
    
}
