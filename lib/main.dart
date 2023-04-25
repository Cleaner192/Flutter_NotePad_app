import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/register_screen.dart';
import 'package:flutter_application_1/login_screen.dart';
import 'package:flutter_application_1/appbar.dart';
import 'package:flutter_application_1/addNote.dart';
import 'package:flutter_application_1/editNote.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Мое приложение',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute:
          '/register', // страница, которая будет открыта при запуске приложения
      routes: {
        // регистрация маршрутов, допольно удобно по ним переходить
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
      },
    );
  }
}
