//
//  ViewController.swift
//  Notificacoes
//
//  Created by Usuário Convidado on 11/10/17.
//  Copyright © 2017 Usuário Convidado. All rights reserved.
//

import UIKit
import UserNotifications



class ViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var tfMessage: UITextField!
    @IBOutlet weak var dpFireDate: UIDatePicker!
    @IBOutlet weak var lbMessage: UILabel!
    
    //MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onReceive(notification:)), name: NSNotification.Name(rawValue:"Received"), object: nil)
        
    }
    
    func onReceive(notification:Notification){
        if let message = notification.object as? String{
            lbMessage.text = message
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dpFireDate.minimumDate = Date()
    }
    // MARK: - IBActions
    @IBAction func fireNotification(_ sender: Any) {
        
        let content = UNMutableNotificationContent()
        content.title = "Lembrete"
        content.subtitle = "Vim lembrar-lhe de:"
        content.body = tfMessage.text!
        //content.sound = UNNotificationSound(named: "arquivo-de-som.caf")
        content.categoryIdentifier = "Lembrete"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        //let dateComponents = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute], from: dpFireDate.date)
        
        //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: "Reminder", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        
        
    }

    @IBAction func cancelNotifications(_ sender: UIButton) {
        
        //UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        UNUserNotificationCenter.current().getPendingNotificationRequests { (notifications:[UNNotificationRequest]) in
            for notification in notifications{
                if notification.identifier == "Reminder"{
                    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers:[notification.identifier])
            }
        }
        
    }
}
}

extension ViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

