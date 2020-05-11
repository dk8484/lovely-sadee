import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_focus_watcher/flutter_focus_watcher.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../blocs/signin/signin_bloc.dart';
import '../../repositories/authentication_repository.dart';
import '../../services/analytics.dart';
import 'form.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({
    Key key,
    @required AuthenticationRepository authRepository,
    @required AnalyticsService analyticsService,
  })  : assert(authRepository != null),
        _authRepository = authRepository,
        assert(analyticsService != null),
        _analyticsService = analyticsService,
        super(key: key);

  final AuthenticationRepository _authRepository;
  final AnalyticsService _analyticsService;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FocusWatcher(
        child: PlatformScaffold(
          android: (BuildContext context) => MaterialScaffoldData(
            resizeToAvoidBottomInset: true,
          ),
          body: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowGlow();
              return true;
            },
            child: BlocProvider<SignInBloc>(
              create: (BuildContext context) => SignInBloc(
                authRepository: _authRepository,
                analyticsService: _analyticsService,
              ),
              child: SignInForm(
                authRepository: _authRepository,
                analyticsService: _analyticsService,
                widthFactor: 0.9,
                logoScaleFactor: 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
