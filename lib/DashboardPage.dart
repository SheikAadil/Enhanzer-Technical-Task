import 'package:enhanzer_technical_test_task/DatabaseHelper.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Map<String, dynamic>? _userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final data = await DatabaseHelper.instance.getUserData();
    setState(() {
      _userData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Dashboard', style: TextStyle(color: Colors.deepPurple)),
        backgroundColor: Colors.greenAccent,
      ),
      body: Center(
        child: _userData == null
            ? const CircularProgressIndicator()
            : Card(
                margin: const EdgeInsets.all(16.0),
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.person,
                            size: 50, color: Colors.greenAccent),
                        title: Text(
                          _userData!['User_Display_Name'],
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple),
                        ),
                        subtitle: Text(
                          _userData!['Email'],
                          style: const TextStyle(
                              fontSize: 16, color: Colors.deepPurple),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Divider(),
                      Text(
                        'User Code: ${_userData!['User_Code']}',
                        style: const TextStyle(
                            fontSize: 16, color: Colors.deepPurple),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Employee Code: ${_userData!['User_Employee_Code']}',
                        style: const TextStyle(
                            fontSize: 16, color: Colors.deepPurple),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Company Code: ${_userData!['Company_Code']}',
                        style: const TextStyle(
                            fontSize: 16, color: Colors.deepPurple),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
