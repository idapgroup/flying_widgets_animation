# FlyingWidgetsAnimation

## Description
**FlyingWidgetsAnimation** is a customizable widget that will allow you to decorate your Flutter-application with animation with a continuous stream of flying views distributed randomly throughout the background.

https://github.com/user-attachments/assets/821331df-3e64-42ad-8bab-ca40d1b1bfa1

## Usage example

```dart
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: FlyingWidgetsAnimation(
      numberOfItems: 20,
      child: Container(
        width: 150,
        height: 150,
        decoration: const BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: const Center(
            child: Text('Your widget', style: TextStyle(fontSize: 20))),
      ), // This is your own widget
    ));
  }
}
```

This example allows you to implement the animation shown above. The FlyingWidgetsAnimation widget has the following optional and required parameters:

`numberOfItems` - number of objects that will be shown per 1 animation cycle (3 seconds). This is the only required parameter.

`animatedItem` - a widget that is used as a "placeholder" for the animation. If this parameter is not specified, then an emoji is used as shown in the video above.

`child` - a widget that is used as a static element around which animation occurs. It is centered relative to the parent widget.

`size` - the size of the side of an `animetedItem`, the height and width of which are considered equal. The default value is 100.0

`background` - background color. Default is white.
