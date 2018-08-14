//
//  ViewTwoVC.swift
//  SnapClone
//
//  Created by Ayman Zeine on 8/14/18.
//  Copyright © 2018 Ayman Zeine. All rights reserved.
//

import UIKit
import AVFoundation

class ViewTwoVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var cameraView: UIView!
    
    var captureSession: AVCaptureSession?
    var stillImageOutput: AVCaptureStillImageOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        previewLayer?.frame = cameraView.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        captureSession = AVCaptureSession()
        //captureSession?.sessionPreset = AVCaptureSession.Preset(rawValue: AVAssetExportPreset1920x1080)
        captureSession?.sessionPreset = AVCaptureSession.Preset.high
        
        let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
        
        guard let input = try? AVCaptureDeviceInput(device: backCamera!) else { return }
        
        if (captureSession?.canAddInput(input))! {
            captureSession?.addInput(input)
            stillImageOutput = AVCaptureStillImageOutput()
            stillImageOutput?.outputSettings = [AVVideoCodecKey:AVVideoCodecType.jpeg]
            
            if (captureSession?.canAddOutput(stillImageOutput!))! {
                captureSession?.addOutput(stillImageOutput!)
                
                previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
                previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspect
                previewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                cameraView.layer.addSublayer(previewLayer!)
                
                captureSession?.startRunning()
            }
        }
        
    }

}
