import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quizfirebase/Providers/questions.dart';
import 'package:quizfirebase/Screens/quiz.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  await Firebase.initializeApp();
  // print(user!.uid);

  var questionss =
      await FirebaseFirestore.instance.collection('questions').get();

  runApp(MultiProvider(
    providers: [
      ListenableProvider<questions>(
        create: (_) => questions(),
      ),
    ],
    child: MaterialApp(
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        home: quiz()
        //  user == null ? UserType() : accueil() // signin()
        ),
  ));
}
