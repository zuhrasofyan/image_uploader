import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dio/dio.dart';

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
  var pos;
  bool uploaded = false;
  var dio = Dio();
  
  picker() async {
    dio.options.baseUrl = "https://bappeda.bandaacehkota.go.id/service/hackerearth";
    print('Picker is called');
    File img = await ImagePicker.pickImage(source: ImageSource.camera);
    if (img != null) {
      Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      setState(() {
        // Do add something later
        image = img;
        pos = position;
      });

      FormData formData = new FormData.from({
        "image": UploadFileInfo(image, 'image.jpg')
      });
      Response response;
      response = await dio.post('/image-upload?lat='+pos.latitude.toString()+'&lon='+pos.longitude.toString(), data: formData);
      print(response.data);
      setState(() {
        uploaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (uploaded == false) {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('First Responder Photo App'),
          ),
          body: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  image == null
                    ? Text('No Image Selected. \nPress button on the right bottom to take a photo \nand automatically upload it to the server', textAlign: TextAlign.center,)
                    : Image.file(image),
                    
                ],
              )
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: picker,
            child: Icon(Icons.camera_alt),
          ),
        ),

      );
    } else {  // uploaded true
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('First Responder Photo App'),
          ),
          body: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                    Container(
                      child: Image.file(image),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Icon(
                            Icons.info,
                          ),
                        ),
                        Text('Image sent'),
                      ],
                    )
                    
                    
                ],
              )
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

}