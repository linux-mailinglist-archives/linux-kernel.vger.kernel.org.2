Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C01B429802
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 22:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbhJKUOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 16:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbhJKUOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 16:14:37 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D4DC061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 13:12:36 -0700 (PDT)
Received: from dslb-188-097-046-226.188.097.pools.vodafone-ip.de ([188.97.46.226] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1ma1ew-0004mk-Vf; Mon, 11 Oct 2021 22:12:31 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 8/8] staging: r8188eu: odm SupportPlatform is always ODM_CE
Date:   Mon, 11 Oct 2021 22:11:59 +0200
Message-Id: <20211011201159.10252-9-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211011201159.10252-1-martin@kaiser.cx>
References: <20211011201159.10252-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the SupportPlatform entry of struct odm_dm_struct and any code
that depends on SupportPlatform != ODM_CE.

Merge functions in places where there was a "top-level function" that
would select a "sub-function" based on SupportPlatform.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 .../staging/r8188eu/hal/HalHWImg8188E_BB.c    |   9 +-
 .../staging/r8188eu/hal/HalHWImg8188E_MAC.c   |   3 +-
 .../staging/r8188eu/hal/HalHWImg8188E_RF.c    |   3 +-
 drivers/staging/r8188eu/hal/odm.c             | 141 ++----------------
 drivers/staging/r8188eu/hal/rtl8188e_dm.c     |   2 -
 drivers/staging/r8188eu/include/odm.h         |   3 -
 drivers/staging/r8188eu/include/odm_precomp.h |  10 --
 drivers/staging/r8188eu/include/odm_types.h   |   6 -
 8 files changed, 19 insertions(+), 158 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
index 78c93e87edb3..17b55c31f6eb 100644
--- a/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
@@ -176,7 +176,6 @@ enum HAL_STATUS ODM_ReadAndConfig_AGC_TAB_1T_8188E(struct odm_dm_struct *dm_odm)
 {
 	u32     hex         = 0;
 	u32     i           = 0;
-	u8     platform    = dm_odm->SupportPlatform;
 	u8     interfaceValue   = dm_odm->SupportInterface;
 	u32     arraylen    = sizeof(array_agc_tab_1t_8188e) / sizeof(u32);
 	u32    *array       = array_agc_tab_1t_8188e;
@@ -187,7 +186,7 @@ enum HAL_STATUS ODM_ReadAndConfig_AGC_TAB_1T_8188E(struct odm_dm_struct *dm_odm)
 	enum HAL_STATUS rst = HAL_STATUS_SUCCESS;
 
 	hex += interfaceValue << 8;
-	hex += platform << 16;
+	hex += ODM_CE << 16;
 	hex += 0xFF000000;
 	biol = rtw_IOL_applied(adapter);
 
@@ -454,7 +453,6 @@ enum HAL_STATUS ODM_ReadAndConfig_PHY_REG_1T_8188E(struct odm_dm_struct *dm_odm)
 {
 	u32     hex         = 0;
 	u32     i           = 0;
-	u8     platform    = dm_odm->SupportPlatform;
 	u8     interfaceValue   = dm_odm->SupportInterface;
 	u32     arraylen    = sizeof(array_phy_reg_1t_8188e) / sizeof(u32);
 	u32    *array       = array_phy_reg_1t_8188e;
@@ -464,7 +462,7 @@ enum HAL_STATUS ODM_ReadAndConfig_PHY_REG_1T_8188E(struct odm_dm_struct *dm_odm)
 	u8 bndy_cnt = 1;
 	enum HAL_STATUS rst = HAL_STATUS_SUCCESS;
 	hex += interfaceValue << 8;
-	hex += platform << 16;
+	hex += ODM_CE << 16;
 	hex += 0xFF000000;
 	biol = rtw_IOL_applied(adapter);
 
@@ -661,13 +659,12 @@ void ODM_ReadAndConfig_PHY_REG_PG_8188E(struct odm_dm_struct *dm_odm)
 {
 	u32  hex;
 	u32  i           = 0;
-	u8  platform    = dm_odm->SupportPlatform;
 	u8  interfaceValue   = dm_odm->SupportInterface;
 	u32  arraylen    = sizeof(array_phy_reg_pg_8188e) / sizeof(u32);
 	u32 *array       = array_phy_reg_pg_8188e;
 
 	hex = interfaceValue << 8;
-	hex += (platform << 16) + 0xFF000000;
+	hex += (ODM_CE << 16) + 0xFF000000;
 
 	for (i = 0; i < arraylen; i += 3) {
 		u32 v1 = array[i];
diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
index 2fd86c660b82..bb57e93eb959 100644
--- a/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
@@ -133,7 +133,6 @@ enum HAL_STATUS ODM_ReadAndConfig_MAC_REG_8188E(struct odm_dm_struct *dm_odm)
 
 	u32     hex         = 0;
 	u32     i;
-	u8     platform    = dm_odm->SupportPlatform;
 	u8     interface_val   = dm_odm->SupportInterface;
 	u32     array_len    = sizeof(array_MAC_REG_8188E) / sizeof(u32);
 	u32    *array       = array_MAC_REG_8188E;
@@ -144,7 +143,7 @@ enum HAL_STATUS ODM_ReadAndConfig_MAC_REG_8188E(struct odm_dm_struct *dm_odm)
 	u8 bndy_cnt = 1;
 	enum HAL_STATUS rst = HAL_STATUS_SUCCESS;
 	hex += interface_val << 8;
-	hex += platform << 16;
+	hex += ODM_CE << 16;
 	hex += 0xFF000000;
 
 	biol = rtw_IOL_applied(adapt);
diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
index d41f65a2a829..7a8faa7885a1 100644
--- a/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
@@ -144,7 +144,6 @@ enum HAL_STATUS ODM_ReadAndConfig_RadioA_1T_8188E(struct odm_dm_struct *pDM_Odm)
 
 	u32     hex         = 0;
 	u32     i           = 0;
-	u8     platform    = pDM_Odm->SupportPlatform;
 	u8     interfaceValue   = pDM_Odm->SupportInterface;
 	u32     ArrayLen    = sizeof(Array_RadioA_1T_8188E) / sizeof(u32);
 	u32    *Array       = Array_RadioA_1T_8188E;
@@ -155,7 +154,7 @@ enum HAL_STATUS ODM_ReadAndConfig_RadioA_1T_8188E(struct odm_dm_struct *pDM_Odm)
 	enum HAL_STATUS rst = HAL_STATUS_SUCCESS;
 
 	hex += interfaceValue << 8;
-	hex += platform << 16;
+	hex += ODM_CE << 16;
 	hex += 0xFF000000;
 	biol = rtw_IOL_applied(Adapter);
 
diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 712ec380a90d..2178ffe41bb3 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -214,9 +214,6 @@ void ODM_CmnInfoInit(struct odm_dm_struct *pDM_Odm, enum odm_common_info_def Cmn
 	case	ODM_CMNINFO_ABILITY:
 		pDM_Odm->SupportAbility = (u32)Value;
 		break;
-	case	ODM_CMNINFO_PLATFORM:
-		pDM_Odm->SupportPlatform = (u8)Value;
-		break;
 	case	ODM_CMNINFO_INTERFACE:
 		pDM_Odm->SupportInterface = (u8)Value;
 		break;
@@ -460,15 +457,10 @@ void odm_DIG(struct odm_dm_struct *pDM_Odm)
 	FirstDisConnect = (!pDM_Odm->bLinked) && (pDM_DigTable->bMediaConnect_0);
 
 	/* 1 Boundary Decision */
-	if (pDM_Odm->SupportPlatform & (ODM_AP | ODM_ADSL)) {
-		dm_dig_max = DM_DIG_MAX_AP;
-		dm_dig_min = DM_DIG_MIN_AP;
-		DIG_MaxOfMin = dm_dig_max;
-	} else {
-		dm_dig_max = DM_DIG_MAX_NIC;
-		dm_dig_min = DM_DIG_MIN_NIC;
-		DIG_MaxOfMin = DM_DIG_MAX_AP;
-	}
+	dm_dig_max = DM_DIG_MAX_NIC;
+	dm_dig_min = DM_DIG_MIN_NIC;
+	DIG_MaxOfMin = DM_DIG_MAX_AP;
+
 	if (pDM_Odm->bLinked) {
 		/* 2 8723A Series, offset need to be 10 */
 		/* 2 Modify DIG upper bound */
@@ -844,37 +836,13 @@ u32 ODM_Get_Rate_Bitmap(struct odm_dm_struct *pDM_Odm, u32 macid, u32 ra_mask, u
  *
  *---------------------------------------------------------------------------*/
 void odm_RefreshRateAdaptiveMask(struct odm_dm_struct *pDM_Odm)
-{
-	if (!(pDM_Odm->SupportAbility & ODM_BB_RA_MASK))
-		return;
-	/*  */
-	/*  2011/09/29 MH In HW integration first stage, we provide 4 different handle to operate */
-	/*  at the same time. In the stage2/3, we need to prive universal interface and merge all */
-	/*  HW dynamic mechanism. */
-	/*  */
-	switch	(pDM_Odm->SupportPlatform) {
-	case	ODM_MP:
-		odm_RefreshRateAdaptiveMaskMP(pDM_Odm);
-		break;
-	case	ODM_CE:
-		odm_RefreshRateAdaptiveMaskCE(pDM_Odm);
-		break;
-	case	ODM_AP:
-	case	ODM_ADSL:
-		odm_RefreshRateAdaptiveMaskAPADSL(pDM_Odm);
-		break;
-	}
-}
-
-void odm_RefreshRateAdaptiveMaskMP(struct odm_dm_struct *pDM_Odm)
-{
-}
-
-void odm_RefreshRateAdaptiveMaskCE(struct odm_dm_struct *pDM_Odm)
 {
 	u8 i;
 	struct adapter *pAdapter = pDM_Odm->Adapter;
 
+	if (!(pDM_Odm->SupportAbility & ODM_BB_RA_MASK))
+		return;
+
 	if (pAdapter->bDriverStopped)
 		return;
 
@@ -890,10 +858,6 @@ void odm_RefreshRateAdaptiveMaskCE(struct odm_dm_struct *pDM_Odm)
 	}
 }
 
-void odm_RefreshRateAdaptiveMaskAPADSL(struct odm_dm_struct *pDM_Odm)
-{
-}
-
 /*  Return Value: bool */
 /*  - true: RATRState is changed. */
 bool ODM_RAStateCheck(struct odm_dm_struct *pDM_Odm, s32 RSSI, bool bForceUpdate, u8 *pRATRState)
@@ -941,37 +905,6 @@ bool ODM_RAStateCheck(struct odm_dm_struct *pDM_Odm, s32 RSSI, bool bForceUpdate
 /* 3 RSSI Monitor */
 /* 3============================================================ */
 
-void odm_RSSIMonitorCheck(struct odm_dm_struct *pDM_Odm)
-{
-	if (!(pDM_Odm->SupportAbility & ODM_BB_RSSI_MONITOR))
-		return;
-
-	/*  */
-	/*  2011/09/29 MH In HW integration first stage, we provide 4 different handle to operate */
-	/*  at the same time. In the stage2/3, we need to prive universal interface and merge all */
-	/*  HW dynamic mechanism. */
-	/*  */
-	switch	(pDM_Odm->SupportPlatform) {
-	case	ODM_MP:
-		odm_RSSIMonitorCheckMP(pDM_Odm);
-		break;
-	case	ODM_CE:
-		odm_RSSIMonitorCheckCE(pDM_Odm);
-		break;
-	case	ODM_AP:
-		odm_RSSIMonitorCheckAP(pDM_Odm);
-		break;
-	case	ODM_ADSL:
-		/* odm_DIGAP(pDM_Odm); */
-		break;
-	}
-
-}	/*  odm_RSSIMonitorCheck */
-
-void odm_RSSIMonitorCheckMP(struct odm_dm_struct *pDM_Odm)
-{
-}
-
 static void FindMinimumRSSI(struct adapter *pAdapter)
 {
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(pAdapter);
@@ -986,7 +919,7 @@ static void FindMinimumRSSI(struct adapter *pAdapter)
 	pdmpriv->MinUndecoratedPWDBForDM = pdmpriv->EntryMinUndecoratedSmoothedPWDB;
 }
 
-void odm_RSSIMonitorCheckCE(struct odm_dm_struct *pDM_Odm)
+void odm_RSSIMonitorCheck(struct odm_dm_struct *pDM_Odm)
 {
 	struct adapter *Adapter = pDM_Odm->Adapter;
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(Adapter);
@@ -998,6 +931,9 @@ void odm_RSSIMonitorCheckCE(struct odm_dm_struct *pDM_Odm)
 	struct sta_info *psta;
 	u8 bcast_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
+	if (!(pDM_Odm->SupportAbility & ODM_BB_RSSI_MONITOR))
+		return;
+
 	if (!check_fwstate(&Adapter->mlmepriv, _FW_LINKED))
 		return;
 
@@ -1042,10 +978,6 @@ void odm_RSSIMonitorCheckCE(struct odm_dm_struct *pDM_Odm)
 	ODM_CmnInfoUpdate(&pHalData->odmpriv, ODM_CMNINFO_RSSI_MIN, pdmpriv->MinUndecoratedPWDBForDM);
 }
 
-void odm_RSSIMonitorCheckAP(struct odm_dm_struct *pDM_Odm)
-{
-}
-
 /* 3============================================================ */
 /* 3 Tx Power Tracking */
 /* 3============================================================ */
@@ -1066,26 +998,6 @@ void odm_TXPowerTrackingThermalMeterInit(struct odm_dm_struct *pDM_Odm)
 }
 
 void ODM_TXPowerTrackingCheck(struct odm_dm_struct *pDM_Odm)
-{
-	/*  2011/09/29 MH In HW integration first stage, we provide 4 different handle to operate */
-	/*  at the same time. In the stage2/3, we need to prive universal interface and merge all */
-	/*  HW dynamic mechanism. */
-	switch	(pDM_Odm->SupportPlatform) {
-	case	ODM_MP:
-		odm_TXPowerTrackingCheckMP(pDM_Odm);
-		break;
-	case	ODM_CE:
-		odm_TXPowerTrackingCheckCE(pDM_Odm);
-		break;
-	case	ODM_AP:
-		odm_TXPowerTrackingCheckAP(pDM_Odm);
-		break;
-	case	ODM_ADSL:
-		break;
-	}
-}
-
-void odm_TXPowerTrackingCheckCE(struct odm_dm_struct *pDM_Odm)
 {
 	struct adapter *Adapter = pDM_Odm->Adapter;
 
@@ -1103,14 +1015,6 @@ void odm_TXPowerTrackingCheckCE(struct odm_dm_struct *pDM_Odm)
 	}
 }
 
-void odm_TXPowerTrackingCheckMP(struct odm_dm_struct *pDM_Odm)
-{
-}
-
-void odm_TXPowerTrackingCheckAP(struct odm_dm_struct *pDM_Odm)
-{
-}
-
 /* antenna mapping info */
 /*  1: right-side antenna */
 /*  2/0: left-side antenna */
@@ -1190,26 +1094,6 @@ void ODM_EdcaTurboInit(struct odm_dm_struct *pDM_Odm)
 }	/*  ODM_InitEdcaTurbo */
 
 void odm_EdcaTurboCheck(struct odm_dm_struct *pDM_Odm)
-{
-	/*  2011/09/29 MH In HW integration first stage, we provide 4 different handle to operate */
-	/*  at the same time. In the stage2/3, we need to prive universal interface and merge all */
-	/*  HW dynamic mechanism. */
-	if (!(pDM_Odm->SupportAbility & ODM_MAC_EDCA_TURBO))
-		return;
-
-	switch	(pDM_Odm->SupportPlatform) {
-	case	ODM_MP:
-		break;
-	case	ODM_CE:
-		odm_EdcaTurboCheckCE(pDM_Odm);
-		break;
-	case	ODM_AP:
-	case	ODM_ADSL:
-		break;
-	}
-}	/*  odm_CheckEdcaTurbo */
-
-void odm_EdcaTurboCheckCE(struct odm_dm_struct *pDM_Odm)
 {
 	struct adapter *Adapter = pDM_Odm->Adapter;
 	u32	trafficIndex;
@@ -1224,6 +1108,9 @@ void odm_EdcaTurboCheckCE(struct odm_dm_struct *pDM_Odm)
 	struct mlme_ext_priv	*pmlmeext = &Adapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
+	if (!(pDM_Odm->SupportAbility & ODM_MAC_EDCA_TURBO))
+		return;
+
 	if (pregpriv->wifi_spec == 1)
 		goto dm_CheckEdcaTurbo_EXIT;
 
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
index 3a7e01540516..1ca24a507d6d 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
@@ -33,8 +33,6 @@ static void Init_ODM_ComInfo_88E(struct adapter *Adapter)
 
 	dm_odm->Adapter = Adapter;
 
-	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_PLATFORM, ODM_CE);
-
 	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_INTERFACE, ODM_ITRF_USB);
 
 	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_MP_TEST_CHIP, IS_NORMAL_CHIP(hal_data->VersionID));
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index ef859bab7489..187f872d09b5 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -261,7 +261,6 @@ enum odm_common_info_def {
 	/*  Fixed value: */
 
 	/* HOOK BEFORE REG INIT----------- */
-	ODM_CMNINFO_PLATFORM = 0,
 	ODM_CMNINFO_ABILITY,		/* ODM_ABILITY_E */
 	ODM_CMNINFO_INTERFACE,		/* ODM_INTERFACE_E */
 	ODM_CMNINFO_MP_TEST_CHIP,
@@ -610,8 +609,6 @@ struct odm_dm_struct {
 /* 1  COMMON INFORMATION */
 	/*  Init Value */
 /* HOOK BEFORE REG INIT----------- */
-	/*  ODM Platform info AP/ADSL/CE/MP = 1/2/3/4 */
-	u8	SupportPlatform;
 	/*  ODM Support Ability DIG/RATR/TX_PWR_TRACK/ �K�K = 1/2/3/�K */
 	u32	SupportAbility;
 	/*  ODM PCIE/USB/SDIO/GSPI = 0/1/2/3 */
diff --git a/drivers/staging/r8188eu/include/odm_precomp.h b/drivers/staging/r8188eu/include/odm_precomp.h
index aa1328abdfcc..892a2501f05a 100644
--- a/drivers/staging/r8188eu/include/odm_precomp.h
+++ b/drivers/staging/r8188eu/include/odm_precomp.h
@@ -43,22 +43,12 @@ void odm_CommonInfoSelfUpdate(struct odm_dm_struct *pDM_Odm);
 void odm_FalseAlarmCounterStatistics(struct odm_dm_struct *pDM_Odm);
 void odm_DIG(struct odm_dm_struct *pDM_Odm);
 void odm_CCKPacketDetectionThresh(struct odm_dm_struct *pDM_Odm);
-void odm_RefreshRateAdaptiveMaskMP(struct odm_dm_struct *pDM_Odm);
 void odm_SwAntDivChkAntSwitch(struct odm_dm_struct *pDM_Odm, u8 Step);
 void odm_EdcaTurboCheck(struct odm_dm_struct *pDM_Odm);
 void odm_CommonInfoSelfInit(struct odm_dm_struct *pDM_Odm);
 void odm_RSSIMonitorCheck(struct odm_dm_struct *pDM_Odm);
 void odm_RefreshRateAdaptiveMask(struct odm_dm_struct *pDM_Odm);
-void odm_RefreshRateAdaptiveMaskCE(struct odm_dm_struct *pDM_Odm);
-void odm_RefreshRateAdaptiveMaskAPADSL(struct odm_dm_struct *pDM_Odm);
-void odm_RSSIMonitorCheckMP(struct odm_dm_struct *pDM_Odm);
-void odm_RSSIMonitorCheckCE(struct odm_dm_struct *pDM_Odm);
-void odm_RSSIMonitorCheckAP(struct odm_dm_struct *pDM_Odm);
 void odm_TXPowerTrackingThermalMeterInit(struct odm_dm_struct *pDM_Odm);
-void odm_EdcaTurboCheckCE(struct odm_dm_struct *pDM_Odm);
-void odm_TXPowerTrackingCheckCE(struct odm_dm_struct *pDM_Odm);
-void odm_TXPowerTrackingCheckMP(struct odm_dm_struct *pDM_Odm);
-void odm_TXPowerTrackingCheckAP(struct odm_dm_struct *pDM_Odm);
 void odm_SwAntDivChkAntSwitchCallback(struct timer_list *t);
 void odm_InitHybridAntDiv(struct odm_dm_struct *pDM_Odm);
 void odm_HwAntDiv(struct odm_dm_struct *pDM_Odm);
diff --git a/drivers/staging/r8188eu/include/odm_types.h b/drivers/staging/r8188eu/include/odm_types.h
index 7b6a3c392f2a..08ba7a418ba8 100644
--- a/drivers/staging/r8188eu/include/odm_types.h
+++ b/drivers/staging/r8188eu/include/odm_types.h
@@ -4,13 +4,7 @@
 #ifndef __ODM_TYPES_H__
 #define __ODM_TYPES_H__
 
-/*  */
-/*  Define Different SW team support */
-/*  */
-#define	ODM_AP			0x01	 /* BIT(0) */
-#define	ODM_ADSL		0x02	/* BIT(1) */
 #define	ODM_CE			0x04	/* BIT(2) */
-#define	ODM_MP			0x08	/* BIT(3) */
 
 enum HAL_STATUS {
 	HAL_STATUS_SUCCESS,
-- 
2.20.1

