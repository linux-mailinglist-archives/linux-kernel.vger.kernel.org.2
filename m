Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC973ADFB8
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 19:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhFTR4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 13:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhFTRzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 13:55:47 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050E4C061756;
        Sun, 20 Jun 2021 10:53:33 -0700 (PDT)
Received: from dslb-084-059-235-131.084.059.pools.vodafone-ip.de ([84.59.235.131] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1lv1dT-00012S-Nn; Sun, 20 Jun 2021 19:53:31 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 08/13] staging: rtl8188eu: remove HAL_INIT_PROFILE_TAG
Date:   Sun, 20 Jun 2021 19:52:56 +0200
Message-Id: <20210620175301.14988-8-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210620175301.14988-1-martin@kaiser.cx>
References: <20210620175301.14988-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove HAL_INIT_PROFILE_TAG, which is an empty loop already.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/hal/usb_halinit.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/usb_halinit.c b/drivers/staging/rtl8188eu/hal/usb_halinit.c
index 3ecc0186fea0..23f6597b7e07 100644
--- a/drivers/staging/rtl8188eu/hal/usb_halinit.c
+++ b/drivers/staging/rtl8188eu/hal/usb_halinit.c
@@ -643,10 +643,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	struct pwrctrl_priv		*pwrctrlpriv = &Adapter->pwrctrlpriv;
 	struct registry_priv	*pregistrypriv = &Adapter->registrypriv;
 
-	#define HAL_INIT_PROFILE_TAG(stage) do {} while (0)
-
-	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_BEGIN);
-
 	if (Adapter->pwrctrlpriv.bkeepfwalive) {
 		if (haldata->odmpriv.RFCalibrateInfo.bIQKInitialized) {
 			rtl88eu_phy_iq_calibrate(Adapter, true);
@@ -661,7 +657,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 		goto exit;
 	}
 
-	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_INIT_PW_ON);
 	status = rtw_hal_power_on(Adapter);
 	if (status == _FAIL) {
 		goto exit;
@@ -684,7 +679,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 		txpktbuf_bndy = WMM_NORMAL_TX_PAGE_BOUNDARY_88E;
 	}
 
-	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_MISC01);
 	_InitQueueReservedPage(Adapter);
 	_InitQueuePriority(Adapter);
 	_InitPageBoundary(Adapter);
@@ -692,7 +686,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 
 	_InitTxBufferBoundary(Adapter, 0);
 
-	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_DOWNLOAD_FW);
 	if (Adapter->registrypriv.mp_mode == 1) {
 		_InitRxSetting(Adapter);
 		Adapter->bFWReady = false;
@@ -713,20 +706,17 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 
 	rtl88eu_phy_rf_config(Adapter);
 
-	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_EFUSE_PATCH);
 	status = rtl8188e_iol_efuse_patch(Adapter);
 	if (status == _FAIL)
 		goto exit;
 
 	_InitTxBufferBoundary(Adapter, txpktbuf_bndy);
 
-	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_INIT_LLTT);
 	status =  InitLLTTable(Adapter, txpktbuf_bndy);
 	if (status == _FAIL) {
 		goto exit;
 	}
 
-	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_MISC02);
 	/*  Get Rx PHY status in order to report RSSI and others. */
 	_InitDriverInfoSize(Adapter, DRVINFO_SZ);
 
@@ -768,13 +758,10 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	haldata->RfRegChnlVal[0] = rtw_hal_read_rfreg(Adapter, (enum rf_radio_path)0, RF_CHNLBW, bRFRegOffsetMask);
 	haldata->RfRegChnlVal[1] = rtw_hal_read_rfreg(Adapter, (enum rf_radio_path)1, RF_CHNLBW, bRFRegOffsetMask);
 
-	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_TURN_ON_BLOCK);
 	_BBTurnOnBlock(Adapter);
 
-	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_INIT_SECURITY);
 	invalidate_cam_all(Adapter);
 
-	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_MISC11);
 	/*  2010/12/17 MH We need to set TX power according to EFUSE content at first. */
 	phy_set_tx_power_level(Adapter, haldata->CurrentChannel);
 
@@ -799,7 +786,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	/* Nav limit , suggest by scott */
 	usb_write8(Adapter, 0x652, 0x0);
 
-	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_INIT_HAL_DM);
 	rtl8188e_InitHalDm(Adapter);
 
 	/*  2010/08/11 MH Merge from 8192SE for Minicard init. We need to confirm current radio status */
@@ -823,7 +809,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	/* enable tx DMA to drop the redundate data of packet */
 	usb_write16(Adapter, REG_TXDMA_OFFSET_CHK, (usb_read16(Adapter, REG_TXDMA_OFFSET_CHK) | DROP_DATA_EN));
 
-	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_IQK);
 	/*  2010/08/26 MH Merge from 8192CE. */
 	if (pwrctrlpriv->rf_pwrstate == rf_on) {
 		if (haldata->odmpriv.RFCalibrateInfo.bIQKInitialized) {
@@ -833,15 +818,11 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 			haldata->odmpriv.RFCalibrateInfo.bIQKInitialized = true;
 		}
 
-		HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_PW_TRACK);
-
 		ODM_TXPowerTrackingCheck(&haldata->odmpriv);
 
-		HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_LCK);
 		rtl88eu_phy_lc_calibrate(Adapter);
 	}
 
-/* HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_INIT_PABIAS); */
 /*	_InitPABias(Adapter); */
 	usb_write8(Adapter, REG_USB_HRPWM, 0);
 
@@ -849,7 +830,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	usb_write32(Adapter, REG_FWHW_TXQ_CTRL, usb_read32(Adapter, REG_FWHW_TXQ_CTRL) | BIT(12));
 
 exit:
-	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_END);
 
 	return status;
 }
-- 
2.20.1

