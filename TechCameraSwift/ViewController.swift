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
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func takePhoto(){
        // ----- カメラを起動する
        let picker = UIImagePickerController()
        picker.sourceType = UIImagePickerControllerSourceType.Camera
        picker.delegate = self
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        cameraImageView.image = image                             // 撮影した画像をセットする
        
        // ----- 合成した画像を保存する
        UIGraphicsBeginImageContext(cameraImageView.bounds.size)
        cameraImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        UIImageWriteToSavedPhotosAlbum(UIGraphicsGetImageFromCurrentImageContext(), self, nil, nil)
        UIGraphicsEndImageContext()
        
        dismissViewControllerAnimated(true, completion: nil)    // アプリ画面へ戻る
    }
    
    
    @IBAction func savePhoto(){
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

