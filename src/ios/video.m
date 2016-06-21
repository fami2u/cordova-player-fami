/********* video.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import "RootViewController.h"

@interface video : CDVPlugin


- (void)play:(CDVInvokedUrlCommand*)command;

@property (nonatomic,strong)RootViewController *rootVC;

@end

@implementation video

- (void)play:(CDVInvokedUrlCommand*)command
{
    NSDictionary* echo = [command.arguments objectAtIndex:0];
    NSString *url = [echo objectForKey:@"strUrl"];
    
    NSString* yesOrN = [echo objectForKey:@"type"];
    
    if (url.length == 0) {
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"无参数,调起支付失败!"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        
    }else{
        
        self.rootVC = [[RootViewController alloc]init];
        
        self.rootVC.videoUrl = url;
        
        self.rootVC.networkOrLocat = yesOrN;
        
        [self.viewController presentViewController:self.rootVC animated:YES completion:nil];
        
        //添加通知跳转
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(goHome) name:@"goHome" object:nil];
        
    }
}


- (void)goHome{
    
    [self.rootVC dismissViewControllerAnimated:YES completion:nil];
    
}

@end
