//
//  ViewController.swift
//  MemeMev1
//
//  Created by doc on 30/12/2017.
//  Copyright © 2017 Simone Barbara. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    let imagePicker = UIImagePickerController()
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // subscribe to notifications
        subscribeToKeyboardNotifications()
        // set the delegates
        self.imagePicker.delegate = self
        self.topTextField.delegate = self
        self.bottomTextField.delegate = self
        self.cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        // this button will be enabled after saving the meme
        self.shareButton.isHidden = true
        self.setTextFieldAttributes()
    }
    
    func setTextFieldAttributes(){
        self.topTextField.text = "TOP"
        self.bottomTextField.text = "BOTTOM"
        let memeTextAttributes:[String:Any] = [
            NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
            NSAttributedStringKey.foregroundColor.rawValue:UIColor.white,
            NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedStringKey.strokeWidth.rawValue: -2.0]
        self.topTextField.defaultTextAttributes = memeTextAttributes
        self.bottomTextField.defaultTextAttributes = memeTextAttributes
        self.topTextField.textAlignment = .center
        self.bottomTextField.textAlignment = .center
    }
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        // Move the view only if the bootm textfield is the one that
        // triggers the keyboard
        if self.bottomTextField.isFirstResponder{
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    @IBAction func shareMeme(_ sender: Any) {
    }
    
    @IBAction func pickImage(_ sender: Any) {
        if (sender as! UIButton).tag == 0 {
            self.imagePicker.sourceType = .photoLibrary
        }else {
            self.imagePicker.sourceType = .camera
        }
        present(self.imagePicker, animated: true, completion: nil)
    }
}

// Protocol implementation
extension ViewController {
    
    // Picker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.imageView.image = chosenImage
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // TextFields
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // If the user leaves the textfield empty, it will be filled with the
    // default value
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField.text?.isEmpty)!{
            textField.text = (textField.tag == 0 ? "TOP" : "BOTTOM")
        }
    }
}

