import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpload extends StatefulWidget {
  const ImageUpload({Key? key}) : super(key: key);

  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  File? _pickedImage; // Variable to store the picked image

  Future<void> _getImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path); // Store the picked image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: const Text(
                  "Upload a clear photo, and let us do the rest. We'll scan for diseases with precision and care.",
                  style: TextStyle(
                    color: Color.fromARGB(255, 15, 78, 2),
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60),
            Center(
              child: Column(
                children: [
                  MaterialButton(
                    color: Color.fromARGB(255, 20, 119, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    onPressed: _getImageFromGallery,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "Add Photo from Gallery",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  MaterialButton(
                    color: Color.fromARGB(255, 20, 119, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    onPressed: () {
                      // TODO: Add code to detect diseases
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "Detect Diseases",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (_pickedImage != null)
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.file(
                    _pickedImage!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ImageUpload(),
  ));
}
