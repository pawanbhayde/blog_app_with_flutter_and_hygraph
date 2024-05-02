import 'package:blog_app_with_flutter_and_hygraph/blog_raw.dart';
import 'package:blog_app_with_flutter_and_hygraph/main.dart';
import 'package:blog_app_with_flutter_and_hygraph/pages/blogscreen.dart';
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
                variables: const <String, dynamic>{"variableName": "value"}),
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
                  final blog = posts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlogScreen(
                            title: blog['title'],
                            content: blog['content']['text'],
                            coverImageUrl: blog['coverImage']['url'],
                          ),
                        ),
                      );
                    },
                    child: BlogRow(
                      title: blog['title'],
                      excerpt: blog['excerpt'],
                      coverURL: blog['coverImage']['url'],
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
