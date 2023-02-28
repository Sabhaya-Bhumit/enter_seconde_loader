import 'dart:async';

class HistoryBloc {
  List History = [];

  // Sending value to Stream
  final StreamController<List> _HistoryController = StreamController<List>();

  // Expose value to StreamBuilder
  Stream<List> get HistoryStream => _HistoryController.stream;

  incrementHistory(int value) {
    History.add(value);
    _HistoryController.sink.add(History);
  }

  // decrementCounter() {
  //   _HistoryController.sink.add(count--);
  // }

  void dispose() {
    _HistoryController.close();
  }
}

final historyBloc = HistoryBloc();
