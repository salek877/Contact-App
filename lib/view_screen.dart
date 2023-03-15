import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewScreen extends StatefulWidget {
  const ViewScreen({Key? key}) : super(key: key);

  @override
  _ViewScreenState createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  @override
  List userDetailsList = [];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact"),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: userDetailsList.length,
                    itemBuilder: (buildContext, index) {
                      return Card(
                          child: Container(
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 22,
                            backgroundImage: NetworkImage(
                                "https://avatars.githubusercontent.com/u/24518666?v=4"),
                          ),
                          title: Text("${userDetailsList[index]["name"]}"),
                          subtitle: Text("${userDetailsList[index]["mobile"]}"),
                          trailing: Wrap(
                            children: [
                              IconButton(
                                  onPressed: () {}, icon: Icon(Icons.web)),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.location_on,
                                    color: Colors.green,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    launch(
                                        "tel://${userDetailsList[index]["mobile"]}");
                                  },
                                  icon: Icon(
                                    Icons.call,
                                    color: Colors.blue,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    print("Delete pressed");
                                    setState(() {
                                      userDetailsList.removeAt(index);
                                    });
                                  },
                                  icon: Icon(Icons.delete, color: Colors.red)),
                            ],
                          ),
                        ),
                      ));
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
