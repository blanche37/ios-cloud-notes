//
//  CloudNotes - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class MenuViewController: UIViewController {
    var splitView: SplitViewController?
    
    let tableView = UITableView()
    var data = [CloudNoteItem]()
    
    override func loadView() {
        super.loadView()
        data = ParsingManager().parse(fileName: "sample")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.cellIdentifier)
        configureTableView()
    }
    
    func configureNavigationItem() {
        self.title = "메모"
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = view.safeAreaLayoutGuide
        
        tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
    }
    
    func loadData(detail: String, indexPath: IndexPath) {
        self.data[indexPath.row].body = detail
    }
    
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.cellIdentifier, for: indexPath) as? CustomCell else {
            return UITableViewCell()
        }
        cell.title.text = data[indexPath.row].title
        cell.lastModification.text = "\(data[indexPath.row].lastModified)"
        cell.shortDescription.text = data[indexPath.row].body
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detail = splitView?.detail as? DetailViewController else {
            return
        }
        detail.loadData(data: data, indexPath: indexPath)
        let navi :UINavigationController = UINavigationController(rootViewController: detail)
        self.showDetailViewController(navi, sender: self)
    }
    
}
