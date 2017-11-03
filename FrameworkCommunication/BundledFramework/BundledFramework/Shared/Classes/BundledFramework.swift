//
//  BundledFramework.swift
//  BundledFramework
//
//  Created by Gene Backlin on 10/30/17.
//  Copyright © 2017 Gene Backlin. All rights reserved.
//

import UIKit

public struct Notifications {
    public static let BFRedVCDidSendResponse = "BFRedVCDidSendResponse"
    public static let BFBlueVCDidSendResponse = "BFBlueVCDidSendResponse"
}

public var viewControllerNames: [String] = ["Red", "Blue"]
public var test: String = "test"

public class BundledFramework: NSObject {

    class func postNotification(notificationName: String, userInfo: [String : AnyObject]) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationName), object: nil, userInfo: userInfo)
    }
    
    public class func image(forIndex: Int) -> UIImage? {
        let imageName = "\(viewControllerNames[forIndex].lowercased())Image"
        let image = UIImage(named: imageName, in: Bundle(for: self), compatibleWith: nil)
        
        return image
    }

    public class func image(forName: String) -> UIImage? {
        var image: UIImage?
        for imageName in viewControllerNames {
            let name = "\(imageName.lowercased())Image"
            if name == forName {
                image = UIImage(named: name, in: Bundle(for: self), compatibleWith: nil)
                break
            }
        }
        
        return image
    }
}


