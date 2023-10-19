import 'package:get/get.dart';

class HeaderController extends GetxController {
  var indexHeader = 0.obs;

  void onPageChanged(int index) {
    indexHeader.value = index;
  }
}
