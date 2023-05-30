import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        // 1
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        
        // 2
        let deviceChannel = FlutterMethodChannel(name: "com.example.platform_channel_in_flutter/test",
                                                 binaryMessenger: controller.binaryMessenger)
        
        // 3
        prepareMethodHandler(deviceChannel: deviceChannel)
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func prepareMethodHandler(deviceChannel: FlutterMethodChannel) {
        
        // 4
        deviceChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            
            // 5
            if call.method == "getDeviceModel" {
                
                // 6
                self.receiveDeviceModel(result: result)
            }
            else {
                // 9
                result(FlutterMethodNotImplemented)
                return
            }
            
        })
    }
    
    private func receiveDeviceModel(result: FlutterResult) {
        // 7
        let deviceModel = UIDevice.current.model
        
        // 8
        result(deviceModel)
    }
}
