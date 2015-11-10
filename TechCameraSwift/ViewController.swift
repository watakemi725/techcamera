//
//  ViewController.swift
//  TechCameraSwift
//
//  Created by Takemi Watanuki on 2015/11/06.
//  Copyright © 2015年 watakemi725. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var cameraImageView : UIImageView!
    
    var firstImage : UIImage!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func takePhoto(){
        // ----- カメラを起動する
        let picker = UIImagePickerController()
        picker.sourceType = UIImagePickerControllerSourceType.Camera
        picker.delegate = self
        
        //カメラを正方形の形に開く
        picker.allowsEditing = true
        
        presentViewController(picker, animated: true, completion: nil)
    }
    
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
//        cameraImageView.image = image
//        

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        cameraImageView.image = info[UIImagePickerControllerEditedImage] as? UIImage
    
        firstImage = cameraImageView.image
        
        // 撮影した画像をセットする
        //filteredImage = image
        
        
        // ----- 合成した画像を保存する
//        UIGraphicsBeginImageContext(cameraImageView.bounds.size)
//        cameraImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
//        UIImageWriteToSavedPhotosAlbum(UIGraphicsGetImageFromCurrentImageContext(), self, nil, nil)
//        UIGraphicsEndImageContext()
        
        dismissViewControllerAnimated(true, completion: nil)    // アプリ画面へ戻る
    }
    
    
    @IBAction func savePhoto(){
        UIImageWriteToSavedPhotosAlbum(cameraImageView.image!, self, "image:didFinishSavingWithError:contextInfo:", nil)
    }
    
    //保存処理のイベント
    func image(image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutablePointer<Void>) {
        print("保存できた")
        if error != nil {
            print("保存できなかぅた")
            //エラーの時
        }
    }
    
    
    @IBAction func sepiaFilter(){
        
        
//        let ciImage : CIImage = CIImage(image:cameraImageView.image!)!
        let ciImage : CIImage = CIImage(image:firstImage)!

        let filter = CIFilter(name: "CISepiaTone")!
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        filter.setValue(0.5, forKey: kCIInputIntensityKey)

        cameraImageView.image = UIImage(CIImage: filter.outputImage!)

    }
    
    @IBAction func colorFilter(){
        
        
//        let ciImage : CIImage = CIImage(image:cameraImageView.image!)!
        let ciImage : CIImage = CIImage(image:firstImage)!

        let filter = CIFilter(name: "CIColorControls")!
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        filter.setValue(1.0, forKey: "inputSaturation")
        filter.setValue(0.5, forKey: "inputBrightness")
        filter.setValue(3.0, forKey: "inputContrast")
        
        cameraImageView.image = UIImage(CIImage: filter.outputImage!)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

