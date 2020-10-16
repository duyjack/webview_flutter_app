import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webview_app_plugin/webview_app_plugin.dart';

void main() {
  testWidgets('my webview app', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        title: 'Flutter Demo',
        home: WebViewApp(
          url: 'https://www.google.com/',
        ),
      ),
    );
  });
}
