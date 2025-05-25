# objc-method-protect

A simple library to protect objc methods from being called by external libraries  
(arm64 only)

## Usage
```
#include "protect_method.h"

// ...

int main(int argc, char *argv[]) {
	// ...
	
	// This prevents external libraries from presenting a vc
	// via calling - [UIViewController presentViewController:animated:completion:].
	// The main executable itself is permitted to call such method.
	protect_method(UIViewController,presentViewController:animated:completion:,NULL);
	// This makes the program exit in case any external library calls
	// - [UIWindow makeKeyAndVisible]
	protect_method(UIWindow,makeKeyAndVisible,exit);
	
	// ...
}
```
## License

[MIT License](https://mit-license.org)
	