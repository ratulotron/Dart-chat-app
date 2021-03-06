import 'dart:io';
import 'dart:convert';

main() async {
  // TODO: Get port from environment variable
  var port = 8000;
  var server = await HttpServer.bind(InternetAddress.loopbackIPv4, port);

  print('Server listening on port $port');

  await for (HttpRequest request in server) {
    // TODO: Only needed in local development. Will be removed in future
    request.response.headers
        .add('Access-Control-Allow-Origin', 'http://localhost:8080');

    switch (request.uri.path) {
      case '/signin':
        // String payload = await request.transform(Utf8Decoder()).join();
        String payload = await request.transform(Utf8Decoder()).join();
        var username = Uri.splitQueryString(payload)['username'];

        if (username != null && username.isNotEmpty) {
          // TODO: Check username is unique
          request.response
            ..write(username)
            ..close();
        } else {
          request.response
            ..statusCode = 400
            ..write('Please provide a valid user name')
            ..close();
        }
        break;
      case '/ws':
        // TODO: Upgrade request to Websocket connection
        break;
      default:
      // TODO: Forward to static file server
    }
  }
}
