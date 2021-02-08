import 'dart:convert';

class Status {
  final Map<String, dynamic> json;

  Status({this.json});

  factory Status.fromString(String val) {

    return Status(
        json: jsonDecode(val)
    );
  }
}
