import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Halaman Ulasan Produk',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const ReviewPage(),
    );
  }
}

// Model data untuk sebuah ulasan
class Review {
  final String author;
  final String reviewText;
  final double rating;
  final DateTime date;

  Review({
    required this.author,
    required this.reviewText,
    required this.rating,
    required this.date,
  });
}

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  // Data ulasan dummy
  final List<Review> _reviews = [
    Review(
      author: 'Budi Santoso',
      reviewText: 'Produk ini luar biasa! Kualitasnya melebihi ekspektasi saya. Sangat direkomendasikan untuk semua orang.',
      rating: 5.0,
      date: DateTime(2024, 7, 20),
    ),
    Review(
      author: 'Citra Lestari',
      reviewText: 'Cukup bagus, tapi pengirimannya agak lambat. Secara keseluruhan, produknya berfungsi dengan baik.',
      rating: 4.0,
      date: DateTime(2024, 7, 19),
    ),
    Review(
      author: 'Agus Wijaya',
      reviewText: 'Saya sedikit kecewa dengan daya tahan baterainya. Perlu diisi ulang lebih sering dari yang saya kira.',
      rating: 3.0,
      date: DateTime(2024, 7, 18),
    ),
    Review(
      author: 'Dewi Anggraini',
      reviewText: 'Sangat mudah digunakan dan desainnya elegan. Suka sekali dengan warnanya!',
      rating: 4.5,
      date: DateTime(2024, 7, 17),
    ),
  ];

  void _addReview() {
    // Logika untuk menambah ulasan baru bisa ditambahkan di sini
    // Misalnya, menampilkan dialog atau halaman baru
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fungsi tambah ulasan belum diimplementasikan.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ulasan Pengguna'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: _reviews.length,
        itemBuilder: (context, index) {
          final review = _reviews[index];
          return ReviewListItem(review: review);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addReview,
        tooltip: 'Tambah Ulasan',
        child: const Icon(Icons.add_comment),
      ),
    );
  }
}

class ReviewListItem extends StatelessWidget {
  final Review review;

  const ReviewListItem({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Text(review.author[0]), // Inisial dari nama penulis
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.author,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '${review.date.day}/${review.date.month}/${review.date.year}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                StarRating(rating: review.rating),
              ],
            ),
            const SizedBox(height: 12.0),
            Text(
              review.reviewText,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final double rating;
  final int starCount;
  final Color color;

  const StarRating({
    super.key,
    this.rating = 0.0,
    this.starCount = 5,
    this.color = Colors.amber,
  });

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = Icon(
        Icons.star_border,
        color: color,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = Icon(
        Icons.star_half,
        color: color,
      );
    } else {
      icon = Icon(
        Icons.star,
        color: color,
      );
    }
    return icon;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(starCount, (index) => buildStar(context, index)),
    );
  }
}
