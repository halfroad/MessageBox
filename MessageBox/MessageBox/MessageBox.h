//
//  MessageBox.h
//  OwnHouseCar
//  iStadium
//
//  Created by Jinhui Li on 12/28/14.
//  Copyright (c) 2014 Half Road Software Inc. All rights reserved.
//


/*!
 This is a method.

 @param    param1    This is first parameter.

 @result
 This method returns nothing.

 @discussion
 This is an example.

- (void)someMethodWithParam1:(NSInteger)param1
{
}
 
  */

#import <UIKit/UIKit.h>

@interface MessageBox : UIView <UIAlertViewDelegate, UIActionSheetDelegate>

+ (MessageBox *) sharedInstance;

/**
 * Shows the alert message with title, message and cancel button.
 *
 * @see showAlertInfo: Message: CancelButtonTitle:
 */
- (void) showAlertInfo: (NSString *) title Message: (NSString *) message CancelButtonTitle: (NSString *) cancelButtonTitle;

/**
 * Shows the alert message with title, message, cancel button and event handler.
 *
 * @see showAlertInfo: Message: CancelButtonTitle: OnAlertViewButtonClickedEventHandler:
 */
- (void) showAlertInfo: (NSString *) title Message: (NSString *) message CancelButtonTitle: (NSString *) cancelButtonTitle OnAlertViewButtonClickedEventHandler: (void (^) (NSInteger buttonIndex)) buttonClickedEventHandler;

/**
 * Shows the alert message with cancel button and event handler.
 *
 * @see showAlertInfo: Message: CancelButtonTitle: OnAlertViewButtonClickedEventHandler:
 */
- (void) showActionSheet: (NSString *) cancelButtonTitle OnActionSheetButtonClickedEventHandler: (void (^) (NSInteger buttonIndex)) onActionSheetButtonClickedEventHandler;

/**
 * Shows the alert message with title, message, cancel button and event handler.
 *
 * @see showAlertInfo: Message: CancelButtonTitle: OnAlertViewButtonClickedEventHandler:
 */
- (void) showAlertInfo: (NSString *) title Message: (NSString *) message CancelButtonTitle: (NSString *) cancelButtonTitle OnAlertViewButtonClickedEventHandler : (void (^) (NSInteger buttonIndex)) buttonClickedEventHandler OtherButtonTitles: (NSString *) otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

/**
 * Shows the alert message with title, message, cancel button and InitialText, KeyboardType, event handler.
 *
 * @see alertViewTextInput: Message: CancelButtonTitle: KeyboardType: InitialText: OnAlertViewWithTextInputButtonClickedEventHandler: OtherButtonTitles:
 */
- (void) alertViewTextInput: (NSString *) title Message: (NSString *) message CancelButtonTitle: (NSString *) cancelButtonTitle KeyboardType: (UIKeyboardType) keyboardType InitialText: (NSString *) initialText OnAlertViewWithTextInputButtonClickedEventHandler: (void (^) (NSInteger buttonIndex, NSString *enteredText)) buttonClickedEventHandler OtherButtonTitles: (NSString *) otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

/**
 * Shows the alert message with title, message, cancel button and event handler.
 *
 * @see showAlertInfo: Message: CancelButtonTitle: AlertViewStyle: OnAlertViewSecuredInputButtonClickedEventHandler: OtherButtonTitles:
 */
- (void) alertViewTextInput: (NSString *) title Message: (NSString *) message CancelButtonTitle: (NSString *) cancelButtonTitle AlertViewStyle: (UIAlertViewStyle) alertViewStyle OnAlertViewSecuredInputButtonClickedEventHandler: (void (^) (NSInteger buttonIndex, NSString *securedTextFieldText)) buttonClickedEventHandler OtherButtonTitles: (NSString *) otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

/**
 * Shows the alert message with title, message, cancel button and event handler.
 *
 * @see showAlertInfo: Message: CancelButtonTitle: AlertViewStyle: OnAlertViewWithTextAndSecuredInputButtonClickedEventHandler: OtherButtonTitles:
 */
- (void) alertViewTextInput: (NSString *) title Message: (NSString *) message CancelButtonTitle: (NSString *) cancelButtonTitle AlertViewStyle: (UIAlertViewStyle) alertViewStyle OnAlertViewWithTextAndSecuredInputButtonClickedEventHandler: (void (^) (NSInteger buttonIndex, NSString *textFieldText, NSString *securedTextFieldText)) buttonClickedEventHandler OtherButtonTitles: (NSString *) otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

/**
 * Shows the alert message with title, message, cancel button and event handler.
 *
 * @see showAlertInfo: Message: CancelButtonTitle: AlertViewStyle: OnAlertViewSecuredInputButtonClickedEventHandler: OnAlertViewWithTextAndSecuredInputButtonClickedEventHandler: OtherButtonTitles:
 */
- (void) alertViewTextInput: (NSString *) title Message: (NSString *) message CancelButtonTitle: (NSString *) cancelButtonTitle AlertViewStyle: (UIAlertViewStyle) alertViewStyle OnAlertViewSecuredInputButtonClickedEventHandler: (void (^) (NSInteger buttonIndex, NSString *securedTextFieldText)) securedInputButtonClickedEventHandler OnAlertViewWithTextAndSecuredInputButtonClickedEventHandler: (void (^) (NSInteger buttonIndex, NSString *textFieldText, NSString *securedTextFieldText)) buttonClickedEventHandler OtherButtonTitles: (NSString *) otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

#pragma mark - Action Sheet

- (void) showActionSheet: (NSString *) cancelButtonTitle;

- (void) showActionSheet: (NSString *) title CancelButtonTitle: (NSString *) cancelButtonTitle;

- (void) showActionSheet: (UIActionSheetStyle) actionSheetStyle Title: (NSString *) title CancelButtonTitle: (NSString *) cancelButtonTitle;

- (void) showActionSheet: (NSString *) title CancelButtonTitle: (NSString *) cancelButtonTitle OnActionSheetButtonClickedEventHandler: (void (^) (NSInteger buttonIndex)) onActionSheetButtonClickedEventHandler;

- (void) showActionSheet: (NSString *) title OnActionSheetButtonClickedEventHandler: (void (^) (NSInteger buttonIndex)) onActionSheetButtonClickedEventHandler OtherButtonTitles: (NSString *) otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

- (void) showActionSheet: (NSString *) title CancelButtonTitle: (NSString *) cancelButtonTitle OnActionSheetButtonClickedEventHandler: (void (^) (NSInteger buttonIndex)) onActionSheetButtonClickedEventHandler OtherButtonTitles: (NSString *) otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

- (void) showActionSheet: (NSString *) title DestructiveButtonTitle: (NSString *) destructiveButtonTitle OnActionSheetButtonClickedEventHandler: (void (^) (NSInteger buttonIndex)) onActionSheetButtonClickedEventHandler OtherButtonTitles: (NSString *) otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

- (void) showActionSheet: (UIActionSheetStyle) actionSheetStyle Title: (NSString *) title CancelButtonTitle: (NSString *) cancelButtonTitle OnActionSheetButtonClickedEventHandler: (void (^) (NSInteger buttonIndex)) onActionSheetButtonClickedEventHandler OtherButtonTitles: (NSString *) otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

- (void) showActionSheet: (UIActionSheetStyle) actionSheetStyle Title: (NSString *) title CancelButtonTitle: (NSString *) cancelButtonTitle DestructiveButtonTitle: (NSString *) destructiveButtonTitle OnActionSheetButtonClickedEventHandler: (void (^) (NSInteger buttonIndex)) onActionSheetButtonClickedEventHandler OtherButtonTitles: (NSString *) otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

- (void) showActionSheet: (UIActionSheetStyle) actionSheetStyle Title: (NSString *) title CancelButtonTitle: (NSString *) cancelButtonTitle OtherButtonTitles: (NSArray *) otherButtonTitles OnActionSheetButtonClickedEventHandler: (void (^) (NSInteger buttonIndex)) onActionSheetButtonClickedEventHandler;

- (void) showActionSheet: (UIView *) inView ActionSheetStyle: (UIActionSheetStyle) actionSheetStyle Title: (NSString *) title CancelButtonTitle: (NSString *) cancelButtonTitle OtherButtonTitles: (NSArray *) otherButtonTitles OnActionSheetButtonClickedEventHandler: (void (^) (NSInteger buttonIndex)) onActionSheetButtonClickedEventHandler;

- (void) showActionSheet: (UIView *) inView ActionSheetStyle: (UIActionSheetStyle) actionSheetStyle Title: (NSString *) title CancelButtonTitle: (NSString *) cancelButtonTitle DestructiveButtonTitle: (NSString *) destructiveButtonTitle OtherButtonTitles: (NSArray *) otherButtonTitles OnActionSheetButtonClickedEventHandler: (void (^) (NSInteger buttonIndex)) onActionSheetButtonClickedEventHandler;

- (void) showActionSheet: (UIView *) inView ActionSheetStyle: (UIActionSheetStyle) actionSheetStyle Title: (NSString *) title CancelButtonTitle: (NSString *) cancelButtonTitle DestructiveButtonTitle: (NSString *) destructiveButtonTitle OnActionSheetButtonClickedEventHandler: (void (^) (NSInteger buttonIndex)) onActionSheetButtonClickedEventHandler ButtonTitles: (NSString *) otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

- (void) showActionSheet: (UIView *) inView ActionSheetStyle: (UIActionSheetStyle) actionSheetStyle Title: (NSString *) title CancelButtonTitle: (NSString *) cancelButtonTitle DestructiveButtonTitle: (NSString *) destructiveButtonTitle OnActionSheetButtonClickedEventHandler: (void (^) (NSInteger buttonIndex)) onActionSheetButtonClickedEventHandler OtherButtonTitles: (NSArray *) otherButtonTitles;

- (void) showActionSheet: (CGRect) rect InView: (UIView *) inView ActionSheetStyle: (UIActionSheetStyle) actionSheetStyle Title: (NSString *) title CancelButtonTitle: (NSString *) cancelButtonTitle DestructiveButtonTitle: (NSString *) destructiveButtonTitle OnActionSheetButtonClickedEventHandler: (void (^) (NSInteger buttonIndex)) onActionSheetButtonClickedEventHandler OtherButtonTitles: (NSString *) otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

- (void) showActionSheet: (CGRect) rect InView: (UIView *) inView ActionSheetStyle: (UIActionSheetStyle) actionSheetStyle Title: (NSString *) title CancelButtonTitle: (NSString *) cancelButtonTitle DestructiveButtonTitle: (NSString *) destructiveButtonTitle OtherButtonTitles: (NSArray *) otherButtonTitles OnActionSheetButtonClickedEventHandler: (void (^) (NSInteger buttonIndex)) onActionSheetButtonClickedEventHandler;

- (void) showActionSheet: (UIBarButtonItem *) barButtonItem ActionSheetStyle: (UIActionSheetStyle) actionSheetStyle Title: (NSString *) title CancelButtonTitle: (NSString *) cancelButtonTitle DestructiveButtonTitle: (NSString *) destructiveButtonTitle OnActionSheetButtonClickedEventHandler: (void (^) (NSInteger buttonIndex)) onActionSheetButtonClickedEventHandler OtherButtons: (NSString *) otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

- (void) showActionSheet: (UIBarButtonItem *) barButtonItem ActionSheetStyle: (UIActionSheetStyle) actionSheetStyle Title: (NSString *) title CancelButtonTitle: (NSString *) cancelButtonTitle DestructiveButtonTitle: (NSString *) destructiveButtonTitle ButtonTitles: (NSArray *) otherButtonTitles OnActionSheetButtonClickedEventHandler: (void (^) (NSInteger buttonIndex)) onActionSheetButtonClickedEventHandler;

@end
