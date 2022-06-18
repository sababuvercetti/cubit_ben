import 'package:ben_salcie/cubit/get_users_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavigationIndexCubit(),
      child: BlocProvider(
        create: (context) => ActiveMusicCubit(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          home: MyHomePage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  var tabs = ['Home', 'Chat', 'Calls'];

  @override
  Widget build(BuildContext context) {
    var pages = [
      Container(
        color: Colors.blue,
        child: Center(
          child: ElevatedButton(
            child: const Text('Home'),
            onPressed: () {
              context.read<ActiveMusicCubit>().chan('Ali kiba');
            },
          ),
        ),
      ),
      Container(
        color: Colors.green,
      ),
      Container(
        color: Colors.yellow,
      ),
    ];
    return Scaffold(
      body: pages[context.watch<BottomNavigationIndexCubit>().state],
      floatingActionButton: Container(
        color: Colors.red,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(context.watch<ActiveMusicCubit>().state),
        ),
      ),
      bottomNavigationBar: CupertinoTabBar(
          currentIndex: context.watch<BottomNavigationIndexCubit>().state,
          onTap: (val) {
            context.read<BottomNavigationIndexCubit>().changeState(val);
          },
          items:
              tabs.map((e) => BottomNavigationBarItem(icon: Text(e))).toList()),
    );
  }
}

class BottomNavigationIndexCubit extends Cubit<int> {
  BottomNavigationIndexCubit() : super(0);

  changeState(int x) {
    emit(x);
  }
}

class ActiveMusicCubit extends Cubit<String> {
  ActiveMusicCubit() : super('NOthing playing');

  chan(String x) {
    emit(x);
  }
}

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetUsersCubit, GetUsersState>(
      listener: (context, state) {
        if(state == GetUsersFailed){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
          ));
        }
      },
      builder: (context, state) {
        if (state == GetUsersLoading()) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is GetUsersSuccess) {
          return Center(
            child: Text(state.users.join(', ')),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
