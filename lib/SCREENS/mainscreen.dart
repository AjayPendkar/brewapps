import 'dart:collection';

import 'package:brewapps/APIcalls/api.dart';
import 'package:brewapps/MODELS/now_playing_model.dart';
import 'package:brewapps/MODELS/top_rated.dart';
import 'package:brewapps/SCREENS/productscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({Key key}) : super(key: key);

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  var index;

  googleApiCall(BuildContext context) {
    Provider.of<ApiCalls>(context, listen: false).fetchPost();
  }

  toprtd(BuildContext context) {
    Provider.of<ApiCalls>(context, listen: false).topratedpost();
  }

  String _searchString = "";
  List<Movie> _mymovie = [];

  UnmodifiableListView<Movie> get movie1 => _searchString.isEmpty
      ? UnmodifiableListView(_mymovie)
      : UnmodifiableListView(_mymovie.where(
          (movie1) => movie1.results[index].title.contains(_searchString)));

  void changeSearchString(String searchString) {
    _searchString = searchString;
    print(_searchString);
    // notifyListeners();
  }

  @override
  void initState() {
    _controller.addListener(
      () {
        setState(() {
          _searchText = _controller.text;
        });
      },
    );

    super.initState();

    googleApiCall(context);
    toprtd(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool issearching = false;
  String _searchText;
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.orange[300],
        appBar: AppBar(
          backgroundColor: Colors.orange[300],
          centerTitle: true,
          title: !issearching
              ? Text("Movi list")
              : Padding(
                  padding: EdgeInsets.only(top: 50, bottom: 50),
                  child: TextField(
                    onChanged: (value) {
                      Provider.of<ApiCalls>(context, listen: false)
                          .topratedpost();
                    },
                    controller: _controller,
                    // controller: editingController,
                    decoration: InputDecoration(
                        labelText: "Search",
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)))),
                  ),
                ),
          actions: [
            InkWell(
                onTap: () {
                  setState(() {
                    this.issearching = !this.issearching;
                  });
                },
                child: Icon(Icons.search))
          ],
        ),
        bottomNavigationBar: tabbar(),
        body: TabBarView(
          children: [
            listtile(),
            topratd(),
          ],
        ),
      ),
    );
  }

  Widget listtile() {
    Movie movie;
    return Container(
      child: FutureBuilder<Movie>(
          future: Provider.of<ApiCalls>(context, listen: false).fetchPost(),
          builder: (context, snapshot) {
            // print(snapshot.data.results[index].title);
            return (snapshot.data != null)
                ? ListView.builder(
                    itemCount: snapshot.data.results.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Productscreen(
                                        relesedate: snapshot
                                            .data.results[index].releaseDate,
                                        title:
                                            snapshot.data.results[index].title,
                                        bgimage:
                                            "https://image.tmdb.org/t/p/w342" +
                                                snapshot.data.results[index]
                                                    .backdropPath,
                                        shortnotes: snapshot
                                            .data.results[index].overview,
                                        popularity: snapshot
                                            .data.results[index].popularity
                                            .toString(),
                                      ))),
                          child: ListTile(
                            title: Text(
                              snapshot.data.results[index].title,
                              maxLines: 2,
                            ),
                            subtitle: Text(
                              snapshot.data.results[index].overview,
                              maxLines: 2,
                            ),
                            leading: ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: 100,
                                minHeight: 300,
                                maxWidth: 104,
                                maxHeight: 304,
                              ),
                              child: Image.network(
                                  "https://image.tmdb.org/t/p/w342" +
                                      snapshot.data.results[index].posterPath,
                                  fit: BoxFit.fill),
                            ),
                          ),

                          // Image.network(
                          //     "https://image.tmdb.org/t/p/w342" +
                          //         snapshot.data.results[index].posterPath),
                        ),
                      );
                    })
                : Center(
                    child: CircularProgressIndicator(
                      value: 0.8,
                    ),
                  );
          }),
    );
  }

  Widget topratd() {
    Topmovie topmovie;
    return Container(
      child: FutureBuilder<Topmovie>(
          future: Provider.of<ApiCalls>(context, listen: false).topratedpost(),
          builder: (context, snapshot) {
            // print(snapshot.data.results[index].title);
            return (snapshot.data != null)
                ? ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                          color: Colors.black,
                          thickness: 2,
                        ),
                    itemCount: snapshot.data.results.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Productscreen(
                                        relesedate: snapshot
                                            .data.results[index].releaseDate,
                                        title:
                                            snapshot.data.results[index].title,
                                        bgimage:
                                            "https://image.tmdb.org/t/p/w342" +
                                                snapshot.data.results[index]
                                                    .backdropPath,
                                        shortnotes: snapshot
                                            .data.results[index].overview,
                                        popularity: snapshot
                                            .data.results[index].popularity
                                            .toString(),
                                      ))).then((_) {
                            toprtd(context);
                          }),
                          child: ListTile(
                            title: Text(
                              snapshot.data.results[index].title,
                              maxLines: 2,
                            ),
                            subtitle: Text(
                              snapshot.data.results[index].overview,
                              maxLines: 2,
                            ),
                            leading: Image.network(
                                "https://image.tmdb.org/t/p/w342" +
                                    snapshot.data.results[index].posterPath),
                          ),
                        ),
                      );
                    })
                : Center(
                    child: CircularProgressIndicator(
                      value: 0.8,
                    ),
                  );
          }),
    );
  }

  Widget tabbar() {
    return Container(
      color: Colors.orange[300],
      child: TabBar(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.all(5.0),
        indicatorColor: Colors.blue,
        tabs: [
          Tab(
            text: "MovieList",
            icon: Icon(Icons.euro_symbol),
          ),
          Tab(
            text: "Rating",
            icon: Icon(Icons.assignment),
          ),
        ],
      ),
    );
  }
}
