Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D79F3870E8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 07:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346365AbhEREpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 00:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346364AbhEREpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 00:45:35 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93919C061756
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 21:44:16 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id h20so4402258plr.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 21:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pdUQZzXIz36ctJ/KQ7/qh97R6DqY7r5h4cwvHh56rPY=;
        b=CFBXnjURe7QzJkT2G4QPxri9FQ7ArtYZY41aGFihVjO4KjRZ7u1a64FkBBW7SEU9uD
         cIeA1PJk1x5Ylh9moLFVqYKnkA56Vbg3ixx1S2iUB/JV00sSO8246sXusWhgDg9i09Nd
         sb4CtZ4tvo2eJyfrRMxH4AdAZPBY3cNgNgY9W2AvBAu0I3IfbWpX2i0/PIriIQXbIODW
         YcaE39malXYg2wc0OXcD/vorrMN/4J2Z5yvsNO7CNV7WJ3HKYAHeAgIsmHDVmukFKTNy
         RG9UW6HMo8VlK01p/KzXz+jICHaBGj+IEMo14BPfpPphwnKi3HU3tgKPDXeOgxbVup4A
         uUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pdUQZzXIz36ctJ/KQ7/qh97R6DqY7r5h4cwvHh56rPY=;
        b=PyX11UUfa9YNGNokYQCiaZc/FJADB+Ca8jFg+Hk/1lvZaztvccxChaF85hAh62fB1E
         QNGaRW5EEpiSrzUpp3+jQp2d8L+NUMmGKncIRSrG84VoXpeeMKn1ao65/iZ/BsFeGCr8
         y343geskAWc7Rm9EzI8LZUmbYmbRPyowSscMLsrvXVuMNHg109O46d1VwkX/5Nhis7qj
         DxjhJUkxB0Zdd8K9WYjpVxGpfQP0hrU4dpXlbDGPScAlMudQYzakL5bKPt5sP5sc3T5Q
         onBLedzs2XrDEtqY5+JalQ43jk+/DEaoQh4SyuhUiAccaJUOTgpEfWjetbRqtoDD4dOO
         flMQ==
X-Gm-Message-State: AOAM532aRh2h6rszugaeg8GvTCmLBLsT25K5juluXjF97A2JZnIyq5U4
        N67X+1VELJvrmNuQvhsyWRI=
X-Google-Smtp-Source: ABdhPJzb17F0DE6arTXfOQCw+TXBOW6i1aPt/e4qiyFtW2stNK/4Y5SJ17djcWgD6fcApRKirhIP9A==
X-Received: by 2002:a17:90a:71c7:: with SMTP id m7mr3003696pjs.9.1621313056055;
        Mon, 17 May 2021 21:44:16 -0700 (PDT)
Received: from localhost.localdomain ([203.126.139.7])
        by smtp.gmail.com with ESMTPSA id t15sm357538pjh.0.2021.05.17.21.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 21:44:15 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     gregkh@linuxfoundation.org, marcocesati@gmail.com,
        dan.carpenter@oracle.com, fabioaiuto83@gmail.com,
        fmdefrancesco@gmail.com, eantoranz@gmail.com, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        skhan@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2 6/7] Staging: rtl8723bs: fix line continuations in HalBtc8723b1Ant.c
Date:   Tue, 18 May 2021 00:41:18 -0400
Message-Id: <20210518044119.2960494-7-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210518044119.2960494-1-desmondcheongzx@gmail.com>
References: <20210518044119.2960494-1-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to removing line continuations, the indentation of some
lines were fixed. This was done to avoid the introduction of new
warnings because removing the line continuations caused checkpatch.pl
to emit "CHECK: Alignment should match open parenthesis".

This commit fixes the following checkpatch.pl warnings:

WARNING: Avoid unnecessary line continuations
+		"\r\n %-35s = %d/ %d/ %d", "Ant PG Num/ Ant Mech/ Ant Pos:", \

WARNING: Avoid unnecessary line continuations
+		"\r\n %-35s = %s / %d", "BT stack/ hci ext ver", \

WARNING: Avoid unnecessary line continuations
+		"\r\n %-35s = %d_%x/ 0x%x/ 0x%x(%d)", "CoexVer/ FwVer/ PatchVer", \

WARNING: Avoid unnecessary line continuations
+		"\r\n %-35s = %d / %d(%d)", "Dot11 channel / HsChnl(HsMode)", \

WARNING: Avoid unnecessary line continuations
+		"\r\n %-35s = %02x %02x %02x ", "H2C Wifi inform bt chnl Info", \

WARNING: Avoid unnecessary line continuations
+		"\r\n %-35s = %d/ %d", "Wifi rssi/ HS rssi", \

WARNING: Avoid unnecessary line continuations
+		"\r\n %-35s = %d/ %d/ %d/ %s", "Wifi bLink/ bRoam/ bScan/ bHi-Pri", \

WARNING: Avoid unnecessary line continuations
+		"\r\n %-35s = %s / %s/ %s/ AP =%d/ %s ", "Wifi status", \

WARNING: Avoid unnecessary line continuations
+		"\r\n %-35s = %d/ %d/ %d/ %d/ %d", "sta/vwifi/hs/p2pGo/p2pGc", \

WARNING: Avoid unnecessary line continuations
+		"\r\n %-35s = [%s/ %d/ %d/ %d] ", "BT [status/ rssi/ retryCnt/ popCnt]", \

WARNING: Avoid unnecessary line continuations
+		"\r\n %-35s = %d / %d / %d / %d", "SCO/HID/PAN/A2DP", \

WARNING: Avoid unnecessary line continuations
+		CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = %s", "BT Role", \

WARNING: Avoid unnecessary line continuations
+		"\r\n %-35s = %s", "BT Info A2DP rate", \

WARNING: Avoid unnecessary line continuations
+				"\r\n %-35s = %02x %02x %02x %02x %02x %02x %02x(%d)", GLBtInfoSrc8723b1Ant[i], \

WARNING: Avoid unnecessary line continuations
+		"\r\n %-35s = %s/%s, (0x%x/0x%x)", "PS state, IPS/LPS, (lps/rpwm)", \

WARNING: Avoid unnecessary line continuations
+			"\r\n %-35s = %d", "SM[LowPenaltyRA]", \

WARNING: Avoid unnecessary line continuations
+			"\r\n %-35s = %s/ %s/ %d ", "DelBA/ BtCtrlAgg/ AggSize", \

WARNING: Avoid unnecessary line continuations
+			"\r\n %-35s = 0x%x ", "Rate Mask", \

WARNING: Avoid unnecessary line continuations
+		CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = %02x %02x %02x %02x %02x case-%d (auto:%d)", "PS TDMA", \

WARNING: Avoid unnecessary line continuations
+		CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = %d", "Coex Table Type", \

WARNING: Avoid unnecessary line continuations
+		CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = %d", "IgnWlanAct", \

WARNING: Avoid unnecessary line continuations
+	CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = 0x%x/0x%x/0x%x/0x%x", "backup ARFR1/ARFR2/RL/AMaxTime", \

WARNING: Avoid unnecessary line continuations
+	CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = 0x%x/0x%x/0x%x/0x%x", "0x430/0x434/0x42a/0x456", \

WARNING: Avoid unnecessary line continuations
+		"\r\n %-35s = 0x%x/ 0x%x/ 0x%x", "0x778/0x6cc/0x880[29:25]", \

WARNING: Avoid unnecessary line continuations
+		"\r\n %-35s = 0x%x/ 0x%x/ 0x%x/ 0x%x", "0x948/ 0x67[5] / 0x764 / 0x76e", \

WARNING: Avoid unnecessary line continuations
+		"\r\n %-35s = 0x%x/ 0x%x/ 0x%x", "0x92c[1:0]/ 0x930[7:0]/0x944[1:0]", \

WARNING: Avoid unnecessary line continuations
+		"\r\n %-35s = 0x%x/ 0x%x/ 0x%x/ 0x%x", "0x38[11]/0x40/0x4c[24:23]/0x64[0]", \

WARNING: Avoid unnecessary line continuations
+		"\r\n %-35s = 0x%x/ 0x%x", "0x550(bcn ctrl)/0x522", \

WARNING: Avoid unnecessary line continuations
+		"\r\n %-35s = 0x%x/ 0x%x", "0xc50(dig)/0x49c(null-drop)", \

WARNING: Avoid unnecessary line continuations
+		(u4Tmp[1] & 0xffff) +  (u4Tmp[2] & 0xffff) + \

WARNING: Avoid unnecessary line continuations
+		"\r\n %-35s = 0x%x/ 0x%x/ 0x%x", "OFDM-CCA/OFDM-FA/CCK-FA", \

WARNING: Avoid unnecessary line continuations
+		"\r\n %-35s = %d/ %d/ %d/ %d", "CRC_OK CCK/11g/11n/11n-Agg", \

WARNING: Avoid unnecessary line continuations
+		"\r\n %-35s = %d/ %d/ %d/ %d", "CRC_Err CCK/11g/11n/11n-Agg", \

WARNING: Avoid unnecessary line continuations
+		"\r\n %-35s = 0x%x/ 0x%x/ 0x%x", "0x6c0/0x6c4/0x6c8(coexTable)", \

WARNING: Avoid unnecessary line continuations
+		"\r\n %-35s = %d/ %d", "0x770(high-pri rx/tx)", \

WARNING: Avoid unnecessary line continuations
+		"\r\n %-35s = %d/ %d", "0x774(low-pri rx/tx)", \

Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
---
 .../staging/rtl8723bs/hal/HalBtc8723b1Ant.c   | 88 +++++++++----------
 1 file changed, 44 insertions(+), 44 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
index cf36a7de4735..cc7f558903ac 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
+++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
@@ -2273,7 +2273,7 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	CL_SPRINTF(
 		cliBuf,
 		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %d/ %d/ %d", "Ant PG Num/ Ant Mech/ Ant Pos:", \
+		"\r\n %-35s = %d/ %d/ %d", "Ant PG Num/ Ant Mech/ Ant Pos:",
 		pBoardInfo->pgAntNum,
 		pBoardInfo->btdmAntNum,
 		pBoardInfo->btdmAntPos
@@ -2283,7 +2283,7 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	CL_SPRINTF(
 		cliBuf,
 		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %s / %d", "BT stack/ hci ext ver", \
+		"\r\n %-35s = %s / %d", "BT stack/ hci ext ver",
 		((pStackInfo->bProfileNotified) ? "Yes" : "No"),
 		pStackInfo->hciVersion
 	);
@@ -2294,7 +2294,7 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	CL_SPRINTF(
 		cliBuf,
 		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %d_%x/ 0x%x/ 0x%x(%d)", "CoexVer/ FwVer/ PatchVer", \
+		"\r\n %-35s = %d_%x/ 0x%x/ 0x%x(%d)", "CoexVer/ FwVer/ PatchVer",
 		GLCoexVerDate8723b1Ant,
 		GLCoexVer8723b1Ant,
 		fwVer,
@@ -2309,7 +2309,7 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	CL_SPRINTF(
 		cliBuf,
 		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %d / %d(%d)", "Dot11 channel / HsChnl(HsMode)", \
+		"\r\n %-35s = %d / %d(%d)", "Dot11 channel / HsChnl(HsMode)",
 		wifiDot11Chnl,
 		wifiHsChnl,
 		bBtHsOn
@@ -2319,7 +2319,7 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	CL_SPRINTF(
 		cliBuf,
 		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %02x %02x %02x ", "H2C Wifi inform bt chnl Info", \
+		"\r\n %-35s = %02x %02x %02x ", "H2C Wifi inform bt chnl Info",
 		pCoexDm->wifiChnlInfo[0],
 		pCoexDm->wifiChnlInfo[1],
 		pCoexDm->wifiChnlInfo[2]
@@ -2331,7 +2331,7 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	CL_SPRINTF(
 		cliBuf,
 		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %d/ %d", "Wifi rssi/ HS rssi", \
+		"\r\n %-35s = %d/ %d", "Wifi rssi/ HS rssi",
 		wifiRssi - 100, btHsRssi - 100
 	);
 	CL_PRINTF(cliBuf);
@@ -2342,7 +2342,7 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	CL_SPRINTF(
 		cliBuf,
 		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %d/ %d/ %d/ %s", "Wifi bLink/ bRoam/ bScan/ bHi-Pri", \
+		"\r\n %-35s = %d/ %d/ %d/ %s", "Wifi bLink/ bRoam/ bScan/ bHi-Pri",
 		bLink, bRoam, bScan, ((pCoexSta->bWiFiIsHighPriTask) ? "1" : "0")
 	);
 	CL_PRINTF(cliBuf);
@@ -2360,7 +2360,7 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	CL_SPRINTF(
 		cliBuf,
 		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %s / %s/ %s/ AP =%d/ %s ", "Wifi status", \
+		"\r\n %-35s = %s / %s/ %s/ AP =%d/ %s ", "Wifi status",
 		(bWifiUnder5G ? "5G" : "2.4G"),
 		((bWifiUnderBMode) ? "11b" : ((wifiBw == BTC_WIFI_BW_LEGACY) ? "11bg" : (((wifiBw == BTC_WIFI_BW_HT40) ? "HT40" : "HT20")))),
 		((!bWifiBusy) ? "idle" : ((wifiTrafficDir == BTC_WIFI_TRAFFIC_TX) ? "uplink" : "downlink")),
@@ -2375,7 +2375,7 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	CL_SPRINTF(
 		cliBuf,
 		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %d/ %d/ %d/ %d/ %d", "sta/vwifi/hs/p2pGo/p2pGc", \
+		"\r\n %-35s = %d/ %d/ %d/ %d/ %d", "sta/vwifi/hs/p2pGo/p2pGc",
 		((wifiLinkStatus & WIFI_STA_CONNECTED) ? 1 : 0),
 		((wifiLinkStatus & WIFI_AP_CONNECTED) ? 1 : 0),
 		((wifiLinkStatus & WIFI_HS_CONNECTED) ? 1 : 0),
@@ -2389,7 +2389,7 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	CL_SPRINTF(
 		cliBuf,
 		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = [%s/ %d/ %d/ %d] ", "BT [status/ rssi/ retryCnt/ popCnt]", \
+		"\r\n %-35s = [%s/ %d/ %d/ %d] ", "BT [status/ rssi/ retryCnt/ popCnt]",
 		((pBtCoexist->btInfo.bBtDisabled) ? ("disabled") : ((pCoexSta->bC2hBtInquiryPage) ? ("inquiry/page scan") : ((pCoexDm->btStatus == BT_8723B_1ANT_BT_STATUS_NON_CONNECTED_IDLE) ? "non-connected idle" :
 																					((pCoexDm->btStatus == BT_8723B_1ANT_BT_STATUS_CONNECTED_IDLE) ? "connected-idle" : "busy")))),
 		pCoexSta->btRssi, pCoexSta->btRetryCnt, pCoexSta->popEventCnt
@@ -2405,7 +2405,7 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	CL_SPRINTF(
 		cliBuf,
 		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %d / %d / %d / %d", "SCO/HID/PAN/A2DP", \
+		"\r\n %-35s = %d / %d / %d / %d", "SCO/HID/PAN/A2DP",
 		pBtLinkInfo->bScoExist,
 		pBtLinkInfo->bHidExist,
 		pBtLinkInfo->bPanExist,
@@ -2416,8 +2416,8 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	if (pStackInfo->bProfileNotified) {
 		pBtCoexist->fBtcDispDbgMsg(pBtCoexist, BTC_DBG_DISP_BT_LINK_INFO);
 	} else {
-		CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = %s", "BT Role", \
-		(pBtLinkInfo->bSlaveRole) ? "Slave" : "Master");
+		CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = %s", "BT Role",
+			   (pBtLinkInfo->bSlaveRole) ? "Slave" : "Master");
 		CL_PRINTF(cliBuf);
 	}
 
@@ -2426,7 +2426,7 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	CL_SPRINTF(
 		cliBuf,
 		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %s", "BT Info A2DP rate", \
+		"\r\n %-35s = %s", "BT Info A2DP rate",
 		(btInfoExt & BIT0) ? "Basic rate" : "EDR rate"
 	);
 	CL_PRINTF(cliBuf);
@@ -2436,7 +2436,7 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 			CL_SPRINTF(
 				cliBuf,
 				BT_TMP_BUF_SIZE,
-				"\r\n %-35s = %02x %02x %02x %02x %02x %02x %02x(%d)", GLBtInfoSrc8723b1Ant[i], \
+				"\r\n %-35s = %02x %02x %02x %02x %02x %02x %02x(%d)", GLBtInfoSrc8723b1Ant[i],
 				pCoexSta->btInfoC2h[i][0], pCoexSta->btInfoC2h[i][1],
 				pCoexSta->btInfoC2h[i][2], pCoexSta->btInfoC2h[i][3],
 				pCoexSta->btInfoC2h[i][4], pCoexSta->btInfoC2h[i][5],
@@ -2448,7 +2448,7 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	CL_SPRINTF(
 		cliBuf,
 		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %s/%s, (0x%x/0x%x)", "PS state, IPS/LPS, (lps/rpwm)", \
+		"\r\n %-35s = %s/%s, (0x%x/0x%x)", "PS state, IPS/LPS, (lps/rpwm)",
 		(pCoexSta->bUnderIps ? "IPS ON" : "IPS OFF"),
 		(pCoexSta->bUnderLps ? "LPS ON" : "LPS OFF"),
 		pBtCoexist->btInfo.lpsVal,
@@ -2469,7 +2469,7 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 		CL_SPRINTF(
 			cliBuf,
 			BT_TMP_BUF_SIZE,
-			"\r\n %-35s = %d", "SM[LowPenaltyRA]", \
+			"\r\n %-35s = %d", "SM[LowPenaltyRA]",
 			pCoexDm->bCurLowPenaltyRa
 		);
 		CL_PRINTF(cliBuf);
@@ -2477,7 +2477,7 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 		CL_SPRINTF(
 			cliBuf,
 			BT_TMP_BUF_SIZE,
-			"\r\n %-35s = %s/ %s/ %d ", "DelBA/ BtCtrlAgg/ AggSize", \
+			"\r\n %-35s = %s/ %s/ %d ", "DelBA/ BtCtrlAgg/ AggSize",
 			(pBtCoexist->btInfo.bRejectAggPkt ? "Yes" : "No"),
 			(pBtCoexist->btInfo.bBtCtrlAggBufSize ? "Yes" : "No"),
 			pBtCoexist->btInfo.aggBufSize
@@ -2486,7 +2486,7 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 		CL_SPRINTF(
 			cliBuf,
 			BT_TMP_BUF_SIZE,
-			"\r\n %-35s = 0x%x ", "Rate Mask", \
+			"\r\n %-35s = 0x%x ", "Rate Mask",
 			pBtCoexist->btInfo.raMask
 		);
 		CL_PRINTF(cliBuf);
@@ -2496,18 +2496,18 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 		CL_PRINTF(cliBuf);
 
 		psTdmaCase = pCoexDm->curPsTdma;
-		CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = %02x %02x %02x %02x %02x case-%d (auto:%d)", "PS TDMA", \
-			pCoexDm->psTdmaPara[0], pCoexDm->psTdmaPara[1],
-			pCoexDm->psTdmaPara[2], pCoexDm->psTdmaPara[3],
-			pCoexDm->psTdmaPara[4], psTdmaCase, pCoexDm->bAutoTdmaAdjust);
+		CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = %02x %02x %02x %02x %02x case-%d (auto:%d)", "PS TDMA",
+			   pCoexDm->psTdmaPara[0], pCoexDm->psTdmaPara[1],
+			   pCoexDm->psTdmaPara[2], pCoexDm->psTdmaPara[3],
+			   pCoexDm->psTdmaPara[4], psTdmaCase, pCoexDm->bAutoTdmaAdjust);
 		CL_PRINTF(cliBuf);
 
-		CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = %d", "Coex Table Type", \
-			pCoexSta->nCoexTableType);
+		CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = %d", "Coex Table Type",
+			   pCoexSta->nCoexTableType);
 		CL_PRINTF(cliBuf);
 
-		CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = %d", "IgnWlanAct", \
-			pCoexDm->bCurIgnoreWlanAct);
+		CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = %d", "IgnWlanAct",
+			   pCoexDm->bCurIgnoreWlanAct);
 		CL_PRINTF(cliBuf);
 
 		/*
@@ -2521,16 +2521,16 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s", "============[Hw setting]============");
 	CL_PRINTF(cliBuf);
 
-	CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = 0x%x/0x%x/0x%x/0x%x", "backup ARFR1/ARFR2/RL/AMaxTime", \
-		pCoexDm->backupArfrCnt1, pCoexDm->backupArfrCnt2, pCoexDm->backupRetryLimit, pCoexDm->backupAmpduMaxTime);
+	CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = 0x%x/0x%x/0x%x/0x%x", "backup ARFR1/ARFR2/RL/AMaxTime",
+		   pCoexDm->backupArfrCnt1, pCoexDm->backupArfrCnt2, pCoexDm->backupRetryLimit, pCoexDm->backupAmpduMaxTime);
 	CL_PRINTF(cliBuf);
 
 	u4Tmp[0] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x430);
 	u4Tmp[1] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x434);
 	u2Tmp[0] = pBtCoexist->fBtcRead2Byte(pBtCoexist, 0x42a);
 	u1Tmp[0] = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x456);
-	CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = 0x%x/0x%x/0x%x/0x%x", "0x430/0x434/0x42a/0x456", \
-		u4Tmp[0], u4Tmp[1], u2Tmp[0], u1Tmp[0]);
+	CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = 0x%x/0x%x/0x%x/0x%x", "0x430/0x434/0x42a/0x456",
+		   u4Tmp[0], u4Tmp[1], u2Tmp[0], u1Tmp[0]);
 	CL_PRINTF(cliBuf);
 
 	u1Tmp[0] = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x778);
@@ -2538,7 +2538,7 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	u4Tmp[1] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x880);
 	CL_SPRINTF(
 		cliBuf, BT_TMP_BUF_SIZE,
-		"\r\n %-35s = 0x%x/ 0x%x/ 0x%x", "0x778/0x6cc/0x880[29:25]", \
+		"\r\n %-35s = 0x%x/ 0x%x/ 0x%x", "0x778/0x6cc/0x880[29:25]",
 		u1Tmp[0], u4Tmp[0],  (u4Tmp[1] & 0x3e000000) >> 25
 	);
 	CL_PRINTF(cliBuf);
@@ -2550,7 +2550,7 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	CL_SPRINTF(
 		cliBuf,
 		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = 0x%x/ 0x%x/ 0x%x/ 0x%x", "0x948/ 0x67[5] / 0x764 / 0x76e", \
+		"\r\n %-35s = 0x%x/ 0x%x/ 0x%x/ 0x%x", "0x948/ 0x67[5] / 0x764 / 0x76e",
 		u4Tmp[0], ((u1Tmp[0] & 0x20) >> 5), (u4Tmp[1] & 0xffff), u1Tmp[1]
 	);
 	CL_PRINTF(cliBuf);
@@ -2561,7 +2561,7 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	CL_SPRINTF(
 		cliBuf,
 		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = 0x%x/ 0x%x/ 0x%x", "0x92c[1:0]/ 0x930[7:0]/0x944[1:0]", \
+		"\r\n %-35s = 0x%x/ 0x%x/ 0x%x", "0x92c[1:0]/ 0x930[7:0]/0x944[1:0]",
 		u4Tmp[0] & 0x3, u4Tmp[1] & 0xff, u4Tmp[2] & 0x3
 	);
 	CL_PRINTF(cliBuf);
@@ -2573,7 +2573,7 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	CL_SPRINTF(
 		cliBuf,
 		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = 0x%x/ 0x%x/ 0x%x/ 0x%x", "0x38[11]/0x40/0x4c[24:23]/0x64[0]", \
+		"\r\n %-35s = 0x%x/ 0x%x/ 0x%x/ 0x%x", "0x38[11]/0x40/0x4c[24:23]/0x64[0]",
 		((u1Tmp[0] & 0x8) >> 3),
 		u1Tmp[1],
 		((u4Tmp[0] & 0x01800000) >> 23),
@@ -2586,7 +2586,7 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	CL_SPRINTF(
 		cliBuf,
 		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = 0x%x/ 0x%x", "0x550(bcn ctrl)/0x522", \
+		"\r\n %-35s = 0x%x/ 0x%x", "0x550(bcn ctrl)/0x522",
 		u4Tmp[0], u1Tmp[0]
 	);
 	CL_PRINTF(cliBuf);
@@ -2596,7 +2596,7 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	CL_SPRINTF(
 		cliBuf,
 		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = 0x%x/ 0x%x", "0xc50(dig)/0x49c(null-drop)", \
+		"\r\n %-35s = 0x%x/ 0x%x", "0xc50(dig)/0x49c(null-drop)",
 		u4Tmp[0] & 0xff, u1Tmp[0]
 	);
 	CL_PRINTF(cliBuf);
@@ -2612,14 +2612,14 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	faOfdm =
 		((u4Tmp[0] & 0xffff0000) >> 16) +
 		((u4Tmp[1] & 0xffff0000) >> 16) +
-		(u4Tmp[1] & 0xffff) +  (u4Tmp[2] & 0xffff) + \
+		(u4Tmp[1] & 0xffff) +  (u4Tmp[2] & 0xffff) +
 		((u4Tmp[3] & 0xffff0000) >> 16) + (u4Tmp[3] & 0xffff);
 	faCck = (u1Tmp[0] << 8) + u1Tmp[1];
 
 	CL_SPRINTF(
 		cliBuf,
 		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = 0x%x/ 0x%x/ 0x%x", "OFDM-CCA/OFDM-FA/CCK-FA", \
+		"\r\n %-35s = 0x%x/ 0x%x/ 0x%x", "OFDM-CCA/OFDM-FA/CCK-FA",
 		u4Tmp[0] & 0xffff, faOfdm, faCck
 	);
 	CL_PRINTF(cliBuf);
@@ -2628,7 +2628,7 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	CL_SPRINTF(
 		cliBuf,
 		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %d/ %d/ %d/ %d", "CRC_OK CCK/11g/11n/11n-Agg", \
+		"\r\n %-35s = %d/ %d/ %d/ %d", "CRC_OK CCK/11g/11n/11n-Agg",
 		pCoexSta->nCRCOK_CCK,
 		pCoexSta->nCRCOK_11g,
 		pCoexSta->nCRCOK_11n,
@@ -2639,7 +2639,7 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	CL_SPRINTF(
 		cliBuf,
 		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %d/ %d/ %d/ %d", "CRC_Err CCK/11g/11n/11n-Agg", \
+		"\r\n %-35s = %d/ %d/ %d/ %d", "CRC_Err CCK/11g/11n/11n-Agg",
 		pCoexSta->nCRCErr_CCK,
 		pCoexSta->nCRCErr_11g,
 		pCoexSta->nCRCErr_11n,
@@ -2653,21 +2653,21 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	CL_SPRINTF(
 		cliBuf,
 		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = 0x%x/ 0x%x/ 0x%x", "0x6c0/0x6c4/0x6c8(coexTable)", \
+		"\r\n %-35s = 0x%x/ 0x%x/ 0x%x", "0x6c0/0x6c4/0x6c8(coexTable)",
 		u4Tmp[0], u4Tmp[1], u4Tmp[2]);
 	CL_PRINTF(cliBuf);
 
 	CL_SPRINTF(
 		cliBuf,
 		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %d/ %d", "0x770(high-pri rx/tx)", \
+		"\r\n %-35s = %d/ %d", "0x770(high-pri rx/tx)",
 		pCoexSta->highPriorityRx, pCoexSta->highPriorityTx
 	);
 	CL_PRINTF(cliBuf);
 	CL_SPRINTF(
 		cliBuf,
 		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %d/ %d", "0x774(low-pri rx/tx)", \
+		"\r\n %-35s = %d/ %d", "0x774(low-pri rx/tx)",
 		pCoexSta->lowPriorityRx, pCoexSta->lowPriorityTx
 	);
 	CL_PRINTF(cliBuf);
-- 
2.25.1

