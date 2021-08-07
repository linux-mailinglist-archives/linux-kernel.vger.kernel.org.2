Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 325AC3E346E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 11:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbhHGJsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 05:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbhHGJsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 05:48:38 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB05C0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 02:48:20 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id i10-20020a05600c354ab029025a0f317abfso10633035wmq.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 02:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=djf2N9fMwhvWHMz/rE0qi3LyJyiiJWuoJzGM1DvQmBo=;
        b=kxMxaaqRi2S8sdWwbMhwFcSph0gYbKJZI/hRQOU+yXyTkFdmz69hsTcZjy9neqdMlA
         Kq5cfT1rO8DGLh8107kdHcNNGPpQp3LIotcZmuHP86CWf3xAt7vxK9evFCpv6YQH7s6o
         IjJ2YJAT4vPrODu1KfIiPFHU8jZjmqGNrwRT4zPdk5qHKjQZ6bY7IQZ+jbXwKQauuyuH
         yRwbvUBBR8jnq/DefXrCdW/OHnOkhreIb4TvHx4mqPoRRzdOlFTYvHPtodtn/ggzCmeZ
         YgHYDQwifXatkEhW6KtxuMgKTjjgNceonHclHnZu/heL0/8ZgyvvAmrgm+klYzuGQdK4
         yvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=djf2N9fMwhvWHMz/rE0qi3LyJyiiJWuoJzGM1DvQmBo=;
        b=ubrEfMMTb/WeEpJcaZ5beY15xChqnAClo5xKZuqoERQ71WR8gk5LoLO3mQtcc0auZd
         5LfMeyTisGCUxnQAIyuX9e1ClomY0Ph69k3+l/9s4WHMVGoP+DOferId2YiEIU6W346D
         X94ENkHEKTccoxkZSXnTVyC4Ge1Y2Emjh8CVdvsnxH+VGqr2oNiJKt7y0vmj6DQkth27
         j3LEDCtVQZPujz7FEK+f1JmhkLXmXyilQyX/SAC6BaAY2ttFfCEfHK4QiLsubd1UWo6t
         qY/oi7zpqoEtUEY1m/tXXSi0L12JloZah6mCBio0WSMIYHOpe6wLCB58YnAGy5ZeQV7a
         j1Nw==
X-Gm-Message-State: AOAM530pRu1JHKmCzTpHbqP5BJ9Hy56v3lMtX7fTQlbgISxepgy3rQUG
        /x9BRczyWcA4jqroT7yop90ekBbpk0Q=
X-Google-Smtp-Source: ABdhPJyq7QDwNC7tQxjOFzHob979HTNlO5O6r8n0SQqLkKTwOjL21l4S7nxluuo5udA+A+qJ5huEog==
X-Received: by 2002:a05:600c:4f15:: with SMTP id l21mr7107907wmq.171.1628329699168;
        Sat, 07 Aug 2021 02:48:19 -0700 (PDT)
Received: from agape ([5.171.80.112])
        by smtp.gmail.com with ESMTPSA id n5sm10899274wme.47.2021.08.07.02.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 02:48:19 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 03/21] staging: rtl8723bs: do some code cleaning in modified function
Date:   Sat,  7 Aug 2021 11:47:55 +0200
Message-Id: <2bddef34cebdf35666d8abec4462c1a8d30c8c60.1628329348.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1628329348.git.fabioaiuto83@gmail.com>
References: <cover.1628329348.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do some code cleaning after changes of previous commit.
Fixed comments, camel case names, variable naming conventions;
kept function names without chip series numbers (this is
just code for 8723), fixed indentations, blank lines and
other minor stuff.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 .../staging/rtl8723bs/hal/odm_CfoTracking.c   |  26 +-
 .../staging/rtl8723bs/hal/odm_CfoTracking.h   |   2 +-
 drivers/staging/rtl8723bs/hal/odm_HWConfig.c  | 229 +++++++++---------
 drivers/staging/rtl8723bs/hal/odm_HWConfig.h  |   2 +-
 drivers/staging/rtl8723bs/hal/odm_RTL8723B.c  |  12 +-
 drivers/staging/rtl8723bs/hal/odm_RTL8723B.h  |   2 +-
 6 files changed, 139 insertions(+), 134 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c b/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c
index 0f6b9d661e39..a99d567468b2 100644
--- a/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c
+++ b/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c
@@ -188,26 +188,28 @@ void ODM_CfoTracking(void *pDM_VOID)
 	}
 }
 
-void ODM_ParsingCFO(void *pDM_VOID, void *pPktinfo_VOID, s8 *pcfotail)
+void odm_parsing_cfo(void *dm_void, void *pkt_info_void, s8 *cfotail)
 {
-	struct dm_odm_t *pDM_Odm = (struct dm_odm_t *)pDM_VOID;
-	struct odm_packet_info *pPktinfo = pPktinfo_VOID;
-	struct cfo_tracking *pCfoTrack = &pDM_Odm->DM_CfoTrack;
+	struct dm_odm_t *dm_odm = (struct dm_odm_t *)dm_void;
+	struct odm_packet_info *pkt_info = pkt_info_void;
+	struct cfo_tracking *cfo_track = &dm_odm->DM_CfoTrack;
 	u8 i;
 
-	if (!(pDM_Odm->SupportAbility & ODM_BB_CFO_TRACKING))
+	if (!(dm_odm->SupportAbility & ODM_BB_CFO_TRACKING))
 		return;
 
-	if (pPktinfo->station_id != 0) {
-		/* 3 Update CFO report for path-A & path-B */
-		/*  Only paht-A and path-B have CFO tail and short CFO */
+	if (pkt_info->station_id != 0) {
+		/*
+		 * 3 Update CFO report for path-A & path-B
+		 * Only paht-A and path-B have CFO tail and short CFO
+		 */
 		for (i = ODM_RF_PATH_A; i <= ODM_RF_PATH_B; i++)
-			pCfoTrack->CFO_tail[i] = (int)pcfotail[i];
+			cfo_track->CFO_tail[i] = (int)cfotail[i];
 
 		/* 3 Update packet counter */
-		if (pCfoTrack->packetCount == 0xffffffff)
-			pCfoTrack->packetCount = 0;
+		if (cfo_track->packetCount == 0xffffffff)
+			cfo_track->packetCount = 0;
 		else
-			pCfoTrack->packetCount++;
+			cfo_track->packetCount++;
 	}
 }
diff --git a/drivers/staging/rtl8723bs/hal/odm_CfoTracking.h b/drivers/staging/rtl8723bs/hal/odm_CfoTracking.h
index bb00d8c893bd..8fa6d9ec5880 100644
--- a/drivers/staging/rtl8723bs/hal/odm_CfoTracking.h
+++ b/drivers/staging/rtl8723bs/hal/odm_CfoTracking.h
@@ -34,6 +34,6 @@ void ODM_CfoTrackingInit(void *pDM_VOID);
 
 void ODM_CfoTracking(void *pDM_VOID);
 
-void ODM_ParsingCFO(void *pDM_VOID, void *pPktinfo_VOID, s8 *pcfotail);
+void odm_parsing_cfo(void *pDM_VOID, void *pPktinfo_VOID, s8 *pcfotail);
 
 #endif
diff --git a/drivers/staging/rtl8723bs/hal/odm_HWConfig.c b/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
index af4d5ab1b382..6d7b34fd595e 100644
--- a/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
+++ b/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
@@ -10,51 +10,51 @@
 #define READ_AND_CONFIG_MP(ic, txt) (ODM_ReadAndConfig_MP_##ic##txt(pDM_Odm))
 #define READ_AND_CONFIG     READ_AND_CONFIG_MP
 
-static u8 odm_QueryRxPwrPercentage(s8 AntPower)
+static u8 odm_query_rx_pwr_percentage(s8 ant_power)
 {
-	if ((AntPower <= -100) || (AntPower >= 20))
+	if ((ant_power <= -100) || (ant_power >= 20))
 		return	0;
-	else if (AntPower >= 0)
+	else if (ant_power >= 0)
 		return	100;
 	else
-		return 100 + AntPower;
+		return 100 + ant_power;
 
 }
 
-s32 odm_SignalScaleMapping(struct dm_odm_t *pDM_Odm, s32 CurrSig)
+s32 odm_signal_scale_mapping(struct dm_odm_t *dm_odm, s32 curr_sig)
 {
-	s32 RetSig = 0;
-
-	if (pDM_Odm->SupportInterface  == ODM_ITRF_SDIO) {
-		if (CurrSig >= 51 && CurrSig <= 100)
-			RetSig = 100;
-		else if (CurrSig >= 41 && CurrSig <= 50)
-			RetSig = 80 + ((CurrSig - 40)*2);
-		else if (CurrSig >= 31 && CurrSig <= 40)
-			RetSig = 66 + (CurrSig - 30);
-		else if (CurrSig >= 21 && CurrSig <= 30)
-			RetSig = 54 + (CurrSig - 20);
-		else if (CurrSig >= 10 && CurrSig <= 20)
-			RetSig = 42 + (((CurrSig - 10) * 2) / 3);
-		else if (CurrSig >= 5 && CurrSig <= 9)
-			RetSig = 22 + (((CurrSig - 5) * 3) / 2);
-		else if (CurrSig >= 1 && CurrSig <= 4)
-			RetSig = 6 + (((CurrSig - 1) * 3) / 2);
+	s32 ret_sig = 0;
+
+	if (dm_odm->SupportInterface  == ODM_ITRF_SDIO) {
+		if (curr_sig >= 51 && curr_sig <= 100)
+			ret_sig = 100;
+		else if (curr_sig >= 41 && curr_sig <= 50)
+			ret_sig = 80 + ((curr_sig - 40)*2);
+		else if (curr_sig >= 31 && curr_sig <= 40)
+			ret_sig = 66 + (curr_sig - 30);
+		else if (curr_sig >= 21 && curr_sig <= 30)
+			ret_sig = 54 + (curr_sig - 20);
+		else if (curr_sig >= 10 && curr_sig <= 20)
+			ret_sig = 42 + (((curr_sig - 10) * 2) / 3);
+		else if (curr_sig >= 5 && curr_sig <= 9)
+			ret_sig = 22 + (((curr_sig - 5) * 3) / 2);
+		else if (curr_sig >= 1 && curr_sig <= 4)
+			ret_sig = 6 + (((curr_sig - 1) * 3) / 2);
 		else
-			RetSig = CurrSig;
+			ret_sig = curr_sig;
 	}
 
-	return RetSig;
+	return ret_sig;
 }
 
-static u8 odm_EVMdbToPercentage(s8 Value)
+static u8 odm_evm_db_to_percentage(s8 value)
 {
 	/*  */
 	/*  -33dB~0dB to 0%~99% */
 	/*  */
 	s8 ret_val;
 
-	ret_val = Value;
+	ret_val = value;
 	ret_val /= 2;
 
 	if (ret_val >= 0)
@@ -71,116 +71,116 @@ static u8 odm_EVMdbToPercentage(s8 Value)
 	return ret_val;
 }
 
-static void odm_RxPhyStatus92CSeries_Parsing(
-	struct dm_odm_t *pDM_Odm,
-	struct odm_phy_info *pPhyInfo,
-	u8 *pPhyStatus,
-	struct odm_packet_info *pPktinfo
-)
+static void odm_rx_phy_status_parsing(struct dm_odm_t *dm_odm,
+				      struct odm_phy_info *phy_info,
+				      u8 *phy_status,
+				      struct odm_packet_info *pkt_info)
 {
 	u8 i;
 	s8 rx_pwr[4], rx_pwr_all = 0;
-	u8 EVM, PWDB_ALL = 0, PWDB_ALL_BT;
-	u8 RSSI, total_rssi = 0;
-	bool isCCKrate = false;
+	u8 evm, pwdb_all = 0, pwdb_all_bt;
+	u8 rssi, total_rssi = 0;
+	bool is_cck_rate = false;
 	u8 rf_rx_num = 0;
-	u8 LNA_idx, VGA_idx;
-	struct phy_status_rpt_8192cd_t *pPhyStaRpt = (struct phy_status_rpt_8192cd_t *)pPhyStatus;
+	u8 lna_idx, vga_idx;
+	struct phy_status_rpt_8192cd_t *phy_sta_rpt = (struct phy_status_rpt_8192cd_t *)phy_status;
 
-	isCCKrate = pPktinfo->data_rate <= DESC_RATE11M;
-	pPhyInfo->rx_mimo_signal_quality[ODM_RF_PATH_A] = -1;
-	pPhyInfo->rx_mimo_signal_quality[ODM_RF_PATH_B] = -1;
+	is_cck_rate = pkt_info->data_rate <= DESC_RATE11M;
+	phy_info->rx_mimo_signal_quality[ODM_RF_PATH_A] = -1;
+	phy_info->rx_mimo_signal_quality[ODM_RF_PATH_B] = -1;
 
 
-	if (isCCKrate) {
+	if (is_cck_rate) {
 		u8 cck_agc_rpt;
 
-		pDM_Odm->PhyDbgInfo.NumQryPhyStatusCCK++;
-		/*  */
-		/*  (1)Hardware does not provide RSSI for CCK */
-		/*  (2)PWDB, Average PWDB calculated by hardware (for rate adaptive) */
-		/*  */
-
-		cck_agc_rpt = pPhyStaRpt->cck_agc_rpt_ofdm_cfosho_a;
-
-		/* 2011.11.28 LukeLee: 88E use different LNA & VGA gain table */
-		/* The RSSI formula should be modified according to the gain table */
-		LNA_idx = ((cck_agc_rpt & 0xE0)>>5);
-		VGA_idx = (cck_agc_rpt & 0x1F);
-		rx_pwr_all = odm_CCKRSSI_8723B(LNA_idx, VGA_idx);
-		PWDB_ALL = odm_QueryRxPwrPercentage(rx_pwr_all);
-		if (PWDB_ALL > 100)
-			PWDB_ALL = 100;
-
-		pPhyInfo->rx_pwd_ba11 = PWDB_ALL;
-		pPhyInfo->bt_rx_rssi_percentage = PWDB_ALL;
-		pPhyInfo->recv_signal_power = rx_pwr_all;
-		/*  */
+		dm_odm->PhyDbgInfo.NumQryPhyStatusCCK++;
+
+		/*
+		 * (1)Hardware does not provide RSSI for CCK/
+		 * (2)PWDB, Average PWDB calculated by
+		 *    hardware (for rate adaptive)
+		 */
+
+		cck_agc_rpt = phy_sta_rpt->cck_agc_rpt_ofdm_cfosho_a;
+
+		/*
+		 * 2011.11.28 LukeLee: 88E use different LNA & VGA gain table
+		 * The RSSI formula should be modified according to the gain table
+		 */
+		lna_idx = ((cck_agc_rpt & 0xE0)>>5);
+		vga_idx = (cck_agc_rpt & 0x1F);
+		rx_pwr_all = odm_cck_rssi(lna_idx, vga_idx);
+		pwdb_all = odm_query_rx_pwr_percentage(rx_pwr_all);
+		if (pwdb_all > 100)
+			pwdb_all = 100;
+
+		phy_info->rx_pwd_ba11 = pwdb_all;
+		phy_info->bt_rx_rssi_percentage = pwdb_all;
+		phy_info->recv_signal_power = rx_pwr_all;
+
 		/*  (3) Get Signal Quality (EVM) */
-		/*  */
+
 		/* if (pPktinfo->bPacketMatchBSSID) */
 		{
-			u8 SQ, SQ_rpt;
+			u8 sq, sq_rpt;
 
-			if (pPhyInfo->rx_pwd_ba11 > 40 && !pDM_Odm->bInHctTest)
-				SQ = 100;
+			if (phy_info->rx_pwd_ba11 > 40 && !dm_odm->bInHctTest)
+				sq = 100;
 			else {
-				SQ_rpt = pPhyStaRpt->cck_sig_qual_ofdm_pwdb_all;
+				sq_rpt = phy_sta_rpt->cck_sig_qual_ofdm_pwdb_all;
 
-				if (SQ_rpt > 64)
-					SQ = 0;
-				else if (SQ_rpt < 20)
-					SQ = 100;
+				if (sq_rpt > 64)
+					sq = 0;
+				else if (sq_rpt < 20)
+					sq = 100;
 				else
-					SQ = ((64-SQ_rpt) * 100) / 44;
+					sq = ((64-sq_rpt) * 100) / 44;
 
 			}
 
-			pPhyInfo->signal_quality = SQ;
-			pPhyInfo->rx_mimo_signal_quality[ODM_RF_PATH_A] = SQ;
-			pPhyInfo->rx_mimo_signal_quality[ODM_RF_PATH_B] = -1;
+			phy_info->signal_quality = sq;
+			phy_info->rx_mimo_signal_quality[ODM_RF_PATH_A] = sq;
+			phy_info->rx_mimo_signal_quality[ODM_RF_PATH_B] = -1;
 		}
 	} else { /* is OFDM rate */
-		pDM_Odm->PhyDbgInfo.NumQryPhyStatusOFDM++;
+		dm_odm->PhyDbgInfo.NumQryPhyStatusOFDM++;
 
-		/*  */
-		/*  (1)Get RSSI for HT rate */
-		/*  */
+		/*
+		 * (1)Get RSSI for HT rate
+		 */
 
 		for (i = ODM_RF_PATH_A; i < ODM_RF_PATH_MAX; i++) {
 			/*  2008/01/30 MH we will judge RF RX path now. */
-			if (pDM_Odm->RFPathRxEnable & BIT(i))
+			if (dm_odm->RFPathRxEnable & BIT(i))
 				rf_rx_num++;
 			/* else */
 				/* continue; */
 
-			rx_pwr[i] = ((pPhyStaRpt->path_agc[i].gain&0x3F)*2) - 110;
-
+			rx_pwr[i] = ((phy_sta_rpt->path_agc[i].gain & 0x3F) * 2) - 110;
 
-			pPhyInfo->rx_pwr[i] = rx_pwr[i];
+			phy_info->rx_pwr[i] = rx_pwr[i];
 
 			/* Translate DBM to percentage. */
-			RSSI = odm_QueryRxPwrPercentage(rx_pwr[i]);
-			total_rssi += RSSI;
+			rssi = odm_query_rx_pwr_percentage(rx_pwr[i]);
+			total_rssi += rssi;
 
-			pPhyInfo->rx_mimo_signal_strength[i] = (u8) RSSI;
+			phy_info->rx_mimo_signal_strength[i] = (u8)rssi;
 
 			/* Get Rx snr value in DB */
-			pPhyInfo->rx_snr[i] = pDM_Odm->PhyDbgInfo.RxSNRdB[i] = (s32)(pPhyStaRpt->path_rxsnr[i]/2);
+			phy_info->rx_snr[i] = dm_odm->PhyDbgInfo.RxSNRdB[i] = (s32)(phy_sta_rpt->path_rxsnr[i]/2);
 		}
 
+		/*
+		 * (2)PWDB, Average PWDB calculated by hardware (for rate adaptive)
+		 */
+		rx_pwr_all = ((phy_sta_rpt->cck_sig_qual_ofdm_pwdb_all >> 1) & 0x7f) - 110;
 
-		/*  */
-		/*  (2)PWDB, Average PWDB calculated by hardware (for rate adaptive) */
-		/*  */
-		rx_pwr_all = (((pPhyStaRpt->cck_sig_qual_ofdm_pwdb_all) >> 1)&0x7f)-110;
-
-		PWDB_ALL_BT = PWDB_ALL = odm_QueryRxPwrPercentage(rx_pwr_all);
+		pwdb_all_bt = pwdb_all = odm_query_rx_pwr_percentage(rx_pwr_all);
 
-		pPhyInfo->rx_pwd_ba11 = PWDB_ALL;
-		pPhyInfo->bt_rx_rssi_percentage = PWDB_ALL_BT;
-		pPhyInfo->rx_power = rx_pwr_all;
-		pPhyInfo->recv_signal_power = rx_pwr_all;
+		phy_info->rx_pwd_ba11 = pwdb_all;
+		phy_info->bt_rx_rssi_percentage = pwdb_all_bt;
+		phy_info->rx_power = rx_pwr_all;
+		phy_info->recv_signal_power = rx_pwr_all;
 
 		/*
 		 * (3)EVM of HT rate
@@ -195,23 +195,26 @@ static void odm_RxPhyStatus92CSeries_Parsing(
 		 * is supposed to be negative) is not correct
 		 * anymore.
 		 */
-		EVM = odm_EVMdbToPercentage(pPhyStaRpt->stream_rxevm[0]);	/* dbm */
+		evm = odm_evm_db_to_percentage(phy_sta_rpt->stream_rxevm[0]); /* dbm */
 
 		/*  Fill value in RFD, Get the first spatial stream only */
-		pPhyInfo->signal_quality = (u8)(EVM & 0xff);
+		phy_info->signal_quality = (u8)(evm & 0xff);
 
-		pPhyInfo->rx_mimo_signal_quality[ODM_RF_PATH_A] = (u8)(EVM & 0xff);
+		phy_info->rx_mimo_signal_quality[ODM_RF_PATH_A] = (u8)(evm & 0xff);
 
-		ODM_ParsingCFO(pDM_Odm, pPktinfo, pPhyStaRpt->path_cfotail);
+		odm_parsing_cfo(dm_odm, pkt_info, phy_sta_rpt->path_cfotail);
 	}
 
-	/* UI BSS List signal strength(in percentage), make it good looking, from 0~100. */
-	/* It is assigned to the BSS List in GetValueFromBeaconOrProbeRsp(). */
-	if (isCCKrate) {
-		pPhyInfo->signal_strength = (u8)(odm_SignalScaleMapping(pDM_Odm, PWDB_ALL));/* PWDB_ALL; */
+	/*
+	 * UI BSS List signal strength(in percentage), make it good
+	 * looking, from 0~100.
+	 * It is assigned to the BSS List in GetValueFromBeaconOrProbeRsp().
+	 */
+	if (is_cck_rate) {
+		phy_info->signal_strength = (u8)(odm_signal_scale_mapping(dm_odm, pwdb_all));
 	} else {
 		if (rf_rx_num != 0) {
-			pPhyInfo->signal_strength = (u8)(odm_SignalScaleMapping(pDM_Odm, total_rssi /= rf_rx_num));
+			phy_info->signal_strength = (u8)(odm_signal_scale_mapping(dm_odm, total_rssi /= rf_rx_num));
 		}
 	}
 }
@@ -364,17 +367,17 @@ static void odm_Process_RSSIForDM(
 /*  Endianness before calling this API */
 /*  */
 static void ODM_PhyStatusQuery_92CSeries(
-	struct dm_odm_t *pDM_Odm,
-	struct odm_phy_info *pPhyInfo,
-	u8 *pPhyStatus,
-	struct odm_packet_info *pPktinfo
+	struct dm_odm_t *dm_odm,
+	struct odm_phy_info *phy_info,
+	u8 *phy_status,
+	struct odm_packet_info *pkt_info
 )
 {
 
-	odm_RxPhyStatus92CSeries_Parsing(pDM_Odm, pPhyInfo, pPhyStatus, pPktinfo);
+	odm_rx_phy_status_parsing(dm_odm, phy_info, phy_status, pkt_info);
 
-	if (!pDM_Odm->RSSI_test)
-		odm_Process_RSSIForDM(pDM_Odm, pPhyInfo, pPktinfo);
+	if (!dm_odm->RSSI_test)
+		odm_Process_RSSIForDM(dm_odm, phy_info, pkt_info);
 }
 
 void ODM_PhyStatusQuery(
diff --git a/drivers/staging/rtl8723bs/hal/odm_HWConfig.h b/drivers/staging/rtl8723bs/hal/odm_HWConfig.h
index 574f9cfe8190..c0dbf5cc8ed4 100644
--- a/drivers/staging/rtl8723bs/hal/odm_HWConfig.h
+++ b/drivers/staging/rtl8723bs/hal/odm_HWConfig.h
@@ -102,6 +102,6 @@ enum hal_status ODM_ConfigFWWithHeaderFile(
 	u32 *pSize
 );
 
-s32 odm_SignalScaleMapping(struct dm_odm_t *pDM_Odm, s32 CurrSig);
+s32 odm_signal_scale_mapping(struct dm_odm_t *pDM_Odm, s32 CurrSig);
 
 #endif
diff --git a/drivers/staging/rtl8723bs/hal/odm_RTL8723B.c b/drivers/staging/rtl8723bs/hal/odm_RTL8723B.c
index 54518ea1be6b..325f2a7ae337 100644
--- a/drivers/staging/rtl8723bs/hal/odm_RTL8723B.c
+++ b/drivers/staging/rtl8723bs/hal/odm_RTL8723B.c
@@ -7,25 +7,25 @@
 
 #include "odm_precomp.h"
 
-s8 odm_CCKRSSI_8723B(u8 LNA_idx, u8 VGA_idx)
+s8 odm_cck_rssi(u8 lna_idx, u8 vga_idx)
 {
 	s8 rx_pwr_all = 0x00;
 
-	switch (LNA_idx) {
+	switch (lna_idx) {
 	/* 46  53 73 95 201301231630 */
 	/*  46 53 77 99 201301241630 */
 
 	case 6:
-		rx_pwr_all = -34 - (2 * VGA_idx);
+		rx_pwr_all = -34 - (2 * vga_idx);
 		break;
 	case 4:
-		rx_pwr_all = -14 - (2 * VGA_idx);
+		rx_pwr_all = -14 - (2 * vga_idx);
 		break;
 	case 1:
-		rx_pwr_all = 6 - (2 * VGA_idx);
+		rx_pwr_all = 6 - (2 * vga_idx);
 		break;
 	case 0:
-		rx_pwr_all = 16 - (2 * VGA_idx);
+		rx_pwr_all = 16 - (2 * vga_idx);
 		break;
 	default:
 		/* rx_pwr_all = -53+(2*(31-VGA_idx)); */
diff --git a/drivers/staging/rtl8723bs/hal/odm_RTL8723B.h b/drivers/staging/rtl8723bs/hal/odm_RTL8723B.h
index 96ef1cc41a96..752f180ebd46 100644
--- a/drivers/staging/rtl8723bs/hal/odm_RTL8723B.h
+++ b/drivers/staging/rtl8723bs/hal/odm_RTL8723B.h
@@ -9,6 +9,6 @@
 
 #define	DM_DIG_MIN_NIC_8723	0x1C
 
-s8 odm_CCKRSSI_8723B(u8 LNA_idx, u8 VGA_idx);
+s8 odm_cck_rssi(u8 LNA_idx, u8 VGA_idx);
 
 #endif
-- 
2.20.1

