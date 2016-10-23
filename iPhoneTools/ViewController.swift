//
//  ViewController.swift
//  iPhoneTools
//
//  Created by Tejas Prakash on 10/21/16.
//  Copyright © 2016 Tejas Prakash. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

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
    func shell(launchPath: String, arguments: [String] = []) -> NSString? {
        
        let task = Process()
        task.launchPath = launchPath
        task.arguments = arguments
        
        let pipe = Pipe()
        task.standardOutput = pipe
        task.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        
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
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("Fixing lockdownd...")
        var lol = "-R 777 /var/db/lockdown"
        let commandOutput = executeCommand(command: "/usr/bin/sudo", args: ["chmod\(lol)"])
        NSLog("Command output: \(commandOutput)")
        let fileManager = FileManager.default
        
        // Get current directory path
        
        let path = fileManager.currentDirectoryPath
        NSLog("\(path)/iPhoneTools.app/Contents/Resources/ideviceinstaller")
        
        // Do any additional setup after loading the view.
    }
    
   
    
    
    @IBOutlet weak var otaText: NSTextField!

    @IBAction func librariesPressed(_ sender: NSButton) {
        var ll = "/usr/local/bin"
        let commandOutput = executeCommand(command: "/bin/cp", args: ["ideviceinstaller\(ll)"])
        NSLog(commandOutput)
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

