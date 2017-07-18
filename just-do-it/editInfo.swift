//
//  editInfo.swift
//  just-do-it
//
//  Created by 刘新宇 on 2017/7/17.
//  Copyright © 2017年 soulpacket. All rights reserved.
//

import Foundation
import UIKit
class editInfo: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var finish_edit_button: UIBarButtonItem!
    
    var dimension = [[0], [0]]
    var time_text : String?
    var Editing : Bool? = false
    var index_path : Int?
    
    @IBOutlet weak var table_test:
        UITableView!
    let tf = UITextField(frame: CGRect(x: 10, y: 0, width: 375, height: 43.5))
    let tf_1 = UISwitch(frame: CGRect(x: 296, y: 6, width: 51, height:31))
    let tf_2 = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 375, height:216))
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //table_test.reloadData()
        tf.placeholder = "Enter text here"
        tf.font = UIFont.systemFont(ofSize: 15)
        //tf_1.isOn = false
        tf_1.addTarget(self, action: #selector(stateChanged(switchState:)), for: UIControlEvents.valueChanged)
        tf_2.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged)
        tf_2.locale = Locale(identifier: "zh_TW")
        if !Editing!{
        tf.becomeFirstResponder()
        }
        tf.delegate = self
        
        if tf.text == Optional(""){
            finish_edit_button.isEnabled = false}
        else{
            finish_edit_button.isEnabled = true
        }
        self.stateChanged(switchState: tf_1)
    }
    
    
    
    func stateChanged(switchState: UISwitch){
        if switchState.isOn {
            //print("The Switch is On")
            //默认推迟两小时
            let now = Date()
            let timeInterval:TimeInterval = now.timeIntervalSince1970
            let timeStamp = Int(timeInterval)+3600*2
            
            let timeInter:TimeInterval = TimeInterval(timeStamp)
            let date = Date(timeIntervalSince1970: timeInter)
            
            let dformatter = DateFormatter()
            dformatter.dateFormat = "MM/dd/yy HH:mm"
            self.time_text = dformatter.string(from: date)
            
            dimension[1] = [0, 0]
            self.table_test.reloadData()
        } else {
            //print("The Switch is Off")
            dimension[1] = [0]
            self.table_test.reloadData()
        }
    }
    
    
    func datePickerChanged(datePicker:UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yy HH:mm"
        
        // 更新 UILabel 的內容
        self.time_text = formatter.string(from: datePicker.date)
        self.table_test.reloadData()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dimension.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dimension[section].count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "new_start")!
        //let infooo = restaurantNames[(indexPath as NSIndexPath).row]
        if indexPath.section == 0{
            //cell.contentView.addSubview(tf)
            cell.addSubview(tf)
            return cell
        }
        else{
            if indexPath.row == 0{
            cell.addSubview(self.tf_1)
            cell.textLabel?.text = "是否设置提醒时间"
            return cell
            }
            else if indexPath.row == 1{
                cell.textLabel?.text = "提醒时间"
                cell.detailTextLabel?.text = self.time_text
            }
            else if indexPath.row == 2{
                self.tf_2.minimumDate = Date()  //设置最小的选择时间为当前时间
                cell.addSubview(self.tf_2)
            }
        }
        //cell.textLabel?.text = "这是第\(indexPath.row)个cell"
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //选择了改变时间，出现datepicker view
        if indexPath.section == 1 && indexPath.row == 1{
            self.dimension[1] = [0, 0, 0]
            self.table_test.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
        //出现datepicker时增大cell的高度到220
        {
        var height:CGFloat = CGFloat()
        if indexPath.row == 2 && indexPath.section == 1{
            height = 220
        }
        else {
            height = 44
        }
        
        return height
    }
    
    
    @IBAction func cancel_edit(_ sender: Any) {
        let controller = self.navigationController!.viewControllers[0]
        let _ = self.navigationController?.popToViewController(controller, animated: true)
        self.tabBarController?.tabBar.isHidden=false
        
    }
    
    
    //edit和新建有两种逻辑。edit：change_property, new: add_task
    @IBAction func finish_edit(_ sender: Any) {
        if !Editing!{
        if self.tf_1.isOn{
        infos.add_task(title: self.tf.text!,
                       desc: nil,
                       time: self.time_text,
                       alarm: true)
        }
        else {
            infos.add_task(title: self.tf.text!,
                           desc: nil,
                           time: nil,
                           alarm: false)
            }
        }
        else{
            if self.tf_1.isOn{
            infos.todos[self.index_path!].change_property(title: self.tf.text!, description: nil, time: self.time_text, alarm: true)
            }
            else{
                infos.todos[self.index_path!].change_property(title: self.tf.text!, description: nil, time: nil, alarm: false)
            }
            }
        let controller = self.navigationController!.viewControllers[0]
        let _ = self.navigationController?.popToViewController(controller, animated: true)
        self.tabBarController?.tabBar.isHidden=false

    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text
        let newtext = (currentText! as NSString).replacingCharacters(in: range, with: string)
        
        finish_edit_button.isEnabled = newtext.characters.count>0
        return true
    }
}

class customCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
