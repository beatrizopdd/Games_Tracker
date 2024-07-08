import 'database_controller.dart';

import 'package:sqflite/sqflite.dart';
import '../controller/genre_controller.dart';
import '../model/game.dart';


class GameController {
  static final String tableName = "game";
  static Database? db;

  static Future<Database?> get _db async {
    return db ??= await DatabaseController.db;
  }
  static Future<void> printaTableGame() async {
    var database = await _db;
    List<Map<String, dynamic>> result = await database!.query('game');
    print("\n");
    print("\n");
    print("\n");
    print("\n");
    print("\n");
    for (var row in result) {
      print(row);
    }
    print("\n");
    print("\n");
    print("\n");
    print("\n");
    print("\n");
  }

  static Future<int> insertGame(int user_id,  String name,String description,String release_date,String genre) async {
    var database = await _db;

    int result = await database!
        .insert('game', {'user_id': user_id,'name': name, 'description': description, 'release_date': release_date});

    int res_gen = await GenreController.insertGenre(genre);//Atribui à alguém só para printar.
    //mandar id do game pra genre_game e o id do genre pra la também, o res_gen e o result geram os ids
    print(result);
    return result;
  }


  static Future<int> deleteGame(String name) async {
    var database = await _db;

    int result =
        await database!.delete(tableName, where: "name = ?", whereArgs: [name]);

    return result;
  }

  static Future<Game?> findGame(String name) async{
    String table = 'game';
    List<String> columns = ['id','user_id', 'name', 'release_date', 'description'];
    String where = 'name LIKE ?';
    List<dynamic> whereArgs = [name];

    // Executando a consulta
    var database = await _db;
    List<Map<String, dynamic>> result = await database!.query(
      table,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
    );

    // Verificando se a lista não está vazia antes de criar o jogo

    Game? game;
    if (result.isNotEmpty) {
      game = Game.fromMap(result.first);
    }

    // Imprimindo o jogo para verificar o mapeamento

    if (game != null) {
      print(
          'ID: ${game.id}, User_ID: ${game.user_id} Name: ${game.name}, Release_Date: ${game.release_date}, Decription: ${game.description}');
    } else {
      print('Nenhum usuário encontrado na lista.');
    }
    return game;
  }


  //cadastro
  static Future<int> cadastraGame(
      int user_id,String name, String description, String release_date,String genre) async {
    if (name == '' || description == '' || release_date == '' || genre == '' || user_id < 1) {
      return 0;
    }

    // Definindo os parâmetros para a consulta
    String table = 'game';
    List<String> columns = ['id','user_id', 'name', 'description', 'release_date'];
    String where = 'name LIKE ?';
    List<dynamic> whereArgs = [name];
    String? groupBy;
    String? having;
    String? orderBy;
    int? limit;
    int? offset;

    // Executando a consulta
    var database = await _db;
    List<Map<String, dynamic>> result = await database!.query(
      table,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
      groupBy: groupBy,
      having: having,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );

    //Realizar a mesma coisa que o Fred fez na área de register para a área de cadastro de jogo novo.
    if (result.isEmpty) {
      return insertGame(user_id, name, description, release_date, genre);
    } else {
      return -1;
    }
  }

}