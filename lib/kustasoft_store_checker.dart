
import 'kustasoft_store_checker_platform_interface.dart';

class KustasoftStoreChecker {
  Future<String?> getPlatformVersion() {
    return KustasoftStoreCheckerPlatform.instance.getPlatformVersion();
  }
}
