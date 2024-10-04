import 'package:bloc/bloc.dart';
import 'package:multi_bloc_state/bloc/switch_example/switch_event.dart';
import 'package:multi_bloc_state/bloc/switch_example/switch_state.dart';

class SwitchBloc extends Bloc<SwitchEvents, SwitchState> {
  SwitchBloc() : super(SwitchState()) {
    on<EnableOrDisableNotification>(_enableOrDisableNotification);
    on<SliderEvent>(_slider);
  }

  void _enableOrDisableNotification(
      EnableOrDisableNotification events, Emitter<SwitchState> emit) {
    emit(state.copyWith(isSwitch: !state.isSwitch));
  }

  void _slider(SliderEvent events, Emitter<SwitchState> emit) {
    emit(state.copyWith(slider: events.slider));
  }
}
