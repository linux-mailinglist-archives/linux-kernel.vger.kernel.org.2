Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7276E3D4E7F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 18:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbhGYPT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 11:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbhGYPTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 11:19:08 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04A4C061757;
        Sun, 25 Jul 2021 08:59:38 -0700 (PDT)
Received: from dslb-188-096-139-014.188.096.pools.vodafone-ip.de ([188.96.139.14] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1m7gXQ-0000SM-IU; Sun, 25 Jul 2021 17:59:36 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 15/18] staging: rtl8188eu: simplify phy_iq_calibrate
Date:   Sun, 25 Jul 2021 17:58:59 +0200
Message-Id: <20210725155902.32433-15-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210725155902.32433-1-martin@kaiser.cx>
References: <20210725155902.32433-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

phy_iq_calibrate's is2t parameter is always false.
Remove some code that would be called only for is2t == true.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/hal/phy.c | 91 ++---------------------------
 1 file changed, 6 insertions(+), 85 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/phy.c b/drivers/staging/rtl8188eu/hal/phy.c
index 3866d5ebe960..62f979ceadc6 100644
--- a/drivers/staging/rtl8188eu/hal/phy.c
+++ b/drivers/staging/rtl8188eu/hal/phy.c
@@ -625,38 +625,6 @@ static u8 phy_path_a_rx_iqk(struct adapter *adapt, bool configPathB)
 	return result;
 }
 
-static u8 phy_path_b_iqk(struct adapter *adapt)
-{
-	u32 regeac, regeb4, regebc, regec4, regecc;
-	u8 result = 0x00;
-
-	/* One shot, path B LOK & IQK */
-	phy_set_bb_reg(adapt, rIQK_AGC_Cont, bMaskDWord, 0x00000002);
-	phy_set_bb_reg(adapt, rIQK_AGC_Cont, bMaskDWord, 0x00000000);
-
-	mdelay(IQK_DELAY_TIME_88E);
-
-	regeac = phy_query_bb_reg(adapt, rRx_Power_After_IQK_A_2, bMaskDWord);
-	regeb4 = phy_query_bb_reg(adapt, rTx_Power_Before_IQK_B, bMaskDWord);
-	regebc = phy_query_bb_reg(adapt, rTx_Power_After_IQK_B, bMaskDWord);
-	regec4 = phy_query_bb_reg(adapt, rRx_Power_Before_IQK_B_2, bMaskDWord);
-	regecc = phy_query_bb_reg(adapt, rRx_Power_After_IQK_B_2, bMaskDWord);
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
 static void patha_fill_iqk(struct adapter *adapt, bool iqkok, s32 result[][8],
 			   u8 final_candidate, bool txonly)
 {
@@ -774,13 +742,6 @@ static void mac_setting_calibration(struct adapter *adapt, const u32 *mac_reg,
 	usb_write8(adapt, mac_reg[i], (u8)(backup[i] & (~BIT(5))));
 }
 
-static void path_a_standby(struct adapter *adapt)
-{
-	phy_set_bb_reg(adapt, rFPGA0_IQK, bMaskDWord, 0x0);
-	phy_set_bb_reg(adapt, 0x840, bMaskDWord, 0x00010000);
-	phy_set_bb_reg(adapt, rFPGA0_IQK, bMaskDWord, 0x80800000);
-}
-
 static void pi_mode_switch(struct adapter *adapt, bool pi_mode)
 {
 	u32 mode;
@@ -865,11 +826,11 @@ static bool simularity_compare(struct adapter *adapt, s32 resulta[][8],
 }
 
 static void phy_iq_calibrate(struct adapter *adapt, s32 result[][8],
-			     u8 t, bool is2t)
+			     u8 t)
 {
 	struct odm_dm_struct *dm_odm = &adapt->HalData->odmpriv;
 	u32 i;
-	u8 path_a_ok, path_b_ok;
+	u8 path_a_ok;
 	static const u32 adda_reg[IQK_ADDA_REG_NUM] = {
 		rFPGA0_XCD_SwitchControl, rBlue_Tooth,
 		rRx_Wait_CCA, rTx_CCK_RFON,
@@ -909,7 +870,7 @@ static void phy_iq_calibrate(struct adapter *adapt, s32 result[][8],
 				    dm_odm->RFCalibrateInfo.IQK_BB_backup, IQK_BB_REG_NUM);
 	}
 
-	path_adda_on(adapt, adda_reg, true, is2t);
+	path_adda_on(adapt, adda_reg, true, false);
 	if (t == 0)
 		dm_odm->RFCalibrateInfo.bRfPiEnable = (u8)phy_query_bb_reg(adapt, rFPGA0_XA_HSSIParameter1,
 									   BIT(8));
@@ -930,13 +891,6 @@ static void phy_iq_calibrate(struct adapter *adapt, s32 result[][8],
 	phy_set_bb_reg(adapt, rFPGA0_XA_RFInterfaceOE, BIT(10), 0x00);
 	phy_set_bb_reg(adapt, rFPGA0_XB_RFInterfaceOE, BIT(10), 0x00);
 
-	if (is2t) {
-		phy_set_bb_reg(adapt, rFPGA0_XA_LSSIParameter, bMaskDWord,
-			       0x00010000);
-		phy_set_bb_reg(adapt, rFPGA0_XB_LSSIParameter, bMaskDWord,
-			       0x00010000);
-	}
-
 	/* MAC settings */
 	mac_setting_calibration(adapt, iqk_mac_reg,
 				dm_odm->RFCalibrateInfo.IQK_MAC_backup);
@@ -945,16 +899,13 @@ static void phy_iq_calibrate(struct adapter *adapt, s32 result[][8],
 	/* AP or IQK */
 	phy_set_bb_reg(adapt, rConfig_AntA, bMaskDWord, 0x0f600000);
 
-	if (is2t)
-		phy_set_bb_reg(adapt, rConfig_AntB, bMaskDWord, 0x0f600000);
-
 	/*  IQ calibration setting */
 	phy_set_bb_reg(adapt, rFPGA0_IQK, bMaskDWord, 0x80800000);
 	phy_set_bb_reg(adapt, rTx_IQK, bMaskDWord, 0x01007c00);
 	phy_set_bb_reg(adapt, rRx_IQK, bMaskDWord, 0x81004800);
 
 	for (i = 0; i < retry_count; i++) {
-		path_a_ok = phy_path_a_iqk(adapt, is2t);
+		path_a_ok = phy_path_a_iqk(adapt, false);
 		if (path_a_ok == 0x01) {
 			result[t][0] = (phy_query_bb_reg(adapt, rTx_Power_Before_IQK_A,
 							 bMaskDWord) & 0x3FF0000) >> 16;
@@ -965,7 +916,7 @@ static void phy_iq_calibrate(struct adapter *adapt, s32 result[][8],
 	}
 
 	for (i = 0; i < retry_count; i++) {
-		path_a_ok = phy_path_a_rx_iqk(adapt, is2t);
+		path_a_ok = phy_path_a_rx_iqk(adapt, false);
 		if (path_a_ok == 0x03) {
 			result[t][2] = (phy_query_bb_reg(adapt, rRx_Power_Before_IQK_A_2,
 							 bMaskDWord) & 0x3FF0000) >> 16;
@@ -975,33 +926,6 @@ static void phy_iq_calibrate(struct adapter *adapt, s32 result[][8],
 		}
 	}
 
-	if (is2t) {
-		path_a_standby(adapt);
-
-		/*  Turn Path B ADDA on */
-		path_adda_on(adapt, adda_reg, false, is2t);
-
-		for (i = 0; i < retry_count; i++) {
-			path_b_ok = phy_path_b_iqk(adapt);
-			if (path_b_ok == 0x03) {
-				result[t][4] = (phy_query_bb_reg(adapt, rTx_Power_Before_IQK_B,
-								 bMaskDWord) & 0x3FF0000) >> 16;
-				result[t][5] = (phy_query_bb_reg(adapt, rTx_Power_After_IQK_B,
-								 bMaskDWord) & 0x3FF0000) >> 16;
-				result[t][6] = (phy_query_bb_reg(adapt, rRx_Power_Before_IQK_B_2,
-								 bMaskDWord) & 0x3FF0000) >> 16;
-				result[t][7] = (phy_query_bb_reg(adapt, rRx_Power_After_IQK_B_2,
-								 bMaskDWord) & 0x3FF0000) >> 16;
-				break;
-			} else if (i == (retry_count - 1) && path_b_ok == 0x01) {	/* Tx IQK OK */
-				result[t][4] = (phy_query_bb_reg(adapt, rTx_Power_Before_IQK_B,
-								 bMaskDWord) & 0x3FF0000) >> 16;
-				result[t][5] = (phy_query_bb_reg(adapt, rTx_Power_After_IQK_B,
-								 bMaskDWord) & 0x3FF0000) >> 16;
-			}
-		}
-	}
-
 	/* Back to BB mode, load original value */
 	phy_set_bb_reg(adapt, rFPGA0_IQK, bMaskDWord, 0);
 
@@ -1027,9 +951,6 @@ static void phy_iq_calibrate(struct adapter *adapt, s32 result[][8],
 		/*  Restore RX initial gain */
 		phy_set_bb_reg(adapt, rFPGA0_XA_LSSIParameter,
 			       bMaskDWord, 0x00032ed3);
-		if (is2t)
-			phy_set_bb_reg(adapt, rFPGA0_XB_LSSIParameter,
-				       bMaskDWord, 0x00032ed3);
 
 		/* load 0xe30 IQC default value */
 		phy_set_bb_reg(adapt, rTx_IQK_Tone_A, bMaskDWord, 0x01008c00);
@@ -1134,7 +1055,7 @@ void rtl88eu_phy_iq_calibrate(struct adapter *adapt, bool recovery)
 	is13simular = false;
 
 	for (i = 0; i < 3; i++) {
-		phy_iq_calibrate(adapt, result, i, false);
+		phy_iq_calibrate(adapt, result, i);
 
 		if (i == 1) {
 			is12simular = simularity_compare(adapt, result, 0, 1);
-- 
2.20.1

