import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart' as p;

class mainBody extends StatefulWidget {
  @override
  State<mainBody> createState() => _mainBodyState();
}

class _mainBodyState extends State<mainBody> {

  String newFolder ="";
  List files = [];

  Future<Directory> getDir(String fName) async{
    final dir = Directory((await getExternalStorageDirectory())!.path + '/$fName');
    return dir;
  }

  void listOfFiles() async {
    //var files1 = Directory("/storage/emulated/0/Android/data/com.hansyyyyy.doclocker/files/docLock").listSync();
    var storagePath = await getDir('docLock');

    setState(() {
      var files1 = storagePath.listSync();
      for(var f in files1){
        files.add(p.basename(f.path));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    listOfFiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(
            Icons.upload_file
        ),
        onPressed: () {
        },
      ),
      backgroundColor: const Color.fromARGB(255, 41, 40, 40),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 40, 150, 250),
        title: Text(
            'DocLock'
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () async{
               await showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text(
                        'New folder name',
                        style: TextStyle(
                          color: Colors.blueGrey,
                        ),
                      ),
                      content: TextField(
                        autofocus: true,
                        onChanged: (newName){
                          newFolder = newName;
                        },
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context,'Cancel'),
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            print(newFolder);
                            var storagePath = await getDir('docLock/$newFolder');
                            storagePath.create();
                            files = [];
                            listOfFiles();
                            Navigator.pop(context,'Create');
                          },
                          child: Text('Create'),
                        )
                      ],
                    )
                );
              },
              child: const Icon(
                Icons.create_new_folder_rounded,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: ListView.builder(
                    itemCount: files.length,
                    itemBuilder: (BuildContext context, int index){
                      //print(files[index].path);
                      //print('-------');
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Text(
                          files[index].toString(),
                          style : TextStyle(
                              color: Colors.white,
                            fontSize: 20,
                          ), ),
                      );
                    }),
              ))
          ],
        ),
      ),
    );
  }
}