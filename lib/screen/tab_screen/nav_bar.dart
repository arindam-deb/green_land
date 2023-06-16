import 'package:flutter/material.dart';
import 'package:green_land/screen/tab_screen/card_screen/card_screen.dart';
import 'package:green_land/screen/tab_screen/homeScreen_pages/home_screen.dart';
import 'package:green_land/screen/tab_screen/setting_screen/about.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _pages = <Widget>[
    HomeScreen(),
    CardScreen(),
    AboutScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('lib/images/heroicons-outline_menu-alt-2.png'),
        title:Image.asset('lib/images/Green land.png'),
        //  Text(
        //   'Green Land',
        //   style: TextStyle(color: Colors.green),
        // ),
        //Image.asset(''),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(
              Icons.grid_view,
              color: Colors.grey,
            ),
          )
        ],
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'About',
          ),
        ],
      ),
      body: Center(child: _pages.elementAt(_selectedIndex)),
    );
  }
}
