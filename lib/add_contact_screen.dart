import 'package:flutter/material.dart';
import 'package:my_contact/custom_textfield_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ImportData extends StatefulWidget {
  @override
  _ImportDataState createState() => _ImportDataState();
}

class _ImportDataState extends State<ImportData> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController mobileCtrl = TextEditingController();
  final TextEditingController addressCtrl = TextEditingController();

  List userDetailsList = [];

  dataAddToList() {
    setState(() {
      userDetailsList.add({
        "name": "${nameCtrl.text}",
        "mobile": "${mobileCtrl.text}",
        "address": "${addressCtrl.text}",
      });
    });
    print(userDetailsList);
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact"),
        centerTitle: true,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Form(
          key: _formKey,
          child: Container(
            height: _height,
            width: _width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  child: Wrap(
                    children: [
                      //<========================================for Name
                      CustomTextField(
                        keyboardType: TextInputType.name,
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        labelText: "Name",
                        controller: nameCtrl,
                        validator: (value) {
                          if (value!.isEmpty || value.length == 0) {
                            return "Name field is reqired";
                          } else if (value.length < 3) {
                            return "Enter a valid name";
                          }
                          return null;
                        },
                      ),
                      //<========================================for Mobile
                      CustomTextField(
                        keyboardType: TextInputType.number,
                        prefixIcon: Icon(
                          Icons.call,
                          color: Colors.blue,
                        ),
                        labelText: "Mobile No.",
                        controller: mobileCtrl,
                        validator: (value) {
                          if (value!.isEmpty || value.length == 0) {
                            return "Name field is reqired";
                          } else if (value.length < 10) {
                            return "Enter a valid mobile number";
                          }
                          return null;
                        },
                      ),

                      //<========================================for Address
                      CustomTextField(
                        keyboardType: TextInputType.streetAddress,
                        prefixIcon: Icon(Icons.web, color: Colors.green),
                        labelText: "Website",
                        controller: addressCtrl,
                      ),

                      SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                dataAddToList();
                                nameCtrl.clear();
                                mobileCtrl.clear();
                                addressCtrl.clear();
                                print("Valid");
                              } else {
                                print("Invalid");
                              }
                            },
                            child: Text("Add")),
                      ),

                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
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
                              title: Text("${userDetailsList[index]["name"]}"),
                              subtitle:
                                  Text("${userDetailsList[index]["mobile"]}"),
                              trailing: Wrap(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        launch(
                                            "${userDetailsList[index]["address"]}");
                                      },
                                      icon: Icon(
                                        Icons.web,
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
                                      icon: Icon(Icons.delete,
                                          color: Colors.red)),
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
        ),
      ),
    );
  }
}
