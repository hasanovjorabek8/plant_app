import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_widget/plant-detail_screen.dart';

class ExclusiveOfferCarousel extends StatefulWidget {
  @override
  _ExclusiveOfferCarouselState createState() => _ExclusiveOfferCarouselState();
}

class _ExclusiveOfferCarouselState extends State<ExclusiveOfferCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<String> _images = [
    'assets/plant1.png',
    'assets/plant2.png',
    'assets/plant3.png',
    'assets/plant4.png',
  ];
  Timer? _timer;
  int _currentCategory = 0; // 0: Indoor, 1: Garden, 2: Decorative
  final List<Map<String, dynamic>> _plants = [
    {
      'name': 'Monstera Adansonii',
      'family': 'Monstera family',
      'price': '60.000 UZS',
      'image': 'assets/plant1.png',
      'background': Colors.green[100],
      'category': 'Indoor',
      'isFavorite': false,
    },
    {
      'name': 'Janda Bolong',
      'family': 'Agung Suka family',
      'price': '125.000 UZS',
      'image': 'assets/plant2.png',
      'background': Colors.blue[100],
      'category': 'Indoor',
      'isFavorite': false,
    },
    {
      'name': 'Rose',
      'family': 'Flower family',
      'price': '20.000 UZS',
      'image': 'assets/plant3.png',
      'background': Colors.purple[100],
      'category': 'Garden',
      'isFavorite': false,
    },
    {
      'name': 'Tulip',
      'family': 'Flower family',
      'price': '25.000 UZS',
      'image': 'assets/plant4.png',
      'background': Colors.red[100],
      'category': 'Garden',
      'isFavorite': false,
    },
    {
      'name': 'Cactus',
      'family': 'Cactus family',
      'price': '45.000 UZS',
      'image': 'assets/plant1.png',
      'background': Colors.teal[100],
      'category': 'Decorative',
      'isFavorite': false,
    },
    {
      'name': 'Succulent',
      'family': 'Succulent family',
      'price': '55.000 UZS',
      'image': 'assets/plant1.png',
      'background': Colors.green[200],
      'category': 'Decorative',
      'isFavorite': false,
    },
  ];

  void _setCategory(int index) {
    setState(() {
      _currentCategory = index;
    });
  }

  List<Map<String, dynamic>> get _filteredPlants {
    final categories = ['Indoor', 'Garden', 'Decorative'];
    return _plants
        .where((plant) => plant['category'] == categories[_currentCategory])
        .take(2) // Ограничиваем количество элементов до 2
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 2), (Timer timer) {
      if (_currentPage < _images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _toggleFavorite(int index) {
    setState(() {
      _plants[index]['isFavorite'] = !_plants[index]['isFavorite'];
    });
  }

  void _openCamera() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Camera"),
        content: Text("Kamera xususiyati kelmoqda."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Yopish"),
          ),
        ],
      ),
    );
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          'assets/logo.png',
          width: 21,
          height: 25,
        ),
        title: Text(
          'PLANTSCAPE',
          style: GoogleFonts.roboto(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.density_medium_sharp),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Column(
          children: [
            // Carousel
            Container(
              height: 300,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _images.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xFFFCEAD8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              _images[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Eksklyuziv\ntaklif',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "60% chegirma bilan birinchi o'simlik oling",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_images.length, (index) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: _currentPage == index ? 16 : 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index ? Colors.black : Colors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "O'simliklarni qidirish...",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.camera_alt_outlined, size: 32),
                    onPressed: _openCamera,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCategoryButton(
                  'Домашние растения',
                  Icons.home_outlined,
                  _currentCategory == 0 ? Colors.green : Colors.green[200]!,
                  'Indoor',
                ),
                _buildCategoryButton(
                  'Садовые растения',
                  Icons.local_florist_outlined,
                  _currentCategory == 1 ? Colors.blue : Colors.blue[200]!,
                  'Garden',
                ),
                _buildCategoryButton(
                  'Декоративные растения',
                  Icons.eco_outlined,
                  _currentCategory == 2 ? Colors.purple : Colors.purple[200]!,
                  'Decorative',
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredPlants.length,
                itemBuilder: (context, index) {
                  final plant = _filteredPlants[index];
                  return GestureDetector(
                      onTap: () {
                    // Переход на экран PlantDetailsScreen с передачей данных
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlantDetailsScreen(),
                      ),
                    );
                  },
                  child:  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: plant['background'],
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  plant['image'],
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      plant['name'],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      plant['family'],
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      plant['price'],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: -10,
                          left: -10,
                          child: GestureDetector(
                            onTap: () => _toggleFavorite(index),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 2,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.all(8),
                              child: Icon(
                                plant['isFavorite']
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  );
                }
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Uy',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Sevimli',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Arava',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  Widget _buildCategoryButton(
      String title, IconData icon, Color color, String category) {
    return GestureDetector(
      onTap: () {
        _setCategory(category == 'Indoor'
            ? 0
            : category == 'Garden'
            ? 1
            : 2);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(icon, size: 12, color: Colors.white),
            SizedBox(height: 4),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
