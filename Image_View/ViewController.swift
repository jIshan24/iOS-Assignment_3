//
//  ViewController.swift
//  Image_View
//
//  Created by user235623 on 11/16/23.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, ImageDelegate {
    
    @IBOutlet weak var imgView: UIImageView!
    
    
    @IBOutlet weak var imgPicker: UIPickerView!
    
    var imgTitle = (UIApplication.shared.delegate as! AppDelegate).imgList

    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgPicker.delegate = self
        imgPicker.dataSource = self
        imgPicker.reloadAllComponents()
    
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        	return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imgTitle.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return imgTitle[row].imgName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selected = imgTitle[row]
        
        let imgURL = selected.imgURL
        
        fetchImg(from: imgURL) {
            img in
                if let imgSet = img {
                        DispatchQueue.main.async {
                                self.imgView.image = UIImage(data: imgSet)
                        }
                }
        }
}
    
    func fetchImg(from urlString: String, completionHandler: @escaping (Data?) -> Void) {
        guard let imageURL = URL(string: urlString) else {
            completionHandler(nil)
            return
        }
        let dataTask = URLSession.shared.dataTask(with: imageURL) { imageData, _, error in
            if let error = error {
                print("Error fetching image data: \(error.localizedDescription)")
                completionHandler(nil)
                return
            }
            completionHandler(imageData)
        }

        dataTask.resume()
    }


    func imgDidCorrectly(newImg: Images) {
        
        imgTitle.append(newImg)
        imgPicker.reloadAllComponents()
    }
    func viewDidCancel() {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        var des = segue.destination as! Add_Image
        des.delegate = self
    }

}

