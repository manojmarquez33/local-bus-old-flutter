import 'package:bus_flutter/breakdown_report.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'find_bus.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Local Bus',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  /* void _shareApp() {
    final RenderBox box = context.findRenderObject() as RenderBox;
    Share.share(
      'Check out the Local Bus app!',
      subject: 'Local Bus',
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // <-- add this line
      appBar: AppBar(
        title: Text("Local Bus"),
        backgroundColor: Color(0xFF070A52),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF070A52),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/app_icon.png',
                    height: 64,
                    width: 64,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Local Bus',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Rate App'),
              onTap: () {
                // TODO: Implement rate app functionality
              },
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Rate App'),
              onTap: () {
                // TODO: Implement rate app functionality
              },
            ),
            ListTile(
              leading: Icon(Icons.bug_report),
              title: Text('Report Bug'),
              onTap: () {
                // TODO: Implement report bug functionality
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(5.0),
            height: 230,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Carousel(
                images: const [
                  AssetImage('assets/images/demo (1).jpg'),
                  AssetImage('assets/images/demo (2).jpg'),
                  AssetImage('assets/images/demo (3).jpg'),
                  AssetImage('assets/images/demo (4).jpg')
                ],
              ),
            ),
          ),
          SizedBox(height: 40),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            children: [
              _buildCard(Icons.directions_bus, 'Find Bus', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FindBus()),
                );
              }),
              _buildCard(Icons.map, 'Break Down Report', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BusBreakdownForm()),
                );
              }),
              _buildCard(Icons.person, 'About', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BusBreakdownForm()),
                );
              }),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'About',
          ),
        ],
      ),
    );
  }

  Widget _buildCard(IconData iconData, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 50,
            ),
            SizedBox(height: 16),
            Text(
              text,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
