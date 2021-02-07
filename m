Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD6FC3124B3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 15:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhBGOe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 09:34:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:49314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229491AbhBGOe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 09:34:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6439264E42;
        Sun,  7 Feb 2021 14:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612708457;
        bh=WTLkE+iYv7ult7TIpL8q2wfswvIm5afRydOWeq9c3gw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pxV7sVXNpdtHe9hjvs+NnUrufoizzc7hIO9DhS4UEqJRcj0OPE+oCfA1Fq46+gdRd
         uFQ/2em8dMzcbrczxiXdCkL537pa7vxtkcCv37P469oN5kwtzxrNknl0Tv31szrNeH
         4fepcD4x1gLtF+AqRd1PAtPZ8394yU8IUTbQ4N9M=
Date:   Sun, 7 Feb 2021 15:34:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     karthek <mail@karthek.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: fix block comments alignment
Message-ID: <YB/6ZmZwCF3jeEue@kroah.com>
References: <YB/2Uvj99+sReckM@karthik-strix-linux.karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YB/2Uvj99+sReckM@karthik-strix-linux.karthek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 07:46:50PM +0530, karthek wrote:
> fix checkpatch.pl warning for "block comments should align the * on each line"
> 
> Signed-off-by: karthek <mail@karthek.com>
> ---
> eudyptula challenge thing
> 
>  .../staging/rtl8723bs/hal/rtl8723b_phycfg.c   | 204 +++++++++---------
>  1 file changed, 102 insertions(+), 102 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
> index cf23414d7..003f954c2 100644
> --- a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
> +++ b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
> @@ -20,16 +20,16 @@
>  #define MAX_DOZE_WAITING_TIMES_9x 64
>  
>  /**
> -* Function:	phy_CalculateBitShift
> -*
> -* OverView:	Get shifted position of the BitMask
> -*
> -* Input:
> -*		u32 	BitMask,
> -*
> -* Output:	none
> -* Return:		u32 	Return the shift bit bit position of the mask
> -*/
> + * Function:	phy_CalculateBitShift
> + *
> + * OverView:	Get shifted position of the BitMask
> + *
> + * Input:
> + *		u32 	BitMask,
> + *
> + * Output:	none
> + * Return:		u32 	Return the shift bit bit position of the mask
> + */
>  static	u32 phy_CalculateBitShift(u32 BitMask)
>  {
>  	u32 i;
> @@ -43,19 +43,19 @@ static	u32 phy_CalculateBitShift(u32 BitMask)
>  
>  
>  /**
> -* Function:	PHY_QueryBBReg
> -*
> -* OverView:	Read "specific bits" from BB register
> -*
> -* Input:
> -*		struct adapter *	Adapter,
> -*		u32 		RegAddr,	The target address to be readback
> -*		u32 		BitMask		The target bit position in the target address
> -*							to be readback
> -* Output:	None
> -* Return:		u32 		Data		The readback register value
> -* Note:		This function is equal to "GetRegSetting" in PHY programming guide
> -*/
> + * Function:	PHY_QueryBBReg
> + *
> + * OverView:	Read "specific bits" from BB register
> + *
> + * Input:
> + *		struct adapter *	Adapter,
> + *		u32 		RegAddr,	The target address to be readback
> + *		u32 		BitMask		The target bit position in the target address
> + *							to be readback
> + * Output:	None
> + * Return:		u32 		Data		The readback register value
> + * Note:		This function is equal to "GetRegSetting" in PHY programming guide
> + */
>  u32 PHY_QueryBBReg_8723B(struct adapter *Adapter, u32 RegAddr, u32 BitMask)
>  {
>  	u32 OriginalValue, BitShift;
> @@ -75,22 +75,22 @@ u32 PHY_QueryBBReg_8723B(struct adapter *Adapter, u32 RegAddr, u32 BitMask)
>  
>  
>  /**
> -* Function:	PHY_SetBBReg
> -*
> -* OverView:	Write "Specific bits" to BB register (page 8~)
> -*
> -* Input:
> -*		struct adapter *	Adapter,
> -*		u32 		RegAddr,	The target address to be modified
> -*		u32 		BitMask		The target bit position in the target address
> -*								to be modified
> -*		u32 		Data		The new register value in the target bit position
> -*								of the target address
> -*
> -* Output:	None
> -* Return:		None
> -* Note:		This function is equal to "PutRegSetting" in PHY programming guide
> -*/
> + * Function:	PHY_SetBBReg
> + *
> + * OverView:	Write "Specific bits" to BB register (page 8~)
> + *
> + * Input:
> + *		struct adapter *	Adapter,
> + *		u32 		RegAddr,	The target address to be modified
> + *		u32 		BitMask		The target bit position in the target address
> + *								to be modified
> + *		u32 		Data		The new register value in the target bit position
> + *								of the target address
> + *
> + * Output:	None
> + * Return:		None
> + * Note:		This function is equal to "PutRegSetting" in PHY programming guide
> + */
>  
>  void PHY_SetBBReg_8723B(
>  	struct adapter *Adapter,
> @@ -184,25 +184,25 @@ static u32 phy_RFSerialRead_8723B(
>  }
>  
>  /**
> -* Function:	phy_RFSerialWrite_8723B
> -*
> -* OverView:	Write data to RF register (page 8~)
> -*
> -* Input:
> -*		struct adapter *	Adapter,
> -*		RF_PATH			eRFPath,	Radio path of A/B/C/D
> -*		u32 		Offset,		The target address to be read
> -*		u32 		Data		The new register Data in the target bit position
> -*								of the target to be read
> -*
> -* Output:	None
> -* Return:		None
> -* Note:		Threre are three types of serial operations:
> -*		1. Software serial write
> -*		2. Hardware LSSI-Low Speed Serial Interface
> -*		3. Hardware HSSI-High speed
> -*		serial write. Driver need to implement (1) and (2).
> -*		This function is equal to the combination of RF_ReadReg() and  RFLSSIRead()
> + * Function:	phy_RFSerialWrite_8723B
> + *
> + * OverView:	Write data to RF register (page 8~)
> + *
> + * Input:
> + *		struct adapter *	Adapter,
> + *		RF_PATH			eRFPath,	Radio path of A/B/C/D
> + *		u32 		Offset,		The target address to be read
> + *		u32 		Data		The new register Data in the target bit position
> + *								of the target to be read
> + *
> + * Output:	None
> + * Return:		None
> + * Note:		Threre are three types of serial operations:
> + *		1. Software serial write
> + *		2. Hardware LSSI-Low Speed Serial Interface
> + *		3. Hardware HSSI-High speed
> + *		serial write. Driver need to implement (1) and (2).
> + *		This function is equal to the combination of RF_ReadReg() and  RFLSSIRead()
>   *
>   * Note:		  For RF8256 only
>   *		 The total count of RTL8256(Zebra4) register is around 36 bit it only employs
> @@ -225,7 +225,7 @@ static u32 phy_RFSerialRead_8723B(
>   *
>   *
>   *
> -*/
> + */
>  static void phy_RFSerialWrite_8723B(
>  	struct adapter *Adapter,
>  	enum RF_PATH eRFPath,
> @@ -261,21 +261,21 @@ static void phy_RFSerialWrite_8723B(
>  
>  
>  /**
> -* Function:	PHY_QueryRFReg
> -*
> -* OverView:	Query "Specific bits" to RF register (page 8~)
> -*
> -* Input:
> -*		struct adapter *	Adapter,
> -*		RF_PATH			eRFPath,	Radio path of A/B/C/D
> -*		u32 		RegAddr,	The target address to be read
> -*		u32 		BitMask		The target bit position in the target address
> -*								to be read
> -*
> -* Output:	None
> -* Return:		u32 		Readback value
> -* Note:		This function is equal to "GetRFRegSetting" in PHY programming guide
> -*/
> + * Function:	PHY_QueryRFReg
> + *
> + * OverView:	Query "Specific bits" to RF register (page 8~)
> + *
> + * Input:
> + *		struct adapter *	Adapter,
> + *		RF_PATH			eRFPath,	Radio path of A/B/C/D
> + *		u32 		RegAddr,	The target address to be read
> + *		u32 		BitMask		The target bit position in the target address
> + *								to be read
> + *
> + * Output:	None
> + * Return:		u32 		Readback value
> + * Note:		This function is equal to "GetRFRegSetting" in PHY programming guide
> + */
>  u32 PHY_QueryRFReg_8723B(
>  	struct adapter *Adapter,
>  	u8 eRFPath,
> @@ -296,23 +296,23 @@ u32 PHY_QueryRFReg_8723B(
>  }
>  
>  /**
> -* Function:	PHY_SetRFReg
> -*
> -* OverView:	Write "Specific bits" to RF register (page 8~)
> -*
> -* Input:
> -*		struct adapter *	Adapter,
> -*		RF_PATH			eRFPath,	Radio path of A/B/C/D
> -*		u32 		RegAddr,	The target address to be modified
> -*		u32 		BitMask		The target bit position in the target address
> -*								to be modified
> -*		u32 		Data		The new register Data in the target bit position
> -*								of the target address
> -*
> -* Output:	None
> -* Return:		None
> -* Note:		This function is equal to "PutRFRegSetting" in PHY programming guide
> -*/
> + * Function:	PHY_SetRFReg
> + *
> + * OverView:	Write "Specific bits" to RF register (page 8~)
> + *
> + * Input:
> + *		struct adapter *	Adapter,
> + *		RF_PATH			eRFPath,	Radio path of A/B/C/D
> + *		u32 		RegAddr,	The target address to be modified
> + *		u32 		BitMask		The target bit position in the target address
> + *								to be modified
> + *		u32 		Data		The new register Data in the target bit position
> + *								of the target address
> + *
> + * Output:	None
> + * Return:		None
> + * Note:		This function is equal to "PutRFRegSetting" in PHY programming guide
> + */
>  void PHY_SetRFReg_8723B(
>  	struct adapter *Adapter,
>  	u8 eRFPath,
> @@ -369,17 +369,17 @@ s32 PHY_MACConfig8723B(struct adapter *Adapter)
>  }
>  
>  /**
> -* Function:	phy_InitBBRFRegisterDefinition
> -*
> -* OverView:	Initialize Register definition offset for Radio Path A/B/C/D
> -*
> -* Input:
> -*		struct adapter *	Adapter,
> -*
> -* Output:	None
> -* Return:		None
> -* Note:		The initialization value is constant and it should never be changes
> -*/
> + * Function:	phy_InitBBRFRegisterDefinition
> + *
> + * OverView:	Initialize Register definition offset for Radio Path A/B/C/D
> + *
> + * Input:
> + *		struct adapter *	Adapter,
> + *
> + * Output:	None
> + * Return:		None
> + * Note:		The initialization value is constant and it should never be changes
> + */
>  static void phy_InitBBRFRegisterDefinition(struct adapter *Adapter)
>  {
>  	struct hal_com_data		*pHalData = GET_HAL_DATA(Adapter);
> -- 
> 2.30.0
> 
> _______________________________________________
> devel mailing list
> devel@linuxdriverproject.org
> http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file, Documentation/SubmittingPatches
  for how to do this correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
