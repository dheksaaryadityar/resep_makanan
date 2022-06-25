import 'dart:convert';
import 'package:resep_makanan/model/resep.api.dart';
import 'package:http/http.dart' as http;
import 'package:resep_makanan/model/resep.dart';

class ResepApi {
// const req = unirest("GET", "https://yummly2.p.rapidapi.com/feeds/list");

// req.query({
// 	"limit": "24",
// 	"start": "0"
//  "tag": "list.recipe.popular"
// });

// req.headers({
// 	"X-RapidAPI-Key": "7e64b7d58amsh3434d84b7a16293p106f09jsn7e9373d687c5",
// 	"X-RapidAPI-Host": "yummly2.p.rapidapi.com",
// 	"useQueryString": true
// });

  static Future<List<Resep>> getResep() async {
    var uri = Uri.https('tasty.p.rapidapi.com', '/recipes/list',
        {"from": "0", "size": "50", "tags": "under_30_minutes"});

    final Response = await http.get(uri, headers: {
      "X-RapidAPI-Key": "7e64b7d58amsh3434d84b7a16293p106f09jsn7e9373d687c5",
      "X-RapidAPI-Host": "tasty.p.rapidapi.com",
      "useQueryString": "true"
    });

    Map data = jsonDecode(Response.body);

    List _temp = [];

    for (var i in data['results']) {
      _temp.add(i);
    }

    return Resep.resepFromSnapshot(_temp);
  }
}
