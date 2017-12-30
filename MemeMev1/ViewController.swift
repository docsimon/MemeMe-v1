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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
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

