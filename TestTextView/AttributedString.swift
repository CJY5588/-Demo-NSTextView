//
//  AttributedString.swift
//  iReader
//
//  Created by jianyi.chen on 2021/12/24.
//

import Cocoa

class AttributedString: NSObject {

}

func setStringAttributedString(_ string:String) -> NSAttributedString {
    
    let configuration = Configuration()
    let configPlist:NSDictionary = configuration.testDictionaryDataFromPlist(scriptPath: "FontPlist")
    let colorDic:NSDictionary = configPlist["fontColor"] as! NSDictionary
    let red:CGFloat   = colorDic["red"]   as! CGFloat
    let green:CGFloat = colorDic["green"] as! CGFloat
    let blue:CGFloat  = colorDic["blue"]  as! CGFloat
    let alpha:CGFloat = colorDic["alpha"] as! CGFloat
    let attributedString = string.matt
        .font(NSFont.init(name: configPlist["fontName"] as! String, size: configPlist["fontSize"] as! CGFloat)!)
        .color(NSColor.init(srgbRed: red , green: green , blue: blue , alpha:alpha))
        .kern(configPlist["fontKern"] as! CGFloat)
        .paraStyle(.left, lineSpacing: configPlist["lineSpacing"] as! CGFloat, paragraphSpacingBefore: configPlist["paragraphSpacingBefore"] as! CGFloat , lineBreakMode: .byCharWrapping)
    
    return attributedString

}

///属性链式编程实现
@objc public extension NSMutableAttributedString {
    
    func font(_ font: NSFont) -> Self {
        addAttributes([NSAttributedString.Key.font: font], range: NSMakeRange(0, self.length))
        return self
    }
    
    func color(_ color: NSColor) -> Self {
        addAttributes([NSAttributedString.Key.foregroundColor: color], range: NSMakeRange(0, self.length))
        return self
    }
    
    func bgColor(_ color: NSColor) -> Self {
        addAttributes([NSAttributedString.Key.backgroundColor: color], range: NSMakeRange(0, self.length))
        return self
    }
    
    func link(_ value: String) -> Self {
        return linkURL(URL(string: value)!)
    }
    
    func linkURL(_ value: URL) -> Self {
        addAttributes([NSAttributedString.Key.link: value], range: NSMakeRange(0, self.length))
        return self
    }
    //设置字体倾斜度，取值为float，正值右倾，负值左倾
    func oblique(_ value: CGFloat = 0.1) -> Self {
        addAttributes([NSAttributedString.Key.obliqueness: value], range: NSMakeRange(0, self.length))
        return self
    }
       
    //字符间距
    func kern(_ value: CGFloat) -> Self {
        addAttributes([.kern: value], range: NSMakeRange(0, self.length))
        return self
    }
    
    //设置字体的横向拉伸，取值为float，正值拉伸 ，负值压缩
    func expansion(_ value: CGFloat) -> Self {
        addAttributes([.expansion: value], range: NSMakeRange(0, self.length))
        return self
    }
    
    //设置下划线
    func underline(_ style: NSUnderlineStyle = .single, _ color: NSColor) -> Self {
        addAttributes([
            .underlineColor: color,
            .underlineStyle: style.rawValue
        ], range: NSMakeRange(0, self.length))
        return self
    }
    
    //设置删除线
    func strikethrough(_ style: NSUnderlineStyle = .single, _ color: NSColor) -> Self {
        addAttributes([
            .strikethroughColor: color,
            .strikethroughStyle: style.rawValue,
        ], range: NSMakeRange(0, self.length))
        return self
    }
    
    //设置删除线
    func stroke(_ color: NSColor, _ value: CGFloat = 0) -> Self {
        addAttributes([
            .strokeColor: color,
            .strokeWidth: value,
        ], range: NSMakeRange(0, self.length))
        return self
    }
    
    ///设置基准位置 (正上负下)
    func baseline(_ value: CGFloat) -> Self {
        addAttributes([.baselineOffset: value], range: NSMakeRange(0, self.length))
        return self
    }
    
    ///设置段落
    func paraStyle(_ alignment: NSTextAlignment,
                   lineSpacing: CGFloat = 0,
                   paragraphSpacingBefore: CGFloat = 0,
                   lineBreakMode: NSLineBreakMode = .byTruncatingTail) -> Self {
        let style = NSMutableParagraphStyle()
        style.alignment = alignment
        style.lineBreakMode = lineBreakMode
        style.lineSpacing = lineSpacing
        style.paragraphSpacingBefore = paragraphSpacingBefore
        addAttributes([.paragraphStyle: style], range: NSMakeRange(0, self.length))
        return self
    }
        
    ///设置段落
    func paragraphStyle(_ style: NSMutableParagraphStyle) -> Self {
        addAttributes([.paragraphStyle: style], range: NSMakeRange(0, self.length))
        return self
    }
}

public extension String {
    
    /// -> NSMutableAttributedString
    var matt: NSMutableAttributedString{
        return NSMutableAttributedString(string: self)
    }
    
    func mySubString(to:String) -> String {
        var subString = self
        subString = String(subString[..<subString.range(of: to)!.lowerBound])
        return subString
    }
    
}

@objc public extension NSAttributedString {
    
    /// -> NSMutableAttributedString
    var matt: NSMutableAttributedString{
        return NSMutableAttributedString(attributedString: self)
    }
    
}

@objc public extension NSMutableParagraphStyle {
    
    func lineSpacing(_ value: CGFloat) -> Self {
        self.lineSpacing = value
        return self
    }
    
    func paragraphSpacing(_ value: CGFloat) -> Self {
        self.paragraphSpacing = value
        return self
    }
    
    func alignment(_ value: NSTextAlignment) -> Self {
        self.alignment = value
        return self
    }
    
    func firstLineHeadIndent(_ value: CGFloat) -> Self {
        self.firstLineHeadIndent = value
        return self
    }
    
    func headIndent(_ value: CGFloat) -> Self {
        self.headIndent = value
        return self
    }
    
    func tailIndent(_ value: CGFloat) -> Self {
        self.tailIndent = value
        return self
    }
    
    func lineBreakMode(_ value: NSLineBreakMode) -> Self {
        self.lineBreakMode = value
        return self
    }
    
    func minimumLineHeight(_ value: CGFloat) -> Self {
        self.minimumLineHeight = value
        return self
    }
    
    func maximumLineHeight(_ value: CGFloat) -> Self {
        self.maximumLineHeight = value
        return self
    }
    
    func baseWritingDirection(_ value: NSWritingDirection) -> Self {
        self.baseWritingDirection = value
        return self
    }
    
    func lineHeightMultiple(_ value: CGFloat) -> Self {
        self.lineHeightMultiple = value
        return self
    }
    
    func paragraphSpacingBefore(_ value: CGFloat) -> Self {
        self.paragraphSpacingBefore = value
        return self
    }
    
    func hyphenationFactor(_ value: Float) -> Self {
        self.hyphenationFactor = value
        return self
    }
    
    func tabStops(_ value: [NSTextTab]) -> Self {
        self.tabStops = value
        return self
    }
    
    func defaultTabInterval(_ value: CGFloat) -> Self {
        self.defaultTabInterval = value
        return self
    }
    
    func allowsDefaultTighteningForTruncation(_ value: Bool) -> Self {
        self.allowsDefaultTighteningForTruncation = value
        return self
    }
    
    func lineBreakStrategy(_ value: NSParagraphStyle.LineBreakStrategy) -> Self {
        self.lineBreakStrategy = value
        return self
    }
        
    func addTabStopChain(_ value: NSTextTab) -> Self {
        self.addTabStop(value)
        return self
    }
    
    func removeTabStopChain(_ value: NSTextTab) -> Self {
        self.removeTabStop(value)
        return self
    }
    
    func setParagraphStyleChain(_ value: NSParagraphStyle) -> Self {
        self.setParagraphStyle(value)
        return self
    }
    
    
    
}

