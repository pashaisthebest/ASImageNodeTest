//
//  CCProfileBackgroundHeaderView.m
//  CarCar
//
//  Created by Pavel Gurov on 08/04/16.
//  Copyright © 2016 Superbright. All rights reserved.
//

#import "CCProfileBackgroundHeaderView.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import <UIImageView+WebCache.h>

@interface CCProfileBackgroundHeaderView()
@property (strong, nonatomic) ASImageNode *avatarNode;
@property (strong, nonatomic) CCUserHeaderViewModel *userHeaderModel;
@end

@implementation CCProfileBackgroundHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor blackColor];
    
    _avatarNode = [ASImageNode new];
    _avatarNode.layerBacked = YES;
    _avatarNode.contentMode = UIViewContentModeScaleAspectFill;
    _avatarNode.borderWidth = 2.0;
    _avatarNode.borderColor = [UIColor greenColor].CGColor;
    
//    _avatarNode.imageModificationBlock = ^UIImage *(UIImage *image) {
//        UIImage *blurredImage = [UIImageEffects imageByApplyingBlurToImage:image withRadius:100*image.scale tintColor:[UIColor colorWithWhite:0 alpha:0.5] saturationDeltaFactor:0.6 maskImage:nil];
//        return blurredImage;
//    };
    
    [self addSubnode:_avatarNode];
}

- (void)configure {
    ASPerformBlockOnBackgroundThread(^{
        __weak ASImageNode *weakAvatarNode = _avatarNode;
        NSURL *newImageURL = [NSURL URLWithString:@"https://pp.vk.me/c627530/v627530193/3ddfb/tgKrnJGP51w.jpg"];
        [[SDWebImageManager sharedManager] downloadImageWithURL:newImageURL options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            weakAvatarNode.image = image;
        }];
    });
}

#pragma mark - layout

- (void)layoutSubviews {
    [super layoutSubviews];
    _avatarNode.frame = self.bounds;
}

@end
