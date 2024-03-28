import 'dart:developer';

import 'package:fwms_rm_app/features/auth/data/auth_api_client.dart';
import 'package:fwms_rm_app/features/auth/data/auth_local_data_source.dart';
import 'package:fwms_rm_app/features/auth/dtos/sign_in_dto.dart';
import 'package:fwms_rm_app/features/result_type.dart';

class AuthRepository {
  final AuthApiClient authApiClient;
  final AuthLocalDataSource authLocalDataSource;

  AuthRepository({
    required this.authApiClient,
    required this.authLocalDataSource,
  });

  Future<Result<void>> signIn({
    required String username,
    required String password,
  }) async {
    try {
      final signInSuccessDto = await authApiClient
          .signIn(SignInDto(username: username, password: password));
      await authLocalDataSource.saveToken(signInSuccessDto.tokenString);
    } catch (e) {
      log('$e');
      return Failure('$e');
    }
    return Success(null);
  }
}
