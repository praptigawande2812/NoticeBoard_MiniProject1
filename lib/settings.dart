import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'General Settings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text('Notifications'),
              trailing: Switch(
                value: true, // Example value, you can use state management to handle this.
                onChanged: (bool value) {
                  // Handle switch change here.
                },
              ),
            ),
            ListTile(
              title: Text('Dark Mode'),
              trailing: Switch(
                value: false, // Example value, you can use state management to handle this.
                onChanged: (bool value) {
                  // Handle switch change here.
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
