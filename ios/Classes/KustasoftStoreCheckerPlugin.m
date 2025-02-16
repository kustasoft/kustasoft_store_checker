#import "KustasoftStoreCheckerPlugin.h"
#import <Flutter/Flutter.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@implementation KustasoftStoreCheckerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"kustasoft_store_checker"
            binaryMessenger:[registrar messenger]];
  KustasoftStoreCheckerPlugin* instance = [[KustasoftStoreCheckerPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"getSource" isEqualToString:call.method]) {
        BOOL isTestFlight = [self isRunningInTestFlightEnvironment];
        BOOL isAppStore = [self isRunningInAppStoreEnvironment];

        if (isTestFlight) {
            // Installed from TestFlight
            result(@"TestFlight");
        } else if (isAppStore) {
            // Installed from App Store
            result(@"AppStore");
        } else {
            // Result is unknown
            result(@"");
        }
    } else {
        result(FlutterMethodNotImplemented);
    }
}

// Check whether current app is TestFlight Beta app or not
- (BOOL)isRunningInTestFlightEnvironment {
    if ([self isSimulator]) {
        return NO;
    } else {
        if ([self isAppStoreReceiptSandbox] && ![self hasEmbeddedMobileProvision]) {
            return YES;
        } else {
            return NO;
        }
    }
}

// Check whether current app is App Store build app or not
- (BOOL)isRunningInAppStoreEnvironment {
    if ([self isSimulator]) {
        return NO;
    } else {
        if ([self isAppStoreReceiptSandbox] || [self hasEmbeddedMobileProvision]) {
            return NO;
        } else {
            return YES;
        }
    }
}

// Check whether current app is App is embedded or mobileprovision
- (BOOL)hasEmbeddedMobileProvision {
    if ([[NSBundle mainBundle] pathForResource:@"embedded" ofType:@"mobileprovision"]) {
        return YES;
    }
    return NO;
}

// Check whether current app is App Store receipt sandbox app or not
- (BOOL)isAppStoreReceiptSandbox {
    if ([self isSimulator]) {
        return NO;
    } else {
        NSURL *appStoreReceiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
        if (appStoreReceiptURL && [[appStoreReceiptURL lastPathComponent] isEqualToString:@"sandboxReceipt"]) {
            return YES;
        }
    }
    return NO;
}

// Check current app is running on simulator or not
- (BOOL)isSimulator {
#if TARGET_OS_SIMULATOR
    return YES;
#else
    return NO;
#endif
}

@end