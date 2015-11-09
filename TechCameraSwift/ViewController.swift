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
    
    var filteredImage : UIImage!
    

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
    
        filteredImage = cameraImageView.image
        
        // 撮影した画像をセットする
        //filteredImage = image
        
        
        // ----- 合成した画像を保存する
        UIGraphicsBeginImageContext(cameraImageView.bounds.size)
        cameraImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        UIImageWriteToSavedPhotosAlbum(UIGraphicsGetImageFromCurrentImageContext(), self, nil, nil)
        UIGraphicsEndImageContext()
        
        dismissViewControllerAnimated(true, completion: nil)    // アプリ画面へ戻る
    }
    
    
    @IBAction func savePhoto(){
        UIImageWriteToSavedPhotosAlbum(cameraImageView.image!, self, "image:didFinishSavingWithError:contextInfo:", nil)
    }
    
    //保存処理のイベント
    func image(image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutablePointer<Void>) {
        if error != nil {
            //エラーの時
        }
    }
    
    
    @IBAction func sepiaFilter(){
        // image が 元画像のUIImage
        let ciImage:CIImage = CIImage(image:filteredImage)!
        let ciFilter:CIFilter = CIFilter(name: "CISepiaTone")!
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        ciFilter.setValue(0.8, forKey: "inputIntensity")
        let ciContext:CIContext = CIContext(options: nil)
        let cgimg:CGImageRef = ciContext.createCGImage(ciFilter.outputImage!, fromRect:ciFilter.outputImage!.extent)
        
        //image2に加工後のUIImage
        let image2:UIImage = UIImage(CGImage: cgimg)//, scale: 1.0, orientation:UIImageOrientation.Right)//UIImageOrientation.up
        
        cameraImageView.image = image2
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

