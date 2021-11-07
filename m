Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A54447353
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 15:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbhKGOea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 09:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235499AbhKGOe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 09:34:26 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31653C061570
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 06:31:43 -0800 (PST)
Received: from dslb-178-004-202-058.178.004.pools.vodafone-ip.de ([178.4.202.58] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mjjCs-0001Pk-TB; Sun, 07 Nov 2021 15:31:39 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/4] staging: r8188eu: remove constant phy_IQCalibrate_8188E parameter
Date:   Sun,  7 Nov 2021 15:30:59 +0100
Message-Id: <20211107143100.9047-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211107143100.9047-1-martin@kaiser.cx>
References: <20211107143100.9047-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only caller of phy_IQCalibrate_8188E sets the is2t parameter
to false.

Remove the parameter and resulting dead code. This includes the
phy_PathB_IQK_8188E and _PHY_PathAStandBy functions.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  | 88 +------------------
 .../staging/r8188eu/include/HalPhyRf_8188e.h  |  2 -
 2 files changed, 4 insertions(+), 86 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index 7c192b272a77..6b49acab0be8 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -502,43 +502,6 @@ phy_PathA_RxIQK(struct adapter *adapt)
 	return result;
 }
 
-static u8 /* bit0 = 1 => Tx OK, bit1 = 1 => Rx OK */
-phy_PathB_IQK_8188E(struct adapter *adapt)
-{
-	u32 regeac, regeb4, regebc, regec4, regecc;
-	u8 result = 0x00;
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
-	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
-
-	/* One shot, path B LOK & IQK */
-	ODM_SetBBReg(dm_odm, rIQK_AGC_Cont, bMaskDWord, 0x00000002);
-	ODM_SetBBReg(dm_odm, rIQK_AGC_Cont, bMaskDWord, 0x00000000);
-
-	/*  delay x ms */
-	ODM_delay_ms(IQK_DELAY_TIME_88E);
-
-	/*  Check failed */
-	regeac = ODM_GetBBReg(dm_odm, rRx_Power_After_IQK_A_2, bMaskDWord);
-	regeb4 = ODM_GetBBReg(dm_odm, rTx_Power_Before_IQK_B, bMaskDWord);
-	regebc = ODM_GetBBReg(dm_odm, rTx_Power_After_IQK_B, bMaskDWord);
-	regec4 = ODM_GetBBReg(dm_odm, rRx_Power_Before_IQK_B_2, bMaskDWord);
-	regecc = ODM_GetBBReg(dm_odm, rRx_Power_After_IQK_B_2, bMaskDWord);
-
-	if (!(regeac & BIT(31)) &&
-	    (((regeb4 & 0x03FF0000) >> 16) != 0x142) &&
-	    (((regebc & 0x03FF0000) >> 16) != 0x42))
-		result |= 0x01;
-	else
-		return result;
-
-	if (!(regeac & BIT(30)) &&
-	    (((regec4 & 0x03FF0000) >> 16) != 0x132) &&
-	    (((regecc & 0x03FF0000) >> 16) != 0x36))
-		result |= 0x02;
-
-	return result;
-}
-
 static void patha_fill_iqk(struct adapter *adapt, bool iqkok, s32 result[][8], u8 final_candidate, bool txonly)
 {
 	u32 Oldval_0, X, TX0_A, reg;
@@ -675,19 +638,6 @@ _PHY_MACSettingCalibration(
 	rtw_write8(adapt, MACReg[i], (u8)(MACBackup[i] & (~BIT(5))));
 }
 
-void
-_PHY_PathAStandBy(
-	struct adapter *adapt
-	)
-{
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
-	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
-
-	ODM_SetBBReg(dm_odm, rFPGA0_IQK, bMaskDWord, 0x0);
-	ODM_SetBBReg(dm_odm, 0x840, bMaskDWord, 0x00010000);
-	ODM_SetBBReg(dm_odm, rFPGA0_IQK, bMaskDWord, 0x80800000);
-}
-
 static void _PHY_PIModeSwitch(
 		struct adapter *adapt,
 		bool PIMode
@@ -781,12 +731,12 @@ static bool phy_SimularityCompare_8188E(
 	}
 }
 
-static void phy_IQCalibrate_8188E(struct adapter *adapt, s32 result[][8], u8 t, bool is2t)
+static void phy_IQCalibrate_8188E(struct adapter *adapt, s32 result[][8], u8 t)
 {
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
 	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
 	u32 i;
-	u8 PathAOK, PathBOK;
+	u8 PathAOK;
 	u32 ADDA_REG[IQK_ADDA_REG_NUM] = {
 						rFPGA0_XCD_SwitchControl, rBlue_Tooth,
 						rRx_Wait_CCA, 	rTx_CCK_RFON,
@@ -818,7 +768,7 @@ static void phy_IQCalibrate_8188E(struct adapter *adapt, s32 result[][8], u8 t,
 		_PHY_SaveADDARegisters(adapt, IQK_BB_REG_92C, dm_odm->RFCalibrateInfo.IQK_BB_backup, IQK_BB_REG_NUM);
 	}
 
-	_PHY_PathADDAOn(adapt, ADDA_REG, true, is2t);
+	_PHY_PathADDAOn(adapt, ADDA_REG, true, false);
 	if (t == 0)
 		dm_odm->RFCalibrateInfo.bRfPiEnable = (u8)ODM_GetBBReg(dm_odm, rFPGA0_XA_HSSIParameter1, BIT(8));
 
@@ -838,11 +788,6 @@ static void phy_IQCalibrate_8188E(struct adapter *adapt, s32 result[][8], u8 t,
 	ODM_SetBBReg(dm_odm, rFPGA0_XA_RFInterfaceOE, BIT(10), 0x00);
 	ODM_SetBBReg(dm_odm, rFPGA0_XB_RFInterfaceOE, BIT(10), 0x00);
 
-	if (is2t) {
-		ODM_SetBBReg(dm_odm, rFPGA0_XA_LSSIParameter, bMaskDWord, 0x00010000);
-		ODM_SetBBReg(dm_odm, rFPGA0_XB_LSSIParameter, bMaskDWord, 0x00010000);
-	}
-
 	/* MAC settings */
 	_PHY_MACSettingCalibration(adapt, IQK_MAC_REG, dm_odm->RFCalibrateInfo.IQK_MAC_backup);
 
@@ -850,8 +795,6 @@ static void phy_IQCalibrate_8188E(struct adapter *adapt, s32 result[][8], u8 t,
 	/* AP or IQK */
 	ODM_SetBBReg(dm_odm, rConfig_AntA, bMaskDWord, 0x0f600000);
 
-	if (is2t)
-		ODM_SetBBReg(dm_odm, rConfig_AntB, bMaskDWord, 0x0f600000);
 
 	/*  IQ calibration setting */
 	ODM_SetBBReg(dm_odm, rFPGA0_IQK, bMaskDWord, 0x80800000);
@@ -876,27 +819,6 @@ static void phy_IQCalibrate_8188E(struct adapter *adapt, s32 result[][8], u8 t,
 		}
 	}
 
-	if (is2t) {
-		_PHY_PathAStandBy(adapt);
-
-		/*  Turn Path B ADDA on */
-		_PHY_PathADDAOn(adapt, ADDA_REG, false, is2t);
-
-		for (i = 0; i < retryCount; i++) {
-			PathBOK = phy_PathB_IQK_8188E(adapt);
-			if (PathBOK == 0x03) {
-				result[t][4] = (ODM_GetBBReg(dm_odm, rTx_Power_Before_IQK_B, bMaskDWord) & 0x3FF0000) >> 16;
-				result[t][5] = (ODM_GetBBReg(dm_odm, rTx_Power_After_IQK_B, bMaskDWord) & 0x3FF0000) >> 16;
-				result[t][6] = (ODM_GetBBReg(dm_odm, rRx_Power_Before_IQK_B_2, bMaskDWord) & 0x3FF0000) >> 16;
-				result[t][7] = (ODM_GetBBReg(dm_odm, rRx_Power_After_IQK_B_2, bMaskDWord) & 0x3FF0000) >> 16;
-				break;
-			} else if (i == (retryCount - 1) && PathBOK == 0x01) {	/* Tx IQK OK */
-				result[t][4] = (ODM_GetBBReg(dm_odm, rTx_Power_Before_IQK_B, bMaskDWord) & 0x3FF0000) >> 16;
-				result[t][5] = (ODM_GetBBReg(dm_odm, rTx_Power_After_IQK_B, bMaskDWord) & 0x3FF0000) >> 16;
-			}
-		}
-	}
-
 	/* Back to BB mode, load original value */
 	ODM_SetBBReg(dm_odm, rFPGA0_IQK, bMaskDWord, 0);
 
@@ -916,8 +838,6 @@ static void phy_IQCalibrate_8188E(struct adapter *adapt, s32 result[][8], u8 t,
 
 		/*  Restore RX initial gain */
 		ODM_SetBBReg(dm_odm, rFPGA0_XA_LSSIParameter, bMaskDWord, 0x00032ed3);
-		if (is2t)
-			ODM_SetBBReg(dm_odm, rFPGA0_XB_LSSIParameter, bMaskDWord, 0x00032ed3);
 
 		/* load 0xe30 IQC default value */
 		ODM_SetBBReg(dm_odm, rTx_IQK_Tone_A, bMaskDWord, 0x01008c00);
@@ -1027,7 +947,7 @@ void PHY_IQCalibrate_8188E(struct adapter *adapt, bool recovery)
 	is13simular = false;
 
 	for (i = 0; i < 3; i++) {
-		phy_IQCalibrate_8188E(adapt, result, i, false);
+		phy_IQCalibrate_8188E(adapt, result, i);
 
 		if (i == 1) {
 			is12simular = phy_SimularityCompare_8188E(adapt, result, 0, 1);
diff --git a/drivers/staging/r8188eu/include/HalPhyRf_8188e.h b/drivers/staging/r8188eu/include/HalPhyRf_8188e.h
index d4a27662309f..60909ea2874e 100644
--- a/drivers/staging/r8188eu/include/HalPhyRf_8188e.h
+++ b/drivers/staging/r8188eu/include/HalPhyRf_8188e.h
@@ -36,6 +36,4 @@ void _PHY_PathADDAOn(struct adapter *pAdapter, u32 *ADDAReg,
 void _PHY_MACSettingCalibration(struct adapter *pAdapter, u32 *MACReg,
 				u32 *MACBackup);
 
-void _PHY_PathAStandBy(struct adapter *pAdapter);
-
 #endif	/*  #ifndef __HAL_PHY_RF_8188E_H__ */
-- 
2.20.1

