import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/detailsScreen.dart';
import 'dart:convert';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List searchResults = [];
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;
  bool hasError = false;

  Future<void> searchMovies(String query) async {
    if (query.isEmpty) return;

    setState(() {
      isLoading = true;
      hasError = false;
      searchResults = [];
    });

    try {
      final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=$query'));

      if (response.statusCode == 200) {
        setState(() {
          searchResults = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load results');
      }
    } catch (e) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: "Search for movies...",
            border: InputBorder.none,
          ),
          textInputAction: TextInputAction.search,
          onSubmitted: (value) {
            searchMovies(value);
          },
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : hasError
              ? Center(child: Text("Failed to load results. Please try again."))
              : searchResults.isEmpty
                  ? Center(child: Text("Type a movie name to start searching"))
                  : ListView.builder(
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        final movie = searchResults[index]['show'];
                        return ListTile(
                          leading: movie['image'] != null
                              ? Image.network(movie['image']['medium'], width: 50)
                              : Icon(Icons.movie, size: 50),
                          title: Text(movie['name'] ?? 'No Title'),
                          subtitle: Text(
                            movie['summary'] != null
                                ? movie['summary'].replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), '')
                                : 'No summary available',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(movie: movie),
                              ),
                            );
                          },
                        );
                      },
                    ),
    );
  }
}
