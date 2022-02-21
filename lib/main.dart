import 'dart:io';
import 'package:flutter/material.dart';
import 'mainBody.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    checkSetup();
  }

  void checkSetup() async{
    print('hello');
    final prefs = await SharedPreferences.getInstance();
    final String? checkStartup = prefs.getString('firstTime');
    if(checkStartup == null){
      await prefs.setString('firstTime', 'yes');
      print('opening for first time');
      var path = await createFolder('docLock');
      print(path);
    } else {
      print('no');
    }
  }

  Future<String> createFolder(String fName) async {
    final dir = Directory((await getExternalStorageDirectory())!.path + '/$fName');
    var status = await Permission.storage.status;
    if(!status.isGranted){
      await Permission.storage.request();
    }
    if(await dir.exists()){
      return dir.path;
    } else {
      dir.create();
      return dir.path;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: mainBody(),
    );
  }
}
