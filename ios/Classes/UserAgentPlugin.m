#import "UserAgentPlugin.h"

@implementation UserAgentPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"user_agent"
            binaryMessenger:[registrar messenger]];
  UserAgentPlugin* instance = [[UserAgentPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getProperties" isEqualToString:call.method]) {
    [self constantsToExport:result];
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.webView = [[WKWebView alloc] initWithFrame:CGRectZero];
    }
    return self;
}

//eg. Darwin/16.3.0
- (NSString *)darwinVersion
{
    struct utsname systemInfo;
    (void) uname(&systemInfo);
    return [NSString stringWithUTF8String:systemInfo.release];
}

- (NSString *)deviceNameFromIdentifier:(NSString*)identifier
{
    static NSDictionary* deviceNamesByCode = nil;

    if (!deviceNamesByCode) {
        deviceNamesByCode = @{
            @"iPod1,1"   : @"iPod touch",
            @"iPod2,1"   : @"iPod touch (2nd generation)",
            @"iPod3,1"   : @"iPod touch (3rd generation)",
            @"iPod4,1"   : @"iPod touch (4th generation)",
            @"iPod5,1"   : @"iPod touch (5th generation)",
            @"iPod7,1"   : @"iPod touch (6th generation)",
            @"iPod9,1"   : @"iPod touch (7th generation)",

            @"iPhone1,1" : @"iPhone",
            @"iPhone1,2" : @"iPhone 3G",
            @"iPhone2,1" : @"iPhone 3GS",
            @"iPhone3,1" : @"iPhone 4",
            @"iPhone3,2" : @"iPhone 4",
            @"iPhone3,3" : @"iPhone 4",
            @"iPhone4,1" : @"iPhone 4S",
            @"iPhone5,1" : @"iPhone 5",
            @"iPhone5,2" : @"iPhone 5",
            @"iPhone5,3" : @"iPhone 5c",
            @"iPhone5,4" : @"iPhone 5c",
            @"iPhone6,1" : @"iPhone 5s",
            @"iPhone6,2" : @"iPhone 5s",
            @"iPhone7,1" : @"iPhone 6 Plus",
            @"iPhone7,2" : @"iPhone 6",
            @"iPhone8,1" : @"iPhone 6S",
            @"iPhone8,2" : @"iPhone 6S Plus",
            @"iPhone8,4" : @"iPhone SE",
            @"iPhone9,1" : @"iPhone 7",
            @"iPhone9,3" : @"iPhone 7",
            @"iPhone9,2" : @"iPhone 7 Plus",
            @"iPhone9,4" : @"iPhone 7 Plus",
            @"iPhone10,1": @"iPhone 8",
            @"iPhone10,4": @"iPhone 8",
            @"iPhone10,2": @"iPhone 8 Plus",
            @"iPhone10,5": @"iPhone 8 Plus",
            @"iPhone10,3": @"iPhone X",
            @"iPhone10,6": @"iPhone X",
            @"iPhone11,2": @"iPhone XS",
            @"iPhone11,4": @"iPhone XS Max",
            @"iPhone11,6": @"iPhone XS Max",
            @"iPhone11,8": @"iPhone XR",
            @"iPhone12,1": @"iPhone 11",
            @"iPhone12,3": @"iPhone 11 Pro",
            @"iPhone12,5": @"iPhone 11 Pro Max",

            @"iPad1,1"   : @"iPad",
            @"iPad2,1"   : @"iPad 2",
            @"iPad2,2"   : @"iPad 2",
            @"iPad2,3"   : @"iPad 2",
            @"iPad2,4"   : @"iPad 2",
            @"iPad3,1"   : @"iPad (3rd generation)",
            @"iPad3,2"   : @"iPad (3rd generation)",
            @"iPad3,3"   : @"iPad (3rd generation)",
            @"iPad3,4"   : @"iPad (4th generation)",
            @"iPad3,5"   : @"iPad (4th generation)",
            @"iPad3,6"   : @"iPad (4th generation)",
            @"iPad4,1"   : @"iPad Air",
            @"iPad4,2"   : @"iPad Air",
            @"iPad4,3"   : @"iPad Air",
            @"iPad5,3"   : @"iPad Air 2",
            @"iPad5,4"   : @"iPad Air 2",
            @"iPad6,3"   : @"iPad Pro (9.7\")",
            @"iPad6,4"   : @"iPad Pro (9.7\")",
            @"iPad6,7"   : @"iPad Pro (12.9\")",
            @"iPad6,8"   : @"iPad Pro (12.9\")",
            @"iPad6,11"  : @"iPad (5th generation)",
            @"iPad6,12"  : @"iPad (5th generation)",
            @"iPad7,1"   : @"iPad Pro (12.9\") (2nd generation)",
            @"iPad7,2"   : @"iPad Pro (12.9\") (2nd generation)",
            @"iPad7,3"   : @"iPad Pro (10.5\")",
            @"iPad7,4"   : @"iPad Pro (10.5\")",
            @"iPad7,5"   : @"iPad (6th generation)",
            @"iPad7,6"   : @"iPad (6th generation)",
            @"iPad8,1"   : @"iPad Pro (11\")",
            @"iPad8,2"   : @"iPad Pro (11\")",
            @"iPad8,3"   : @"iPad Pro (11\")",
            @"iPad8,4"   : @"iPad Pro (11\")",
            @"iPad8,5"   : @"iPad Pro (12.9\") (3rd generation)",
            @"iPad8,6"   : @"iPad Pro (12.9\") (3rd generation)",
            @"iPad8,7"   : @"iPad Pro (12.9\") (3rd generation)",
            @"iPad8,8"   : @"iPad Pro (12.9\") (3rd generation)",
            @"iPad11,3"  : @"iPad Air (3rd generation)",
            @"iPad11,4"  : @"iPad Air (3rd generation)",

            @"iPad2,5"   : @"iPad mini",
            @"iPad2,6"   : @"iPad mini",
            @"iPad2,7"   : @"iPad mini",
            @"iPad4,4"   : @"iPad mini 2",
            @"iPad4,5"   : @"iPad mini 2",
            @"iPad4,6"   : @"iPad mini 2",
            @"iPad4,7"   : @"iPad mini 3",
            @"iPad4,8"   : @"iPad mini 3",
            @"iPad4,9"   : @"iPad mini 3",
            @"iPad5,1"   : @"iPad mini 4",
            @"iPad5,2"   : @"iPad mini 4",
            @"iPad11,1"  : @"iPad mini (5th generation)",
            @"iPad11,2"  : @"iPad mini (5th generation)",
        };
    }

     NSString* deviceName = [deviceNamesByCode objectForKey:identifier];

     if (!deviceName) {
//        if ([identifier rangeOfString:@"iPod"].location != NSNotFound) {
//            deviceName = @"iPod touch";
//        } else if ([identifier rangeOfString:@"iPad"].location != NSNotFound) {
//            deviceName = @"iPad";
//        } else if ([identifier rangeOfString:@"iPhone"].location != NSNotFound) {
//            deviceName = @"iPhone";
//        } else {
            deviceName = identifier;
//        }
    }

    return deviceName;
}

- (void)constantsToExport:(FlutterResult)result
{
    struct utsname systemInfo;
    uname(&systemInfo);

    UIDevice *currentDevice = [UIDevice currentDevice];
    NSString *systemName = currentDevice.systemName;
    NSString *systemVersion = currentDevice.systemVersion;

    NSBundle *bundle = [NSBundle mainBundle];
    NSString *appName = [bundle objectForInfoDictionaryKey:@"CFBundleName"] ?: [NSNull null];
    NSString *appVersion = [bundle objectForInfoDictionaryKey:@"CFBundleShortVersionString"] ?: [NSNull null];
    NSString *buildNumber = [bundle objectForInfoDictionaryKey:@"CFBundleVersion"] ?: [NSNull null];

    NSString *cfnVersion = [NSBundle bundleWithIdentifier:@"com.apple.CFNetwork"].infoDictionary[@"CFBundleShortVersionString"];

    NSString *darwinVersion = [NSString stringWithUTF8String:systemInfo.release];
    NSString *deviceIdentifier = [NSString stringWithUTF8String:systemInfo.machine];

    BOOL isSimulator = NO;
    if ([deviceIdentifier isEqualToString:@"i386"] || [deviceIdentifier isEqualToString:@"x86_64"]) {
        deviceIdentifier = [NSString stringWithFormat:@"%s", getenv("SIMULATOR_MODEL_IDENTIFIER")];
        isSimulator = YES;
    }

    NSString *deviceName = [self deviceNameFromIdentifier:deviceIdentifier];

    if (isSimulator) {
        deviceName = [NSString stringWithFormat:@"%@ Simulator", deviceName];
    }

    NSString *userAgent = [NSString stringWithFormat:@"CFNetwork/%@ Darwin/%@ (%@ %@/%@)",
                           cfnVersion, darwinVersion, deviceName, systemName, systemVersion];
    NSString *packageUserAgent = [NSString stringWithFormat:@"%@/%@.%@ %@", appName, appVersion, buildNumber, userAgent];

    [self.webView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id __nullable webViewUserAgent, NSError * __nullable error) {
        result(@{
          @"isEmulator": @(isSimulator),
          @"systemName": systemName,
          @"systemVersion": systemVersion,
          @"applicationName": appName,
          @"applicationVersion": appVersion,
          @"buildNumber": buildNumber,
          @"darwinVersion": darwinVersion,
          @"cfnetworkVersion": cfnVersion,
          @"deviceName": deviceName,
          @"packageUserAgent": packageUserAgent,
          @"userAgent": userAgent,
          @"webViewUserAgent": webViewUserAgent ?: [NSNull null]
        });
    }];
}

@end


