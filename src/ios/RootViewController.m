//
//  RootViewController.m
//  AVPlayerTest
//
//  Created by 1 on 16/5/9.
//  Copyright © 2016年 fami2u.com. All rights reserved.
//

#import "RootViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>


#define HEIGHT self.view.bounds.size.height
#define WIDTH self.view.bounds.size.width


@interface RootViewController ()

@property (nonatomic,strong)AVPlayer           *player;
@property (nonatomic,strong)AVPlayerItem * playerItem;
@property (nonatomic,strong)AVPlayerLayer  *playerLayer;


@end

@implementation RootViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //隐藏navItem
    self.navigationController.navigationBar.hidden = YES;
    
    [self myButton];
    
    //初始化playerLayer
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    
    self.playerLayer.frame = self.view.bounds;
    
    //默认视频填充模式
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    [self.view.layer insertSublayer:self.playerLayer atIndex:0];
    [self.player play];
    
    
}

- (void)myButton{
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH / 2 - 50, HEIGHT - 80, 100, 40)];
    button.backgroundColor = [UIColor blackColor];
    button.alpha = 0.5;
    [button setTitle:@"点击进入" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(gpHome) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
}


- (void)gpHome{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"goHome" object:nil userInfo:nil];
    
}


- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context{
    
    AVPlayerItem*playerItem = object;
    
    /**
     
     *     AVPlayerItemStatusUnknown,播放源未知
     
     *     AVPlayerItemStatusReadyToPlay,播放源准备好
     
     *     AVPlayerItemStatusFailed播放源失败
     
     */
    
    if (object == self.player.currentItem) {
        if ([keyPath isEqualToString:@"status"]) {
            
            if (self.player.currentItem.status == AVPlayerItemStatusReadyToPlay) {
                
                NSLog(@"播放成功,视频总长度:%.2f",CMTimeGetSeconds(playerItem.duration));
                
            }else if(self.player.currentItem.status == AVPlayerItemStatusFailed){
                
                NSLog(@"播放失败");
                
            }
        }
    }
    
    
}


- (AVPlayer *)player{
    
    if (!_player) {
        
        NSURL *url = [NSURL new];
        
        if ([self.networkOrLocat isEqualToString:@"local"]) {
            
            //本地视频
            url = [[NSBundle mainBundle] URLForResource:self.videoUrl withExtension:nil];
            
        }else{
            
            //网络视频
            //NSURL *url = [NSURL URLWithString: @"http://baobab.wdjcdn.com/1455888619273255747085_x264.mp4"];
            
            url = [NSURL URLWithString: self.videoUrl];
            
        }
        
        
        self.playerItem = [AVPlayerItem playerItemWithURL:url];
        
        _player = [AVPlayer playerWithPlayerItem:self.playerItem];
        
        //监控状态属性，注意AVPlayer也有一个status属性，通过监控它的status也可以获得播放状态
        [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        
    }
    
    return _player;
    
}


- (void)dealloc{
    
    [self.player pause];
    self.playerItem = nil;
    [self removeObserver:self forKeyPath:@"status"];
    
}



- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:YES];
    
    self.playerItem = nil;
    [self.player pause];
    [self.playerItem removeObserver:self forKeyPath:@"status"];
    
}

- (BOOL)prefersStatusBarHidden{
    
    return YES;
    
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
