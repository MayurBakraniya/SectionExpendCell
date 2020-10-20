//
//  ViewController.swift
//  SectionExpendCell
//
//  Created by MAC on 20/10/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var hiddenSections = Set<Int>()
    let tableViewData = [
        ["Mayur","Meet","Nitin","Shubh"],
        ["1","2","3","4"],
        ["Android","Mac","iOS","Java"],
        ["Mayur","Meet","Nitin"],
        ["Android","Mac","iOS","Java"],
    ]
    
    let TitleArray = ["Section 1","Section 2","Section 3","Section 4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        // Do any additional setup after loading the view.
    }


}

extension ViewController : UITableViewDelegate,UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.hiddenSections.contains(section) {
            return 0
        }
        return self.tableViewData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.lblText.text = self.tableViewData[indexPath.section][indexPath.row]
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionButton = UIButton()
        sectionButton.setTitle(String(section),for: .normal)
        sectionButton.backgroundColor = .lightGray
        sectionButton.tag = section
        sectionButton.addTarget(self, action: #selector(self.hideSection(sender:)), for: .touchUpInside)
        
        return sectionButton
    }
    
   
    
    @objc private func hideSection(sender: UIButton) {
        let section = sender.tag
        
        func indexPathsForSection() -> [IndexPath] {
            
            var indexPaths = [IndexPath]()
            
            for row in 0..<self.tableViewData[section].count {
                indexPaths.append(IndexPath(row: row,section:section))
            }
            return indexPaths
        }
       
        
        if self.hiddenSections.contains(section) {
            self.hiddenSections.remove(section)
           self.tableView.insertRows(at: indexPathsForSection(), with: .fade)
        } else {
            self.hiddenSections.insert(section)
           self.tableView.deleteRows(at: indexPathsForSection(), with: .fade)
        }
    }
}
