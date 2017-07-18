//
//  addInfo.swift
//  just-do-it
//
//  Created by 刘新宇 on 2017/7/12.
//  Copyright © 2017年 soulpacket. All rights reserved.
//

import Foundation
import UIKit

var infos = info()
struct do_info {
    var title: String
    var description: String?
    var time: String?
    var alarm: Bool
    mutating func change_property(title: String, description: String?, time: String?, alarm: Bool)
    {
        self.title = title
        self.description = description
        self.time = time
        self.alarm = alarm
    }
}

class info{
    var todos = [do_info]()
    func add_task(title : String, desc : String?, time : String?, alarm : Bool?)
    {
        todos.append(do_info(title: title, description: desc, time: time, alarm: alarm!))
    }
    
}

