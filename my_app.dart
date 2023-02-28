import 'package:flutter/material.dart';
import 'package:loader_second/texteditingclean.dart';

//import 'package:loader_second/history_list.dart';

import 'counter_bloc.dart';
import 'history_list.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Bloc',
      debugShowCheckedModeBanner: false,
      home: MyCounter(),
    );
  }
}

class MyCounter extends StatefulWidget {
  const MyCounter({Key? key}) : super(key: key);

  @override
  State<MyCounter> createState() => _MyCounterState();
}

class _MyCounterState extends State<MyCounter> {
  @override
  void dispose() {
    counterBloc.dispose();
    historyBloc.dispose();
    texteCleanBloc.dispose();
    super.dispose();
  }

  // TextEditingController valueController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Simple Counter"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20),
              StreamBuilder(
                  initialData: counterBloc.count,
                  stream: counterBloc.counterStream,
                  builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                    if (snapshot.data! >= 1) {
                      if (int.parse(
                              texteCleanBloc.textEditingController.text) ==
                          1) {
                        Future.delayed(Duration(milliseconds: 500), () {
                          counterBloc.decrementCounter();
                        });
                        return CircularProgressIndicator();
                      } else {
                        print(snapshot.data);
                        if (snapshot.data == 1) {
                          counterBloc.decrementCounter();
                        } else {
                          Future.delayed(Duration(seconds: 1), () {
                            counterBloc.decrementCounter();
                          });
                        }
                        return CircularProgressIndicator();
                      }
                    }
                    // if (int.parse(texteCleanBloc.textEditingController.text) ==
                    //     1) {
                    //   Future.delayed(Duration(milliseconds: 400), () {
                    //     counterBloc.decrementCounter();
                    //   });
                    //   return CircularProgressIndicator();
                    // }
                    else {
                      if (texteCleanBloc
                              .textEditingController.text.isNotEmpty &&
                          int.parse(
                                  texteCleanBloc.textEditingController.text) >=
                              1) {
                        historyBloc.incrementHistory(int.parse(
                            texteCleanBloc.textEditingController.text));

                        Future.delayed(Duration.zero, () {
                          texteCleanBloc.TextClean();
                        });
                      }

                      return Text("enter Your Secode");
                    }
                  }),
              SizedBox(height: 20),
              // StreamBuilder(
              //     initialData: counterBloc.count,
              //     stream: counterBloc.counterStream,
              //     builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              //       return Text(
              //         '${snapshot.data}',
              //         style: Theme.of(context).textTheme.headline4,
              //       );
              //     }),
              Row(
                children: [
                  Expanded(
                      child: StreamBuilder(
                    initialData: texteCleanBloc.textEditingController,
                    stream: texteCleanBloc.TexteditingclearStream,
                    builder: (context, snapshot) {
                      return TextFormField(
                        controller: snapshot.data,
                        keyboardType: TextInputType.number,
                      );
                    },
                  )
                      //
                      ),
                  Expanded(
                      child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (int.parse(
                                  texteCleanBloc.textEditingController.text) >
                              0) {
                            counterBloc.Count(int.parse(
                                texteCleanBloc.textEditingController.text));
                          }
                        },
                        child: Text("Start"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          counterBloc.count = 0;
                          Future.delayed(Duration.zero, () {
                            texteCleanBloc.TextClean();
                          });
                        },
                        child: Text("Stop"),
                      )
                    ],
                  )),
                ],
              ),
              SizedBox(height: 20),
              Text("History"),

              Container(
                height: 300,
                // alignment: Alignment.center,
                child: StreamBuilder(
                  // initialData: HistoryBloc.h,
                  initialData: historyBloc.History,
                  stream: historyBloc.HistoryStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Error is ${snapshot.hasError}"),
                      );
                    } else if (snapshot.hasData) {
                      List? res = snapshot.data;
                      return Center(
                        child: ListView.builder(
                          itemCount: res!.length,
                          itemBuilder: (context, i) {
                            return Text(
                              "${res![i]}",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            );
                          },
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              )

              //   StreamBuilder(
              //   initialData: HistoryBloc.History,
              //   stream: HistoryBloc.HistoryStream,
              //   builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              //
              //
              //   return HistoryBloc().incrementHistory(10);
              //   }
              // }),
            ],
          ),
        ),
      ),
    );
  }
}
