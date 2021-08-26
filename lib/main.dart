import 'package:flutter/material.dart';
import 'package:flutter_starter/ui/index.dart';
import 'package:flutter_starter/ui/superAdmin.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs) {
    runApp(MyApp(prefs: prefs));
  });
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  MyApp({required this.prefs});

  Widget _pageAwal() {
    bool seen = (prefs.getBool('login') ?? false);

    return Index();
    // if (seen) {
    //   if (prefs.getString("role") == "4") {
    //     return SuperAdmin();
    //   } else if (prefs.getString("role") == "3") {
    //     return Admin();
    //   } else if (prefs.getString("role") == "2") {
    //     return Manager();
    //   } else if (prefs.getString("role") == "1") {
    //     return Index();
    //   } else {
    //     return Login();
    //   }
    // } else {
    //   return Login();
    // }
    // var whatsappUrl ="whatsapp://send?phone=62895414866726";
    // await canLaunch(whatsappUrl) ?
    // launch(whatsappUrl):
    // print("open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SAMPERIN",
      theme: ThemeData(
        primaryColor: Colors.blue[200],
        fontFamily: 'Nunito-Regular',
      ),
      routes: <String, WidgetBuilder>{
        '/ui/index': (BuildContext context) => Index(),
      },
      home: _pageAwal(),
      debugShowCheckedModeBanner: false,
    );
  }
}
