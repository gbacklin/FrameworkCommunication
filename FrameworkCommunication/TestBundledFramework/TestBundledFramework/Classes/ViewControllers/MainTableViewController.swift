//
//  MainTableViewController.swift
//  TestBundledFramework
//
//  Created by Gene Backlin on 10/30/17.
//  Copyright © 2017 Gene Backlin. All rights reserved.
//

import UIKit
import BundledFramework

class MainTableViewController: UITableViewController {
    let objects: [String] = viewControllerNames

    override func viewDidLoad() {
        super.viewDidLoad()

        registerForNotifications()
        tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        deregisterForNotifications()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Configure the cell...
        cell.separatorInset = UIEdgeInsets.zero
        cell.imageView?.frame = CGRect(x: 10, y: 0, width: 40, height: 40)
        cell.imageView?.contentMode = UIViewContentMode.scaleAspectFit

        cell.imageView?.image = BundledFramework.image(forIndex: indexPath.row)
        cell.textLabel?.text = objects[indexPath.row]
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let segueName = "Show\(objects[indexPath.row])"
        self.performSegue(withIdentifier: segueName, sender: indexPath)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath: IndexPath = sender as! IndexPath
        let messageToSend = "Segue \(String(describing: segue.identifier!)) was selected from Section: \(indexPath.section) Row: \(indexPath.row)"

        if segue.identifier == "ShowRed" {
            let controller: RedViewController = segue.destination as! RedViewController
            controller.receivedText = messageToSend
        } else if segue.identifier == "ShowBlue" {
            let controller: BlueViewController = segue.destination as! BlueViewController
            controller.receivedText = messageToSend
        }
    }
    
    // MARK: - Notification selector processing
    
    @objc func didReceiveResponseFromFramework(_ notification: Notification) {
        let userInfo = notification.userInfo
        
        let image: UIImage = userInfo!["image"] as! UIImage
        let text: String = userInfo!["text"] as! String
        let alertMessage = UIAlertController(title: nil, message: text, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        action.setValue(image.withRenderingMode(.alwaysOriginal), forKey: "image")
        alertMessage.addAction(action)
        
        self.navigationController?.popViewController(animated: true)
        self.present(alertMessage, animated: true, completion: nil)
    }

    // MARK: - Notification registration/deregistration
    
    func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(type(of:self).didReceiveResponseFromFramework(_:)), name: NSNotification.Name(rawValue: Notifications.BFRedVCDidSendResponse), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(type(of:self).didReceiveResponseFromFramework(_:)), name: NSNotification.Name(rawValue: Notifications.BFBlueVCDidSendResponse), object: nil)
    }

    func deregisterForNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
}
