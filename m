Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926C6316FBA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 20:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbhBJTLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 14:11:12 -0500
Received: from mail-pf1-f175.google.com ([209.85.210.175]:36350 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbhBJTLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 14:11:02 -0500
Received: by mail-pf1-f175.google.com with SMTP id 18so1904152pfz.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 11:10:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=6uhamtRDVQ5W7PuL+OxgzVNnY2TIw/W8O7lDC5/cd6Y=;
        b=eyoymrYzxyD5aS1b9l6hFww7zptZDhv2yxawkxgZUN0urx78D7H22oZKdSYPW6/Pm7
         hijXGE7RPdjUYTDzRNiBcEjd89bUIhqvFopVq+uLLEkWNcEngk9NN3Q7hbIkpwiyZKch
         VYiylHV8lQ0uwWmKZsFIpxVw56wsGKMYEKEU4Dn7yhrOJ8fHlaStbIigq0NvmSvpp+nQ
         vpkVbXrXnlbv8E8MtrcqmW6M7yZ1BLc+56EBH9pSGJ7uFgwRLCo1Y5/GwSt6sTNjqDHz
         ioYadJJ3iYErIaDbfHAiMGTqB+vRGqkXjQXLd2llj1FGsddr6tQr/g81qYKBqLwcj9KK
         8mRw==
X-Gm-Message-State: AOAM5300lhE9B/0Ap4JzNH8QMocD40y5zAxdnIjfOPrKkyQGOIe/Yu5h
        +GjrG3DpMshJiaNwrqnELBQ=
X-Google-Smtp-Source: ABdhPJy23PXtEfK2WIswIgCWg1HLrUZnehshOr1ru8LGxo6fJg0NJ/9/O/bI5O1T7S2fiu2U61FwYA==
X-Received: by 2002:a62:5a07:0:b029:1cf:f54d:6e59 with SMTP id o7-20020a625a070000b02901cff54d6e59mr4556005pfb.49.1612984220926;
        Wed, 10 Feb 2021 11:10:20 -0800 (PST)
Received: from karthik-strix-linux.karthek.com ([192.140.155.38])
        by smtp.gmail.com with ESMTPSA id h15sm3105444pfo.193.2021.02.10.11.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 11:10:20 -0800 (PST)
Date:   Thu, 11 Feb 2021 00:40:15 +0530
From:   karthik alapati <mail@karthek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: fix function comments to follow
 kernel-doc
Message-ID: <YCQvl3+KviQNh2JI@karthik-strix-linux.karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix checkpatch.pl warning for "block comments should align the
 * on each line" and make function comments follow kernel-doc

Signed-off-by: karthik alapati <mail@karthek.com>
---
 .../staging/rtl8723bs/hal/rtl8723b_phycfg.c   | 185 +++++++-----------
 1 file changed, 73 insertions(+), 112 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
index cf23414d7..1fd504181 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
@@ -20,16 +20,11 @@
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
+ *	phy_CalculateBitShift - Get shifted position of the BitMask.
+ *	@BitMask: Bitmask.
+ *
+ *	Return:	Return the shift bit position of the mask
+ */
 static	u32 phy_CalculateBitShift(u32 BitMask)
 {
 	u32 i;
@@ -43,19 +38,17 @@ static	u32 phy_CalculateBitShift(u32 BitMask)
 
 
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
+ *	PHY_QueryBBReg - Read "specific bits" from BB register.
+ *	@Adapter:
+ *	@RegAddr:	The target address to be readback
+ *	@BitMask:	The target bit position in the target address
+ *				to be readback
+ *
+ * Return:	The readback register value
+ *
+ * .. Note::	This function is equal to "GetRegSetting" in PHY programming
+ *			guide
+ */
 u32 PHY_QueryBBReg_8723B(struct adapter *Adapter, u32 RegAddr, u32 BitMask)
 {
 	u32 OriginalValue, BitShift;
@@ -75,22 +68,17 @@ u32 PHY_QueryBBReg_8723B(struct adapter *Adapter, u32 RegAddr, u32 BitMask)
 
 
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
+ *	PHY_SetBBReg - Write "Specific bits" to BB register (page 8~).
+ *	@Adapter:
+ *	@RegAddr:	The target address to be modified
+ *	@BitMask:	The target bit position in the target address
+ *				to be modified
+ *	@Data:		The new register value in the target bit position
+ *				of the target address
+ *
+ * .. Note::	This function is equal to "PutRegSetting" in PHY programming
+ *			guide
+ */
 
 void PHY_SetBBReg_8723B(
 	struct adapter *Adapter,
@@ -184,27 +172,21 @@ static u32 phy_RFSerialRead_8723B(
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
+ *	phy_RFSerialWrite_8723B - Write data to RF register (page 8~).
+ *	@Adapter:
+ *	@eRFPath:	Radio path of A/B/C/D
+ *	@Offset:	The target address to be read
+ *	@Data:	The new register Data in the target bit position
+ *			of the target to be read
+ *
+ * .. Note::	Threre are three types of serial operations:
+ *		1. Software serial write
+ *		2. Hardware LSSI-Low Speed Serial Interface
+ *		3. Hardware HSSI-High speed
+ *		serial write. Driver need to implement (1) and (2).
+ *		This function is equal to the combination of RF_ReadReg() and  RFLSSIRead()
  *
- * Note:		  For RF8256 only
+ * .. Note::		  For RF8256 only
  *		 The total count of RTL8256(Zebra4) register is around 36 bit it only employs
  *		 4-bit RF address. RTL8256 uses "register mode control bit" (Reg00[12], Reg00[10])
  *		 to access register address bigger than 0xf. See "Appendix-4 in PHY Configuration
@@ -225,7 +207,7 @@ static u32 phy_RFSerialRead_8723B(
  *
  *
  *
-*/
+ */
 static void phy_RFSerialWrite_8723B(
 	struct adapter *Adapter,
 	enum RF_PATH eRFPath,
@@ -261,21 +243,18 @@ static void phy_RFSerialWrite_8723B(
 
 
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
+ *	PHY_QueryRFReg - Query "Specific bits" to RF register (page 8~).
+ *	@Adapter:
+ *	@eRFPath:	Radio path of A/B/C/D
+ *	@RegAdd:	The target address to be read
+ *	@BitMask:	The target bit position in the target address
+ *				to be read
+ *
+ *	Return:	Readback value
+ *
+ * .. Note::	This function is equal to "GetRFRegSetting" in PHY
+ *			programming guide
+ */
 u32 PHY_QueryRFReg_8723B(
 	struct adapter *Adapter,
 	u8 eRFPath,
@@ -296,23 +275,18 @@ u32 PHY_QueryRFReg_8723B(
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
+ *	PHY_SetRFReg - Write "Specific bits" to RF register (page 8~).
+ *	@Adapter:
+ *	@eRFPath:	Radio path of A/B/C/D
+ *	@RegAddr:	The target address to be modified
+ *	@BitMask:	The target bit position in the target address
+ *				to be modified
+ *	@Data:	The new register Data in the target bit position
+ *								of the target address
+ *
+ *	.. Note::	This function is equal to "PutRFRegSetting" in PHY
+ *			programming guide.
+ */
 void PHY_SetRFReg_8723B(
 	struct adapter *Adapter,
 	u8 eRFPath,
@@ -344,15 +318,7 @@ void PHY_SetRFReg_8723B(
 
 
 /*-----------------------------------------------------------------------------
- * Function:    PHY_MACConfig8192C
- *
- * Overview:	Condig MAC by header file or parameter file.
- *
- * Input:       NONE
- *
- * Output:      NONE
- *
- * Return:      NONE
+ *	PHY_MACConfig8192C - Condig MAC by header file or parameter file.
  *
  * Revised History:
  *  When		Who		Remark
@@ -369,17 +335,12 @@ s32 PHY_MACConfig8723B(struct adapter *Adapter)
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
+ *	phy_InitBBRFRegisterDefinition - Initialize Register definition offset for
+ *									Radio Path A/B/C/D
+ *	@Adapter:
+ *
+ *	.. Note::		The initialization value is constant and it should never be changes
+ */
 static void phy_InitBBRFRegisterDefinition(struct adapter *Adapter)
 {
 	struct hal_com_data		*pHalData = GET_HAL_DATA(Adapter);
-- 
2.30.0

