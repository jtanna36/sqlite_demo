import 'package:get/get.dart';
import 'package:sqlite_demo/model/Employee.dart';
import 'package:sqlite_demo/provider/db_provider.dart';
import 'package:sqlite_demo/provider/employee_api_provider.dart';

class DataController extends GetxController{
  var isLoading = false.obs;
  var check_val_list = [].obs;
  List<Employee> list = new List<Employee>().obs;

  loadFromApi() async {
    isLoading.value = true;

    var apiProvider = EmployeeApiProvider();
    await apiProvider.getAllEmployees();

    // wait for 2 seconds to simulate loading of data
    await Future.delayed(const Duration(seconds: 3));

    isLoading.value = false;

    getEmployeList();
  }

  deleteData() async {
    isLoading.value = true;

    var result = await DBProvider.db.getAllEmployees();

    // wait for 1 second to simulate loading of data
    await Future.delayed(const Duration(seconds: 1));

    isLoading.value = false;

    print('All employees deleted');
    list.clear();
    list.addAll(await result);
  }

  getEmployeList() async {
    var result = DBProvider.db.getAllEmployees();
    if(result!=null){
      list.addAll(await result);
      for(int i=0;i<list.length;i++){
        check_val_list.add(false);
      }
    }
  }

  @override
  void onInit() {
    //getEmployeList();
    super.onInit();
  }
}