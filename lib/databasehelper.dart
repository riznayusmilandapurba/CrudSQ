import 'package:crudsq/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  final String tabelPegawai = "tbpegawai";
  final String columnId = "id";
  final String columnFirstName = "firstname";
  final String columnLastName = "lastname";
  final String columnMobileNo = "mobileno";
  final String columnEmailId = "emailid";
  Database? db;

  Future<Database?> cekDatabase() async {
    if (db != null) {
      return db;
    }
    db = await initDb();
    return db;
  }

  initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "pegawai.db");
    var db = openDatabase(path, version: 1, onCreate: onCreate);
    return db;
  }

  void onCreate(Database db, int newVersion) async {
    await db.execute(
    'CREATE TABLE $tabelPegawai($columnId INTEGER PRIMARY KEY,$columnFirstName TEXT, $columnLastName TEXT, $columnMobileNo TEXT,$columnEmailId TEXT)');
  }

  Future<int?> savePegawai(ModelPegawai pegawai) async {
    var dbClient = await cekDatabase();
    var result = dbClient!.insert(tabelPegawai, pegawai.toMap());
    print("insert data $result");
    return result;
  }

  Future<List?> getAllPegawai() async {
    var dbClient = await cekDatabase();
    var result = await dbClient!.query(tabelPegawai, columns: [
      columnId,
      columnFirstName,
      columnLastName,
      columnMobileNo,
      columnEmailId
    ]);
    return result;
  }
  Future<int?> updatePegawai(ModelPegawai pegawai) async {
    var dbClient = await cekDatabase();
    var result = dbClient!.update(tabelPegawai, pegawai.toMap(),
    where: "$columnId = ?", whereArgs: [pegawai.id]);
    return result;
  }
  Future<int?> deletePegawai(int id) async {
    return await db!
    .delete(tabelPegawai, where: "$columnId = ?", whereArgs:
    [id]);
  }
}