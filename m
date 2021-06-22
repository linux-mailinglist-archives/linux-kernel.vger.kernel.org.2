Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B54F3B0467
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 14:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbhFVMcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 08:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbhFVMcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:32:05 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE13C061760
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 05:29:49 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id j21-20020a05600c1c15b02901dde2accccbso2134560wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 05:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aaVYDaWI5B+nrFzKbktT11rttGKVUOF0TEP29OpjHJY=;
        b=s+sIdXez02FZUhYcfvP9f3fYw6dkCLa42AftvpPQGRMaxgzTOpNJa1rxSS9VOiJQ5w
         KmSpB0XJwF9rcM24nJTzLkr4pVoUXjdIGnvsw5C3tiX7M0suwx9b7EZ7IKJkHouxcN9d
         UhsqAmFIylF6wa5FNfjpFervjaWQneOAzqEwC6VpIyopKXisL8/aifG/CnyZW2gTf4CE
         h7MhSacFgFdP34VkbRmNkxhTFkReyq7Za2VO0nXw+8E1OYDMplBgOsGQXrV+3+YbUJ+9
         O4mjdfNGU/LNX328BvRtnsj9YX6RW1H4JWt4UUNGRK4NX3v61Wu7Qb+TJHHRQQPB3thZ
         96SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aaVYDaWI5B+nrFzKbktT11rttGKVUOF0TEP29OpjHJY=;
        b=fmQG1KHDoFuuquD0bVw29mkV/D8fJ4HJnsr5p9pvSThLfRZIxoHskoelv2jDsMij9m
         tDAULpp9Ko9Bc2ZmvmQfSCOksFX2SqOg4b1vGdj1kqcFd9KtWPEMNN316PCnRxL0Em87
         vMHcunmdC+6OeoqxjE22JA+0x4U+UytXM/eWhBakYYWTxTLgv6KbK8zjpUhd1dp7RhO7
         1uhhkv8MStJ+9EKLHKVlKJZ3jcxFn64Ww1FVxVhQ7+re4WAAsg9/Y/Jxiuk3KmWnQ7ul
         rrD5+wrPJ8SyaQ4We8x6asFRxYCzvIruxI5JD250yxma//EEbQd0XP6PIldE38MP88tw
         GjVw==
X-Gm-Message-State: AOAM5333iE1QC1oQI1Fc/lHIcOsQk34dUw1v/Yoh0mpDKa5K69rili4J
        Mvo1I6Lzf6ncYgWa1x2/qBSIJc8kXoocAA==
X-Google-Smtp-Source: ABdhPJyphInr6fVj2pyQNzLSk5LpdnCD71RTLPZOzBCajv4c+WK+yZUmg6DrxkDb+JNtdjnw0pjQWQ==
X-Received: by 2002:a7b:c385:: with SMTP id s5mr4073316wmj.178.1624364987624;
        Tue, 22 Jun 2021 05:29:47 -0700 (PDT)
Received: from agape ([5.171.73.108])
        by smtp.gmail.com with ESMTPSA id z9sm2281822wmf.43.2021.06.22.05.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 05:29:47 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/17] staging: rtl8723bs: remove code related to unsupported channel bandwidth
Date:   Tue, 22 Jun 2021 14:29:27 +0200
Message-Id: <3ad4397340e7f5315b7ee1c0a02eb56d7a07f430.1624364582.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1624364582.git.fabioaiuto83@gmail.com>
References: <cover.1624364582.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove all code related to unsupported channel
bandwidth (i.e. 80, 80+80, 160 Mhz). rtl8723bs NIC
works only on 20 and 40 Mhz channels.

Module parameter rtw_bw_mode can only have two
values: 0 and 1 (20 Mhz and 40Mhz). So modify
the default value setting to zero the 5Ghz nibble.

Comments modified accordingly.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 .../staging/rtl8723bs/core/rtw_wlan_util.c    | 15 +-------
 drivers/staging/rtl8723bs/core/rtw_xmit.c     |  5 +--
 .../staging/rtl8723bs/hal/hal_com_phycfg.c    | 34 -------------------
 drivers/staging/rtl8723bs/hal/odm.h           |  3 --
 drivers/staging/rtl8723bs/hal/odm_DIG.c       |  2 --
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 31 ++---------------
 .../staging/rtl8723bs/hal/rtl8723b_phycfg.c   | 33 +-----------------
 drivers/staging/rtl8723bs/include/drv_types.h |  8 +++--
 drivers/staging/rtl8723bs/include/rtw_rf.h    |  4 ---
 drivers/staging/rtl8723bs/os_dep/os_intfs.c   | 10 +++---
 10 files changed, 17 insertions(+), 128 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 2a47d678de01..c06b74f6569a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -336,9 +336,7 @@ u8 rtw_get_center_ch(u8 channel, u8 chnl_bw, u8 chnl_offset)
 {
 	u8 center_ch = channel;
 
-	if (chnl_bw == CHANNEL_WIDTH_80) {
-		center_ch = 7;
-	} else if (chnl_bw == CHANNEL_WIDTH_40) {
+	if (chnl_bw == CHANNEL_WIDTH_40) {
 		if (chnl_offset == HAL_PRIME_CHNL_OFFSET_LOWER)
 			center_ch = channel + 2;
 		else
@@ -375,14 +373,6 @@ void set_channel_bwmode(struct adapter *padapter, unsigned char channel, unsigne
 
 	center_ch = rtw_get_center_ch(channel, bwmode, channel_offset);
 
-	if (bwmode == CHANNEL_WIDTH_80) {
-		if (center_ch > channel)
-			chnl_offset80 = HAL_PRIME_CHNL_OFFSET_LOWER;
-		else if (center_ch < channel)
-			chnl_offset80 = HAL_PRIME_CHNL_OFFSET_UPPER;
-		else
-			chnl_offset80 = HAL_PRIME_CHNL_OFFSET_DONT_CARE;
-	}
 
 	/* set Channel */
 	if (mutex_lock_interruptible(&(adapter_to_dvobj(padapter)->setch_mutex)))
@@ -919,9 +909,6 @@ static void bwmode_update_check(struct adapter *padapter, struct ndis_80211_var_
 	if (phtpriv->ht_option == false)
 		return;
 
-	if (pmlmeext->cur_bwmode >= CHANNEL_WIDTH_80)
-		return;
-
 	if (pIE->Length > sizeof(struct HT_info_element))
 		return;
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index 0562fa6c1255..79e4d7df1ef5 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -321,15 +321,12 @@ void _rtw_free_xmit_priv(struct xmit_priv *pxmitpriv)
 
 u8 query_ra_short_GI(struct sta_info *psta)
 {
-	u8 sgi = false, sgi_20m = false, sgi_40m = false, sgi_80m = false;
+	u8 sgi = false, sgi_20m = false, sgi_40m = false;
 
 	sgi_20m = psta->htpriv.sgi_20m;
 	sgi_40m = psta->htpriv.sgi_40m;
 
 	switch (psta->bw_mode) {
-	case CHANNEL_WIDTH_80:
-		sgi = sgi_80m;
-		break;
 	case CHANNEL_WIDTH_40:
 		sgi = sgi_40m;
 		break;
diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
index 94d11689b4ac..56e657d2aaac 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -995,7 +995,6 @@ u8 PHY_GetTxPowerIndexBase(
 )
 {
 	struct hal_com_data *pHalData = GET_HAL_DATA(padapter);
-	u8 i = 0;	/* default set to 1S */
 	u8 txPower = 0;
 	u8 chnlIdx = (Channel-1);
 
@@ -1035,18 +1034,6 @@ u8 PHY_GetTxPowerIndexBase(
 				txPower += pHalData->BW40_24G_Diff[RFPath][TX_4S];
 
 		}
-		/*  Willis suggest adopt BW 40M power index while in BW 80 mode */
-		else if (BandWidth == CHANNEL_WIDTH_80) {
-			if ((MGN_MCS0 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT1SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
-				txPower += pHalData->BW40_24G_Diff[RFPath][TX_1S];
-			if ((MGN_MCS8 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT2SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
-				txPower += pHalData->BW40_24G_Diff[RFPath][TX_2S];
-			if ((MGN_MCS16 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT3SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
-				txPower += pHalData->BW40_24G_Diff[RFPath][TX_3S];
-			if ((MGN_MCS24 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT4SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
-				txPower += pHalData->BW40_24G_Diff[RFPath][TX_4S];
-
-		}
 	} else {/* 3 ============================== 5 G ============================== */
 		if (MGN_6M <= Rate)
 			txPower = pHalData->Index5G_BW40_Base[RFPath][chnlIdx];
@@ -1076,23 +1063,6 @@ u8 PHY_GetTxPowerIndexBase(
 			if ((MGN_MCS24 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT4SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
 				txPower += pHalData->BW40_5G_Diff[RFPath][TX_4S];
 
-		} else if (BandWidth == CHANNEL_WIDTH_80) { /*  BW80-1S, BW80-2S */
-			/*  <20121220, Kordan> Get the index of array "Index5G_BW80_Base". */
-			u8 channel5G_80M[CHANNEL_MAX_NUMBER_5G_80M] = {42, 58, 106, 122, 138, 155, 171};
-			for (i = 0; i < ARRAY_SIZE(channel5G_80M); ++i)
-				if (channel5G_80M[i] == Channel)
-					chnlIdx = i;
-
-			txPower = pHalData->Index5G_BW80_Base[RFPath][chnlIdx];
-
-			if ((MGN_MCS0 <= Rate && Rate <= MGN_MCS31)  || (MGN_VHT1SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
-				txPower += + pHalData->BW80_5G_Diff[RFPath][TX_1S];
-			if ((MGN_MCS8 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT2SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
-				txPower += pHalData->BW80_5G_Diff[RFPath][TX_2S];
-			if ((MGN_MCS16 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT3SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
-				txPower += pHalData->BW80_5G_Diff[RFPath][TX_3S];
-			if ((MGN_MCS23 <= Rate && Rate <= MGN_MCS31) || (MGN_VHT4SS_MCS0 <= Rate && Rate <= MGN_VHT4SS_MCS9))
-				txPower += pHalData->BW80_5G_Diff[RFPath][TX_4S];
 		}
 	}
 
@@ -1512,10 +1482,6 @@ static s16 get_bandwidth_idx(const enum channel_width bandwidth)
 		return 0;
 	case CHANNEL_WIDTH_40:
 		return 1;
-	case CHANNEL_WIDTH_80:
-		return 2;
-	case CHANNEL_WIDTH_160:
-		return 3;
 	default:
 		return -1;
 	}
diff --git a/drivers/staging/rtl8723bs/hal/odm.h b/drivers/staging/rtl8723bs/hal/odm.h
index 7e2d3679c7d0..a7a77fbb8390 100644
--- a/drivers/staging/rtl8723bs/hal/odm.h
+++ b/drivers/staging/rtl8723bs/hal/odm.h
@@ -471,9 +471,6 @@ enum { /* tag_Band_Type_Definition */
 enum { /* tag_Bandwidth_Definition */
 	ODM_BW20M		= 0,
 	ODM_BW40M		= 1,
-	ODM_BW80M		= 2,
-	ODM_BW160M		= 3,
-	ODM_BW10M		= 4,
 };
 
 /*  ODM_CMNINFO_BOARD_TYPE */
diff --git a/drivers/staging/rtl8723bs/hal/odm_DIG.c b/drivers/staging/rtl8723bs/hal/odm_DIG.c
index 702bb065636a..ef5b48bb01b2 100644
--- a/drivers/staging/rtl8723bs/hal/odm_DIG.c
+++ b/drivers/staging/rtl8723bs/hal/odm_DIG.c
@@ -230,8 +230,6 @@ void odm_Adaptivity(void *pDM_VOID, u8 IGI)
 		IGI_target = pDM_Odm->IGI_Base;
 	else if (*pDM_Odm->pBandWidth == ODM_BW40M)
 		IGI_target = pDM_Odm->IGI_Base + 2;
-	else if (*pDM_Odm->pBandWidth == ODM_BW80M)
-		IGI_target = pDM_Odm->IGI_Base + 2;
 	else
 		IGI_target = pDM_Odm->IGI_Base;
 	pDM_Odm->IGI_target = (u8) IGI_target;
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 6359cd661374..3ecd034342ec 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -2509,15 +2509,8 @@ u8 BWMapping_8723B(struct adapter *Adapter, struct pkt_attrib *pattrib)
 	u8 BWSettingOfDesc = 0;
 	struct hal_com_data *pHalData = GET_HAL_DATA(Adapter);
 
-	if (pHalData->CurrentChannelBW == CHANNEL_WIDTH_80) {
-		if (pattrib->bwmode == CHANNEL_WIDTH_80)
-			BWSettingOfDesc = 2;
-		else if (pattrib->bwmode == CHANNEL_WIDTH_40)
-			BWSettingOfDesc = 1;
-		else
-			BWSettingOfDesc = 0;
-	} else if (pHalData->CurrentChannelBW == CHANNEL_WIDTH_40) {
-		if ((pattrib->bwmode == CHANNEL_WIDTH_40) || (pattrib->bwmode == CHANNEL_WIDTH_80))
+	if (pHalData->CurrentChannelBW == CHANNEL_WIDTH_40) {
+		if (pattrib->bwmode == CHANNEL_WIDTH_40)
 			BWSettingOfDesc = 1;
 		else
 			BWSettingOfDesc = 0;
@@ -2535,25 +2528,7 @@ u8 SCMapping_8723B(struct adapter *Adapter, struct pkt_attrib *pattrib)
 	u8 SCSettingOfDesc = 0;
 	struct hal_com_data *pHalData = GET_HAL_DATA(Adapter);
 
-	if (pHalData->CurrentChannelBW == CHANNEL_WIDTH_80) {
-		if (pattrib->bwmode == CHANNEL_WIDTH_80) {
-			SCSettingOfDesc = VHT_DATA_SC_DONOT_CARE;
-		} else if (pattrib->bwmode == CHANNEL_WIDTH_40) {
-			if (pHalData->nCur80MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER)
-				SCSettingOfDesc = VHT_DATA_SC_40_LOWER_OF_80MHZ;
-			else if (pHalData->nCur80MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER)
-				SCSettingOfDesc = VHT_DATA_SC_40_UPPER_OF_80MHZ;
-		} else {
-			if ((pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER) && (pHalData->nCur80MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER))
-				SCSettingOfDesc = VHT_DATA_SC_20_LOWEST_OF_80MHZ;
-			else if ((pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER) && (pHalData->nCur80MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER))
-				SCSettingOfDesc = VHT_DATA_SC_20_LOWER_OF_80MHZ;
-			else if ((pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER) && (pHalData->nCur80MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER))
-				SCSettingOfDesc = VHT_DATA_SC_20_UPPER_OF_80MHZ;
-			else if ((pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER) && (pHalData->nCur80MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER))
-				SCSettingOfDesc = VHT_DATA_SC_20_UPPERST_OF_80MHZ;
-		}
-	} else if (pHalData->CurrentChannelBW == CHANNEL_WIDTH_40) {
+	if (pHalData->CurrentChannelBW == CHANNEL_WIDTH_40) {
 		if (pattrib->bwmode == CHANNEL_WIDTH_40) {
 			SCSettingOfDesc = VHT_DATA_SC_DONOT_CARE;
 		} else if (pattrib->bwmode == CHANNEL_WIDTH_20) {
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
index 3a2e3d0e88e8..275460865719 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
@@ -609,11 +609,6 @@ static void phy_SetRegBW_8723B(
 		rtw_write16(Adapter, REG_TRXPTCL_CTL_8723B, (u2tmp & 0xFEFF)); /*  BIT 7 = 1, BIT 8 = 0 */
 		break;
 
-	case CHANNEL_WIDTH_80:
-		u2tmp = RegRfMod_BW | BIT8;
-		rtw_write16(Adapter, REG_TRXPTCL_CTL_8723B, (u2tmp & 0xFF7F)); /*  BIT 7 = 0, BIT 8 = 1 */
-		break;
-
 	default:
 		break;
 	}
@@ -624,33 +619,7 @@ static u8 phy_GetSecondaryChnl_8723B(struct adapter *Adapter)
 	u8 SCSettingOf40 = 0, SCSettingOf20 = 0;
 	struct hal_com_data *pHalData = GET_HAL_DATA(Adapter);
 
-	if (pHalData->CurrentChannelBW == CHANNEL_WIDTH_80) {
-		if (pHalData->nCur80MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER)
-			SCSettingOf40 = VHT_DATA_SC_40_LOWER_OF_80MHZ;
-		else if (pHalData->nCur80MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER)
-			SCSettingOf40 = VHT_DATA_SC_40_UPPER_OF_80MHZ;
-
-		if (
-			(pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER) &&
-			(pHalData->nCur80MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER)
-		)
-			SCSettingOf20 = VHT_DATA_SC_20_LOWEST_OF_80MHZ;
-		else if (
-			(pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER) &&
-			(pHalData->nCur80MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER)
-		)
-			SCSettingOf20 = VHT_DATA_SC_20_LOWER_OF_80MHZ;
-		else if (
-			(pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER) &&
-			(pHalData->nCur80MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER)
-		)
-			SCSettingOf20 = VHT_DATA_SC_20_UPPER_OF_80MHZ;
-		else if (
-			(pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER) &&
-			(pHalData->nCur80MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER)
-		)
-			SCSettingOf20 = VHT_DATA_SC_20_UPPERST_OF_80MHZ;
-	} else if (pHalData->CurrentChannelBW == CHANNEL_WIDTH_40) {
+	if (pHalData->CurrentChannelBW == CHANNEL_WIDTH_40) {
 		if (pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER)
 			SCSettingOf20 = VHT_DATA_SC_20_UPPER_OF_80MHZ;
 		else if (pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER)
diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
index cc0dac355589..02df5bd8f575 100644
--- a/drivers/staging/rtl8723bs/include/drv_types.h
+++ b/drivers/staging/rtl8723bs/include/drv_types.h
@@ -108,9 +108,11 @@ struct registry_priv {
 	struct wlan_bssid_ex    dev_network;
 
 	u8 ht_enable;
-	/*  0: 20 MHz, 1: 40 MHz, 2: 80 MHz, 3: 160MHz */
-	/*  2.4G use bit 0 ~ 3, 5G use bit 4 ~ 7 */
-	/*  0x21 means enable 2.4G 40MHz & 5G 80MHz */
+	/*
+	 * 0: 20 MHz, 1: 40 MHz
+	 * 2.4G use bit 0 ~ 3
+	 * 0x01 means enable 2.4G 40MHz
+	 */
 	u8 bw_mode;
 	u8 ampdu_enable;/* for tx */
 	u8 rx_stbc;
diff --git a/drivers/staging/rtl8723bs/include/rtw_rf.h b/drivers/staging/rtl8723bs/include/rtw_rf.h
index cb6beccd3d23..98bc274e5e81 100644
--- a/drivers/staging/rtl8723bs/include/rtw_rf.h
+++ b/drivers/staging/rtl8723bs/include/rtw_rf.h
@@ -83,10 +83,6 @@ enum {
 enum channel_width {
 	CHANNEL_WIDTH_20 = 0,
 	CHANNEL_WIDTH_40 = 1,
-	CHANNEL_WIDTH_80 = 2,
-	CHANNEL_WIDTH_160 = 3,
-	CHANNEL_WIDTH_80_80 = 4,
-	CHANNEL_WIDTH_MAX = 5,
 };
 
 /*  Represent Extension Channel Offset in HT Capabilities */
diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 4e7c115c8bc1..a06c8b1beb01 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -65,10 +65,12 @@ static int rtw_uapsd_acvi_en;
 static int rtw_uapsd_acvo_en;
 
 int rtw_ht_enable = 1;
-/*  0: 20 MHz, 1: 40 MHz, 2: 80 MHz, 3: 160MHz, 4: 80+80MHz */
-/*  2.4G use bit 0 ~ 3, 5G use bit 4 ~ 7 */
-/*  0x21 means enable 2.4G 40MHz & 5G 80MHz */
-static int rtw_bw_mode = 0x21;
+/*
+ * 0: 20 MHz, 1: 40 MHz
+ * 2.4G use bit 0 ~ 3
+ * 0x01 means enable 2.4G 40MHz
+ */
+static int rtw_bw_mode = 0x01;
 static int rtw_ampdu_enable = 1;/* for enable tx_ampdu ,0: disable, 0x1:enable (but wifi_spec should be 0), 0x2: force enable (don't care wifi_spec) */
 static int rtw_rx_stbc = 1;/*  0: disable, 1:enable 2.4g */
 static int rtw_ampdu_amsdu;/*  0: disabled, 1:enabled, 2:auto . There is an IOT issu with DLINK DIR-629 when the flag turn on */
-- 
2.20.1

