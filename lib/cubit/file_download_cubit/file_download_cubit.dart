import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import '../../utils/download_data/download_data.dart';
import '../../utils/my_utils/my_utils.dart';
import 'file_download_state.dart';

class FileManagerCubit extends Cubit<FileManagerState> {
  FileManagerCubit()
      : super(
    const FileManagerState(progress: 0.0, newFileLocation: "", stop: true),
  );
  void stopped({required bool stopped, stop}) async {
    stop == stopped;
  }

  void dawnloadIfExis({required FileInfo fileInfo, stop}) async {
    if (stop == false) {
      MyUtils.getMyToast(message: "Yuklash jarayoni tugadi");
    }else{

      Dio dio = Dio();
      var directory = await getDawnloadPath();
      print("Path: ${directory?.path}");
      String url = fileInfo.fileUrl;
      String newFileLocation =
          "${directory?.path}/${fileInfo.fileName}${DateTime.now().microsecond}${url.substring(url.length - 5, url.length)}";
      try {
        await dio.download(url, newFileLocation,
            onReceiveProgress: (received, total) {
              var pr = received / total;
              print(pr);
              emit(state.copyWith(progress: pr));
            });
        emit(state.copyWith(newFileLocation: newFileLocation));
      } catch (error) {
        debugPrint("Download Error:$error");
      }

    }
  }
}

Future<bool> _requestWritePermission() async {
  await Permission.storage.request();
  return await Permission.storage.request().isDenied;
}

Future<Directory?> getDawnloadPath() async {
  Directory? directory;
  try {
    if (Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
    } else {
      directory = Directory('/storage/emulated/0/Download');
      if (!await directory.exists()) {
        directory = await getExternalStorageDirectory();
      }
    }
  } catch (err) {
    debugPrint("Cannot get download folder path");
  }
  return directory;
}
