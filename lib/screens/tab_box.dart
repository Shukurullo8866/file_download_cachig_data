import 'package:file_download_cachig_data/screens/tab_box/download_page/download_page.dart';
import 'package:flutter/material.dart';


class TabBox extends StatefulWidget {
  const TabBox({super.key});

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {

  int currentPage=0;
  @override
  Widget build(BuildContext context) {
    List pages = [
      const DownloadPage(),
      Container(),
      Container()

    ];
    return Scaffold(

      body: pages[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (value) {
          currentPage=value;
          setState(() {});
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.countertops_sharp),label: "Counter"),
          BottomNavigationBarItem(icon: Icon(Icons.download),label: "Download"),
          BottomNavigationBarItem(icon: Icon(Icons.add_card),label: "Add cart"),


        ],
      ),


    );
  }
}
