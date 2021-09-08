Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D8840411D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 00:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347491AbhIHWkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 18:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244469AbhIHWkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 18:40:37 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E904C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 15:39:29 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id z4so5522667wrr.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 15:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Xjay+OnxJOLudTFFKRgsdno8a9S825AsCQkvjXdAR0=;
        b=cXJI+VMD7JpbhibxlJDS7juqR7RIU+RI5jaOcRxpsRQ6KsZeBr+E7MX648vUQEVugm
         iTlq0RTejSPY/Nt3cDEo+nj7VObOZ75nSFq5qwJivSS7T1DiWkMm6iAA2wrO5E30RaX0
         p4wiBq/9aCsfvw0DFYgPAe3DzfvxIIqD5beMNrBjESmaMYhJohmlVhoucxh7bl6607XP
         eOb9KxYzA7WJCIgZzqYI8EEBPqR77l/oO77lVEEwFyPQhFwFg1zwO6x2PRRkZZlqdY9B
         P4rheHRGWhtSbyt7TnqVz5nkB+s2w9RnuLHqFOmrY4cVaV3hyHZXOPcmqcX9H5XMnL0k
         Is7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Xjay+OnxJOLudTFFKRgsdno8a9S825AsCQkvjXdAR0=;
        b=Ldf3EW9VvMSW8yL6zXRgvPxFlRy8qPoXqILchs+4+cxC//k7I/7i/O0NP7a23YtgC7
         cgGMM4qphCCWStgm16g1Rg9MvZYGEfhJdguwnGnZMovCUuLlZ1kkFxD/qI+S0M5AgDcL
         jwT1cYYhp8ALhBcTM9O5jjgsFFJJkgnLKv1CIqLRrSbl5cy26o71Op/LIWbi22+XYNS5
         XoWzIxToExSK6kSvMIVwy941Nw3jZh+wTlDF6imdX9fX5Tp7Bg+ocO/WEcvKCFT0p40B
         vNCXfgnlliORTk7dw//I39/YW3SDwKlOKVHPWbq318GdsCTWQ5/WHMt/Z1kRMj8LlTdM
         /iqQ==
X-Gm-Message-State: AOAM532QIiX9YKd65JzbSueNVUziti/8d5g4PTsyZUAjpah/92LJXWVI
        WZB87RG8xHKrN1sk9fLGxII=
X-Google-Smtp-Source: ABdhPJwgw/cfKfmsbe6kgu2iH7AEggfQvurrLn8j9t+1H5rJ49/pvxpYhndcRD1kNqXW2OWgLeQ77g==
X-Received: by 2002:a5d:5490:: with SMTP id h16mr588478wrv.170.1631140767956;
        Wed, 08 Sep 2021 15:39:27 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id d29sm428643wrc.6.2021.09.08.15.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 15:39:27 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/4] staging: r8188eu: remove unused PHY_UpdateTxPowerDbm8188E()
Date:   Thu,  9 Sep 2021 00:39:02 +0200
Message-Id: <20210908223903.10516-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210908223903.10516-1-straube.linux@gmail.com>
References: <20210908223903.10516-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function PHY_UpdateTxPowerDbm8188E() is unused and it is the only user
of function phy_DbmToTxPwrIdx(), remove both.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 80 -------------------
 .../staging/r8188eu/include/Hal8188EPhyCfg.h  |  1 -
 2 files changed, 81 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index d3564181542d..dd0008bcceb6 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -627,49 +627,6 @@ rtl8192c_PHY_GetHWRegOriginalValue(
 	pHalData->framesyncC34 = PHY_QueryBBReg(Adapter, rOFDM0_RxDetector2, bMaskDWord);
 }
 
-/*  */
-/*	Description: */
-/*		Map dBm into Tx power index according to */
-/*		current HW model, for example, RF and PA, and */
-/*		current wireless mode. */
-/*	By Bruce, 2008-01-29. */
-/*  */
-static	u8 phy_DbmToTxPwrIdx(struct adapter *Adapter, enum wireless_mode WirelessMode, int PowerInDbm)
-{
-	u8 TxPwrIdx = 0;
-	int				Offset = 0;
-
-	/*  */
-	/*  Tested by MP, we found that CCK Index 0 equals to 8dbm, OFDM legacy equals to */
-	/*  3dbm, and OFDM HT equals to 0dbm respectively. */
-	/*  Note: */
-	/*	The mapping may be different by different NICs. Do not use this formula for what needs accurate result. */
-	/*  By Bruce, 2008-01-29. */
-	/*  */
-	switch (WirelessMode) {
-	case WIRELESS_MODE_B:
-		Offset = -7;
-		break;
-
-	case WIRELESS_MODE_G:
-	case WIRELESS_MODE_N_24G:
-	default:
-		Offset = -8;
-		break;
-	}
-
-	if ((PowerInDbm - Offset) > 0)
-		TxPwrIdx = (u8)((PowerInDbm - Offset) * 2);
-	else
-		TxPwrIdx = 0;
-
-	/*  Tx Power Index is too large. */
-	if (TxPwrIdx > MAX_TXPWR_IDX_NMODE_92S)
-		TxPwrIdx = MAX_TXPWR_IDX_NMODE_92S;
-
-	return TxPwrIdx;
-}
-
 static void getTxPowerIndex88E(struct adapter *Adapter, u8 channel, u8 *cckPowerLevel,
 			       u8 *ofdmPowerLevel, u8 *BW20PowerLevel,
 			       u8 *BW40PowerLevel)
@@ -793,43 +750,6 @@ PHY_SetTxPowerLevel8188E(
 	rtl8188e_PHY_RF6052SetOFDMTxPower(Adapter, &ofdmPowerLevel[0], &BW20PowerLevel[0], &BW40PowerLevel[0], channel);
 }
 
-/*  */
-/*	Description: */
-/*		Update transmit power level of all channel supported. */
-/*  */
-/*	TODO: */
-/*		A mode. */
-/*	By Bruce, 2008-02-04. */
-/*  */
-bool
-PHY_UpdateTxPowerDbm8188E(
-		struct adapter *Adapter,
-		int		powerInDbm
-	)
-{
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(Adapter);
-	u8 idx;
-	u8 rf_path;
-
-	/*  TODO: A mode Tx power. */
-	u8 CckTxPwrIdx = phy_DbmToTxPwrIdx(Adapter, WIRELESS_MODE_B, powerInDbm);
-	u8 OfdmTxPwrIdx = phy_DbmToTxPwrIdx(Adapter, WIRELESS_MODE_N_24G, powerInDbm);
-
-	if (OfdmTxPwrIdx - pHalData->LegacyHTTxPowerDiff > 0)
-		OfdmTxPwrIdx -= pHalData->LegacyHTTxPowerDiff;
-	else
-		OfdmTxPwrIdx = 0;
-
-	for (idx = 0; idx < 14; idx++) {
-		for (rf_path = 0; rf_path < 2; rf_path++) {
-			pHalData->TxPwrLevelCck[rf_path][idx] = CckTxPwrIdx;
-			pHalData->TxPwrLevelHT40_1S[rf_path][idx] =
-			pHalData->TxPwrLevelHT40_2S[rf_path][idx] = OfdmTxPwrIdx;
-		}
-	}
-	return true;
-}
-
 /*-----------------------------------------------------------------------------
  * Function:    PHY_SetBWModeCallback8192C()
  *
diff --git a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
index 1799d9aeaa3c..e5662fa9c918 100644
--- a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
+++ b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
@@ -190,7 +190,6 @@ void rtl8192c_PHY_GetHWRegOriginalValue(struct adapter *adapter);
 
 /*  BB TX Power R/W */
 void PHY_SetTxPowerLevel8188E(struct adapter *adapter, u8 channel);
-bool PHY_UpdateTxPowerDbm8188E(struct adapter *adapter, int power);
 
 /*  Switch bandwidth for 8192S */
 void PHY_SetBWMode8188E(struct adapter *adapter,
-- 
2.33.0

