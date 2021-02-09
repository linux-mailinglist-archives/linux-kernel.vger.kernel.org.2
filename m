Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A613B315858
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 22:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbhBIVJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 16:09:19 -0500
Received: from mail-pj1-f53.google.com ([209.85.216.53]:40196 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbhBISyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 13:54:31 -0500
Received: by mail-pj1-f53.google.com with SMTP id z9so2202021pjl.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 10:53:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=3x8SHWviOX06noXl3VoCAEVkKd/3xhRiiOCeeg42KP0=;
        b=Dn7GyQnVYajP6+xC4ERnX1PCYc7UYdEMvUqGxIUE7x2Q7Pc6vSTnfr0iFgH9y7IS6e
         YpTIMeYSL3zbFtNTRcTVPB5oo+M/ElqWN4sUgRHrt3ysFkS0/FGKx99xHrOkLV1ofakE
         /VvAIhp7PFqJSweBfxyTcTS1ObXdTr7aZ5lKo/hzYzdH2crmKzNT3Y09ZGibZLuudGWp
         UrUuCKplMBjnlwVBeSpTZlZWs8UH+DrZEljBnRDtwg8tgwivOdIXKi5O2Wi2JTsqtW24
         sTehAoBzcFNEu6neQcEQauaOI5FxJdOAb1B5FyBt7bFnst73e8C20RLQVqirPiUY0aH/
         2wOA==
X-Gm-Message-State: AOAM533UDnJfdVAfAzSKk820ddy6ic+drmPsfTX+KJAWtv1ZCknJWgja
        2xNlO6wxto5JDtG+9w/teiE=
X-Google-Smtp-Source: ABdhPJwZVdfjNVUGRwkBl370CX/LHOszp4Jlj5KSRT0z7W0XHTPZ0DpFanbL2vGMkHnENEY0dX6P4w==
X-Received: by 2002:a17:90b:1804:: with SMTP id lw4mr5499762pjb.141.1612896802116;
        Tue, 09 Feb 2021 10:53:22 -0800 (PST)
Received: from karthik-strix-linux.karthek.com ([192.140.154.47])
        by smtp.gmail.com with ESMTPSA id 18sm3643628pfy.46.2021.02.09.10.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 10:53:21 -0800 (PST)
Date:   Wed, 10 Feb 2021 00:23:17 +0530
From:   karthik alapati <mail@karthek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: fix block comments alignment
Message-ID: <YCLaHXD/sUKM5HZE@karthik-strix-linux.karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix checkpatch.pl warning for "block comments should align the * on each line"

Signed-off-by: karthik alapati <mail@karthek.com>
---
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

