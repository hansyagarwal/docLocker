import 'package:flutter/material.dart';

class mainBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    String newFolder ="";

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
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
              onTap: (){
                showDialog<String>(
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
                          onPressed: () {
                            print(newFolder);
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
    );
  }
}