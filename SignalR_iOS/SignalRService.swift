//
//  SignalRService.swift
//  SignalR_iOS
//
//  Created by Saleh Mohammed  on 03/09/2020.
//  Copyright © 2020 Saleh Mohammed . All rights reserved.
//

import Foundation
import SwiftSignalRClient

public class SignalRService {
    private var hubConnection: HubConnection
    
    public init(url: URL) {
        
        hubConnection = HubConnectionBuilder(url: url).withLogging(minLogLevel: .error).build()
//        if hubconnection.isHubConnected {
//
//        }
        hubConnection.on(method: "MessageReceived", callback: { (user: String, message: String) in
            do {
                self.handleMessage(message, from: user)
            } catch {
                print(error)
            }
        })
        
        hubConnection.start()
        
        
        
//        // Are we already connected to the hub?
//        if !isHubConnected {
//            hubConnection = HubConnectionBuilder(url: url).withLogging(minLogLevel: .error).build()
//            if let hub = hubConnection {
//                hub.delegate = self
//
//                // Set our callbacks for the messages we expect from the SignalR hub.
//                hub.on(method: "ProgressUpdate", callback: {args, typeConverter in
//                    if let data = try? typeConverter.convertFromWireType(obj: args[0], targetType: String.self) {
//                        self.onHubProgressUpdate(progress: data)
//                    }
//                })
//
//                // Start the hub connection.
//                hub.start()
//            }
//        }
    }
    
    private func handleMessage(_ message: String, from user: String) {
        // Do something with the message.
    }
}
