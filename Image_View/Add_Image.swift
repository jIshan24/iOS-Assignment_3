//
//  Add_Image.swift
//  Image_View
//
//  Created by user235623 on 11/16/23.
//

import UIKit

protocol ImageDelegate{
    
    func imgDidCorrectly(newImg : Images)
    
    func viewDidCancel()
}

class Add_Image: UIViewController {

    var delegate : ImageDelegate?
    
    
    
    @IBOutlet weak var imgName: UITextField!
    
    
    @IBOutlet weak var imgURL: UITextField!
    
    

    @IBOutlet weak var doneBtn: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let myColor = UIColor.black
        imgURL.layer.borderColor = myColor.cgColor
        imgURL.layer.borderWidth = 1.0
        imgURL.layer.cornerRadius = 10.0
        imgURL.layer.masksToBounds = true
        
        imgName.layer.borderColor = myColor.cgColor
        imgName.layer.borderWidth = 1.0
        imgName.layer.cornerRadius = 10.0
        imgName.layer.masksToBounds = true
    }
    
    
    @IBAction func saveBtn(_ sender: Any) {
        if let goodimgName = imgName.text {
            if let goodimgURL = imgURL.text {
                if !goodimgName.isEmpty && !goodimgURL.isEmpty {
                    let newImage = Images(imgName: goodimgName, imgURL: goodimgURL)
                    
                    delegate!.imgDidCorrectly(newImg: newImage)
                    
                }
                
            }
            
        }
        
    }
    
    @IBAction func doneBtn(_ sender: Any) {
        dismiss(animated: true , completion: nil)
    }
    
    
    @IBAction func cancelBtn(_ sender: Any) {
        delegate!.viewDidCancel()
        dismiss(animated: true , completion: nil)
    }
    
}
