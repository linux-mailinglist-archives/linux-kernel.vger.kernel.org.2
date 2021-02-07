Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC3D3124A5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 15:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhBGORp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 09:17:45 -0500
Received: from mail-pj1-f44.google.com ([209.85.216.44]:35420 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhBGORh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 09:17:37 -0500
Received: by mail-pj1-f44.google.com with SMTP id e9so7300437pjj.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 06:17:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=EoSYCloPwFhlL2ow7ezZY9SrJk2D6AsXpeTP42d3z/U=;
        b=KAd6Xh7oA5XYMwOf7EjUnmGi17tKIfAUJsXzpdFVwRP10MYJYeekB165j7jCdwtaUg
         0Qyn7rFIGN8TXaR8B013fxQF7TekE9YrWcNtdcSVnRMAQ8ucDvO0dJ74T7wr5peKb8vO
         3bi5viJctcCUsJ0eB6yC9Hp0iSl5AGvp0TNtyLH9YH7UcSYtKF2t6GNy9+/PMEuFxucE
         XB6UqvtEb6tkayFQtWNZUN+Ljhgtiv7ldqDboyUrpCv9rzrI5XUOrTCEgw3WgNRs/aE/
         x9SaE+kXXAjNdWPcqYLtig4sYxI8VZRnBXgWjS6rd4vusn80uqrcK5rp8+1sE/VUbQVp
         OTjA==
X-Gm-Message-State: AOAM530q7EIyfoud6Ud/HTkumq7j9SBwWtE4A0w4Ebo64piZG0qw2teZ
        cgGK8/bE1Km6ohdReTVar4hDT3lDibwuQQ==
X-Google-Smtp-Source: ABdhPJzDkwNR7BF8Xtg6atmOrNIl2XDAQrR47WXaMTdMo+GASPGNsHiIykl+ft5euzfd65wVNRcIWQ==
X-Received: by 2002:a17:902:9b90:b029:e0:6c0:df4f with SMTP id y16-20020a1709029b90b02900e006c0df4fmr12542822plp.60.1612707416250;
        Sun, 07 Feb 2021 06:16:56 -0800 (PST)
Received: from karthik-strix-linux.karthek.com ([192.140.154.2])
        by smtp.gmail.com with ESMTPSA id y7sm353783pfl.127.2021.02.07.06.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 06:16:54 -0800 (PST)
Date:   Sun, 7 Feb 2021 19:46:50 +0530
From:   karthek <mail@karthek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: fix block comments alignment
Message-ID: <YB/2Uvj99+sReckM@karthik-strix-linux.karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix checkpatch.pl warning for "block comments should align the * on each line"

Signed-off-by: karthek <mail@karthek.com>
---
eudyptula challenge thing

 .../staging/rtl8723bs/hal/rtl8723b_phycfg.c   | 204 +++++++++---------
 1 file changed, 102 insertions(+), 102 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
index cf23414d7..003f954c2 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
@@ -20,16 +20,16 @@
 #define MAX_DOZE_WAITING_TIMES_9x 64
 
 /**
-* Function:	phy_CalculateBitShift
-*
-* OverView:	Get shifted position of the BitMask
-*
-* Input:
-*		u32 	BitMask,
-*
-* Output:	none
-* Return:		u32 	Return the shift bit bit position of the mask
-*/
+ * Function:	phy_CalculateBitShift
+ *
+ * OverView:	Get shifted position of the BitMask
+ *
+ * Input:
+ *		u32 	BitMask,
+ *
+ * Output:	none
+ * Return:		u32 	Return the shift bit bit position of the mask
+ */
 static	u32 phy_CalculateBitShift(u32 BitMask)
 {
 	u32 i;
@@ -43,19 +43,19 @@ static	u32 phy_CalculateBitShift(u32 BitMask)
 
 
 /**
-* Function:	PHY_QueryBBReg
-*
-* OverView:	Read "specific bits" from BB register
-*
-* Input:
-*		struct adapter *	Adapter,
-*		u32 		RegAddr,	The target address to be readback
-*		u32 		BitMask		The target bit position in the target address
-*							to be readback
-* Output:	None
-* Return:		u32 		Data		The readback register value
-* Note:		This function is equal to "GetRegSetting" in PHY programming guide
-*/
+ * Function:	PHY_QueryBBReg
+ *
+ * OverView:	Read "specific bits" from BB register
+ *
+ * Input:
+ *		struct adapter *	Adapter,
+ *		u32 		RegAddr,	The target address to be readback
+ *		u32 		BitMask		The target bit position in the target address
+ *							to be readback
+ * Output:	None
+ * Return:		u32 		Data		The readback register value
+ * Note:		This function is equal to "GetRegSetting" in PHY programming guide
+ */
 u32 PHY_QueryBBReg_8723B(struct adapter *Adapter, u32 RegAddr, u32 BitMask)
 {
 	u32 OriginalValue, BitShift;
@@ -75,22 +75,22 @@ u32 PHY_QueryBBReg_8723B(struct adapter *Adapter, u32 RegAddr, u32 BitMask)
 
 
 /**
-* Function:	PHY_SetBBReg
-*
-* OverView:	Write "Specific bits" to BB register (page 8~)
-*
-* Input:
-*		struct adapter *	Adapter,
-*		u32 		RegAddr,	The target address to be modified
-*		u32 		BitMask		The target bit position in the target address
-*								to be modified
-*		u32 		Data		The new register value in the target bit position
-*								of the target address
-*
-* Output:	None
-* Return:		None
-* Note:		This function is equal to "PutRegSetting" in PHY programming guide
-*/
+ * Function:	PHY_SetBBReg
+ *
+ * OverView:	Write "Specific bits" to BB register (page 8~)
+ *
+ * Input:
+ *		struct adapter *	Adapter,
+ *		u32 		RegAddr,	The target address to be modified
+ *		u32 		BitMask		The target bit position in the target address
+ *								to be modified
+ *		u32 		Data		The new register value in the target bit position
+ *								of the target address
+ *
+ * Output:	None
+ * Return:		None
+ * Note:		This function is equal to "PutRegSetting" in PHY programming guide
+ */
 
 void PHY_SetBBReg_8723B(
 	struct adapter *Adapter,
@@ -184,25 +184,25 @@ static u32 phy_RFSerialRead_8723B(
 }
 
 /**
-* Function:	phy_RFSerialWrite_8723B
-*
-* OverView:	Write data to RF register (page 8~)
-*
-* Input:
-*		struct adapter *	Adapter,
-*		RF_PATH			eRFPath,	Radio path of A/B/C/D
-*		u32 		Offset,		The target address to be read
-*		u32 		Data		The new register Data in the target bit position
-*								of the target to be read
-*
-* Output:	None
-* Return:		None
-* Note:		Threre are three types of serial operations:
-*		1. Software serial write
-*		2. Hardware LSSI-Low Speed Serial Interface
-*		3. Hardware HSSI-High speed
-*		serial write. Driver need to implement (1) and (2).
-*		This function is equal to the combination of RF_ReadReg() and  RFLSSIRead()
+ * Function:	phy_RFSerialWrite_8723B
+ *
+ * OverView:	Write data to RF register (page 8~)
+ *
+ * Input:
+ *		struct adapter *	Adapter,
+ *		RF_PATH			eRFPath,	Radio path of A/B/C/D
+ *		u32 		Offset,		The target address to be read
+ *		u32 		Data		The new register Data in the target bit position
+ *								of the target to be read
+ *
+ * Output:	None
+ * Return:		None
+ * Note:		Threre are three types of serial operations:
+ *		1. Software serial write
+ *		2. Hardware LSSI-Low Speed Serial Interface
+ *		3. Hardware HSSI-High speed
+ *		serial write. Driver need to implement (1) and (2).
+ *		This function is equal to the combination of RF_ReadReg() and  RFLSSIRead()
  *
  * Note:		  For RF8256 only
  *		 The total count of RTL8256(Zebra4) register is around 36 bit it only employs
@@ -225,7 +225,7 @@ static u32 phy_RFSerialRead_8723B(
  *
  *
  *
-*/
+ */
 static void phy_RFSerialWrite_8723B(
 	struct adapter *Adapter,
 	enum RF_PATH eRFPath,
@@ -261,21 +261,21 @@ static void phy_RFSerialWrite_8723B(
 
 
 /**
-* Function:	PHY_QueryRFReg
-*
-* OverView:	Query "Specific bits" to RF register (page 8~)
-*
-* Input:
-*		struct adapter *	Adapter,
-*		RF_PATH			eRFPath,	Radio path of A/B/C/D
-*		u32 		RegAddr,	The target address to be read
-*		u32 		BitMask		The target bit position in the target address
-*								to be read
-*
-* Output:	None
-* Return:		u32 		Readback value
-* Note:		This function is equal to "GetRFRegSetting" in PHY programming guide
-*/
+ * Function:	PHY_QueryRFReg
+ *
+ * OverView:	Query "Specific bits" to RF register (page 8~)
+ *
+ * Input:
+ *		struct adapter *	Adapter,
+ *		RF_PATH			eRFPath,	Radio path of A/B/C/D
+ *		u32 		RegAddr,	The target address to be read
+ *		u32 		BitMask		The target bit position in the target address
+ *								to be read
+ *
+ * Output:	None
+ * Return:		u32 		Readback value
+ * Note:		This function is equal to "GetRFRegSetting" in PHY programming guide
+ */
 u32 PHY_QueryRFReg_8723B(
 	struct adapter *Adapter,
 	u8 eRFPath,
@@ -296,23 +296,23 @@ u32 PHY_QueryRFReg_8723B(
 }
 
 /**
-* Function:	PHY_SetRFReg
-*
-* OverView:	Write "Specific bits" to RF register (page 8~)
-*
-* Input:
-*		struct adapter *	Adapter,
-*		RF_PATH			eRFPath,	Radio path of A/B/C/D
-*		u32 		RegAddr,	The target address to be modified
-*		u32 		BitMask		The target bit position in the target address
-*								to be modified
-*		u32 		Data		The new register Data in the target bit position
-*								of the target address
-*
-* Output:	None
-* Return:		None
-* Note:		This function is equal to "PutRFRegSetting" in PHY programming guide
-*/
+ * Function:	PHY_SetRFReg
+ *
+ * OverView:	Write "Specific bits" to RF register (page 8~)
+ *
+ * Input:
+ *		struct adapter *	Adapter,
+ *		RF_PATH			eRFPath,	Radio path of A/B/C/D
+ *		u32 		RegAddr,	The target address to be modified
+ *		u32 		BitMask		The target bit position in the target address
+ *								to be modified
+ *		u32 		Data		The new register Data in the target bit position
+ *								of the target address
+ *
+ * Output:	None
+ * Return:		None
+ * Note:		This function is equal to "PutRFRegSetting" in PHY programming guide
+ */
 void PHY_SetRFReg_8723B(
 	struct adapter *Adapter,
 	u8 eRFPath,
@@ -369,17 +369,17 @@ s32 PHY_MACConfig8723B(struct adapter *Adapter)
 }
 
 /**
-* Function:	phy_InitBBRFRegisterDefinition
-*
-* OverView:	Initialize Register definition offset for Radio Path A/B/C/D
-*
-* Input:
-*		struct adapter *	Adapter,
-*
-* Output:	None
-* Return:		None
-* Note:		The initialization value is constant and it should never be changes
-*/
+ * Function:	phy_InitBBRFRegisterDefinition
+ *
+ * OverView:	Initialize Register definition offset for Radio Path A/B/C/D
+ *
+ * Input:
+ *		struct adapter *	Adapter,
+ *
+ * Output:	None
+ * Return:		None
+ * Note:		The initialization value is constant and it should never be changes
+ */
 static void phy_InitBBRFRegisterDefinition(struct adapter *Adapter)
 {
 	struct hal_com_data		*pHalData = GET_HAL_DATA(Adapter);
-- 
2.30.0

