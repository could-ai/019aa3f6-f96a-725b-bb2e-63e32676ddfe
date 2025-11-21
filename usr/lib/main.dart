import 'package:flutter/material.dart';
import 'screens/menu_screen.dart';

void main() {
  runApp(const OxygenLudoApp());
}

class OxygenLudoApp extends StatelessWidget {
  const OxygenLudoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ليدو اوكسجين',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // ألوان علم السودان (أحمر، أخضر، أسود، أبيض)
        primaryColor: const Color(0xFFD21034), // أحمر
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF007229), // أخضر
          primary: const Color(0xFFD21034), // أحمر
          secondary: const Color(0xFF000000), // أسود
        ),
        useMaterial3: true,
        fontFamily: 'Arial', // يمكن تغيير الخط لاحقاً
      ),
      // تحديد المسارات
      initialRoute: '/',
      routes: {
        '/': (context) => const MenuScreen(),
      },
    );
  }
}
