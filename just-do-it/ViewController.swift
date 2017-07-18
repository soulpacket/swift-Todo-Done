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
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var datePicker : UIDatePicker!
    
    
    
    var text = ""
    var index = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        subviews.append(addbutton)
        subviews.append(dolist)
        self.disappear_date()
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.dolist.reloadData()
    }
    
    
    @IBAction func set_alarm(_ sender: Any) {
        self.appear_date()
    }
    
    func addDate(){
        //日期样式
        let formatter = DateFormatter()
        formatter.dateFormat = "MM//dd//yyyy HH:mm"
        self.datePicker.datePickerMode = .dateAndTime
        self.datePicker.locale = NSLocale(localeIdentifier: "zh_CN") as Locale
        //更新提醒时间文本框
        self.text = formatter.string(from: datePicker.date)
    }
    
    
    func appear_date(){
        self.tabBarController?.tabBar.isHidden=true
        self.datePicker.isHidden = false
        self.toolbar.isHidden = false
        self.addbutton.isHidden = true
    }
    
    
    func disappear_date(){
        self.tabBarController?.tabBar.isHidden=false
        self.datePicker.isHidden = true
        self.toolbar.isHidden = true
        self.addbutton.isHidden = false
    }
    
    
    @IBAction func finish_edit_time(_ sender: Any) {
        self.disappear_date()
        //todo detailtextlabel = time
    }
    
    
    @IBAction func cancel_edit_time(_ sender: Any) {
        self.disappear_date()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infos.todos.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hahaha")!
        let info = infos.todos[(indexPath as NSIndexPath).row]
        // Set the name and image
        cell.textLabel?.text = info.title
        cell.detailTextLabel?.text = info.time
        return cell
    }
    
    
    //右滑产生actions
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        let edit = UITableViewRowAction(style: .normal, title: "edit") { action, index in
            print("more button tapped")
            let detailController = self.storyboard!.instantiateViewController(withIdentifier: "editInfo") as! editInfo
            detailController.tf.text = infos.todos[(indexPath as NSIndexPath).row].title
            detailController.tf_1.setOn(infos.todos[(indexPath as NSIndexPath).row].alarm, animated: true)
            detailController.Editing = true
            detailController.index_path = (indexPath as NSIndexPath).row
            self.navigationController!.pushViewController(detailController, animated: true)
        }
        edit.backgroundColor = UIColor.orange
        
        //delete a row
        let delete = UITableViewRowAction(style: .normal, title: "delete") { action, index in
            infos.todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
        delete.backgroundColor = UIColor.red
        return [delete, edit]
    }
}

