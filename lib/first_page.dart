import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_bloc_state/bloc/switch_example/switch_bloc.dart';
import 'package:multi_bloc_state/bloc/switch_example/switch_event.dart';
import 'package:multi_bloc_state/bloc/switch_example/switch_state.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  double _sliderValue = 0.1; // Initialize slider value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Multi State Bloc"),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Notifications"),
                BlocBuilder<SwitchBloc, SwitchState>(
                    buildWhen: (previous, current) =>
                        previous.isSwitch != current.isSwitch,
                    builder: (context, state) {
                      return Switch(
                        value: state.isSwitch,
                        onChanged: (value) {
                          context
                              .read<SwitchBloc>()
                              .add(EnableOrDisableNotification());
                        },
                      );
                    })
              ],
            ),
            SizedBox(
              height: 30,
            ),
            BlocBuilder<SwitchBloc, SwitchState>(
                buildWhen: (previous, current) =>
                    previous.slider != current.slider,
                builder: (context, state) {
                  return Container(
                    height: 200,
                    color: Colors.red.withOpacity(state.slider),
                  );
                }),
            const SizedBox(
              height: 50,
            ),
            BlocBuilder<SwitchBloc, SwitchState>(
                buildWhen: (previous, current) =>
                    previous.slider != current.slider,
                builder: (context, state) {
                  return Slider(
                    value: state.slider,
                    min: 0.0,
                    max: 1.0,
                    divisions: 10,
                    label: _sliderValue.toStringAsFixed(1),
                    onChanged: (value) {
                      context
                          .read<SwitchBloc>()
                          .add(SliderEvent(slider: value));
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}
