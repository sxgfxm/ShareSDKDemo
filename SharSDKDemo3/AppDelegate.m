//
//  AppDelegate.m
//  SharSDKDemo3
//
//  Created by 宋晓光 on 22/10/2016.
//  Copyright © 2016 Light. All rights reserved.
//

#import "AppDelegate.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>

#import "WXApi.h"

#import "WeiboSDK.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

  [ShareSDK registerApp:@"182947e7afac0"
      activePlatforms:@[
        @(SSDKPlatformTypeSinaWeibo),
        @(SSDKPlatformSubTypeWechatSession),
        @(SSDKPlatformSubTypeWechatTimeline),
        @(SSDKPlatformTypeQQ)
      ]
      onImport:^(SSDKPlatformType platformType) {
        switch (platformType) {
        case SSDKPlatformTypeSinaWeibo:
          [ShareSDKConnector connectWeChat:[WeiboSDK class]];
          break;
        case SSDKPlatformTypeWechat:
          [ShareSDKConnector connectWeChat:[WXApi class]];
          break;
        case SSDKPlatformTypeQQ:
          [ShareSDKConnector connectQQ:[QQApiInterface class]
                     tencentOAuthClass:[TencentOAuth class]];
          break;
        default:
          break;
        }
      }
      onConfiguration:^(SSDKPlatformType platformType,
                        NSMutableDictionary *appInfo) {
        switch (platformType) {
        case SSDKPlatformTypeSinaWeibo:
          [appInfo
              SSDKSetupSinaWeiboByAppKey:@"3144028685"
                               appSecret:@"11abfe456bc8eefbab49fe7bbcd90bf0"
                             redirectUri:@"http://www.sharesdk.cn"
                                authType:SSDKAuthTypeBoth];
          break;
        case SSDKPlatformTypeWechat:
          [appInfo SSDKSetupWeChatByAppId:@"wx030db67392eff055"
                                appSecret:@"e06c7162a5ec371886f1be9ae21d4d82"];
          break;
        case SSDKPlatformTypeQQ:
          [appInfo SSDKSetupQQByAppId:@"" appKey:@"" authType:SSDKAuthTypeBoth];
          break;
        default:
          break;
        }
      }];
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state.
  // This can occur for certain types of temporary interruptions (such as an
  // incoming phone call or SMS message) or when the user quits the application
  // and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and invalidate
  // graphics rendering callbacks. Games should use this method to pause the
  // game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate
  // timers, and store enough application state information to restore your
  // application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called
  // instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the active state;
  // here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the
  // application was inactive. If the application was previously in the
  // background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if
  // appropriate. See also applicationDidEnterBackground:.
}

@end
