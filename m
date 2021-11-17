Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E196D4548A2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 15:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238361AbhKQO07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 09:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238485AbhKQO0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 09:26:55 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65658C061210
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 06:21:39 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id z9so2715708qtj.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 06:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yu4+ZUt+SSXzjXZ9GWO7X8e2jtwCTt/9QsuwZG7Z8NM=;
        b=B9Nos4m+YaDWPPbbJTlm0dDckLBlXl0HBOnExFfgTposZjnIFkONZDvUqAcDxsMiKx
         UzCvv48KP+KbzD08FGEVstYo0vVOU6/XzBbv6D6n/vLF/NzaVXDFeT/tMo12jahcvtzS
         98C7eywDCKLn4IRitictS6gkdtnfQ2zdX0HioKYMiCG1grt0BG+jZtVn7JSDglJvSX0U
         4d7+9jq0TmGiXp2N3YxOcp1EugiTCG0cLyckzcdyYHkj52U6dE4ofMfJV5YHrKyf9bfv
         caSS3zhsqvyQmaXtmeU3yVwbha8+sEi9JmUibfLHv2/+hoKKPkvZzIkYIA4/BC9EWYO1
         b3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yu4+ZUt+SSXzjXZ9GWO7X8e2jtwCTt/9QsuwZG7Z8NM=;
        b=Gb2fH2KbCT2FWGyKFHy/WhUY8EXQkiSn8Ke3vKb2DRrjaj4l4/wYT9Uq0FEONd1dFw
         uUPRTE3YKkYXhptYDHC2g8bNWM6MBnqiM3UGehpti7ByS2iwTLuziCzxrX3uEkRfguU+
         /DAy4PLoyg4csJFHKiDgd1k20OdYoYLG+xqLIGrp9tdTP0K/YybB/w5NMpjGG2zA0U6J
         jbSe93paHf2rb3cPSP4b5no2/5nN7dcOYH1zSZDwgqm3aXaENlT8xnvQLSynYf3ADUcg
         oMgMVYSZ8QyOgIc9tRPdJJO8a/SvstJE/j4VXx/88M5Cx9IhD3veFDFAwqUAjptgZWRq
         npJw==
X-Gm-Message-State: AOAM533f9ILT8yB9BgN0dwzGB9qstaIFOKPKz/S8AapZX7fpNX39/4GC
        ffNMDSlW/N424DpZdO5oYL8=
X-Google-Smtp-Source: ABdhPJw1q0SPuFvNNWRYgLk5hrkm6iOjNTSmrtlWLKSao0ARKAwmU75hH7HF83ulZ7e78yLDGIWsng==
X-Received: by 2002:a05:622a:4c:: with SMTP id y12mr16947897qtw.21.1637158898412;
        Wed, 17 Nov 2021 06:21:38 -0800 (PST)
Received: from localhost.localdomain (pool-98-113-42-30.nycmny.fios.verizon.net. [98.113.42.30])
        by smtp.googlemail.com with ESMTPSA id r16sm10613644qkp.42.2021.11.17.06.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 06:21:38 -0800 (PST)
From:   Zameer Manji <zmanji@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Zameer Manji <zmanji@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: r8188eu: remove unused hal fields
Date:   Wed, 17 Nov 2021 14:20:20 +0000
Message-Id: <20211117142108.1505715-1-zmanji@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several HAL related fields are never used or are useless. This removes
those fields and any code that is now safe to remove from the field
deletion.

The fields that are referenced but are useless are:
* interfaceIndex: only written to, never read.
* CurrentCckTxPwrIdx: only written to, never read.
* CurrentOfdm24GTxPwrIdx: only written to, never read.
* CurrentBW2024GTxPwrIdx: only written to, never read.
* CurrentBW4024GTxPwrIdx: only written to, never read.
* bRDGEnable: never initialized, always false.

Signed-off-by: Zameer Manji <zmanji@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 13 ------
 drivers/staging/r8188eu/hal/usb_halinit.c     | 12 ------
 .../staging/r8188eu/include/rtl8188e_hal.h    | 40 -------------------
 3 files changed, 65 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index 47402851700b..6e2de43b5903 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -685,17 +685,6 @@ static void getTxPowerIndex88E(struct adapter *Adapter, u8 channel, u8 *cckPower
 	}
 }
 
-static void phy_PowerIndexCheck88E(struct adapter *Adapter, u8 channel, u8 *cckPowerLevel,
-				   u8 *ofdmPowerLevel, u8 *BW20PowerLevel, u8 *BW40PowerLevel)
-{
-	struct hal_data_8188e		*pHalData = GET_HAL_DATA(Adapter);
-
-	pHalData->CurrentCckTxPwrIdx = cckPowerLevel[0];
-	pHalData->CurrentOfdm24GTxPwrIdx = ofdmPowerLevel[0];
-	pHalData->CurrentBW2024GTxPwrIdx = BW20PowerLevel[0];
-	pHalData->CurrentBW4024GTxPwrIdx = BW40PowerLevel[0];
-}
-
 /*-----------------------------------------------------------------------------
  * Function:    SetTxPowerLevel8190()
  *
@@ -726,8 +715,6 @@ PHY_SetTxPowerLevel8188E(
 
 	getTxPowerIndex88E(Adapter, channel, &cckPowerLevel[0], &ofdmPowerLevel[0], &BW20PowerLevel[0], &BW40PowerLevel[0]);
 
-	phy_PowerIndexCheck88E(Adapter, channel, &cckPowerLevel[0], &ofdmPowerLevel[0], &BW20PowerLevel[0], &BW40PowerLevel[0]);
-
 	rtl8188e_PHY_RF6052SetCckTxPower(Adapter, &cckPowerLevel[0]);
 	rtl8188e_PHY_RF6052SetOFDMTxPower(Adapter, &ofdmPowerLevel[0], &BW20PowerLevel[0], &BW40PowerLevel[0], channel);
 }
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 902afbb4aeb8..bea4420da8c2 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -70,8 +70,6 @@ void rtl8188eu_interface_configure(struct adapter *adapt)
 	else
 		haldata->UsbBulkOutSize = USB_FULL_SPEED_BULK_SIZE;/* 64 bytes */
 
-	haldata->interfaceIndex = pdvobjpriv->InterfaceNumber;
-
 	haldata->UsbTxAggMode		= 1;
 	haldata->UsbTxAggDescNum	= 0x6;	/*  only 4 bits */
 
@@ -400,13 +398,6 @@ static void _InitEDCA(struct adapter *Adapter)
 	rtw_write32(Adapter, REG_EDCA_VO_PARAM, 0x002FA226);
 }
 
-static void _InitRDGSetting(struct adapter *Adapter)
-{
-	rtw_write8(Adapter, REG_RD_CTRL, 0xFF);
-	rtw_write16(Adapter, REG_RD_NAV_NXT, 0x200);
-	rtw_write8(Adapter, REG_RD_RESP_PKT_TH, 0x05);
-}
-
 static void _InitRetryFunction(struct adapter *Adapter)
 {
 	u8 value8;
@@ -743,9 +734,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	value16 |= (MACTXEN | MACRXEN);
 	rtw_write8(Adapter, REG_CR, value16);
 
-	if (haldata->bRDGEnable)
-		_InitRDGSetting(Adapter);
-
 	/* Enable TX Report */
 	/* Enable Tx Report Timer */
 	value8 = rtw_read8(Adapter, REG_TX_RPT_CTRL);
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 31a46f204954..a75929c6bc05 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -112,21 +112,6 @@ enum usb_rx_agg_mode {
 #include "HalVerDef.h"
 #include "hal_com.h"
 
-/* 	Channel Plan */
-enum ChannelPlan {
-	CHPL_FCC	= 0,
-	CHPL_IC		= 1,
-	CHPL_ETSI	= 2,
-	CHPL_SPA	= 3,
-	CHPL_FRANCE	= 4,
-	CHPL_MKK	= 5,
-	CHPL_MKK1	= 6,
-	CHPL_ISRAEL	= 7,
-	CHPL_TELEC	= 8,
-	CHPL_GLOBAL	= 9,
-	CHPL_WORLD	= 10,
-};
-
 struct txpowerinfo24g {
 	u8 IndexCCK_Base[RF_PATH_MAX][MAX_CHNL_GROUP_24G];
 	u8 IndexBW40_Base[RF_PATH_MAX][MAX_CHNL_GROUP_24G];
@@ -206,18 +191,7 @@ struct hal_data_8188e {
 	u8	PwrGroupHT20[RF_PATH_MAX][CHANNEL_MAX_NUMBER];
 	u8	PwrGroupHT40[RF_PATH_MAX][CHANNEL_MAX_NUMBER];
 
-	u8	LegacyHTTxPowerDiff;/*  Legacy to HT rate power diff */
-	/*  The current Tx Power Level */
-	u8	CurrentCckTxPwrIdx;
-	u8	CurrentOfdm24GTxPwrIdx;
-	u8	CurrentBW2024GTxPwrIdx;
-	u8	CurrentBW4024GTxPwrIdx;
-
 	/*  Read/write are allow for following hardware information variables */
-	u8	framesync;
-	u32	framesyncC34;
-	u8	framesyncMonitor;
-	u8	DefaultInitialGain[4];
 	u8	pwrGroupCnt;
 	u32	MCSTxPowerLevelOriginalOffset[MAX_PG_GROUP][16];
 	u32	CCKTxPowerLevelOriginalOffset;
@@ -237,9 +211,6 @@ struct hal_data_8188e {
 
 	u32	RfRegChnlVal[2];
 
-	/* RDG enable */
-	bool	 bRDGEnable;
-
 	/* for host message to fw */
 	u8	LastHMEBoxNum;
 
@@ -260,23 +231,12 @@ struct hal_data_8188e {
 	u8	FwRsvdPageStartOffset; /* Reserve page start offset except
 					*  beacon in TxQ. */
 
-	/*  2010/08/09 MH Add CU power down mode. */
-	bool		pwrdown;
-
-	/*  Add for dual MAC  0--Mac0 1--Mac1 */
-	u32	interfaceIndex;
-
 	u8	OutEpQueueSel;
 	u8	OutEpNumber;
 
 	/*  Add for USB aggreation mode dynamic shceme. */
 	bool		UsbRxHighSpeedMode;
 
-	/*  2010/11/22 MH Add for slim combo debug mode selective. */
-	/*  This is used for fix the drawback of CU TSMC-A/UMC-A cut.
-	 * HW auto suspend ability. Close BT clock. */
-	bool		SlimComboDbg;
-
 	u16	EfuseUsedBytes;
 
 	struct P2P_PS_Offload_t	p2p_ps_offload;
-- 
2.25.1

