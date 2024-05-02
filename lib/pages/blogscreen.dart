import 'package:flutter/material.dart';

class BlogScreen extends StatefulWidget {
  final String title;
  final String content;
  final String coverImageUrl;

  const BlogScreen({
    Key? key,
    required this.title,
    required this.content,
    required this.coverImageUrl,
  }) : super(key: key);

  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.coverImageUrl),
            SizedBox(height: 16.0),
            Text(
              widget.title,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(widget.content),
          ],
        ),
      ),
    );
  }
}
