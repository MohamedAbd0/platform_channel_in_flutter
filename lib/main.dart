import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _deviceModel = '';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => getDeviceModel());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("widget.title"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Device Model is',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              _deviceModel,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }

  getDeviceModel() async {
    await DeviceModel.getDeviceModel().then((value) {
      setState(() {
        _deviceModel = value;
      });
    });
  }
}

class DeviceModel {
  static const platform =
      MethodChannel('com.example.platform_channel_in_flutter/test');
  static Future<String> getDeviceModel() async {
    try {
      final result = await platform.invokeMethod('getDeviceModel');
      return result;
    } catch (e) {
      return '';
    }
  }
}
