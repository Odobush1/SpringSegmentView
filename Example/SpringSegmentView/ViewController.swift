//
//  ViewController.swift
//  SpringSegmentView
//
//  Created by Dobush Oleksii on 30.08.18.
//  Copyright © 2018 Oleksii Dobush. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var springSegmentView: SpringSegmentView! {
        didSet {
            configureSegmentView()
            setDefaultTitle()
        }
    }
    
    private let titles = ["iPhone", "iPad", "iPod"]
    private let cellsCount = 10
    private var currentTitle = ""
    
    private func configureSegmentView() {
        let configurations = SpringSegmentView.Configurations(titles: titles,
                                                              activeFont: .boldSystemFont(ofSize: 19),
                                                              passiveFont: .systemFont(ofSize: 17))
        springSegmentView.cofigure(with: configurations)
        springSegmentView.delegate = self
    }
    
    private func setDefaultTitle() {
         currentTitle = titles[0]
    }
}

extension ViewController: SpringSegmentViewDelegate {
    
    func springSegmentViewValueChanged(_ index: Int, title: String?) {
        currentTitle = titles[index]
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        cell.textLabel?.text = "\(currentTitle) \(indexPath.row + 1)"
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
