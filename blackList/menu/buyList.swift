//
//  buyList.swift
//  blackList
//
//  Created by Olzhas Zhakan on 19.07.2023.
//

import UIKit
import Foil

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let tableView = UITableView()
    var selectedProducts: Set<Int> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }

    private func setupNavigationBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        
        let backButton = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        navigationItem.title = "Список покупок"
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppDefaults.shared.shoppingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let product = AppDefaults.shared.shoppingList[indexPath.row]
        cell.textLabel?.text = product //"\(product.name) \(product.amount)"
         
        
        cell.accessoryType = selectedProducts.contains(indexPath.row) ? .checkmark : .none
        cell.selectionStyle = .default
        cell.textLabel?.textColor = selectedProducts.contains(indexPath.row) ? .gray : .white

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
     
        
        if selectedProducts.contains(indexPath.row) {
            selectedProducts.remove(indexPath.row)
        } else {
            selectedProducts.insert(indexPath.row)
        }
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            AppDefaults.shared.shoppingList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    @objc private func addButtonTapped() {
        let alertController = UIAlertController(title: "Добавить товар", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Название товара"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Количество"
            textField.keyboardType = .numberPad
        }
        
        let addAction = UIAlertAction(title: "Добавить", style: .default) { (action) in
            if let nameTextField = alertController.textFields?[0],
               let amountTextField = alertController.textFields?[1],
               let name = nameTextField.text,
               let amountString = amountTextField.text,
               let amount = Int(amountString) {
                
                //let product = Product(storedValue: (name, amount))
                let product = name
                AppDefaults.shared.shoppingList.append(product)
                self.tableView.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
