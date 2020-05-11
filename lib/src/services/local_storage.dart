import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorageServiceInterface {
  String getAuthenticatedUserID();
  Future<bool> setAuthenticatedUserID(String uid);
  Future<void> deleteAuthenticatedUserID();
}

class LocalStorageService implements LocalStorageServiceInterface {
  static LocalStorageService _instance;
  static SharedPreferences _preferences;

  static Future<LocalStorageService> getInstance() async {
    _instance ??= LocalStorageService();
    _preferences ??= await SharedPreferences.getInstance();
    return _instance;
  }

  @override
  String getAuthenticatedUserID() {
    String uid;
    try {
      uid = _preferences.getString('auth_uid');
    } catch (_) {
      uid = null;
    }
    return uid;
  }

  @override
  Future<bool> setAuthenticatedUserID(String uid) {
    return _preferences.setString('auth_uid', uid);
  }

  @override
  Future<void> deleteAuthenticatedUserID() async {
    await _preferences.remove('auth_uid');
  }
}
