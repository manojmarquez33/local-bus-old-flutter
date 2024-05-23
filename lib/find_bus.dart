import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:dropdown_search/dropdown_search.dart';

void main() {
  runApp(const FindBus());
}

class FindBus extends StatelessWidget {
  const FindBus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Local Bus',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Local Bus'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;
  List<String> towns = [''];
  List<Map<String, dynamic>> data = [];
  String src = '', des = '';

  void setSrc(String? t) {
    setState(() {
      src = t ?? towns[0];
    });
  }

  void setDes(String? t) {
    setState(() {
      des = t ?? towns[0];
    });
  }

//-----------------------------fetch town names-----------------------------------------------------------------
  void fetchTowns() async {
    Response response =
        await get(Uri.parse('https://localbus33.000webhostapp.com/api.php'));
    List result = jsonDecode(response.body) as List;
    setState(() {
      towns.clear();

      for (Map<String, dynamic> item in result) {
        String? townName = item['name'];
        if (townName != null) towns.add(townName);
      }
    });
  }

  //-----------------------------Get bus infromation from API-----------------------------------------------------------------
  void search() async {
    setState(() {
      isLoading = true; // set the loading state to true
    });
    String url =
        'https://localbus33.000webhostapp.com/busapi.php?src=$src&&des=$des';
    Response response = await get(Uri.parse(url));
    setState(() {
      isLoading = false; // set the loading state to false
      data.clear();
      List items = jsonDecode(response.body) as List;
      for (Map<String, dynamic> item in items) {
        data.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    fetchTowns();
    return Scaffold(
      // <-- add this line
      appBar: AppBar(
        title: Text("Find Your Bus"),
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
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //-----------------------------Dropdown source-----------------------------------------------------------------
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 20.0),
                    child: DropdownSearch<String>(
                      mode: Mode.MENU,
                      showSearchBox: true,
                      items: towns,
                      label: "Source",
                      hint: "Select source",
                      selectedItem: src,
                      onChanged: setSrc,
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 60,
                    height: 45,
                    child: FloatingActionButton(
                      backgroundColor: Color(0xFF070A52),
                      child: Icon(Icons.swap_vert_outlined),
                      onPressed: () {
                        setState(() {
                          final temp = src;
                          src = des;
                          des = temp;
                        });
                      },
                    ),
                  ),
                ],
              ),

              //-----------------------------Dropdown destination-----------------------------------------------------------------
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 20.0),
                    child: DropdownSearch<String>(
                      mode: Mode.MENU,
                      showSearchBox: true,
                      items: towns,
                      label: "Destination",
                      hint: "Select destination",
                      selectedItem: des,
                      onChanged: setDes,
                    ),
                  ),
                ],
              ),
            ],
          ),

          //-----------------------------Button to Search buses -----------------------------------------------------------------
          TextButton.icon(
            icon: const Icon(Icons.directions_bus_filled_rounded,
                color: Colors.white),
            onPressed: isLoading ? null : search,
            label: isLoading
                ? Text('Finding Buses...',
                    style: TextStyle(color: Colors.white))
                : const Text(
                    'Find Bus',
                    style: TextStyle(color: Colors.white),
                  ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.purple,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : data.isEmpty
                    ? Center(child: Text('No buses found'))
                    : ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, i) => BusCard(data: data[i])),
          ),
        ],
      ),
    );
  }
}

//-----------------------------Listview shows the bus information-----------------------------------------------------------------
class BusCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const BusCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
            color: Color(0xfff0f8ff), borderRadius: BorderRadius.circular(12)),
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['src_name']!,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      data['src_district']!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const Text(
                  '→',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      data['des_name']!,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      data['des_district']!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Container(
                  height: 22,
                  //child: Image.asset('lib/icons/way.png'),
                ),
                Expanded(
                  child: Text(
                    data['distance'] + ', via ' + data['inter_towns']!,
                    maxLines: 2,
                    // overflow: TextOverflow.ellipsis,

                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Container(
                  height: 22,
                  //child: Image.asset('lib/icons/bus.png'),
                ),
                Text(
                  data['bus_id'] + ' , ' + data['bus_type'] + ' Bus',
                  maxLines: 2,
                  // overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 1.5),
                  height: 22,
                  //child: Image.asset('lib/icons/arrival.png'),
                ),
                Text(
                  data['arrival_time'],
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  height: 22,
                  //child: Image.asset('lib/icons/departure.png'),
                ),
                Text(
                  data['departure_time'],
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(
                  width: 16,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  height: 20,
                  //child: Image.asset('lib/icons/duration.png'),
                ),
                Text(
                  data['duration'],
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
