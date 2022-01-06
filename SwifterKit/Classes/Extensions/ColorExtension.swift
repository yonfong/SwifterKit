//
//  Color+Extension.swift
//  SwifterKit
//
//  Created by sky on 2021/12/25.
//

#if os(iOS) || os(tvOS) || os(watchOS)
  import UIKit
  public typealias HexColor = UIColor
#else
  import Cocoa
  public typealias HexColor = NSColor
#endif

public extension HexColor {
    
    /// Default count limit: 100
    class var cacheCountLimit: Int {
        set {
            hexColorCache.countLimit = newValue
        }
        get {
            return hexColorCache.countLimit
        }
    }
    
    private class func hexToUInt64(_ hexString: String) -> UInt64 {
        var result: UInt64 = 0
        guard Scanner(string: hexString).scanHexInt64(&result) else {
            return 1
        }
        return result
    }
    
    private static var hexColorCache: NSCache<NSString, HexColor> = {
        let cache = NSCache<NSString, HexColor>()
        cache.countLimit = 100;
        return cache
    }()
    
    class func hexColor(_ hexString: String) -> HexColor {
        return self.hexColor(hexString: hexString, alpha: 1.0)
    }
    
    class func hexColor(hexString: String, alpha: CGFloat) -> HexColor {
        
        var resultHex = hexString
        
        if hexString.hasPrefix("#") {
            resultHex.removeFirst(1)
        }
        
        var resultAlpha: CGFloat = alpha
        if resultHex.count == 8 {
            resultAlpha = CGFloat(self.hexToUInt64("0x\(resultHex.prefix(2))")) / 255.0
            resultHex.removeFirst(2)
        }
        
        if resultHex.count != 6 {
#if DEBUG
            assert(false, "Hex: [\(hexString)] format is error!")
#endif
            return self.clear
        }
        
        // hex color from cache
        if let cacheColor = self.hexColorCache.object(forKey: resultHex as NSString) {
            return cacheColor.withAlphaComponent(resultAlpha)
        }
        
        // get green hex index
        let greenBegin = resultHex.index(resultHex.startIndex, offsetBy: 2)
        let greenEnd = resultHex.index(resultHex.startIndex, offsetBy: 3)
        
        let red = CGFloat(self.hexToUInt64("0x\(resultHex.prefix(2))")) / 255.0
        let green = CGFloat(self.hexToUInt64("0x\(resultHex[greenBegin...greenEnd])")) / 255.0
        let blue = CGFloat(self.hexToUInt64("0x\(resultHex.suffix(2))")) / 255.0
        
        var resultColor: HexColor
        
        #if os(iOS) || os(watchOS) || os(tvOS)
          resultColor = self.init(red:red, green:green, blue:blue, alpha:resultAlpha)
        #else
          resultColor = self.init(calibratedRed:red, green:green, blue:blue, alpha:resultAlpha)
        #endif
        
        self.hexColorCache.setObject(resultColor, forKey: hexString as NSString)
        
        return resultColor
    }
}




