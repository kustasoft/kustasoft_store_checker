import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'kustasoft_store_checker_platform_interface.dart';

/// An implementation of [KustasoftStoreCheckerPlatform] that uses method channels.
class MethodChannelKustasoftStoreChecker extends KustasoftStoreCheckerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('kustasoft_store_checker');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
