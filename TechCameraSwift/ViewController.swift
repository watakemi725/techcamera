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
    
    var originalImage : UIImage!
    
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
            
            //カメラを自由な形に開きたいとき(今回は正方形)
            picker.allowsEditing = true
            
            presentViewController(picker, animated: true, completion: nil)
            
        }
        else{
            print("error")
            
        }
        
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        
        cameraImageView.image = info[UIImagePickerControllerEditedImage] as? UIImage
        
        //あとから追加
        originalImage = cameraImageView.image
        
        dismissViewControllerAnimated(true, completion: nil)    // アプリ画面へ 戻る
    }
    
    
    @IBAction func savePhoto(){
        
        //保存する加工した画像を取得して保存
        let imageToSave = filter.outputImage!
        let softwareContext = CIContext(options:[kCIContextUseSoftwareRenderer: true])
        let cgimg = softwareContext.createCGImage(imageToSave, fromRect:imageToSave.extent)
        let library = ALAssetsLibrary()
        library.writeImageToSavedPhotosAlbum(cgimg,metadata:imageToSave.properties,completionBlock:nil)
        
    }
    
    
    
    @IBAction func sepiaFilter(){
        
        
        let ciImage : CIImage = CIImage(image:originalImage)!
        
        //let
        filter = CIFilter(name: "CISepiaTone")!
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        filter.setValue(0.5, forKey: kCIInputIntensityKey)
        
        cameraImageView.image = UIImage(CIImage: filter.outputImage!)
        
    }
    
    @IBAction func colorFilter(){
        
        //加工したい画像を用意する
        let filterImage : CIImage = CIImage(image:originalImage)!
        
        //加工フィルターの準備を行うよ、今回は"色調節フィルター"
        filter = CIFilter(name: "CIColorControls")!
        filter.setValue(filterImage, forKey: kCIInputImageKey)
        filter.setValue(1.0, forKey: "inputSaturation")
        filter.setValue(0.5, forKey: "inputBrightness")
        filter.setValue(3.0, forKey: "inputContrast")
        
        //加工した画像を表示させよう
        cameraImageView.image = UIImage(CIImage: filter.outputImage!)
        
    }
    
    
    @IBAction func openAlbum(){
        
        // カメラロールが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            
            //カメラを自由な形に開きたいとき(今回は正方形)
            picker.allowsEditing = true
            
            //アプリ画面へ戻る
            self.presentViewController(picker, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

