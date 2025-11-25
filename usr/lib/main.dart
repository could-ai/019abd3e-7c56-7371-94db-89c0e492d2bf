import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(const NaviSpectApp());
}

class NaviSpectApp extends StatelessWidget {
  const NaviSpectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NaviSpect AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0A2342),
          primary: const Color(0xFF0A2342),
          secondary: const Color(0xFF2CA58D),
        ),
        useMaterial3: true,
        fontFamily: 'Roboto', // Varsayılan font
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const DashboardScreen(),
      },
    );
  }
}
