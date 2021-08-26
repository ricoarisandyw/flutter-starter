// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:salmon/ui/bugReport.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// import 'package:salmon/api/listApi.dart';

// import 'package:salmon/ui/login.dart';

// import 'package:salmon/ui/drawer/sbu.dart';
// import 'package:salmon/ui/drawer/produk.dart';
// import 'package:salmon/ui/drawer/account.dart';

// import 'package:salmon/model/ratingSales.dart';
// import 'package:salmon/model/rankSbuModel.dart';
// import 'package:salmon/model/checkTokenModel.dart';

class SuperAdmin extends StatefulWidget {
  @override
  _SuperAdminState createState() => _SuperAdminState();
}

class _SuperAdminState extends State<SuperAdmin> {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  var _chart;
  var _fullName = "Gagal memuat data";
  var _countSales = "Gagal memuat data";
  var _emailDrawer = "Gagal memuat data";
  var _confRate = [];
  var _realisasi = [];
  var _namaSbu = [];
  // var _target = [];

  bool _failLoad = false;

  @override
  void initState() {
    _checkToken();
    _setDataLocal();
    _getRatingSales();
    _getSBURank();
    super.initState();
  }

  void _checkToken() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // try {
    //   var apiResult = await http.get(
    //     "${ListApi.getApiCheckToken()}",
    //     headers: {"key": "${prefs.getString("token")}"}
    //   );
    //   if (apiResult.statusCode == 401) {
    //     var result = CheckTokenModel.fromJson(json.decode(apiResult.body));
    //     if (result.error == "Unauthorized") {
    //       logout();
    //     }
    //   }
    // }
    // catch (e) {
    //   print(e);
    // }
  }

  void _setDataLocal() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // try {
    //   setState(() {
    //     _fullName = prefs.getString("fullname");
    //     _emailDrawer = prefs.getString("email");
    //     // _fullName = "cobak";
    //     // _emailDrawer = "coba@gmail.com";
    //   });
    // }
    // catch (e) {
    //   print(e);
    // }
  }

  void _getRatingSales() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // try {
    //   var apiResult = await http.get(
    //     "${ListApi.getApiRatingSales(prefs.getString("sbuId"), prefs.getString("role"))}",
    //     headers: {"key": "${prefs.getString("token")}"}
    //   );
    //   if (apiResult.statusCode == 200) {
    //     var result = RatingSales.fromJson(json.decode(apiResult.body));
    //     setState(() {
    //       _countSales = result.procentage.length.toString();
    //     });
    //     List<Sales> dataSales = [];
    //     for (var i = 0; i < result.procentage.length; i++) {
    //       setState(() {
    //         dataSales.add(Sales(result.procentage[i].name, result.procentage[i].proc.round()));
    //       });
    //     }
    //     var series = [
    //       charts.Series(
    //         domainFn: (Sales sales, _) => sales.sales,
    //         measureFn: (Sales sales, _) => sales.persentase,
    //         id: "Penjualan",
    //         data: dataSales,
    //         labelAccessorFn: (Sales sales, _) => "${sales.sales} : ${sales.persentase.toString()}%"
    //       )
    //     ];
    //     setState(() {
    //       _failLoad = false;
    //       _chart = charts.BarChart(
    //         series,
    //         vertical: false,
    //         barRendererDecorator: charts.BarLabelDecorator<String>(),
    //         domainAxis: charts.OrdinalAxisSpec(renderSpec: charts.NoneRenderSpec()),
    //       );
    //     });
    //   }
    //   else {
    //     setState(() {
    //       _failLoad = true;
    //     });
    //   }
    // }
    // catch (e) {
    //   // setState(() {
    //   //   _failLoad = true;
    //   // });
    //   print(e);
    // }
  }

  void _getSBURank() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // try {
    //   var apiResult = await http.get(
    //     "${ListApi.getApiSBURank()}",
    //     headers: {"key": "${prefs.getString("token")}"}
    //   );
    //   if (apiResult.statusCode == 200) {
    //     var result = RankSbuModel.fromJson(json.decode(apiResult.body));
    //     for (var i = 0; i < result.hits.length; i++) {
    //       String formatRealisasi = result.hits[i].realization.toDouble().toString();
    //       String formatTarget = result.hits[i].target.toDouble().toString();

    //       setState(() {
    //         _confRate.add(double.parse(result.hits[i].confStr));
    //         _realisasi.add(formatRealisasi);
    //         _namaSbu.add(result.hits[i].sbuName);
    //         _target.add(formatTarget);
    //       });
    //     }
    //     print(_namaSbu[0]);
    //   }
    // }
    // catch (e) {
    //   print(e);
    // }
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("email");
    prefs.remove("fullname");
    prefs.remove("id");
    prefs.remove("password");
    prefs.remove("phone");
    prefs.remove("role");
    prefs.remove("sbuId");
    prefs.remove("status");
    prefs.remove("token");
    prefs.setBool("login", false);
  }

  Future<bool> _confirmExit() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Anda yakin?"),
          content: Text("Anda akan keluar dari aplikasi ini!!"),
          actions: <Widget>[
            TextButton(
              child: Text("Tidak"),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text("Ya"),
              onPressed: () {
                // exit(0);
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
            )
          ],
        );
      }
    ) as Future<bool>;
  }

  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 3));
    _setDataLocal();
    _getRatingSales();
    _getSBURank();
    return null;
  }

  Widget _buildTile(Widget child, {Function()? onTap}) {
    return Material(
      elevation: 14.0,
      borderRadius: BorderRadius.circular(12.0),
      shadowColor: Color(0x802196F3),
      child: InkWell (
        onTap: onTap != null ? () => onTap() : () { print('Not set yet'); },
        child: child
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _confirmExit,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.blue),
          title: Text(
            "Super Admin",
            style: TextStyle(
              // fontFamily: 'Nunito-Black',
              fontSize: 20.0,
              // letterSpacing: 0.5,
              color: Colors.blue,
              // fontWeight: FontWeight.bold
            ),
          ),
        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white, size: 40.0,),
                ),
                accountName: Text(_fullName),
                accountEmail: Text(_emailDrawer),
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      leading: Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: Colors.green[300],
                          borderRadius: BorderRadius.circular(8.0)
                        ),
                        child: Icon(
                          Icons.person, 
                          size: 30.0,
                          color: Colors.white,
                        ),
                      ),
                      title: Text("Profile"),
                      onTap: (){
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(builder: (context) => Account())
                        // ).then((value) {
                        //   _setDataLocal();
                        // });
                      },
                    ),
                    ListTile(
                      leading: Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: Colors.amber[300],
                          borderRadius: BorderRadius.circular(8.0)
                        ),
                        child: Icon(
                          Icons.business, 
                          size: 30.0,
                          color: Colors.white,
                        ),
                      ),
                      title: Text("SBU"),
                      onTap: (){
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(builder: (context) => ListSBU())
                        // );
                      },
                    ),
                    ListTile(
                      leading: Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[300],
                          borderRadius: BorderRadius.circular(8.0)
                        ),
                        child: Icon(
                          Icons.folder_open, 
                          size: 30.0,
                          color: Colors.white,
                        ),
                      ),
                      title: Text("Produk"),
                      onTap: (){
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(builder: (context) => ProdukManager())
                        // );
                      },
                    ),
                    ListTile(
                      leading: Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: Colors.blue[300],
                          borderRadius: BorderRadius.circular(8.0)
                        ),
                        child: Icon(
                          Icons.help_outline, 
                          size: 30.0,
                          color: Colors.white,
                        ),
                      ),
                      title: Text("Pusat Bantuan"),
                      onTap: (){
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(builder: (context) => BugReport())
                        // );
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: Colors.red[300],
                          borderRadius: BorderRadius.circular(8.0)
                        ),
                        child: Icon(
                          Icons.exit_to_app, 
                          size: 30.0,
                          color: Colors.white,
                        ),
                      ),
                      title: Text("Logout"),
                      onTap: (){
                        logout();
                        // Navigator.of(context).pushReplacement(
                        //   MaterialPageRoute(builder: (context) => Login())
                        // );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _refresh,
          child: StaggeredGridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            children: <Widget>[
              _buildTile(
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Top 6 Sales",
                                style: TextStyle(
                                  color: Colors.blueAccent[400],
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18.0
                                )
                              ),
                              Text(
                                _countSales, 
                                style: TextStyle(
                                  color: Colors.black, 
                                  fontWeight: FontWeight.w700, 
                                  fontSize: 18.0
                                )
                              )
                            ],
                          ),
                          Container(
                            width: 55.0,
                            height: 55.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Color(0XFF8AC0DE),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Icon(
                                  Icons.group, 
                                  color: Colors.white, 
                                  size: 25.0
                                ),
                              )
                            )
                          ),
                        ]
                      ),
                      SizedBox(
                        height: 250.0,
                        child: _failLoad ? Container() : _chart,
                      )
                    ],
                  ),
                ),
              ),
              _buildTile(
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Top 3 SBU",
                            style: TextStyle(
                              color: Colors.blueAccent[400],
                              fontWeight: FontWeight.w700,
                              fontSize: 18.0
                            )
                          ),
                          Container(
                            width: 55.0,
                            height: 55.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Color(0XFF8AC0DE),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Icon(
                                  Icons.business, 
                                  color: Colors.white, 
                                  size: 25.0
                                ),
                              )
                            )
                          ),
                        ]
                      ),
                      SizedBox(height: 10.0,),
                      (_confRate.length != 0) ?
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _namaSbu[0],
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(_realisasi[0]),
                            SizedBox(height: 16.0,),
                            Text(
                              _namaSbu[1],
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(_realisasi[1]),
                            SizedBox(height: 16.0,),
                            Text(
                              _namaSbu[2],
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(_realisasi[2]),
                            SizedBox(height: 16.0,),
                          ],
                        ),
                      ) :
                      Container()
                    ],
                  ),
                ),
              ),
            ],
            staggeredTiles: [
              StaggeredTile.extent(2, 360.0),
              StaggeredTile.extent(2, 300.0),
            ],
          ),
        ),
      ),
    );
  }
}

class Sales{
  final String sales;
  final int persentase;

  Sales(this.sales, this.persentase);
}