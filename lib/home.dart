import 'package:flutter/material.dart';
import 'package:sql_flutter/db_helper.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  await DatabaseHelper.instance.insertRecord({
                    DatabaseHelper.columnName: "Hello Data",
                    DatabaseHelper.columnAddress: "Kathmandu",
                    DatabaseHelper.columnPhone: "9789878987",
                  });
                },
                child: Text('Create')),
            ElevatedButton(
                onPressed: () async {
                  var readData = await DatabaseHelper.instance.readRecord();
                  print(readData);
                },
                child: Text('Read')),
            ElevatedButton(
                onPressed: () async {
                  await DatabaseHelper.instance.updateRecord({
                    DatabaseHelper.columnId: 1,
                    DatabaseHelper.columnName: 'This is Updated'
                  });
                },
                child: Text('Update')),
            ElevatedButton(
                onPressed: () async {
                  await DatabaseHelper.instance.deleteRecord(1);
                },
                child: Text('Delete')),
          ],
        ),
      ),
    );
  }
}
