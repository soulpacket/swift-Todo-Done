//
//  ViewController.swift
//  just-do-it
//
//  Created by 刘新宇 on 2017/7/12.
//  Copyright © 2017年 soulpacket. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var subviews = [UIView]()
   
    @IBOutlet weak var dolist: UITableView!
    @IBOutlet weak var addbutton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        subviews.append(addbutton)
        subviews.append(dolist)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.dolist.reloadData()
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(infos.todos.count)
        return infos.todos.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hahaha")!
        let info = infos.todos[(indexPath as NSIndexPath).row]
        print(info)
        print(1)
        // Set the name and image
        cell.textLabel?.text = info.title
        return cell
    }
    
}

