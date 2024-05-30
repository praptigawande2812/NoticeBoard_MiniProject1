import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(StudentPage());
}

class StudentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notice Board',
      debugShowCheckedModeBanner: false, // Remove the debug banner
      home: NoticeBoard(),
    );
  }
}

class NoticeBoard extends StatefulWidget {
  @override
  _NoticeBoardState createState() => _NoticeBoardState();
}

class _NoticeBoardState extends State<NoticeBoard> {
  List<Map<String, dynamic>> notices = [];
  List<Map<String, dynamic>> filteredNotices = [];
  String searchFilter = 'Title';
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchNotices();
  }

  Future<void> fetchNotices() async {
    final QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection('notices').get();
    setState(() {
      notices = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>? ?? {})
          .toList();
      notices ??= []; // Handle potential null value
      filteredNotices = notices;
    });
  }

  void filterNotices(String filter, String query) {
    setState(() {
      searchFilter = filter;
      searchQuery = query;
      filteredNotices = notices.where((notice) {
        String value =
            notice[filter.toLowerCase()]?.toString().toLowerCase() ?? '';
        return value.contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notice Board',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 28, // Increased font size for the page heading
            fontWeight: FontWeight.bold, // Made the page heading bold
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  DropdownButton<String>(
                    value: searchFilter,
                    onChanged: (value) {
                      filterNotices(value!, '');
                    },
                    items: ['Title', 'Date', 'Department']
                        .map((value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                            fontWeight: FontWeight.bold), // Bold dropdown items
                      ),
                    ))
                        .toList(),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        filterNotices(searchFilter, value);
                      },
                      decoration: InputDecoration(
                        hintText: 'Search $searchFilter',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.0), // Add some space below the search bar
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                child: SingleChildScrollView(
                  child: DataTable(
                    columnSpacing: 20, // Adjust spacing between columns
                    dataRowHeight: 60, // Adjust height of each row
                    columns: [
                      DataColumn(
                        label: Text(
                          'Title',
                          style: TextStyle(fontWeight: FontWeight.bold), // Bold title
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Date',
                          style: TextStyle(fontWeight: FontWeight.bold), // Bold date
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Department',
                          style: TextStyle(fontWeight: FontWeight.bold), // Bold department
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'View',
                          style: TextStyle(fontWeight: FontWeight.bold), // Bold view
                        ),
                      ),
                    ],
                    rows: filteredNotices.isNotEmpty
                        ? filteredNotices
                        .where((notice) =>
                    notice['title'] != null &&
                        notice['date'] != null &&
                        notice['department'] != null &&
                        notice['description'] != null)
                        .map(
                          (notice) => DataRow(
                        cells: [
                          DataCell(Text(notice['title'].toString())),
                          DataCell(Text(notice['date'].toString())),
                          DataCell(
                              Text(notice['department'].toString())),
                          DataCell(
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        NoticeDescriptionPage(
                                          title: notice['title'].toString(),
                                          description: notice['description']
                                              .toString(),
                                        ),
                                  ),
                                );
                              },
                              child: Text('View'),
                            ),
                          ),
                        ],
                      ),
                    )
                        .toList()
                        : [], // Return an empty list if there are no notices
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

class NoticeDescriptionPage extends StatelessWidget {
  final String title;
  final String description;

  NoticeDescriptionPage({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              description,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
