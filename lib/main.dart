import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:mercado_na_nao/addCategoriaScreen.dart';
import 'package:mercado_na_nao/camera.dart';
import 'package:mercado_na_nao/categoriaScreen.dart';
import 'package:mercado_na_nao/modelCategoria.dart';
import 'package:mercado_na_nao/sacolaScreen.dart';
import 'package:mercado_na_nao/sharedPreferencesHelper.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de Compras',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  AnimatedSplashScreen(
            duration: 3000,
            splashIconSize: 250,
            splash: Image(image: AssetImage("assets/images/full 1.png")),
            nextScreen: MainScreen(),
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: const Color.fromARGB(255, 255, 255, 255)));
    
  }
}




class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final SharedPreferencesHelper _prefsHelper = SharedPreferencesHelper();
  List<Categoria> _categorias = [];
  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _refreshCategorias();

    _widgetOptions = <Widget>[
      CategoriaScreen(),
      AddCategoriaScreen(onSave: _refreshCategorias),
      SacolaScreen(),
      CameraGalleryScreen(),
    ];
  }

  Future<void> _refreshCategorias() async {
    final categorias = await _prefsHelper.getCategorias();
    setState(() {
      _categorias = categorias;
    });
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 227, 227),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: BottomNavigationBar(
          enableFeedback: true,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Center(
                child: CircleAvatar(
                  backgroundColor: _selectedIndex == 0
                      ? const Color.fromARGB(255, 94, 196, 1)
                      : Colors.transparent,
                  child: Icon(
                    Icons.home,
                    color: _selectedIndex == 0
                        ? Colors.white
                        : const Color.fromARGB(255, 55, 71, 79),
                  ),
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Center(
                child: CircleAvatar(
                  backgroundColor: _selectedIndex == 1
                      ? const Color.fromARGB(255, 94, 196, 1)
                      : Colors.transparent,
                  child: Icon(
                    Icons.category,
                    color: _selectedIndex == 1
                        ? Colors.white
                        : const Color.fromARGB(255, 55, 71, 79),
                  ),
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Center(
                child: CircleAvatar(
                  backgroundColor: _selectedIndex == 2
                      ? const Color.fromARGB(255, 94, 196, 1)
                      : Colors.transparent,
                  child: Icon(
                    Icons.shopping_bag,
                    color: _selectedIndex == 2
                        ? Colors.white
                        : const Color.fromARGB(255, 55, 71, 79),
                  ),
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Center(
                child: CircleAvatar(
                  backgroundColor: _selectedIndex == 3
                      ? const Color.fromARGB(255, 94, 196, 1)
                      : Colors.transparent,
                  child: Icon(
                    Icons.camera_alt_rounded,
                    color: _selectedIndex == 3
                        ? Colors.white
                        : const Color.fromARGB(255, 55, 71, 79),
                  ),
                ),
              ),
              label: '',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color.fromARGB(255, 48, 48, 48),
          unselectedItemColor: const Color.fromARGB(31, 0, 0, 0),
          onTap: _onItemTapped,
          selectedIconTheme: const IconThemeData(
            color: Color.fromARGB(255, 255, 255, 255),
            size: 30.0,
          ),
          selectedLabelStyle: const TextStyle(
            color: Colors.green,
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
