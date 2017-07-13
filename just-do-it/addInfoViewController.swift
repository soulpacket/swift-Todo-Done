//
//  addInfoViewController.swift
//  just-do-it
//
//  Created by 刘新宇 on 2017/7/12.
//  Copyright © 2017年 soulpacket. All rights reserved.
//

import Foundation
import UIKit

class addInfoViewController: UIViewController, UITextFieldDelegate
{
    
    @IBOutlet weak var finish_edit_button: UIButton!
    
    
    @IBOutlet weak var text_title: UITextField!
    @IBOutlet weak var text_view: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        text_title.becomeFirstResponder()
        self.text_title.delegate = self
        finish_edit_button.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    /*
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        
        infos.add_task(title: textField.text!, desc: nil)
        print(infos.todos[0])
    }
    */
    @IBAction func finish_edit(_ sender: Any) {
        infos.add_task(title: text_title.text!, desc: text_view.text)
        let controller = self.navigationController!.viewControllers[0]
        let _ = self.navigationController?.popToViewController(controller, animated: true)
    }
    @IBAction func cancel_edit(_ sender: Any) {
        let controller = self.navigationController!.viewControllers[0]
        let _ = self.navigationController?.popToViewController(controller, animated: true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(range)
        print(string)
        let currentText = textField.text
        let newtext = (currentText! as NSString).replacingCharacters(in: range, with: string)
       
        finish_edit_button.isEnabled = newtext.characters.count>0
    
        return true
    }
    /*
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text != ""
        {
            finish_edit_button.isEnabled = true
        
    }
    */
}
