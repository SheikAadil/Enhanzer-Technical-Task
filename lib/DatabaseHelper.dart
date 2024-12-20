import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('user_data.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            User_Code TEXT,
            User_Display_Name TEXT,
            Email TEXT,
            User_Employee_Code TEXT,
            Company_Code TEXT
          )
        ''');
      },
    );
  }

  Future<void> saveUserData(Map<String, dynamic> userData) async {
    final db = await instance.database;
    await db.insert(
      'users',
      {
        'User_Code': userData['User_Code'],
        'User_Display_Name': userData['User_Display_Name'],
        'Email': userData['Email'],
        'User_Employee_Code': userData['User_Employee_Code'],
        'Company_Code': userData['Company_Code'],
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getUserData() async {
    final db = await instance.database;
    final result = await db.query('users');

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }
}
