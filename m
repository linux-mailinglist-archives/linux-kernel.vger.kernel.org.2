Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11148429801
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 22:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbhJKUOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 16:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234927AbhJKUOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 16:14:33 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DEDC061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 13:12:32 -0700 (PDT)
Received: from dslb-188-097-046-226.188.097.pools.vodafone-ip.de ([188.97.46.226] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1ma1eu-0004mk-Od; Mon, 11 Oct 2021 22:12:28 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 7/8] staging: r8188eu: odm BoardType is never set
Date:   Mon, 11 Oct 2021 22:11:58 +0200
Message-Id: <20211011201159.10252-8-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211011201159.10252-1-martin@kaiser.cx>
References: <20211011201159.10252-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

odm BoardType is never set, so it's always 0 (ODM_BOARD_NORMAL).
Remove dead code and the BoardType itself.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c  |  7 +------
 drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c |  2 --
 drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c  |  2 --
 drivers/staging/r8188eu/hal/odm.c               |  3 ---
 drivers/staging/r8188eu/hal/odm_HWConfig.c      | 11 -----------
 drivers/staging/r8188eu/include/odm.h           | 12 ------------
 6 files changed, 1 insertion(+), 36 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
index 86e92552dfb0..78c93e87edb3 100644
--- a/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
@@ -178,7 +178,6 @@ enum HAL_STATUS ODM_ReadAndConfig_AGC_TAB_1T_8188E(struct odm_dm_struct *dm_odm)
 	u32     i           = 0;
 	u8     platform    = dm_odm->SupportPlatform;
 	u8     interfaceValue   = dm_odm->SupportInterface;
-	u8     board       = dm_odm->BoardType;
 	u32     arraylen    = sizeof(array_agc_tab_1t_8188e) / sizeof(u32);
 	u32    *array       = array_agc_tab_1t_8188e;
 	bool		biol = false;
@@ -187,7 +186,6 @@ enum HAL_STATUS ODM_ReadAndConfig_AGC_TAB_1T_8188E(struct odm_dm_struct *dm_odm)
 	u8 bndy_cnt = 1;
 	enum HAL_STATUS rst = HAL_STATUS_SUCCESS;
 
-	hex += board;
 	hex += interfaceValue << 8;
 	hex += platform << 16;
 	hex += 0xFF000000;
@@ -458,7 +456,6 @@ enum HAL_STATUS ODM_ReadAndConfig_PHY_REG_1T_8188E(struct odm_dm_struct *dm_odm)
 	u32     i           = 0;
 	u8     platform    = dm_odm->SupportPlatform;
 	u8     interfaceValue   = dm_odm->SupportInterface;
-	u8     board       = dm_odm->BoardType;
 	u32     arraylen    = sizeof(array_phy_reg_1t_8188e) / sizeof(u32);
 	u32    *array       = array_phy_reg_1t_8188e;
 	bool	biol = false;
@@ -466,7 +463,6 @@ enum HAL_STATUS ODM_ReadAndConfig_PHY_REG_1T_8188E(struct odm_dm_struct *dm_odm)
 	struct xmit_frame *pxmit_frame = NULL;
 	u8 bndy_cnt = 1;
 	enum HAL_STATUS rst = HAL_STATUS_SUCCESS;
-	hex += board;
 	hex += interfaceValue << 8;
 	hex += platform << 16;
 	hex += 0xFF000000;
@@ -667,11 +663,10 @@ void ODM_ReadAndConfig_PHY_REG_PG_8188E(struct odm_dm_struct *dm_odm)
 	u32  i           = 0;
 	u8  platform    = dm_odm->SupportPlatform;
 	u8  interfaceValue   = dm_odm->SupportInterface;
-	u8  board       = dm_odm->BoardType;
 	u32  arraylen    = sizeof(array_phy_reg_pg_8188e) / sizeof(u32);
 	u32 *array       = array_phy_reg_pg_8188e;
 
-	hex = board + (interfaceValue << 8);
+	hex = interfaceValue << 8;
 	hex += (platform << 16) + 0xFF000000;
 
 	for (i = 0; i < arraylen; i += 3) {
diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
index 0aab0eb87682..2fd86c660b82 100644
--- a/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
@@ -135,7 +135,6 @@ enum HAL_STATUS ODM_ReadAndConfig_MAC_REG_8188E(struct odm_dm_struct *dm_odm)
 	u32     i;
 	u8     platform    = dm_odm->SupportPlatform;
 	u8     interface_val   = dm_odm->SupportInterface;
-	u8     board       = dm_odm->BoardType;
 	u32     array_len    = sizeof(array_MAC_REG_8188E) / sizeof(u32);
 	u32    *array       = array_MAC_REG_8188E;
 	bool	biol = false;
@@ -144,7 +143,6 @@ enum HAL_STATUS ODM_ReadAndConfig_MAC_REG_8188E(struct odm_dm_struct *dm_odm)
 	struct xmit_frame	*pxmit_frame = NULL;
 	u8 bndy_cnt = 1;
 	enum HAL_STATUS rst = HAL_STATUS_SUCCESS;
-	hex += board;
 	hex += interface_val << 8;
 	hex += platform << 16;
 	hex += 0xFF000000;
diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
index b4269ad56ede..d41f65a2a829 100644
--- a/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
@@ -146,7 +146,6 @@ enum HAL_STATUS ODM_ReadAndConfig_RadioA_1T_8188E(struct odm_dm_struct *pDM_Odm)
 	u32     i           = 0;
 	u8     platform    = pDM_Odm->SupportPlatform;
 	u8     interfaceValue   = pDM_Odm->SupportInterface;
-	u8     board       = pDM_Odm->BoardType;
 	u32     ArrayLen    = sizeof(Array_RadioA_1T_8188E) / sizeof(u32);
 	u32    *Array       = Array_RadioA_1T_8188E;
 	bool		biol = false;
@@ -155,7 +154,6 @@ enum HAL_STATUS ODM_ReadAndConfig_RadioA_1T_8188E(struct odm_dm_struct *pDM_Odm)
 	u8 bndy_cnt = 1;
 	enum HAL_STATUS rst = HAL_STATUS_SUCCESS;
 
-	hex += board;
 	hex += interfaceValue << 8;
 	hex += platform << 16;
 	hex += 0xFF000000;
diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 6f0bd678edf6..712ec380a90d 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -229,9 +229,6 @@ void ODM_CmnInfoInit(struct odm_dm_struct *pDM_Odm, enum odm_common_info_def Cmn
 	case    ODM_CMNINFO_RF_ANTENNA_TYPE:
 		pDM_Odm->AntDivType = (u8)Value;
 		break;
-	case	ODM_CMNINFO_BOARD_TYPE:
-		pDM_Odm->BoardType = (u8)Value;
-		break;
 	/* To remove the compiler warning, must add an empty default statement to handle the other values. */
 	default:
 		/* do nothing */
diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
index c36b4beeb216..b76aa93573dc 100644
--- a/drivers/staging/r8188eu/hal/odm_HWConfig.c
+++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
@@ -179,17 +179,6 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 			RSSI = odm_QueryRxPwrPercentage(rx_pwr[i]);
 			total_rssi += RSSI;
 
-			/* Modification for ext-LNA board */
-			if (dm_odm->BoardType == ODM_BOARD_HIGHPWR) {
-				if ((pPhyStaRpt->path_agc[i].trsw) == 1)
-					RSSI = (RSSI > 94) ? 100 : (RSSI + 6);
-				else
-					RSSI = (RSSI <= 16) ? (RSSI >> 3) : (RSSI - 16);
-
-				if ((RSSI <= 34) && (RSSI >= 4))
-					RSSI -= 4;
-			}
-
 			pPhyInfo->RxMIMOSignalStrength[i] = (u8)RSSI;
 
 			/* Get Rx snr value in DB */
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 7097d1b495fb..ef859bab7489 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -266,7 +266,6 @@ enum odm_common_info_def {
 	ODM_CMNINFO_INTERFACE,		/* ODM_INTERFACE_E */
 	ODM_CMNINFO_MP_TEST_CHIP,
 	ODM_CMNINFO_RF_TYPE,		/* RF_PATH_E or ODM_RF_TYPE_E? */
-	ODM_CMNINFO_BOARD_TYPE,		/* ODM_BOARD_TYPE_E */
 	/* HOOK BEFORE REG INIT-----------  */
 
 	/*  Dynamic value: */
@@ -437,15 +436,6 @@ enum odm_bw {
 	ODM_BW40M		= 1,
 };
 
-/*  ODM_CMNINFO_BOARD_TYPE */
-enum odm_board_type {
-	ODM_BOARD_NORMAL	= 0,
-	ODM_BOARD_HIGHPWR	= 1,
-	ODM_BOARD_MINICARD	= 2,
-	ODM_BOARD_SLIM		= 3,
-	ODM_BOARD_COMBO		= 4,
-};
-
 /*  ODM_CMNINFO_ONE_PATH_CCA */
 enum odm_cca_path {
 	ODM_CCA_2R		= 0,
@@ -628,8 +618,6 @@ struct odm_dm_struct {
 	u8	SupportInterface;
 	/*  RF Type 4T4R/3T3R/2T2R/1T2R/1T1R/... */
 	u8	RFType;
-	/*  Board Type Normal/HighPower/MiniCard/SLIM/Combo/. = 0/1/2/3/4/. */
-	u8	BoardType;
 
 	u32	BK_SupportAbility;
 	u8	AntDivType;
-- 
2.20.1

