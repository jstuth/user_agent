#import <sys/utsname.h>
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import <Flutter/Flutter.h>

@interface UserAgentPlugin : NSObject<FlutterPlugin>
//@property (nonatomic) bool isEmulator;
@property (strong, nonatomic) WKWebView* webView;
@end
