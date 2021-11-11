Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134D344DD11
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 22:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbhKKVaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 16:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbhKKV37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 16:29:59 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FE8C061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 13:27:09 -0800 (PST)
Received: from ipservice-092-217-091-158.092.217.pools.vodafone-ip.de ([92.217.91.158] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mlHb7-0006fH-Lp; Thu, 11 Nov 2021 22:27:05 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 5/7] staging: r8188eu: rf_chip is constant
Date:   Thu, 11 Nov 2021 22:26:42 +0100
Message-Id: <20211111212644.9011-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211111212644.9011-1-martin@kaiser.cx>
References: <20211111212644.9011-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For this driver, rf_chip is always RF_6052. Remove the rf_chip component
from struct hal_data_8188e and resulting dead code.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 26 +------------------
 drivers/staging/r8188eu/hal/usb_halinit.c     |  8 ------
 .../staging/r8188eu/include/Hal8188EPhyCfg.h  | 10 -------
 .../staging/r8188eu/include/rtl8188e_hal.h    |  1 -
 4 files changed, 1 insertion(+), 44 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index bb0cda0c16a0..47402851700b 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -756,13 +756,6 @@ _PHY_SetBWMode92C(
 	u8 regBwOpMode;
 	u8 regRRSR_RSC;
 
-	if (pHalData->rf_chip == RF_PSEUDO_11N)
-		return;
-
-	/*  There is no 40MHz mode in RF_8225. */
-	if (pHalData->rf_chip == RF_8225)
-		return;
-
 	if (Adapter->bDriverStopped)
 		return;
 
@@ -814,21 +807,7 @@ _PHY_SetBWMode92C(
 	}
 	/* Skip over setting of J-mode in BB register here. Default value is "None J mode". Emily 20070315 */
 
-	/* 3<3>Set RF related register */
-	switch (pHalData->rf_chip) {
-	case RF_8225:
-		break;
-	case RF_8256:
-		/*  Please implement this function in Hal8190PciPhy8256.c */
-		break;
-	case RF_PSEUDO_11N:
-		break;
-	case RF_6052:
-		rtl8188e_PHY_RF6052SetBandwidth(Adapter, pHalData->CurrentChannelBW);
-		break;
-	default:
-		break;
-	}
+	rtl8188e_PHY_RF6052SetBandwidth(Adapter, pHalData->CurrentChannelBW);
 }
 
  /*-----------------------------------------------------------------------------
@@ -885,9 +864,6 @@ void PHY_SwChnl8188E(struct adapter *Adapter, u8 channel)
 	/*  Call after initialization */
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(Adapter);
 
-	if (pHalData->rf_chip == RF_PSEUDO_11N)
-		return;		/* return immediately if it is peudo-phy */
-
 	if (channel == 0)
 		channel = 1;
 
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 1625873aa742..119523d9c38a 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1037,16 +1037,8 @@ static void _ReadPROMContent(
 	readAdapterInfo_8188EU(Adapter);
 }
 
-static void _ReadRFType(struct adapter *Adapter)
-{
-	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
-
-	haldata->rf_chip = RF_6052;
-}
-
 static int _ReadAdapterInfo8188EU(struct adapter *Adapter)
 {
-	_ReadRFType(Adapter);/* rf_chip -> _InitRFType() */
 	_ReadPROMContent(Adapter);
 
 	return _SUCCESS;
diff --git a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
index 6f901ce607e8..b1ba7acb454c 100644
--- a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
+++ b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
@@ -48,16 +48,6 @@ enum rf_radio_path {
 						 * total three groups */
 #define CHANNEL_GROUP_MAX_88E		6
 
-/* BB/RF related */
-enum RF_TYPE_8190P {
-	RF_TYPE_MIN,		/*  0 */
-	RF_8225 = 1,		/*  1 11b/g RF for verification only */
-	RF_8256 = 2,		/*  2 11b/g/n */
-	RF_6052 = 4,		/*  4 11b/g/n RF */
-	/*  TODO: We should remove this psudo PHY RF after we get new RF. */
-	RF_PSEUDO_11N = 5,	/*  5, It is a temporality RF. */
-};
-
 struct bb_reg_def {
 	u32 rfintfs;		/*  set software control: */
 				/*	0x870~0x877[8 bytes] */
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 3593334e24b6..6630cb5c5e55 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -169,7 +169,6 @@ struct hal_data_8188e {
 	u16	BasicRateSet;
 
 	/* rf_ctrl */
-	u8	rf_chip;
 	u8	rf_type;
 
 	u8	BoardType;
-- 
2.20.1

