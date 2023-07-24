import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';

// k stands for a global variable
var kColorScheme = ColorScheme.fromSeed(seedColor: Colors.orange.shade200);
var kDarkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark, seedColor: Colors.orange.shade200);

void main() {
  // let's us set which screen rotation orientations are allowed
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //   [DeviceOrientation.portraitUp],
  // ).then((fn) {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kDarkColorScheme.primaryContainer,
          foregroundColor: kDarkColorScheme.onPrimaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.secondaryContainer,
            foregroundColor: kDarkColorScheme.onSecondaryContainer,
          ),
        ),
        snackBarTheme: const SnackBarThemeData().copyWith(
          backgroundColor: kDarkColorScheme.inverseSurface,
          contentTextStyle: TextStyle(color: kColorScheme.onInverseSurface),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: kDarkColorScheme.onSecondaryContainer,
                fontSize: 24,
              ),
            ),
      ),

      // we copy an existing theme and only style individual aspects of that
      // theme
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.primaryContainer,
          foregroundColor: kColorScheme.onPrimaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        // for elevatedButtonTheme there's no .copyWith method, so we use
        // .styleFrom
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.secondaryContainer,
            foregroundColor: kColorScheme.onSecondaryContainer,
          ),
        ),
        snackBarTheme: const SnackBarThemeData().copyWith(
          backgroundColor: kColorScheme.inverseSurface,
          contentTextStyle: TextStyle(color: kColorScheme.onInverseSurface),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: kColorScheme.onSecondaryContainer,
                fontSize: 24,
              ),
            ),
      ),
      // themeMode: ThemeMode.system, // is default
      home: const Expenses(),
    ),
  );
  // });
}
