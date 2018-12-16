import 'dart:html';

void main() {
  // Selectors
  var chatSigninBox = querySelector('#ChatSignin');
  var chatRoomBox = querySelector('#ChatRoom');
  var validationBox = chatSigninBox.querySelector('p.help');
  // We specify the type whenever possible because querySelector() returns a generic Element object.
  // Specifying type helps the Dart analyser to access the type specific methods, such as `value` property of `InputElement`
  InputElement nameField = chatSigninBox.querySelector('input[type="text"]');
  ButtonElement submitBtn = chatSigninBox.querySelector('button');

  // Event listeners
  nameField.addEventListener('input', (evt) {
    if (nameField.value.trim().isNotEmpty) {
      nameField.classes
        ..removeWhere((className) => className == 'is-danger')
        ..add('is-success');
      validationBox.text = '';
    } else {
      nameField.classes
        ..removeWhere((className) => className == 'is-success')
        ..add('is-danger');
    }
  });

  submitBtn.addEventListener('click', (evt) async {
    // 1. Validate name field
    if (nameField.value.trim().isEmpty) {
      nameField.classes.add('is-danger');
      validationBox.text = 'Please enter your name';
      return;
    }

    submitBtn.disabled = true;

    try {
      // 2. Submit name to backend via POST
      var response = await HttpRequest.postFormData(
        'http://localhost:8000/signin', // TODO: Endpoint to be created in next step
        {'username': nameField.value}
      );

      // 3. Handle success response and switch view
      chatSigninBox.hidden = true;
      chatRoomBox.hidden = false;
    } catch (e) {
      // 4. Handle failure response
      submitBtn
        ..disabled = false
        ..text = 'Failed to join chat. Try again?';
    }
  });
}
