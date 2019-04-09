import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(new PhotoApp());
}

class PhotoApp extends StatefulWidget {
  
  @override
  _PhotoAppState createState() => _PhotoAppState();
  
}

class _PhotoAppState extends State<PhotoApp> {
  // initial var image
  File image;

  picker() async {
    print('Picker is called');
    File img = await ImagePicker.pickImage(source: ImageSource.camera);
    if (img != null) {
      
      setState(() {
        // Do add something later
        image = img;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('First Responder Photo App'),
        ),
        body: Container(
          child: Center(
            child: image == null
              ? Text('No Image Selected')
              : Image.file(image),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: picker,
          child: Icon(Icons.camera_alt),
        ),
      ),

    );
  }

}