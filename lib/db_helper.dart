import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  //Variables
  static const dbName = "recentlyUpdated3.db";
  //Version of Database
  static const dbVersion = 1;
  //Table Name
  static const dbTable = "myTable";
  //Column
  static const columnId = "id";
  static const columnName = "name";
  static const columnAddress = "address";
  static const columnPhone = "phone";

  //Constructor
  static final DatabaseHelper instance = DatabaseHelper();

  //database initialize
  static Database? _database;

  // Initializing _database
  Future<Database?> get database async {
    _database ??= await initDB();

    return _database;
  }

  initDB() async {
//This gets location
    Directory directory = await getApplicationDocumentsDirectory();
    //This basically joins our directory and the database thus creating a complete path
    String path = join(directory.path, dbName);
    //This is a method Provided by Sqflite to open the datbase
    return await openDatabase(path, version: dbVersion, onCreate: onCreate);
  }

  Future onCreate(Database db, int version) async {
    //We pass add the SQL Command here
    db.execute(''' 
    CREATE TABLE $dbTable (
      $columnId INTEGER PRIMARY KEY, 
      $columnName TEXT NOT NULL,
      $columnAddress TEXT NOT NULL,
      $columnPhone TEXT NOT NULL
    )
    ''');
  }

  //Insert Method
  insertRecord(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(dbTable, row);
  }

  //Read Method
  Future<List<Map<String, dynamic>>> readRecord() async {
    Database? db = await instance.database;
    return await db!.query(dbTable);
  }

  //UpdateMethod
  Future<int> updateRecord(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int id = row[columnId];
    return await db!
        .update(dbTable, row, where: '$columnId=?', whereArgs: [id]);
  }

  //DeleteMethod
  Future<int> deleteRecord(int id) async {
    Database? db = await instance.database;
    return await db!.delete(dbTable, where: '$columnId = ?', whereArgs: [id]);
  }
}
