import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewApp extends StatefulWidget {
  WebViewApp(
      {Key key, Color backgroundColor, this.url, this.useBlackTheme = true})
      : this.backgroundColor = backgroundColor ?? Colors.black,
        super(key: key);

  final Color backgroundColor;
  final String url;
  final bool useBlackTheme;

  @override
  _WebViewAppState createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  bool loading = false;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Color statusBarColor = widget.useBlackTheme ? Colors.white : Colors.black;
      Brightness statusBarBrightness =
          widget.useBlackTheme ? Brightness.light : Brightness.dark;
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: statusBarColor,
          statusBarBrightness: statusBarBrightness,
          systemNavigationBarDividerColor: Color(010101),
        ),
      );
    });
  }

  void _setLoading(bool status) {
    if (mounted) {
      setState(() {
        loading = status;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              WebView(
                initialUrl: widget.url,
                javascriptMode: JavascriptMode.unrestricted,
                onPageStarted: (_) {
                  _setLoading(true);
                },
                onPageFinished: (_) {
                  _setLoading(false);
                },
              ),
              loading
                  ? Container(
                      color: widget.backgroundColor,
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
