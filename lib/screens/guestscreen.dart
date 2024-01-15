import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:login_signup_flow_app/screens/results_page.dart'; // Import your ResultsPage

void main() {
  runApp(MaterialApp(
    home: ImageUpload(),
  ));
}

class ImageUpload extends StatefulWidget {
  const ImageUpload({Key? key}) : super(key: key);

  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  File? _pickedImage;
  String? _predictedClass;
  double? _confidence;
  List<double>? _probabilities;
  bool _showResultsButton = false;

  Future<void> _getImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
        _predictedClass = null;
        _confidence = null;
        _probabilities = null;
        _showResultsButton = false;
      });
    }
  }

  Future<void> _detectDisease() async {
    if (_pickedImage == null) {
      return;
    }

    final url = Uri.parse('http://127.0.0.1:5000/predict');
    var request = http.MultipartRequest('POST', url);
    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        _pickedImage!.path,
        filename: 'picked_image.jpg',
      ),
    );

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        setState(() {
          _predictedClass = responseData['predicted_class'].toString();
          _confidence = responseData['confidence'];
          _probabilities = List<double>.from(responseData['probabilities']);
          _showResultsButton = true;
        });
      } else {
        // Handle other status codes or errors
        setState(() {
          _predictedClass = 'Error';
          _confidence = null;
          _probabilities = null;
          _showResultsButton = true;
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _predictedClass = 'Error';
        _confidence = null;
        _probabilities = null;
        _showResultsButton = true;
      });
    }
  }

  void _viewRemedies() {
    // Check if _predictedClass is not null before navigating
    if (_predictedClass != null) {
      // Navigate to a new RemediesPage with the necessary information
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RemediesPage(
            predictedClass: _predictedClass!,
          ),
        ),
      );
    } else {
      // Handle the case where _predictedClass is null (if needed)
      // You might want to display an error message or take appropriate action
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
        child: SingleChildScrollView(
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
                      onPressed: _detectDisease,
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
                    if (_showResultsButton)
                      MaterialButton(
                        color: Color.fromARGB(255, 20, 119, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        onPressed: _viewRemedies,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "View Remedies",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    if (_predictedClass != null)
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Predicted Disease: ${_predictedClass ?? "Not detected"}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (_confidence != null) SizedBox(height: 10),
                            if (_confidence != null)
                              Text(
                                'Confidence: ${_confidence?.toStringAsFixed(2) ?? 'N/A'}%',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            if (_probabilities != null) SizedBox(height: 10),
                            if (_probabilities != null)
                              Text(
                                'Probabilities: ${_probabilities?.toString() ?? 'N/A'}',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                          ],
                        ),
                      ),
                    const SizedBox(
                        height: 100), // Add extra space for smaller screens
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
