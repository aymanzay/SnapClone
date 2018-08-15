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
    @IBOutlet weak var tempImageView: UIImageView!
    
    var didTakePhoto = Bool()
    
    var captureSession: AVCaptureSession?
    var stillImageOutput: AVCaptureStillImageOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func didPressTakePhoto() {
        
        if let videoConnection = stillImageOutput?.connection(with: AVMediaType.video) {
            videoConnection.videoOrientation = AVCaptureVideoOrientation.portrait
            stillImageOutput?.captureStillImageAsynchronously(from: videoConnection, completionHandler: { (sampleBuffer, error) in
                if error != nil {
                    return
                }
                
                if sampleBuffer != nil {
                    
                    var imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer!)
                    var dataProvider = CGDataProvider(data: imageData as! CFData)
                    var cgImageRef = CGImage(jpegDataProviderSource: dataProvider!, decode: nil, shouldInterpolate: true, intent: CGColorRenderingIntent.defaultIntent)
                    
                    var image = UIImage(cgImage: cgImageRef!, scale: 1.0, orientation: UIImageOrientation.right)
                    DispatchQueue.main.async {
                        self.tempImageView.image = image
                        self.tempImageView.isHidden = false
                        self.cameraView.isHidden = true
                    }
                    print("in didPressTakePhoto")
                    
                }
                
            })
        }
    }
    
    func didPressTakeAnother() {
        
        if didTakePhoto == true {
            tempImageView.isHidden = true
            cameraView.isHidden = false
            didTakePhoto = false
            print("in didPressTakeAnother :::::: TRUE")
        } else {
            captureSession?.startRunning()
            cameraView.isHidden = false
            didTakePhoto = true
            print("in didPressTakeAnother :::::: FALSE")
            didPressTakePhoto()
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("in touchesBegan")
        didPressTakeAnother()
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
                previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
                previewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                cameraView.layer.addSublayer(previewLayer!)
                
                captureSession?.startRunning()
            }
        }
        
    }

}
