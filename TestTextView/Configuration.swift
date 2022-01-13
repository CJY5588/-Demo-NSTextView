//
//  Configuration.swift
//  iReader
//
//  Created by jianyi.chen on 2021/12/22.
//

import Cocoa

class Configuration: NSObject {

    func testArrayDataFromPlist(scriptPath:String) -> NSArray {
        let testData:NSArray = NSArray(contentsOfFile: Bundle.main.path(forResource: scriptPath, ofType: "plist")!)!
        return testData
    }
    
    func testDictionaryDataFromPlist(scriptPath:String) -> NSDictionary {
        let testData:NSDictionary = NSDictionary(contentsOfFile: Bundle.main.path(forResource: scriptPath, ofType: "plist")!)!
        return testData
    }
    
    func updateDictionaryDataPlist(scriptPath:String, data:NSDictionary) {
       // let testData:NSDictionary = NSDictionary(contentsOfFile: Bundle.main.path(forResource: scriptPath, ofType: "plist")!)!
        data.write(toFile: Bundle.main.path(forResource: scriptPath, ofType: "plist")!, atomically: true)
        //NSArray(array: testData).write(toFile: Bundle.main.path(forResource: scriptPath, ofType: "plist")!, atomically: true)
    }
}
