Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C65835D254
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 23:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239779AbhDLVD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 17:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237497AbhDLVDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 17:03:25 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00EEC061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 14:03:06 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r22so16708105edq.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 14:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K2oLfbvIvE6kqcnR4F+3GyglrFxiOW06bWThYASZtCE=;
        b=UofQDVeEkbrDsa5JpLukEDilAORfmcMy5FjmXusj0ccQC2SDaB03NaHz0BvqREuOVj
         NJzbPIYXl1lPoteqPnWJEGWwEdzjPIv59W8R2iubK7FiDctrdzRZwmtI6XrATq9Jsyb5
         oGUodkUbZzJO5E5o9urvKJ+5shZTixHcTkgl4XYxCB0CYHU59opNiZ5SyfjUSENvXcdx
         eUlQsb4vvLpTxJvKKba0GgjAZx+oA0433LUZvdPlhpbHKacjC5XDHRFs49k5fL5VHkGJ
         M0CKOWL94ocQTzq/UODBpOdltK8cRE8hd4nq4pMsXQijqn3JbM60L6p9465k3Kn3zCi7
         m5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K2oLfbvIvE6kqcnR4F+3GyglrFxiOW06bWThYASZtCE=;
        b=mwWvXVrPT0PxK9YnBC4nl7ov2YW/RxEldyD+U6lV7LicEP4b3AcPoaWintnlPjPHLA
         gPtozNWoOmOc0bXeAFjSkysRKDceOpN4nLXumsiise/9tZBMxceMGME8RZm1uIT3wDG4
         pzY+ss2XmK4UtEnAH0m9k+a77w1kHaarw+jT3gELkrFQjEcNw825myGyxjJAi0OGLdg5
         sbYqTyuMSl1poNGTDNfy6YC40Plzy7+S3z36mGHLs8qZWgwte274Xg4qdU/4kwM0ADJc
         WqRTiJKk8IaQlPxvny/EMyhK7DoEzLygEpnoapeq7Sbko+iRycrzddI6FOqdI6hkWacJ
         w8Bw==
X-Gm-Message-State: AOAM533X948fcJWZpUD/WZxPOGbIRjduJeIBQ65Oam5vfMplYG9o+S71
        ZVOc5a1pjzMXI1lxIT8MGN4=
X-Google-Smtp-Source: ABdhPJySQRgGdHsqHk7KbnLYtLJMDuzTEe4YgYKaS0ieVPSeS3WEXgwW+lD5omjvfKvlt7I66QMmEA==
X-Received: by 2002:aa7:c455:: with SMTP id n21mr26773525edr.48.1618261384923;
        Mon, 12 Apr 2021 14:03:04 -0700 (PDT)
Received: from linux.local (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id s12sm7724835edx.18.2021.04.12.14.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 14:03:03 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH] staging: rtl8723bs: hal: Remove camelcase
Date:   Mon, 12 Apr 2021 23:02:58 +0200
Message-Id: <20210412210258.8061-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed camelcase in (some) symbols. Further work is needed.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 .../staging/rtl8723bs/hal/HalBtc8723b1Ant.c   | 2080 ++++++++---------
 1 file changed, 1039 insertions(+), 1041 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
index 503790924532..9e8a45f1a045 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
+++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
@@ -8,46 +8,44 @@
 #include "Mp_Precomp.h"
 
 /*  Global variables, these are static variables */
-static struct coex_dm_8723b_1ant GLCoexDm8723b1Ant;
-static struct coex_dm_8723b_1ant *pCoexDm = &GLCoexDm8723b1Ant;
-static struct coex_sta_8723b_1ant GLCoexSta8723b1Ant;
-static struct coex_sta_8723b_1ant *pCoexSta = &GLCoexSta8723b1Ant;
+static struct coex_dm_8723b_1ant gl_coex_dm_8723b_1ant;
+static struct coex_dm_8723b_1ant *p_coex_dm = &gl_coex_dm_8723b_1ant;
+static struct coex_sta_8723b_1ant gl_coex_sta_8723b_1ant;
+static struct coex_sta_8723b_1ant *p_coex_sta = &gl_coex_sta_8723b_1ant;
 
-static const char *const GLBtInfoSrc8723b1Ant[] = {
+static const char *const gl_bt_info_src_8723b_1ant[] = {
 	"BT Info[wifi fw]",
 	"BT Info[bt rsp]",
 	"BT Info[bt auto report]",
 };
 
-static u32 GLCoexVerDate8723b1Ant = 20140507;
-static u32 GLCoexVer8723b1Ant = 0x4e;
+static u32 gl_coex_ver_date_8723b_1ant = 20140507;
+static u32 gl_coex_ver_8723b_1ant = 0x4e;
 
 /*  local function proto type if needed */
 /*  local function start with halbtc8723b1ant_ */
-static u8 halbtc8723b1ant_BtRssiState(
-	u8 levelNum, u8 rssiThresh, u8 rssiThresh1
-)
+static u8 hal_btc_8723b_1ant_btRssi_state(u8 levelNum, u8 rssi_thresh, u8 rssi_thresh1)
 {
-	s32 btRssi = 0;
-	u8 btRssiState = pCoexSta->preBtRssiState;
+	s32 bt_rssi = 0;
+	u8 bt_rssi_state = p_coex_sta->preBtRssiState;
 
-	btRssi = pCoexSta->btRssi;
+	bt_rssi = p_coex_sta->btRssi;
 
 	if (levelNum == 2) {
 		if (
-			(pCoexSta->preBtRssiState == BTC_RSSI_STATE_LOW) ||
-			(pCoexSta->preBtRssiState == BTC_RSSI_STATE_STAY_LOW)
+			(p_coex_sta->preBtRssiState == BTC_RSSI_STATE_LOW) ||
+			(p_coex_sta->preBtRssiState == BTC_RSSI_STATE_STAY_LOW)
 		) {
-			if (btRssi >= (rssiThresh + BTC_RSSI_COEX_THRESH_TOL_8723B_1ANT)) {
+			if (bt_rssi >= (rssi_thresh + BTC_RSSI_COEX_THRESH_TOL_8723B_1ANT)) {
 
-				btRssiState = BTC_RSSI_STATE_HIGH;
+				bt_rssi_state = BTC_RSSI_STATE_HIGH;
 				BTC_PRINT(
 					BTC_MSG_ALGORITHM,
 					ALGO_BT_RSSI_STATE,
 					("[BTCoex], BT Rssi state switch to High\n")
 				);
 			} else {
-				btRssiState = BTC_RSSI_STATE_STAY_LOW;
+				bt_rssi_state = BTC_RSSI_STATE_STAY_LOW;
 				BTC_PRINT(
 					BTC_MSG_ALGORITHM,
 					ALGO_BT_RSSI_STATE,
@@ -55,15 +53,15 @@ static u8 halbtc8723b1ant_BtRssiState(
 				);
 			}
 		} else {
-			if (btRssi < rssiThresh) {
-				btRssiState = BTC_RSSI_STATE_LOW;
+			if (bt_rssi < rssi_thresh) {
+				bt_rssi_state = BTC_RSSI_STATE_LOW;
 				BTC_PRINT(
 					BTC_MSG_ALGORITHM,
 					ALGO_BT_RSSI_STATE,
 					("[BTCoex], BT Rssi state switch to Low\n")
 				);
 			} else {
-				btRssiState = BTC_RSSI_STATE_STAY_HIGH;
+				bt_rssi_state = BTC_RSSI_STATE_STAY_HIGH;
 				BTC_PRINT(
 					BTC_MSG_ALGORITHM,
 					ALGO_BT_RSSI_STATE,
@@ -72,28 +70,28 @@ static u8 halbtc8723b1ant_BtRssiState(
 			}
 		}
 	} else if (levelNum == 3) {
-		if (rssiThresh > rssiThresh1) {
+		if (rssi_thresh > rssi_thresh1) {
 			BTC_PRINT(
 				BTC_MSG_ALGORITHM,
 				ALGO_BT_RSSI_STATE,
 				("[BTCoex], BT Rssi thresh error!!\n")
 			);
-			return pCoexSta->preBtRssiState;
+			return p_coex_sta->preBtRssiState;
 		}
 
 		if (
-			(pCoexSta->preBtRssiState == BTC_RSSI_STATE_LOW) ||
-			(pCoexSta->preBtRssiState == BTC_RSSI_STATE_STAY_LOW)
+			(p_coex_sta->preBtRssiState == BTC_RSSI_STATE_LOW) ||
+			(p_coex_sta->preBtRssiState == BTC_RSSI_STATE_STAY_LOW)
 		) {
-			if (btRssi >= (rssiThresh + BTC_RSSI_COEX_THRESH_TOL_8723B_1ANT)) {
-				btRssiState = BTC_RSSI_STATE_MEDIUM;
+			if (bt_rssi >= (rssi_thresh + BTC_RSSI_COEX_THRESH_TOL_8723B_1ANT)) {
+				bt_rssi_state = BTC_RSSI_STATE_MEDIUM;
 				BTC_PRINT(
 					BTC_MSG_ALGORITHM,
 					ALGO_BT_RSSI_STATE,
 					("[BTCoex], BT Rssi state switch to Medium\n")
 				);
 			} else {
-				btRssiState = BTC_RSSI_STATE_STAY_LOW;
+				bt_rssi_state = BTC_RSSI_STATE_STAY_LOW;
 				BTC_PRINT(
 					BTC_MSG_ALGORITHM,
 					ALGO_BT_RSSI_STATE,
@@ -101,25 +99,25 @@ static u8 halbtc8723b1ant_BtRssiState(
 				);
 			}
 		} else if (
-			(pCoexSta->preBtRssiState == BTC_RSSI_STATE_MEDIUM) ||
-			(pCoexSta->preBtRssiState == BTC_RSSI_STATE_STAY_MEDIUM)
+			(p_coex_sta->preBtRssiState == BTC_RSSI_STATE_MEDIUM) ||
+			(p_coex_sta->preBtRssiState == BTC_RSSI_STATE_STAY_MEDIUM)
 		) {
-			if (btRssi >= (rssiThresh1 + BTC_RSSI_COEX_THRESH_TOL_8723B_1ANT)) {
-				btRssiState = BTC_RSSI_STATE_HIGH;
+			if (bt_rssi >= (rssi_thresh1 + BTC_RSSI_COEX_THRESH_TOL_8723B_1ANT)) {
+				bt_rssi_state = BTC_RSSI_STATE_HIGH;
 				BTC_PRINT(
 					BTC_MSG_ALGORITHM,
 					ALGO_BT_RSSI_STATE,
 					("[BTCoex], BT Rssi state switch to High\n")
 				);
-			} else if (btRssi < rssiThresh) {
-				btRssiState = BTC_RSSI_STATE_LOW;
+			} else if (bt_rssi < rssi_thresh) {
+				bt_rssi_state = BTC_RSSI_STATE_LOW;
 				BTC_PRINT(
 					BTC_MSG_ALGORITHM,
 					ALGO_BT_RSSI_STATE,
 					("[BTCoex], BT Rssi state switch to Low\n")
 				);
 			} else {
-				btRssiState = BTC_RSSI_STATE_STAY_MEDIUM;
+				bt_rssi_state = BTC_RSSI_STATE_STAY_MEDIUM;
 				BTC_PRINT(
 					BTC_MSG_ALGORITHM,
 					ALGO_BT_RSSI_STATE,
@@ -127,15 +125,15 @@ static u8 halbtc8723b1ant_BtRssiState(
 				);
 			}
 		} else {
-			if (btRssi < rssiThresh1) {
-				btRssiState = BTC_RSSI_STATE_MEDIUM;
+			if (bt_rssi < rssi_thresh1) {
+				bt_rssi_state = BTC_RSSI_STATE_MEDIUM;
 				BTC_PRINT(
 					BTC_MSG_ALGORITHM,
 					ALGO_BT_RSSI_STATE,
 					("[BTCoex], BT Rssi state switch to Medium\n")
 				);
 			} else {
-				btRssiState = BTC_RSSI_STATE_STAY_HIGH;
+				bt_rssi_state = BTC_RSSI_STATE_STAY_HIGH;
 				BTC_PRINT(
 					BTC_MSG_ALGORITHM,
 					ALGO_BT_RSSI_STATE,
@@ -145,54 +143,54 @@ static u8 halbtc8723b1ant_BtRssiState(
 		}
 	}
 
-	pCoexSta->preBtRssiState = btRssiState;
+	p_coex_sta->preBtRssiState = bt_rssi_state;
 
-	return btRssiState;
+	return bt_rssi_state;
 }
 
 static void halbtc8723b1ant_UpdateRaMask(
-	struct btc_coexist *pBtCoexist, bool bForceExec, u32 disRateMask
+	struct btc_coexist *p_bt_coexist, bool force_exec, u32 dis_rate_mask
 )
 {
-	pCoexDm->curRaMask = disRateMask;
+	p_coex_dm->curRaMask = dis_rate_mask;
 
-	if (bForceExec || (pCoexDm->preRaMask != pCoexDm->curRaMask))
-		pBtCoexist->fBtcSet(
-			pBtCoexist,
+	if (force_exec || (p_coex_dm->preRaMask != p_coex_dm->curRaMask))
+		p_bt_coexist->fBtcSet(
+			p_bt_coexist,
 			BTC_SET_ACT_UPDATE_RAMASK,
-			&pCoexDm->curRaMask
+			&p_coex_dm->curRaMask
 		);
-	pCoexDm->preRaMask = pCoexDm->curRaMask;
+	p_coex_dm->preRaMask = p_coex_dm->curRaMask;
 }
 
 static void halbtc8723b1ant_AutoRateFallbackRetry(
-	struct btc_coexist *pBtCoexist, bool bForceExec, u8 type
+	struct btc_coexist *p_bt_coexist, bool force_exec, u8 type
 )
 {
-	bool bWifiUnderBMode = false;
+	bool wifi_under_bmode = false;
 
-	pCoexDm->curArfrType = type;
+	p_coex_dm->curArfrType = type;
 
-	if (bForceExec || (pCoexDm->preArfrType != pCoexDm->curArfrType)) {
-		switch (pCoexDm->curArfrType) {
+	if (force_exec || (p_coex_dm->preArfrType != p_coex_dm->curArfrType)) {
+		switch (p_coex_dm->curArfrType) {
 		case 0:	/*  normal mode */
-			pBtCoexist->fBtcWrite4Byte(
-				pBtCoexist, 0x430, pCoexDm->backupArfrCnt1
+			p_bt_coexist->fBtcWrite4Byte(
+				p_bt_coexist, 0x430, p_coex_dm->backupArfrCnt1
 			);
-			pBtCoexist->fBtcWrite4Byte(
-				pBtCoexist, 0x434, pCoexDm->backupArfrCnt2
+			p_bt_coexist->fBtcWrite4Byte(
+				p_bt_coexist, 0x434, p_coex_dm->backupArfrCnt2
 			);
 			break;
 		case 1:
-			pBtCoexist->fBtcGet(
-				pBtCoexist, BTC_GET_BL_WIFI_UNDER_B_MODE, &bWifiUnderBMode
+			p_bt_coexist->fBtcGet(
+				p_bt_coexist, BTC_GET_BL_WIFI_UNDER_B_MODE, &wifi_under_bmode
 			);
-			if (bWifiUnderBMode) {
-				pBtCoexist->fBtcWrite4Byte(pBtCoexist, 0x430, 0x0);
-				pBtCoexist->fBtcWrite4Byte(pBtCoexist, 0x434, 0x01010101);
+			if (wifi_under_bmode) {
+				p_bt_coexist->fBtcWrite4Byte(p_bt_coexist, 0x430, 0x0);
+				p_bt_coexist->fBtcWrite4Byte(p_bt_coexist, 0x434, 0x01010101);
 			} else {
-				pBtCoexist->fBtcWrite4Byte(pBtCoexist, 0x430, 0x0);
-				pBtCoexist->fBtcWrite4Byte(pBtCoexist, 0x434, 0x04030201);
+				p_bt_coexist->fBtcWrite4Byte(p_bt_coexist, 0x430, 0x0);
+				p_bt_coexist->fBtcWrite4Byte(p_bt_coexist, 0x434, 0x04030201);
 			}
 			break;
 		default:
@@ -200,93 +198,93 @@ static void halbtc8723b1ant_AutoRateFallbackRetry(
 		}
 	}
 
-	pCoexDm->preArfrType = pCoexDm->curArfrType;
+	p_coex_dm->preArfrType = p_coex_dm->curArfrType;
 }
 
 static void halbtc8723b1ant_RetryLimit(
-	struct btc_coexist *pBtCoexist, bool bForceExec, u8 type
+	struct btc_coexist *p_bt_coexist, bool force_exec, u8 type
 )
 {
-	pCoexDm->curRetryLimitType = type;
+	p_coex_dm->curRetryLimitType = type;
 
 	if (
-		bForceExec ||
-		(pCoexDm->preRetryLimitType != pCoexDm->curRetryLimitType)
+		force_exec ||
+		(p_coex_dm->preRetryLimitType != p_coex_dm->curRetryLimitType)
 	) {
-		switch (pCoexDm->curRetryLimitType) {
+		switch (p_coex_dm->curRetryLimitType) {
 		case 0:	/*  normal mode */
-			pBtCoexist->fBtcWrite2Byte(
-				pBtCoexist, 0x42a, pCoexDm->backupRetryLimit
+			p_bt_coexist->fBtcWrite2Byte(
+				p_bt_coexist, 0x42a, p_coex_dm->backupRetryLimit
 			);
 			break;
 		case 1:	/*  retry limit =8 */
-			pBtCoexist->fBtcWrite2Byte(pBtCoexist, 0x42a, 0x0808);
+			p_bt_coexist->fBtcWrite2Byte(p_bt_coexist, 0x42a, 0x0808);
 			break;
 		default:
 			break;
 		}
 	}
 
-	pCoexDm->preRetryLimitType = pCoexDm->curRetryLimitType;
+	p_coex_dm->preRetryLimitType = p_coex_dm->curRetryLimitType;
 }
 
 static void halbtc8723b1ant_AmpduMaxTime(
-	struct btc_coexist *pBtCoexist, bool bForceExec, u8 type
+	struct btc_coexist *p_bt_coexist, bool force_exec, u8 type
 )
 {
-	pCoexDm->curAmpduTimeType = type;
+	p_coex_dm->curAmpduTimeType = type;
 
 	if (
-		bForceExec || (pCoexDm->preAmpduTimeType != pCoexDm->curAmpduTimeType)
+		force_exec || (p_coex_dm->preAmpduTimeType != p_coex_dm->curAmpduTimeType)
 	) {
-		switch (pCoexDm->curAmpduTimeType) {
+		switch (p_coex_dm->curAmpduTimeType) {
 		case 0:	/*  normal mode */
-			pBtCoexist->fBtcWrite1Byte(
-				pBtCoexist, 0x456, pCoexDm->backupAmpduMaxTime
+			p_bt_coexist->fBtcWrite1Byte(
+				p_bt_coexist, 0x456, p_coex_dm->backupAmpduMaxTime
 			);
 			break;
 		case 1:	/*  AMPDU timw = 0x38 * 32us */
-			pBtCoexist->fBtcWrite1Byte(pBtCoexist, 0x456, 0x38);
+			p_bt_coexist->fBtcWrite1Byte(p_bt_coexist, 0x456, 0x38);
 			break;
 		default:
 			break;
 		}
 	}
 
-	pCoexDm->preAmpduTimeType = pCoexDm->curAmpduTimeType;
+	p_coex_dm->preAmpduTimeType = p_coex_dm->curAmpduTimeType;
 }
 
 static void halbtc8723b1ant_LimitedTx(
-	struct btc_coexist *pBtCoexist,
-	bool bForceExec,
-	u8 raMaskType,
-	u8 arfrType,
-	u8 retryLimitType,
-	u8 ampduTimeType
+	struct btc_coexist *p_bt_coexist,
+	bool force_exec,
+	u8 ra_mask_type,
+	u8 arfr_type,
+	u8 retry_limit_type,
+	u8 ampdu_time_type
 )
 {
-	switch (raMaskType) {
+	switch (ra_mask_type) {
 	case 0:	/*  normal mode */
-		halbtc8723b1ant_UpdateRaMask(pBtCoexist, bForceExec, 0x0);
+		halbtc8723b1ant_UpdateRaMask(p_bt_coexist, force_exec, 0x0);
 		break;
 	case 1:	/*  disable cck 1/2 */
-		halbtc8723b1ant_UpdateRaMask(pBtCoexist, bForceExec, 0x00000003);
+		halbtc8723b1ant_UpdateRaMask(p_bt_coexist, force_exec, 0x00000003);
 		break;
 	case 2:	/*  disable cck 1/2/5.5, ofdm 6/9/12/18/24, mcs 0/1/2/3/4 */
-		halbtc8723b1ant_UpdateRaMask(pBtCoexist, bForceExec, 0x0001f1f7);
+		halbtc8723b1ant_UpdateRaMask(p_bt_coexist, force_exec, 0x0001f1f7);
 		break;
 	default:
 		break;
 	}
 
-	halbtc8723b1ant_AutoRateFallbackRetry(pBtCoexist, bForceExec, arfrType);
-	halbtc8723b1ant_RetryLimit(pBtCoexist, bForceExec, retryLimitType);
-	halbtc8723b1ant_AmpduMaxTime(pBtCoexist, bForceExec, ampduTimeType);
+	halbtc8723b1ant_AutoRateFallbackRetry(p_bt_coexist, force_exec, arfr_type);
+	halbtc8723b1ant_RetryLimit(p_bt_coexist, force_exec, retry_limit_type);
+	halbtc8723b1ant_AmpduMaxTime(p_bt_coexist, force_exec, ampdu_time_type);
 }
 
 static void halbtc8723b1ant_LimitedRx(
-	struct btc_coexist *pBtCoexist,
-	bool bForceExec,
+	struct btc_coexist *p_bt_coexist,
+	bool force_exec,
 	bool bRejApAggPkt,
 	bool bBtCtrlAggBufSize,
 	u8 aggBufSize
@@ -299,73 +297,73 @@ static void halbtc8723b1ant_LimitedRx(
 	/*  */
 	/* 	Rx Aggregation related setting */
 	/*  */
-	pBtCoexist->fBtcSet(
-		pBtCoexist, BTC_SET_BL_TO_REJ_AP_AGG_PKT, &bRejectRxAgg
+	p_bt_coexist->fBtcSet(
+		p_bt_coexist, BTC_SET_BL_TO_REJ_AP_AGG_PKT, &bRejectRxAgg
 	);
 	/*  decide BT control aggregation buf size or not */
-	pBtCoexist->fBtcSet(
-		pBtCoexist, BTC_SET_BL_BT_CTRL_AGG_SIZE, &bBtCtrlRxAggSize
+	p_bt_coexist->fBtcSet(
+		p_bt_coexist, BTC_SET_BL_BT_CTRL_AGG_SIZE, &bBtCtrlRxAggSize
 	);
 	/*  aggregation buf size, only work when BT control Rx aggregation size. */
-	pBtCoexist->fBtcSet(pBtCoexist, BTC_SET_U1_AGG_BUF_SIZE, &rxAggSize);
+	p_bt_coexist->fBtcSet(p_bt_coexist, BTC_SET_U1_AGG_BUF_SIZE, &rxAggSize);
 	/*  real update aggregation setting */
-	pBtCoexist->fBtcSet(pBtCoexist, BTC_SET_ACT_AGGREGATE_CTRL, NULL);
+	p_bt_coexist->fBtcSet(p_bt_coexist, BTC_SET_ACT_AGGREGATE_CTRL, NULL);
 
 
 }
 
-static void halbtc8723b1ant_QueryBtInfo(struct btc_coexist *pBtCoexist)
+static void halbtc8723b1ant_QueryBtInfo(struct btc_coexist *p_bt_coexist)
 {
-	u8 	H2C_Parameter[1] = {0};
+	u8 	h2c_parameter[1] = {0};
 
-	pCoexSta->bC2hBtInfoReqSent = true;
+	p_coex_sta->bC2hBtInfoReqSent = true;
 
-	H2C_Parameter[0] |= BIT0;	/*  trigger */
+	h2c_parameter[0] |= BIT0;	/*  trigger */
 
 	BTC_PRINT(
 		BTC_MSG_ALGORITHM,
 		ALGO_TRACE_FW_EXEC,
-		("[BTCoex], Query Bt Info, FW write 0x61 = 0x%x\n", H2C_Parameter[0])
+		("[BTCoex], Query Bt Info, FW write 0x61 = 0x%x\n", h2c_parameter[0])
 	);
 
-	pBtCoexist->fBtcFillH2c(pBtCoexist, 0x61, 1, H2C_Parameter);
+	p_bt_coexist->fBtcFillH2c(p_bt_coexist, 0x61, 1, h2c_parameter);
 }
 
-static void halbtc8723b1ant_MonitorBtCtr(struct btc_coexist *pBtCoexist)
+static void halbtc8723b1ant_MonitorBtCtr(struct btc_coexist *p_bt_coexist)
 {
 	u32 regHPTxRx, regLPTxRx, u4Tmp;
 	u32 regHPTx = 0, regHPRx = 0, regLPTx = 0, regLPRx = 0;
 	static u8 NumOfBtCounterChk;
 
        /* to avoid 0x76e[3] = 1 (WLAN_Act control by PTA) during IPS */
-	/* if (! (pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x76e) & 0x8)) */
+	/* if (! (p_bt_coexist->fBtcRead1Byte(p_bt_coexist, 0x76e) & 0x8)) */
 
-	if (pCoexSta->bUnderIps) {
-		pCoexSta->highPriorityTx = 65535;
-		pCoexSta->highPriorityRx = 65535;
-		pCoexSta->lowPriorityTx = 65535;
-		pCoexSta->lowPriorityRx = 65535;
+	if (p_coex_sta->bUnderIps) {
+		p_coex_sta->highPriorityTx = 65535;
+		p_coex_sta->highPriorityRx = 65535;
+		p_coex_sta->lowPriorityTx = 65535;
+		p_coex_sta->lowPriorityRx = 65535;
 		return;
 	}
 
 	regHPTxRx = 0x770;
 	regLPTxRx = 0x774;
 
-	u4Tmp = pBtCoexist->fBtcRead4Byte(pBtCoexist, regHPTxRx);
+	u4Tmp = p_bt_coexist->fBtcRead4Byte(p_bt_coexist, regHPTxRx);
 	regHPTx = u4Tmp & bMaskLWord;
 	regHPRx = (u4Tmp & bMaskHWord) >> 16;
 
-	u4Tmp = pBtCoexist->fBtcRead4Byte(pBtCoexist, regLPTxRx);
+	u4Tmp = p_bt_coexist->fBtcRead4Byte(p_bt_coexist, regLPTxRx);
 	regLPTx = u4Tmp & bMaskLWord;
 	regLPRx = (u4Tmp & bMaskHWord) >> 16;
 
-	pCoexSta->highPriorityTx = regHPTx;
-	pCoexSta->highPriorityRx = regHPRx;
-	pCoexSta->lowPriorityTx = regLPTx;
-	pCoexSta->lowPriorityRx = regLPRx;
+	p_coex_sta->highPriorityTx = regHPTx;
+	p_coex_sta->highPriorityRx = regHPRx;
+	p_coex_sta->lowPriorityTx = regLPTx;
+	p_coex_sta->lowPriorityRx = regLPRx;
 
-	if ((pCoexSta->lowPriorityTx >= 1050) && (!pCoexSta->bC2hBtInquiryPage))
-		pCoexSta->popEventCnt++;
+	if ((p_coex_sta->lowPriorityTx >= 1050) && (!p_coex_sta->bC2hBtInquiryPage))
+		p_coex_sta->popEventCnt++;
 
 	BTC_PRINT(
 		BTC_MSG_ALGORITHM,
@@ -380,68 +378,68 @@ static void halbtc8723b1ant_MonitorBtCtr(struct btc_coexist *pBtCoexist)
 	);
 
 	/*  reset counter */
-	pBtCoexist->fBtcWrite1Byte(pBtCoexist, 0x76e, 0xc);
+	p_bt_coexist->fBtcWrite1Byte(p_bt_coexist, 0x76e, 0xc);
 
 	if ((regHPTx == 0) && (regHPRx == 0) && (regLPTx == 0) && (regLPRx == 0)) {
 		NumOfBtCounterChk++;
 		if (NumOfBtCounterChk >= 3) {
-			halbtc8723b1ant_QueryBtInfo(pBtCoexist);
+			halbtc8723b1ant_QueryBtInfo(p_bt_coexist);
 			NumOfBtCounterChk = 0;
 		}
 	}
 }
 
 
-static void halbtc8723b1ant_MonitorWiFiCtr(struct btc_coexist *pBtCoexist)
+static void halbtc8723b1ant_MonitorWiFiCtr(struct btc_coexist *p_bt_coexist)
 {
 	s32	wifiRssi = 0;
-	bool bWifiBusy = false, bWifiUnderBMode = false;
+	bool bWifiBusy = false, wifi_under_bmode = false;
 	static u8 nCCKLockCounter;
 
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_BUSY, &bWifiBusy);
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_S4_WIFI_RSSI, &wifiRssi);
-	pBtCoexist->fBtcGet(
-		pBtCoexist, BTC_GET_BL_WIFI_UNDER_B_MODE, &bWifiUnderBMode
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_BL_WIFI_BUSY, &bWifiBusy);
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_S4_WIFI_RSSI, &wifiRssi);
+	p_bt_coexist->fBtcGet(
+		p_bt_coexist, BTC_GET_BL_WIFI_UNDER_B_MODE, &wifi_under_bmode
 	);
 
-	if (pCoexSta->bUnderIps) {
-		pCoexSta->nCRCOK_CCK = 0;
-		pCoexSta->nCRCOK_11g = 0;
-		pCoexSta->nCRCOK_11n = 0;
-		pCoexSta->nCRCOK_11nAgg = 0;
+	if (p_coex_sta->bUnderIps) {
+		p_coex_sta->nCRCOK_CCK = 0;
+		p_coex_sta->nCRCOK_11g = 0;
+		p_coex_sta->nCRCOK_11n = 0;
+		p_coex_sta->nCRCOK_11nAgg = 0;
 
-		pCoexSta->nCRCErr_CCK = 0;
-		pCoexSta->nCRCErr_11g = 0;
-		pCoexSta->nCRCErr_11n = 0;
-		pCoexSta->nCRCErr_11nAgg = 0;
+		p_coex_sta->nCRCErr_CCK = 0;
+		p_coex_sta->nCRCErr_11g = 0;
+		p_coex_sta->nCRCErr_11n = 0;
+		p_coex_sta->nCRCErr_11nAgg = 0;
 	} else {
-		pCoexSta->nCRCOK_CCK	= pBtCoexist->fBtcRead4Byte(pBtCoexist, 0xf88);
-		pCoexSta->nCRCOK_11g	= pBtCoexist->fBtcRead2Byte(pBtCoexist, 0xf94);
-		pCoexSta->nCRCOK_11n	= pBtCoexist->fBtcRead2Byte(pBtCoexist, 0xf90);
-		pCoexSta->nCRCOK_11nAgg = pBtCoexist->fBtcRead2Byte(pBtCoexist, 0xfb8);
+		p_coex_sta->nCRCOK_CCK	= p_bt_coexist->fBtcRead4Byte(p_bt_coexist, 0xf88);
+		p_coex_sta->nCRCOK_11g	= p_bt_coexist->fBtcRead2Byte(p_bt_coexist, 0xf94);
+		p_coex_sta->nCRCOK_11n	= p_bt_coexist->fBtcRead2Byte(p_bt_coexist, 0xf90);
+		p_coex_sta->nCRCOK_11nAgg = p_bt_coexist->fBtcRead2Byte(p_bt_coexist, 0xfb8);
 
-		pCoexSta->nCRCErr_CCK	 = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0xf84);
-		pCoexSta->nCRCErr_11g	 = pBtCoexist->fBtcRead2Byte(pBtCoexist, 0xf96);
-		pCoexSta->nCRCErr_11n	 = pBtCoexist->fBtcRead2Byte(pBtCoexist, 0xf92);
-		pCoexSta->nCRCErr_11nAgg = pBtCoexist->fBtcRead2Byte(pBtCoexist, 0xfba);
+		p_coex_sta->nCRCErr_CCK	 = p_bt_coexist->fBtcRead4Byte(p_bt_coexist, 0xf84);
+		p_coex_sta->nCRCErr_11g	 = p_bt_coexist->fBtcRead2Byte(p_bt_coexist, 0xf96);
+		p_coex_sta->nCRCErr_11n	 = p_bt_coexist->fBtcRead2Byte(p_bt_coexist, 0xf92);
+		p_coex_sta->nCRCErr_11nAgg = p_bt_coexist->fBtcRead2Byte(p_bt_coexist, 0xfba);
 	}
 
 
 	/* reset counter */
-	pBtCoexist->fBtcWrite1ByteBitMask(pBtCoexist, 0xf16, 0x1, 0x1);
-	pBtCoexist->fBtcWrite1ByteBitMask(pBtCoexist, 0xf16, 0x1, 0x0);
+	p_bt_coexist->fBtcWrite1ByteBitMask(p_bt_coexist, 0xf16, 0x1, 0x1);
+	p_bt_coexist->fBtcWrite1ByteBitMask(p_bt_coexist, 0xf16, 0x1, 0x0);
 
-	if (bWifiBusy && (wifiRssi >= 30) && !bWifiUnderBMode) {
+	if (bWifiBusy && (wifiRssi >= 30) && !wifi_under_bmode) {
 		if (
-			(pCoexDm->btStatus == BT_8723B_1ANT_BT_STATUS_ACL_BUSY) ||
-			(pCoexDm->btStatus == BT_8723B_1ANT_BT_STATUS_ACL_SCO_BUSY) ||
-			(pCoexDm->btStatus == BT_8723B_1ANT_BT_STATUS_SCO_BUSY)
+			(p_coex_dm->btStatus == BT_8723B_1ANT_BT_STATUS_ACL_BUSY) ||
+			(p_coex_dm->btStatus == BT_8723B_1ANT_BT_STATUS_ACL_SCO_BUSY) ||
+			(p_coex_dm->btStatus == BT_8723B_1ANT_BT_STATUS_SCO_BUSY)
 		) {
 			if (
-				pCoexSta->nCRCOK_CCK > (
-					pCoexSta->nCRCOK_11g +
-					pCoexSta->nCRCOK_11n +
-					pCoexSta->nCRCOK_11nAgg
+				p_coex_sta->nCRCOK_CCK > (
+					p_coex_sta->nCRCOK_11g +
+					p_coex_sta->nCRCOK_11n +
+					p_coex_sta->nCRCOK_11nAgg
 				)
 			) {
 				if (nCCKLockCounter < 5)
@@ -460,37 +458,37 @@ static void halbtc8723b1ant_MonitorWiFiCtr(struct btc_coexist *pBtCoexist)
 			nCCKLockCounter--;
 	}
 
-	if (!pCoexSta->bPreCCKLock) {
+	if (!p_coex_sta->bPreCCKLock) {
 
 		if (nCCKLockCounter >= 5)
-		 pCoexSta->bCCKLock = true;
+		 p_coex_sta->bCCKLock = true;
 		else
-		 pCoexSta->bCCKLock = false;
+		 p_coex_sta->bCCKLock = false;
 	} else {
 		if (nCCKLockCounter == 0)
-		 pCoexSta->bCCKLock = false;
+		 p_coex_sta->bCCKLock = false;
 		else
-		 pCoexSta->bCCKLock = true;
+		 p_coex_sta->bCCKLock = true;
 	}
 
-	pCoexSta->bPreCCKLock =  pCoexSta->bCCKLock;
+	p_coex_sta->bPreCCKLock =  p_coex_sta->bCCKLock;
 
 
 }
 
-static bool halbtc8723b1ant_IsWifiStatusChanged(struct btc_coexist *pBtCoexist)
+static bool halbtc8723b1ant_IsWifiStatusChanged(struct btc_coexist *p_bt_coexist)
 {
 	static bool	bPreWifiBusy, bPreUnder4way, bPreBtHsOn;
 	bool bWifiBusy = false, bUnder4way = false, bBtHsOn = false;
 	bool bWifiConnected = false;
 
-	pBtCoexist->fBtcGet(
-		pBtCoexist, BTC_GET_BL_WIFI_CONNECTED, &bWifiConnected
+	p_bt_coexist->fBtcGet(
+		p_bt_coexist, BTC_GET_BL_WIFI_CONNECTED, &bWifiConnected
 	);
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_BUSY, &bWifiBusy);
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_HS_OPERATION, &bBtHsOn);
-	pBtCoexist->fBtcGet(
-		pBtCoexist, BTC_GET_BL_WIFI_4_WAY_PROGRESS, &bUnder4way
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_BL_WIFI_BUSY, &bWifiBusy);
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_BL_HS_OPERATION, &bBtHsOn);
+	p_bt_coexist->fBtcGet(
+		p_bt_coexist, BTC_GET_BL_WIFI_4_WAY_PROGRESS, &bUnder4way
 	);
 
 	if (bWifiConnected) {
@@ -513,18 +511,18 @@ static bool halbtc8723b1ant_IsWifiStatusChanged(struct btc_coexist *pBtCoexist)
 	return false;
 }
 
-static void halbtc8723b1ant_UpdateBtLinkInfo(struct btc_coexist *pBtCoexist)
+static void halbtc8723b1ant_UpdateBtLinkInfo(struct btc_coexist *p_bt_coexist)
 {
-	struct btc_bt_link_info *pBtLinkInfo = &pBtCoexist->btLinkInfo;
+	struct btc_bt_link_info *pBtLinkInfo = &p_bt_coexist->btLinkInfo;
 	bool bBtHsOn = false;
 
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_HS_OPERATION, &bBtHsOn);
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_BL_HS_OPERATION, &bBtHsOn);
 
-	pBtLinkInfo->bBtLinkExist = pCoexSta->bBtLinkExist;
-	pBtLinkInfo->bScoExist = pCoexSta->bScoExist;
-	pBtLinkInfo->bA2dpExist = pCoexSta->bA2dpExist;
-	pBtLinkInfo->bPanExist = pCoexSta->bPanExist;
-	pBtLinkInfo->bHidExist = pCoexSta->bHidExist;
+	pBtLinkInfo->bBtLinkExist = p_coex_sta->bBtLinkExist;
+	pBtLinkInfo->bScoExist = p_coex_sta->bScoExist;
+	pBtLinkInfo->bA2dpExist = p_coex_sta->bA2dpExist;
+	pBtLinkInfo->bPanExist = p_coex_sta->bPanExist;
+	pBtLinkInfo->bHidExist = p_coex_sta->bHidExist;
 
 	/*  work around for HS mode. */
 	if (bBtHsOn) {
@@ -577,14 +575,14 @@ static void halbtc8723b1ant_UpdateBtLinkInfo(struct btc_coexist *pBtCoexist)
 		pBtLinkInfo->bHidOnly = false;
 }
 
-static u8 halbtc8723b1ant_ActionAlgorithm(struct btc_coexist *pBtCoexist)
+static u8 halbtc8723b1ant_ActionAlgorithm(struct btc_coexist *p_bt_coexist)
 {
-	struct btc_bt_link_info *pBtLinkInfo = &pBtCoexist->btLinkInfo;
+	struct btc_bt_link_info *pBtLinkInfo = &p_bt_coexist->btLinkInfo;
 	bool bBtHsOn = false;
 	u8 algorithm = BT_8723B_1ANT_COEX_ALGO_UNDEFINED;
 	u8 numOfDiffProfile = 0;
 
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_HS_OPERATION, &bBtHsOn);
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_BL_HS_OPERATION, &bBtHsOn);
 
 	if (!pBtLinkInfo->bBtLinkExist) {
 		BTC_PRINT(
@@ -805,19 +803,19 @@ static u8 halbtc8723b1ant_ActionAlgorithm(struct btc_coexist *pBtCoexist)
 }
 
 static void halbtc8723b1ant_SetSwPenaltyTxRateAdaptive(
-	struct btc_coexist *pBtCoexist, bool bLowPenaltyRa
+	struct btc_coexist *p_bt_coexist, bool bLowPenaltyRa
 )
 {
-	u8 	H2C_Parameter[6] = {0};
+	u8 	h2c_parameter[6] = {0};
 
-	H2C_Parameter[0] = 0x6;	/*  opCode, 0x6 = Retry_Penalty */
+	h2c_parameter[0] = 0x6;	/*  opCode, 0x6 = Retry_Penalty */
 
 	if (bLowPenaltyRa) {
-		H2C_Parameter[1] |= BIT0;
-		H2C_Parameter[2] = 0x00;  /* normal rate except MCS7/6/5, OFDM54/48/36 */
-		H2C_Parameter[3] = 0xf7;  /* MCS7 or OFDM54 */
-		H2C_Parameter[4] = 0xf8;  /* MCS6 or OFDM48 */
-		H2C_Parameter[5] = 0xf9;	/* MCS5 or OFDM36 */
+		h2c_parameter[1] |= BIT0;
+		h2c_parameter[2] = 0x00;  /* normal rate except MCS7/6/5, OFDM54/48/36 */
+		h2c_parameter[3] = 0xf7;  /* MCS7 or OFDM54 */
+		h2c_parameter[4] = 0xf8;  /* MCS6 or OFDM48 */
+		h2c_parameter[5] = 0xf9;	/* MCS5 or OFDM36 */
 	}
 
 	BTC_PRINT(
@@ -829,28 +827,28 @@ static void halbtc8723b1ant_SetSwPenaltyTxRateAdaptive(
 		)
 	);
 
-	pBtCoexist->fBtcFillH2c(pBtCoexist, 0x69, 6, H2C_Parameter);
+	p_bt_coexist->fBtcFillH2c(p_bt_coexist, 0x69, 6, h2c_parameter);
 }
 
 static void halbtc8723b1ant_LowPenaltyRa(
-	struct btc_coexist *pBtCoexist, bool bForceExec, bool bLowPenaltyRa
+	struct btc_coexist *p_bt_coexist, bool force_exec, bool bLowPenaltyRa
 )
 {
-	pCoexDm->bCurLowPenaltyRa = bLowPenaltyRa;
+	p_coex_dm->bCurLowPenaltyRa = bLowPenaltyRa;
 
-	if (!bForceExec) {
-		if (pCoexDm->bPreLowPenaltyRa == pCoexDm->bCurLowPenaltyRa)
+	if (!force_exec) {
+		if (p_coex_dm->bPreLowPenaltyRa == p_coex_dm->bCurLowPenaltyRa)
 			return;
 	}
 	halbtc8723b1ant_SetSwPenaltyTxRateAdaptive(
-		pBtCoexist, pCoexDm->bCurLowPenaltyRa
+		p_bt_coexist, p_coex_dm->bCurLowPenaltyRa
 	);
 
-	pCoexDm->bPreLowPenaltyRa = pCoexDm->bCurLowPenaltyRa;
+	p_coex_dm->bPreLowPenaltyRa = p_coex_dm->bCurLowPenaltyRa;
 }
 
 static void halbtc8723b1ant_SetCoexTable(
-	struct btc_coexist *pBtCoexist,
+	struct btc_coexist *p_bt_coexist,
 	u32 val0x6c0,
 	u32 val0x6c4,
 	u32 val0x6c8,
@@ -862,33 +860,33 @@ static void halbtc8723b1ant_SetCoexTable(
 		ALGO_TRACE_SW_EXEC,
 		("[BTCoex], set coex table, set 0x6c0 = 0x%x\n", val0x6c0)
 	);
-	pBtCoexist->fBtcWrite4Byte(pBtCoexist, 0x6c0, val0x6c0);
+	p_bt_coexist->fBtcWrite4Byte(p_bt_coexist, 0x6c0, val0x6c0);
 
 	BTC_PRINT(
 		BTC_MSG_ALGORITHM,
 		ALGO_TRACE_SW_EXEC,
 		("[BTCoex], set coex table, set 0x6c4 = 0x%x\n", val0x6c4)
 	);
-	pBtCoexist->fBtcWrite4Byte(pBtCoexist, 0x6c4, val0x6c4);
+	p_bt_coexist->fBtcWrite4Byte(p_bt_coexist, 0x6c4, val0x6c4);
 
 	BTC_PRINT(
 		BTC_MSG_ALGORITHM,
 		ALGO_TRACE_SW_EXEC,
 		("[BTCoex], set coex table, set 0x6c8 = 0x%x\n", val0x6c8)
 	);
-	pBtCoexist->fBtcWrite4Byte(pBtCoexist, 0x6c8, val0x6c8);
+	p_bt_coexist->fBtcWrite4Byte(p_bt_coexist, 0x6c8, val0x6c8);
 
 	BTC_PRINT(
 		BTC_MSG_ALGORITHM,
 		ALGO_TRACE_SW_EXEC,
 		("[BTCoex], set coex table, set 0x6cc = 0x%x\n", val0x6cc)
 	);
-	pBtCoexist->fBtcWrite1Byte(pBtCoexist, 0x6cc, val0x6cc);
+	p_bt_coexist->fBtcWrite1Byte(p_bt_coexist, 0x6cc, val0x6cc);
 }
 
 static void halbtc8723b1ant_CoexTable(
-	struct btc_coexist *pBtCoexist,
-	bool bForceExec,
+	struct btc_coexist *p_bt_coexist,
+	bool force_exec,
 	u32 val0x6c0,
 	u32 val0x6c4,
 	u32 val0x6c8,
@@ -900,37 +898,37 @@ static void halbtc8723b1ant_CoexTable(
 		ALGO_TRACE_SW,
 		(
 			"[BTCoex], %s write Coex Table 0x6c0 = 0x%x, 0x6c4 = 0x%x, 0x6cc = 0x%x\n",
-			(bForceExec ? "force to" : ""),
+			(force_exec ? "force to" : ""),
 			val0x6c0, val0x6c4, val0x6cc
 		)
 	);
-	pCoexDm->curVal0x6c0 = val0x6c0;
-	pCoexDm->curVal0x6c4 = val0x6c4;
-	pCoexDm->curVal0x6c8 = val0x6c8;
-	pCoexDm->curVal0x6cc = val0x6cc;
+	p_coex_dm->curVal0x6c0 = val0x6c0;
+	p_coex_dm->curVal0x6c4 = val0x6c4;
+	p_coex_dm->curVal0x6c8 = val0x6c8;
+	p_coex_dm->curVal0x6cc = val0x6cc;
 
-	if (!bForceExec) {
+	if (!force_exec) {
 		if (
-			(pCoexDm->preVal0x6c0 == pCoexDm->curVal0x6c0) &&
-		    (pCoexDm->preVal0x6c4 == pCoexDm->curVal0x6c4) &&
-		    (pCoexDm->preVal0x6c8 == pCoexDm->curVal0x6c8) &&
-		    (pCoexDm->preVal0x6cc == pCoexDm->curVal0x6cc)
+			(p_coex_dm->preVal0x6c0 == p_coex_dm->curVal0x6c0) &&
+		    (p_coex_dm->preVal0x6c4 == p_coex_dm->curVal0x6c4) &&
+		    (p_coex_dm->preVal0x6c8 == p_coex_dm->curVal0x6c8) &&
+		    (p_coex_dm->preVal0x6cc == p_coex_dm->curVal0x6cc)
 		)
 			return;
 	}
 
 	halbtc8723b1ant_SetCoexTable(
-		pBtCoexist, val0x6c0, val0x6c4, val0x6c8, val0x6cc
+		p_bt_coexist, val0x6c0, val0x6c4, val0x6c8, val0x6cc
 	);
 
-	pCoexDm->preVal0x6c0 = pCoexDm->curVal0x6c0;
-	pCoexDm->preVal0x6c4 = pCoexDm->curVal0x6c4;
-	pCoexDm->preVal0x6c8 = pCoexDm->curVal0x6c8;
-	pCoexDm->preVal0x6cc = pCoexDm->curVal0x6cc;
+	p_coex_dm->preVal0x6c0 = p_coex_dm->curVal0x6c0;
+	p_coex_dm->preVal0x6c4 = p_coex_dm->curVal0x6c4;
+	p_coex_dm->preVal0x6c8 = p_coex_dm->curVal0x6c8;
+	p_coex_dm->preVal0x6cc = p_coex_dm->curVal0x6cc;
 }
 
 static void halbtc8723b1ant_CoexTableWithType(
-	struct btc_coexist *pBtCoexist, bool bForceExec, u8 type
+	struct btc_coexist *p_bt_coexist, bool force_exec, u8 type
 )
 {
 	BTC_PRINT(
@@ -939,47 +937,47 @@ static void halbtc8723b1ant_CoexTableWithType(
 		("[BTCoex], ********** CoexTable(%d) **********\n", type)
 	);
 
-	pCoexSta->nCoexTableType = type;
+	p_coex_sta->nCoexTableType = type;
 
 	switch (type) {
 	case 0:
 		halbtc8723b1ant_CoexTable(
-			pBtCoexist, bForceExec, 0x55555555, 0x55555555, 0xffffff, 0x3
+			p_bt_coexist, force_exec, 0x55555555, 0x55555555, 0xffffff, 0x3
 		);
 		break;
 	case 1:
 		halbtc8723b1ant_CoexTable(
-			pBtCoexist, bForceExec, 0x55555555, 0x5a5a5a5a, 0xffffff, 0x3
+			p_bt_coexist, force_exec, 0x55555555, 0x5a5a5a5a, 0xffffff, 0x3
 		);
 		break;
 	case 2:
 		halbtc8723b1ant_CoexTable(
-			pBtCoexist, bForceExec, 0x5a5a5a5a, 0x5a5a5a5a, 0xffffff, 0x3
+			p_bt_coexist, force_exec, 0x5a5a5a5a, 0x5a5a5a5a, 0xffffff, 0x3
 		);
 		break;
 	case 3:
 		halbtc8723b1ant_CoexTable(
-			pBtCoexist, bForceExec, 0xaaaa5555, 0xaaaa5a5a, 0xffffff, 0x3
+			p_bt_coexist, force_exec, 0xaaaa5555, 0xaaaa5a5a, 0xffffff, 0x3
 		);
 		break;
 	case 4:
 		halbtc8723b1ant_CoexTable(
-			pBtCoexist, bForceExec, 0x55555555, 0xaaaa5a5a, 0xffffff, 0x3
+			p_bt_coexist, force_exec, 0x55555555, 0xaaaa5a5a, 0xffffff, 0x3
 		);
 		break;
 	case 5:
 		halbtc8723b1ant_CoexTable(
-			pBtCoexist, bForceExec, 0x5a5a5a5a, 0xaaaa5a5a, 0xffffff, 0x3
+			p_bt_coexist, force_exec, 0x5a5a5a5a, 0xaaaa5a5a, 0xffffff, 0x3
 		);
 		break;
 	case 6:
 		halbtc8723b1ant_CoexTable(
-			pBtCoexist, bForceExec, 0x55555555, 0xaaaaaaaa, 0xffffff, 0x3
+			p_bt_coexist, force_exec, 0x55555555, 0xaaaaaaaa, 0xffffff, 0x3
 		);
 		break;
 	case 7:
 		halbtc8723b1ant_CoexTable(
-			pBtCoexist, bForceExec, 0xaaaaaaaa, 0xaaaaaaaa, 0xffffff, 0x3
+			p_bt_coexist, force_exec, 0xaaaaaaaa, 0xaaaaaaaa, 0xffffff, 0x3
 		);
 		break;
 	default:
@@ -988,28 +986,28 @@ static void halbtc8723b1ant_CoexTableWithType(
 }
 
 static void halbtc8723b1ant_SetFwIgnoreWlanAct(
-	struct btc_coexist *pBtCoexist, bool bEnable
+	struct btc_coexist *p_bt_coexist, bool bEnable
 )
 {
-	u8 H2C_Parameter[1] = {0};
+	u8 h2c_parameter[1] = {0};
 
 	if (bEnable)
-		H2C_Parameter[0] |= BIT0; /* function enable */
+		h2c_parameter[0] |= BIT0; /* function enable */
 
 	BTC_PRINT(
 		BTC_MSG_ALGORITHM,
 		ALGO_TRACE_FW_EXEC,
 		(
 			"[BTCoex], set FW for BT Ignore Wlan_Act, FW write 0x63 = 0x%x\n",
-			H2C_Parameter[0]
+			h2c_parameter[0]
 		)
 	);
 
-	pBtCoexist->fBtcFillH2c(pBtCoexist, 0x63, 1, H2C_Parameter);
+	p_bt_coexist->fBtcFillH2c(p_bt_coexist, 0x63, 1, h2c_parameter);
 }
 
 static void halbtc8723b1ant_IgnoreWlanAct(
-	struct btc_coexist *pBtCoexist, bool bForceExec, bool bEnable
+	struct btc_coexist *p_bt_coexist, bool force_exec, bool bEnable
 )
 {
 	BTC_PRINT(
@@ -1017,44 +1015,44 @@ static void halbtc8723b1ant_IgnoreWlanAct(
 		ALGO_TRACE_FW,
 		(
 			"[BTCoex], %s turn Ignore WlanAct %s\n",
-			(bForceExec ? "force to" : ""),
+			(force_exec ? "force to" : ""),
 			(bEnable ? "ON" : "OFF")
 		)
 	);
-	pCoexDm->bCurIgnoreWlanAct = bEnable;
+	p_coex_dm->bCurIgnoreWlanAct = bEnable;
 
-	if (!bForceExec) {
+	if (!force_exec) {
 		BTC_PRINT(
 			BTC_MSG_ALGORITHM,
 			ALGO_TRACE_FW_DETAIL,
 			(
 				"[BTCoex], bPreIgnoreWlanAct = %d, bCurIgnoreWlanAct = %d!!\n",
-				pCoexDm->bPreIgnoreWlanAct,
-				pCoexDm->bCurIgnoreWlanAct
+				p_coex_dm->bPreIgnoreWlanAct,
+				p_coex_dm->bCurIgnoreWlanAct
 			)
 		);
 
-		if (pCoexDm->bPreIgnoreWlanAct == pCoexDm->bCurIgnoreWlanAct)
+		if (p_coex_dm->bPreIgnoreWlanAct == p_coex_dm->bCurIgnoreWlanAct)
 			return;
 	}
-	halbtc8723b1ant_SetFwIgnoreWlanAct(pBtCoexist, bEnable);
+	halbtc8723b1ant_SetFwIgnoreWlanAct(p_bt_coexist, bEnable);
 
-	pCoexDm->bPreIgnoreWlanAct = pCoexDm->bCurIgnoreWlanAct;
+	p_coex_dm->bPreIgnoreWlanAct = p_coex_dm->bCurIgnoreWlanAct;
 }
 
 static void halbtc8723b1ant_SetLpsRpwm(
-	struct btc_coexist *pBtCoexist, u8 lpsVal, u8 rpwmVal
+	struct btc_coexist *p_bt_coexist, u8 lpsVal, u8 rpwmVal
 )
 {
 	u8 lps = lpsVal;
 	u8 rpwm = rpwmVal;
 
-	pBtCoexist->fBtcSet(pBtCoexist, BTC_SET_U1_LPS_VAL, &lps);
-	pBtCoexist->fBtcSet(pBtCoexist, BTC_SET_U1_RPWM_VAL, &rpwm);
+	p_bt_coexist->fBtcSet(p_bt_coexist, BTC_SET_U1_LPS_VAL, &lps);
+	p_bt_coexist->fBtcSet(p_bt_coexist, BTC_SET_U1_RPWM_VAL, &rpwm);
 }
 
 static void halbtc8723b1ant_LpsRpwm(
-	struct btc_coexist *pBtCoexist, bool bForceExec, u8 lpsVal, u8 rpwmVal
+	struct btc_coexist *p_bt_coexist, bool force_exec, u8 lpsVal, u8 rpwmVal
 )
 {
 	BTC_PRINT(
@@ -1062,50 +1060,50 @@ static void halbtc8723b1ant_LpsRpwm(
 		ALGO_TRACE_FW,
 		(
 			"[BTCoex], %s set lps/rpwm = 0x%x/0x%x\n",
-			(bForceExec ? "force to" : ""),
+			(force_exec ? "force to" : ""),
 			lpsVal,
 			rpwmVal
 		)
 	);
-	pCoexDm->curLps = lpsVal;
-	pCoexDm->curRpwm = rpwmVal;
+	p_coex_dm->curLps = lpsVal;
+	p_coex_dm->curRpwm = rpwmVal;
 
-	if (!bForceExec) {
+	if (!force_exec) {
 		BTC_PRINT(
 			BTC_MSG_ALGORITHM,
 			ALGO_TRACE_FW_DETAIL,
 			(
 				"[BTCoex], LPS-RxBeaconMode = 0x%x , LPS-RPWM = 0x%x!!\n",
-				pCoexDm->curLps,
-				pCoexDm->curRpwm
+				p_coex_dm->curLps,
+				p_coex_dm->curRpwm
 			)
 		);
 
 		if (
-			(pCoexDm->preLps == pCoexDm->curLps) &&
-			(pCoexDm->preRpwm == pCoexDm->curRpwm)
+			(p_coex_dm->preLps == p_coex_dm->curLps) &&
+			(p_coex_dm->preRpwm == p_coex_dm->curRpwm)
 		) {
 			BTC_PRINT(
 				BTC_MSG_ALGORITHM,
 				ALGO_TRACE_FW_DETAIL,
 				(
 					"[BTCoex], LPS-RPWM_Last = 0x%x , LPS-RPWM_Now = 0x%x!!\n",
-					pCoexDm->preRpwm,
-					pCoexDm->curRpwm
+					p_coex_dm->preRpwm,
+					p_coex_dm->curRpwm
 				)
 			);
 
 			return;
 		}
 	}
-	halbtc8723b1ant_SetLpsRpwm(pBtCoexist, lpsVal, rpwmVal);
+	halbtc8723b1ant_SetLpsRpwm(p_bt_coexist, lpsVal, rpwmVal);
 
-	pCoexDm->preLps = pCoexDm->curLps;
-	pCoexDm->preRpwm = pCoexDm->curRpwm;
+	p_coex_dm->preLps = p_coex_dm->curLps;
+	p_coex_dm->preRpwm = p_coex_dm->curRpwm;
 }
 
 static void halbtc8723b1ant_SwMechanism(
-	struct btc_coexist *pBtCoexist, bool bLowPenaltyRA
+	struct btc_coexist *p_bt_coexist, bool bLowPenaltyRA
 )
 {
 	BTC_PRINT(
@@ -1114,79 +1112,79 @@ static void halbtc8723b1ant_SwMechanism(
 		("[BTCoex], SM[LpRA] = %d\n", bLowPenaltyRA)
 	);
 
-	halbtc8723b1ant_LowPenaltyRa(pBtCoexist, NORMAL_EXEC, bLowPenaltyRA);
+	halbtc8723b1ant_LowPenaltyRa(p_bt_coexist, NORMAL_EXEC, bLowPenaltyRA);
 }
 
 static void halbtc8723b1ant_SetAntPath(
-	struct btc_coexist *pBtCoexist, u8 antPosType, bool bInitHwCfg, bool bWifiOff
+	struct btc_coexist *p_bt_coexist, u8 antPosType, bool bInitHwCfg, bool bWifiOff
 )
 {
-	struct btc_board_info *pBoardInfo = &pBtCoexist->boardInfo;
-	u32 fwVer = 0, u4Tmp = 0, cntBtCalChk = 0;
+	struct btc_board_info *pBoardInfo = &p_bt_coexist->boardInfo;
+	u32 fw_ver = 0, u4Tmp = 0, cntBtCalChk = 0;
 	bool bPgExtSwitch = false;
 	bool bUseExtSwitch = false;
 	bool bIsInMpMode = false;
-	u8 H2C_Parameter[2] = {0}, u1Tmp = 0;
+	u8 h2c_parameter[2] = {0}, u1Tmp = 0;
 
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_EXT_SWITCH, &bPgExtSwitch);
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_U4_WIFI_FW_VER, &fwVer); /*  [31:16]=fw ver, [15:0]=fw sub ver */
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_BL_EXT_SWITCH, &bPgExtSwitch);
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_U4_WIFI_FW_VER, &fw_ver); /*  [31:16]=fw ver, [15:0]=fw sub ver */
 
-	if ((fwVer > 0 && fwVer < 0xc0000) || bPgExtSwitch)
+	if ((fw_ver > 0 && fw_ver < 0xc0000) || bPgExtSwitch)
 		bUseExtSwitch = true;
 
 	if (bInitHwCfg) {
-		pBtCoexist->fBtcSetRfReg(pBtCoexist, BTC_RF_A, 0x1, 0xfffff, 0x780); /* WiFi TRx Mask on */
-		pBtCoexist->fBtcSetBtReg(pBtCoexist, BTC_BT_REG_RF, 0x3c, 0x15); /* BT TRx Mask on */
+		p_bt_coexist->fBtcSetRfReg(p_bt_coexist, BTC_RF_A, 0x1, 0xfffff, 0x780); /* WiFi TRx Mask on */
+		p_bt_coexist->fBtcSetBtReg(p_bt_coexist, BTC_BT_REG_RF, 0x3c, 0x15); /* BT TRx Mask on */
 
-		if (fwVer >= 0x180000) {
+		if (fw_ver >= 0x180000) {
 			/* Use H2C to set GNT_BT to HIGH */
-			H2C_Parameter[0] = 1;
-			pBtCoexist->fBtcFillH2c(pBtCoexist, 0x6E, 1, H2C_Parameter);
+			h2c_parameter[0] = 1;
+			p_bt_coexist->fBtcFillH2c(p_bt_coexist, 0x6E, 1, h2c_parameter);
 		} else /*  set grant_bt to high */
-			pBtCoexist->fBtcWrite1Byte(pBtCoexist, 0x765, 0x18);
+			p_bt_coexist->fBtcWrite1Byte(p_bt_coexist, 0x765, 0x18);
 
 		/* set wlan_act control by PTA */
-		pBtCoexist->fBtcWrite1Byte(pBtCoexist, 0x76e, 0x4);
+		p_bt_coexist->fBtcWrite1Byte(p_bt_coexist, 0x76e, 0x4);
 
-		pBtCoexist->fBtcWrite1ByteBitMask(pBtCoexist, 0x67, 0x20, 0x1); /* BT select s0/s1 is controlled by WiFi */
+		p_bt_coexist->fBtcWrite1ByteBitMask(p_bt_coexist, 0x67, 0x20, 0x1); /* BT select s0/s1 is controlled by WiFi */
 
-		pBtCoexist->fBtcWrite1ByteBitMask(pBtCoexist, 0x39, 0x8, 0x1);
-		pBtCoexist->fBtcWrite1Byte(pBtCoexist, 0x974, 0xff);
-		pBtCoexist->fBtcWrite1ByteBitMask(pBtCoexist, 0x944, 0x3, 0x3);
-		pBtCoexist->fBtcWrite1Byte(pBtCoexist, 0x930, 0x77);
+		p_bt_coexist->fBtcWrite1ByteBitMask(p_bt_coexist, 0x39, 0x8, 0x1);
+		p_bt_coexist->fBtcWrite1Byte(p_bt_coexist, 0x974, 0xff);
+		p_bt_coexist->fBtcWrite1ByteBitMask(p_bt_coexist, 0x944, 0x3, 0x3);
+		p_bt_coexist->fBtcWrite1Byte(p_bt_coexist, 0x930, 0x77);
 	} else if (bWifiOff) {
-		if (fwVer >= 0x180000) {
+		if (fw_ver >= 0x180000) {
 			/* Use H2C to set GNT_BT to HIGH */
-			H2C_Parameter[0] = 1;
-			pBtCoexist->fBtcFillH2c(pBtCoexist, 0x6E, 1, H2C_Parameter);
+			h2c_parameter[0] = 1;
+			p_bt_coexist->fBtcFillH2c(p_bt_coexist, 0x6E, 1, h2c_parameter);
 		} else /*  set grant_bt to high */
-			pBtCoexist->fBtcWrite1Byte(pBtCoexist, 0x765, 0x18);
+			p_bt_coexist->fBtcWrite1Byte(p_bt_coexist, 0x765, 0x18);
 
 		/* set wlan_act to always low */
-		pBtCoexist->fBtcWrite1Byte(pBtCoexist, 0x76e, 0x4);
+		p_bt_coexist->fBtcWrite1Byte(p_bt_coexist, 0x76e, 0x4);
 
-		pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_IS_IN_MP_MODE, &bIsInMpMode);
+		p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_BL_WIFI_IS_IN_MP_MODE, &bIsInMpMode);
 		if (!bIsInMpMode)
-			pBtCoexist->fBtcWrite1ByteBitMask(pBtCoexist, 0x67, 0x20, 0x0); /* BT select s0/s1 is controlled by BT */
+			p_bt_coexist->fBtcWrite1ByteBitMask(p_bt_coexist, 0x67, 0x20, 0x0); /* BT select s0/s1 is controlled by BT */
 		else
-			pBtCoexist->fBtcWrite1ByteBitMask(pBtCoexist, 0x67, 0x20, 0x1); /* BT select s0/s1 is controlled by WiFi */
+			p_bt_coexist->fBtcWrite1ByteBitMask(p_bt_coexist, 0x67, 0x20, 0x1); /* BT select s0/s1 is controlled by WiFi */
 
 		/*  0x4c[24:23]= 00, Set Antenna control by BT_RFE_CTRL	BT Vendor 0xac = 0xf002 */
-		u4Tmp = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x4c);
+		u4Tmp = p_bt_coexist->fBtcRead4Byte(p_bt_coexist, 0x4c);
 		u4Tmp &= ~BIT23;
 		u4Tmp &= ~BIT24;
-		pBtCoexist->fBtcWrite4Byte(pBtCoexist, 0x4c, u4Tmp);
+		p_bt_coexist->fBtcWrite4Byte(p_bt_coexist, 0x4c, u4Tmp);
 	} else {
 		/* Use H2C to set GNT_BT to LOW */
-		if (fwVer >= 0x180000) {
-			if (pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x765) != 0) {
-				H2C_Parameter[0] = 0;
-				pBtCoexist->fBtcFillH2c(pBtCoexist, 0x6E, 1, H2C_Parameter);
+		if (fw_ver >= 0x180000) {
+			if (p_bt_coexist->fBtcRead1Byte(p_bt_coexist, 0x765) != 0) {
+				h2c_parameter[0] = 0;
+				p_bt_coexist->fBtcFillH2c(p_bt_coexist, 0x6E, 1, h2c_parameter);
 			}
 		} else {
 			/*  BT calibration check */
 			while (cntBtCalChk <= 20) {
-				u1Tmp = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x49d);
+				u1Tmp = p_bt_coexist->fBtcRead1Byte(p_bt_coexist, 0x49d);
 				cntBtCalChk++;
 
 				if (u1Tmp & BIT0) {
@@ -1199,34 +1197,34 @@ static void halbtc8723b1ant_SetAntPath(
 			}
 
 			/*  set grant_bt to PTA */
-			pBtCoexist->fBtcWrite1Byte(pBtCoexist, 0x765, 0x0);
+			p_bt_coexist->fBtcWrite1Byte(p_bt_coexist, 0x765, 0x0);
 		}
 
-		if (pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x76e) != 0xc)
+		if (p_bt_coexist->fBtcRead1Byte(p_bt_coexist, 0x76e) != 0xc)
 			/* set wlan_act control by PTA */
-			pBtCoexist->fBtcWrite1Byte(pBtCoexist, 0x76e, 0xc);
+			p_bt_coexist->fBtcWrite1Byte(p_bt_coexist, 0x76e, 0xc);
 	}
 
 	if (bUseExtSwitch) {
 		if (bInitHwCfg) {
 			/*  0x4c[23]= 0, 0x4c[24]= 1  Antenna control by WL/BT */
-			u4Tmp = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x4c);
+			u4Tmp = p_bt_coexist->fBtcRead4Byte(p_bt_coexist, 0x4c);
 			u4Tmp &= ~BIT23;
 			u4Tmp |= BIT24;
-			pBtCoexist->fBtcWrite4Byte(pBtCoexist, 0x4c, u4Tmp);
+			p_bt_coexist->fBtcWrite4Byte(p_bt_coexist, 0x4c, u4Tmp);
 
-			pBtCoexist->fBtcWrite4Byte(pBtCoexist, 0x948, 0x0); /*  fixed internal switch S1->WiFi, S0->BT */
+			p_bt_coexist->fBtcWrite4Byte(p_bt_coexist, 0x948, 0x0); /*  fixed internal switch S1->WiFi, S0->BT */
 
 			if (pBoardInfo->btdmAntPos == BTC_ANTENNA_AT_MAIN_PORT) {
 				/* tell firmware "no antenna inverse" */
-				H2C_Parameter[0] = 0;
-				H2C_Parameter[1] = 1;  /* ext switch type */
-				pBtCoexist->fBtcFillH2c(pBtCoexist, 0x65, 2, H2C_Parameter);
+				h2c_parameter[0] = 0;
+				h2c_parameter[1] = 1;  /* ext switch type */
+				p_bt_coexist->fBtcFillH2c(p_bt_coexist, 0x65, 2, h2c_parameter);
 			} else {
 				/* tell firmware "antenna inverse" */
-				H2C_Parameter[0] = 1;
-				H2C_Parameter[1] = 1;  /* ext switch type */
-				pBtCoexist->fBtcFillH2c(pBtCoexist, 0x65, 2, H2C_Parameter);
+				h2c_parameter[0] = 1;
+				h2c_parameter[1] = 1;  /* ext switch type */
+				p_bt_coexist->fBtcFillH2c(p_bt_coexist, 0x65, 2, h2c_parameter);
 			}
 		}
 
@@ -1235,48 +1233,48 @@ static void halbtc8723b1ant_SetAntPath(
 		switch (antPosType) {
 		case BTC_ANT_PATH_WIFI:
 			if (pBoardInfo->btdmAntPos == BTC_ANTENNA_AT_MAIN_PORT)
-				pBtCoexist->fBtcWrite1ByteBitMask(pBtCoexist, 0x92c, 0x3, 0x1);
+				p_bt_coexist->fBtcWrite1ByteBitMask(p_bt_coexist, 0x92c, 0x3, 0x1);
 			else
-				pBtCoexist->fBtcWrite1ByteBitMask(pBtCoexist, 0x92c, 0x3, 0x2);
+				p_bt_coexist->fBtcWrite1ByteBitMask(p_bt_coexist, 0x92c, 0x3, 0x2);
 			break;
 		case BTC_ANT_PATH_BT:
 			if (pBoardInfo->btdmAntPos == BTC_ANTENNA_AT_MAIN_PORT)
-				pBtCoexist->fBtcWrite1ByteBitMask(pBtCoexist, 0x92c, 0x3, 0x2);
+				p_bt_coexist->fBtcWrite1ByteBitMask(p_bt_coexist, 0x92c, 0x3, 0x2);
 			else
-				pBtCoexist->fBtcWrite1ByteBitMask(pBtCoexist, 0x92c, 0x3, 0x1);
+				p_bt_coexist->fBtcWrite1ByteBitMask(p_bt_coexist, 0x92c, 0x3, 0x1);
 			break;
 		default:
 		case BTC_ANT_PATH_PTA:
 			if (pBoardInfo->btdmAntPos == BTC_ANTENNA_AT_MAIN_PORT)
-				pBtCoexist->fBtcWrite1ByteBitMask(pBtCoexist, 0x92c, 0x3, 0x1);
+				p_bt_coexist->fBtcWrite1ByteBitMask(p_bt_coexist, 0x92c, 0x3, 0x1);
 			else
-				pBtCoexist->fBtcWrite1ByteBitMask(pBtCoexist, 0x92c, 0x3, 0x2);
+				p_bt_coexist->fBtcWrite1ByteBitMask(p_bt_coexist, 0x92c, 0x3, 0x2);
 			break;
 		}
 
 	} else {
 		if (bInitHwCfg) {
 			/*  0x4c[23]= 1, 0x4c[24]= 0  Antenna control by 0x64 */
-			u4Tmp = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x4c);
+			u4Tmp = p_bt_coexist->fBtcRead4Byte(p_bt_coexist, 0x4c);
 			u4Tmp |= BIT23;
 			u4Tmp &= ~BIT24;
-			pBtCoexist->fBtcWrite4Byte(pBtCoexist, 0x4c, u4Tmp);
+			p_bt_coexist->fBtcWrite4Byte(p_bt_coexist, 0x4c, u4Tmp);
 
 			/* Fix Ext switch Main->S1, Aux->S0 */
-			pBtCoexist->fBtcWrite1ByteBitMask(pBtCoexist, 0x64, 0x1, 0x0);
+			p_bt_coexist->fBtcWrite1ByteBitMask(p_bt_coexist, 0x64, 0x1, 0x0);
 
 			if (pBoardInfo->btdmAntPos == BTC_ANTENNA_AT_MAIN_PORT) {
 
 				/* tell firmware "no antenna inverse" */
-				H2C_Parameter[0] = 0;
-				H2C_Parameter[1] = 0;  /* internal switch type */
-				pBtCoexist->fBtcFillH2c(pBtCoexist, 0x65, 2, H2C_Parameter);
+				h2c_parameter[0] = 0;
+				h2c_parameter[1] = 0;  /* internal switch type */
+				p_bt_coexist->fBtcFillH2c(p_bt_coexist, 0x65, 2, h2c_parameter);
 			} else {
 
 				/* tell firmware "antenna inverse" */
-				H2C_Parameter[0] = 1;
-				H2C_Parameter[1] = 0;  /* internal switch type */
-				pBtCoexist->fBtcFillH2c(pBtCoexist, 0x65, 2, H2C_Parameter);
+				h2c_parameter[0] = 1;
+				h2c_parameter[1] = 0;  /* internal switch type */
+				p_bt_coexist->fBtcFillH2c(p_bt_coexist, 0x65, 2, h2c_parameter);
 			}
 		}
 
@@ -1285,36 +1283,36 @@ static void halbtc8723b1ant_SetAntPath(
 		switch (antPosType) {
 		case BTC_ANT_PATH_WIFI:
 			if (pBoardInfo->btdmAntPos == BTC_ANTENNA_AT_MAIN_PORT)
-				pBtCoexist->fBtcWrite4Byte(pBtCoexist, 0x948, 0x0);
+				p_bt_coexist->fBtcWrite4Byte(p_bt_coexist, 0x948, 0x0);
 			else
-				pBtCoexist->fBtcWrite4Byte(pBtCoexist, 0x948, 0x280);
+				p_bt_coexist->fBtcWrite4Byte(p_bt_coexist, 0x948, 0x280);
 			break;
 		case BTC_ANT_PATH_BT:
 			if (pBoardInfo->btdmAntPos == BTC_ANTENNA_AT_MAIN_PORT)
-				pBtCoexist->fBtcWrite4Byte(pBtCoexist, 0x948, 0x280);
+				p_bt_coexist->fBtcWrite4Byte(p_bt_coexist, 0x948, 0x280);
 			else
-				pBtCoexist->fBtcWrite4Byte(pBtCoexist, 0x948, 0x0);
+				p_bt_coexist->fBtcWrite4Byte(p_bt_coexist, 0x948, 0x0);
 			break;
 		default:
 		case BTC_ANT_PATH_PTA:
 			if (pBoardInfo->btdmAntPos == BTC_ANTENNA_AT_MAIN_PORT)
-				pBtCoexist->fBtcWrite4Byte(pBtCoexist, 0x948, 0x200);
+				p_bt_coexist->fBtcWrite4Byte(p_bt_coexist, 0x948, 0x200);
 			else
-				pBtCoexist->fBtcWrite4Byte(pBtCoexist, 0x948, 0x80);
+				p_bt_coexist->fBtcWrite4Byte(p_bt_coexist, 0x948, 0x80);
 			break;
 		}
 	}
 }
 
 static void halbtc8723b1ant_SetFwPstdma(
-	struct btc_coexist *pBtCoexist, u8 byte1, u8 byte2, u8 byte3, u8 byte4, u8 byte5
+	struct btc_coexist *p_bt_coexist, u8 byte1, u8 byte2, u8 byte3, u8 byte4, u8 byte5
 )
 {
-	u8 H2C_Parameter[5] = {0};
+	u8 h2c_parameter[5] = {0};
 	u8 realByte1 = byte1, realByte5 = byte5;
 	bool bApEnable = false;
 
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_AP_MODE_ENABLE, &bApEnable);
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_BL_WIFI_AP_MODE_ENABLE, &bApEnable);
 
 	if (bApEnable) {
 		if (byte1 & BIT4 && !(byte1 & BIT5)) {
@@ -1331,60 +1329,60 @@ static void halbtc8723b1ant_SetFwPstdma(
 		}
 	}
 
-	H2C_Parameter[0] = realByte1;
-	H2C_Parameter[1] = byte2;
-	H2C_Parameter[2] = byte3;
-	H2C_Parameter[3] = byte4;
-	H2C_Parameter[4] = realByte5;
+	h2c_parameter[0] = realByte1;
+	h2c_parameter[1] = byte2;
+	h2c_parameter[2] = byte3;
+	h2c_parameter[3] = byte4;
+	h2c_parameter[4] = realByte5;
 
-	pCoexDm->psTdmaPara[0] = realByte1;
-	pCoexDm->psTdmaPara[1] = byte2;
-	pCoexDm->psTdmaPara[2] = byte3;
-	pCoexDm->psTdmaPara[3] = byte4;
-	pCoexDm->psTdmaPara[4] = realByte5;
+	p_coex_dm->psTdmaPara[0] = realByte1;
+	p_coex_dm->psTdmaPara[1] = byte2;
+	p_coex_dm->psTdmaPara[2] = byte3;
+	p_coex_dm->psTdmaPara[3] = byte4;
+	p_coex_dm->psTdmaPara[4] = realByte5;
 
 	BTC_PRINT(
 		BTC_MSG_ALGORITHM,
 		ALGO_TRACE_FW_EXEC,
 		(
 			"[BTCoex], PS-TDMA H2C cmd = 0x%x%08x\n",
-			H2C_Parameter[0],
-			H2C_Parameter[1] << 24 |
-			H2C_Parameter[2] << 16 |
-			H2C_Parameter[3] << 8 |
-			H2C_Parameter[4]
+			h2c_parameter[0],
+			h2c_parameter[1] << 24 |
+			h2c_parameter[2] << 16 |
+			h2c_parameter[3] << 8 |
+			h2c_parameter[4]
 		)
 	);
 
-	pBtCoexist->fBtcFillH2c(pBtCoexist, 0x60, 5, H2C_Parameter);
+	p_bt_coexist->fBtcFillH2c(p_bt_coexist, 0x60, 5, h2c_parameter);
 }
 
 
 static void halbtc8723b1ant_PsTdma(
-	struct btc_coexist *pBtCoexist, bool bForceExec, bool bTurnOn, u8 type
+	struct btc_coexist *p_bt_coexist, bool force_exec, bool bTurnOn, u8 type
 )
 {
-	struct btc_bt_link_info *pBtLinkInfo = &pBtCoexist->btLinkInfo;
+	struct btc_bt_link_info *pBtLinkInfo = &p_bt_coexist->btLinkInfo;
 	bool bWifiBusy = false;
 	u8 rssiAdjustVal = 0;
 	u8 psTdmaByte4Val = 0x50, psTdmaByte0Val = 0x51, psTdmaByte3Val =  0x10;
 	s8 nWiFiDurationAdjust = 0x0;
-	/* u32 		fwVer = 0; */
+	/* u32 		fw_ver = 0; */
 
 	/* BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE_FW, ("[BTCoex], %s turn %s PS TDMA, type =%d\n", */
-	/* 	(bForceExec? "force to":""), (bTurnOn? "ON":"OFF"), type)); */
-	pCoexDm->bCurPsTdmaOn = bTurnOn;
-	pCoexDm->curPsTdma = type;
+	/* 	(force_exec? "force to":""), (bTurnOn? "ON":"OFF"), type)); */
+	p_coex_dm->bCurPsTdmaOn = bTurnOn;
+	p_coex_dm->curPsTdma = type;
 
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_BUSY, &bWifiBusy);
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_BL_WIFI_BUSY, &bWifiBusy);
 
-	if (pCoexDm->bCurPsTdmaOn) {
+	if (p_coex_dm->bCurPsTdmaOn) {
 		BTC_PRINT(
 			BTC_MSG_ALGORITHM,
 			ALGO_TRACE,
 			(
 				"[BTCoex], ********** TDMA(on, %d) **********\n",
-				pCoexDm->curPsTdma
+				p_coex_dm->curPsTdma
 			)
 		);
 	} else {
@@ -1393,27 +1391,27 @@ static void halbtc8723b1ant_PsTdma(
 			ALGO_TRACE,
 			(
 				"[BTCoex], ********** TDMA(off, %d) **********\n",
-				pCoexDm->curPsTdma
+				p_coex_dm->curPsTdma
 			)
 		);
 	}
 
-	if (!bForceExec) {
+	if (!force_exec) {
 		if (
-			(pCoexDm->bPrePsTdmaOn == pCoexDm->bCurPsTdmaOn) &&
-			(pCoexDm->prePsTdma == pCoexDm->curPsTdma)
+			(p_coex_dm->bPrePsTdmaOn == p_coex_dm->bCurPsTdmaOn) &&
+			(p_coex_dm->prePsTdma == p_coex_dm->curPsTdma)
 		)
 			return;
 	}
 
-	if (pCoexSta->nScanAPNum <= 5)
+	if (p_coex_sta->nScanAPNum <= 5)
 		nWiFiDurationAdjust = 5;
-	else if  (pCoexSta->nScanAPNum >= 40)
+	else if  (p_coex_sta->nScanAPNum >= 40)
 		nWiFiDurationAdjust = -15;
-	else if  (pCoexSta->nScanAPNum >= 20)
+	else if  (p_coex_sta->nScanAPNum >= 20)
 		nWiFiDurationAdjust = -10;
 
-	if (!pCoexSta->bForceLpsOn) { /* only for A2DP-only case 1/2/9/11 */
+	if (!p_coex_sta->bForceLpsOn) { /* only for A2DP-only case 1/2/9/11 */
 		psTdmaByte0Val = 0x61;  /* no null-pkt */
 		psTdmaByte3Val = 0x11; /*  no tx-pause at BT-slot */
 		psTdmaByte4Val = 0x10; /*  0x778 = d/1 toggle */
@@ -1428,12 +1426,12 @@ static void halbtc8723b1ant_PsTdma(
 		switch (type) {
 		default:
 			halbtc8723b1ant_SetFwPstdma(
-				pBtCoexist, 0x51, 0x1a, 0x1a, 0x0, psTdmaByte4Val
+				p_bt_coexist, 0x51, 0x1a, 0x1a, 0x0, psTdmaByte4Val
 			);
 			break;
 		case 1:
 			halbtc8723b1ant_SetFwPstdma(
-				pBtCoexist,
+				p_bt_coexist,
 				psTdmaByte0Val,
 				0x3a + nWiFiDurationAdjust,
 				0x03,
@@ -1443,7 +1441,7 @@ static void halbtc8723b1ant_PsTdma(
 			break;
 		case 2:
 			halbtc8723b1ant_SetFwPstdma(
-				pBtCoexist,
+				p_bt_coexist,
 				psTdmaByte0Val,
 				0x2d + nWiFiDurationAdjust,
 				0x03,
@@ -1453,35 +1451,35 @@ static void halbtc8723b1ant_PsTdma(
 			break;
 		case 3:
 			halbtc8723b1ant_SetFwPstdma(
-				pBtCoexist, 0x51, 0x1d, 0x1d, 0x0, 0x10
+				p_bt_coexist, 0x51, 0x1d, 0x1d, 0x0, 0x10
 			);
 			break;
 		case 4:
 			halbtc8723b1ant_SetFwPstdma(
-				pBtCoexist, 0x93, 0x15, 0x3, 0x14, 0x0
+				p_bt_coexist, 0x93, 0x15, 0x3, 0x14, 0x0
 			);
 			break;
 		case 5:
 			halbtc8723b1ant_SetFwPstdma(
-				pBtCoexist, 0x61, 0x15, 0x3, 0x11, 0x10
+				p_bt_coexist, 0x61, 0x15, 0x3, 0x11, 0x10
 			);
 			break;
 		case 6:
 			halbtc8723b1ant_SetFwPstdma(
-				pBtCoexist, 0x61, 0x20, 0x3, 0x11, 0x11
+				p_bt_coexist, 0x61, 0x20, 0x3, 0x11, 0x11
 			);
 			break;
 		case 7:
-			halbtc8723b1ant_SetFwPstdma(pBtCoexist, 0x13, 0xc, 0x5, 0x0, 0x0);
+			halbtc8723b1ant_SetFwPstdma(p_bt_coexist, 0x13, 0xc, 0x5, 0x0, 0x0);
 			break;
 		case 8:
 			halbtc8723b1ant_SetFwPstdma(
-				pBtCoexist, 0x93, 0x25, 0x3, 0x10, 0x0
+				p_bt_coexist, 0x93, 0x25, 0x3, 0x10, 0x0
 			);
 			break;
 		case 9:
 			halbtc8723b1ant_SetFwPstdma(
-				pBtCoexist,
+				p_bt_coexist,
 				psTdmaByte0Val,
 				0x21,
 				0x3,
@@ -1490,11 +1488,11 @@ static void halbtc8723b1ant_PsTdma(
 			);
 			break;
 		case 10:
-			halbtc8723b1ant_SetFwPstdma(pBtCoexist, 0x13, 0xa, 0xa, 0x0, 0x40);
+			halbtc8723b1ant_SetFwPstdma(p_bt_coexist, 0x13, 0xa, 0xa, 0x0, 0x40);
 			break;
 		case 11:
 			halbtc8723b1ant_SetFwPstdma(
-				pBtCoexist,
+				p_bt_coexist,
 				psTdmaByte0Val,
 				0x21,
 				0x03,
@@ -1504,124 +1502,124 @@ static void halbtc8723b1ant_PsTdma(
 			break;
 		case 12:
 			halbtc8723b1ant_SetFwPstdma(
-				pBtCoexist, 0x51, 0x0a, 0x0a, 0x0, 0x50
+				p_bt_coexist, 0x51, 0x0a, 0x0a, 0x0, 0x50
 			);
 			break;
 		case 13:
 			halbtc8723b1ant_SetFwPstdma(
-				pBtCoexist, 0x51, 0x12, 0x12, 0x0, 0x10
+				p_bt_coexist, 0x51, 0x12, 0x12, 0x0, 0x10
 			);
 			break;
 		case 14:
 			halbtc8723b1ant_SetFwPstdma(
-				pBtCoexist, 0x51, 0x21, 0x3, 0x10, psTdmaByte4Val
+				p_bt_coexist, 0x51, 0x21, 0x3, 0x10, psTdmaByte4Val
 			);
 			break;
 		case 15:
 			halbtc8723b1ant_SetFwPstdma(
-				pBtCoexist, 0x13, 0xa, 0x3, 0x8, 0x0
+				p_bt_coexist, 0x13, 0xa, 0x3, 0x8, 0x0
 			);
 			break;
 		case 16:
 			halbtc8723b1ant_SetFwPstdma(
-				pBtCoexist, 0x93, 0x15, 0x3, 0x10, 0x0
+				p_bt_coexist, 0x93, 0x15, 0x3, 0x10, 0x0
 			);
 			break;
 		case 18:
 			halbtc8723b1ant_SetFwPstdma(
-				pBtCoexist, 0x93, 0x25, 0x3, 0x10, 0x0
+				p_bt_coexist, 0x93, 0x25, 0x3, 0x10, 0x0
 			);
 			break;
 		case 20:
 			halbtc8723b1ant_SetFwPstdma(
-				pBtCoexist, 0x61, 0x3f, 0x03, 0x11, 0x10
+				p_bt_coexist, 0x61, 0x3f, 0x03, 0x11, 0x10
 
 			);
 			break;
 		case 21:
 			halbtc8723b1ant_SetFwPstdma(
-				pBtCoexist, 0x61, 0x25, 0x03, 0x11, 0x11
+				p_bt_coexist, 0x61, 0x25, 0x03, 0x11, 0x11
 			);
 			break;
 		case 22:
 			halbtc8723b1ant_SetFwPstdma(
-				pBtCoexist, 0x61, 0x25, 0x03, 0x11, 0x10
+				p_bt_coexist, 0x61, 0x25, 0x03, 0x11, 0x10
 			);
 			break;
 		case 23:
 			halbtc8723b1ant_SetFwPstdma(
-				pBtCoexist, 0xe3, 0x25, 0x3, 0x31, 0x18
+				p_bt_coexist, 0xe3, 0x25, 0x3, 0x31, 0x18
 			);
 			break;
 		case 24:
 			halbtc8723b1ant_SetFwPstdma(
-				pBtCoexist, 0xe3, 0x15, 0x3, 0x31, 0x18
+				p_bt_coexist, 0xe3, 0x15, 0x3, 0x31, 0x18
 			);
 			break;
 		case 25:
 			halbtc8723b1ant_SetFwPstdma(
-				pBtCoexist, 0xe3, 0xa, 0x3, 0x31, 0x18
+				p_bt_coexist, 0xe3, 0xa, 0x3, 0x31, 0x18
 			);
 			break;
 		case 26:
 			halbtc8723b1ant_SetFwPstdma(
-				pBtCoexist, 0xe3, 0xa, 0x3, 0x31, 0x18
+				p_bt_coexist, 0xe3, 0xa, 0x3, 0x31, 0x18
 			);
 			break;
 		case 27:
 			halbtc8723b1ant_SetFwPstdma(
-				pBtCoexist, 0xe3, 0x25, 0x3, 0x31, 0x98
+				p_bt_coexist, 0xe3, 0x25, 0x3, 0x31, 0x98
 			);
 			break;
 		case 28:
 			halbtc8723b1ant_SetFwPstdma(
-				pBtCoexist, 0x69, 0x25, 0x3, 0x31, 0x0
+				p_bt_coexist, 0x69, 0x25, 0x3, 0x31, 0x0
 			);
 			break;
 		case 29:
 			halbtc8723b1ant_SetFwPstdma(
-				pBtCoexist, 0xab, 0x1a, 0x1a, 0x1, 0x10
+				p_bt_coexist, 0xab, 0x1a, 0x1a, 0x1, 0x10
 			);
 			break;
 		case 30:
 			halbtc8723b1ant_SetFwPstdma(
-				pBtCoexist, 0x51, 0x30, 0x3, 0x10, 0x10
+				p_bt_coexist, 0x51, 0x30, 0x3, 0x10, 0x10
 			);
 			break;
 		case 31:
 			halbtc8723b1ant_SetFwPstdma(
-				pBtCoexist, 0xd3, 0x1a, 0x1a, 0x0, 0x58
+				p_bt_coexist, 0xd3, 0x1a, 0x1a, 0x0, 0x58
 			);
 			break;
 		case 32:
 			halbtc8723b1ant_SetFwPstdma(
-				pBtCoexist, 0x61, 0x35, 0x3, 0x11, 0x11
+				p_bt_coexist, 0x61, 0x35, 0x3, 0x11, 0x11
 			);
 			break;
 		case 33:
 			halbtc8723b1ant_SetFwPstdma(
-				pBtCoexist, 0xa3, 0x25, 0x3, 0x30, 0x90
+				p_bt_coexist, 0xa3, 0x25, 0x3, 0x30, 0x90
 			);
 			break;
 		case 34:
 			halbtc8723b1ant_SetFwPstdma(
-				pBtCoexist, 0x53, 0x1a, 0x1a, 0x0, 0x10
+				p_bt_coexist, 0x53, 0x1a, 0x1a, 0x0, 0x10
 			);
 			break;
 		case 35:
 			halbtc8723b1ant_SetFwPstdma(
-				pBtCoexist, 0x63, 0x1a, 0x1a, 0x0, 0x10
+				p_bt_coexist, 0x63, 0x1a, 0x1a, 0x0, 0x10
 			);
 			break;
 		case 36:
 			halbtc8723b1ant_SetFwPstdma(
-				pBtCoexist, 0xd3, 0x12, 0x3, 0x14, 0x50
+				p_bt_coexist, 0xd3, 0x12, 0x3, 0x14, 0x50
 			);
 			break;
 		case 40: /*  SoftAP only with no sta associated, BT disable , TDMA mode for power saving */
 			/* here softap mode screen off will cost 70-80mA for phone */
 			halbtc8723b1ant_SetFwPstdma(
-				pBtCoexist, 0x23, 0x18, 0x00, 0x10, 0x24
+				p_bt_coexist, 0x23, 0x18, 0x00, 0x10, 0x24
 			);
 			break;
 		}
@@ -1630,47 +1628,47 @@ static void halbtc8723b1ant_PsTdma(
 		/*  disable PS tdma */
 		switch (type) {
 		case 8: /* PTA Control */
-			halbtc8723b1ant_SetFwPstdma(pBtCoexist, 0x8, 0x0, 0x0, 0x0, 0x0);
+			halbtc8723b1ant_SetFwPstdma(p_bt_coexist, 0x8, 0x0, 0x0, 0x0, 0x0);
 			halbtc8723b1ant_SetAntPath(
-				pBtCoexist, BTC_ANT_PATH_PTA, false, false
+				p_bt_coexist, BTC_ANT_PATH_PTA, false, false
 			);
 			break;
 		case 0:
 		default:  /* Software control, Antenna at BT side */
-			halbtc8723b1ant_SetFwPstdma(pBtCoexist, 0x0, 0x0, 0x0, 0x0, 0x0);
+			halbtc8723b1ant_SetFwPstdma(p_bt_coexist, 0x0, 0x0, 0x0, 0x0, 0x0);
 			halbtc8723b1ant_SetAntPath(
-				pBtCoexist, BTC_ANT_PATH_BT, false, false
+				p_bt_coexist, BTC_ANT_PATH_BT, false, false
 			);
 			break;
 		case 9:   /* Software control, Antenna at WiFi side */
-			halbtc8723b1ant_SetFwPstdma(pBtCoexist, 0x0, 0x0, 0x0, 0x0, 0x0);
+			halbtc8723b1ant_SetFwPstdma(p_bt_coexist, 0x0, 0x0, 0x0, 0x0, 0x0);
 			halbtc8723b1ant_SetAntPath(
-				pBtCoexist, BTC_ANT_PATH_WIFI, false, false
+				p_bt_coexist, BTC_ANT_PATH_WIFI, false, false
 			);
 			break;
 		}
 	}
 
 	rssiAdjustVal = 0;
-	pBtCoexist->fBtcSet(
-		pBtCoexist, BTC_SET_U1_RSSI_ADJ_VAL_FOR_1ANT_COEX_TYPE, &rssiAdjustVal
+	p_bt_coexist->fBtcSet(
+		p_bt_coexist, BTC_SET_U1_RSSI_ADJ_VAL_FOR_1ANT_COEX_TYPE, &rssiAdjustVal
 	);
 
 	/*  update pre state */
-	pCoexDm->bPrePsTdmaOn = pCoexDm->bCurPsTdmaOn;
-	pCoexDm->prePsTdma = pCoexDm->curPsTdma;
+	p_coex_dm->bPrePsTdmaOn = p_coex_dm->bCurPsTdmaOn;
+	p_coex_dm->prePsTdma = p_coex_dm->curPsTdma;
 }
 
-static bool halbtc8723b1ant_IsCommonAction(struct btc_coexist *pBtCoexist)
+static bool halbtc8723b1ant_IsCommonAction(struct btc_coexist *p_bt_coexist)
 {
 	bool bCommon = false, bWifiConnected = false, bWifiBusy = false;
 
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_CONNECTED, &bWifiConnected);
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_BUSY, &bWifiBusy);
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_BL_WIFI_CONNECTED, &bWifiConnected);
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_BL_WIFI_BUSY, &bWifiBusy);
 
 	if (
 		!bWifiConnected &&
-		BT_8723B_1ANT_BT_STATUS_NON_CONNECTED_IDLE == pCoexDm->btStatus
+		BT_8723B_1ANT_BT_STATUS_NON_CONNECTED_IDLE == p_coex_dm->btStatus
 	) {
 		BTC_PRINT(
 			BTC_MSG_ALGORITHM,
@@ -1678,12 +1676,12 @@ static bool halbtc8723b1ant_IsCommonAction(struct btc_coexist *pBtCoexist)
 			("[BTCoex], Wifi non connected-idle + BT non connected-idle!!\n")
 		);
 
-		/* halbtc8723b1ant_SwMechanism(pBtCoexist, false); */
+		/* halbtc8723b1ant_SwMechanism(p_bt_coexist, false); */
 
 		bCommon = true;
 	} else if (
 		bWifiConnected &&
-		(BT_8723B_1ANT_BT_STATUS_NON_CONNECTED_IDLE == pCoexDm->btStatus)
+		(BT_8723B_1ANT_BT_STATUS_NON_CONNECTED_IDLE == p_coex_dm->btStatus)
 	) {
 		BTC_PRINT(
 			BTC_MSG_ALGORITHM,
@@ -1691,12 +1689,12 @@ static bool halbtc8723b1ant_IsCommonAction(struct btc_coexist *pBtCoexist)
 			("[BTCoex], Wifi connected + BT non connected-idle!!\n")
 		);
 
-		/* halbtc8723b1ant_SwMechanism(pBtCoexist, false); */
+		/* halbtc8723b1ant_SwMechanism(p_bt_coexist, false); */
 
 		bCommon = true;
 	} else if (
 		!bWifiConnected &&
-		(BT_8723B_1ANT_BT_STATUS_CONNECTED_IDLE == pCoexDm->btStatus)
+		(BT_8723B_1ANT_BT_STATUS_CONNECTED_IDLE == p_coex_dm->btStatus)
 	) {
 		BTC_PRINT(
 			BTC_MSG_ALGORITHM,
@@ -1704,21 +1702,21 @@ static bool halbtc8723b1ant_IsCommonAction(struct btc_coexist *pBtCoexist)
 			("[BTCoex], Wifi non connected-idle + BT connected-idle!!\n")
 		);
 
-		/* halbtc8723b1ant_SwMechanism(pBtCoexist, false); */
+		/* halbtc8723b1ant_SwMechanism(p_bt_coexist, false); */
 
 		bCommon = true;
 	} else if (
 		bWifiConnected &&
-		(BT_8723B_1ANT_BT_STATUS_CONNECTED_IDLE == pCoexDm->btStatus)
+		(BT_8723B_1ANT_BT_STATUS_CONNECTED_IDLE == p_coex_dm->btStatus)
 	) {
 		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Wifi connected + BT connected-idle!!\n"));
 
-		/* halbtc8723b1ant_SwMechanism(pBtCoexist, false); */
+		/* halbtc8723b1ant_SwMechanism(p_bt_coexist, false); */
 
 		bCommon = true;
 	} else if (
 		!bWifiConnected &&
-		(BT_8723B_1ANT_BT_STATUS_CONNECTED_IDLE != pCoexDm->btStatus)
+		(BT_8723B_1ANT_BT_STATUS_CONNECTED_IDLE != p_coex_dm->btStatus)
 	) {
 		BTC_PRINT(
 			BTC_MSG_ALGORITHM,
@@ -1726,7 +1724,7 @@ static bool halbtc8723b1ant_IsCommonAction(struct btc_coexist *pBtCoexist)
 			("[BTCoex], Wifi non connected-idle + BT Busy!!\n")
 		);
 
-		/* halbtc8723b1ant_SwMechanism(pBtCoexist, false); */
+		/* halbtc8723b1ant_SwMechanism(p_bt_coexist, false); */
 
 		bCommon = true;
 	} else {
@@ -1752,7 +1750,7 @@ static bool halbtc8723b1ant_IsCommonAction(struct btc_coexist *pBtCoexist)
 
 
 static void halbtc8723b1ant_TdmaDurationAdjustForAcl(
-	struct btc_coexist *pBtCoexist, u8 wifiStatus
+	struct btc_coexist *p_bt_coexist, u8 wifiStatus
 )
 {
 	static s32 up, dn, m, n, WaitCount;
@@ -1771,13 +1769,13 @@ static void halbtc8723b1ant_TdmaDurationAdjustForAcl(
 		(BT_8723B_1ANT_WIFI_STATUS_CONNECTED_SPECIAL_PKT == wifiStatus)
 	) {
 		if (
-			pCoexDm->curPsTdma != 1 &&
-			pCoexDm->curPsTdma != 2 &&
-			pCoexDm->curPsTdma != 3 &&
-			pCoexDm->curPsTdma != 9
+			p_coex_dm->curPsTdma != 1 &&
+			p_coex_dm->curPsTdma != 2 &&
+			p_coex_dm->curPsTdma != 3 &&
+			p_coex_dm->curPsTdma != 9
 		) {
-			halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 9);
-			pCoexDm->psTdmaDuAdjType = 9;
+			halbtc8723b1ant_PsTdma(p_bt_coexist, NORMAL_EXEC, true, 9);
+			p_coex_dm->psTdmaDuAdjType = 9;
 
 			up = 0;
 			dn = 0;
@@ -1789,16 +1787,16 @@ static void halbtc8723b1ant_TdmaDurationAdjustForAcl(
 		return;
 	}
 
-	if (!pCoexDm->bAutoTdmaAdjust) {
-		pCoexDm->bAutoTdmaAdjust = true;
+	if (!p_coex_dm->bAutoTdmaAdjust) {
+		p_coex_dm->bAutoTdmaAdjust = true;
 		BTC_PRINT(
 			BTC_MSG_ALGORITHM,
 			ALGO_TRACE_FW_DETAIL,
 			("[BTCoex], first run TdmaDurationAdjust()!!\n")
 		);
 
-		halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 2);
-		pCoexDm->psTdmaDuAdjType = 2;
+		halbtc8723b1ant_PsTdma(p_bt_coexist, NORMAL_EXEC, true, 2);
+		p_coex_dm->psTdmaDuAdjType = 2;
 		/*  */
 		up = 0;
 		dn = 0;
@@ -1808,13 +1806,13 @@ static void halbtc8723b1ant_TdmaDurationAdjustForAcl(
 		WaitCount = 0;
 	} else {
 		/* acquire the BT TRx retry count from BT_Info byte2 */
-		retryCount = pCoexSta->btRetryCnt;
-		btInfoExt = pCoexSta->btInfoExt;
+		retryCount = p_coex_sta->btRetryCnt;
+		btInfoExt = p_coex_sta->btInfoExt;
 		/* BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE_FW_DETAIL, ("[BTCoex], retryCount = %d\n", retryCount)); */
 		/* BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE_FW_DETAIL, ("[BTCoex], up =%d, dn =%d, m =%d, n =%d, WaitCount =%d\n", */
 		/* 	up, dn, m, n, WaitCount)); */
 
-		if (pCoexSta->lowPriorityTx > 1050 || pCoexSta->lowPriorityRx > 1250)
+		if (p_coex_sta->lowPriorityTx > 1050 || p_coex_sta->lowPriorityRx > 1250)
 			retryCount++;
 
 		result = 0;
@@ -1886,36 +1884,36 @@ static void halbtc8723b1ant_TdmaDurationAdjustForAcl(
 		if (result == -1) {
 			if (
 				BT_INFO_8723B_1ANT_A2DP_BASIC_RATE(btInfoExt) &&
-				((pCoexDm->curPsTdma == 1) || (pCoexDm->curPsTdma == 2))
+				((p_coex_dm->curPsTdma == 1) || (p_coex_dm->curPsTdma == 2))
 			) {
-				halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 9);
-				pCoexDm->psTdmaDuAdjType = 9;
-			} else if (pCoexDm->curPsTdma == 1) {
-				halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 2);
-				pCoexDm->psTdmaDuAdjType = 2;
-			} else if (pCoexDm->curPsTdma == 2) {
-				halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 9);
-				pCoexDm->psTdmaDuAdjType = 9;
-			} else if (pCoexDm->curPsTdma == 9) {
-				halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 11);
-				pCoexDm->psTdmaDuAdjType = 11;
+				halbtc8723b1ant_PsTdma(p_bt_coexist, NORMAL_EXEC, true, 9);
+				p_coex_dm->psTdmaDuAdjType = 9;
+			} else if (p_coex_dm->curPsTdma == 1) {
+				halbtc8723b1ant_PsTdma(p_bt_coexist, NORMAL_EXEC, true, 2);
+				p_coex_dm->psTdmaDuAdjType = 2;
+			} else if (p_coex_dm->curPsTdma == 2) {
+				halbtc8723b1ant_PsTdma(p_bt_coexist, NORMAL_EXEC, true, 9);
+				p_coex_dm->psTdmaDuAdjType = 9;
+			} else if (p_coex_dm->curPsTdma == 9) {
+				halbtc8723b1ant_PsTdma(p_bt_coexist, NORMAL_EXEC, true, 11);
+				p_coex_dm->psTdmaDuAdjType = 11;
 			}
 		} else if (result == 1) {
 			if (
 				BT_INFO_8723B_1ANT_A2DP_BASIC_RATE(btInfoExt) &&
-				((pCoexDm->curPsTdma == 1) || (pCoexDm->curPsTdma == 2))
+				((p_coex_dm->curPsTdma == 1) || (p_coex_dm->curPsTdma == 2))
 			) {
-				halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 9);
-				pCoexDm->psTdmaDuAdjType = 9;
-			} else if (pCoexDm->curPsTdma == 11) {
-				halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 9);
-				pCoexDm->psTdmaDuAdjType = 9;
-			} else if (pCoexDm->curPsTdma == 9) {
-				halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 2);
-				pCoexDm->psTdmaDuAdjType = 2;
-			} else if (pCoexDm->curPsTdma == 2) {
-				halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 1);
-				pCoexDm->psTdmaDuAdjType = 1;
+				halbtc8723b1ant_PsTdma(p_bt_coexist, NORMAL_EXEC, true, 9);
+				p_coex_dm->psTdmaDuAdjType = 9;
+			} else if (p_coex_dm->curPsTdma == 11) {
+				halbtc8723b1ant_PsTdma(p_bt_coexist, NORMAL_EXEC, true, 9);
+				p_coex_dm->psTdmaDuAdjType = 9;
+			} else if (p_coex_dm->curPsTdma == 9) {
+				halbtc8723b1ant_PsTdma(p_bt_coexist, NORMAL_EXEC, true, 2);
+				p_coex_dm->psTdmaDuAdjType = 2;
+			} else if (p_coex_dm->curPsTdma == 2) {
+				halbtc8723b1ant_PsTdma(p_bt_coexist, NORMAL_EXEC, true, 1);
+				p_coex_dm->psTdmaDuAdjType = 1;
 			}
 		} else {	  /* no change */
 			BTC_PRINT(
@@ -1923,39 +1921,39 @@ static void halbtc8723b1ant_TdmaDurationAdjustForAcl(
 				ALGO_TRACE_FW_DETAIL,
 				(
 					"[BTCoex], ********** TDMA(on, %d) **********\n",
-					pCoexDm->curPsTdma
+					p_coex_dm->curPsTdma
 				)
 			);
 		}
 
 		if (
-			pCoexDm->curPsTdma != 1 &&
-			pCoexDm->curPsTdma != 2 &&
-			pCoexDm->curPsTdma != 9 &&
-			pCoexDm->curPsTdma != 11
+			p_coex_dm->curPsTdma != 1 &&
+			p_coex_dm->curPsTdma != 2 &&
+			p_coex_dm->curPsTdma != 9 &&
+			p_coex_dm->curPsTdma != 11
 		) /*  recover to previous adjust type */
 			halbtc8723b1ant_PsTdma(
-				pBtCoexist, NORMAL_EXEC, true, pCoexDm->psTdmaDuAdjType
+				p_bt_coexist, NORMAL_EXEC, true, p_coex_dm->psTdmaDuAdjType
 			);
 	}
 }
 
 static void halbtc8723b1ant_PsTdmaCheckForPowerSaveState(
-	struct btc_coexist *pBtCoexist, bool bNewPsState
+	struct btc_coexist *p_bt_coexist, bool bNewPsState
 )
 {
 	u8 lpsMode = 0x0;
 
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_U1_LPS_MODE, &lpsMode);
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_U1_LPS_MODE, &lpsMode);
 
 	if (lpsMode) {	/*  already under LPS state */
 		if (bNewPsState) {
 			/*  keep state under LPS, do nothing. */
 		} else /*  will leave LPS state, turn off psTdma first */
-			halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, false, 0);
+			halbtc8723b1ant_PsTdma(p_bt_coexist, NORMAL_EXEC, false, 0);
 	} else {						/*  NO PS state */
 		if (bNewPsState) /*  will enter LPS state, turn off psTdma first */
-			halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, false, 0);
+			halbtc8723b1ant_PsTdma(p_bt_coexist, NORMAL_EXEC, false, 0);
 		else {
 			/*  keep state under NO PS state, do nothing. */
 		}
@@ -1963,7 +1961,7 @@ static void halbtc8723b1ant_PsTdmaCheckForPowerSaveState(
 }
 
 static void halbtc8723b1ant_PowerSaveState(
-	struct btc_coexist *pBtCoexist, u8 psType, u8 lpsVal, u8 rpwmVal
+	struct btc_coexist *p_bt_coexist, u8 psType, u8 lpsVal, u8 rpwmVal
 )
 {
 	bool bLowPwrDisable = false;
@@ -1972,28 +1970,28 @@ static void halbtc8723b1ant_PowerSaveState(
 	case BTC_PS_WIFI_NATIVE:
 		/*  recover to original 32k low power setting */
 		bLowPwrDisable = false;
-		pBtCoexist->fBtcSet(
-			pBtCoexist, BTC_SET_ACT_DISABLE_LOW_POWER, &bLowPwrDisable
+		p_bt_coexist->fBtcSet(
+			p_bt_coexist, BTC_SET_ACT_DISABLE_LOW_POWER, &bLowPwrDisable
 		);
-		pBtCoexist->fBtcSet(pBtCoexist, BTC_SET_ACT_NORMAL_LPS, NULL);
-		pCoexSta->bForceLpsOn = false;
+		p_bt_coexist->fBtcSet(p_bt_coexist, BTC_SET_ACT_NORMAL_LPS, NULL);
+		p_coex_sta->bForceLpsOn = false;
 		break;
 	case BTC_PS_LPS_ON:
-		halbtc8723b1ant_PsTdmaCheckForPowerSaveState(pBtCoexist, true);
-		halbtc8723b1ant_LpsRpwm(pBtCoexist, NORMAL_EXEC, lpsVal, rpwmVal);
+		halbtc8723b1ant_PsTdmaCheckForPowerSaveState(p_bt_coexist, true);
+		halbtc8723b1ant_LpsRpwm(p_bt_coexist, NORMAL_EXEC, lpsVal, rpwmVal);
 		/*  when coex force to enter LPS, do not enter 32k low power. */
 		bLowPwrDisable = true;
-		pBtCoexist->fBtcSet(
-			pBtCoexist, BTC_SET_ACT_DISABLE_LOW_POWER, &bLowPwrDisable
+		p_bt_coexist->fBtcSet(
+			p_bt_coexist, BTC_SET_ACT_DISABLE_LOW_POWER, &bLowPwrDisable
 		);
 		/*  power save must executed before psTdma. */
-		pBtCoexist->fBtcSet(pBtCoexist, BTC_SET_ACT_ENTER_LPS, NULL);
-		pCoexSta->bForceLpsOn = true;
+		p_bt_coexist->fBtcSet(p_bt_coexist, BTC_SET_ACT_ENTER_LPS, NULL);
+		p_coex_sta->bForceLpsOn = true;
 		break;
 	case BTC_PS_LPS_OFF:
-		halbtc8723b1ant_PsTdmaCheckForPowerSaveState(pBtCoexist, false);
-		pBtCoexist->fBtcSet(pBtCoexist, BTC_SET_ACT_LEAVE_LPS, NULL);
-		pCoexSta->bForceLpsOn = false;
+		halbtc8723b1ant_PsTdmaCheckForPowerSaveState(p_bt_coexist, false);
+		p_bt_coexist->fBtcSet(p_bt_coexist, BTC_SET_ACT_LEAVE_LPS, NULL);
+		p_coex_sta->bForceLpsOn = false;
 		break;
 	default:
 		break;
@@ -2011,185 +2009,185 @@ static void halbtc8723b1ant_PowerSaveState(
 /* 	Non-Software Coex Mechanism start */
 /*  */
 /*  */
-static void halbtc8723b1ant_ActionWifiMultiPort(struct btc_coexist *pBtCoexist)
+static void halbtc8723b1ant_ActionWifiMultiPort(struct btc_coexist *p_bt_coexist)
 {
-	halbtc8723b1ant_PowerSaveState(pBtCoexist, BTC_PS_WIFI_NATIVE, 0x0, 0x0);
+	halbtc8723b1ant_PowerSaveState(p_bt_coexist, BTC_PS_WIFI_NATIVE, 0x0, 0x0);
 
-	halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, false, 8);
-	halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 2);
+	halbtc8723b1ant_PsTdma(p_bt_coexist, NORMAL_EXEC, false, 8);
+	halbtc8723b1ant_CoexTableWithType(p_bt_coexist, NORMAL_EXEC, 2);
 }
 
-static void halbtc8723b1ant_ActionHs(struct btc_coexist *pBtCoexist)
+static void halbtc8723b1ant_ActionHs(struct btc_coexist *p_bt_coexist)
 {
-	halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 5);
-	halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 2);
+	halbtc8723b1ant_PsTdma(p_bt_coexist, NORMAL_EXEC, true, 5);
+	halbtc8723b1ant_CoexTableWithType(p_bt_coexist, NORMAL_EXEC, 2);
 }
 
-static void halbtc8723b1ant_ActionBtInquiry(struct btc_coexist *pBtCoexist)
+static void halbtc8723b1ant_ActionBtInquiry(struct btc_coexist *p_bt_coexist)
 {
-	struct btc_bt_link_info *pBtLinkInfo = &pBtCoexist->btLinkInfo;
+	struct btc_bt_link_info *pBtLinkInfo = &p_bt_coexist->btLinkInfo;
 	bool bWifiConnected = false;
 	bool bApEnable = false;
 	bool bWifiBusy = false;
 	bool bBtBusy = false;
 
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_AP_MODE_ENABLE, &bApEnable);
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_CONNECTED, &bWifiConnected);
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_BUSY, &bWifiBusy);
-	pBtCoexist->fBtcSet(pBtCoexist, BTC_SET_BL_BT_TRAFFIC_BUSY, &bBtBusy);
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_BL_WIFI_AP_MODE_ENABLE, &bApEnable);
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_BL_WIFI_CONNECTED, &bWifiConnected);
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_BL_WIFI_BUSY, &bWifiBusy);
+	p_bt_coexist->fBtcSet(p_bt_coexist, BTC_SET_BL_BT_TRAFFIC_BUSY, &bBtBusy);
 
-	if (!bWifiConnected && !pCoexSta->bWiFiIsHighPriTask) {
-		halbtc8723b1ant_PowerSaveState(pBtCoexist, BTC_PS_WIFI_NATIVE, 0x0, 0x0);
-		halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, false, 8);
+	if (!bWifiConnected && !p_coex_sta->bWiFiIsHighPriTask) {
+		halbtc8723b1ant_PowerSaveState(p_bt_coexist, BTC_PS_WIFI_NATIVE, 0x0, 0x0);
+		halbtc8723b1ant_PsTdma(p_bt_coexist, NORMAL_EXEC, false, 8);
 
-		halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 0);
+		halbtc8723b1ant_CoexTableWithType(p_bt_coexist, NORMAL_EXEC, 0);
 	} else if (
 		pBtLinkInfo->bScoExist ||
 		pBtLinkInfo->bHidExist ||
 		pBtLinkInfo->bA2dpExist
 	) {
 		/*  SCO/HID/A2DP busy */
-		halbtc8723b1ant_PowerSaveState(pBtCoexist, BTC_PS_WIFI_NATIVE, 0x0, 0x0);
-		halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 32);
+		halbtc8723b1ant_PowerSaveState(p_bt_coexist, BTC_PS_WIFI_NATIVE, 0x0, 0x0);
+		halbtc8723b1ant_PsTdma(p_bt_coexist, NORMAL_EXEC, true, 32);
 
-		halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 4);
+		halbtc8723b1ant_CoexTableWithType(p_bt_coexist, NORMAL_EXEC, 4);
 	} else if (pBtLinkInfo->bPanExist || bWifiBusy) {
-		halbtc8723b1ant_PowerSaveState(pBtCoexist, BTC_PS_WIFI_NATIVE, 0x0, 0x0);
-		halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 20);
+		halbtc8723b1ant_PowerSaveState(p_bt_coexist, BTC_PS_WIFI_NATIVE, 0x0, 0x0);
+		halbtc8723b1ant_PsTdma(p_bt_coexist, NORMAL_EXEC, true, 20);
 
-		halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 4);
+		halbtc8723b1ant_CoexTableWithType(p_bt_coexist, NORMAL_EXEC, 4);
 	} else {
-		halbtc8723b1ant_PowerSaveState(pBtCoexist, BTC_PS_WIFI_NATIVE, 0x0, 0x0);
-		halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, false, 8);
+		halbtc8723b1ant_PowerSaveState(p_bt_coexist, BTC_PS_WIFI_NATIVE, 0x0, 0x0);
+		halbtc8723b1ant_PsTdma(p_bt_coexist, NORMAL_EXEC, false, 8);
 
-		halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 7);
+		halbtc8723b1ant_CoexTableWithType(p_bt_coexist, NORMAL_EXEC, 7);
 	}
 }
 
 static void halbtc8723b1ant_ActionBtScoHidOnlyBusy(
-	struct btc_coexist *pBtCoexist, u8 wifiStatus
+	struct btc_coexist *p_bt_coexist, u8 wifiStatus
 )
 {
-	struct btc_bt_link_info *pBtLinkInfo = &pBtCoexist->btLinkInfo;
+	struct btc_bt_link_info *pBtLinkInfo = &p_bt_coexist->btLinkInfo;
 	bool bWifiConnected = false;
 
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_CONNECTED, &bWifiConnected);
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_BL_WIFI_CONNECTED, &bWifiConnected);
 
 	/*  tdma and coex table */
 
 	if (pBtLinkInfo->bScoExist) {
-		halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 5);
-		halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 5);
+		halbtc8723b1ant_PsTdma(p_bt_coexist, NORMAL_EXEC, true, 5);
+		halbtc8723b1ant_CoexTableWithType(p_bt_coexist, NORMAL_EXEC, 5);
 	} else { /* HID */
-		halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 6);
-		halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 5);
+		halbtc8723b1ant_PsTdma(p_bt_coexist, NORMAL_EXEC, true, 6);
+		halbtc8723b1ant_CoexTableWithType(p_bt_coexist, NORMAL_EXEC, 5);
 	}
 }
 
 static void halbtc8723b1ant_ActionWifiConnectedBtAclBusy(
-	struct btc_coexist *pBtCoexist, u8 wifiStatus
+	struct btc_coexist *p_bt_coexist, u8 wifiStatus
 )
 {
-	struct btc_bt_link_info *pBtLinkInfo = &pBtCoexist->btLinkInfo;
-	halbtc8723b1ant_BtRssiState(2, 28, 0);
+	struct btc_bt_link_info *pBtLinkInfo = &p_bt_coexist->btLinkInfo;
+	hal_btc_8723b_1ant_btRssi_state(2, 28, 0);
 
-	if ((pCoexSta->lowPriorityRx >= 1000) && (pCoexSta->lowPriorityRx != 65535))
+	if ((p_coex_sta->lowPriorityRx >= 1000) && (p_coex_sta->lowPriorityRx != 65535))
 		pBtLinkInfo->bSlaveRole = true;
 	else
 		pBtLinkInfo->bSlaveRole = false;
 
 	if (pBtLinkInfo->bHidOnly) { /* HID */
-		halbtc8723b1ant_ActionBtScoHidOnlyBusy(pBtCoexist, wifiStatus);
-		pCoexDm->bAutoTdmaAdjust = false;
+		halbtc8723b1ant_ActionBtScoHidOnlyBusy(p_bt_coexist, wifiStatus);
+		p_coex_dm->bAutoTdmaAdjust = false;
 		return;
 	} else if (pBtLinkInfo->bA2dpOnly) { /* A2DP */
 		if (BT_8723B_1ANT_WIFI_STATUS_CONNECTED_IDLE == wifiStatus) {
-			halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 32);
-			halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 4);
-			pCoexDm->bAutoTdmaAdjust = false;
+			halbtc8723b1ant_PsTdma(p_bt_coexist, NORMAL_EXEC, true, 32);
+			halbtc8723b1ant_CoexTableWithType(p_bt_coexist, NORMAL_EXEC, 4);
+			p_coex_dm->bAutoTdmaAdjust = false;
 		} else {
-			halbtc8723b1ant_TdmaDurationAdjustForAcl(pBtCoexist, wifiStatus);
-			halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 4);
-			pCoexDm->bAutoTdmaAdjust = true;
+			halbtc8723b1ant_TdmaDurationAdjustForAcl(p_bt_coexist, wifiStatus);
+			halbtc8723b1ant_CoexTableWithType(p_bt_coexist, NORMAL_EXEC, 4);
+			p_coex_dm->bAutoTdmaAdjust = true;
 		}
 	} else if (pBtLinkInfo->bHidExist && pBtLinkInfo->bA2dpExist) { /* HID+A2DP */
-		halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 14);
-		pCoexDm->bAutoTdmaAdjust = false;
+		halbtc8723b1ant_PsTdma(p_bt_coexist, NORMAL_EXEC, true, 14);
+		p_coex_dm->bAutoTdmaAdjust = false;
 
-		halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 4);
+		halbtc8723b1ant_CoexTableWithType(p_bt_coexist, NORMAL_EXEC, 4);
 	} else if (
 		pBtLinkInfo->bPanOnly ||
 		(pBtLinkInfo->bHidExist && pBtLinkInfo->bPanExist)
 	) { /* PAN(OPP, FTP), HID+PAN(OPP, FTP) */
-		halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 3);
-		halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 4);
-		pCoexDm->bAutoTdmaAdjust = false;
+		halbtc8723b1ant_PsTdma(p_bt_coexist, NORMAL_EXEC, true, 3);
+		halbtc8723b1ant_CoexTableWithType(p_bt_coexist, NORMAL_EXEC, 4);
+		p_coex_dm->bAutoTdmaAdjust = false;
 	} else if (
 		(pBtLinkInfo->bA2dpExist && pBtLinkInfo->bPanExist) ||
 		(pBtLinkInfo->bHidExist && pBtLinkInfo->bA2dpExist && pBtLinkInfo->bPanExist)
 	) { /* A2DP+PAN(OPP, FTP), HID+A2DP+PAN(OPP, FTP) */
-		halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 13);
-		halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 4);
-		pCoexDm->bAutoTdmaAdjust = false;
+		halbtc8723b1ant_PsTdma(p_bt_coexist, NORMAL_EXEC, true, 13);
+		halbtc8723b1ant_CoexTableWithType(p_bt_coexist, NORMAL_EXEC, 4);
+		p_coex_dm->bAutoTdmaAdjust = false;
 	} else {
 		/* BT no-profile busy (0x9) */
-		halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 32);
-		halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 4);
-		pCoexDm->bAutoTdmaAdjust = false;
+		halbtc8723b1ant_PsTdma(p_bt_coexist, NORMAL_EXEC, true, 32);
+		halbtc8723b1ant_CoexTableWithType(p_bt_coexist, NORMAL_EXEC, 4);
+		p_coex_dm->bAutoTdmaAdjust = false;
 	}
 }
 
-static void halbtc8723b1ant_ActionWifiNotConnected(struct btc_coexist *pBtCoexist)
+static void halbtc8723b1ant_ActionWifiNotConnected(struct btc_coexist *p_bt_coexist)
 {
 	/*  power save state */
-	halbtc8723b1ant_PowerSaveState(pBtCoexist, BTC_PS_WIFI_NATIVE, 0x0, 0x0);
+	halbtc8723b1ant_PowerSaveState(p_bt_coexist, BTC_PS_WIFI_NATIVE, 0x0, 0x0);
 
 	/*  tdma and coex table */
-	halbtc8723b1ant_PsTdma(pBtCoexist, FORCE_EXEC, false, 8);
-	halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 0);
+	halbtc8723b1ant_PsTdma(p_bt_coexist, FORCE_EXEC, false, 8);
+	halbtc8723b1ant_CoexTableWithType(p_bt_coexist, NORMAL_EXEC, 0);
 }
 
 static void halbtc8723b1ant_ActionWifiNotConnectedScan(
-	struct btc_coexist *pBtCoexist
+	struct btc_coexist *p_bt_coexist
 )
 {
-	struct btc_bt_link_info *pBtLinkInfo = &pBtCoexist->btLinkInfo;
+	struct btc_bt_link_info *pBtLinkInfo = &p_bt_coexist->btLinkInfo;
 
-	halbtc8723b1ant_PowerSaveState(pBtCoexist, BTC_PS_WIFI_NATIVE, 0x0, 0x0);
+	halbtc8723b1ant_PowerSaveState(p_bt_coexist, BTC_PS_WIFI_NATIVE, 0x0, 0x0);
 
 	/*  tdma and coex table */
-	if (BT_8723B_1ANT_BT_STATUS_ACL_BUSY == pCoexDm->btStatus) {
+	if (BT_8723B_1ANT_BT_STATUS_ACL_BUSY == p_coex_dm->btStatus) {
 		if (pBtLinkInfo->bA2dpExist) {
-			halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 32);
-			halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 4);
+			halbtc8723b1ant_PsTdma(p_bt_coexist, NORMAL_EXEC, true, 32);
+			halbtc8723b1ant_CoexTableWithType(p_bt_coexist, NORMAL_EXEC, 4);
 		} else if (pBtLinkInfo->bA2dpExist && pBtLinkInfo->bPanExist) {
-			halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 22);
-			halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 4);
+			halbtc8723b1ant_PsTdma(p_bt_coexist, NORMAL_EXEC, true, 22);
+			halbtc8723b1ant_CoexTableWithType(p_bt_coexist, NORMAL_EXEC, 4);
 		} else {
-			halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 20);
-			halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 4);
+			halbtc8723b1ant_PsTdma(p_bt_coexist, NORMAL_EXEC, true, 20);
+			halbtc8723b1ant_CoexTableWithType(p_bt_coexist, NORMAL_EXEC, 4);
 		}
 	} else if (
-		(BT_8723B_1ANT_BT_STATUS_SCO_BUSY == pCoexDm->btStatus) ||
-		(BT_8723B_1ANT_BT_STATUS_ACL_SCO_BUSY == pCoexDm->btStatus)
+		(BT_8723B_1ANT_BT_STATUS_SCO_BUSY == p_coex_dm->btStatus) ||
+		(BT_8723B_1ANT_BT_STATUS_ACL_SCO_BUSY == p_coex_dm->btStatus)
 	) {
 		halbtc8723b1ant_ActionBtScoHidOnlyBusy(
-			pBtCoexist, BT_8723B_1ANT_WIFI_STATUS_CONNECTED_SCAN
+			p_bt_coexist, BT_8723B_1ANT_WIFI_STATUS_CONNECTED_SCAN
 		);
 	} else {
 		/* Bryant Add */
-		halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, false, 8);
-		halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 2);
+		halbtc8723b1ant_PsTdma(p_bt_coexist, NORMAL_EXEC, false, 8);
+		halbtc8723b1ant_CoexTableWithType(p_bt_coexist, NORMAL_EXEC, 2);
 	}
 }
 
 static void halbtc8723b1ant_ActionWifiNotConnectedAssoAuth(
-	struct btc_coexist *pBtCoexist
+	struct btc_coexist *p_bt_coexist
 )
 {
-	struct btc_bt_link_info *pBtLinkInfo = &pBtCoexist->btLinkInfo;
+	struct btc_bt_link_info *pBtLinkInfo = &p_bt_coexist->btLinkInfo;
 
-	halbtc8723b1ant_PowerSaveState(pBtCoexist, BTC_PS_WIFI_NATIVE, 0x0, 0x0);
+	halbtc8723b1ant_PowerSaveState(p_bt_coexist, BTC_PS_WIFI_NATIVE, 0x0, 0x0);
 
 	/*  tdma and coex table */
 	if (
@@ -2197,56 +2195,56 @@ static void halbtc8723b1ant_ActionWifiNotConnectedAssoAuth(
 		(pBtLinkInfo->bHidExist) ||
 		(pBtLinkInfo->bA2dpExist)
 	) {
-		halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 32);
-		halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 4);
+		halbtc8723b1ant_PsTdma(p_bt_coexist, NORMAL_EXEC, true, 32);
+		halbtc8723b1ant_CoexTableWithType(p_bt_coexist, NORMAL_EXEC, 4);
 	} else if (pBtLinkInfo->bPanExist) {
-		halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 20);
-		halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 4);
+		halbtc8723b1ant_PsTdma(p_bt_coexist, NORMAL_EXEC, true, 20);
+		halbtc8723b1ant_CoexTableWithType(p_bt_coexist, NORMAL_EXEC, 4);
 	} else {
-		halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, false, 8);
-		halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 2);
+		halbtc8723b1ant_PsTdma(p_bt_coexist, NORMAL_EXEC, false, 8);
+		halbtc8723b1ant_CoexTableWithType(p_bt_coexist, NORMAL_EXEC, 2);
 	}
 }
 
-static void halbtc8723b1ant_ActionWifiConnectedScan(struct btc_coexist *pBtCoexist)
+static void halbtc8723b1ant_ActionWifiConnectedScan(struct btc_coexist *p_bt_coexist)
 {
-	struct btc_bt_link_info *pBtLinkInfo = &pBtCoexist->btLinkInfo;
+	struct btc_bt_link_info *pBtLinkInfo = &p_bt_coexist->btLinkInfo;
 
-	halbtc8723b1ant_PowerSaveState(pBtCoexist, BTC_PS_WIFI_NATIVE, 0x0, 0x0);
+	halbtc8723b1ant_PowerSaveState(p_bt_coexist, BTC_PS_WIFI_NATIVE, 0x0, 0x0);
 
 	/*  tdma and coex table */
-	if (BT_8723B_1ANT_BT_STATUS_ACL_BUSY == pCoexDm->btStatus) {
+	if (BT_8723B_1ANT_BT_STATUS_ACL_BUSY == p_coex_dm->btStatus) {
 		if (pBtLinkInfo->bA2dpExist) {
-			halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 32);
-			halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 4);
+			halbtc8723b1ant_PsTdma(p_bt_coexist, NORMAL_EXEC, true, 32);
+			halbtc8723b1ant_CoexTableWithType(p_bt_coexist, NORMAL_EXEC, 4);
 		} else if (pBtLinkInfo->bA2dpExist && pBtLinkInfo->bPanExist) {
-			halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 22);
-			halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 4);
+			halbtc8723b1ant_PsTdma(p_bt_coexist, NORMAL_EXEC, true, 22);
+			halbtc8723b1ant_CoexTableWithType(p_bt_coexist, NORMAL_EXEC, 4);
 		} else {
-			halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 20);
-			halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 4);
+			halbtc8723b1ant_PsTdma(p_bt_coexist, NORMAL_EXEC, true, 20);
+			halbtc8723b1ant_CoexTableWithType(p_bt_coexist, NORMAL_EXEC, 4);
 		}
 	} else if (
-		(BT_8723B_1ANT_BT_STATUS_SCO_BUSY == pCoexDm->btStatus) ||
-		(BT_8723B_1ANT_BT_STATUS_ACL_SCO_BUSY == pCoexDm->btStatus)
+		(BT_8723B_1ANT_BT_STATUS_SCO_BUSY == p_coex_dm->btStatus) ||
+		(BT_8723B_1ANT_BT_STATUS_ACL_SCO_BUSY == p_coex_dm->btStatus)
 	) {
 		halbtc8723b1ant_ActionBtScoHidOnlyBusy(
-			pBtCoexist, BT_8723B_1ANT_WIFI_STATUS_CONNECTED_SCAN
+			p_bt_coexist, BT_8723B_1ANT_WIFI_STATUS_CONNECTED_SCAN
 		);
 	} else {
 		/* Bryant Add */
-		halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, false, 8);
-		halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 2);
+		halbtc8723b1ant_PsTdma(p_bt_coexist, NORMAL_EXEC, false, 8);
+		halbtc8723b1ant_CoexTableWithType(p_bt_coexist, NORMAL_EXEC, 2);
 	}
 }
 
 static void halbtc8723b1ant_ActionWifiConnectedSpecialPacket(
-	struct btc_coexist *pBtCoexist
+	struct btc_coexist *p_bt_coexist
 )
 {
-	struct btc_bt_link_info *pBtLinkInfo = &pBtCoexist->btLinkInfo;
+	struct btc_bt_link_info *pBtLinkInfo = &p_bt_coexist->btLinkInfo;
 
-	halbtc8723b1ant_PowerSaveState(pBtCoexist, BTC_PS_WIFI_NATIVE, 0x0, 0x0);
+	halbtc8723b1ant_PowerSaveState(p_bt_coexist, BTC_PS_WIFI_NATIVE, 0x0, 0x0);
 
 	/*  tdma and coex table */
 	if (
@@ -2254,18 +2252,18 @@ static void halbtc8723b1ant_ActionWifiConnectedSpecialPacket(
 		(pBtLinkInfo->bHidExist) ||
 		(pBtLinkInfo->bA2dpExist)
 	) {
-		halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 32);
-		halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 4);
+		halbtc8723b1ant_PsTdma(p_bt_coexist, NORMAL_EXEC, true, 32);
+		halbtc8723b1ant_CoexTableWithType(p_bt_coexist, NORMAL_EXEC, 4);
 	} else if (pBtLinkInfo->bPanExist) {
-		halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 20);
-		halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 4);
+		halbtc8723b1ant_PsTdma(p_bt_coexist, NORMAL_EXEC, true, 20);
+		halbtc8723b1ant_CoexTableWithType(p_bt_coexist, NORMAL_EXEC, 4);
 	} else {
-		halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, false, 8);
-		halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 2);
+		halbtc8723b1ant_PsTdma(p_bt_coexist, NORMAL_EXEC, false, 8);
+		halbtc8723b1ant_CoexTableWithType(p_bt_coexist, NORMAL_EXEC, 2);
 	}
 }
 
-static void halbtc8723b1ant_ActionWifiConnected(struct btc_coexist *pBtCoexist)
+static void halbtc8723b1ant_ActionWifiConnected(struct btc_coexist *p_bt_coexist)
 {
 	bool bWifiBusy = false;
 	bool bScan = false, bLink = false, bRoam = false;
@@ -2277,9 +2275,9 @@ static void halbtc8723b1ant_ActionWifiConnected(struct btc_coexist *pBtCoexist)
 		("[BTCoex], CoexForWifiConnect() ===>\n")
 	);
 
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_4_WAY_PROGRESS, &bUnder4way);
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_BL_WIFI_4_WAY_PROGRESS, &bUnder4way);
 	if (bUnder4way) {
-		halbtc8723b1ant_ActionWifiConnectedSpecialPacket(pBtCoexist);
+		halbtc8723b1ant_ActionWifiConnectedSpecialPacket(p_bt_coexist);
 		BTC_PRINT(
 			BTC_MSG_ALGORITHM,
 			ALGO_TRACE,
@@ -2288,14 +2286,14 @@ static void halbtc8723b1ant_ActionWifiConnected(struct btc_coexist *pBtCoexist)
 		return;
 	}
 
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_SCAN, &bScan);
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_LINK, &bLink);
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_ROAM, &bRoam);
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_BL_WIFI_SCAN, &bScan);
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_BL_WIFI_LINK, &bLink);
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_BL_WIFI_ROAM, &bRoam);
 	if (bScan || bLink || bRoam) {
 		if (bScan)
-			halbtc8723b1ant_ActionWifiConnectedScan(pBtCoexist);
+			halbtc8723b1ant_ActionWifiConnectedScan(p_bt_coexist);
 		else
-			halbtc8723b1ant_ActionWifiConnectedSpecialPacket(pBtCoexist);
+			halbtc8723b1ant_ActionWifiConnectedSpecialPacket(p_bt_coexist);
 		BTC_PRINT(
 			BTC_MSG_ALGORITHM,
 			ALGO_TRACE,
@@ -2304,149 +2302,149 @@ static void halbtc8723b1ant_ActionWifiConnected(struct btc_coexist *pBtCoexist)
 		return;
 	}
 
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_AP_MODE_ENABLE, &bApEnable);
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_BUSY, &bWifiBusy);
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_BL_WIFI_AP_MODE_ENABLE, &bApEnable);
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_BL_WIFI_BUSY, &bWifiBusy);
 
 	/*  power save state */
 	if (
 		!bApEnable &&
-		BT_8723B_1ANT_BT_STATUS_ACL_BUSY == pCoexDm->btStatus &&
-		!pBtCoexist->btLinkInfo.bHidOnly
+		BT_8723B_1ANT_BT_STATUS_ACL_BUSY == p_coex_dm->btStatus &&
+		!p_bt_coexist->btLinkInfo.bHidOnly
 	) {
-		if (pBtCoexist->btLinkInfo.bA2dpOnly) { /* A2DP */
+		if (p_bt_coexist->btLinkInfo.bA2dpOnly) { /* A2DP */
 			if (!bWifiBusy)
 				halbtc8723b1ant_PowerSaveState(
-					pBtCoexist, BTC_PS_WIFI_NATIVE, 0x0, 0x0
+					p_bt_coexist, BTC_PS_WIFI_NATIVE, 0x0, 0x0
 				);
 			else { /* busy */
-				if  (pCoexSta->nScanAPNum >= BT_8723B_1ANT_WIFI_NOISY_THRESH)  /* no force LPS, no PS-TDMA, use pure TDMA */
+				if  (p_coex_sta->nScanAPNum >= BT_8723B_1ANT_WIFI_NOISY_THRESH)  /* no force LPS, no PS-TDMA, use pure TDMA */
 					halbtc8723b1ant_PowerSaveState(
-						pBtCoexist, BTC_PS_WIFI_NATIVE, 0x0, 0x0
+						p_bt_coexist, BTC_PS_WIFI_NATIVE, 0x0, 0x0
 					);
 				else
 					halbtc8723b1ant_PowerSaveState(
-						pBtCoexist, BTC_PS_LPS_ON, 0x50, 0x4
+						p_bt_coexist, BTC_PS_LPS_ON, 0x50, 0x4
 					);
 			}
 		} else if (
-			(!pCoexSta->bPanExist) &&
-			(!pCoexSta->bA2dpExist) &&
-			(!pCoexSta->bHidExist)
+			(!p_coex_sta->bPanExist) &&
+			(!p_coex_sta->bA2dpExist) &&
+			(!p_coex_sta->bHidExist)
 		)
-			halbtc8723b1ant_PowerSaveState(pBtCoexist, BTC_PS_WIFI_NATIVE, 0x0, 0x0);
+			halbtc8723b1ant_PowerSaveState(p_bt_coexist, BTC_PS_WIFI_NATIVE, 0x0, 0x0);
 		else
-			halbtc8723b1ant_PowerSaveState(pBtCoexist, BTC_PS_LPS_ON, 0x50, 0x4);
+			halbtc8723b1ant_PowerSaveState(p_bt_coexist, BTC_PS_LPS_ON, 0x50, 0x4);
 	} else
-		halbtc8723b1ant_PowerSaveState(pBtCoexist, BTC_PS_WIFI_NATIVE, 0x0, 0x0);
+		halbtc8723b1ant_PowerSaveState(p_bt_coexist, BTC_PS_WIFI_NATIVE, 0x0, 0x0);
 
 	/*  tdma and coex table */
 	if (!bWifiBusy) {
-		if (BT_8723B_1ANT_BT_STATUS_ACL_BUSY == pCoexDm->btStatus) {
+		if (BT_8723B_1ANT_BT_STATUS_ACL_BUSY == p_coex_dm->btStatus) {
 			halbtc8723b1ant_ActionWifiConnectedBtAclBusy(
-				pBtCoexist,
+				p_bt_coexist,
 				BT_8723B_1ANT_WIFI_STATUS_CONNECTED_IDLE
 			);
 		} else if (
-			(BT_8723B_1ANT_BT_STATUS_SCO_BUSY == pCoexDm->btStatus) ||
-			(BT_8723B_1ANT_BT_STATUS_ACL_SCO_BUSY == pCoexDm->btStatus)
+			(BT_8723B_1ANT_BT_STATUS_SCO_BUSY == p_coex_dm->btStatus) ||
+			(BT_8723B_1ANT_BT_STATUS_ACL_SCO_BUSY == p_coex_dm->btStatus)
 		) {
-			halbtc8723b1ant_ActionBtScoHidOnlyBusy(pBtCoexist,
+			halbtc8723b1ant_ActionBtScoHidOnlyBusy(p_bt_coexist,
 				BT_8723B_1ANT_WIFI_STATUS_CONNECTED_IDLE);
 		} else {
-			halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, false, 8);
+			halbtc8723b1ant_PsTdma(p_bt_coexist, NORMAL_EXEC, false, 8);
 
-			if ((pCoexSta->highPriorityTx) + (pCoexSta->highPriorityRx) <= 60)
-				halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 2);
+			if ((p_coex_sta->highPriorityTx) + (p_coex_sta->highPriorityRx) <= 60)
+				halbtc8723b1ant_CoexTableWithType(p_bt_coexist, NORMAL_EXEC, 2);
 			else
-				halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 7);
+				halbtc8723b1ant_CoexTableWithType(p_bt_coexist, NORMAL_EXEC, 7);
 		}
 	} else {
-		if (BT_8723B_1ANT_BT_STATUS_ACL_BUSY == pCoexDm->btStatus) {
+		if (BT_8723B_1ANT_BT_STATUS_ACL_BUSY == p_coex_dm->btStatus) {
 			halbtc8723b1ant_ActionWifiConnectedBtAclBusy(
-				pBtCoexist,
+				p_bt_coexist,
 				BT_8723B_1ANT_WIFI_STATUS_CONNECTED_BUSY
 			);
 		} else if (
-			(BT_8723B_1ANT_BT_STATUS_SCO_BUSY == pCoexDm->btStatus) ||
-			(BT_8723B_1ANT_BT_STATUS_ACL_SCO_BUSY == pCoexDm->btStatus)
+			(BT_8723B_1ANT_BT_STATUS_SCO_BUSY == p_coex_dm->btStatus) ||
+			(BT_8723B_1ANT_BT_STATUS_ACL_SCO_BUSY == p_coex_dm->btStatus)
 		) {
 			halbtc8723b1ant_ActionBtScoHidOnlyBusy(
-				pBtCoexist,
+				p_bt_coexist,
 				BT_8723B_1ANT_WIFI_STATUS_CONNECTED_BUSY
 			);
 		} else {
-			halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, false, 8);
+			halbtc8723b1ant_PsTdma(p_bt_coexist, NORMAL_EXEC, false, 8);
 
-			if ((pCoexSta->highPriorityTx) + (pCoexSta->highPriorityRx) <= 60)
-				halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 2);
+			if ((p_coex_sta->highPriorityTx) + (p_coex_sta->highPriorityRx) <= 60)
+				halbtc8723b1ant_CoexTableWithType(p_bt_coexist, NORMAL_EXEC, 2);
 			else
-				halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 7);
+				halbtc8723b1ant_CoexTableWithType(p_bt_coexist, NORMAL_EXEC, 7);
 		}
 	}
 }
 
-static void halbtc8723b1ant_RunSwCoexistMechanism(struct btc_coexist *pBtCoexist)
+static void halbtc8723b1ant_RunSwCoexistMechanism(struct btc_coexist *p_bt_coexist)
 {
 	u8 algorithm = 0;
 
-	algorithm = halbtc8723b1ant_ActionAlgorithm(pBtCoexist);
-	pCoexDm->curAlgorithm = algorithm;
+	algorithm = halbtc8723b1ant_ActionAlgorithm(p_bt_coexist);
+	p_coex_dm->curAlgorithm = algorithm;
 
-	if (halbtc8723b1ant_IsCommonAction(pBtCoexist)) {
+	if (halbtc8723b1ant_IsCommonAction(p_bt_coexist)) {
 
 	} else {
-		switch (pCoexDm->curAlgorithm) {
+		switch (p_coex_dm->curAlgorithm) {
 		case BT_8723B_1ANT_COEX_ALGO_SCO:
 			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Action algorithm = SCO.\n"));
-			/* halbtc8723b1ant_ActionSco(pBtCoexist); */
+			/* halbtc8723b1ant_ActionSco(p_bt_coexist); */
 			break;
 		case BT_8723B_1ANT_COEX_ALGO_HID:
 			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Action algorithm = HID.\n"));
-			/* halbtc8723b1ant_ActionHid(pBtCoexist); */
+			/* halbtc8723b1ant_ActionHid(p_bt_coexist); */
 			break;
 		case BT_8723B_1ANT_COEX_ALGO_A2DP:
 			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Action algorithm = A2DP.\n"));
-			/* halbtc8723b1ant_ActionA2dp(pBtCoexist); */
+			/* halbtc8723b1ant_ActionA2dp(p_bt_coexist); */
 			break;
 		case BT_8723B_1ANT_COEX_ALGO_A2DP_PANHS:
 			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Action algorithm = A2DP+PAN(HS).\n"));
-			/* halbtc8723b1ant_ActionA2dpPanHs(pBtCoexist); */
+			/* halbtc8723b1ant_ActionA2dpPanHs(p_bt_coexist); */
 			break;
 		case BT_8723B_1ANT_COEX_ALGO_PANEDR:
 			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Action algorithm = PAN(EDR).\n"));
-			/* halbtc8723b1ant_ActionPanEdr(pBtCoexist); */
+			/* halbtc8723b1ant_ActionPanEdr(p_bt_coexist); */
 			break;
 		case BT_8723B_1ANT_COEX_ALGO_PANHS:
 			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Action algorithm = HS mode.\n"));
-			/* halbtc8723b1ant_ActionPanHs(pBtCoexist); */
+			/* halbtc8723b1ant_ActionPanHs(p_bt_coexist); */
 			break;
 		case BT_8723B_1ANT_COEX_ALGO_PANEDR_A2DP:
 			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Action algorithm = PAN+A2DP.\n"));
-			/* halbtc8723b1ant_ActionPanEdrA2dp(pBtCoexist); */
+			/* halbtc8723b1ant_ActionPanEdrA2dp(p_bt_coexist); */
 			break;
 		case BT_8723B_1ANT_COEX_ALGO_PANEDR_HID:
 			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Action algorithm = PAN(EDR)+HID.\n"));
-			/* halbtc8723b1ant_ActionPanEdrHid(pBtCoexist); */
+			/* halbtc8723b1ant_ActionPanEdrHid(p_bt_coexist); */
 			break;
 		case BT_8723B_1ANT_COEX_ALGO_HID_A2DP_PANEDR:
 			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Action algorithm = HID+A2DP+PAN.\n"));
-			/* halbtc8723b1ant_ActionHidA2dpPanEdr(pBtCoexist); */
+			/* halbtc8723b1ant_ActionHidA2dpPanEdr(p_bt_coexist); */
 			break;
 		case BT_8723B_1ANT_COEX_ALGO_HID_A2DP:
 			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Action algorithm = HID+A2DP.\n"));
-			/* halbtc8723b1ant_ActionHidA2dp(pBtCoexist); */
+			/* halbtc8723b1ant_ActionHidA2dp(p_bt_coexist); */
 			break;
 		default:
 			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Action algorithm = coexist All Off!!\n"));
 			break;
 		}
-		pCoexDm->preAlgorithm = pCoexDm->curAlgorithm;
+		p_coex_dm->preAlgorithm = p_coex_dm->curAlgorithm;
 	}
 }
 
-static void halbtc8723b1ant_RunCoexistMechanism(struct btc_coexist *pBtCoexist)
+static void halbtc8723b1ant_RunCoexistMechanism(struct btc_coexist *p_bt_coexist)
 {
-	struct btc_bt_link_info *pBtLinkInfo = &pBtCoexist->btLinkInfo;
+	struct btc_bt_link_info *pBtLinkInfo = &p_bt_coexist->btLinkInfo;
 	bool bWifiConnected = false, bBtHsOn = false;
 	bool bIncreaseScanDevNum = false;
 	bool bBtCtrlAggBufSize = false;
@@ -2456,42 +2454,42 @@ static void halbtc8723b1ant_RunCoexistMechanism(struct btc_coexist *pBtCoexist)
 
 	BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], RunCoexistMechanism() ===>\n"));
 
-	if (pBtCoexist->bManualControl) {
+	if (p_bt_coexist->bManualControl) {
 		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], RunCoexistMechanism(), return for Manual CTRL <===\n"));
 		return;
 	}
 
-	if (pBtCoexist->bStopCoexDm) {
+	if (p_bt_coexist->bStopCoexDm) {
 		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], RunCoexistMechanism(), return for Stop Coex DM <===\n"));
 		return;
 	}
 
-	if (pCoexSta->bUnderIps) {
+	if (p_coex_sta->bUnderIps) {
 		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], wifi is under IPS !!!\n"));
 		return;
 	}
 
 	if (
-		(BT_8723B_1ANT_BT_STATUS_ACL_BUSY == pCoexDm->btStatus) ||
-		(BT_8723B_1ANT_BT_STATUS_SCO_BUSY == pCoexDm->btStatus) ||
-		(BT_8723B_1ANT_BT_STATUS_ACL_SCO_BUSY == pCoexDm->btStatus)
+		(BT_8723B_1ANT_BT_STATUS_ACL_BUSY == p_coex_dm->btStatus) ||
+		(BT_8723B_1ANT_BT_STATUS_SCO_BUSY == p_coex_dm->btStatus) ||
+		(BT_8723B_1ANT_BT_STATUS_ACL_SCO_BUSY == p_coex_dm->btStatus)
 	){
 		bIncreaseScanDevNum = true;
 	}
 
-	pBtCoexist->fBtcSet(
-		pBtCoexist,
+	p_bt_coexist->fBtcSet(
+		p_bt_coexist,
 		BTC_SET_BL_INC_SCAN_DEV_NUM,
 		&bIncreaseScanDevNum
 	);
-	pBtCoexist->fBtcGet(
-		pBtCoexist,
+	p_bt_coexist->fBtcGet(
+		p_bt_coexist,
 		BTC_GET_BL_WIFI_CONNECTED,
 		&bWifiConnected
 	);
 
-	pBtCoexist->fBtcGet(
-		pBtCoexist,
+	p_bt_coexist->fBtcGet(
+		p_bt_coexist,
 		BTC_GET_U4_WIFI_LINK_STATUS,
 		&wifiLinkStatus
 	);
@@ -2507,52 +2505,52 @@ static void halbtc8723b1ant_RunCoexistMechanism(struct btc_coexist *pBtCoexist)
 				wifiLinkStatus
 			)
 		);
-		halbtc8723b1ant_LimitedTx(pBtCoexist, NORMAL_EXEC, 0, 0, 0, 0);
-		halbtc8723b1ant_LimitedRx(pBtCoexist, NORMAL_EXEC, false, bBtCtrlAggBufSize, aggBufSize);
+		halbtc8723b1ant_LimitedTx(p_bt_coexist, NORMAL_EXEC, 0, 0, 0, 0);
+		halbtc8723b1ant_LimitedRx(p_bt_coexist, NORMAL_EXEC, false, bBtCtrlAggBufSize, aggBufSize);
 
-		if ((pBtLinkInfo->bA2dpExist) && (pCoexSta->bC2hBtInquiryPage)) {
+		if ((pBtLinkInfo->bA2dpExist) && (p_coex_sta->bC2hBtInquiryPage)) {
 			BTC_PRINT(
 				BTC_MSG_INTERFACE,
 				INTF_NOTIFY,
 				("############# [BTCoex],  BT Is Inquirying\n")
 			);
-			halbtc8723b1ant_ActionBtInquiry(pBtCoexist);
+			halbtc8723b1ant_ActionBtInquiry(p_bt_coexist);
 		} else
-			halbtc8723b1ant_ActionWifiMultiPort(pBtCoexist);
+			halbtc8723b1ant_ActionWifiMultiPort(p_bt_coexist);
 
 		return;
 	}
 
 	if ((pBtLinkInfo->bBtLinkExist) && (bWifiConnected)) {
-		halbtc8723b1ant_LimitedTx(pBtCoexist, NORMAL_EXEC, 1, 1, 0, 1);
+		halbtc8723b1ant_LimitedTx(p_bt_coexist, NORMAL_EXEC, 1, 1, 0, 1);
 
 		if (pBtLinkInfo->bScoExist)
-			halbtc8723b1ant_LimitedRx(pBtCoexist, NORMAL_EXEC, false, true, 0x5);
+			halbtc8723b1ant_LimitedRx(p_bt_coexist, NORMAL_EXEC, false, true, 0x5);
 		else
-			halbtc8723b1ant_LimitedRx(pBtCoexist, NORMAL_EXEC, false, true, 0x8);
+			halbtc8723b1ant_LimitedRx(p_bt_coexist, NORMAL_EXEC, false, true, 0x8);
 
-		halbtc8723b1ant_SwMechanism(pBtCoexist, true);
-		halbtc8723b1ant_RunSwCoexistMechanism(pBtCoexist);  /* just print debug message */
+		halbtc8723b1ant_SwMechanism(p_bt_coexist, true);
+		halbtc8723b1ant_RunSwCoexistMechanism(p_bt_coexist);  /* just print debug message */
 	} else {
-		halbtc8723b1ant_LimitedTx(pBtCoexist, NORMAL_EXEC, 0, 0, 0, 0);
+		halbtc8723b1ant_LimitedTx(p_bt_coexist, NORMAL_EXEC, 0, 0, 0, 0);
 
-		halbtc8723b1ant_LimitedRx(pBtCoexist, NORMAL_EXEC, false, false, 0x5);
+		halbtc8723b1ant_LimitedRx(p_bt_coexist, NORMAL_EXEC, false, false, 0x5);
 
-		halbtc8723b1ant_SwMechanism(pBtCoexist, false);
-		halbtc8723b1ant_RunSwCoexistMechanism(pBtCoexist); /* just print debug message */
+		halbtc8723b1ant_SwMechanism(p_bt_coexist, false);
+		halbtc8723b1ant_RunSwCoexistMechanism(p_bt_coexist); /* just print debug message */
 	}
 
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_HS_OPERATION, &bBtHsOn);
-	if (pCoexSta->bC2hBtInquiryPage) {
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_BL_HS_OPERATION, &bBtHsOn);
+	if (p_coex_sta->bC2hBtInquiryPage) {
 		BTC_PRINT(
 			BTC_MSG_INTERFACE,
 			INTF_NOTIFY,
 			("############# [BTCoex],  BT Is Inquirying\n")
 		);
-		halbtc8723b1ant_ActionBtInquiry(pBtCoexist);
+		halbtc8723b1ant_ActionBtInquiry(p_bt_coexist);
 		return;
 	} else if (bBtHsOn) {
-		halbtc8723b1ant_ActionHs(pBtCoexist);
+		halbtc8723b1ant_ActionHs(p_bt_coexist);
 		return;
 	}
 
@@ -2562,41 +2560,41 @@ static void halbtc8723b1ant_RunCoexistMechanism(struct btc_coexist *pBtCoexist)
 
 		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], wifi is non connected-idle !!!\n"));
 
-		pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_SCAN, &bScan);
-		pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_LINK, &bLink);
-		pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_ROAM, &bRoam);
+		p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_BL_WIFI_SCAN, &bScan);
+		p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_BL_WIFI_LINK, &bLink);
+		p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_BL_WIFI_ROAM, &bRoam);
 
 		if (bScan || bLink || bRoam) {
 			 if (bScan)
-				halbtc8723b1ant_ActionWifiNotConnectedScan(pBtCoexist);
+				halbtc8723b1ant_ActionWifiNotConnectedScan(p_bt_coexist);
 			 else
-				halbtc8723b1ant_ActionWifiNotConnectedAssoAuth(pBtCoexist);
+				halbtc8723b1ant_ActionWifiNotConnectedAssoAuth(p_bt_coexist);
 		} else
-			halbtc8723b1ant_ActionWifiNotConnected(pBtCoexist);
+			halbtc8723b1ant_ActionWifiNotConnected(p_bt_coexist);
 	} else /*  wifi LPS/Busy */
-		halbtc8723b1ant_ActionWifiConnected(pBtCoexist);
+		halbtc8723b1ant_ActionWifiConnected(p_bt_coexist);
 }
 
-static void halbtc8723b1ant_InitCoexDm(struct btc_coexist *pBtCoexist)
+static void halbtc8723b1ant_InitCoexDm(struct btc_coexist *p_bt_coexist)
 {
 	/*  force to reset coex mechanism */
 
 	/*  sw all off */
-	halbtc8723b1ant_SwMechanism(pBtCoexist, false);
+	halbtc8723b1ant_SwMechanism(p_bt_coexist, false);
 
-	/* halbtc8723b1ant_PsTdma(pBtCoexist, FORCE_EXEC, false, 8); */
-	halbtc8723b1ant_CoexTableWithType(pBtCoexist, FORCE_EXEC, 0);
+	/* halbtc8723b1ant_PsTdma(p_bt_coexist, FORCE_EXEC, false, 8); */
+	halbtc8723b1ant_CoexTableWithType(p_bt_coexist, FORCE_EXEC, 0);
 
-	pCoexSta->popEventCnt = 0;
+	p_coex_sta->popEventCnt = 0;
 }
 
 static void halbtc8723b1ant_InitHwConfig(
-	struct btc_coexist *pBtCoexist,
+	struct btc_coexist *p_bt_coexist,
 	bool bBackUp,
 	bool bWifiOnly
 )
 {
-	u32 u4Tmp = 0;/*  fwVer; */
+	u32 u4Tmp = 0;/*  fw_ver; */
 	u8 u1Tmpa = 0, u1Tmpb = 0;
 
 	BTC_PRINT(
@@ -2605,28 +2603,28 @@ static void halbtc8723b1ant_InitHwConfig(
 		("[BTCoex], 1Ant Init HW Config!!\n")
 	);
 
-	pBtCoexist->fBtcWrite1ByteBitMask(pBtCoexist, 0x550, 0x8, 0x1);  /* enable TBTT nterrupt */
+	p_bt_coexist->fBtcWrite1ByteBitMask(p_bt_coexist, 0x550, 0x8, 0x1);  /* enable TBTT nterrupt */
 
 	/*  0x790[5:0]= 0x5 */
-	pBtCoexist->fBtcWrite1Byte(pBtCoexist, 0x790, 0x5);
+	p_bt_coexist->fBtcWrite1Byte(p_bt_coexist, 0x790, 0x5);
 
 	/*  Enable counter statistics */
-	pBtCoexist->fBtcWrite1Byte(pBtCoexist, 0x778, 0x1);
-	pBtCoexist->fBtcWrite1ByteBitMask(pBtCoexist, 0x40, 0x20, 0x1);
+	p_bt_coexist->fBtcWrite1Byte(p_bt_coexist, 0x778, 0x1);
+	p_bt_coexist->fBtcWrite1ByteBitMask(p_bt_coexist, 0x40, 0x20, 0x1);
 
 	/* Antenna config */
 	if (bWifiOnly) {
-		halbtc8723b1ant_SetAntPath(pBtCoexist, BTC_ANT_PATH_WIFI, true, false);
-		halbtc8723b1ant_PsTdma(pBtCoexist, FORCE_EXEC, false, 9);
+		halbtc8723b1ant_SetAntPath(p_bt_coexist, BTC_ANT_PATH_WIFI, true, false);
+		halbtc8723b1ant_PsTdma(p_bt_coexist, FORCE_EXEC, false, 9);
 	} else
-		halbtc8723b1ant_SetAntPath(pBtCoexist, BTC_ANT_PATH_BT, true, false);
+		halbtc8723b1ant_SetAntPath(p_bt_coexist, BTC_ANT_PATH_BT, true, false);
 
 	/*  PTA parameter */
-	halbtc8723b1ant_CoexTableWithType(pBtCoexist, FORCE_EXEC, 0);
+	halbtc8723b1ant_CoexTableWithType(p_bt_coexist, FORCE_EXEC, 0);
 
-	u4Tmp = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x948);
-	u1Tmpa = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x765);
-	u1Tmpb = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x67);
+	u4Tmp = p_bt_coexist->fBtcRead4Byte(p_bt_coexist, 0x948);
+	u1Tmpa = p_bt_coexist->fBtcRead1Byte(p_bt_coexist, 0x765);
+	u1Tmpb = p_bt_coexist->fBtcRead1Byte(p_bt_coexist, 0x67);
 
 	BTC_PRINT(
 		BTC_MSG_INTERFACE,
@@ -2646,22 +2644,22 @@ static void halbtc8723b1ant_InitHwConfig(
 /*  */
 /*  extern function start with EXhalbtc8723b1ant_ */
 /*  */
-void EXhalbtc8723b1ant_PowerOnSetting(struct btc_coexist *pBtCoexist)
+void EXhalbtc8723b1ant_PowerOnSetting(struct btc_coexist *p_bt_coexist)
 {
-	struct btc_board_info *pBoardInfo = &pBtCoexist->boardInfo;
+	struct btc_board_info *pBoardInfo = &p_bt_coexist->boardInfo;
 	u8 u1Tmp = 0x0;
 	u16 u2Tmp = 0x0;
 
-	pBtCoexist->fBtcWrite1Byte(pBtCoexist, 0x67, 0x20);
+	p_bt_coexist->fBtcWrite1Byte(p_bt_coexist, 0x67, 0x20);
 
 	/*  enable BB, REG_SYS_FUNC_EN such that we can write 0x948 correctly. */
-	u2Tmp = pBtCoexist->fBtcRead2Byte(pBtCoexist, 0x2);
-	pBtCoexist->fBtcWrite2Byte(pBtCoexist, 0x2, u2Tmp | BIT0 | BIT1);
+	u2Tmp = p_bt_coexist->fBtcRead2Byte(p_bt_coexist, 0x2);
+	p_bt_coexist->fBtcWrite2Byte(p_bt_coexist, 0x2, u2Tmp | BIT0 | BIT1);
 
 	/*  set GRAN_BT = 1 */
-	pBtCoexist->fBtcWrite1Byte(pBtCoexist, 0x765, 0x18);
+	p_bt_coexist->fBtcWrite1Byte(p_bt_coexist, 0x765, 0x18);
 	/*  set WLAN_ACT = 0 */
-	pBtCoexist->fBtcWrite1Byte(pBtCoexist, 0x76e, 0x4);
+	p_bt_coexist->fBtcWrite1Byte(p_bt_coexist, 0x76e, 0x4);
 
 	/*  */
 	/*  S0 or S1 setting and Local register setting(By the setting fw can get ant number, S0/S1, ... info) */
@@ -2670,40 +2668,40 @@ void EXhalbtc8723b1ant_PowerOnSetting(struct btc_coexist *pBtCoexist)
 	/* 	BIT1: "0" for internal switch; "1" for external switch */
 	/* 	BIT2: "0" for one antenna; "1" for two antenna */
 	/*  NOTE: here default all internal switch and 1-antenna ==> BIT1 = 0 and BIT2 = 0 */
-	if (pBtCoexist->chipInterface == BTC_INTF_USB) {
+	if (p_bt_coexist->chipInterface == BTC_INTF_USB) {
 		/*  fixed at S0 for USB interface */
-		pBtCoexist->fBtcWrite4Byte(pBtCoexist, 0x948, 0x0);
+		p_bt_coexist->fBtcWrite4Byte(p_bt_coexist, 0x948, 0x0);
 
 		u1Tmp |= 0x1;	/*  antenna inverse */
-		pBtCoexist->fBtcWriteLocalReg1Byte(pBtCoexist, 0xfe08, u1Tmp);
+		p_bt_coexist->fBtcWriteLocalReg1Byte(p_bt_coexist, 0xfe08, u1Tmp);
 
 		pBoardInfo->btdmAntPos = BTC_ANTENNA_AT_AUX_PORT;
 	} else {
 		/*  for PCIE and SDIO interface, we check efuse 0xc3[6] */
 		if (pBoardInfo->singleAntPath == 0) {
 			/*  set to S1 */
-			pBtCoexist->fBtcWrite4Byte(pBtCoexist, 0x948, 0x280);
+			p_bt_coexist->fBtcWrite4Byte(p_bt_coexist, 0x948, 0x280);
 			pBoardInfo->btdmAntPos = BTC_ANTENNA_AT_MAIN_PORT;
 		} else if (pBoardInfo->singleAntPath == 1) {
 			/*  set to S0 */
-			pBtCoexist->fBtcWrite4Byte(pBtCoexist, 0x948, 0x0);
+			p_bt_coexist->fBtcWrite4Byte(p_bt_coexist, 0x948, 0x0);
 			u1Tmp |= 0x1;	/*  antenna inverse */
 			pBoardInfo->btdmAntPos = BTC_ANTENNA_AT_AUX_PORT;
 		}
 
-		if (pBtCoexist->chipInterface == BTC_INTF_PCI)
-			pBtCoexist->fBtcWriteLocalReg1Byte(pBtCoexist, 0x384, u1Tmp);
-		else if (pBtCoexist->chipInterface == BTC_INTF_SDIO)
-			pBtCoexist->fBtcWriteLocalReg1Byte(pBtCoexist, 0x60, u1Tmp);
+		if (p_bt_coexist->chipInterface == BTC_INTF_PCI)
+			p_bt_coexist->fBtcWriteLocalReg1Byte(p_bt_coexist, 0x384, u1Tmp);
+		else if (p_bt_coexist->chipInterface == BTC_INTF_SDIO)
+			p_bt_coexist->fBtcWriteLocalReg1Byte(p_bt_coexist, 0x60, u1Tmp);
 	}
 }
 
-void EXhalbtc8723b1ant_InitHwConfig(struct btc_coexist *pBtCoexist, bool bWifiOnly)
+void EXhalbtc8723b1ant_InitHwConfig(struct btc_coexist *p_bt_coexist, bool bWifiOnly)
 {
-	halbtc8723b1ant_InitHwConfig(pBtCoexist, true, bWifiOnly);
+	halbtc8723b1ant_InitHwConfig(p_bt_coexist, true, bWifiOnly);
 }
 
-void EXhalbtc8723b1ant_InitCoexDm(struct btc_coexist *pBtCoexist)
+void EXhalbtc8723b1ant_InitCoexDm(struct btc_coexist *p_bt_coexist)
 {
 	BTC_PRINT(
 		BTC_MSG_INTERFACE,
@@ -2711,19 +2709,19 @@ void EXhalbtc8723b1ant_InitCoexDm(struct btc_coexist *pBtCoexist)
 		("[BTCoex], Coex Mechanism Init!!\n")
 	);
 
-	pBtCoexist->bStopCoexDm = false;
+	p_bt_coexist->bStopCoexDm = false;
 
-	halbtc8723b1ant_InitCoexDm(pBtCoexist);
+	halbtc8723b1ant_InitCoexDm(p_bt_coexist);
 
-	halbtc8723b1ant_QueryBtInfo(pBtCoexist);
+	halbtc8723b1ant_QueryBtInfo(p_bt_coexist);
 }
 
-void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
+void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *p_bt_coexist)
 {
-	struct btc_board_info *pBoardInfo = &pBtCoexist->boardInfo;
-	struct btc_stack_info *pStackInfo = &pBtCoexist->stackInfo;
-	struct btc_bt_link_info *pBtLinkInfo = &pBtCoexist->btLinkInfo;
-	u8 *cliBuf = pBtCoexist->cliBuf;
+	struct btc_board_info *pBoardInfo = &p_bt_coexist->boardInfo;
+	struct btc_stack_info *pStackInfo = &p_bt_coexist->stackInfo;
+	struct btc_bt_link_info *pBtLinkInfo = &p_bt_coexist->btLinkInfo;
+	u8 *cliBuf = p_bt_coexist->cliBuf;
 	u8 u1Tmp[4], i, btInfoExt, psTdmaCase = 0;
 	u16 u2Tmp[4];
 	u32 u4Tmp[4];
@@ -2731,13 +2729,13 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	bool bScan = false;
 	bool bLink = false;
 	bool bWifiUnder5G = false;
-	bool bWifiUnderBMode = false;
+	bool wifi_under_bmode = false;
 	bool bBtHsOn = false;
 	bool bWifiBusy = false;
 	s32 wifiRssi = 0, btHsRssi = 0;
 	u32 wifiBw, wifiTrafficDir, faOfdm, faCck, wifiLinkStatus;
 	u8 wifiDot11Chnl, wifiHsChnl;
-	u32 fwVer = 0, btPatchVer = 0;
+	u32 fw_ver = 0, bt_patch_ver = 0;
 	static u8 PopReportIn10s;
 
 	CL_SPRINTF(
@@ -2747,7 +2745,7 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	);
 	CL_PRINTF(cliBuf);
 
-	if (pBtCoexist->bManualControl) {
+	if (p_bt_coexist->bManualControl) {
 		CL_SPRINTF(
 			cliBuf,
 			BT_TMP_BUF_SIZE,
@@ -2760,7 +2758,7 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 		);
 		CL_PRINTF(cliBuf);
 	}
-	if (pBtCoexist->bStopCoexDm) {
+	if (p_bt_coexist->bStopCoexDm) {
 		CL_SPRINTF(
 			cliBuf,
 			BT_TMP_BUF_SIZE,
@@ -2794,23 +2792,23 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	);
 	CL_PRINTF(cliBuf);
 
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_U4_BT_PATCH_VER, &btPatchVer);
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_U4_WIFI_FW_VER, &fwVer);
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_U4_BT_PATCH_VER, &bt_patch_ver);
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_U4_WIFI_FW_VER, &fw_ver);
 	CL_SPRINTF(
 		cliBuf,
 		BT_TMP_BUF_SIZE,
 		"\r\n %-35s = %d_%x/ 0x%x/ 0x%x(%d)", "CoexVer/ FwVer/ PatchVer", \
-		GLCoexVerDate8723b1Ant,
-		GLCoexVer8723b1Ant,
-		fwVer,
-		btPatchVer,
-		btPatchVer
+		gl_coex_ver_date_8723b_1ant,
+		gl_coex_ver_8723b_1ant,
+		fw_ver,
+		bt_patch_ver,
+		bt_patch_ver
 	);
 	CL_PRINTF(cliBuf);
 
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_HS_OPERATION, &bBtHsOn);
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_U1_WIFI_DOT11_CHNL, &wifiDot11Chnl);
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_U1_WIFI_HS_CHNL, &wifiHsChnl);
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_BL_HS_OPERATION, &bBtHsOn);
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_U1_WIFI_DOT11_CHNL, &wifiDot11Chnl);
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_U1_WIFI_HS_CHNL, &wifiHsChnl);
 	CL_SPRINTF(
 		cliBuf,
 		BT_TMP_BUF_SIZE,
@@ -2825,14 +2823,14 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 		cliBuf,
 		BT_TMP_BUF_SIZE,
 		"\r\n %-35s = %02x %02x %02x ", "H2C Wifi inform bt chnl Info", \
-		pCoexDm->wifiChnlInfo[0],
-		pCoexDm->wifiChnlInfo[1],
-		pCoexDm->wifiChnlInfo[2]
+		p_coex_dm->wifiChnlInfo[0],
+		p_coex_dm->wifiChnlInfo[1],
+		p_coex_dm->wifiChnlInfo[2]
 	);
 	CL_PRINTF(cliBuf);
 
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_S4_WIFI_RSSI, &wifiRssi);
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_S4_HS_RSSI, &btHsRssi);
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_S4_WIFI_RSSI, &wifiRssi);
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_S4_HS_RSSI, &btHsRssi);
 	CL_SPRINTF(
 		cliBuf,
 		BT_TMP_BUF_SIZE,
@@ -2841,25 +2839,25 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	);
 	CL_PRINTF(cliBuf);
 
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_SCAN, &bScan);
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_LINK, &bLink);
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_ROAM, &bRoam);
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_BL_WIFI_SCAN, &bScan);
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_BL_WIFI_LINK, &bLink);
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_BL_WIFI_ROAM, &bRoam);
 	CL_SPRINTF(
 		cliBuf,
 		BT_TMP_BUF_SIZE,
 		"\r\n %-35s = %d/ %d/ %d/ %s", "Wifi bLink/ bRoam/ bScan/ bHi-Pri", \
-		bLink, bRoam, bScan, ((pCoexSta->bWiFiIsHighPriTask) ? "1" : "0")
+		bLink, bRoam, bScan, ((p_coex_sta->bWiFiIsHighPriTask) ? "1" : "0")
 	);
 	CL_PRINTF(cliBuf);
 
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_UNDER_5G, &bWifiUnder5G);
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_U4_WIFI_BW, &wifiBw);
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_BUSY, &bWifiBusy);
-	pBtCoexist->fBtcGet(
-		pBtCoexist, BTC_GET_U4_WIFI_TRAFFIC_DIRECTION, &wifiTrafficDir
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_BL_WIFI_UNDER_5G, &bWifiUnder5G);
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_U4_WIFI_BW, &wifiBw);
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_BL_WIFI_BUSY, &bWifiBusy);
+	p_bt_coexist->fBtcGet(
+		p_bt_coexist, BTC_GET_U4_WIFI_TRAFFIC_DIRECTION, &wifiTrafficDir
 	);
-	pBtCoexist->fBtcGet(
-		pBtCoexist, BTC_GET_BL_WIFI_UNDER_B_MODE, &bWifiUnderBMode
+	p_bt_coexist->fBtcGet(
+		p_bt_coexist, BTC_GET_BL_WIFI_UNDER_B_MODE, &wifi_under_bmode
 	);
 
 	CL_SPRINTF(
@@ -2867,15 +2865,15 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 		BT_TMP_BUF_SIZE,
 		"\r\n %-35s = %s / %s/ %s/ AP =%d/ %s ", "Wifi status", \
 		(bWifiUnder5G ? "5G" : "2.4G"),
-		((bWifiUnderBMode) ? "11b" : ((BTC_WIFI_BW_LEGACY == wifiBw) ? "11bg" : (((BTC_WIFI_BW_HT40 == wifiBw) ? "HT40" : "HT20")))),
+		((wifi_under_bmode) ? "11b" : ((BTC_WIFI_BW_LEGACY == wifiBw) ? "11bg" : (((BTC_WIFI_BW_HT40 == wifiBw) ? "HT40" : "HT20")))),
 		((!bWifiBusy) ? "idle" : ((BTC_WIFI_TRAFFIC_TX == wifiTrafficDir) ? "uplink" : "downlink")),
-		pCoexSta->nScanAPNum,
-		(pCoexSta->bCCKLock) ? "Lock" : "noLock"
+		p_coex_sta->nScanAPNum,
+		(p_coex_sta->bCCKLock) ? "Lock" : "noLock"
 	);
 	CL_PRINTF(cliBuf);
 
-	pBtCoexist->fBtcGet(
-		pBtCoexist, BTC_GET_U4_WIFI_LINK_STATUS, &wifiLinkStatus
+	p_bt_coexist->fBtcGet(
+		p_bt_coexist, BTC_GET_U4_WIFI_LINK_STATUS, &wifiLinkStatus
 	);
 	CL_SPRINTF(
 		cliBuf,
@@ -2895,14 +2893,14 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 		cliBuf,
 		BT_TMP_BUF_SIZE,
 		"\r\n %-35s = [%s/ %d/ %d/ %d] ", "BT [status/ rssi/ retryCnt/ popCnt]", \
-		((pBtCoexist->btInfo.bBtDisabled) ? ("disabled") : ((pCoexSta->bC2hBtInquiryPage) ? ("inquiry/page scan") : ((BT_8723B_1ANT_BT_STATUS_NON_CONNECTED_IDLE == pCoexDm->btStatus) ? "non-connected idle" :
-		((BT_8723B_1ANT_BT_STATUS_CONNECTED_IDLE == pCoexDm->btStatus) ? "connected-idle" : "busy")))),
-		pCoexSta->btRssi, pCoexSta->btRetryCnt, pCoexSta->popEventCnt
+		((p_bt_coexist->btInfo.bBtDisabled) ? ("disabled") : ((p_coex_sta->bC2hBtInquiryPage) ? ("inquiry/page scan") : ((BT_8723B_1ANT_BT_STATUS_NON_CONNECTED_IDLE == p_coex_dm->btStatus) ? "non-connected idle" :
+		((BT_8723B_1ANT_BT_STATUS_CONNECTED_IDLE == p_coex_dm->btStatus) ? "connected-idle" : "busy")))),
+		p_coex_sta->btRssi, p_coex_sta->btRetryCnt, p_coex_sta->popEventCnt
 	);
 	CL_PRINTF(cliBuf);
 
 	if (PopReportIn10s >= 5) {
-		pCoexSta->popEventCnt = 0;
+		p_coex_sta->popEventCnt = 0;
 		PopReportIn10s = 0;
 	}
 
@@ -2919,7 +2917,7 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	CL_PRINTF(cliBuf);
 
 	if (pStackInfo->bProfileNotified) {
-		pBtCoexist->fBtcDispDbgMsg(pBtCoexist, BTC_DBG_DISP_BT_LINK_INFO);
+		p_bt_coexist->fBtcDispDbgMsg(p_bt_coexist, BTC_DBG_DISP_BT_LINK_INFO);
 	} else {
 		CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = %s", "BT Role", \
 		(pBtLinkInfo->bSlaveRole) ? "Slave" : "Master");
@@ -2927,7 +2925,7 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	}
 
 
-	btInfoExt = pCoexSta->btInfoExt;
+	btInfoExt = p_coex_sta->btInfoExt;
 	CL_SPRINTF(
 		cliBuf,
 		BT_TMP_BUF_SIZE,
@@ -2937,15 +2935,15 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	CL_PRINTF(cliBuf);
 
 	for (i = 0; i < BT_INFO_SRC_8723B_1ANT_MAX; i++) {
-		if (pCoexSta->btInfoC2hCnt[i]) {
+		if (p_coex_sta->btInfoC2hCnt[i]) {
 			CL_SPRINTF(
 				cliBuf,
 				BT_TMP_BUF_SIZE,
-				"\r\n %-35s = %02x %02x %02x %02x %02x %02x %02x(%d)", GLBtInfoSrc8723b1Ant[i], \
-				pCoexSta->btInfoC2h[i][0], pCoexSta->btInfoC2h[i][1],
-				pCoexSta->btInfoC2h[i][2], pCoexSta->btInfoC2h[i][3],
-				pCoexSta->btInfoC2h[i][4], pCoexSta->btInfoC2h[i][5],
-				pCoexSta->btInfoC2h[i][6], pCoexSta->btInfoC2hCnt[i]
+				"\r\n %-35s = %02x %02x %02x %02x %02x %02x %02x(%d)", gl_bt_info_src_8723b_1ant[i], \
+				p_coex_sta->btInfoC2h[i][0], p_coex_sta->btInfoC2h[i][1],
+				p_coex_sta->btInfoC2h[i][2], p_coex_sta->btInfoC2h[i][3],
+				p_coex_sta->btInfoC2h[i][4], p_coex_sta->btInfoC2h[i][5],
+				p_coex_sta->btInfoC2h[i][6], p_coex_sta->btInfoC2hCnt[i]
 			);
 			CL_PRINTF(cliBuf);
 		}
@@ -2954,15 +2952,15 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 		cliBuf,
 		BT_TMP_BUF_SIZE,
 		"\r\n %-35s = %s/%s, (0x%x/0x%x)", "PS state, IPS/LPS, (lps/rpwm)", \
-		(pCoexSta->bUnderIps ? "IPS ON" : "IPS OFF"),
-		(pCoexSta->bUnderLps ? "LPS ON" : "LPS OFF"),
-		pBtCoexist->btInfo.lpsVal,
-		pBtCoexist->btInfo.rpwmVal
+		(p_coex_sta->bUnderIps ? "IPS ON" : "IPS OFF"),
+		(p_coex_sta->bUnderLps ? "LPS ON" : "LPS OFF"),
+		p_bt_coexist->btInfo.lpsVal,
+		p_bt_coexist->btInfo.rpwmVal
 	);
 	CL_PRINTF(cliBuf);
-	pBtCoexist->fBtcDispDbgMsg(pBtCoexist, BTC_DBG_DISP_FW_PWR_MODE_CMD);
+	p_bt_coexist->fBtcDispDbgMsg(p_bt_coexist, BTC_DBG_DISP_FW_PWR_MODE_CMD);
 
-	if (!pBtCoexist->bManualControl) {
+	if (!p_bt_coexist->bManualControl) {
 		/*  Sw mechanism */
 		CL_SPRINTF(
 			cliBuf,
@@ -2975,7 +2973,7 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 			cliBuf,
 			BT_TMP_BUF_SIZE,
 			"\r\n %-35s = %d", "SM[LowPenaltyRA]", \
-			pCoexDm->bCurLowPenaltyRa
+			p_coex_dm->bCurLowPenaltyRa
 		);
 		CL_PRINTF(cliBuf);
 
@@ -2983,16 +2981,16 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 			cliBuf,
 			BT_TMP_BUF_SIZE,
 			"\r\n %-35s = %s/ %s/ %d ", "DelBA/ BtCtrlAgg/ AggSize", \
-			(pBtCoexist->btInfo.bRejectAggPkt ? "Yes" : "No"),
-			(pBtCoexist->btInfo.bBtCtrlAggBufSize ? "Yes" : "No"),
-			pBtCoexist->btInfo.aggBufSize
+			(p_bt_coexist->btInfo.bRejectAggPkt ? "Yes" : "No"),
+			(p_bt_coexist->btInfo.bBtCtrlAggBufSize ? "Yes" : "No"),
+			p_bt_coexist->btInfo.aggBufSize
 		);
 		CL_PRINTF(cliBuf);
 		CL_SPRINTF(
 			cliBuf,
 			BT_TMP_BUF_SIZE,
 			"\r\n %-35s = 0x%x ", "Rate Mask", \
-			pBtCoexist->btInfo.raMask
+			p_bt_coexist->btInfo.raMask
 		);
 		CL_PRINTF(cliBuf);
 
@@ -3000,24 +2998,24 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 		CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s", "============[Fw mechanism]============");
 		CL_PRINTF(cliBuf);
 
-		psTdmaCase = pCoexDm->curPsTdma;
+		psTdmaCase = p_coex_dm->curPsTdma;
 		CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = %02x %02x %02x %02x %02x case-%d (auto:%d)", "PS TDMA", \
-			pCoexDm->psTdmaPara[0], pCoexDm->psTdmaPara[1],
-			pCoexDm->psTdmaPara[2], pCoexDm->psTdmaPara[3],
-			pCoexDm->psTdmaPara[4], psTdmaCase, pCoexDm->bAutoTdmaAdjust);
+			p_coex_dm->psTdmaPara[0], p_coex_dm->psTdmaPara[1],
+			p_coex_dm->psTdmaPara[2], p_coex_dm->psTdmaPara[3],
+			p_coex_dm->psTdmaPara[4], psTdmaCase, p_coex_dm->bAutoTdmaAdjust);
 		CL_PRINTF(cliBuf);
 
 		CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = %d", "Coex Table Type", \
-			pCoexSta->nCoexTableType);
+			p_coex_sta->nCoexTableType);
 		CL_PRINTF(cliBuf);
 
 		CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = %d", "IgnWlanAct", \
-			pCoexDm->bCurIgnoreWlanAct);
+			p_coex_dm->bCurIgnoreWlanAct);
 		CL_PRINTF(cliBuf);
 
 		/*
 		CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = 0x%x ", "Latest error condition(should be 0)", \
-			pCoexDm->errorCondition);
+			p_coex_dm->errorCondition);
 		CL_PRINTF(cliBuf);
 		*/
 	}
@@ -3027,20 +3025,20 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	CL_PRINTF(cliBuf);
 
 	CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = 0x%x/0x%x/0x%x/0x%x", "backup ARFR1/ARFR2/RL/AMaxTime", \
-		pCoexDm->backupArfrCnt1, pCoexDm->backupArfrCnt2, pCoexDm->backupRetryLimit, pCoexDm->backupAmpduMaxTime);
+		p_coex_dm->backupArfrCnt1, p_coex_dm->backupArfrCnt2, p_coex_dm->backupRetryLimit, p_coex_dm->backupAmpduMaxTime);
 	CL_PRINTF(cliBuf);
 
-	u4Tmp[0] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x430);
-	u4Tmp[1] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x434);
-	u2Tmp[0] = pBtCoexist->fBtcRead2Byte(pBtCoexist, 0x42a);
-	u1Tmp[0] = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x456);
+	u4Tmp[0] = p_bt_coexist->fBtcRead4Byte(p_bt_coexist, 0x430);
+	u4Tmp[1] = p_bt_coexist->fBtcRead4Byte(p_bt_coexist, 0x434);
+	u2Tmp[0] = p_bt_coexist->fBtcRead2Byte(p_bt_coexist, 0x42a);
+	u1Tmp[0] = p_bt_coexist->fBtcRead1Byte(p_bt_coexist, 0x456);
 	CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = 0x%x/0x%x/0x%x/0x%x", "0x430/0x434/0x42a/0x456", \
 		u4Tmp[0], u4Tmp[1], u2Tmp[0], u1Tmp[0]);
 	CL_PRINTF(cliBuf);
 
-	u1Tmp[0] = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x778);
-	u4Tmp[0] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x6cc);
-	u4Tmp[1] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x880);
+	u1Tmp[0] = p_bt_coexist->fBtcRead1Byte(p_bt_coexist, 0x778);
+	u4Tmp[0] = p_bt_coexist->fBtcRead4Byte(p_bt_coexist, 0x6cc);
+	u4Tmp[1] = p_bt_coexist->fBtcRead4Byte(p_bt_coexist, 0x880);
 	CL_SPRINTF(
 		cliBuf, BT_TMP_BUF_SIZE,
 		"\r\n %-35s = 0x%x/ 0x%x/ 0x%x", "0x778/0x6cc/0x880[29:25]", \
@@ -3048,10 +3046,10 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	);
 	CL_PRINTF(cliBuf);
 
-	u4Tmp[0] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x948);
-	u1Tmp[0] = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x67);
-	u4Tmp[1] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x764);
-	u1Tmp[1] = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x76e);
+	u4Tmp[0] = p_bt_coexist->fBtcRead4Byte(p_bt_coexist, 0x948);
+	u1Tmp[0] = p_bt_coexist->fBtcRead1Byte(p_bt_coexist, 0x67);
+	u4Tmp[1] = p_bt_coexist->fBtcRead4Byte(p_bt_coexist, 0x764);
+	u1Tmp[1] = p_bt_coexist->fBtcRead1Byte(p_bt_coexist, 0x76e);
 	CL_SPRINTF(
 		cliBuf,
 		BT_TMP_BUF_SIZE,
@@ -3060,9 +3058,9 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	);
 	CL_PRINTF(cliBuf);
 
-	u4Tmp[0] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x92c);
-	u4Tmp[1] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x930);
-	u4Tmp[2] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x944);
+	u4Tmp[0] = p_bt_coexist->fBtcRead4Byte(p_bt_coexist, 0x92c);
+	u4Tmp[1] = p_bt_coexist->fBtcRead4Byte(p_bt_coexist, 0x930);
+	u4Tmp[2] = p_bt_coexist->fBtcRead4Byte(p_bt_coexist, 0x944);
 	CL_SPRINTF(
 		cliBuf,
 		BT_TMP_BUF_SIZE,
@@ -3071,10 +3069,10 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	);
 	CL_PRINTF(cliBuf);
 
-	u1Tmp[0] = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x39);
-	u1Tmp[1] = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x40);
-	u4Tmp[0] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x4c);
-	u1Tmp[2] = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x64);
+	u1Tmp[0] = p_bt_coexist->fBtcRead1Byte(p_bt_coexist, 0x39);
+	u1Tmp[1] = p_bt_coexist->fBtcRead1Byte(p_bt_coexist, 0x40);
+	u4Tmp[0] = p_bt_coexist->fBtcRead4Byte(p_bt_coexist, 0x4c);
+	u1Tmp[2] = p_bt_coexist->fBtcRead1Byte(p_bt_coexist, 0x64);
 	CL_SPRINTF(
 		cliBuf,
 		BT_TMP_BUF_SIZE,
@@ -3086,8 +3084,8 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	);
 	CL_PRINTF(cliBuf);
 
-	u4Tmp[0] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x550);
-	u1Tmp[0] = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x522);
+	u4Tmp[0] = p_bt_coexist->fBtcRead4Byte(p_bt_coexist, 0x550);
+	u1Tmp[0] = p_bt_coexist->fBtcRead1Byte(p_bt_coexist, 0x522);
 	CL_SPRINTF(
 		cliBuf,
 		BT_TMP_BUF_SIZE,
@@ -3096,8 +3094,8 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	);
 	CL_PRINTF(cliBuf);
 
-	u4Tmp[0] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0xc50);
-	u1Tmp[0] = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x49c);
+	u4Tmp[0] = p_bt_coexist->fBtcRead4Byte(p_bt_coexist, 0xc50);
+	u1Tmp[0] = p_bt_coexist->fBtcRead1Byte(p_bt_coexist, 0x49c);
 	CL_SPRINTF(
 		cliBuf,
 		BT_TMP_BUF_SIZE,
@@ -3106,13 +3104,13 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 	);
 	CL_PRINTF(cliBuf);
 
-	u4Tmp[0] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0xda0);
-	u4Tmp[1] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0xda4);
-	u4Tmp[2] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0xda8);
-	u4Tmp[3] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0xcf0);
+	u4Tmp[0] = p_bt_coexist->fBtcRead4Byte(p_bt_coexist, 0xda0);
+	u4Tmp[1] = p_bt_coexist->fBtcRead4Byte(p_bt_coexist, 0xda4);
+	u4Tmp[2] = p_bt_coexist->fBtcRead4Byte(p_bt_coexist, 0xda8);
+	u4Tmp[3] = p_bt_coexist->fBtcRead4Byte(p_bt_coexist, 0xcf0);
 
-	u1Tmp[0] = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0xa5b);
-	u1Tmp[1] = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0xa5c);
+	u1Tmp[0] = p_bt_coexist->fBtcRead1Byte(p_bt_coexist, 0xa5b);
+	u1Tmp[1] = p_bt_coexist->fBtcRead1Byte(p_bt_coexist, 0xa5c);
 
 	faOfdm =
 		((u4Tmp[0] & 0xffff0000) >> 16) +
@@ -3134,10 +3132,10 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 		cliBuf,
 		BT_TMP_BUF_SIZE,
 		"\r\n %-35s = %d/ %d/ %d/ %d", "CRC_OK CCK/11g/11n/11n-Agg", \
-		pCoexSta->nCRCOK_CCK,
-		pCoexSta->nCRCOK_11g,
-		pCoexSta->nCRCOK_11n,
-		pCoexSta->nCRCOK_11nAgg
+		p_coex_sta->nCRCOK_CCK,
+		p_coex_sta->nCRCOK_11g,
+		p_coex_sta->nCRCOK_11n,
+		p_coex_sta->nCRCOK_11nAgg
 	);
 	CL_PRINTF(cliBuf);
 
@@ -3145,16 +3143,16 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 		cliBuf,
 		BT_TMP_BUF_SIZE,
 		"\r\n %-35s = %d/ %d/ %d/ %d", "CRC_Err CCK/11g/11n/11n-Agg", \
-		pCoexSta->nCRCErr_CCK,
-		pCoexSta->nCRCErr_11g,
-		pCoexSta->nCRCErr_11n,
-		pCoexSta->nCRCErr_11nAgg
+		p_coex_sta->nCRCErr_CCK,
+		p_coex_sta->nCRCErr_11g,
+		p_coex_sta->nCRCErr_11n,
+		p_coex_sta->nCRCErr_11nAgg
 	);
 	CL_PRINTF(cliBuf);
 
-	u4Tmp[0] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x6c0);
-	u4Tmp[1] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x6c4);
-	u4Tmp[2] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x6c8);
+	u4Tmp[0] = p_bt_coexist->fBtcRead4Byte(p_bt_coexist, 0x6c0);
+	u4Tmp[1] = p_bt_coexist->fBtcRead4Byte(p_bt_coexist, 0x6c4);
+	u4Tmp[2] = p_bt_coexist->fBtcRead4Byte(p_bt_coexist, 0x6c8);
 	CL_SPRINTF(
 		cliBuf,
 		BT_TMP_BUF_SIZE,
@@ -3166,66 +3164,66 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 		cliBuf,
 		BT_TMP_BUF_SIZE,
 		"\r\n %-35s = %d/ %d", "0x770(high-pri rx/tx)", \
-		pCoexSta->highPriorityRx, pCoexSta->highPriorityTx
+		p_coex_sta->highPriorityRx, p_coex_sta->highPriorityTx
 	);
 	CL_PRINTF(cliBuf);
 	CL_SPRINTF(
 		cliBuf,
 		BT_TMP_BUF_SIZE,
 		"\r\n %-35s = %d/ %d", "0x774(low-pri rx/tx)", \
-		pCoexSta->lowPriorityRx, pCoexSta->lowPriorityTx
+		p_coex_sta->lowPriorityRx, p_coex_sta->lowPriorityTx
 	);
 	CL_PRINTF(cliBuf);
 
-	pBtCoexist->fBtcDispDbgMsg(pBtCoexist, BTC_DBG_DISP_COEX_STATISTICS);
+	p_bt_coexist->fBtcDispDbgMsg(p_bt_coexist, BTC_DBG_DISP_COEX_STATISTICS);
 }
 
 
-void EXhalbtc8723b1ant_IpsNotify(struct btc_coexist *pBtCoexist, u8 type)
+void EXhalbtc8723b1ant_IpsNotify(struct btc_coexist *p_bt_coexist, u8 type)
 {
-	if (pBtCoexist->bManualControl ||	pBtCoexist->bStopCoexDm)
+	if (p_bt_coexist->bManualControl ||	p_bt_coexist->bStopCoexDm)
 		return;
 
 	if (BTC_IPS_ENTER == type) {
 		BTC_PRINT(
 			BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], IPS ENTER notify\n")
 		);
-		pCoexSta->bUnderIps = true;
+		p_coex_sta->bUnderIps = true;
 
-		halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, false, 0);
-		halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 0);
-		halbtc8723b1ant_SetAntPath(pBtCoexist, BTC_ANT_PATH_BT, false, true);
+		halbtc8723b1ant_PsTdma(p_bt_coexist, NORMAL_EXEC, false, 0);
+		halbtc8723b1ant_CoexTableWithType(p_bt_coexist, NORMAL_EXEC, 0);
+		halbtc8723b1ant_SetAntPath(p_bt_coexist, BTC_ANT_PATH_BT, false, true);
 	} else if (BTC_IPS_LEAVE == type) {
 		BTC_PRINT(
 			BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], IPS LEAVE notify\n")
 		);
-		pCoexSta->bUnderIps = false;
+		p_coex_sta->bUnderIps = false;
 
-		halbtc8723b1ant_InitHwConfig(pBtCoexist, false, false);
-		halbtc8723b1ant_InitCoexDm(pBtCoexist);
-		halbtc8723b1ant_QueryBtInfo(pBtCoexist);
+		halbtc8723b1ant_InitHwConfig(p_bt_coexist, false, false);
+		halbtc8723b1ant_InitCoexDm(p_bt_coexist);
+		halbtc8723b1ant_QueryBtInfo(p_bt_coexist);
 	}
 }
 
-void EXhalbtc8723b1ant_LpsNotify(struct btc_coexist *pBtCoexist, u8 type)
+void EXhalbtc8723b1ant_LpsNotify(struct btc_coexist *p_bt_coexist, u8 type)
 {
-	if (pBtCoexist->bManualControl || pBtCoexist->bStopCoexDm)
+	if (p_bt_coexist->bManualControl || p_bt_coexist->bStopCoexDm)
 		return;
 
 	if (BTC_LPS_ENABLE == type) {
 		BTC_PRINT(
 			BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], LPS ENABLE notify\n")
 		);
-		pCoexSta->bUnderLps = true;
+		p_coex_sta->bUnderLps = true;
 	} else if (BTC_LPS_DISABLE == type) {
 		BTC_PRINT(
 			BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], LPS DISABLE notify\n")
 		);
-		pCoexSta->bUnderLps = false;
+		p_coex_sta->bUnderLps = false;
 	}
 }
 
-void EXhalbtc8723b1ant_ScanNotify(struct btc_coexist *pBtCoexist, u8 type)
+void EXhalbtc8723b1ant_ScanNotify(struct btc_coexist *p_bt_coexist, u8 type)
 {
 	bool bWifiConnected = false, bBtHsOn = false;
 	u32 wifiLinkStatus = 0;
@@ -3236,19 +3234,19 @@ void EXhalbtc8723b1ant_ScanNotify(struct btc_coexist *pBtCoexist, u8 type)
 	u8 u1Tmpa, u1Tmpb;
 	u32 u4Tmp;
 
-	if (pBtCoexist->bManualControl || pBtCoexist->bStopCoexDm)
+	if (p_bt_coexist->bManualControl || p_bt_coexist->bStopCoexDm)
 		return;
 
 	if (BTC_SCAN_START == type) {
-		pCoexSta->bWiFiIsHighPriTask = true;
+		p_coex_sta->bWiFiIsHighPriTask = true;
 		BTC_PRINT(
 			BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], SCAN START notify\n")
 		);
 
-		halbtc8723b1ant_PsTdma(pBtCoexist, FORCE_EXEC, false, 8);  /* Force antenna setup for no scan result issue */
-		u4Tmp = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x948);
-		u1Tmpa = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x765);
-		u1Tmpb = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x67);
+		halbtc8723b1ant_PsTdma(p_bt_coexist, FORCE_EXEC, false, 8);  /* Force antenna setup for no scan result issue */
+		u4Tmp = p_bt_coexist->fBtcRead4Byte(p_bt_coexist, 0x948);
+		u1Tmpa = p_bt_coexist->fBtcRead1Byte(p_bt_coexist, 0x765);
+		u1Tmpb = p_bt_coexist->fBtcRead1Byte(p_bt_coexist, 0x67);
 
 
 		BTC_PRINT(
@@ -3262,60 +3260,60 @@ void EXhalbtc8723b1ant_ScanNotify(struct btc_coexist *pBtCoexist, u8 type)
 			)
 		);
 	} else {
-		pCoexSta->bWiFiIsHighPriTask = false;
+		p_coex_sta->bWiFiIsHighPriTask = false;
 		BTC_PRINT(
 			BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], SCAN FINISH notify\n")
 		);
 
-		pBtCoexist->fBtcGet(
-			pBtCoexist, BTC_GET_U1_AP_NUM, &pCoexSta->nScanAPNum
+		p_bt_coexist->fBtcGet(
+			p_bt_coexist, BTC_GET_U1_AP_NUM, &p_coex_sta->nScanAPNum
 		);
 	}
 
-	if (pBtCoexist->btInfo.bBtDisabled)
+	if (p_bt_coexist->btInfo.bBtDisabled)
 		return;
 
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_HS_OPERATION, &bBtHsOn);
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_CONNECTED, &bWifiConnected);
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_BL_HS_OPERATION, &bBtHsOn);
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_BL_WIFI_CONNECTED, &bWifiConnected);
 
-	halbtc8723b1ant_QueryBtInfo(pBtCoexist);
+	halbtc8723b1ant_QueryBtInfo(p_bt_coexist);
 
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_U4_WIFI_LINK_STATUS, &wifiLinkStatus);
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_U4_WIFI_LINK_STATUS, &wifiLinkStatus);
 	numOfWifiLink = wifiLinkStatus >> 16;
 
 	if (numOfWifiLink >= 2) {
-		halbtc8723b1ant_LimitedTx(pBtCoexist, NORMAL_EXEC, 0, 0, 0, 0);
+		halbtc8723b1ant_LimitedTx(p_bt_coexist, NORMAL_EXEC, 0, 0, 0, 0);
 		halbtc8723b1ant_LimitedRx(
-			pBtCoexist, NORMAL_EXEC, false, bBtCtrlAggBufSize, aggBufSize
+			p_bt_coexist, NORMAL_EXEC, false, bBtCtrlAggBufSize, aggBufSize
 		);
-		halbtc8723b1ant_ActionWifiMultiPort(pBtCoexist);
+		halbtc8723b1ant_ActionWifiMultiPort(p_bt_coexist);
 		return;
 	}
 
-	if (pCoexSta->bC2hBtInquiryPage) {
-		halbtc8723b1ant_ActionBtInquiry(pBtCoexist);
+	if (p_coex_sta->bC2hBtInquiryPage) {
+		halbtc8723b1ant_ActionBtInquiry(p_bt_coexist);
 		return;
 	} else if (bBtHsOn) {
-		halbtc8723b1ant_ActionHs(pBtCoexist);
+		halbtc8723b1ant_ActionHs(p_bt_coexist);
 		return;
 	}
 
 	if (BTC_SCAN_START == type) {
 		/* BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], SCAN START notify\n")); */
 		if (!bWifiConnected)	/*  non-connected scan */
-			halbtc8723b1ant_ActionWifiNotConnectedScan(pBtCoexist);
+			halbtc8723b1ant_ActionWifiNotConnectedScan(p_bt_coexist);
 		else	/*  wifi is connected */
-			halbtc8723b1ant_ActionWifiConnectedScan(pBtCoexist);
+			halbtc8723b1ant_ActionWifiConnectedScan(p_bt_coexist);
 	} else if (BTC_SCAN_FINISH == type) {
 		/* BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], SCAN FINISH notify\n")); */
 		if (!bWifiConnected)	/*  non-connected scan */
-			halbtc8723b1ant_ActionWifiNotConnected(pBtCoexist);
+			halbtc8723b1ant_ActionWifiNotConnected(p_bt_coexist);
 		else
-			halbtc8723b1ant_ActionWifiConnected(pBtCoexist);
+			halbtc8723b1ant_ActionWifiConnected(p_bt_coexist);
 	}
 }
 
-void EXhalbtc8723b1ant_ConnectNotify(struct btc_coexist *pBtCoexist, u8 type)
+void EXhalbtc8723b1ant_ConnectNotify(struct btc_coexist *p_bt_coexist, u8 type)
 {
 	bool bWifiConnected = false, bBtHsOn = false;
 	u32 wifiLinkStatus = 0;
@@ -3324,125 +3322,125 @@ void EXhalbtc8723b1ant_ConnectNotify(struct btc_coexist *pBtCoexist, u8 type)
 	u8 aggBufSize = 5;
 
 	if (
-		pBtCoexist->bManualControl ||
-		pBtCoexist->bStopCoexDm ||
-		pBtCoexist->btInfo.bBtDisabled
+		p_bt_coexist->bManualControl ||
+		p_bt_coexist->bStopCoexDm ||
+		p_bt_coexist->btInfo.bBtDisabled
 	)
 		return;
 
 	if (BTC_ASSOCIATE_START == type) {
-		pCoexSta->bWiFiIsHighPriTask = true;
+		p_coex_sta->bWiFiIsHighPriTask = true;
 		BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], CONNECT START notify\n"));
-		 pCoexDm->nArpCnt = 0;
+		 p_coex_dm->nArpCnt = 0;
 	} else {
-		pCoexSta->bWiFiIsHighPriTask = false;
+		p_coex_sta->bWiFiIsHighPriTask = false;
 		BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], CONNECT FINISH notify\n"));
-		/* pCoexDm->nArpCnt = 0; */
+		/* p_coex_dm->nArpCnt = 0; */
 	}
 
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_U4_WIFI_LINK_STATUS, &wifiLinkStatus);
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_U4_WIFI_LINK_STATUS, &wifiLinkStatus);
 	numOfWifiLink = wifiLinkStatus >> 16;
 	if (numOfWifiLink >= 2) {
-		halbtc8723b1ant_LimitedTx(pBtCoexist, NORMAL_EXEC, 0, 0, 0, 0);
-		halbtc8723b1ant_LimitedRx(pBtCoexist, NORMAL_EXEC, false, bBtCtrlAggBufSize, aggBufSize);
-		halbtc8723b1ant_ActionWifiMultiPort(pBtCoexist);
+		halbtc8723b1ant_LimitedTx(p_bt_coexist, NORMAL_EXEC, 0, 0, 0, 0);
+		halbtc8723b1ant_LimitedRx(p_bt_coexist, NORMAL_EXEC, false, bBtCtrlAggBufSize, aggBufSize);
+		halbtc8723b1ant_ActionWifiMultiPort(p_bt_coexist);
 		return;
 	}
 
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_HS_OPERATION, &bBtHsOn);
-	if (pCoexSta->bC2hBtInquiryPage) {
-		halbtc8723b1ant_ActionBtInquiry(pBtCoexist);
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_BL_HS_OPERATION, &bBtHsOn);
+	if (p_coex_sta->bC2hBtInquiryPage) {
+		halbtc8723b1ant_ActionBtInquiry(p_bt_coexist);
 		return;
 	} else if (bBtHsOn) {
-		halbtc8723b1ant_ActionHs(pBtCoexist);
+		halbtc8723b1ant_ActionHs(p_bt_coexist);
 		return;
 	}
 
 	if (BTC_ASSOCIATE_START == type) {
 		/* BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], CONNECT START notify\n")); */
-		halbtc8723b1ant_ActionWifiNotConnectedAssoAuth(pBtCoexist);
+		halbtc8723b1ant_ActionWifiNotConnectedAssoAuth(p_bt_coexist);
 	} else if (BTC_ASSOCIATE_FINISH == type) {
 		/* BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], CONNECT FINISH notify\n")); */
 
-		pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_CONNECTED, &bWifiConnected);
+		p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_BL_WIFI_CONNECTED, &bWifiConnected);
 		if (!bWifiConnected) /*  non-connected scan */
-			halbtc8723b1ant_ActionWifiNotConnected(pBtCoexist);
+			halbtc8723b1ant_ActionWifiNotConnected(p_bt_coexist);
 		else
-			halbtc8723b1ant_ActionWifiConnected(pBtCoexist);
+			halbtc8723b1ant_ActionWifiConnected(p_bt_coexist);
 	}
 }
 
-void EXhalbtc8723b1ant_MediaStatusNotify(struct btc_coexist *pBtCoexist, u8 type)
+void EXhalbtc8723b1ant_MediaStatusNotify(struct btc_coexist *p_bt_coexist, u8 type)
 {
-	u8 H2C_Parameter[3] = {0};
+	u8 h2c_parameter[3] = {0};
 	u32 wifiBw;
 	u8 wifiCentralChnl;
-	bool bWifiUnderBMode = false;
+	bool wifi_under_bmode = false;
 
 	if (
-		pBtCoexist->bManualControl ||
-		pBtCoexist->bStopCoexDm ||
-		pBtCoexist->btInfo.bBtDisabled
+		p_bt_coexist->bManualControl ||
+		p_bt_coexist->bStopCoexDm ||
+		p_bt_coexist->btInfo.bBtDisabled
 	)
 		return;
 
 	if (BTC_MEDIA_CONNECT == type) {
 		BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], MEDIA connect notify\n"));
 
-		pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_UNDER_B_MODE, &bWifiUnderBMode);
+		p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_BL_WIFI_UNDER_B_MODE, &wifi_under_bmode);
 
 		/* Set CCK Tx/Rx high Pri except 11b mode */
-		if (bWifiUnderBMode) {
-			pBtCoexist->fBtcWrite1Byte(pBtCoexist, 0x6cd, 0x00); /* CCK Tx */
-			pBtCoexist->fBtcWrite1Byte(pBtCoexist, 0x6cf, 0x00); /* CCK Rx */
+		if (wifi_under_bmode) {
+			p_bt_coexist->fBtcWrite1Byte(p_bt_coexist, 0x6cd, 0x00); /* CCK Tx */
+			p_bt_coexist->fBtcWrite1Byte(p_bt_coexist, 0x6cf, 0x00); /* CCK Rx */
 		} else {
-			pBtCoexist->fBtcWrite1Byte(pBtCoexist, 0x6cd, 0x10); /* CCK Tx */
-			pBtCoexist->fBtcWrite1Byte(pBtCoexist, 0x6cf, 0x10); /* CCK Rx */
+			p_bt_coexist->fBtcWrite1Byte(p_bt_coexist, 0x6cd, 0x10); /* CCK Tx */
+			p_bt_coexist->fBtcWrite1Byte(p_bt_coexist, 0x6cf, 0x10); /* CCK Rx */
 		}
 
-		pCoexDm->backupArfrCnt1 = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x430);
-		pCoexDm->backupArfrCnt2 = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x434);
-		pCoexDm->backupRetryLimit = pBtCoexist->fBtcRead2Byte(pBtCoexist, 0x42a);
-		pCoexDm->backupAmpduMaxTime = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x456);
+		p_coex_dm->backupArfrCnt1 = p_bt_coexist->fBtcRead4Byte(p_bt_coexist, 0x430);
+		p_coex_dm->backupArfrCnt2 = p_bt_coexist->fBtcRead4Byte(p_bt_coexist, 0x434);
+		p_coex_dm->backupRetryLimit = p_bt_coexist->fBtcRead2Byte(p_bt_coexist, 0x42a);
+		p_coex_dm->backupAmpduMaxTime = p_bt_coexist->fBtcRead1Byte(p_bt_coexist, 0x456);
 	} else {
 		BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], MEDIA disconnect notify\n"));
-		pCoexDm->nArpCnt = 0;
+		p_coex_dm->nArpCnt = 0;
 
-		pBtCoexist->fBtcWrite1Byte(pBtCoexist, 0x6cd, 0x0); /* CCK Tx */
-		pBtCoexist->fBtcWrite1Byte(pBtCoexist, 0x6cf, 0x0); /* CCK Rx */
+		p_bt_coexist->fBtcWrite1Byte(p_bt_coexist, 0x6cd, 0x0); /* CCK Tx */
+		p_bt_coexist->fBtcWrite1Byte(p_bt_coexist, 0x6cf, 0x0); /* CCK Rx */
 	}
 
 	/*  only 2.4G we need to inform bt the chnl mask */
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_U1_WIFI_CENTRAL_CHNL, &wifiCentralChnl);
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_U1_WIFI_CENTRAL_CHNL, &wifiCentralChnl);
 	if ((BTC_MEDIA_CONNECT == type) && (wifiCentralChnl <= 14)) {
-		/* H2C_Parameter[0] = 0x1; */
-		H2C_Parameter[0] = 0x0;
-		H2C_Parameter[1] = wifiCentralChnl;
-		pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_U4_WIFI_BW, &wifiBw);
+		/* h2c_parameter[0] = 0x1; */
+		h2c_parameter[0] = 0x0;
+		h2c_parameter[1] = wifiCentralChnl;
+		p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_U4_WIFI_BW, &wifiBw);
 
 		if (BTC_WIFI_BW_HT40 == wifiBw)
-			H2C_Parameter[2] = 0x30;
+			h2c_parameter[2] = 0x30;
 		else
-			H2C_Parameter[2] = 0x20;
+			h2c_parameter[2] = 0x20;
 	}
 
-	pCoexDm->wifiChnlInfo[0] = H2C_Parameter[0];
-	pCoexDm->wifiChnlInfo[1] = H2C_Parameter[1];
-	pCoexDm->wifiChnlInfo[2] = H2C_Parameter[2];
+	p_coex_dm->wifiChnlInfo[0] = h2c_parameter[0];
+	p_coex_dm->wifiChnlInfo[1] = h2c_parameter[1];
+	p_coex_dm->wifiChnlInfo[2] = h2c_parameter[2];
 
 	BTC_PRINT(
 		BTC_MSG_ALGORITHM,
 		ALGO_TRACE_FW_EXEC,
 		(
 			"[BTCoex], FW write 0x66 = 0x%x\n",
-			H2C_Parameter[0] << 16 | H2C_Parameter[1] << 8 | H2C_Parameter[2]
+			h2c_parameter[0] << 16 | h2c_parameter[1] << 8 | h2c_parameter[2]
 		)
 	);
 
-	pBtCoexist->fBtcFillH2c(pBtCoexist, 0x66, 3, H2C_Parameter);
+	p_bt_coexist->fBtcFillH2c(p_bt_coexist, 0x66, 3, h2c_parameter);
 }
 
-void EXhalbtc8723b1ant_SpecialPacketNotify(struct btc_coexist *pBtCoexist, u8 type)
+void EXhalbtc8723b1ant_SpecialPacketNotify(struct btc_coexist *p_bt_coexist, u8 type)
 {
 	bool bBtHsOn = false;
 	u32 wifiLinkStatus = 0;
@@ -3451,9 +3449,9 @@ void EXhalbtc8723b1ant_SpecialPacketNotify(struct btc_coexist *pBtCoexist, u8 ty
 	u8 aggBufSize = 5;
 
 	if (
-		pBtCoexist->bManualControl ||
-		pBtCoexist->bStopCoexDm ||
-		pBtCoexist->btInfo.bBtDisabled
+		p_bt_coexist->bManualControl ||
+		p_bt_coexist->bStopCoexDm ||
+		p_bt_coexist->btInfo.bBtDisabled
 	)
 		return;
 
@@ -3469,19 +3467,19 @@ void EXhalbtc8723b1ant_SpecialPacketNotify(struct btc_coexist *pBtCoexist, u8 ty
 				("[BTCoex], special Packet ARP notify\n")
 			);
 
-			pCoexDm->nArpCnt++;
+			p_coex_dm->nArpCnt++;
 			BTC_PRINT(
 				BTC_MSG_INTERFACE,
 				INTF_NOTIFY,
-				("[BTCoex], ARP Packet Count = %d\n", pCoexDm->nArpCnt)
+				("[BTCoex], ARP Packet Count = %d\n", p_coex_dm->nArpCnt)
 			);
 
-			if (pCoexDm->nArpCnt >= 10) /*  if APR PKT > 10 after connect, do not go to ActionWifiConnectedSpecialPacket(pBtCoexist) */
-				pCoexSta->bWiFiIsHighPriTask = false;
+			if (p_coex_dm->nArpCnt >= 10) /*  if APR PKT > 10 after connect, do not go to ActionWifiConnectedSpecialPacket(p_bt_coexist) */
+				p_coex_sta->bWiFiIsHighPriTask = false;
 			else
-				pCoexSta->bWiFiIsHighPriTask = true;
+				p_coex_sta->bWiFiIsHighPriTask = true;
 		} else {
-			pCoexSta->bWiFiIsHighPriTask = true;
+			p_coex_sta->bWiFiIsHighPriTask = true;
 			BTC_PRINT(
 				BTC_MSG_INTERFACE,
 				INTF_NOTIFY,
@@ -3489,7 +3487,7 @@ void EXhalbtc8723b1ant_SpecialPacketNotify(struct btc_coexist *pBtCoexist, u8 ty
 			);
 		}
 	} else {
-		pCoexSta->bWiFiIsHighPriTask = false;
+		p_coex_sta->bWiFiIsHighPriTask = false;
 		BTC_PRINT(
 			BTC_MSG_INTERFACE,
 			INTF_NOTIFY,
@@ -3497,41 +3495,41 @@ void EXhalbtc8723b1ant_SpecialPacketNotify(struct btc_coexist *pBtCoexist, u8 ty
 		);
 	}
 
-	pCoexSta->specialPktPeriodCnt = 0;
+	p_coex_sta->specialPktPeriodCnt = 0;
 
-	pBtCoexist->fBtcGet(
-		pBtCoexist, BTC_GET_U4_WIFI_LINK_STATUS, &wifiLinkStatus
+	p_bt_coexist->fBtcGet(
+		p_bt_coexist, BTC_GET_U4_WIFI_LINK_STATUS, &wifiLinkStatus
 	);
 	numOfWifiLink = wifiLinkStatus >> 16;
 
 	if (numOfWifiLink >= 2) {
-		halbtc8723b1ant_LimitedTx(pBtCoexist, NORMAL_EXEC, 0, 0, 0, 0);
+		halbtc8723b1ant_LimitedTx(p_bt_coexist, NORMAL_EXEC, 0, 0, 0, 0);
 		halbtc8723b1ant_LimitedRx(
-			pBtCoexist, NORMAL_EXEC, false, bBtCtrlAggBufSize, aggBufSize
+			p_bt_coexist, NORMAL_EXEC, false, bBtCtrlAggBufSize, aggBufSize
 		);
-		halbtc8723b1ant_ActionWifiMultiPort(pBtCoexist);
+		halbtc8723b1ant_ActionWifiMultiPort(p_bt_coexist);
 		return;
 	}
 
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_HS_OPERATION, &bBtHsOn);
-	if (pCoexSta->bC2hBtInquiryPage) {
-		halbtc8723b1ant_ActionBtInquiry(pBtCoexist);
+	p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_BL_HS_OPERATION, &bBtHsOn);
+	if (p_coex_sta->bC2hBtInquiryPage) {
+		halbtc8723b1ant_ActionBtInquiry(p_bt_coexist);
 		return;
 	} else if (bBtHsOn) {
-		halbtc8723b1ant_ActionHs(pBtCoexist);
+		halbtc8723b1ant_ActionHs(p_bt_coexist);
 		return;
 	}
 
 	if (
 		BTC_PACKET_DHCP == type ||
 		BTC_PACKET_EAPOL == type ||
-		((BTC_PACKET_ARP == type) && (pCoexSta->bWiFiIsHighPriTask))
+		((BTC_PACKET_ARP == type) && (p_coex_sta->bWiFiIsHighPriTask))
 	)
-		halbtc8723b1ant_ActionWifiConnectedSpecialPacket(pBtCoexist);
+		halbtc8723b1ant_ActionWifiConnectedSpecialPacket(p_bt_coexist);
 }
 
 void EXhalbtc8723b1ant_BtInfoNotify(
-	struct btc_coexist *pBtCoexist, u8 *tmpBuf, u8 length
+	struct btc_coexist *p_bt_coexist, u8 *tmpBuf, u8 length
 )
 {
 	u8 btInfo = 0;
@@ -3539,12 +3537,12 @@ void EXhalbtc8723b1ant_BtInfoNotify(
 	bool bWifiConnected = false;
 	bool bBtBusy = false;
 
-	pCoexSta->bC2hBtInfoReqSent = false;
+	p_coex_sta->bC2hBtInfoReqSent = false;
 
 	rspSource = tmpBuf[0] & 0xf;
 	if (rspSource >= BT_INFO_SRC_8723B_1ANT_MAX)
 		rspSource = BT_INFO_SRC_8723B_1ANT_WIFI_FW;
-	pCoexSta->btInfoC2hCnt[rspSource]++;
+	p_coex_sta->btInfoC2hCnt[rspSource]++;
 
 	BTC_PRINT(
 		BTC_MSG_INTERFACE,
@@ -3554,7 +3552,7 @@ void EXhalbtc8723b1ant_BtInfoNotify(
 		length)
 	);
 	for (i = 0; i < length; i++) {
-		pCoexSta->btInfoC2h[rspSource][i] = tmpBuf[i];
+		p_coex_sta->btInfoC2h[rspSource][i] = tmpBuf[i];
 		if (i == 1)
 			btInfo = tmpBuf[i];
 		if (i == length - 1)
@@ -3566,53 +3564,53 @@ void EXhalbtc8723b1ant_BtInfoNotify(
 	}
 
 	if (BT_INFO_SRC_8723B_1ANT_WIFI_FW != rspSource) {
-		pCoexSta->btRetryCnt = pCoexSta->btInfoC2h[rspSource][2] & 0xf;
+		p_coex_sta->btRetryCnt = p_coex_sta->btInfoC2h[rspSource][2] & 0xf;
 
-		if (pCoexSta->btRetryCnt >= 1)
-			pCoexSta->popEventCnt++;
+		if (p_coex_sta->btRetryCnt >= 1)
+			p_coex_sta->popEventCnt++;
 
-		if (pCoexSta->btInfoC2h[rspSource][2] & 0x20)
-			pCoexSta->bC2hBtPage = true;
+		if (p_coex_sta->btInfoC2h[rspSource][2] & 0x20)
+			p_coex_sta->bC2hBtPage = true;
 		else
-			pCoexSta->bC2hBtPage = false;
+			p_coex_sta->bC2hBtPage = false;
 
-		pCoexSta->btRssi = pCoexSta->btInfoC2h[rspSource][3] * 2 - 90;
-		/* pCoexSta->btInfoC2h[rspSource][3]*2+10; */
+		p_coex_sta->btRssi = p_coex_sta->btInfoC2h[rspSource][3] * 2 - 90;
+		/* p_coex_sta->btInfoC2h[rspSource][3]*2+10; */
 
-		pCoexSta->btInfoExt = pCoexSta->btInfoC2h[rspSource][4];
+		p_coex_sta->btInfoExt = p_coex_sta->btInfoC2h[rspSource][4];
 
-		pCoexSta->bBtTxRxMask = (pCoexSta->btInfoC2h[rspSource][2] & 0x40);
-		pBtCoexist->fBtcSet(pBtCoexist, BTC_SET_BL_BT_TX_RX_MASK, &pCoexSta->bBtTxRxMask);
+		p_coex_sta->bBtTxRxMask = (p_coex_sta->btInfoC2h[rspSource][2] & 0x40);
+		p_bt_coexist->fBtcSet(p_bt_coexist, BTC_SET_BL_BT_TX_RX_MASK, &p_coex_sta->bBtTxRxMask);
 
-		if (!pCoexSta->bBtTxRxMask) {
+		if (!p_coex_sta->bBtTxRxMask) {
 			/* BT into is responded by BT FW and BT RF REG 0x3C != 0x15 => Need to switch BT TRx Mask */
 			BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], Switch BT TRx Mask since BT RF REG 0x3C != 0x15\n"));
-			pBtCoexist->fBtcSetBtReg(pBtCoexist, BTC_BT_REG_RF, 0x3c, 0x15);
+			p_bt_coexist->fBtcSetBtReg(p_bt_coexist, BTC_BT_REG_RF, 0x3c, 0x15);
 		}
 
 		/*  Here we need to resend some wifi info to BT */
 		/*  because bt is reset and loss of the info. */
-		if (pCoexSta->btInfoExt & BIT1) {
+		if (p_coex_sta->btInfoExt & BIT1) {
 			BTC_PRINT(
 				BTC_MSG_ALGORITHM,
 				ALGO_TRACE,
 				("[BTCoex], BT ext info bit1 check, send wifi BW&Chnl to BT!!\n")
 			);
-			pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_CONNECTED, &bWifiConnected);
+			p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_BL_WIFI_CONNECTED, &bWifiConnected);
 			if (bWifiConnected)
-				EXhalbtc8723b1ant_MediaStatusNotify(pBtCoexist, BTC_MEDIA_CONNECT);
+				EXhalbtc8723b1ant_MediaStatusNotify(p_bt_coexist, BTC_MEDIA_CONNECT);
 			else
-				EXhalbtc8723b1ant_MediaStatusNotify(pBtCoexist, BTC_MEDIA_DISCONNECT);
+				EXhalbtc8723b1ant_MediaStatusNotify(p_bt_coexist, BTC_MEDIA_DISCONNECT);
 		}
 
-		if (pCoexSta->btInfoExt & BIT3) {
-			if (!pBtCoexist->bManualControl && !pBtCoexist->bStopCoexDm) {
+		if (p_coex_sta->btInfoExt & BIT3) {
+			if (!p_bt_coexist->bManualControl && !p_bt_coexist->bStopCoexDm) {
 				BTC_PRINT(
 					BTC_MSG_ALGORITHM,
 					ALGO_TRACE,
 					("[BTCoex], BT ext info bit3 check, set BT NOT to ignore Wlan active!!\n")
 				);
-				halbtc8723b1ant_IgnoreWlanAct(pBtCoexist, FORCE_EXEC, false);
+				halbtc8723b1ant_IgnoreWlanAct(p_bt_coexist, FORCE_EXEC, false);
 			}
 		} else {
 			/*  BT already NOT ignore Wlan active, do nothing here. */
@@ -3621,143 +3619,143 @@ void EXhalbtc8723b1ant_BtInfoNotify(
 
 	/*  check BIT2 first ==> check if bt is under inquiry or page scan */
 	if (btInfo & BT_INFO_8723B_1ANT_B_INQ_PAGE)
-		pCoexSta->bC2hBtInquiryPage = true;
+		p_coex_sta->bC2hBtInquiryPage = true;
 	else
-		pCoexSta->bC2hBtInquiryPage = false;
+		p_coex_sta->bC2hBtInquiryPage = false;
 
 	/*  set link exist status */
 	if (!(btInfo & BT_INFO_8723B_1ANT_B_CONNECTION)) {
-		pCoexSta->bBtLinkExist = false;
-		pCoexSta->bPanExist = false;
-		pCoexSta->bA2dpExist = false;
-		pCoexSta->bHidExist = false;
-		pCoexSta->bScoExist = false;
+		p_coex_sta->bBtLinkExist = false;
+		p_coex_sta->bPanExist = false;
+		p_coex_sta->bA2dpExist = false;
+		p_coex_sta->bHidExist = false;
+		p_coex_sta->bScoExist = false;
 	} else {	/*  connection exists */
-		pCoexSta->bBtLinkExist = true;
+		p_coex_sta->bBtLinkExist = true;
 		if (btInfo & BT_INFO_8723B_1ANT_B_FTP)
-			pCoexSta->bPanExist = true;
+			p_coex_sta->bPanExist = true;
 		else
-			pCoexSta->bPanExist = false;
+			p_coex_sta->bPanExist = false;
 
 		if (btInfo & BT_INFO_8723B_1ANT_B_A2DP)
-			pCoexSta->bA2dpExist = true;
+			p_coex_sta->bA2dpExist = true;
 		else
-			pCoexSta->bA2dpExist = false;
+			p_coex_sta->bA2dpExist = false;
 
 		if (btInfo & BT_INFO_8723B_1ANT_B_HID)
-			pCoexSta->bHidExist = true;
+			p_coex_sta->bHidExist = true;
 		else
-			pCoexSta->bHidExist = false;
+			p_coex_sta->bHidExist = false;
 
 		if (btInfo & BT_INFO_8723B_1ANT_B_SCO_ESCO)
-			pCoexSta->bScoExist = true;
+			p_coex_sta->bScoExist = true;
 		else
-			pCoexSta->bScoExist = false;
+			p_coex_sta->bScoExist = false;
 	}
 
-	halbtc8723b1ant_UpdateBtLinkInfo(pBtCoexist);
+	halbtc8723b1ant_UpdateBtLinkInfo(p_bt_coexist);
 
 	btInfo = btInfo & 0x1f;  /* mask profile bit for connect-ilde identification (for CSR case: A2DP idle --> 0x41) */
 
 	if (!(btInfo & BT_INFO_8723B_1ANT_B_CONNECTION)) {
-		pCoexDm->btStatus = BT_8723B_1ANT_BT_STATUS_NON_CONNECTED_IDLE;
+		p_coex_dm->btStatus = BT_8723B_1ANT_BT_STATUS_NON_CONNECTED_IDLE;
 		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], BtInfoNotify(), BT Non-Connected idle!!!\n"));
 	} else if (btInfo == BT_INFO_8723B_1ANT_B_CONNECTION)	{
 		/*  connection exists but no busy */
-		pCoexDm->btStatus = BT_8723B_1ANT_BT_STATUS_CONNECTED_IDLE;
+		p_coex_dm->btStatus = BT_8723B_1ANT_BT_STATUS_CONNECTED_IDLE;
 		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], BtInfoNotify(), BT Connected-idle!!!\n"));
 	} else if (
 		(btInfo & BT_INFO_8723B_1ANT_B_SCO_ESCO) ||
 		(btInfo & BT_INFO_8723B_1ANT_B_SCO_BUSY)
 	) {
-		pCoexDm->btStatus = BT_8723B_1ANT_BT_STATUS_SCO_BUSY;
+		p_coex_dm->btStatus = BT_8723B_1ANT_BT_STATUS_SCO_BUSY;
 		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], BtInfoNotify(), BT SCO busy!!!\n"));
 	} else if (btInfo & BT_INFO_8723B_1ANT_B_ACL_BUSY) {
-		if (BT_8723B_1ANT_BT_STATUS_ACL_BUSY != pCoexDm->btStatus)
-			pCoexDm->bAutoTdmaAdjust = false;
+		if (BT_8723B_1ANT_BT_STATUS_ACL_BUSY != p_coex_dm->btStatus)
+			p_coex_dm->bAutoTdmaAdjust = false;
 
-		pCoexDm->btStatus = BT_8723B_1ANT_BT_STATUS_ACL_BUSY;
+		p_coex_dm->btStatus = BT_8723B_1ANT_BT_STATUS_ACL_BUSY;
 		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], BtInfoNotify(), BT ACL busy!!!\n"));
 	} else {
-		pCoexDm->btStatus = BT_8723B_1ANT_BT_STATUS_MAX;
+		p_coex_dm->btStatus = BT_8723B_1ANT_BT_STATUS_MAX;
 		BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], BtInfoNotify(), BT Non-Defined state!!!\n"));
 	}
 
 	if (
-		(BT_8723B_1ANT_BT_STATUS_ACL_BUSY == pCoexDm->btStatus) ||
-		(BT_8723B_1ANT_BT_STATUS_SCO_BUSY == pCoexDm->btStatus) ||
-		(BT_8723B_1ANT_BT_STATUS_ACL_SCO_BUSY == pCoexDm->btStatus)
+		(BT_8723B_1ANT_BT_STATUS_ACL_BUSY == p_coex_dm->btStatus) ||
+		(BT_8723B_1ANT_BT_STATUS_SCO_BUSY == p_coex_dm->btStatus) ||
+		(BT_8723B_1ANT_BT_STATUS_ACL_SCO_BUSY == p_coex_dm->btStatus)
 	)
 		bBtBusy = true;
 	else
 		bBtBusy = false;
-	pBtCoexist->fBtcSet(pBtCoexist, BTC_SET_BL_BT_TRAFFIC_BUSY, &bBtBusy);
+	p_bt_coexist->fBtcSet(p_bt_coexist, BTC_SET_BL_BT_TRAFFIC_BUSY, &bBtBusy);
 
-	halbtc8723b1ant_RunCoexistMechanism(pBtCoexist);
+	halbtc8723b1ant_RunCoexistMechanism(p_bt_coexist);
 }
 
-void EXhalbtc8723b1ant_HaltNotify(struct btc_coexist *pBtCoexist)
+void EXhalbtc8723b1ant_HaltNotify(struct btc_coexist *p_bt_coexist)
 {
 	BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], Halt notify\n"));
 
-	halbtc8723b1ant_PowerSaveState(pBtCoexist, BTC_PS_WIFI_NATIVE, 0x0, 0x0);
-	halbtc8723b1ant_PsTdma(pBtCoexist, FORCE_EXEC, false, 0);
-	halbtc8723b1ant_SetAntPath(pBtCoexist, BTC_ANT_PATH_BT, false, true);
+	halbtc8723b1ant_PowerSaveState(p_bt_coexist, BTC_PS_WIFI_NATIVE, 0x0, 0x0);
+	halbtc8723b1ant_PsTdma(p_bt_coexist, FORCE_EXEC, false, 0);
+	halbtc8723b1ant_SetAntPath(p_bt_coexist, BTC_ANT_PATH_BT, false, true);
 
-	halbtc8723b1ant_IgnoreWlanAct(pBtCoexist, FORCE_EXEC, true);
+	halbtc8723b1ant_IgnoreWlanAct(p_bt_coexist, FORCE_EXEC, true);
 
-	EXhalbtc8723b1ant_MediaStatusNotify(pBtCoexist, BTC_MEDIA_DISCONNECT);
+	EXhalbtc8723b1ant_MediaStatusNotify(p_bt_coexist, BTC_MEDIA_DISCONNECT);
 
-	pBtCoexist->bStopCoexDm = true;
+	p_bt_coexist->bStopCoexDm = true;
 }
 
-void EXhalbtc8723b1ant_PnpNotify(struct btc_coexist *pBtCoexist, u8 pnpState)
+void EXhalbtc8723b1ant_PnpNotify(struct btc_coexist *p_bt_coexist, u8 pnpState)
 {
 	BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], Pnp notify\n"));
 
 	if (BTC_WIFI_PNP_SLEEP == pnpState) {
 		BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], Pnp notify to SLEEP\n"));
 
-		halbtc8723b1ant_PowerSaveState(pBtCoexist, BTC_PS_WIFI_NATIVE, 0x0, 0x0);
-		halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, false, 0);
-		halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 2);
-		halbtc8723b1ant_SetAntPath(pBtCoexist, BTC_ANT_PATH_BT, false, true);
+		halbtc8723b1ant_PowerSaveState(p_bt_coexist, BTC_PS_WIFI_NATIVE, 0x0, 0x0);
+		halbtc8723b1ant_PsTdma(p_bt_coexist, NORMAL_EXEC, false, 0);
+		halbtc8723b1ant_CoexTableWithType(p_bt_coexist, NORMAL_EXEC, 2);
+		halbtc8723b1ant_SetAntPath(p_bt_coexist, BTC_ANT_PATH_BT, false, true);
 
-		pBtCoexist->bStopCoexDm = true;
+		p_bt_coexist->bStopCoexDm = true;
 	} else if (BTC_WIFI_PNP_WAKE_UP == pnpState) {
 		BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], Pnp notify to WAKE UP\n"));
-		pBtCoexist->bStopCoexDm = false;
-		halbtc8723b1ant_InitHwConfig(pBtCoexist, false, false);
-		halbtc8723b1ant_InitCoexDm(pBtCoexist);
-		halbtc8723b1ant_QueryBtInfo(pBtCoexist);
+		p_bt_coexist->bStopCoexDm = false;
+		halbtc8723b1ant_InitHwConfig(p_bt_coexist, false, false);
+		halbtc8723b1ant_InitCoexDm(p_bt_coexist);
+		halbtc8723b1ant_QueryBtInfo(p_bt_coexist);
 	}
 }
 
-void EXhalbtc8723b1ant_Periodical(struct btc_coexist *pBtCoexist)
+void EXhalbtc8723b1ant_Periodical(struct btc_coexist *p_bt_coexist)
 {
-	static u8 disVerInfoCnt;
-	u32 fwVer = 0, btPatchVer = 0;
+	static u8 dis_ver_info_cnt;
+	u32 fw_ver = 0, bt_patch_ver = 0;
 
 	BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE, ("[BTCoex], ==========================Periodical ===========================\n"));
 
-	if (disVerInfoCnt <= 5) {
-		disVerInfoCnt += 1;
+	if (dis_ver_info_cnt <= 5) {
+		dis_ver_info_cnt += 1;
 		BTC_PRINT(BTC_MSG_INTERFACE, INTF_INIT, ("[BTCoex], ****************************************************************\n"));
-		pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_U4_BT_PATCH_VER, &btPatchVer);
-		pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_U4_WIFI_FW_VER, &fwVer);
+		p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_U4_BT_PATCH_VER, &bt_patch_ver);
+		p_bt_coexist->fBtcGet(p_bt_coexist, BTC_GET_U4_WIFI_FW_VER, &fw_ver);
 		BTC_PRINT(BTC_MSG_INTERFACE, INTF_INIT, ("[BTCoex], CoexVer/ FwVer/ PatchVer = %d_%x/ 0x%x/ 0x%x(%d)\n", \
-			GLCoexVerDate8723b1Ant, GLCoexVer8723b1Ant, fwVer, btPatchVer, btPatchVer));
+			gl_coex_ver_date_8723b_1ant, gl_coex_ver_8723b_1ant, fw_ver, bt_patch_ver, bt_patch_ver));
 		BTC_PRINT(BTC_MSG_INTERFACE, INTF_INIT, ("[BTCoex], ****************************************************************\n"));
 	}
 
-	halbtc8723b1ant_MonitorBtCtr(pBtCoexist);
-	halbtc8723b1ant_MonitorWiFiCtr(pBtCoexist);
+	halbtc8723b1ant_MonitorBtCtr(p_bt_coexist);
+	halbtc8723b1ant_MonitorWiFiCtr(p_bt_coexist);
 
 	if (
-		halbtc8723b1ant_IsWifiStatusChanged(pBtCoexist) ||
-		pCoexDm->bAutoTdmaAdjust
+		halbtc8723b1ant_IsWifiStatusChanged(p_bt_coexist) ||
+		p_coex_dm->bAutoTdmaAdjust
 	)
-		halbtc8723b1ant_RunCoexistMechanism(pBtCoexist);
+		halbtc8723b1ant_RunCoexistMechanism(p_bt_coexist);
 
-	pCoexSta->specialPktPeriodCnt++;
+	p_coex_sta->specialPktPeriodCnt++;
 }
-- 
2.31.1

