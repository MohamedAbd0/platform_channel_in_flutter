package com.example.platform_channel_in_flutter

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import android.content.Context
import android.content.res.Configuration
import android.telephony.TelephonyManager

class MainActivity: FlutterActivity() {

    private val CHANNEL = "com.example.platform_channel_in_flutter/test"
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
                .setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
                    if (call.method == "getDeviceModel") {
                        val deviceModel = getDeviceType(context)
                        result.success(deviceModel)
                    } else {
                        result.notImplemented()
                    }
                }
    }


    
    private fun getDeviceType(context: Context): String {
        val telephonyManager = context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager

        // Check if the device has telephony features
        val isPhone = telephonyManager.phoneType != TelephonyManager.PHONE_TYPE_NONE

        // Check the screen size to determine if it's a tablet
        val isTablet = context.resources.configuration.screenLayout and Configuration.SCREENLAYOUT_SIZE_MASK >= Configuration.SCREENLAYOUT_SIZE_LARGE

        return if (isTablet) {
            "Tablet"
        } else if (isPhone) {
            "Phone"
        } else {
            "Unknown"
        }
    }


}
