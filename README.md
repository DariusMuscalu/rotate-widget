# Before solving the task I had to refactor the code, because it was not easily to understand what is happening inside, because of the long methods, nested and with bad naming that induced me in error.

# First problem was that the widget responsible for rotating (Transform.rotate) did not had the alignment property set and it was the default one. We needed to rotate the widget based on the center of the container, so we set the alignment to center.

- This article explains with some examples how to use the Transform widget properly:
  https://alfonso-software.medium.com/rotation-examples-with-flutter-transform-widget-part-i-bb65b43d5b82

# Second problem was that after rotating, trying to move the widget did not worked in areas that were outside of the initial widget area before being rotated. Here's from where I found the solution, they explain it there:

https://stackoverflow.com/questions/73843182/flutter-after-rotate-widget-inside-stack-when-changing-the-position-it-is-move