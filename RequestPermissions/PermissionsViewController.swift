//
//  ViewController.swift
//  RequestPermissions
//
//  Created by Carl Goldsmith on 17/02/2016.
//  Copyright © 2016 carlgoldsmith. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - VARIABLES
    //MARK: Interface Elements
    var requestMessageLabel: UILabel!
    var requestImageView: UIImageView!
    var grantButton: UIButton!
    var delayButton: UIButton!
    
    //MARK: Setup Variables
    var requestMessageText: String?
    var requestImage: UIImage?
    var grantButtonText: String?
    var delayButtonText: String?
    
    var showImage = true
    
    /**
     The permission type that the view controller is requesting permission for. If this is not explicitly set, it will automatically return "LocationServicesAlways".
    */
    var requestingPermissionsFor: PermissionType {
        get {
            if _requestingPermissionsFor == nil {
                _requestingPermissionsFor = PermissionType.LocationServicesAlways
            }
            
            return _requestingPermissionsFor!
        }
        
        set {
            _requestingPermissionsFor = newValue
        }
    }
    private var _requestingPermissionsFor: PermissionType?

    
    //MARK: - FUNCTIONS
    //MARK: Initialisers
    /**
     Creates a new instance of PermissionsViewController with a specified PermissionType.
     - Parameter type: The type of permission being requested from the user.
    */
    convenience init(type: PermissionType) {
        self.init()
        self.requestingPermissionsFor = type
    }
    
    /**
     Creates a new instance of PermissionsViewController with a specified PermissionType and options for customising the message and image.
     - Parameter type: The type of permission being requested from the user.
     - Parameter requestMessage: This is the message that will be displayed to the user. *Unless this is the first time requesting permission, please avoid using this method and instead modify the strings file to change the default messages.*
     - Parameter grantButtonText: The text to be shown on the button that the user taps in order to grant permissions to the app.
     - Parameter image: The image displayed to the user. If this is left as nil, the default image will be requested. Use 'showImage: Bool' to decide whether or not an image should be displayed to the user.
     - Parameter delayButtonText: The button the user will tap if they don’t want to grant permission at this time. *If the user taps this button, the advantage is that the system still hasn’t presented its own permission request, making it easier for the user to grant permission in future.*
     */
    convenience init(type: PermissionType, requestMessage: String?, grantButtonText: String?, image: UIImage?, delayButtonText: String?) {
        self.init(type: type)
        
        self.requestMessageText = requestMessage
        self.requestImage = image
        self.grantButtonText = grantButtonText
        self.delayButtonText = delayButtonText
    }
    

    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateFields()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK: Interface Setup
    /**
     Will change the text labels if custom values have been set.
    */
    private func updateFields() {
        if self.isViewLoaded() {
            if self.requestMessageText != nil {
                self.requestMessageLabel.text = self.requestMessageText
            }
            
            if self.requestImage != nil {
                self.requestImageView.image = self.requestImage
            }
            
            if self.grantButtonText != nil {
                self.grantButton.titleLabel?.text = self.grantButtonText
            }
            
            if self.delayButtonText != nil {
                self.delayButton.titleLabel?.text = self.delayButtonText
            }
        }
    }
}

