import 'package:flutter/material.dart';

void main() {
  runApp(ListViewSearch());
}

class ListViewSearch extends StatefulWidget {
  @override
  _ListViewSearchState createState() => _ListViewSearchState();
}

class _ListViewSearchState extends State<ListViewSearch> {
  final searchTextFromController = new TextEditingController();

  final items = List<String>.generate(10000, (i) => 'Item No $i');
  final copyItemList = List<String>();

  @override
  void initState() {
    copyItemList.addAll(items); //copying original list as backup
    super.initState();
  }

  void filteringSercahItems(String query) {
    //List<String> filterSearchItems = List<String>();
    //filterSearchItems.addAll(dummyItems);
    if (query.isNotEmpty) {
      List<String> filterItmes = List<String>(); // use list for filtering items
      copyItemList.forEach((value) {
        if (value.contains(query)) {
          filterItmes.add(value);
        }
      });
      setState(() {
        items.clear();
        items.addAll(filterItmes);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(copyItemList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      title: "List View Search",
      home: Scaffold(
        appBar: AppBar(
          title: Text("List View Serach"),
        ),
        body: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 50,
                child: TextFormField(
                  controller: searchTextFromController,
                  textInputAction: TextInputAction.search,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                  onChanged: (value) {
                    filteringSercahItems(value);
                  },
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 10.0),
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: ((context, index) {
                      return ListTile(
                        leading: Icon(
                          Icons.tag,
                          color: Colors.orange[600],
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_outlined,
                          color: Colors.orange[400],
                        ),
                        title: Text(items[index].toString()),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
