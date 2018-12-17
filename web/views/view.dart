abstract class View {
  void onEnter();   // when the view is loaded in
  void onExit();    // when the window is exited
  void prepare();   // before mounting
  void render();    // render view on screen
}