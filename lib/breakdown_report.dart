import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bus Breakdown Report Form',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bus Breakdown Report Form'),
        ),
        body: BusBreakdownForm(),
      ),
    );
  }
}

class BusBreakdownForm extends StatefulWidget {
  @override
  _BusBreakdownFormState createState() => _BusBreakdownFormState();
}

class _BusBreakdownFormState extends State<BusBreakdownForm> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final sourceController = TextEditingController();
  final destinationController = TextEditingController();
  final busNumberController = TextEditingController();
  final breakdownPlaceController = TextEditingController();

  Future<void> submitForm() async {
    final String url = 'http://yourdomain.com/insert.php';

    final response = await http.post(Uri.parse(url), body: {
      'name': nameController.text,
      'phone': phoneController.text,
      'source': sourceController.text,
      'destination': destinationController.text,
      'bus_number': busNumberController.text,
      'breakdown_place': breakdownPlaceController.text,
    });

    if (response.statusCode == 200) {
      print('Form data inserted successfully');
    } else {
      print('Error inserting form data: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Phone',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
            ),
            TextFormField(
              controller: sourceController,
              decoration: InputDecoration(
                labelText: 'Bus Source',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the bus source';
                }
                return null;
              },
            ),
            TextFormField(
              controller: destinationController,
              decoration: InputDecoration(
                labelText: 'Bus Destination',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the bus destination';
                }
                return null;
              },
            ),
            TextFormField(
              controller: busNumberController,
              decoration: InputDecoration(
                labelText: 'Bus Number',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the bus number';
                }
                return null;
              },
            ),
            TextFormField(
              controller: breakdownPlaceController,
              decoration: InputDecoration(
                labelText: 'Breakdown Place',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the breakdown place';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            Center(
                child: ElevatedButton(
              //onPressed: _submitForm,
              onPressed: () {},
              child: Text('Submit'),
            )),
            SizedBox(height: 16.0),
            Text('Emergency'),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Card(
                  child: InkWell(
                    //onTap: _callPolice,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Icon(Icons.local_police),
                          SizedBox(height: 8.0),
                          Text('Call Police'),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  child: InkWell(
                    // onTap: _callAmbulance,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Icon(Icons.local_hospital),
                          SizedBox(height: 8.0),
                          Text('Call Ambulance'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
