import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sqlite_demo/View/Update.dart';
import 'package:sqlite_demo/controllers/DataController.dart';
import 'package:sqlite_demo/provider/db_provider.dart';
import 'package:sqlite_demo/provider/employee_api_provider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  DataController controller = Get.put(DataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          //padding: EdgeInsets.only(right: 10.0),
          child: IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await controller.loadFromApi();
            },
          ),
        ),
        title: Text('Api to sqlite'),
        centerTitle: true,
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () async {
                await controller.deleteData();
              },
            ),
          ),
        ],
      ),
      body:GetX<DataController>(
       init: controller,
       builder: (val){
         if(controller.isLoading.value){
           return Center(
             child: CircularProgressIndicator(),
           );
         }
         else
           {
             return _buildEmployeeListView();
           }
       },
      )
    );
  }

  _buildEmployeeListView() {
    return GetX<DataController>(
      init: controller,
      builder: (val) {
        if (controller.list.length == 0) {
          return Container(

          );
        }
        else {
          return ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Colors.black12,
            ),
            itemCount: controller.list.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    DBProvider.db.deleteEmployee(controller.list[index].id);
                    //controller.list.removeAt(index);
                  },
                ),
                title: GestureDetector(
                  child: Text(
                      "Name: ${controller.list[index].firstName + controller.list[index].lastName} "),
                      onTap: ()=>Get.to(UpdateDetails()),
                ),
                subtitle: Text('EMAIL: ${controller.list[index].email}'),
              );
            },
          );
        }
      },
    );
  }
}