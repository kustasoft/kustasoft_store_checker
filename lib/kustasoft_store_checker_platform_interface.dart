import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'kustasoft_store_checker_method_channel.dart';

abstract class KustasoftStoreCheckerPlatform extends PlatformInterface {
  /// Constructs a KustasoftStoreCheckerPlatform.
  KustasoftStoreCheckerPlatform() : super(token: _token);

  static final Object _token = Object();

  static KustasoftStoreCheckerPlatform _instance = MethodChannelKustasoftStoreChecker();

  /// The default instance of [KustasoftStoreCheckerPlatform] to use.
  ///
  /// Defaults to [MethodChannelKustasoftStoreChecker].
  static KustasoftStoreCheckerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [KustasoftStoreCheckerPlatform] when
  /// they register themselves.
  static set instance(KustasoftStoreCheckerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
