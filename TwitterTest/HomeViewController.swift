//
//  ProfileViewController.swift
//  TwitterTest
//
//  Created by chander bhushan on 17/03/19.
//  Copyright © 2019 Educational. All rights reserved.
//

import UIKit
import DropDown
import TwitterKit
import MobileCoreServices
class HomeViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    //MARK: - OUTLETS
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    // MARK:- INSTANCE VARIBALES
    
    
    //MARK: - LIFE CYCLE CALLS
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self,
                                                                 action: #selector(openOverFlowMenu))
        userIdLabel.text = UserDefaults.standard.string(forKey: "userId")
        userNameLabel.text = UserDefaults.standard.string(forKey: "userName")
        if let email = UserDefaults.standard.string(forKey: "email") {
            emailLabel.text = email
        }else {
             emailLabel.text = ""
        }
    }
    
    // MARK: - ACTIONS
    
    @IBAction func logoutClicked(_ sender: Any) {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
        
        let store = TWTRTwitter.sharedInstance().sessionStore
        if let userID = store.session()?.userID {
            store.logOutUserID(userID)
        }
        
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        self.present(loginVC!, animated: true, completion: nil)

    }
    
    // MARK: - helper methods
     @objc public func openOverFlowMenu(){
        let dropDown = DropDown()
        dropDown.anchorView = self.navigationItem.rightBarButtonItem
        dropDown.dataSource = ["Link", "Photo", "Video"]
        dropDown.width = 200
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            switch index {
            case 0:
                self.shareLink()
            case 1:
                self.openImageLibrary()
            case 2:
                self.openVideoLibrary()
            default:
                break;
            }
        }
        
        dropDown.show()
    }
    
    
    func shareLink(){
        let composer = TWTRComposer()
        composer.setURL(URL(string: "www.google.co.in")!)
        composer.setText("This is my dummy text!")
        composer.show(from: self) { (result) in
            if result == TWTRComposerResult.cancelled{
                print("tweet is canceled by user")
            }else {
                print(result)
                print("tweet successfully")
            }
        }
    }
    
    func openImageLibrary(){
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = [kUTTypeImage as! String]
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    func openVideoLibrary(){
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = [kUTTypeMovie as! String]
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let composer = TWTRComposerViewController(initialText: "image", image: originalImage as! UIImage, videoURL: nil)
            composer.delegate = self
            self.present(composer, animated: true, completion: nil)
        }else if let video = info[UIImagePickerController.InfoKey.mediaURL] {
            let composer = TWTRComposerViewController(initialText: "video", image: nil, videoURL: video as! URL)
            composer.delegate = self
            self.present(composer, animated: true, completion: nil)
        }
        
    }
    
}


extension HomeViewController : TWTRComposerViewControllerDelegate {
    func composerDidSucceed(_ controller: TWTRComposerViewController, with tweet: TWTRTweet) {
        print("success")
    }
    
    func composerDidFail(_ controller: TWTRComposerViewController, withError error: Error) {
        
    }
    
    func composerDidCancel(_ controller: TWTRComposerViewController) {
        
    }
}
