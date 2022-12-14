import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SettingsProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  String langCode = 'en';

  void changeTheme(ThemeMode newMode) async{
    final preferences = await SharedPreferences.getInstance();

    if (newMode == themeMode) {
      return;
    }  
    themeMode = newMode;

    preferences.setString('theme', (themeMode==ThemeMode.dark)? 'dark':'light');
    notifyListeners();
  }

  void changeLocale(String newLocale) async {
    final preferences = await SharedPreferences.getInstance();
    if (newLocale == langCode) {
      return;
    }
    langCode = newLocale;
    preferences.setString('language', langCode); // en arr
    notifyListeners();
  }

  bool isDarkMode() {
    return themeMode == ThemeMode.dark;
  }

  String getMainBackgroundImage() {
    return themeMode == ThemeMode.light
        ? "assets/images/main_background.png"
        : "assets/images/main_background_dark.png";
  }
}
