import 'package:blog_app_with_flutter_and_hygraph/blog_row.dart';
import 'package:blog_app_with_flutter_and_hygraph/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F4F3),
      appBar: AppBar(
        title: const Text(
          "Hygraph Blog",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Query(
            options: QueryOptions(
                document: gql(query),
                variables: const <String, dynamic>{
                  "variableName": "value"
                }),
            builder: (result, {fetchMore, refetch}) {
              if (result.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (result.data == null) {
                return const Center(
                  child: Text("No article found!"),
                );
              }
              final posts = result.data!['posts'];
              return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  final title = post['title'];
                  final excerpt = post['excerpt'];
                  final coverImageURL = post!['coverImage']['url'];
                  return BlogRow(
                    title: title,
                    excerpt: excerpt,
                    coverURL: coverImageURL,
                  );
                },
              );
            }),
      ),
    );
  }
}
