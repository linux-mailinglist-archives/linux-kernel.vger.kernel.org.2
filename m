Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4ED6315B8D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 01:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbhBJAqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 19:46:13 -0500
Received: from mail-pl1-f172.google.com ([209.85.214.172]:42470 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234359AbhBIVNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 16:13:44 -0500
Received: by mail-pl1-f172.google.com with SMTP id s15so10488201plr.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 13:13:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=O7aXSJE1CFIK5AyVwPhOlcXCMOP+mflwjTwdr5k//Cw=;
        b=s8j560AA4fKrxvgZpmMGrSsjdNhHmulUSCLLG/H9oAlJ0JJDPfEhCxQq4lEKoBolQE
         YLm/6Bbro189jR2cXq7GJwPeehky8QlnCasuBY9KcV7xGxcZpjOA5qJu+HzymR/8vYCb
         Jkv80rHYmtS3UIQ9GlJKvlwAH+yKBmbT+RAUD3NNcsKIx6I5gP3iqHgAlGiJzVvZfMVM
         05spHc0Iz4SrXGfguNVZcv2U+71NCoIRm20tCGZ7wD14v6+QM50Tc+xdweqf534Y58Ay
         X58R6+aoFABQFVPx4Ykp7/AxSUfwXRGSF5WY8m8WCIz7StGRqz6yjhymNS0TIfJ+V8m1
         DEmA==
X-Gm-Message-State: AOAM533qIla35GN+oINI/mZ3/4xpHWB5OupmuWrPWbP8NZx6Sz1QCsWD
        WQ3PxvVvAwyzd3z3alZg2uE=
X-Google-Smtp-Source: ABdhPJwZBrrVPPK/heMZOfIlJyg/vEXcNT5aN+4jV2vdZ73ld7NYl4tnl8Jod/3LK6CeFqvgFuCM2A==
X-Received: by 2002:a17:90a:d3cc:: with SMTP id d12mr6007104pjw.202.1612905155219;
        Tue, 09 Feb 2021 13:12:35 -0800 (PST)
Received: from karthik-strix-linux.karthek.com ([192.140.154.47])
        by smtp.gmail.com with ESMTPSA id 73sm5816442pfa.27.2021.02.09.13.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 13:12:34 -0800 (PST)
Date:   Wed, 10 Feb 2021 02:42:30 +0530
From:   karthik alapati <mail@karthek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: fix function comments to follow
 kernel-doc
Message-ID: <YCL6vrGPQ0uDZUI8@karthik-strix-linux.karthek.com>
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
 .../staging/rtl8723bs/hal/rtl8723b_phycfg.c   | 209 ++++++++----------
 1 file changed, 91 insertions(+), 118 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
index cf23414d7..b7fca881c 100644
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
@@ -64,7 +57,10 @@ u32 PHY_QueryBBReg_8723B(struct adapter *Adapter, u32 RegAddr, u32 BitMask)
 	return 0;
 #endif
 
-	/* RT_TRACE(COMP_RF, DBG_TRACE, ("--->PHY_QueryBBReg(): RegAddr(%#lx), BitMask(%#lx)\n", RegAddr, BitMask)); */
+	/**
+	 * RT_TRACE(COMP_RF, DBG_TRACE, ("--->PHY_QueryBBReg():
+	 * RegAddr(%#lx), BitMask(%#lx)\n", RegAddr, BitMask));
+	 */
 
 	OriginalValue = rtw_read32(Adapter, RegAddr);
 	BitShift = phy_CalculateBitShift(BitMask);
@@ -75,22 +71,17 @@ u32 PHY_QueryBBReg_8723B(struct adapter *Adapter, u32 RegAddr, u32 BitMask)
 
 
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
@@ -106,7 +97,10 @@ void PHY_SetBBReg_8723B(
 	return;
 #endif
 
-	/* RT_TRACE(COMP_RF, DBG_TRACE, ("--->PHY_SetBBReg(): RegAddr(%#lx), BitMask(%#lx), Data(%#lx)\n", RegAddr, BitMask, Data)); */
+	/**
+	 * RT_TRACE(COMP_RF, DBG_TRACE, ("--->PHY_SetBBReg():
+	 * RegAddr(%#lx), BitMask(%#lx), Data(%#lx)\n", RegAddr, BitMask, Data));
+	 */
 
 	if (BitMask != bMaskDWord) { /* if not "double word" write */
 		OriginalValue = rtw_read32(Adapter, RegAddr);
@@ -184,27 +178,21 @@ static u32 phy_RFSerialRead_8723B(
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
+ * .. Note::		Threre are three types of serial operations:
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
@@ -225,7 +213,7 @@ static u32 phy_RFSerialRead_8723B(
  *
  *
  *
-*/
+ */
 static void phy_RFSerialWrite_8723B(
 	struct adapter *Adapter,
 	enum RF_PATH eRFPath,
@@ -249,33 +237,33 @@ static void phy_RFSerialWrite_8723B(
 	/*  Put write addr in [5:0]  and write data in [31:16] */
 	/*  */
 	/* DataAndAddr = (Data<<16) | (NewOffset&0x3f); */
-	DataAndAddr = ((NewOffset<<20) | (Data&0x000fffff)) & 0x0fffffff;	/*  T65 RF */
+	DataAndAddr = ((NewOffset<<20) | (Data&0x000fffff)) & 0x0fffffff;
+	/*T65 RF */
 
 	/*  */
 	/*  Write Operation */
 	/*  */
 	PHY_SetBBReg(Adapter, pPhyReg->rf3wireOffset, bMaskDWord, DataAndAddr);
-	/* RTPRINT(FPHY, PHY_RFW, ("RFW-%d Addr[0x%lx]= 0x%lx\n", eRFPath, pPhyReg->rf3wireOffset, DataAndAddr)); */
+	/**
+	  *RTPRINT(FPHY, PHY_RFW, ("RFW-%d Addr[0x%lx]= 0x%lx\n", eRFPath,
+	  *pPhyReg->rf3wireOffset, DataAndAddr));
+	  */
 
 }
 
 
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
+ * .. Note::		This function is equal to "GetRFRegSetting" in PHY programming guide
+ */
 u32 PHY_QueryRFReg_8723B(
 	struct adapter *Adapter,
 	u8 eRFPath,
@@ -296,23 +284,17 @@ u32 PHY_QueryRFReg_8723B(
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
+ *	.. Note::		This function is equal to "PutRFRegSetting" in PHY programming guide
+ */
 void PHY_SetRFReg_8723B(
 	struct adapter *Adapter,
 	u8 eRFPath,
@@ -344,15 +326,7 @@ void PHY_SetRFReg_8723B(
 
 
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
@@ -369,17 +343,12 @@ s32 PHY_MACConfig8723B(struct adapter *Adapter)
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
@@ -675,6 +644,7 @@ static void phy_SetRegBW_8723B(
 )
 {
 	u16 RegRfMod_BW, u2tmp = 0;
+
 	RegRfMod_BW = rtw_read16(Adapter, REG_TRXPTCL_CTL_8723B);
 
 	switch (CurrentBW) {
@@ -789,7 +759,7 @@ static void phy_PostSetBwMode8723B(struct adapter *Adapter)
 
 		PHY_SetBBReg(Adapter, rFPGA1_RFMOD, bRFMOD, 0x0);
 
-/* 			PHY_SetBBReg(Adapter, rFPGA0_AnalogParameter2, BIT10, 1); */
+	/*PHY_SetBBReg(Adapter, rFPGA0_AnalogParameter2, BIT10, 1); */
 
 		PHY_SetBBReg(Adapter, rOFDM0_TxPseudoNoiseWgt, (BIT31|BIT30), 0x0);
 		break;
@@ -800,7 +770,10 @@ static void phy_PostSetBwMode8723B(struct adapter *Adapter)
 
 		PHY_SetBBReg(Adapter, rFPGA1_RFMOD, bRFMOD, 0x1);
 
-		/*  Set Control channel to upper or lower. These settings are required only for 40MHz */
+		/**
+		 * Set Control channel to upper or lower. These settings are required
+		 * only for 40MHz
+		 */
 		PHY_SetBBReg(Adapter, rCCK0_System, bCCKSideBand, (pHalData->nCur40MhzPrimeSC>>1));
 
 		PHY_SetBBReg(Adapter, rOFDM1_LSTF, 0xC00, pHalData->nCur40MhzPrimeSC);
-- 
2.30.0

