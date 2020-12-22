//
//  ViewController.swift
//  SignalR_iO

//
//  Created by Saleh Mohammed  on 03/09/2020.
//  Copyright © 2020 Saleh Mohammed . All rights reserved.
//

import UIKit
import SwiftSignalRClient

class ViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var connectionBtn: UIButton!
    
    private var connected = false
    private var hubConnection: HubConnection!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func startConnectionBtnPressed(_ sender: Any) {
        if !connected {
            let url = URL(string: "http://localhost:5001/exchangeHub")
            
            hubConnection = HubConnectionBuilder(url: url!).withLogging(minLogLevel: .error).build()
            
            //Clients.Others.SendAsync("ReceiveNewMessage" + message);
            hubConnection.on(method: "ReceiveNewMessage", callback: { (message: String) in
                do {
                    self.handleMessage(message)
                } catch {
                    print(error)
                }
            })
                    
            hubConnection.start()
            self.connectionBtn.backgroundColor = UIColor.red
            self.connectionBtn.setTitle("Stop the connection", for: .normal)
            self.connected = true
        } else {
            hubConnection.stop()
            self.connectionBtn.backgroundColor = UIColor.blue
            self.connectionBtn.setTitle("Start the connection", for: .normal)
            self.connected = false
        }
    }
    
    private func handleMessage(_ message: String) {
        self.lbl.text = message
    }
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        if connected {
            hubConnection.send(method: "exchangeMessageFromServer", textField.text)
        }
    }
}
