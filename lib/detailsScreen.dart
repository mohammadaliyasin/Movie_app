import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsScreen extends StatelessWidget {
  final Map movie;

  DetailsScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie['name'],style: GoogleFonts.outfit(fontSize: 22,fontWeight: FontWeight.w600),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            movie['image'] != null
                ? Image.network(movie['image']['original'])
                : const Icon(Icons.movie, size: 100),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movie['name'],
                style: GoogleFonts.outfit(fontSize: 24,fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movie['summary'] ?? 'No summary available',
                style: GoogleFonts.outfit(fontSize: 16,fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
