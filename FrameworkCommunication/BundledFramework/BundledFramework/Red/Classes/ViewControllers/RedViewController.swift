//
//  RedViewController.swift
//  BundledFramework
//
//  Created by Gene Backlin on 10/30/17.
//  Copyright © 2017 Gene Backlin. All rights reserved.
//

import UIKit

public class RedViewController: UIViewController {
    @IBOutlet weak var receivedTextLabel: UILabel!
    @IBOutlet weak var sendingTextField: UITextField!
    @IBOutlet weak var colorImageView: UIImageView!

    public var receivedText: String?

    override public func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        receivedTextLabel.text = receivedText!
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func send(_ sender: UIButton) {
        let image = colorImageView!.image!.resizedImage(newSize: CGSize(width: 40, height: 40))
        var notificationObject: [String : AnyObject] = [String : AnyObject]()
        notificationObject["text"] = sendingTextField.text as AnyObject
        notificationObject["image"] = image as AnyObject
        
        BundledFramework.postNotification(notificationName: Notifications.BFBlueVCDidSendResponse, userInfo: notificationObject)
    }

}
