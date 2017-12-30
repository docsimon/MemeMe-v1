//
//  ViewController.swift
//  MemeMev1
//
//  Created by doc on 30/12/2017.
//  Copyright © 2017 Simone Barbara. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    let imagePicker = UIImagePickerController()
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker.delegate = self
        self.cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        // this button will be enabled after saving the meme
        self.shareButton.isHidden = true
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
    
}

