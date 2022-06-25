import 'package:flutter/material.dart';
import 'package:resep_makanan/model/resep.api.dart';
import 'package:resep_makanan/views/detail_resep.dart';
import 'package:resep_makanan/views/widget/resep_card.dart';
import '../model/resep.dart';

class Homepage extends StatefulWidget {
  Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late List<Resep> _resep;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getResep();
  }

  Future<void> getResep() async {
    _resep = await ResepApi.getResep();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.restaurant_menu),
              SizedBox(width: 10),
              Text('Resep Makanan')
            ],
          ),
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _resep.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: ResepCard(
                      title: _resep[index].name,
                      rating: _resep[index].rating.toString(),
                      cookTime: _resep[index].totalTime,
                      thumbnailUrl: _resep[index].images,
                      videoUrl: _resep[index].videoUrl,
                    ),
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailResep(
                                  name: _resep[index].name,
                                  rating: _resep[index].rating.toString(),
                                  totalTime: _resep[index].totalTime,
                                  images: _resep[index].images,
                                  description: _resep[index].description,
                                  videoUrl: _resep[index].videoUrl,
                                  instructions: _resep[index].instructions,
                                  sections: _resep[index].sections,
                                )),
                      )
                    },
                  );
                }));
  }
}
