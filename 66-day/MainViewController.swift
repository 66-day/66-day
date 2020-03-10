//
//  MainViewController.swift
//  66-day
//
//  Created by Kyung-ha Lee on 2020/03/07.
//  Copyright © 2020 Kyung-ha Lee. All rights reserved.
//

/*
 MIT License

 Copyright (c) 2019 Kyung-ha Lee <i_am@nulleekh.com>

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

import Cocoa

class MainViewController: NSViewController {
    
    let defaults = UserDefaults.standard

    var lapsedDate = 0
    var goalText = ""
    
    @IBOutlet var GoalTextInput: NSTextField!
    @IBOutlet var GoalDateField: NSTextField!
    @IBOutlet var CheckButton: NSButton!
    @IBOutlet var RevertButton: NSButton!
    @IBOutlet var ResetButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let goalTextTemp = defaults.string(forKey: "Goal")
        lapsedDate = defaults.integer(forKey: "Date")
        
        if goalTextTemp == nil {
            lapsedDate = 0
            
            GoalTextInput.isSelectable = true
            GoalTextInput.isEditable = true
            CheckButton.isEnabled = false
            RevertButton.isEnabled = false
            ResetButton.isEnabled = false
            GoalTextInput.stringValue = ""
            GoalDateField.stringValue = ""
        } else {
            goalText = goalTextTemp!
            
            GoalTextInput.isSelectable = false
            GoalTextInput.isEditable = false
            RevertButton.isEnabled = true
            ResetButton.isEnabled = true
            
            GoalTextInput.stringValue = goalText
            
            if lapsedDate < 10 {
                GoalDateField.stringValue = "0" + String(lapsedDate) + "/66"
            } else {
                GoalDateField.stringValue = String(lapsedDate) + "/66"
            }
        }
    }
    
    @IBAction func CheckButtonClicked(_ sender: Any) {
        if lapsedDate != 66 {
            lapsedDate += 1

            defaults.set(lapsedDate, forKey: "Date")
            
            if lapsedDate < 10 {
                GoalDateField.stringValue = "0" + String(lapsedDate) + "/66"
            } else {
                GoalDateField.stringValue = String(lapsedDate) + "/66"
            }
        }
    }
    
    @IBAction func RevertButtonClicked(_ sender: Any) {
        if lapsedDate != 0 {
            lapsedDate -= 1
            
            defaults.set(lapsedDate, forKey: "Date")
            
            if lapsedDate < 10 {
                GoalDateField.stringValue = "0" + String(lapsedDate) + "/66"
            } else {
                GoalDateField.stringValue = String(lapsedDate) + "/66"
            }
        }
    }
    
    @IBAction func GoalContentEntered(_ sender: Any) {
        GoalTextInput.isSelectable = false
        GoalTextInput.isEditable = false
        CheckButton.isEnabled = true
        RevertButton.isEnabled = true
        ResetButton.isEnabled = true
        
        lapsedDate = 0
        goalText = GoalTextInput.stringValue
        
        defaults.set(lapsedDate, forKey: "Date")
        defaults.set(goalText, forKey: "Goal")
        
        if lapsedDate < 10 {
            GoalDateField.stringValue = "0" + String(lapsedDate) + "/66"
        } else {
            GoalDateField.stringValue = String(lapsedDate) + "/66"
        }
    }
    
    @IBAction func ResetButtonClicked(_ sender: Any) {
        lapsedDate = 0
        defaults.set(lapsedDate, forKey: "Date")
        defaults.set(nil, forKey: "Goal")
        
        GoalTextInput.isSelectable = true
        GoalTextInput.isEditable = true
        CheckButton.isEnabled = false
        RevertButton.isEnabled = false
        ResetButton.isEnabled = false
        GoalTextInput.stringValue = ""
        GoalDateField.stringValue = ""
    }
    
}

extension MainViewController {
    // MARK: Storyboard instantiation
    static func freshController() -> MainViewController {
        //1.
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        //2.
        let identifier = NSStoryboard.SceneIdentifier("MainViewController")
        //3.
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? MainViewController else {
            fatalError("Why cant i find MainViewController? - Check Main.storyboard")
        }
        return viewcontroller
    }
}
