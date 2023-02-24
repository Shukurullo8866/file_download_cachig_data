import 'package:file_download_cachig_data/screens/tab_box/download_page/second_page.dart';
import 'package:flutter/material.dart';

import '../../../utils/download_data/download_data.dart';


class DownloadPage extends StatefulWidget {
  const DownloadPage({Key? key}) : super(key: key);

  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  int doublePress = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Download "),
      ),
      body: SizedBox(
        height: 700,
        child: ListView(
          shrinkWrap: true,
          children: List.generate(
            filesData.length,
                (index) {
              var fileInfo = filesData[index];
              return SecondPage(fileInfo: fileInfo);
            },
          ),
        ),
      ),
    );
  }
}