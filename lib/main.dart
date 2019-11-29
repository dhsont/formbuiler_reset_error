import 'package:example/form.dart';
import 'package:flutter/material.dart';
import 'package:sailor/sailor.dart';

void main() async {
  Routes.createRoutes();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Compass Example',
      home: Home(),
      onGenerateRoute: Routes.sailor.generator(),
      navigatorKey: Routes.sailor.navigatorKey,
      navigatorObservers: [
       // SailorLoggingObserver(),
        Routes.sailor.navigationStackObserver,
      ],
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Page'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[      
            RaisedButton(
              child: Text('Form Builder Error Page'),
              onPressed: () async {
                Routes.sailor.navigate("/myHomePage");

               
              },
            ),
          ],
        ),
      ),
    );
  }
}



class MyHomePageArgs extends BaseArguments {
  final int count;

  MyHomePageArgs(this.count);
}

class Routes {
  static final sailor = Sailor(
    options: SailorOptions(
      handleNameNotFoundUI: true,
      isLoggingEnabled: true,
      customTransition: MyCustomTransition(),
      defaultTransitions: [
        SailorTransition.slide_from_bottom,
        SailorTransition.zoom_in,
      ],
      defaultTransitionCurve: Curves.decelerate,
      defaultTransitionDuration: Duration(milliseconds: 500),
    ),
  );

  static void createRoutes() {
    sailor.addRoutes(
      [
      
        SailorRoute(
          name: "/myHomePage",
          builder: (context, args, params) => MyHomePage(),
          defaultTransitions: [SailorTransition.slide_from_left],
        ), 
      ],
    );
  }
}

class MyCustomTransition extends CustomSailorTransition {
  @override
  Widget buildTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}

class CustomRouteGuard extends SailorRouteGuard {
  @override
  Future<bool> canOpen(
    BuildContext context,
    BaseArguments args,
    ParamMap paramMap,
  ) async {
    return false;
  }
}
