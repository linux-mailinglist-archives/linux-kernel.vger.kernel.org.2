Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73549355864
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 17:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345943AbhDFPqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 11:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345793AbhDFPqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:46:49 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69F4C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 08:46:40 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id w3so22716965ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 08:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8HFwoHuoglm1mtfe2pgkTFjqm3d2nSn+JHu5o0wr3aM=;
        b=E4kqJ89Qp0CSQr3cZdQE61CCSXyCGyqq7hoiqaGR27fOT8VodnMEX4IizjGnosGd/K
         2MiGV+DT73yEbq9iQ0g04l1HVgbXsTwBhNJLGb9aiDfu4GyEXfTelwb2WGbiw/VpR/C5
         01yW0mWDO7QSn45CZyv44f8Hd2igeVkcCf5ROmaffs9EkiLqnGrn1CzuggmOmggdv47/
         ZvJiLMzwr6R/qMfFwYMZWVzQyFIoUxvf0zfiivEObTHWV6HflakZOjA3xsDK7hfzmSVP
         DgL3R4NNfBohSrspYXbv7SNdKoz01PExJdWb2LTqZ+EUJmVV2jA+YvhztokWZ5g9kmi4
         YVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8HFwoHuoglm1mtfe2pgkTFjqm3d2nSn+JHu5o0wr3aM=;
        b=AAtmq7me+x8S0nOOC7gKSlqzNAwSzgxv5X7CSkPHJ1QvQ9uR8To6lVfdMUwSpaGGpM
         iS09jPfhp0pbNsS0YnD6QYWYI9dm6FrP65To8kHOzv6ZCHLK0xZylTZm6+4DbVbMwWjX
         ERaJ56pCH9alq6ZA+qLaf5ipLQ/piq5khjWqbT+jXegZrf4RFi161MHuCGOCglOY2mNv
         yUll2ROo186E1xNlYdiqToeL2u8igzjeBsqajjgKYSprPrfPLgyUFFx7K1p8c1e4tmbb
         MY+7MvsZaS0X9kaxhS76xTbpplV/juaTSuM2jteIu6T2OG609AmNwBPjwRDnLgCXXfRQ
         GiZg==
X-Gm-Message-State: AOAM531is91rvXn2i0orjwB+k6KIFcatTSnPh24hGnI3QfMAZ0Vl3FQw
        qn5zVcFKHHt0l44mt6Z4lkDR3EAQi49N1e4w
X-Google-Smtp-Source: ABdhPJxUXYekr4PLYz9TtBuCmjYrYQX7iGLC+KMdtwdI1x7uNzMpyHaIyMxLRUX/ztuPpI1RbxTrJA==
X-Received: by 2002:a17:907:6004:: with SMTP id fs4mr1813929ejc.479.1617723999565;
        Tue, 06 Apr 2021 08:46:39 -0700 (PDT)
Received: from localhost.localdomain (host-79-42-91-147.retail.telecomitalia.it. [79.42.91.147])
        by smtp.gmail.com with ESMTPSA id j1sm11183506ejt.18.2021.04.06.08.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 08:46:39 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     gregkh@linuxfoundation.org, outreachy-kernel@googlegroups.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH v2] staging: rtl8723bs: hal: Add spaces around operators
Date:   Tue,  6 Apr 2021 17:46:35 +0200
Message-Id: <20210406154635.23191-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added spaces around operators in file HalBtc8723b1Ant.c. Issue detected
by checkpatch.pl. Spaces are preferred to improve readibility.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

Patch v2 adds spaces around an operator at line 1355. Overlooked in v1. 

 .../staging/rtl8723bs/hal/HalBtc8723b1Ant.c   | 98 +++++++++----------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
index 3e794093092b..503790924532 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
+++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
@@ -38,7 +38,7 @@ static u8 halbtc8723b1ant_BtRssiState(
 			(pCoexSta->preBtRssiState == BTC_RSSI_STATE_LOW) ||
 			(pCoexSta->preBtRssiState == BTC_RSSI_STATE_STAY_LOW)
 		) {
-			if (btRssi >= (rssiThresh+BTC_RSSI_COEX_THRESH_TOL_8723B_1ANT)) {
+			if (btRssi >= (rssiThresh + BTC_RSSI_COEX_THRESH_TOL_8723B_1ANT)) {
 
 				btRssiState = BTC_RSSI_STATE_HIGH;
 				BTC_PRINT(
@@ -85,7 +85,7 @@ static u8 halbtc8723b1ant_BtRssiState(
 			(pCoexSta->preBtRssiState == BTC_RSSI_STATE_LOW) ||
 			(pCoexSta->preBtRssiState == BTC_RSSI_STATE_STAY_LOW)
 		) {
-			if (btRssi >= (rssiThresh+BTC_RSSI_COEX_THRESH_TOL_8723B_1ANT)) {
+			if (btRssi >= (rssiThresh + BTC_RSSI_COEX_THRESH_TOL_8723B_1ANT)) {
 				btRssiState = BTC_RSSI_STATE_MEDIUM;
 				BTC_PRINT(
 					BTC_MSG_ALGORITHM,
@@ -104,7 +104,7 @@ static u8 halbtc8723b1ant_BtRssiState(
 			(pCoexSta->preBtRssiState == BTC_RSSI_STATE_MEDIUM) ||
 			(pCoexSta->preBtRssiState == BTC_RSSI_STATE_STAY_MEDIUM)
 		) {
-			if (btRssi >= (rssiThresh1+BTC_RSSI_COEX_THRESH_TOL_8723B_1ANT)) {
+			if (btRssi >= (rssiThresh1 + BTC_RSSI_COEX_THRESH_TOL_8723B_1ANT)) {
 				btRssiState = BTC_RSSI_STATE_HIGH;
 				BTC_PRINT(
 					BTC_MSG_ALGORITHM,
@@ -353,11 +353,11 @@ static void halbtc8723b1ant_MonitorBtCtr(struct btc_coexist *pBtCoexist)
 
 	u4Tmp = pBtCoexist->fBtcRead4Byte(pBtCoexist, regHPTxRx);
 	regHPTx = u4Tmp & bMaskLWord;
-	regHPRx = (u4Tmp & bMaskHWord)>>16;
+	regHPRx = (u4Tmp & bMaskHWord) >> 16;
 
 	u4Tmp = pBtCoexist->fBtcRead4Byte(pBtCoexist, regLPTxRx);
 	regLPTx = u4Tmp & bMaskLWord;
-	regLPRx = (u4Tmp & bMaskHWord)>>16;
+	regLPRx = (u4Tmp & bMaskHWord) >> 16;
 
 	pCoexSta->highPriorityTx = regHPTx;
 	pCoexSta->highPriorityRx = regHPRx;
@@ -1317,7 +1317,7 @@ static void halbtc8723b1ant_SetFwPstdma(
 	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_AP_MODE_ENABLE, &bApEnable);
 
 	if (bApEnable) {
-		if (byte1&BIT4 && !(byte1&BIT5)) {
+		if (byte1 & BIT4 && !(byte1 & BIT5)) {
 			BTC_PRINT(
 				BTC_MSG_INTERFACE,
 				INTF_NOTIFY,
@@ -1349,9 +1349,9 @@ static void halbtc8723b1ant_SetFwPstdma(
 		(
 			"[BTCoex], PS-TDMA H2C cmd = 0x%x%08x\n",
 			H2C_Parameter[0],
-			H2C_Parameter[1]<<24|
-			H2C_Parameter[2]<<16|
-			H2C_Parameter[3]<<8|
+			H2C_Parameter[1] << 24 |
+			H2C_Parameter[2] << 16 |
+			H2C_Parameter[3] << 8 |
 			H2C_Parameter[4]
 		)
 	);
@@ -1435,7 +1435,7 @@ static void halbtc8723b1ant_PsTdma(
 			halbtc8723b1ant_SetFwPstdma(
 				pBtCoexist,
 				psTdmaByte0Val,
-				0x3a+nWiFiDurationAdjust,
+				0x3a + nWiFiDurationAdjust,
 				0x03,
 				psTdmaByte3Val,
 				psTdmaByte4Val
@@ -1445,7 +1445,7 @@ static void halbtc8723b1ant_PsTdma(
 			halbtc8723b1ant_SetFwPstdma(
 				pBtCoexist,
 				psTdmaByte0Val,
-				0x2d+nWiFiDurationAdjust,
+				0x2d + nWiFiDurationAdjust,
 				0x03,
 				psTdmaByte3Val,
 				psTdmaByte4Val
@@ -1855,7 +1855,7 @@ static void halbtc8723b1ant_TdmaDurationAdjustForAcl(
 				if (m >= 20) /* m 最大值 = 20 ' 最大120秒 recheck是否調整 WiFi duration. */
 					m = 20;
 
-				n = 3*m;
+				n = 3 * m;
 				up = 0;
 				dn = 0;
 				WaitCount = 0;
@@ -1871,7 +1871,7 @@ static void halbtc8723b1ant_TdmaDurationAdjustForAcl(
 			if (m >= 20) /* m 最大值 = 20 ' 最大120秒 recheck是否調整 WiFi duration. */
 				m = 20;
 
-			n = 3*m;
+			n = 3 * m;
 			up = 0;
 			dn = 0;
 			WaitCount = 0;
@@ -2495,9 +2495,9 @@ static void halbtc8723b1ant_RunCoexistMechanism(struct btc_coexist *pBtCoexist)
 		BTC_GET_U4_WIFI_LINK_STATUS,
 		&wifiLinkStatus
 	);
-	numOfWifiLink = wifiLinkStatus>>16;
+	numOfWifiLink = wifiLinkStatus >> 16;
 
-	if ((numOfWifiLink >= 2) || (wifiLinkStatus&WIFI_P2P_GO_CONNECTED)) {
+	if ((numOfWifiLink >= 2) || (wifiLinkStatus & WIFI_P2P_GO_CONNECTED)) {
 		BTC_PRINT(
 			BTC_MSG_INTERFACE,
 			INTF_NOTIFY,
@@ -2656,7 +2656,7 @@ void EXhalbtc8723b1ant_PowerOnSetting(struct btc_coexist *pBtCoexist)
 
 	/*  enable BB, REG_SYS_FUNC_EN such that we can write 0x948 correctly. */
 	u2Tmp = pBtCoexist->fBtcRead2Byte(pBtCoexist, 0x2);
-	pBtCoexist->fBtcWrite2Byte(pBtCoexist, 0x2, u2Tmp|BIT0|BIT1);
+	pBtCoexist->fBtcWrite2Byte(pBtCoexist, 0x2, u2Tmp | BIT0 | BIT1);
 
 	/*  set GRAN_BT = 1 */
 	pBtCoexist->fBtcWrite1Byte(pBtCoexist, 0x765, 0x18);
@@ -2837,7 +2837,7 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 		cliBuf,
 		BT_TMP_BUF_SIZE,
 		"\r\n %-35s = %d/ %d", "Wifi rssi/ HS rssi", \
-		wifiRssi-100, btHsRssi-100
+		wifiRssi - 100, btHsRssi - 100
 	);
 	CL_PRINTF(cliBuf);
 
@@ -2881,11 +2881,11 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 		cliBuf,
 		BT_TMP_BUF_SIZE,
 		"\r\n %-35s = %d/ %d/ %d/ %d/ %d", "sta/vwifi/hs/p2pGo/p2pGc", \
-		((wifiLinkStatus&WIFI_STA_CONNECTED) ? 1 : 0),
-		((wifiLinkStatus&WIFI_AP_CONNECTED) ? 1 : 0),
-		((wifiLinkStatus&WIFI_HS_CONNECTED) ? 1 : 0),
-		((wifiLinkStatus&WIFI_P2P_GO_CONNECTED) ? 1 : 0),
-		((wifiLinkStatus&WIFI_P2P_GC_CONNECTED) ? 1 : 0)
+		((wifiLinkStatus & WIFI_STA_CONNECTED) ? 1 : 0),
+		((wifiLinkStatus & WIFI_AP_CONNECTED) ? 1 : 0),
+		((wifiLinkStatus & WIFI_HS_CONNECTED) ? 1 : 0),
+		((wifiLinkStatus & WIFI_P2P_GO_CONNECTED) ? 1 : 0),
+		((wifiLinkStatus & WIFI_P2P_GC_CONNECTED) ? 1 : 0)
 	);
 	CL_PRINTF(cliBuf);
 
@@ -2932,7 +2932,7 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 		cliBuf,
 		BT_TMP_BUF_SIZE,
 		"\r\n %-35s = %s", "BT Info A2DP rate", \
-		(btInfoExt&BIT0) ? "Basic rate" : "EDR rate"
+		(btInfoExt & BIT0) ? "Basic rate" : "EDR rate"
 	);
 	CL_PRINTF(cliBuf);
 
@@ -3044,7 +3044,7 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	CL_SPRINTF(
 		cliBuf, BT_TMP_BUF_SIZE,
 		"\r\n %-35s = 0x%x/ 0x%x/ 0x%x", "0x778/0x6cc/0x880[29:25]", \
-		u1Tmp[0], u4Tmp[0],  (u4Tmp[1]&0x3e000000) >> 25
+		u1Tmp[0], u4Tmp[0],  (u4Tmp[1] & 0x3e000000) >> 25
 	);
 	CL_PRINTF(cliBuf);
 
@@ -3056,7 +3056,7 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 		cliBuf,
 		BT_TMP_BUF_SIZE,
 		"\r\n %-35s = 0x%x/ 0x%x/ 0x%x/ 0x%x", "0x948/ 0x67[5] / 0x764 / 0x76e", \
-		u4Tmp[0], ((u1Tmp[0]&0x20) >> 5), (u4Tmp[1] & 0xffff), u1Tmp[1]
+		u4Tmp[0], ((u1Tmp[0] & 0x20) >> 5), (u4Tmp[1] & 0xffff), u1Tmp[1]
 	);
 	CL_PRINTF(cliBuf);
 
@@ -3067,7 +3067,7 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 		cliBuf,
 		BT_TMP_BUF_SIZE,
 		"\r\n %-35s = 0x%x/ 0x%x/ 0x%x", "0x92c[1:0]/ 0x930[7:0]/0x944[1:0]", \
-		u4Tmp[0]&0x3, u4Tmp[1]&0xff, u4Tmp[2]&0x3
+		u4Tmp[0] & 0x3, u4Tmp[1] & 0xff, u4Tmp[2] & 0x3
 	);
 	CL_PRINTF(cliBuf);
 
@@ -3079,10 +3079,10 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 		cliBuf,
 		BT_TMP_BUF_SIZE,
 		"\r\n %-35s = 0x%x/ 0x%x/ 0x%x/ 0x%x", "0x38[11]/0x40/0x4c[24:23]/0x64[0]", \
-		((u1Tmp[0] & 0x8)>>3),
+		((u1Tmp[0] & 0x8) >> 3),
 		u1Tmp[1],
-		((u4Tmp[0]&0x01800000)>>23),
-		u1Tmp[2]&0x1
+		((u4Tmp[0] & 0x01800000) >> 23),
+		u1Tmp[2] & 0x1
 	);
 	CL_PRINTF(cliBuf);
 
@@ -3102,7 +3102,7 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 		cliBuf,
 		BT_TMP_BUF_SIZE,
 		"\r\n %-35s = 0x%x/ 0x%x", "0xc50(dig)/0x49c(null-drop)", \
-		u4Tmp[0]&0xff, u1Tmp[0]
+		u4Tmp[0] & 0xff, u1Tmp[0]
 	);
 	CL_PRINTF(cliBuf);
 
@@ -3115,17 +3115,17 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	u1Tmp[1] = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0xa5c);
 
 	faOfdm =
-		((u4Tmp[0]&0xffff0000) >> 16) +
-		((u4Tmp[1]&0xffff0000) >> 16) +
+		((u4Tmp[0] & 0xffff0000) >> 16) +
+		((u4Tmp[1] & 0xffff0000) >> 16) +
 		(u4Tmp[1] & 0xffff) +  (u4Tmp[2] & 0xffff) + \
-		((u4Tmp[3]&0xffff0000) >> 16) + (u4Tmp[3] & 0xffff);
+		((u4Tmp[3] & 0xffff0000) >> 16) + (u4Tmp[3] & 0xffff);
 	faCck = (u1Tmp[0] << 8) + u1Tmp[1];
 
 	CL_SPRINTF(
 		cliBuf,
 		BT_TMP_BUF_SIZE,
 		"\r\n %-35s = 0x%x/ 0x%x/ 0x%x", "OFDM-CCA/OFDM-FA/CCK-FA", \
-		u4Tmp[0]&0xffff, faOfdm, faCck
+		u4Tmp[0] & 0xffff, faOfdm, faCck
 	);
 	CL_PRINTF(cliBuf);
 
@@ -3281,7 +3281,7 @@ void EXhalbtc8723b1ant_ScanNotify(struct btc_coexist *pBtCoexist, u8 type)
 	halbtc8723b1ant_QueryBtInfo(pBtCoexist);
 
 	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_U4_WIFI_LINK_STATUS, &wifiLinkStatus);
-	numOfWifiLink = wifiLinkStatus>>16;
+	numOfWifiLink = wifiLinkStatus >> 16;
 
 	if (numOfWifiLink >= 2) {
 		halbtc8723b1ant_LimitedTx(pBtCoexist, NORMAL_EXEC, 0, 0, 0, 0);
@@ -3341,7 +3341,7 @@ void EXhalbtc8723b1ant_ConnectNotify(struct btc_coexist *pBtCoexist, u8 type)
 	}
 
 	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_U4_WIFI_LINK_STATUS, &wifiLinkStatus);
-	numOfWifiLink = wifiLinkStatus>>16;
+	numOfWifiLink = wifiLinkStatus >> 16;
 	if (numOfWifiLink >= 2) {
 		halbtc8723b1ant_LimitedTx(pBtCoexist, NORMAL_EXEC, 0, 0, 0, 0);
 		halbtc8723b1ant_LimitedRx(pBtCoexist, NORMAL_EXEC, false, bBtCtrlAggBufSize, aggBufSize);
@@ -3435,7 +3435,7 @@ void EXhalbtc8723b1ant_MediaStatusNotify(struct btc_coexist *pBtCoexist, u8 type
 		ALGO_TRACE_FW_EXEC,
 		(
 			"[BTCoex], FW write 0x66 = 0x%x\n",
-			H2C_Parameter[0]<<16 | H2C_Parameter[1]<<8 | H2C_Parameter[2]
+			H2C_Parameter[0] << 16 | H2C_Parameter[1] << 8 | H2C_Parameter[2]
 		)
 	);
 
@@ -3502,7 +3502,7 @@ void EXhalbtc8723b1ant_SpecialPacketNotify(struct btc_coexist *pBtCoexist, u8 ty
 	pBtCoexist->fBtcGet(
 		pBtCoexist, BTC_GET_U4_WIFI_LINK_STATUS, &wifiLinkStatus
 	);
-	numOfWifiLink = wifiLinkStatus>>16;
+	numOfWifiLink = wifiLinkStatus >> 16;
 
 	if (numOfWifiLink >= 2) {
 		halbtc8723b1ant_LimitedTx(pBtCoexist, NORMAL_EXEC, 0, 0, 0, 0);
@@ -3541,7 +3541,7 @@ void EXhalbtc8723b1ant_BtInfoNotify(
 
 	pCoexSta->bC2hBtInfoReqSent = false;
 
-	rspSource = tmpBuf[0]&0xf;
+	rspSource = tmpBuf[0] & 0xf;
 	if (rspSource >= BT_INFO_SRC_8723B_1ANT_MAX)
 		rspSource = BT_INFO_SRC_8723B_1ANT_WIFI_FW;
 	pCoexSta->btInfoC2hCnt[rspSource]++;
@@ -3557,7 +3557,7 @@ void EXhalbtc8723b1ant_BtInfoNotify(
 		pCoexSta->btInfoC2h[rspSource][i] = tmpBuf[i];
 		if (i == 1)
 			btInfo = tmpBuf[i];
-		if (i == length-1)
+		if (i == length - 1)
 			BTC_PRINT(
 				BTC_MSG_INTERFACE, INTF_NOTIFY, ("0x%02x]\n", tmpBuf[i])
 			);
@@ -3566,22 +3566,22 @@ void EXhalbtc8723b1ant_BtInfoNotify(
 	}
 
 	if (BT_INFO_SRC_8723B_1ANT_WIFI_FW != rspSource) {
-		pCoexSta->btRetryCnt = pCoexSta->btInfoC2h[rspSource][2]&0xf;
+		pCoexSta->btRetryCnt = pCoexSta->btInfoC2h[rspSource][2] & 0xf;
 
 		if (pCoexSta->btRetryCnt >= 1)
 			pCoexSta->popEventCnt++;
 
-		if (pCoexSta->btInfoC2h[rspSource][2]&0x20)
+		if (pCoexSta->btInfoC2h[rspSource][2] & 0x20)
 			pCoexSta->bC2hBtPage = true;
 		else
 			pCoexSta->bC2hBtPage = false;
 
-		pCoexSta->btRssi = pCoexSta->btInfoC2h[rspSource][3]*2-90;
+		pCoexSta->btRssi = pCoexSta->btInfoC2h[rspSource][3] * 2 - 90;
 		/* pCoexSta->btInfoC2h[rspSource][3]*2+10; */
 
 		pCoexSta->btInfoExt = pCoexSta->btInfoC2h[rspSource][4];
 
-		pCoexSta->bBtTxRxMask = (pCoexSta->btInfoC2h[rspSource][2]&0x40);
+		pCoexSta->bBtTxRxMask = (pCoexSta->btInfoC2h[rspSource][2] & 0x40);
 		pBtCoexist->fBtcSet(pBtCoexist, BTC_SET_BL_BT_TX_RX_MASK, &pCoexSta->bBtTxRxMask);
 
 		if (!pCoexSta->bBtTxRxMask) {
@@ -3626,7 +3626,7 @@ void EXhalbtc8723b1ant_BtInfoNotify(
 		pCoexSta->bC2hBtInquiryPage = false;
 
 	/*  set link exist status */
-	if (!(btInfo&BT_INFO_8723B_1ANT_B_CONNECTION)) {
+	if (!(btInfo & BT_INFO_8723B_1ANT_B_CONNECTION)) {
 		pCoexSta->bBtLinkExist = false;
 		pCoexSta->bPanExist = false;
 		pCoexSta->bA2dpExist = false;
@@ -3659,7 +3659,7 @@ void EXhalbtc8723b1ant_BtInfoNotify(
 
 	btInfo = btInfo & 0x1f;  /* mask profile bit for connect-ilde identification (for CSR case: A2DP idle --> 0x41) */
 
-	if (!(btInfo&BT_INFO_8723B_1ANT_B_CONNECTION)) {
+	if (!(btInfo & BT_INFO_8723B_1ANT_B_CONNECTION)) {
 		pCoexDm->btStatus = BT_8723B_1ANT_BT_STATUS_NON_CONNECTED_IDLE;
 		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], BtInfoNotify(), BT Non-Connected idle!!!\n"));
 	} else if (btInfo == BT_INFO_8723B_1ANT_B_CONNECTION)	{
@@ -3667,12 +3667,12 @@ void EXhalbtc8723b1ant_BtInfoNotify(
 		pCoexDm->btStatus = BT_8723B_1ANT_BT_STATUS_CONNECTED_IDLE;
 		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], BtInfoNotify(), BT Connected-idle!!!\n"));
 	} else if (
-		(btInfo&BT_INFO_8723B_1ANT_B_SCO_ESCO) ||
-		(btInfo&BT_INFO_8723B_1ANT_B_SCO_BUSY)
+		(btInfo & BT_INFO_8723B_1ANT_B_SCO_ESCO) ||
+		(btInfo & BT_INFO_8723B_1ANT_B_SCO_BUSY)
 	) {
 		pCoexDm->btStatus = BT_8723B_1ANT_BT_STATUS_SCO_BUSY;
 		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], BtInfoNotify(), BT SCO busy!!!\n"));
-	} else if (btInfo&BT_INFO_8723B_1ANT_B_ACL_BUSY) {
+	} else if (btInfo & BT_INFO_8723B_1ANT_B_ACL_BUSY) {
 		if (BT_8723B_1ANT_BT_STATUS_ACL_BUSY != pCoexDm->btStatus)
 			pCoexDm->bAutoTdmaAdjust = false;
 
-- 
2.30.2

