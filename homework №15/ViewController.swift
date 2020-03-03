//
//  ViewController.swift
//  homework №15
//
//  Created by Shirayo on 01.03.2020.
//  Copyright © 2020 Shirayo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var fibonacciSequence: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showAlert(title: "Hello", message: "enter border of fibonacci sequence", style: .alert)
        tableView.dataSource = self
        tableView.rowHeight = 40.0
    }
    
    @IBAction func recreateFibDidClick(_ sender: Any) {
        showAlert(title: "Hello again!", message: "enter border of fibonacci sequence", style: .alert)
    }
    
    func showAlert(title: String, message: String, style: UIAlertController.Style) {
        let enterNumberAlert = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: "go", style: .default) {(action) in
            let text = enterNumberAlert.textFields?.first
            if let _ = Int(text!.text!) {
                self.fibonacciSequence = self.createFibonacciTill(Int((text?.text)!) ?? 10)
                self.tableView.reloadData()
            } else {
                self.showAlert(title: "Error", message: "let's try again", style: .alert)
            }
        }
        enterNumberAlert.addAction(action)
        enterNumberAlert.addTextField { (UITextField) in }
        self.present(enterNumberAlert, animated: true, completion: nil)
    }
    
    func createFibonacciTill(_ number: Int) -> [Int] {
        var fibonacciFirst = 1
        var fibonacciSecond = 1
        var element = fibonacciFirst + fibonacciSecond
        var result: [Int] = [fibonacciFirst, fibonacciSecond]
        while  fibonacciFirst + fibonacciSecond <= number {
            element = fibonacciFirst + fibonacciSecond
            fibonacciSecond = fibonacciFirst
            fibonacciFirst = element
            result.append(element)
        }
        return result
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fibonacciSequence.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "fib")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "fib")
        } else {
            print("recreate cell")
        }
        cell?.textLabel?.text = String(fibonacciSequence[indexPath.row])
        return cell!
    }
}
