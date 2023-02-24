import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file_safe/open_file_safe.dart';
import '../../../cubit/file_download_cubit/file_download_cubit.dart';
import '../../../cubit/file_download_cubit/file_download_state.dart';
import '../../../utils/download_data/download_data.dart';
import '../../../utils/my_utils/my_utils.dart';

class SecondPage extends StatelessWidget {
  SecondPage({Key? key, required this.fileInfo}) : super(key: key);
  final FileInfo fileInfo;

  FileManagerCubit fileManagerCubit = FileManagerCubit();
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: fileManagerCubit,
      child: BlocBuilder<FileManagerCubit, FileManagerState>(
        builder: (context, state) {
          return ListTile(
            leading: state.newFileLocation.isEmpty
                ? IconButton(
                onPressed: () {
                  if(state.progress == 0.0 ) {
                    context
                        .read<FileManagerCubit>()
                        .dawnloadIfExis(fileInfo: fileInfo);
                  }else if(state.progress > 0.0) {
                    context
                        .read<FileManagerCubit>()
                        .stopped(stopped: false);
                  }
                },
                icon: Icon(Icons.download))
                : const Icon(Icons.download_done),
            title: Text("${fileInfo.fileName}: ${state.progress * 100}%"),
            subtitle: LinearProgressIndicator(
              value: state.progress,
              backgroundColor: Colors.black,
            ),
            trailing: IconButton(
              onPressed: () {
                if (state.newFileLocation.isNotEmpty) {
                  OpenFile.open(state.newFileLocation);
                }else if(state.progress < 100){
                  context
                      .read<FileManagerCubit>()
                      .dawnloadIfExis(fileInfo: fileInfo);
                  MyUtils.getMyToast(message: " Yuklash jarayonda");
                }
              },
              icon: const Icon(Icons.file_open),
            ),
          );
        },
      ),
    );
  }
}
