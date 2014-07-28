/*
 *  HelloWorldScene.m
 *  SpriteAnimation
 *
 *  Created by Benjamin Encz on 16/12/13.
 *  Copyright (c) 2013 - 2014 MakeGamesWithUs.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */

#import "HelloWorldScene.h"
#import "Knight.h"
#import "CCAnimatedSprite.h"

@implementation HelloWorldScene {
    CCAnimatedSprite *animatedSprite;
}


+ (HelloWorldScene *)scene
{
    return [[self alloc] init];
}

- (id)init
{
    if (self = [super init])
    {
        glClearColor(0.2f, 0.2f, 0.2f, 1.f);
        
        // ************* CREATE MENU ********************
        
        CCButton *runAnimationButton = [CCButton buttonWithTitle:@"'Run'"];
        [runAnimationButton setTarget:self selector:@selector(runAnimationButtonTouched)];
        
        CCButton *stabAnimationButton = [CCButton buttonWithTitle:@"'Stab'"];
        [stabAnimationButton setTarget:self selector:@selector(stabAnimationButtonTouched)];
        
        CCButton *stopAnimationButton = [CCButton buttonWithTitle:@"Stop"];
        [stopAnimationButton setTarget:self selector:@selector(stopAnimationButtonTouched)];
        
        CCButton *customFrameButton = [CCButton buttonWithTitle:@"Custom frame"];
        [customFrameButton setTarget:self selector:@selector(customFrameButtonTouched)];
        
        CCButton *manualAnimationButton = [CCButton buttonWithTitle:@"Manual animation"];
        [manualAnimationButton setTarget:self selector:@selector(manualAnimationButtonTouched)];
        
        CCButton *loopAnimationOnceButton = [CCButton buttonWithTitle:@"Loop Once"];
        [loopAnimationOnceButton setTarget:self selector:@selector(onceAnimationButtonTouched)];
        
        CCLayoutBox *layoutBox = [[CCLayoutBox alloc] init];
        layoutBox.anchorPoint = ccp(0.5f, 0.5f);
        [layoutBox addChild:runAnimationButton];
        [layoutBox addChild:stabAnimationButton];
        [layoutBox addChild:stopAnimationButton];
        [layoutBox addChild:customFrameButton];
        [layoutBox addChild:manualAnimationButton];
        [layoutBox addChild:loopAnimationOnceButton];

        layoutBox.spacing = 10.f;
        layoutBox.direction = CCLayoutBoxDirectionHorizontal;
        [layoutBox layout];
        layoutBox.positionType = CCPositionTypeNormalized;

        layoutBox.position = ccp(0.5f, 0.2f);
        [self addChild:layoutBox];
        
        // ************* CREATE ANIMATION ********************
        
        animatedSprite = [CCAnimatedSprite animatedSpriteWithPlist:@"animation_knight.plist"];
        [animatedSprite addAnimationwithDelayBetweenFrames:0.1f name:@"animation_knight"];
        [animatedSprite addAnimationwithDelayBetweenFrames:0.1f name:@"animation_knight-stab"];
        animatedSprite.positionType = CCPositionTypeNormalized;
        animatedSprite.position = ccp(0.5f, 0.5f);
        [animatedSprite runAnimation:@"animation_knight"];
        [self addChild:animatedSprite];
    }
    
	return self;
}

- (void)runAnimationButtonTouched {
    [animatedSprite runAnimation:@"animation_knight"];
}

- (void)stabAnimationButtonTouched {
    [animatedSprite runAnimation:@"animation_knight-stab"];
}

- (void)stopAnimationButtonTouched {
    [animatedSprite stopAnimation];
}

- (void)customFrameButtonTouched {
    [animatedSprite setFrame:@"animation_knight-1.png"];
}

- (void)manualAnimationButtonTouched {
    // load the animation
    CCActionAnimate *animation = [animatedSprite animationByName:@"animation_knight"];
    
    // stop any current animation
    [animatedSprite stopAnimation];
    
    // run loaded animation once
    [animatedSprite runAction:animation];
}

-(void)onceAnimationButtonTouched{

    [animatedSprite runAnimation:@"animation_knight" withCount:1];
}

@end