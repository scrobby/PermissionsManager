//
//  PermissionsManager.swift
//  RequestPermissions
//
//  Created by Carl Goldsmith on 17/02/2016.
//  Copyright © 2016 carlgoldsmith. All rights reserved.
//

import Foundation
import CoreLocation

enum PermissionType {
    case LocationServicesAlways
    case LocationServicesWhenInUse
    case PushNotifications
    case PhotosAccess
    case BackgroundActivity
}

struct PermissionDetails {
    let hasPermission: Bool
    let alreadyRequested: Bool?
    let permissionRestricted: Bool?
}

protocol PermissionsManagerDelegate {
    func permissionsManagerFinishedRequestWithResult(result: PermissionDetails, type: PermissionType)
}

class PermissionsManager: NSObject, CLLocationManagerDelegate {
    //Variables related to location
    private var _locationManager: CLLocationManager?
    var locationManager: CLLocationManager {
        if _locationManager == nil {
            _locationManager = CLLocationManager()
            _locationManager?.delegate = self
        }
        
        return _locationManager!
    }
    
    
    //MARK - Checking current permissions
    class func hasPermission(type: PermissionType) -> PermissionDetails {
        //Perform the check for location services
        if type == .LocationServicesAlways || type == .LocationServicesWhenInUse {
            switch CLLocationManager.authorizationStatus() {
            case .AuthorizedAlways:
                //If the app has permission to always access location, this is counted as having permission, even in the case of LocationServicesWhenInUse
                return PermissionDetails(hasPermission: true, alreadyRequested: true, permissionRestricted: false)
                
            case .AuthorizedWhenInUse:
                if type == .LocationServicesWhenInUse {
                    return PermissionDetails(hasPermission: true, alreadyRequested: true, permissionRestricted: false)
                } else {
                    return PermissionDetails(hasPermission: false, alreadyRequested: true, permissionRestricted: false)
                }
                
            case .NotDetermined:
                return PermissionDetails(hasPermission: false, alreadyRequested: false, permissionRestricted: nil)
                
            case .Denied:
                return PermissionDetails(hasPermission: false, alreadyRequested: true, permissionRestricted: false)
                
            case .Restricted:
                return PermissionDetails(hasPermission: false, alreadyRequested: true, permissionRestricted: true)
            }
        }
        
        return PermissionDetails(hasPermission: false, alreadyRequested: nil, permissionRestricted: nil)
    }
    
    
    //MARK: - Make Request for Permissions
    func makePermissionRequest(type: PermissionType) {
        switch type {
        case .LocationServicesAlways:
            self.locationManager.requestAlwaysAuthorization()
            break
            
        case .LocationServicesWhenInUse:
            self.locationManager.requestWhenInUseAuthorization()
            break
            
        default:
            break
        }
    }
    
    
    //MARK: Location Manager Delegate
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedAlways {
            //we have permission
        } else if status == .AuthorizedWhenInUse {
            //we have permission
        } else if status == .Restricted {
            //user may need to ask for restrictions to be lifted
            print("Restricted")
        } else if status == .Denied {
            //user has rejected the request
            print("Rejected")
        } else {
            //permission may not have properly been sought
        }
    }
}