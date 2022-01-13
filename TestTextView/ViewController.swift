//
//  ViewController.swift
//  TestTextView
//
//  Created by jianyi.chen on 2021/12/29.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var scrollView: NSScrollView!
    @IBOutlet var textView: NSTextView!
    @IBOutlet weak var pointString: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let string = try? String.init(contentsOfFile: Bundle.main.path(forResource: "4567", ofType: "txt")!)
        else {
            return
        }
        let aString:NSAttributedString = setStringAttributedString(string)
        textView.textStorage?.setAttributedString(aString)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func btn_Go(_ sender: NSButton) {
        print(pointString.stringValue)
        self.scrollToPointByCatalog(string: pointString.stringValue)
    }
    
    func scrollToPointByCatalog(string: String) {
        textView.isEditable = true
        let layout:NSLayoutManager = textView.layoutManager!
        let container = textView.textContainer
        //
        let cutString = textView.textStorage?.string.mySubString(to: string)
        let focusRingFrame:CGRect = layout.boundingRect(forGlyphRange: NSMakeRange(0, cutString!.count), in: container!)
        scrollView.documentView!.scroll(NSPoint(x: 0, y:focusRingFrame.height))
        textView.isEditable = false
    }
}

