import 'dart:io';
import 'dart:math';
import 'dart:convert';

void main(List<String> args) {
  Map<String, dynamic> js = {'x':1.5, 'y':2.05};
  var p1 = Point(2, 3);
  var p2 = Point(4, 6);
  var p3 = NewPoint.fromJson(js);
  print(p1.x);
  print(p2.y);
  print(p1.toString());
  print(p1.hashCode);
  print(p1+p2);
  print(p3);

  p1 = Point(1, 2);
  p2 = Point(2, 2);
  print(p1==p2);
}

@override

class NewPoint extends Point {
  final num x;
  final num y;
  const NewPoint({this.x, this.y}): super(x, y);
  factory NewPoint.fromJson(Map<String, dynamic> json) {
    return NewPoint(
      x: json['x'],
      y: json['y'],
    );
  }
}
