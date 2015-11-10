//
//  ViewController.swift
//  TechCameraSwift
//
//  Created by Takemi Watanuki on 2015/11/06.
//  Copyright © 2015年 watakemi725. All rights reserved.
//

import UIKit

//写真保存用
import AssetsLibrary

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var cameraImageView : UIImageView!
    
    
    var firstImage : UIImage!
    
    var filter : CIFilter!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func takePhoto(){
        
        
        
//        let sourceType : UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.Camera
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){

            // ----- カメラを起動する
            let picker = UIImagePickerController()
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.delegate = self
            
            //カメラを正方形の形に開く
            picker.allowsEditing = true
            
            presentViewController(picker, animated: true, completion: nil)
            
        }
        else{
            print("error")
            
        }
        
        
        

    }
    


    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        
        cameraImageView.image = info[UIImagePickerControllerEditedImage] as? UIImage
    
        firstImage = cameraImageView.image
        
        dismissViewControllerAnimated(true, completion: nil)    // アプリ画面へ戻る
    }
    
    
    @IBAction func savePhoto(){
        
        let imageToSave = filter.outputImage!
        
        let softwareContext = CIContext(options:[kCIContextUseSoftwareRenderer: true])

        let cgimg = softwareContext.createCGImage(imageToSave, fromRect:imageToSave.extent)
        
        let library = ALAssetsLibrary()
        
        library.writeImageToSavedPhotosAlbum(cgimg,metadata:imageToSave.properties,completionBlock:nil)
        
    }

    
    
    @IBAction func sepiaFilter(){
        
        
        let ciImage : CIImage = CIImage(image:firstImage)!

        //let 
        filter = CIFilter(name: "CISepiaTone")!
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        filter.setValue(0.5, forKey: kCIInputIntensityKey)

        cameraImageView.image = UIImage(CIImage: filter.outputImage!)

    }
    
    @IBAction func colorFilter(){
        
        
        let ciImage : CIImage = CIImage(image:firstImage)!

        //let
        filter = CIFilter(name: "CIColorControls")!
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        filter.setValue(1.0, forKey: "inputSaturation")
        filter.setValue(0.5, forKey: "inputBrightness")
        filter.setValue(3.0, forKey: "inputContrast")
        
        cameraImageView.image = UIImage(CIImage: filter.outputImage!)
        
    }
    
    
    @IBAction func openAlbum(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            
            //カメラを正方形の形に開く
            picker.allowsEditing = true
            
            self.presentViewController(picker, animated: true, completion: nil)
        }
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

