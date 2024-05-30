import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(CreatePage());
}

class CreatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Notice',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false, // Removed debug banner
      home: CreateNoticePage(),
    );
  }
}

class CreateNoticePage extends StatefulWidget {
  @override
  _CreateNoticePageState createState() => _CreateNoticePageState();
}

class _CreateNoticePageState extends State<CreateNoticePage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  File? _selectedFile;
  File? _selectedMedia;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now())
      setState(() {
        _dateController.text = picked.toString();
      });
  }

  Future<void> _selectFile() async {
    final result = await FilePicker.platform
        .pickFiles(allowMultiple: false); // Allow only single file selection

    if (result != null) {
      final file = File(result.files.single.path!);
      setState(() {
        _selectedFile = file;
      });
    } else {
      // Handle user cancellation or errors
    }
  }

  Future<void> _selectMedia() async {
    // Use a media picker plugin or implement your custom logic to select media files
    // For example, you can use the image_picker package for selecting images from the device gallery
    // Replace this with the appropriate code for selecting media files
    // For demonstration purposes, we'll use the image_picker package
    final pickedFile =
    await ImagePicker().getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        // Handle the selected media file here
        // For example, you can store the media file path in a variable
        _handleSelectedMedia(File(pickedFile.path));
        _selectedMedia = File(pickedFile.path);
      });
    } else {
      // User canceled the media picker
    }
  }

  void _handleSelectedMedia(File mediaFile) {
    // Handle the selected media file according to your application logic
    // For example, you can store it in a variable or perform any processing
    setState(() {
      _selectedMedia = mediaFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Notice',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 24, // Larger font size
            fontWeight: FontWeight.bold, // Bold font weight
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title*',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'TOC LA1',
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Date*',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _dateController,
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: 'Select Date',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => _selectDate(context),
                  icon: Icon(Icons.calendar_today),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Description*',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Lab Assessment for Theory Of Compu...',
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Upload File',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _selectFile(); // Function to select/upload a file
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color(0xff0095FF),
                    backgroundColor: Colors.white, // Blue text color
                  ),
                  child: Text('Attach File'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _selectMedia(); // Function to select/upload a media file
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color(0xff0095FF),
                    backgroundColor: Colors.white, // Blue text color
                  ),
                  child: Text('Attach Media'),
                ),
                ElevatedButton(
                  onPressed: () => _selectFile(),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color(0xff0095FF),
                    backgroundColor: Colors.white, // Blue text color
                  ),
                  child: Text('Select File'),
                ),
              ],
            ),
            if (_selectedFile != null)
              Text(_selectedFile!.path), // Display selected file path
            SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_titleController.text.isEmpty ||
                      _dateController.text.isEmpty ||
                      _descriptionController.text.isEmpty ||
                      _selectedFile == null) {
                    // Show an alert or toast message indicating that all fields are required
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('All fields are required.')),
                    );
                  } else {
                    // All required fields are filled, proceed with notice submission

                    // Here you can handle the notice submission logic
                    // For demonstration purposes, let's print the notice details
                    print('Title: ${_titleController.text}');
                    print('Date: ${_dateController.text}');
                    print('Description: ${_descriptionController.text}');
                    print('File Path: ${_selectedFile!.path}');

                    // Reset the form fields and selected file
                    _titleController.clear();
                    _dateController.clear();
                    _descriptionController.clear();
                    setState(() {
                      _selectedFile = null;
                    });

                    // Show a success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Notice submitted successfully!')),
                    );
                  }
                },
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(60), // Button height
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xff0095FF), // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50), // Same border
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
