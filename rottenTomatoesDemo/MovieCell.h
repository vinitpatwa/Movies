//
//  MovieCell.h
//  rottenTomatoesDemo
//
//  Created by Vinit Patwa on 10/19/14.
//  Copyright (c) 2014 Vinit Patwa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *poster;
@property (weak, nonatomic) IBOutlet UILabel *movieName;
@property (weak, nonatomic) IBOutlet UILabel *movieDescription;

//- (void) setPoster:(NSURL *)url;
//- (void) setMovieName:(NSString *)movieName;
//- (void) setMovieDescription:(NSString *)movieDescription;

@end
