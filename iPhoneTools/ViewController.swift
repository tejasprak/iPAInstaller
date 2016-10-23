//
//  ViewController.swift
//  iPhoneTools
//
//  Created by Tejas Prakash on 10/21/16.
//  Copyright © 2016 Tejas Prakash. All rights reserved.
//

import Cocoa
class ViewController: NSViewController {
    
    func dialogOKCancel(question: String, text: String) -> Bool {
        let myPopup: NSAlert = NSAlert()
        myPopup.messageText = question
        myPopup.informativeText = text
        myPopup.alertStyle = NSAlertStyle.warning
        myPopup.addButton(withTitle: "Yes")
        myPopup.addButton(withTitle: "No")
        return myPopup.runModal() == NSAlertFirstButtonReturn
    }
    func dialogYesCancel(question: String, text: String) -> Bool {
        let myPopup: NSAlert = NSAlert()
        myPopup.messageText = question
        myPopup.informativeText = text
        myPopup.alertStyle = NSAlertStyle.warning
        myPopup.addButton(withTitle: "I will")
        myPopup.addButton(withTitle: "I won't")
        return myPopup.runModal() == NSAlertFirstButtonReturn
    }
    func dialogOk(question: String, text: String) -> Bool {
        let myPopup: NSAlert = NSAlert()
        myPopup.messageText = question
        myPopup.informativeText = text
        myPopup.alertStyle = NSAlertStyle.warning
        myPopup.addButton(withTitle: "OK")
        
        return myPopup.runModal() == NSAlertFirstButtonReturn
    }
    func executeCommand(command: String, args: [String]) -> String {
        
        let task = Process()
        
        task.launchPath = command
        task.arguments = args
       
        let pipe = Pipe()
        task.standardOutput = pipe
        task.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output: String = NSString(data: data, encoding: String.Encoding.utf8.rawValue) as! String
        
        return output
        
    }
       func getEnvironmentVar(_ name: String) -> String? {
        guard let rawValue = getenv(name) else { return nil }
        return String(utf8String: rawValue)
    }

    
    func executeCommandnoArgs(command: String) -> String {
        
        let task = Process()
        
        task.launchPath = command
        
        
        let pipe = Pipe()
        task.standardOutput = pipe
        task.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output: String = NSString(data: data, encoding: String.Encoding.utf8.rawValue) as! String
        
        return output
        
    }
    @IBOutlet weak var connected: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("Fixing lockdownd...")
        var lol = "-R 777 /var/db/lockdown"
        let answer = dialogYesCancel(question: "Please install libraries if you haven't already", text: "Also make sure to enter the command at the bottom of the screen!.")
      
        //let commandOutput = executeCommand(command: "", args: ["chmod\(lol)"])
        //NSLog("Command output: \(commandOutput)")
        let fileManager = FileManager.default
        
        // Get current directory path
        
        let path = fileManager.currentDirectoryPath
        NSLog("\(path)/iPhoneTools.app/Contents/Resources/ideviceinstaller")
        
        var one  = "|"
        var two = "grep"
        var three = "-i"
        var four = "DeviceName"
        var five = "lol.txt"
        var six = ">"
        
        let commandOutput = executeCommand(command: "/bin/sh", args: ["-c", "/usr/local/bin/ideviceinfo | grep -i DeviceName"])
        NSLog("Command output: \(commandOutput)")
        if commandOutput == "" {
            connected.stringValue = "No device connected"
        } else {
       connected.stringValue = commandOutput + "connected"
        }
        
       // print(output!)
        // Do any additional setup after loading the view.
    }
    
   
    
    
    @IBOutlet weak var otaText: NSTextField!

    @IBAction func librariesPressed(_ sender: NSButton) {
        let answer = dialogOKCancel(question: "Do you have Homebrew installed?", text: "Choose your answer.")
        if answer == true {
            var mb = "install"
            var lib = "libimobiledevice"
            let commandOutput = executeCommand(command: "/usr/local/bin/brew", args: [mb, lib])
            NSLog(commandOutput)
        } else {
            let answer = dialogOk(question: "Don't have Homebrew installed?", text: "Install it by going to brew.sh and following instructions.")
        }
    }
    
    @IBAction func buttonPressed(_ sender: NSButton) {
        let fileManager = FileManager.default
        
        // Get current directory path
        
        let path = fileManager.currentDirectoryPath

        
        var lol = otaText.stringValue
        let commandOutput = executeCommand(command: "\(path)/iPhoneTools.app/Contents/Resources/ideviceinstaller", args: ["-i\(lol)"])
        NSLog("Command output: \(commandOutput)")
        //self.console.stringValue = commandOutput;
        
        /*if let output = shell(launchPath: "/usr/bin/local", arguments: ["", "ideviceinstaller"]) {
            print(output)
        }*/
    }
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

