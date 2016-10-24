//
//  ViewController.m
//  SharSDKDemo3
//
//  Created by 宋晓光 on 22/10/2016.
//  Copyright © 2016 Light. All rights reserved.
//

#import "ViewController.h"

//  系统
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
//  自定义
#import <ShareSDKUI/SSUIEditorViewStyle.h>
#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>

@interface ViewController () <UIImagePickerControllerDelegate,
                              UINavigationControllerDelegate>

@property(nonatomic, strong) UIButton *btn;

@property(nonatomic, strong) UIButton *shareBtn;

@property(nonatomic, strong) UIImagePickerController *picker;

@property(nonatomic, strong) UIImage *image;

@property(nonatomic, strong) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
  self.btn.frame =
      CGRectMake(self.view.bounds.size.width / 2 - 50, 100, 100, 20);
  [self.btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
  [self.btn setTitle:@"Image" forState:UIControlStateNormal];
  [self.btn addTarget:self
                action:@selector(btnAction)
      forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:self.btn];

  self.shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  self.shareBtn.frame =
      CGRectMake(self.view.bounds.size.width / 2 - 50, 150, 100, 20);
  [self.shareBtn setTitleColor:[UIColor redColor]
                      forState:UIControlStateNormal];
  [self.shareBtn setTitle:@"Share" forState:UIControlStateNormal];
  [self.shareBtn addTarget:self
                    action:@selector(shareAction)
          forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:self.shareBtn];

  self.imageView = [[UIImageView alloc]
      initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width,
                               self.view.bounds.size.width)];
  [self.view addSubview:self.imageView];

  self.picker = [[UIImagePickerController alloc] init];
  self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
  self.picker.delegate = self;
  self.picker.allowsEditing = YES;

  self.image = [UIImage imageNamed:@"junxi4.jpeg"];
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<NSString *, id> *)info {
  self.image = [info objectForKey:UIImagePickerControllerOriginalImage];
  self.imageView.image = self.image;
  [self dismissViewControllerAnimated:picker completion:nil];
}

- (void)shareAction {

  //  设置分享参数
  NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
  [shareParams SSDKSetupShareParamsByText:@"分享"
                                   images:self.image
                                      url:nil
                                    title:@"Ticwatch运动分享"
                                     type:SSDKContentTypeAuto];
  //  设置分享sheet样式
  //  分享菜单背景颜色
  //  [SSUIShareActionSheetStyle setActionSheetBackgroundColor:[UIColor
  //  redColor]];
  //  分享菜单颜色
  //  [SSUIShareActionSheetStyle setActionSheetColor:[UIColor greenColor]];
  //  分享菜单社交平台文本颜色
  //  [SSUIShareActionSheetStyle setItemNameColor:[UIColor blueColor]];
  //  分享菜单社交平台文本字体，防止显示不全问题
  [SSUIShareActionSheetStyle setItemNameFont:[UIFont systemFontOfSize:10]];
  //  分享菜单样式
  //  [SSUIShareActionSheetStyle
  //      setShareActionSheetStyle:ShareActionSheetStyleSimple];
  //  分享编辑界面导航栏颜色
  //  [SSUIEditorViewStyle setiPadNavigationBarBackgroundColor:[UIColor
  //  redColor]];
  //  分享编辑界面标题颜色
  //  [SSUIEditorViewStyle setTitleColor:[UIColor greenColor]];
  //  分享编辑界面取消颜色
  //  [SSUIEditorViewStyle setCancelButtonLabelColor:[UIColor blueColor]];
  //  [SSUIEditorViewStyle setShareButtonLabelColor:[UIColor blueColor]];
  //  分享编辑界面状态栏风格
  //  [SSUIEditorViewStyle setStatusBarStyle:UIStatusBarStyleLightContent];

  SSUIShareActionSheetCustomItem *itemWeibo = [SSUIShareActionSheetCustomItem
      itemWithPlatformType:SSDKPlatformTypeSinaWeibo];
  itemWeibo.label = @"微博";

  SSUIShareActionSheetCustomItem *itemWechatSession =
      [SSUIShareActionSheetCustomItem
          itemWithPlatformType:SSDKPlatformSubTypeWechatSession];
  itemWechatSession.label = @"微信";

  SSUIShareActionSheetCustomItem *itemWechatTimeLine =
      [SSUIShareActionSheetCustomItem
          itemWithPlatformType:SSDKPlatformSubTypeWechatTimeline];
  itemWechatTimeLine.label = @"朋友圈";

  SSUIShareActionSheetCustomItem *itemQQ =
      [SSUIShareActionSheetCustomItem itemWithPlatformType:SSDKPlatformTypeQQ];
  itemQQ.label = @"QQ";

  //  分享
  [ShareSDK showShareActionSheet:nil
                           items:@[
                             @(SSDKPlatformTypeSinaWeibo),
                             @(SSDKPlatformSubTypeWechatTimeline),
                             @(SSDKPlatformSubTypeWechatSession)
                           ]
                     shareParams:shareParams
             onShareStateChanged:^(
                 SSDKResponseState state, SSDKPlatformType platformType,
                 NSDictionary *userData, SSDKContentEntity *contentEntity,
                 NSError *error, BOOL end) {
               switch (state) {
               case SSDKResponseStateSuccess:
                 NSLog(@"成功");
                 break;
               case SSDKResponseStateFail:
                 NSLog(@"失败");
                 break;
               default:
                 break;
               }
             }];
}

- (void)btnAction {

  if ([UIImagePickerController
          isSourceTypeAvailable:
              UIImagePickerControllerSourceTypePhotoLibrary]) {
    [self presentViewController:self.picker animated:YES completion:nil];
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
