import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: ProfilePage(),
  ));
}

String name = "Username";
String userType = "Student/faculty";
String phoneNo = "+91";
String email1 = "College email";
String email2 = "Personal email";

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, // Center the title
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.blue), // Blue title color
        ),
        actions: [
          IconButton(
            icon: Icon(CupertinoIcons.pencil),
            onPressed: () {
              // Handle edit profile button press
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          // Profile picture widget
          buildProfilePicture(),
          SizedBox(height: 20.0), // Add space after profile picture
          // User information widgets with boxes, padding, and rounded corners
          buildUserInfoBox(title: "Name", value: name),
          buildUserInfoBox(title: "User Type", value: userType),
          buildUserInfoBox(title: "Phone No.", value: phoneNo),
          buildUserInfoBox(title: "Email", value: email1),
          buildUserInfoBox(title: "", value: email2), // Email2 without title
          SizedBox(height: 20.0), // Add space before update button
          buildUpdateButton(),
        ],
      ),
    );
  }

  // Widget to display profile picture
  Widget buildProfilePicture() {
    // Implement logic to display profile picture from storage/assets
    // For now, display a placeholder
    return Center(
      child: CircleAvatar(
        radius: 50.0,
        backgroundImage: AssetImage('assets/images/profile_picture.png'), // Replace with your placeholder image path
      ),
    );
  }

  // Widget to display a user information tile with box, padding, and rounded corners
  Widget buildUserInfoBox({required String title, required String value}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Container(
        padding: EdgeInsets.all(10.0), // Add padding within the box
        decoration: BoxDecoration(
          color: Colors.white, // Optional background color for boxes
          borderRadius: BorderRadius.circular(10.0), // Add rounded corners
          border: Border.all(color: Colors.grey), // Optional border for boxes
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Left-align content
          children: [
            Text(title),
            Text(value),
          ],
        ),
      ),
    );
  }

  // Widget to display update profile button
  Widget buildUpdateButton() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: TextButton(
            onPressed: () {
              // Handle update profile button press
            },
            child: Text('Update Profile'),
            style: TextButton.styleFrom(
              foregroundColor: Colors.blue, // Blue button color
            ),
            ),
        );
    }
}