import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MaterialApp(
    home: first(),
  ));
}

class first extends StatefulWidget {
  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {

  final ImagePicker _picker = ImagePicker();
  bool imgstatus = false;
  String img_path ="";

  permission()
  async {
    Map<Permission, PermissionStatus> statuses = await [
    Permission.camera,
        Permission.storage,
  ].request();
  print(statuses[Permission.camera]);
    var status = await Permission.camera.status;
    if (status.isDenied) {
      permission();


    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    permission();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 300,
            width: 300,
            child: imgstatus ? Image.file(File(img_path)) : Icon(Icons.camera)
          ),
          ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      title: Text("Select img..."),
                      children: [
                        ListTile(
                          title: Text("Camera"),
                          leading: Icon(Icons.camera_alt),
                          onTap: () async {
                            Navigator.pop(context);
                            final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
                            
                            if(photo != null)
                              {
                                img_path = photo.path;
                                imgstatus = true;
                              }
                            else
                              {
                                imgstatus=false;
                              }
                            setState(() {});

                          },
                        ),
                        ListTile(
                          title: Text("Gallery"),
                          leading: Icon(Icons.collections_outlined,),
                          onTap: () async {
                            Navigator.pop(context);
                            final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

                            if(image != null)
                            {
                              img_path = image.path;
                              imgstatus = true;
                            }
                            else
                            {
                              imgstatus=false;
                            }
                            setState(() {});
                          },
                        )
                      ],
                    );
                  },
                );
              },
              child: Text("Select"))
        ],
      ),
    );
  }
}
