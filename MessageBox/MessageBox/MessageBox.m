//
//  MessageBox.m
//  iStadium
//
//  Created by Jinhui Li on 12/28/14.
//  Copyright (c) 2014 Half Road Software Inc. All rights reserved.
//

#import "MessageBox.h"

static MessageBox* instance;

@interface MessageBox ()

@property (copy, nonatomic) void (^ onButtonClickedEventHandler) (NSInteger);
@property (copy, nonatomic) void (^ onAlertViewWithTextInputButtonClickedEventHandler) (NSInteger, NSString*);
@property (copy, nonatomic) void (^ onAlertViewWithSecuredInputButtonClickedEventHandler) (NSInteger, NSString*);
@property (copy, nonatomic) void (^ onAlertViewWithTextAndSecuredInputButtonClickedventHandler) (NSInteger, NSString *, NSString *);

@end

@implementation MessageBox

+ (MessageBox *) sharedInstance
{
	if (!instance)
		instance = [[MessageBox alloc] init];

	return instance;
}

#pragma mark - Aler View

/**
 * Shows the alert message with title, message and cancel button.
 *
 * @see showAlertInfo: Message: CancelButtonTitle:
 */
- (void) showAlertInfo: (NSString *) title Message: (NSString *) message CancelButtonTitle: (NSString *) cancelButtonTitle
{
	if ([NSThread isMainThread])
	{
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: title message: message delegate: self cancelButtonTitle: cancelButtonTitle otherButtonTitles: nil, nil];

		[alertView show];
	}
	else
	{
		[[NSOperationQueue mainQueue] addOperationWithBlock: ^{

			UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: title message: message delegate: self cancelButtonTitle: cancelButtonTitle otherButtonTitles: nil, nil];

			[alertView show];
		}];
	}

	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: title message: message delegate: self cancelButtonTitle: cancelButtonTitle otherButtonTitles: nil, nil];

	if ([NSThread isMainThread])
		[alertView show];
	else
	{
		[[NSOperationQueue mainQueue] addOperationWithBlock: ^{

			[alertView show];
		}];
	}
}

/**
 * Shows the alert message with title, message, cancel button and event handler.
 *
 * @see showAlertInfo: Message: CancelButtonTitle: OnAlertViewButtonClickedEventHandler:
 */
- (void) showAlertInfo: (NSString *) title Message: (NSString *) message CancelButtonTitle: (NSString *) cancelButtonTitle OnAlertViewButtonClickedEventHandler: (void (^) (NSInteger buttonIndex)) buttonClickedEventHandler
{
	self.onButtonClickedEventHandler = buttonClickedEventHandler;

	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil, nil];

	if ([NSThread isMainThread])
		[alertView show];
	else
	{
		[[NSOperationQueue mainQueue] addOperationWithBlock: ^{

			[alertView show];
		}];
	}
}

/**
 * Shows the alert message with title, message, cancel button and event handler.
 *
 * @see showAlertInfo: Message: CancelButtonTitle: OnAlertViewButtonClickedEventHandler:
 */
- (void) showAlertInfo: (NSString *) title Message: (NSString *) message CancelButtonTitle: (NSString *) cancelButtonTitle OnAlertViewButtonClickedEventHandler : (void (^) (NSInteger buttonIndex)) buttonClickedEventHandler OtherButtonTitles: (NSString *) otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
	self.onButtonClickedEventHandler = buttonClickedEventHandler;

	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];

	if ([NSThread isMainThread])
		[alertView show];
	else
	{
		[[NSOperationQueue mainQueue] addOperationWithBlock: ^{

			[alertView show];
		}];
	}
}

/**
 * Shows the alert message with title, message, cancel button and InitialText, KeyboardType, event handler.
 *
 * @see alertViewTextInput: Message: CancelButtonTitle: KeyboardType: InitialText: OnAlertViewWithTextInputButtonClickedEventHandler: OtherButtonTitles:
 */
- (void) alertViewTextInput: (NSString *) title Message: (NSString *) message CancelButtonTitle: (NSString *) cancelButtonTitle KeyboardType: (UIKeyboardType) keyboardType InitialText: (NSString *) initialText OnAlertViewWithTextInputButtonClickedEventHandler: (void (^) (NSInteger buttonIndex, NSString *enteredText)) buttonClickedEventHandler OtherButtonTitles: (NSString *) otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
	self.onAlertViewWithTextInputButtonClickedEventHandler = buttonClickedEventHandler;

	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: title message: message delegate: self cancelButtonTitle: cancelButtonTitle otherButtonTitles: otherButtonTitles, nil];

	if (otherButtonTitles)
	{
		va_list args ;
		va_start (args, otherButtonTitles);
		NSString *string;

		while ((string = va_arg (args, NSString *)))
		{
			[alertView addButtonWithTitle: string];
		}

		va_end(args);
	}

	alertView.alertViewStyle	= UIAlertViewStylePlainTextInput;
	UITextField *textField		= [alertView textFieldAtIndex: 0];
	textField.text				= initialText;
	textField.keyboardType		= keyboardType;

	if ([NSThread isMainThread])
		[alertView show];
	else
	{
		[[NSOperationQueue mainQueue] addOperationWithBlock: ^{

			[alertView show];
		}];
	}
}

/**
 * Shows the alert message with title, message, cancel button and event handler.
 *
 * @see showAlertInfo: Message: CancelButtonTitle: AlertViewStyle: OnAlertViewSecuredInputButtonClickedEventHandler: OtherButtonTitles:
 */
- (void) alertViewTextInput: (NSString *) title Message: (NSString *) message CancelButtonTitle: (NSString *) cancelButtonTitle AlertViewStyle: (UIAlertViewStyle) alertViewStyle OnAlertViewSecuredInputButtonClickedEventHandler: (void (^) (NSInteger buttonIndex, NSString *securedTextFieldText)) buttonClickedEventHandler OtherButtonTitles: (NSString *) otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
	[self alertViewTextInput: title Message: message CancelButtonTitle: cancelButtonTitle AlertViewStyle: alertViewStyle OnAlertViewSecuredInputButtonClickedEventHandler: buttonClickedEventHandler OnAlertViewWithTextAndSecuredInputButtonClickedEventHandler: nil OtherButtonTitles: otherButtonTitles, nil];
}

/**
 * Shows the alert message with title, message, cancel button and event handler.
 *
 * @see showAlertInfo: Message: CancelButtonTitle: AlertViewStyle: OnAlertViewWithTextAndSecuredInputButtonClickedEventHandler: OtherButtonTitles:
 */
- (void) alertViewTextInput: (NSString *) title Message: (NSString *) message CancelButtonTitle: (NSString *) cancelButtonTitle AlertViewStyle: (UIAlertViewStyle) alertViewStyle OnAlertViewWithTextAndSecuredInputButtonClickedEventHandler: (void (^) (NSInteger buttonIndex, NSString *textFieldText, NSString *securedTextFieldText)) buttonClickedEventHandler OtherButtonTitles: (NSString *) otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
	[self alertViewTextInput: title Message: message CancelButtonTitle: cancelButtonTitle AlertViewStyle: alertViewStyle OnAlertViewSecuredInputButtonClickedEventHandler: nil OnAlertViewWithTextAndSecuredInputButtonClickedEventHandler: buttonClickedEventHandler OtherButtonTitles: otherButtonTitles, nil];
}

/**
 * Shows the alert message with title, message, cancel button and event handler.
 *
 * @see showAlertInfo: Message: CancelButtonTitle: AlertViewStyle: OnAlertViewSecuredInputButtonClickedEventHandler: OnAlertViewWithTextAndSecuredInputButtonClickedEventHandler: OtherButtonTitles:
 */
- (void) alertViewTextInput: (NSString *) title Message: (NSString *) message CancelButtonTitle: (NSString *) cancelButtonTitle AlertViewStyle: (UIAlertViewStyle) alertViewStyle OnAlertViewSecuredInputButtonClickedEventHandler: (void (^) (NSInteger buttonIndex, NSString *securedTextFieldText)) securedInputButtonClickedEventHandler OnAlertViewWithTextAndSecuredInputButtonClickedEventHandler: (void (^) (NSInteger buttonIndex, NSString *textFieldText, NSString *securedTextFieldText)) buttonClickedEventHandler OtherButtonTitles: (NSString *) otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
	self.onAlertViewWithSecuredInputButtonClickedEventHandler		= securedInputButtonClickedEventHandler;
	self.onAlertViewWithTextAndSecuredInputButtonClickedventHandler = buttonClickedEventHandler;

	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: title message: message delegate: self cancelButtonTitle:cancelButtonTitle otherButtonTitles: otherButtonTitles, nil];

	if (otherButtonTitles)
	{
		va_list args ;
		va_start (args, otherButtonTitles);
		NSString *string;

		while ((string = va_arg (args, NSString *)))
		{
			[alertView addButtonWithTitle: string];
		}

		va_end (args);
	}

	alertView.alertViewStyle = alertViewStyle;

	if ([NSThread isMainThread])
		[alertView show];
	else
	{
		[[NSOperationQueue mainQueue] addOperationWithBlock: ^{

			[alertView show];
		}];
	}
}

- (void) alertView: (UIAlertView *) alertView clickedButtonAtIndex: (NSInteger) buttonIndex
{
	switch (buttonIndex)
	{
		case 0:
		{
			if (self.onButtonClickedEventHandler)
			{
				self.onButtonClickedEventHandler (buttonIndex);
				self.onButtonClickedEventHandler = nil;
			}
			else if (self.onAlertViewWithTextInputButtonClickedEventHandler)
			{
				UITextField *textField = [alertView textFieldAtIndex: 0];
				self.onAlertViewWithTextInputButtonClickedEventHandler (buttonIndex, textField.text);

				self.onAlertViewWithTextInputButtonClickedEventHandler = nil;
			}
		}
			break;

		case 1:
		{
			if (self.onButtonClickedEventHandler)
			{
				self.onButtonClickedEventHandler (buttonIndex);
				self.onButtonClickedEventHandler = nil;
			}
			else if (self.onAlertViewWithTextInputButtonClickedEventHandler)
			{
				UITextField *textField	= [alertView textFieldAtIndex: 0];

				self.onAlertViewWithTextInputButtonClickedEventHandler (buttonIndex, textField.text);
				self.onAlertViewWithTextInputButtonClickedEventHandler = nil;
			}
			else
			{
				if (alertView.alertViewStyle == UIAlertViewStyleSecureTextInput)
				{
					UITextField *securedTextField = [alertView textFieldAtIndex: 0];

					if (self.onAlertViewWithSecuredInputButtonClickedEventHandler)
					{
						self.onAlertViewWithSecuredInputButtonClickedEventHandler (buttonIndex, securedTextField.text);
						self.onAlertViewWithSecuredInputButtonClickedEventHandler = nil;
					}
				}
				else if (alertView.alertViewStyle == UIAlertViewStyleLoginAndPasswordInput)
				{
					UITextField *textField			= [alertView textFieldAtIndex: 0];
					UITextField *securedTextField	= [alertView textFieldAtIndex: 1];

					if (self.onAlertViewWithTextAndSecuredInputButtonClickedventHandler)
					{
						self.onAlertViewWithTextAndSecuredInputButtonClickedventHandler (buttonIndex, textField.text, securedTextField.text);
						self.onAlertViewWithTextAndSecuredInputButtonClickedventHandler = nil;
					}
				}
			}
		}
			break;

		default:
			break;
	}

}

#pragma mark - Action Sheet

- (void) showActionSheet: (NSString *) cancelButtonTitle
{
	[self showActionSheet: UIActionSheetStyleDefault Title: nil CancelButtonTitle: cancelButtonTitle];
}

- (void) showActionSheet: (NSString *) title CancelButtonTitle: (NSString *) cancelButtonTitle
{
	[self showActionSheet: UIActionSheetStyleDefault Title: title CancelButtonTitle:cancelButtonTitle];
}

- (void) showActionSheet: (NSString *) cancelButtonTitle OnActionSheetButtonClickedEventHandler: (void (^) (NSInteger buttonIndex)) onActionSheetButtonClickedEventHandler
{
	[self showActionSheet: UIActionSheetStyleDefault Title: nil CancelButtonTitle: cancelButtonTitle OnActionSheetButtonClickedEventHandler: onActionSheetButtonClickedEventHandler OtherButtonTitles: nil, nil];
}

- (void) showActionSheet: (UIActionSheetStyle) actionSheetStyle Title: (NSString *) title CancelButtonTitle: (NSString *) cancelButtonTitle
{
	[self showActionSheet: actionSheetStyle Title: title CancelButtonTitle: cancelButtonTitle OnActionSheetButtonClickedEventHandler: nil OtherButtonTitles: nil, nil];
}

- (void) showActionSheet: (NSString *) title CancelButtonTitle: (NSString *) cancelButtonTitle OnActionSheetButtonClickedEventHandler: (void (^) (NSInteger buttonIndex)) onActionSheetButtonClickedEventHandler
{
	[self showActionSheet: UIActionSheetStyleDefault Title: title CancelButtonTitle: cancelButtonTitle OnActionSheetButtonClickedEventHandler: onActionSheetButtonClickedEventHandler OtherButtonTitles: nil, nil];
}

- (void) showActionSheet: (NSString *) title OnActionSheetButtonClickedEventHandler: (void (^) (NSInteger buttonIndex)) onActionSheetButtonClickedEventHandler OtherButtonTitles: (NSString *) otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
	self.onButtonClickedEventHandler = onActionSheetButtonClickedEventHandler;

	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle: title delegate: self cancelButtonTitle: nil destructiveButtonTitle: nil otherButtonTitles: otherButtonTitles, nil];

	if (otherButtonTitles)
	{
		//[actionSheet addButtonWithTitle: otherButtonTitles];

		va_list args ;
		va_start (args, otherButtonTitles);
		NSString *string;

		while ((string = va_arg (args, NSString *)))
		{
			[actionSheet addButtonWithTitle: string];
		}

		va_end (args);
	}

	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;

	if ([NSThread isMainThread])
		[actionSheet showInView: self];
	else
	{
		[[NSOperationQueue mainQueue] addOperationWithBlock: ^{

			[actionSheet showInView: self];
		}];
	}
}

- (void) showActionSheet: (NSString *) title CancelButtonTitle: (NSString *) cancelButtonTitle OnActionSheetButtonClickedEventHandler: (void (^) (NSInteger buttonIndex)) onActionSheetButtonClickedEventHandler OtherButtonTitles: (NSString *) otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
	self.onButtonClickedEventHandler	= onActionSheetButtonClickedEventHandler;
	UIActionSheet *actionSheet			= [[UIActionSheet alloc] initWithTitle: title delegate: self cancelButtonTitle: cancelButtonTitle destructiveButtonTitle: nil otherButtonTitles: otherButtonTitles, nil];

	if (otherButtonTitles)
	{
		//[actionSheet addButtonWithTitle: otherButtonTitles];

		va_list args ;
		va_start (args, otherButtonTitles);
		NSString *string;

		while ((string = va_arg (args, NSString *)))
		{
			[actionSheet addButtonWithTitle: string];
		}

		va_end (args);
	}

	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;

	if ([NSThread isMainThread])
		[actionSheet showInView: self];
	else
	{
		[[NSOperationQueue mainQueue] addOperationWithBlock: ^{

			[actionSheet showInView: self];
		}];
	}
}

- (void) showActionSheet: (NSString *) title DestructiveButtonTitle: (NSString *) destructiveButtonTitle OnActionSheetButtonClickedEventHandler: (void (^) (NSInteger buttonIndex)) onActionSheetButtonClickedEventHandler OtherButtonTitles: (NSString *) otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
	self.onButtonClickedEventHandler = onActionSheetButtonClickedEventHandler;

	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle: title delegate: self cancelButtonTitle: nil destructiveButtonTitle: destructiveButtonTitle otherButtonTitles: otherButtonTitles, nil];

	if (otherButtonTitles)
	{
		//[actionSheet addButtonWithTitle: otherButtonTitles];

		va_list args ;
		va_start (args, otherButtonTitles);
		NSString *string;

		while ((string = va_arg (args, NSString *)))
		{
			[actionSheet addButtonWithTitle: string];
		}

		va_end (args);
	}

	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;

	if ([NSThread isMainThread])
		[actionSheet showInView: self];
	else
	{
		[[NSOperationQueue mainQueue] addOperationWithBlock: ^{

			[actionSheet showInView: self];
		}];
	}
}

- (void) showActionSheet: (UIActionSheetStyle) actionSheetStyle Title: (NSString *) title CancelButtonTitle: (NSString *) cancelButtonTitle OnActionSheetButtonClickedEventHandler: (void (^) (NSInteger buttonIndex)) onActionSheetButtonClickedEventHandler OtherButtonTitles: (NSString *) otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
	self.onButtonClickedEventHandler = onActionSheetButtonClickedEventHandler;

	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate: self cancelButtonTitle: cancelButtonTitle destructiveButtonTitle: nil otherButtonTitles: otherButtonTitles, nil];

	if (otherButtonTitles)
	{
		//[actionSheet addButtonWithTitle: otherButtonTitles];

		va_list args ;
		va_start (args, otherButtonTitles);
		NSString *string;

		while ((string = va_arg (args, NSString *)))
		{
			[actionSheet addButtonWithTitle: string];
		}

		va_end (args);
	}

	actionSheet.actionSheetStyle = actionSheetStyle;

	if ([NSThread isMainThread])
		[actionSheet showInView: self];
	else
	{
		[[NSOperationQueue mainQueue] addOperationWithBlock: ^{

			[actionSheet showInView: self];
		}];
	}
}

- (void) showActionSheet: (UIActionSheetStyle) actionSheetStyle Title: (NSString *) title CancelButtonTitle: (NSString *) cancelButtonTitle DestructiveButtonTitle: (NSString *) destructiveButtonTitle OnActionSheetButtonClickedEventHandler: (void (^) (NSInteger buttonIndex)) onActionSheetButtonClickedEventHandler OtherButtonTitles: (NSString *) otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
	self.onButtonClickedEventHandler = onActionSheetButtonClickedEventHandler;

	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate: self cancelButtonTitle:cancelButtonTitle destructiveButtonTitle: destructiveButtonTitle otherButtonTitles:otherButtonTitles, nil];

	if (otherButtonTitles)
	{
		//[actionSheet addButtonWithTitle: otherButtonTitles];

		va_list args ;
		va_start (args, otherButtonTitles);
		NSString *string;

		while ((string = va_arg (args, NSString *)))
		{
			[actionSheet addButtonWithTitle: string];
		}

		va_end (args);
	}

	actionSheet.actionSheetStyle = actionSheetStyle;

	if ([NSThread isMainThread])
		[actionSheet showInView: self];
	else
	{
		[[NSOperationQueue mainQueue] addOperationWithBlock: ^{

			[actionSheet showInView: self];
		}];
	}
}

- (void) showActionSheet: (UIActionSheetStyle) actionSheetStyle Title: (NSString *) title CancelButtonTitle: (NSString *) cancelButtonTitle OtherButtonTitles: (NSArray *) otherButtonTitles OnActionSheetButtonClickedEventHandler: (void (^) (NSInteger buttonIndex)) onActionSheetButtonClickedEventHandler
{
	self.onButtonClickedEventHandler = onActionSheetButtonClickedEventHandler;

	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:cancelButtonTitle destructiveButtonTitle: nil otherButtonTitles: nil];

	[otherButtonTitles enumerateObjectsUsingBlock: ^(NSString *string, NSUInteger idx, BOOL *stop) {

		[actionSheet addButtonWithTitle: string];

	}];

	actionSheet.actionSheetStyle = actionSheetStyle;

	if ([NSThread isMainThread])
		[actionSheet showInView: self];
	else
	{
		[[NSOperationQueue mainQueue] addOperationWithBlock: ^{

			[actionSheet showInView: self];
		}];
	}
}

- (void) showActionSheet: (UIView *) inView ActionSheetStyle: (UIActionSheetStyle) actionSheetStyle Title: (NSString *) title CancelButtonTitle: (NSString *) cancelButtonTitle OtherButtonTitles: (NSArray *) otherButtonTitles OnActionSheetButtonClickedEventHandler: (void (^) (NSInteger buttonIndex)) onActionSheetButtonClickedEventHandler
{
	self.onButtonClickedEventHandler = onActionSheetButtonClickedEventHandler;

	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate: self cancelButtonTitle:cancelButtonTitle destructiveButtonTitle: nil otherButtonTitles: nil];

	[otherButtonTitles enumerateObjectsUsingBlock: ^(NSString *string, NSUInteger idx, BOOL *stop) {

		[actionSheet addButtonWithTitle: string];

	}];

	actionSheet.actionSheetStyle = actionSheetStyle;

	if ([NSThread isMainThread])
		[actionSheet showInView: inView];
	else
	{
		[[NSOperationQueue mainQueue] addOperationWithBlock: ^{

			[actionSheet showInView: inView];
		}];
	}
}

- (void) showActionSheet: (UIView *) inView ActionSheetStyle: (UIActionSheetStyle) actionSheetStyle Title: (NSString *) title CancelButtonTitle: (NSString *) cancelButtonTitle DestructiveButtonTitle: (NSString *) destructiveButtonTitle OtherButtonTitles: (NSArray *) otherButtonTitles OnActionSheetButtonClickedEventHandler: (void (^) (NSInteger buttonIndex)) onActionSheetButtonClickedEventHandler
{
	self.onButtonClickedEventHandler = onActionSheetButtonClickedEventHandler;

	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle: title delegate:self cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles: nil];

	[otherButtonTitles enumerateObjectsUsingBlock: ^(NSString *string, NSUInteger idx, BOOL *stop) {

		[actionSheet addButtonWithTitle: string];

	}];

	actionSheet.actionSheetStyle = actionSheetStyle;

	if ([NSThread isMainThread])
		[actionSheet showInView: inView];
	else
	{
		[[NSOperationQueue mainQueue] addOperationWithBlock: ^{

			[actionSheet showInView: inView];
		}];
	}
}

- (void) showActionSheet: (UIView *) inView ActionSheetStyle: (UIActionSheetStyle) actionSheetStyle Title: (NSString *) title CancelButtonTitle: (NSString *) cancelButtonTitle DestructiveButtonTitle: (NSString *) destructiveButtonTitle OnActionSheetButtonClickedEventHandler: (void (^) (NSInteger buttonIndex)) onActionSheetButtonClickedEventHandler ButtonTitles: (NSString *) otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
	self.onButtonClickedEventHandler = onActionSheetButtonClickedEventHandler;

	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitles, nil];

	if (otherButtonTitles)
	{
		//[actionSheet addButtonWithTitle: otherButtonTitles];

		va_list args ;
		va_start (args, otherButtonTitles);
		NSString *string;

		while ((string = va_arg (args, NSString *)))
		{
			[actionSheet addButtonWithTitle: string];
		}

		va_end (args);
	}

	actionSheet.actionSheetStyle = actionSheetStyle;

	if ([NSThread isMainThread])
		[actionSheet showInView: inView];
	else
	{
		[[NSOperationQueue mainQueue] addOperationWithBlock: ^{

			[actionSheet showInView: inView];
		}];
	}
}

- (void) showActionSheet: (UIView *) inView ActionSheetStyle: (UIActionSheetStyle) actionSheetStyle Title: (NSString *) title CancelButtonTitle: (NSString *) cancelButtonTitle DestructiveButtonTitle: (NSString *) destructiveButtonTitle OnActionSheetButtonClickedEventHandler: (void (^) (NSInteger buttonIndex)) onActionSheetButtonClickedEventHandler OtherButtonTitles: (NSArray *) otherButtonTitles
{
	self.onButtonClickedEventHandler = onActionSheetButtonClickedEventHandler;

	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles: nil];

	[otherButtonTitles enumerateObjectsUsingBlock: ^(NSString *string, NSUInteger idx, BOOL *stop) {

		[actionSheet addButtonWithTitle: string];

	}];

	actionSheet.actionSheetStyle = actionSheetStyle;

	if ([NSThread isMainThread])
		[actionSheet showInView: inView];
	else
	{
		[[NSOperationQueue mainQueue] addOperationWithBlock: ^{

			[actionSheet showInView: inView];
		}];
	}
}

- (void) showActionSheet: (CGRect) rect InView: (UIView *) inView ActionSheetStyle: (UIActionSheetStyle) actionSheetStyle Title: (NSString *) title CancelButtonTitle: (NSString *) cancelButtonTitle DestructiveButtonTitle: (NSString *) destructiveButtonTitle OnActionSheetButtonClickedEventHandler: (void (^) (NSInteger buttonIndex)) onActionSheetButtonClickedEventHandler OtherButtonTitles: (NSString *) otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
	self.onButtonClickedEventHandler = onActionSheetButtonClickedEventHandler;

	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle: title delegate:self cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitles, nil];

	if (otherButtonTitles)
	{
		//[actionSheet addButtonWithTitle: otherButtonTitles];

		va_list args ;
		va_start (args, otherButtonTitles);
		NSString *string;

		while ((string = va_arg (args, NSString *)))
		{
			[actionSheet addButtonWithTitle: string];
		}

		va_end (args);
	}

	actionSheet.actionSheetStyle = actionSheetStyle;

	if ([NSThread isMainThread])
		[actionSheet showFromRect:rect inView:inView animated: YES];
	else
	{
		[[NSOperationQueue mainQueue] addOperationWithBlock: ^{

			[actionSheet showFromRect:rect inView:inView animated: YES];
		}];
	}
}

- (void) showActionSheet: (CGRect) rect InView: (UIView *) inView ActionSheetStyle: (UIActionSheetStyle) actionSheetStyle Title: (NSString *) title CancelButtonTitle: (NSString *) cancelButtonTitle DestructiveButtonTitle: (NSString *) destructiveButtonTitle OtherButtonTitles: (NSArray *) otherButtonTitles OnActionSheetButtonClickedEventHandler: (void (^) (NSInteger buttonIndex)) onActionSheetButtonClickedEventHandler
{
	self.onButtonClickedEventHandler = onActionSheetButtonClickedEventHandler;

	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles: nil];

	[otherButtonTitles enumerateObjectsUsingBlock: ^(NSString *string, NSUInteger idx, BOOL *stop) {

		[actionSheet addButtonWithTitle: string];

	}];

	actionSheet.actionSheetStyle = actionSheetStyle;

	if ([NSThread isMainThread])
		[actionSheet showFromRect:rect inView:inView animated: YES];
	else
	{
		[[NSOperationQueue mainQueue] addOperationWithBlock: ^{

			[actionSheet showFromRect:rect inView: inView animated: YES];
		}];
	}
}

- (void) showActionSheet: (UIBarButtonItem *) barButtonItem ActionSheetStyle: (UIActionSheetStyle) actionSheetStyle Title: (NSString *) title CancelButtonTitle: (NSString *) cancelButtonTitle DestructiveButtonTitle: (NSString *) destructiveButtonTitle OnActionSheetButtonClickedEventHandler: (void (^) (NSInteger buttonIndex)) onActionSheetButtonClickedEventHandler OtherButtons: (NSString *) otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
	self.onButtonClickedEventHandler = onActionSheetButtonClickedEventHandler;

	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitles, nil];

	if (otherButtonTitles)
	{
		//[actionSheet addButtonWithTitle: otherButtonTitles];

		va_list args ;
		va_start (args, otherButtonTitles);
		NSString *string;

		while ((string = va_arg (args, NSString *)))
		{
			[actionSheet addButtonWithTitle: string];
		}

		va_end (args);
	}

	actionSheet.actionSheetStyle = actionSheetStyle;

	if ([NSThread isMainThread])
		[actionSheet showFromBarButtonItem:barButtonItem animated: YES];
	else
	{
		[[NSOperationQueue mainQueue] addOperationWithBlock: ^{

			[actionSheet showFromBarButtonItem:barButtonItem animated: YES];
		}];
	}
}

- (void) showActionSheet: (UIBarButtonItem *) barButtonItem ActionSheetStyle: (UIActionSheetStyle) actionSheetStyle Title: (NSString *) title CancelButtonTitle: (NSString *) cancelButtonTitle DestructiveButtonTitle: (NSString *) destructiveButtonTitle ButtonTitles: (NSArray *) otherButtonTitles OnActionSheetButtonClickedEventHandler: (void (^) (NSInteger buttonIndex)) onActionSheetButtonClickedEventHandler
{
	self.onButtonClickedEventHandler = onActionSheetButtonClickedEventHandler;

	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles: nil];

	[otherButtonTitles enumerateObjectsUsingBlock: ^(NSString *string, NSUInteger idx, BOOL *stop) {

		[actionSheet addButtonWithTitle: string];

	}];

	actionSheet.actionSheetStyle = actionSheetStyle;

	if ([NSThread isMainThread])
		[actionSheet showFromBarButtonItem: barButtonItem animated: YES];
	else
	{
		[[NSOperationQueue mainQueue] addOperationWithBlock: ^{

			[actionSheet showFromBarButtonItem: barButtonItem animated: YES];
		}];
	}
}

- (void) actionSheet: (UIActionSheet *) actionSheet clickedButtonAtIndex: (NSInteger)buttonIndex
{
	if (self.onButtonClickedEventHandler)
	{
		self.onButtonClickedEventHandler (buttonIndex);
		self.onButtonClickedEventHandler = nil;
	}
}

@end
