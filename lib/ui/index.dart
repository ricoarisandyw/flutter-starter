import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:percent_indicator/percent_indicator.dart';
// import 'package:salmon/ui/bener.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
// import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// import 'package:salmon/api/listApi.dart';

// import 'package:salmon/ui/login.dart';
// import 'package:salmon/ui/bugReport.dart';
// import 'package:salmon/ui/notification.dart';
// import 'package:salmon/ui/addNewClient.dart';
// import 'package:salmon/ui/addExistingClient.dart';

// import 'package:salmon/ui/drawer/won.dart';
// import 'package:salmon/ui/drawer/plan.dart';
// import 'package:salmon/ui/drawer/lose.dart';
// import 'package:salmon/ui/drawer/leads.dart';
// import 'package:salmon/ui/drawer/account.dart';
// import 'package:salmon/ui/drawer/contact.dart';
// import 'package:salmon/ui/drawer/prospect.dart';
// import 'package:salmon/ui/drawer/connecting.dart';
// import 'package:salmon/ui/drawer/hotProspect.dart';

// import 'package:salmon/model/ratingSales.dart';
// import 'package:salmon/model/checkTokenModel.dart';
// import 'package:salmon/model/summaryDashboard.dart';
// import 'package:salmon/model/scheduleTodayModel.dart';

// import 'dialog/ServiceUpdate.dart';

class Index extends StatefulWidget {

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  late List data;

  var _persentaseEkspektasi = 0.0;
  var _persentaseRealita = 0.0;
  Color _colorPersentaseEkspektasi = Colors.grey;
  Color _colorPersentaseRealita = Colors.grey;
  var _textTargetEkspektasi = "0";
  var _textRealisasiEkspektasi = "0";
  var _textTargetRealita = "0";
  var _textRealisasiRealita = "0";
  var _textLeads = "";
  var _textConnecting = "";
  var _textProspect = "";
  var _textHotProspect = "";
  var _textWon = "";
  var _textLose = "";
  var _notif = 0;
  var _countSales = "Gagal memuat data";
  var _visit = "Gagal memuat data";
  var _fullName = "Gagal memuat data";
  var _emailDrawer = "Gagal memuat data";
  var _call = [];
  var _email = [];
  var _chart;
  bool _failLoad = false;

  @override
  void initState() {
    _checkToken();
    _call.add("Gagal memuat data");
    _call.add("Gagal memuat data");
    _call.add("Gagal memuat data");
    _email.add("Gagal memuat data");
    _email.add("Gagal memuat data");
    _getDataSummary();
    _getScheduleToDay();
    _setDataLocal();
    _getRatingSales();
    super.initState();
    
    //CHECKING VERSION
    Future.delayed(Duration.zero, () {
      // ServiceUpdate.checkVersion(context);
      return null;
    });
  }

  @override
  void dispose() {
    super.dispose();
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      setState(() {
        _fullName = prefs.getString("fullname")!;
        _emailDrawer = prefs.getString("email")!;
      });
    }
    catch (e) {
      print(e);
    }
  }

  void _getDataSummary() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // try {
    //   var apiResult = await http.get(
    //     "${ListApi.getApiDataSummary(prefs.getString("email"))}",
    //     headers: {"key": "${prefs.getString("token")}"}
    //   );
    //   if (apiResult.statusCode == 200) {
    //     var result = SummaryModel.fromJson(json.decode(apiResult.body));
    //     setState(() {
    //       _notif = result.notif;
    //       String  _formatTargetEkspektasi = result.targetMarket.toDouble().toString();
    //       String _formatRealisasiEkspektasi = result.realisasiMarket.toDouble().toString();
    //       String  _formatTargetRealita = result.target.toDouble().toString();
    //       String _formatRealisasiRealita = result.realisasi.toDouble().toString();
    //       String _formatLeads = result.ld.toDouble().toString();
            
    //       String _formatConnecting = result.cn.toDouble().toString();
    //       String _formatProspect =result.pr.toDouble().toString();
    //       String _formatHotProspect = result.hp.toDouble().toString();
    //       String _formatWon = result.realisasi.toDouble().toString();
    //       String _formatLose = result.ls.toDouble().toString();

    //       if (_formatTargetEkspektasi.substring(_formatTargetEkspektasi.length-1) == "M") {
    //         _textTargetEkspektasi = "${_formatTargetEkspektasi.substring(0, _formatTargetEkspektasi.length-1)}JT";
    //       }
    //       else if (_formatTargetEkspektasi.substring(_formatTargetEkspektasi.length-1) == "B") {
    //         _textTargetEkspektasi = "${_formatTargetEkspektasi.substring(0, _formatTargetEkspektasi.length-1)}M";
    //       }
    //       else {
    //         _textTargetEkspektasi = _formatTargetEkspektasi;
    //       }
    //       if (_formatRealisasiEkspektasi.substring(_formatRealisasiEkspektasi.length-1) == "M") {
    //         _textRealisasiEkspektasi = "${_formatRealisasiEkspektasi.substring(0, _formatRealisasiEkspektasi.length-1)}JT";
    //       }
    //       else if (_formatRealisasiEkspektasi.substring(_formatRealisasiEkspektasi.length-1) == "B") {
    //         _textRealisasiEkspektasi = "${_formatRealisasiEkspektasi.substring(0, _formatRealisasiEkspektasi.length-1)}M";
    //       }
    //       else {
    //         _textRealisasiEkspektasi = _formatRealisasiEkspektasi;
    //       }
    //       if (_formatTargetRealita.substring(_formatTargetRealita.length-1) == "M") {
    //         _textTargetRealita = "${_formatTargetRealita.substring(0, _formatTargetRealita.length-1)}JT";
    //       }
    //       else if (_formatTargetRealita.substring(_formatTargetRealita.length-1) == "B") {
    //         _textTargetRealita = "${_formatTargetRealita.substring(0, _formatTargetRealita.length-1)}M";
    //       }
    //       else {
    //         _textTargetRealita = _formatTargetRealita;
    //       }
    //       if (_formatRealisasiRealita.substring(_formatRealisasiRealita.length-1) == "M") {
    //         _textRealisasiRealita = "${_formatRealisasiRealita.substring(0, _formatRealisasiRealita.length-1)}JT";
    //       }
    //       else if (_formatRealisasiRealita.substring(_formatRealisasiRealita.length-1) == "B") {
    //         _textRealisasiRealita = "${_formatRealisasiRealita.substring(0, _formatRealisasiRealita.length-1)}M";
    //       }
    //       else {
    //         _textRealisasiRealita = _formatRealisasiRealita;
    //       }

    //       _textLeads = _formatLeads;
    //       _textConnecting = _formatConnecting;
    //       _textProspect = _formatProspect;
    //       _textHotProspect = _formatHotProspect;
    //       _textWon = _formatWon;
    //       _textLose = _formatLose;
          
    //       if (result.targetMarket != 0) {
    //         _persentaseEkspektasi = (result.realisasiMarket / result.targetMarket) / 2;
    //         _persentaseRealita = result.realisasi / result.target;
    //         // if ((_persentaseEkspektasi*100) <= 50) {
    //         //   _colorPersentaseEkspektasi = Colors.red[300];
    //         // }
    //         // else if ((_persentaseEkspektasi*100) > 50 && (_persentaseEkspektasi*100) <= 80) {
    //         //   _colorPersentaseEkspektasi = Colors.yellow![300];
    //         // }
    //         // else {
    //         //   _colorPersentaseEkspektasi = Colors.green![400];
    //         // }
    //         // if ((_persentaseRealita*100) <= 25) {
    //         //   _colorPersentaseRealita = Colors.red![300];
    //         // }
    //         // else if ((_persentaseRealita*100) > 25 && (_persentaseRealita*100) <= 75) {
    //         //   _colorPersentaseRealita = Colors.yellow[300];
    //         // }
    //         // else {
    //         //   _colorPersentaseRealita = Colors.green[400];
    //         // }
    //       }
    //       else {
    //         _persentaseEkspektasi = 0;
    //         _persentaseRealita = 0;
    //       }
    //     });
    //   }
    // }
    // catch (e) {
    //   print(e);
    // }
  }

  void _getScheduleToDay() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // try {
    //   var apiResult = await http.get(
    //     "${ListApi.getApiScheduleToDay(prefs.getString("email"))}",
    //     headers: {"key": "${prefs.getString("token")}"}
    //   );
    //   if (apiResult.statusCode == 200) {
    //     var result = TaskModel.fromJson(json.decode(apiResult.body));
    //     setState(() {
    //       _call = [];
    //       _email = [];
    //     });
    //     for (var i = 0; i < result.task.length; i++) {
    //       switch (result.task[i].activity) {
    //         case "visit":
    //           setState(() {
    //             _visit = result.task[i].client;
    //           });
    //           break;
    //         case "call":
    //           setState(() {
    //             _call.add(result.task[i].client);
    //           });
    //           break;
    //         case "email":
    //           setState(() {
    //             _email.add(result.task[i].client);
    //           });
    //           break;
    //       }
    //     }
    //     if (_visit == "Gagal memuat data") {
    //       setState(() {
    //         _visit = "Data tidak ditemukan";
    //       });
    //     }
    //     if (_call == null || _call.length <= 3) {
    //       _call.add("Data tidak ditemukan");
    //       _call.add("Data tidak ditemukan");
    //       _call.add("Data tidak ditemukan");
    //     }
    //     if (_email == null || _email.length <= 2) {
    //       _email.add("Data tidak ditemukan");
    //       _email.add("Data tidak ditemukan");
    //     }
    //   }
    //   else {
    //     _call.add("Gagal memuat data");
    //     _call.add("Gagal memuat data");
    //     _call.add("Gagal memuat data");
    //     _email.add("Gagal memuat data");
    //     _email.add("Gagal memuat data");
    //   }
    // } 
    // catch (e) {
    //   _call.add("Gagal memuat data");
    //   _call.add("Gagal memuat data");
    //   _call.add("Gagal memuat data");
    //   _email.add("Gagal memuat data");
    //   _email.add("Gagal memuat data");
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

  // Material untuk grid view
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

  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 3));
    _call.add("Gagal memuat data");
    _call.add("Gagal memuat data");
    _call.add("Gagal memuat data");
    _email.add("Gagal memuat data");
    _email.add("Gagal memuat data");
    _getDataSummary();
    _getScheduleToDay();
    _setDataLocal();
    _getRatingSales();
    return null;
  }

  // Tekan back untuk exit
  Future<bool> _confirmExit() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Anda yakin?"),
          content: Text("Anda akan keluar dari aplikasi ini!!"),
          actions: <Widget>[
            FlatButton(
              child: Text("Tidak"),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            FlatButton(
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _confirmExit,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.blue),
          title: Text(
            "Dashboard",
            style: TextStyle(
              // fontFamily: 'Nunito-Black',
              fontSize: 20.0,
              // letterSpacing: 0.5,
              color: Colors.blue,
              // fontWeight: FontWeight.bold
            ),
          ),
          actions: <Widget>[
            Stack(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.blue[300],
                  ),
                  onPressed: (){
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(builder: (context) => Notif())
                    // ).then((value) {
                    //   _refresh();
                    // });
                  },
                ),
                (_notif == 0 || _notif == null) ?
                Container() :
                Positioned(
                  top: 2.0,
                  right: 4.0,
                  child: Container(
                    padding: EdgeInsets.all(1.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle
                    ),
                    constraints: BoxConstraints(
                      minWidth: 18.0,
                      minHeight: 18.0,
                    ),
                    child: Center(
                      child: Text(
                        "$_notif",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/background/background_login2.jpg"),
                    fit: BoxFit.cover),
                ),
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
                    // ListTile(
                    //   leading: Container(
                    //     width: 40.0,
                    //     height: 40.0,
                    //     decoration: BoxDecoration(
                    //       color: Colors.teal[300],
                    //       borderRadius: BorderRadius.circular(8.0)
                    //     ),
                    //     child: Icon(
                    //       Icons.vpn_key, 
                    //       size: 30.0,
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    //   title: Text("Encrypt & Decrypt"),
                    //   onTap: (){
                    //     Navigator.of(context).push(
                    //       MaterialPageRoute(builder: (context) => DesBener())
                    //     );
                    //   },
                    // ),
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
                        //   MaterialPageRoute(builder: (context) => DESLearn())
                        // );
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(builder: (context) => DesBener())
                        // );
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
                          Icons.group, 
                          size: 30.0,
                          color: Colors.white,
                        ),
                      ),
                      title: Text("Kontak"),
                      onTap: (){
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(builder: (context) => Contact())
                        // );
                      },
                    ),
                    ListTile(
                      leading: Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: Colors.orange[300],
                          borderRadius: BorderRadius.circular(8.0)
                        ),
                        child: Icon(
                          Icons.event,
                          size: 30.0,
                          color: Colors.white,
                        ),
                      ),
                      title: Text("Jadwal"),
                      onTap: (){
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(builder: (context) => Plan())
                        // ).then((value) {
                        //   _refresh();
                        // });
                      },
                    ),
                    ExpansionTile(
                      leading: Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: Colors.indigo[300],
                          borderRadius: BorderRadius.circular(8.0)
                        ),
                        child: Icon(
                          Icons.event_note, 
                          size: 30.0,
                          color: Colors.white,
                        ),
                      ),
                      title: Text("Status"),
                      children: <Widget>[
                        ListTile(
                          leading: SizedBox(),
                          title: Text("Leads"),
                          subtitle: Text(_textLeads),
                          onTap: (){
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(builder: (context) => Leads(manager: false,))
                            // ).then((value) {
                            //   _refresh();
                            // });
                          },
                        ),
                        ListTile(
                          leading: SizedBox(),
                          title: Text("Connecting"),
                          subtitle: Text(_textConnecting),
                          onTap: (){
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(builder: (context) => Connecting(manager: false,))
                            // ).then((value) {
                            //   _refresh();
                            // });
                          },
                        ),
                        ListTile(
                          leading: SizedBox(),
                          title: Text("Prospect"),
                          subtitle: Text(_textProspect),
                          onTap: (){
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(builder: (context) => Prospect(manager: false,))
                            // ).then((value) {
                            //   _refresh();
                            // });
                          },
                        ),
                        ListTile(
                          leading: SizedBox(),
                          title: Text("Hot Prospect"),
                          subtitle: Text(_textHotProspect),
                          onTap: (){
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(builder: (context) => HotProspect(manager: false,))
                            // ).then((value) {
                            //   _refresh();
                            // });
                          },
                        ),
                        ListTile(
                          leading: SizedBox(),
                          title: Text("Won"),
                          subtitle: Text(_textWon),
                          onTap: (){
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(builder: (context) => Won(manager: false,))
                            // ).then((value) {
                            //   _refresh();
                            // });
                          },
                        ),
                        ListTile(
                          leading: SizedBox(),
                          title: Text("Lose"),
                          subtitle: Text(_textLose),
                          onTap: (){
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(builder: (context) => Lose(manager: false,))
                            // ).then((value) {
                            //   _refresh();
                            // });
                          },
                        ),
                      ],
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
        // floatingActionButton: SpeedDial(
        //   // child: Icon(Icons.add,),
        //   animatedIcon: AnimatedIcons.add_event, 
        //   foregroundColor: Colors.white,
        //   backgroundColor: Colors.blue[200],
        //   children: [
        //     SpeedDialChild(
        //       child: Icon(Icons.person_add),
        //       label: "Tambah Klien Baru",
        //       labelBackgroundColor: Color(0XFF5E96EA),
        //       labelStyle: TextStyle(color: Colors.white),
        //       backgroundColor: Color(0XFF5E96EA),
        //       onTap: (){
        //         Navigator.of(context).push(
        //           MaterialPageRoute(builder: (context) => AddNewClient())
        //         ).then((value) {
        //           _refresh();
        //         });
        //       }
        //     ),
        //     SpeedDialChild(
        //       child: Icon(Icons.group_add),
        //       label: "Tambah Leads Produk",
        //       labelBackgroundColor: Color(0XFF5E8B88),
        //       labelStyle: TextStyle(color: Colors.white),
        //       backgroundColor: Color(0XFF5E8B88),
        //       onTap: (){
        //         Navigator.of(context).push(
        //           MaterialPageRoute(builder: (context) => AddExistingClient())
        //         ).then((value) {
        //           _refresh();
        //         });
        //       }
        //     ),
        //   ],
        // ),
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _refresh,
          child: StaggeredGridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            children: <Widget>[
              // _buildTile(
              //   FutureBuilder(
              //     future: _example(),
              //     builder: (BuildContext context, AsyncSnapshot s) {
              //       if (s.connectionState == ConnectionState.done) {
              //         if (s.hasData) {
                        
              //         }
              //         else {
              //           return Center(
              //             child: Text("Tidak Ada Data"),
              //           );
              //         }
              //       }
              //       else {
              //         return Center(
              //           child: SpinKitThreeBounce(color: Colors.blue[200], size: 30.0,)
              //         );
              //       }
              //     }
              //   )
              // ),
              _buildTile(
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "POTENSI",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.green[400]
                        ),
                      ),
                      SizedBox(height: 6.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Target', 
                                style: TextStyle(
                                  fontSize: 16.0,
                                )
                              ),
                              Text(
                                _textTargetEkspektasi,
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Potensi', 
                                style: TextStyle(
                                  fontSize: 16.0,
                                )
                              ),
                              Text(
                                _textRealisasiEkspektasi,
                              )
                            ],
                          ),
                        ]
                      ),
                      // SizedBox(height: 10.0,),
                      // Container(
                      //   child: CircularPercentIndicator(
                      //     radius: 120.0,
                      //     lineWidth: 13.0,
                      //     animation: true,
                      //     percent: (_persentaseEkspektasi > 1.0) ? 1.0 : _persentaseEkspektasi,
                      //     progressColor: _colorPersentaseEkspektasi,
                      //     center: Text(
                      //       "${(_persentaseEkspektasi*100).round()}%",
                      //       style: TextStyle(
                      //         fontWeight: FontWeight.bold,
                      //         fontSize: 18.0
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
              _buildTile(
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "REALISASI",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.green[400]
                        ),
                      ),
                      SizedBox(height: 6.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Target', 
                                style: TextStyle(
                                  fontSize: 16.0,
                                )
                              ),
                              Text(
                                _textTargetRealita,
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Realisasi', 
                                style: TextStyle(
                                  fontSize: 16.0,
                                )
                              ),
                              Text(
                                _textRealisasiRealita,
                              )
                            ],
                          ),
                        ]
                      ),
                      // Container(
                      //   child: CircularPercentIndicator(
                      //     radius: 120.0,
                      //     lineWidth: 13.0,
                      //     animation: true,
                      //     percent: (_persentaseRealita > 1.0) ? 1.0 : _persentaseRealita,
                      //     progressColor: _colorPersentaseRealita,
                      //     center: Text(
                      //       "${(_persentaseRealita*100).round()}%",
                      //       style: TextStyle(
                      //         fontWeight: FontWeight.bold,
                      //         fontSize: 18.0
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
              _buildTile(
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                'Jadwal Hari Ini', 
                                style: TextStyle(
                                  color: Colors.orange[400],
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18.0
                                )
                              ),
                            ],
                          ),
                          Container(
                            width: 55.0,
                            height: 55.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.orange[400],
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Icon(
                                  Icons.calendar_today, 
                                  color: Colors.white, 
                                  size: 25.0
                                ),
                              )
                            )
                          ),
                        ]
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.place, 
                              size: 35.0,
                              color: Colors.red[300],
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20.0),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Visit",
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width*0.6,
                                  height: 30.0,
                                  child: Text(
                                    _visit,
                                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.call, 
                              size: 35.0,
                              color: Colors.green[300],
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20.0),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Call",
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width*0.6,
                                  height: 30.0,
                                  child: Text(
                                    _call[0],
                                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width*0.6,
                                  height: 30.0,
                                  child: Text(
                                    _call[1],
                                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width*0.6,
                                  height: 30.0,
                                  child: Text(
                                    _call[2],
                                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.email, 
                              size: 35.0,
                              color: Colors.blue[300],
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20.0),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Email",
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width*0.6,
                                  height: 30.0,
                                  child: Text(
                                    _email[0],
                                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width*0.6,
                                  height: 30.0,
                                  child: Text(
                                    _email[1],
                                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Top 3 Sales",
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
            ],
            staggeredTiles: [
              StaggeredTile.extent(1, 240.0),
              StaggeredTile.extent(1, 240.0),
              StaggeredTile.extent(2, 350.0),
              StaggeredTile.extent(2, 360.0),
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