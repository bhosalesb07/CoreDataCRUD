//
//  ViewController.swift
//  CoreDataCRUD
//
//  Created by mac on 02/02/23.
//

import UIKit



class ViewController: UIViewController {

    @IBOutlet weak var DataTableView: UITableView!
    @IBOutlet weak var addBtn: UIButton!
    
    var details: [User]?
    let viewModel = coreDataModel()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.view = self
        configuration()
        viewModel.setupUI()
        viewModel.fetchData()
        
    }
    
    func configuration(){
        DataTableView.delegate = self
        DataTableView.dataSource = self
        DataTableView.register(UINib(nibName: "UserDataCell", bundle: nil), forCellReuseIdentifier: "UserDataCell")
    }
    
    @IBAction func AddClicked(_ sender: UIButton) {
        viewModel.ShowUserAlert(User(), index: -1)
    }
    
    
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserDataCell") as! UserDataCell
        let data = details?[indexPath.row]
        cell.nameLbl.halfTextColorChange(fullText: "Name : \(data?.name ?? "")", changeText: data?.name ?? "")
        cell.ageLbl.halfTextColorChange(fullText: "Age : \(data?.age ?? 0)", changeText: String(data?.age ?? 0))
        cell.genderLbl.halfTextColorChange(fullText: "Gender: \(data?.gender ?? "")", changeText: data?.gender ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.ShowUserAlert((details?[indexPath.row])!, index: indexPath.row)
    }
    
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            let animation = AnimationFactory.makeFade(duration: 0.5, delayFactor: 0.05)
            let animator = Animator(animation: animation)
            animator.animate(cell: cell, at: indexPath, in: tableView)
        }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { [self] (action, view, completionHandler) in
            viewModel.deleteData(index: indexPath.row)
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}
