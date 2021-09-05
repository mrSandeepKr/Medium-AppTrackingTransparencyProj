//
//  ViewController.swift
//  AppTrackingTransperancyProj
//
//  Created by Sandeep Kumar on 05/09/21.
//

import UIKit
import AppTrackingTransparency
import AdSupport

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpBackground()
        requestAppTracking()
        print(getTrackingIdentifier())
    }
}

extension ViewController {
    func getTrackingIdentifier() -> UUID? {
        if(self.isTrackingAccessAvailable())
        {
            return ASIdentifierManager.shared().advertisingIdentifier
        }
        return nil
    }
    
    func isTrackingAccessAvailable() -> Bool {
        switch ATTrackingManager.trackingAuthorizationStatus {
            case .authorized:
                return true
            case .notDetermined,.restricted,.denied:
                return false
            @unknown default:
                return false
        }
    }
    
    func requestAppTracking() {
        ATTrackingManager.requestTrackingAuthorization { status in
            switch status {
            case .authorized:
                print("Log: ATTrackingManager request successful")
            case .denied:
                print("Log: Denied: Tracking dialog was shown and user didn't allow tracking")
            case .notDetermined:
                //This is the value when
                print("Not determined")
            case .restricted:
                print("Log: Restricted Tracking dialog was shown and user didn't allow tracking")
                break
            @unknown default:
                //used to take care of future unknown cases
                break
            }
        }
    }
}

extension ViewController {
    private func setUpBackground() {
        UIGraphicsBeginImageContext(self.view.frame.size)
        guard let image = UIImage.init(named: "back")
        else {
            return
        }
        image.draw(in: view.bounds)
        guard let imagefinal = UIGraphicsGetImageFromCurrentImageContext()
        else {
            return
        }
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor =  UIColor.init(patternImage: imagefinal)
    }
}
