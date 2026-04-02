import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

// ROOT OF THE APP

void main() {
  runApp(const MyApp());
}

// MyApp is StatefulWidget now because it needs to
// rebuild the whole app when dark mode is toggled
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Tracks dark mode for the whole app
  bool isDark = false;
  // Toggle the theme
  void toggleTheme() {
    setState(() => isDark = !isDark);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bar-Tar',
      debugShowCheckedModeBanner: false,
      // Switches between light and dark theme
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF8182EB)),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8182EB),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF0F172A),
      ),
      // Pass toggleTheme and isDark down to HomeScreen
      home: HomeScreen(isDark: isDark, onToggleTheme: toggleTheme),
    );
  }
}
