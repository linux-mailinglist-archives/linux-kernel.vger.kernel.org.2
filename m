Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10CF3D9043
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 16:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbhG1OTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 10:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236672AbhG1OTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 10:19:05 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB024C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 07:19:02 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id b7so2766108wri.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 07:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ecZZ+qMzc1G1t7/pWJmJsiL+N046r5VJUSZZDSoP52w=;
        b=aEDrNVLJDDA9bzcJhnauqqOca9yxChKTfZrAzkfhIbnikhoktsDYGJfS93LvGYSIiY
         nJgwKRjHjB/Kr3aK4Kj0SFijZgcdKYdkaFchDMe6a117COHrHWqngcUuHMTLaeLTP3Wq
         wm6ylB1hFpllYz7yVCNuxFPUf1gKOe+627Sr6XjpGAHwEn8tIjqfJN9bnKOk6w7zMZdE
         KYmjwKMZMH0WxqmCcnt1+swbGSGZXpIfFHkMlEvTANj9/GZlcesgcS5Fj63YAb41ypOc
         +cx6d0XwW3dCuiG4dOydYhuCItSHnWsgwZoPXhU1QUQMB9OyMZ/qCWOuohI0zmuhRbxo
         A5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ecZZ+qMzc1G1t7/pWJmJsiL+N046r5VJUSZZDSoP52w=;
        b=im5FxUiSvucs2261KXTPZGsjATaJI1DbB9jqlMXBmxHACnGLACeuOV4SMJf4QSECod
         C/6o8/lud7ggwS5pPMXodv2AI8y4D1RTEtsovfKWq4knyoa1PLuDeLeIOzDs+EUV4O15
         aa5OCAKWT58uPZZbbBWmOI/yiuifejHt2hhiem8QOC+csPCLPr54RuKzbSZC4XvjEEeI
         tLjMvc+CdF4C2EeHDOEjp7qhnhhSYwizeSRhwvS+4to2zoVOGtSCUO/2p9NlMZ1vawNs
         MShEaVt+7J/mbmAT0OoQZP0MvfFmm/Oy+pJSS1W77jUKMiRygzF9Igoj3DPRtpyczK6h
         SIEw==
X-Gm-Message-State: AOAM530jwrbMjAOlFf2upY0+Wm7lcY+4lvdXpbDN0P75fLpzqsTX8XnT
        xeyzNftAB6HKiR0OOy6MyKSkw+iaPCA=
X-Google-Smtp-Source: ABdhPJyo98EUI0FO8k6Et//LsESmnEyz6sshHFDbyUk8E6+gcxfPQiBb4aN/1jv2n/RnBgUswmt4Ag==
X-Received: by 2002:adf:e601:: with SMTP id p1mr2681409wrm.14.1627481940658;
        Wed, 28 Jul 2021 07:19:00 -0700 (PDT)
Received: from agape ([5.171.112.45])
        by smtp.gmail.com with ESMTPSA id d14sm6404421wrs.49.2021.07.28.07.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 07:19:00 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: remove BT debug code
Date:   Wed, 28 Jul 2021 16:18:58 +0200
Message-Id: <20210728141858.13024-1-fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove BT dead debug code, probably it was intended
for a specific command line interface.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 .../staging/rtl8723bs/hal/HalBtc8723b1Ant.c   | 458 ------------------
 .../staging/rtl8723bs/hal/HalBtc8723b1Ant.h   |   1 -
 .../staging/rtl8723bs/hal/HalBtc8723b2Ant.c   | 408 ----------------
 .../staging/rtl8723bs/hal/HalBtc8723b2Ant.h   |   1 -
 drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h  |   8 -
 drivers/staging/rtl8723bs/hal/Mp_Precomp.h    |   2 -
 drivers/staging/rtl8723bs/hal/hal_btcoex.c    | 104 ----
 .../staging/rtl8723bs/include/hal_btcoex.h    |   3 -
 8 files changed, 985 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
index dc58bb87f1b0..242c14959176 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
+++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
@@ -19,9 +19,6 @@ static const char *const GLBtInfoSrc8723b1Ant[] = {
 	"BT Info[bt auto report]",
 };
 
-static u32 GLCoexVerDate8723b1Ant = 20140507;
-static u32 GLCoexVer8723b1Ant = 0x4e;
-
 /*  local function proto type if needed */
 /*  local function start with halbtc8723b1ant_ */
 static u8 halbtc8723b1ant_BtRssiState(
@@ -2210,461 +2207,6 @@ void EXhalbtc8723b1ant_InitCoexDm(struct btc_coexist *pBtCoexist)
 	halbtc8723b1ant_QueryBtInfo(pBtCoexist);
 }
 
-void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
-{
-	struct btc_board_info *pBoardInfo = &pBtCoexist->boardInfo;
-	struct btc_stack_info *pStackInfo = &pBtCoexist->stackInfo;
-	struct btc_bt_link_info *pBtLinkInfo = &pBtCoexist->btLinkInfo;
-	u8 *cliBuf = pBtCoexist->cliBuf;
-	u8 u1Tmp[4], i, btInfoExt, psTdmaCase = 0;
-	u16 u2Tmp[4];
-	u32 u4Tmp[4];
-	bool bRoam = false;
-	bool bScan = false;
-	bool bLink = false;
-	bool bWifiUnderBMode = false;
-	bool bBtHsOn = false;
-	bool bWifiBusy = false;
-	s32 wifiRssi = 0, btHsRssi = 0;
-	u32 wifiBw, wifiTrafficDir, faOfdm, faCck, wifiLinkStatus;
-	u8 wifiDot11Chnl, wifiHsChnl;
-	u32 fwVer = 0, btPatchVer = 0;
-	static u8 PopReportIn10s;
-
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n ============[BT Coexist info]============"
-	);
-	CL_PRINTF(cliBuf);
-
-	if (pBtCoexist->bManualControl) {
-		CL_SPRINTF(
-			cliBuf,
-			BT_TMP_BUF_SIZE,
-			"\r\n ============[Under Manual Control]============"
-		);
-		CL_PRINTF(cliBuf);
-		CL_SPRINTF(cliBuf,
-			BT_TMP_BUF_SIZE,
-			"\r\n =========================================="
-		);
-		CL_PRINTF(cliBuf);
-	}
-	if (pBtCoexist->bStopCoexDm) {
-		CL_SPRINTF(
-			cliBuf,
-			BT_TMP_BUF_SIZE,
-			"\r\n ============[Coex is STOPPED]============"
-		);
-		CL_PRINTF(cliBuf);
-		CL_SPRINTF(
-			cliBuf,
-			BT_TMP_BUF_SIZE,
-			"\r\n =========================================="
-		);
-		CL_PRINTF(cliBuf);
-	}
-
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %d/ %d/ %d", "Ant PG Num/ Ant Mech/ Ant Pos:",
-		pBoardInfo->pgAntNum,
-		pBoardInfo->btdmAntNum,
-		pBoardInfo->btdmAntPos
-	);
-	CL_PRINTF(cliBuf);
-
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %s / %d", "BT stack/ hci ext ver",
-		((pStackInfo->bProfileNotified) ? "Yes" : "No"),
-		pStackInfo->hciVersion
-	);
-	CL_PRINTF(cliBuf);
-
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_U4_BT_PATCH_VER, &btPatchVer);
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_U4_WIFI_FW_VER, &fwVer);
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %d_%x/ 0x%x/ 0x%x(%d)", "CoexVer/ FwVer/ PatchVer",
-		GLCoexVerDate8723b1Ant,
-		GLCoexVer8723b1Ant,
-		fwVer,
-		btPatchVer,
-		btPatchVer
-	);
-	CL_PRINTF(cliBuf);
-
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_HS_OPERATION, &bBtHsOn);
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_U1_WIFI_DOT11_CHNL, &wifiDot11Chnl);
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_U1_WIFI_HS_CHNL, &wifiHsChnl);
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %d / %d(%d)", "Dot11 channel / HsChnl(HsMode)",
-		wifiDot11Chnl,
-		wifiHsChnl,
-		bBtHsOn
-	);
-	CL_PRINTF(cliBuf);
-
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %02x %02x %02x ", "H2C Wifi inform bt chnl Info",
-		pCoexDm->wifiChnlInfo[0],
-		pCoexDm->wifiChnlInfo[1],
-		pCoexDm->wifiChnlInfo[2]
-	);
-	CL_PRINTF(cliBuf);
-
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_S4_WIFI_RSSI, &wifiRssi);
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_S4_HS_RSSI, &btHsRssi);
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %d/ %d", "Wifi rssi/ HS rssi",
-		wifiRssi - 100, btHsRssi - 100
-	);
-	CL_PRINTF(cliBuf);
-
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_SCAN, &bScan);
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_LINK, &bLink);
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_ROAM, &bRoam);
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %d/ %d/ %d/ %s", "Wifi bLink/ bRoam/ bScan/ bHi-Pri",
-		bLink, bRoam, bScan, ((pCoexSta->bWiFiIsHighPriTask) ? "1" : "0")
-	);
-	CL_PRINTF(cliBuf);
-
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_U4_WIFI_BW, &wifiBw);
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_BUSY, &bWifiBusy);
-	pBtCoexist->fBtcGet(
-		pBtCoexist, BTC_GET_U4_WIFI_TRAFFIC_DIRECTION, &wifiTrafficDir
-	);
-	pBtCoexist->fBtcGet(
-		pBtCoexist, BTC_GET_BL_WIFI_UNDER_B_MODE, &bWifiUnderBMode
-	);
-
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %s / %s/ %s/ AP =%d/ %s ", "Wifi status",
-		("2.4G"),
-		((bWifiUnderBMode) ? "11b" : ((wifiBw == BTC_WIFI_BW_LEGACY) ? "11bg" : (((wifiBw == BTC_WIFI_BW_HT40) ? "HT40" : "HT20")))),
-		((!bWifiBusy) ? "idle" : ((wifiTrafficDir == BTC_WIFI_TRAFFIC_TX) ? "uplink" : "downlink")),
-		pCoexSta->nScanAPNum,
-		(pCoexSta->bCCKLock) ? "Lock" : "noLock"
-	);
-	CL_PRINTF(cliBuf);
-
-	pBtCoexist->fBtcGet(
-		pBtCoexist, BTC_GET_U4_WIFI_LINK_STATUS, &wifiLinkStatus
-	);
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %d/ %d/ %d/ %d/ %d", "sta/vwifi/hs/p2pGo/p2pGc",
-		((wifiLinkStatus & WIFI_STA_CONNECTED) ? 1 : 0),
-		((wifiLinkStatus & WIFI_AP_CONNECTED) ? 1 : 0),
-		((wifiLinkStatus & WIFI_HS_CONNECTED) ? 1 : 0),
-		((wifiLinkStatus & WIFI_P2P_GO_CONNECTED) ? 1 : 0),
-		((wifiLinkStatus & WIFI_P2P_GC_CONNECTED) ? 1 : 0)
-	);
-	CL_PRINTF(cliBuf);
-
-
-	PopReportIn10s++;
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = [%s/ %d/ %d/ %d] ", "BT [status/ rssi/ retryCnt/ popCnt]",
-		((pBtCoexist->btInfo.bBtDisabled) ? ("disabled") : ((pCoexSta->bC2hBtInquiryPage) ? ("inquiry/page scan") : ((pCoexDm->btStatus == BT_8723B_1ANT_BT_STATUS_NON_CONNECTED_IDLE) ? "non-connected idle" :
-																					((pCoexDm->btStatus == BT_8723B_1ANT_BT_STATUS_CONNECTED_IDLE) ? "connected-idle" : "busy")))),
-		pCoexSta->btRssi, pCoexSta->btRetryCnt, pCoexSta->popEventCnt
-	);
-	CL_PRINTF(cliBuf);
-
-	if (PopReportIn10s >= 5) {
-		pCoexSta->popEventCnt = 0;
-		PopReportIn10s = 0;
-	}
-
-
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %d / %d / %d / %d", "SCO/HID/PAN/A2DP",
-		pBtLinkInfo->bScoExist,
-		pBtLinkInfo->bHidExist,
-		pBtLinkInfo->bPanExist,
-		pBtLinkInfo->bA2dpExist
-	);
-	CL_PRINTF(cliBuf);
-
-	if (pStackInfo->bProfileNotified) {
-		pBtCoexist->fBtcDispDbgMsg(pBtCoexist, BTC_DBG_DISP_BT_LINK_INFO);
-	} else {
-		CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = %s", "BT Role",
-			   (pBtLinkInfo->bSlaveRole) ? "Slave" : "Master");
-		CL_PRINTF(cliBuf);
-	}
-
-
-	btInfoExt = pCoexSta->btInfoExt;
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %s", "BT Info A2DP rate",
-		(btInfoExt & BIT0) ? "Basic rate" : "EDR rate"
-	);
-	CL_PRINTF(cliBuf);
-
-	for (i = 0; i < BT_INFO_SRC_8723B_1ANT_MAX; i++) {
-		if (pCoexSta->btInfoC2hCnt[i]) {
-			CL_SPRINTF(
-				cliBuf,
-				BT_TMP_BUF_SIZE,
-				"\r\n %-35s = %02x %02x %02x %02x %02x %02x %02x(%d)", GLBtInfoSrc8723b1Ant[i],
-				pCoexSta->btInfoC2h[i][0], pCoexSta->btInfoC2h[i][1],
-				pCoexSta->btInfoC2h[i][2], pCoexSta->btInfoC2h[i][3],
-				pCoexSta->btInfoC2h[i][4], pCoexSta->btInfoC2h[i][5],
-				pCoexSta->btInfoC2h[i][6], pCoexSta->btInfoC2hCnt[i]
-			);
-			CL_PRINTF(cliBuf);
-		}
-	}
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %s/%s, (0x%x/0x%x)", "PS state, IPS/LPS, (lps/rpwm)",
-		(pCoexSta->bUnderIps ? "IPS ON" : "IPS OFF"),
-		(pCoexSta->bUnderLps ? "LPS ON" : "LPS OFF"),
-		pBtCoexist->btInfo.lpsVal,
-		pBtCoexist->btInfo.rpwmVal
-	);
-	CL_PRINTF(cliBuf);
-	pBtCoexist->fBtcDispDbgMsg(pBtCoexist, BTC_DBG_DISP_FW_PWR_MODE_CMD);
-
-	if (!pBtCoexist->bManualControl) {
-		/*  Sw mechanism */
-		CL_SPRINTF(
-			cliBuf,
-			BT_TMP_BUF_SIZE,
-			"\r\n %-35s", "============[Sw mechanism]============"
-		);
-		CL_PRINTF(cliBuf);
-
-		CL_SPRINTF(
-			cliBuf,
-			BT_TMP_BUF_SIZE,
-			"\r\n %-35s = %d", "SM[LowPenaltyRA]",
-			pCoexDm->bCurLowPenaltyRa
-		);
-		CL_PRINTF(cliBuf);
-
-		CL_SPRINTF(
-			cliBuf,
-			BT_TMP_BUF_SIZE,
-			"\r\n %-35s = %s/ %s/ %d ", "DelBA/ BtCtrlAgg/ AggSize",
-			(pBtCoexist->btInfo.bRejectAggPkt ? "Yes" : "No"),
-			(pBtCoexist->btInfo.bBtCtrlAggBufSize ? "Yes" : "No"),
-			pBtCoexist->btInfo.aggBufSize
-		);
-		CL_PRINTF(cliBuf);
-		CL_SPRINTF(
-			cliBuf,
-			BT_TMP_BUF_SIZE,
-			"\r\n %-35s = 0x%x ", "Rate Mask",
-			pBtCoexist->btInfo.raMask
-		);
-		CL_PRINTF(cliBuf);
-
-		/*  Fw mechanism */
-		CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s", "============[Fw mechanism]============");
-		CL_PRINTF(cliBuf);
-
-		psTdmaCase = pCoexDm->curPsTdma;
-		CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = %02x %02x %02x %02x %02x case-%d (auto:%d)", "PS TDMA",
-			   pCoexDm->psTdmaPara[0], pCoexDm->psTdmaPara[1],
-			   pCoexDm->psTdmaPara[2], pCoexDm->psTdmaPara[3],
-			   pCoexDm->psTdmaPara[4], psTdmaCase, pCoexDm->bAutoTdmaAdjust);
-		CL_PRINTF(cliBuf);
-
-		CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = %d", "Coex Table Type",
-			   pCoexSta->nCoexTableType);
-		CL_PRINTF(cliBuf);
-
-		CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = %d", "IgnWlanAct",
-			   pCoexDm->bCurIgnoreWlanAct);
-		CL_PRINTF(cliBuf);
-	}
-
-	/*  Hw setting */
-	CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s", "============[Hw setting]============");
-	CL_PRINTF(cliBuf);
-
-	CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = 0x%x/0x%x/0x%x/0x%x", "backup ARFR1/ARFR2/RL/AMaxTime",
-		   pCoexDm->backupArfrCnt1, pCoexDm->backupArfrCnt2, pCoexDm->backupRetryLimit, pCoexDm->backupAmpduMaxTime);
-	CL_PRINTF(cliBuf);
-
-	u4Tmp[0] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x430);
-	u4Tmp[1] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x434);
-	u2Tmp[0] = pBtCoexist->fBtcRead2Byte(pBtCoexist, 0x42a);
-	u1Tmp[0] = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x456);
-	CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = 0x%x/0x%x/0x%x/0x%x", "0x430/0x434/0x42a/0x456",
-		   u4Tmp[0], u4Tmp[1], u2Tmp[0], u1Tmp[0]);
-	CL_PRINTF(cliBuf);
-
-	u1Tmp[0] = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x778);
-	u4Tmp[0] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x6cc);
-	u4Tmp[1] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x880);
-	CL_SPRINTF(
-		cliBuf, BT_TMP_BUF_SIZE,
-		"\r\n %-35s = 0x%x/ 0x%x/ 0x%x", "0x778/0x6cc/0x880[29:25]",
-		u1Tmp[0], u4Tmp[0],  (u4Tmp[1] & 0x3e000000) >> 25
-	);
-	CL_PRINTF(cliBuf);
-
-	u4Tmp[0] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x948);
-	u1Tmp[0] = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x67);
-	u4Tmp[1] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x764);
-	u1Tmp[1] = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x76e);
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = 0x%x/ 0x%x/ 0x%x/ 0x%x", "0x948/ 0x67[5] / 0x764 / 0x76e",
-		u4Tmp[0], ((u1Tmp[0] & 0x20) >> 5), (u4Tmp[1] & 0xffff), u1Tmp[1]
-	);
-	CL_PRINTF(cliBuf);
-
-	u4Tmp[0] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x92c);
-	u4Tmp[1] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x930);
-	u4Tmp[2] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x944);
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = 0x%x/ 0x%x/ 0x%x", "0x92c[1:0]/ 0x930[7:0]/0x944[1:0]",
-		u4Tmp[0] & 0x3, u4Tmp[1] & 0xff, u4Tmp[2] & 0x3
-	);
-	CL_PRINTF(cliBuf);
-
-	u1Tmp[0] = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x39);
-	u1Tmp[1] = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x40);
-	u4Tmp[0] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x4c);
-	u1Tmp[2] = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x64);
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = 0x%x/ 0x%x/ 0x%x/ 0x%x", "0x38[11]/0x40/0x4c[24:23]/0x64[0]",
-		((u1Tmp[0] & 0x8) >> 3),
-		u1Tmp[1],
-		((u4Tmp[0] & 0x01800000) >> 23),
-		u1Tmp[2] & 0x1
-	);
-	CL_PRINTF(cliBuf);
-
-	u4Tmp[0] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x550);
-	u1Tmp[0] = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x522);
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = 0x%x/ 0x%x", "0x550(bcn ctrl)/0x522",
-		u4Tmp[0], u1Tmp[0]
-	);
-	CL_PRINTF(cliBuf);
-
-	u4Tmp[0] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0xc50);
-	u1Tmp[0] = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x49c);
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = 0x%x/ 0x%x", "0xc50(dig)/0x49c(null-drop)",
-		u4Tmp[0] & 0xff, u1Tmp[0]
-	);
-	CL_PRINTF(cliBuf);
-
-	u4Tmp[0] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0xda0);
-	u4Tmp[1] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0xda4);
-	u4Tmp[2] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0xda8);
-	u4Tmp[3] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0xcf0);
-
-	u1Tmp[0] = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0xa5b);
-	u1Tmp[1] = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0xa5c);
-
-	faOfdm =
-		((u4Tmp[0] & 0xffff0000) >> 16) +
-		((u4Tmp[1] & 0xffff0000) >> 16) +
-		(u4Tmp[1] & 0xffff) +  (u4Tmp[2] & 0xffff) +
-		((u4Tmp[3] & 0xffff0000) >> 16) + (u4Tmp[3] & 0xffff);
-	faCck = (u1Tmp[0] << 8) + u1Tmp[1];
-
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = 0x%x/ 0x%x/ 0x%x", "OFDM-CCA/OFDM-FA/CCK-FA",
-		u4Tmp[0] & 0xffff, faOfdm, faCck
-	);
-	CL_PRINTF(cliBuf);
-
-
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %d/ %d/ %d/ %d", "CRC_OK CCK/11g/11n/11n-Agg",
-		pCoexSta->nCRCOK_CCK,
-		pCoexSta->nCRCOK_11g,
-		pCoexSta->nCRCOK_11n,
-		pCoexSta->nCRCOK_11nAgg
-	);
-	CL_PRINTF(cliBuf);
-
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %d/ %d/ %d/ %d", "CRC_Err CCK/11g/11n/11n-Agg",
-		pCoexSta->nCRCErr_CCK,
-		pCoexSta->nCRCErr_11g,
-		pCoexSta->nCRCErr_11n,
-		pCoexSta->nCRCErr_11nAgg
-	);
-	CL_PRINTF(cliBuf);
-
-	u4Tmp[0] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x6c0);
-	u4Tmp[1] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x6c4);
-	u4Tmp[2] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x6c8);
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = 0x%x/ 0x%x/ 0x%x", "0x6c0/0x6c4/0x6c8(coexTable)",
-		u4Tmp[0], u4Tmp[1], u4Tmp[2]);
-	CL_PRINTF(cliBuf);
-
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %d/ %d", "0x770(high-pri rx/tx)",
-		pCoexSta->highPriorityRx, pCoexSta->highPriorityTx
-	);
-	CL_PRINTF(cliBuf);
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %d/ %d", "0x774(low-pri rx/tx)",
-		pCoexSta->lowPriorityRx, pCoexSta->lowPriorityTx
-	);
-	CL_PRINTF(cliBuf);
-
-	pBtCoexist->fBtcDispDbgMsg(pBtCoexist, BTC_DBG_DISP_COEX_STATISTICS);
-}
-
-
 void EXhalbtc8723b1ant_IpsNotify(struct btc_coexist *pBtCoexist, u8 type)
 {
 	if (pBtCoexist->bManualControl ||	pBtCoexist->bStopCoexDm)
diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.h b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.h
index 719e19420a3b..de471e27a185 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.h
+++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.h
@@ -182,4 +182,3 @@ void EXhalbtc8723b1ant_BtInfoNotify(
 void EXhalbtc8723b1ant_HaltNotify(struct btc_coexist *pBtCoexist);
 void EXhalbtc8723b1ant_PnpNotify(struct btc_coexist *pBtCoexist, u8 pnpState);
 void EXhalbtc8723b1ant_Periodical(struct btc_coexist *pBtCoexist);
-void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist);
diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c b/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c
index 84241619fb3a..3e36a7dc72a6 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c
+++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c
@@ -26,9 +26,6 @@ static const char *const GLBtInfoSrc8723b2Ant[] = {
 	"BT Info[bt auto report]",
 };
 
-static u32 GLCoexVerDate8723b2Ant = 20131211;
-static u32 GLCoexVer8723b2Ant = 0x40;
-
 /*  local function start with halbtc8723b2ant_ */
 static u8 halbtc8723b2ant_BtRssiState(
 	u8 levelNum, u8 rssiThresh, u8 rssiThresh1
@@ -188,31 +185,6 @@ static void halbtc8723b2ant_LimitedRx(
 	pBtCoexist->fBtcSet(pBtCoexist, BTC_SET_ACT_AGGREGATE_CTRL, NULL);
 }
 
-static void halbtc8723b2ant_MonitorBtCtr(struct btc_coexist *pBtCoexist)
-{
-	u32 regHPTxRx, regLPTxRx, u4Tmp;
-	u32 regHPTx = 0, regHPRx = 0, regLPTx = 0, regLPRx = 0;
-
-	regHPTxRx = 0x770;
-	regLPTxRx = 0x774;
-
-	u4Tmp = pBtCoexist->fBtcRead4Byte(pBtCoexist, regHPTxRx);
-	regHPTx = u4Tmp & bMaskLWord;
-	regHPRx = (u4Tmp & bMaskHWord) >> 16;
-
-	u4Tmp = pBtCoexist->fBtcRead4Byte(pBtCoexist, regLPTxRx);
-	regLPTx = u4Tmp & bMaskLWord;
-	regLPRx = (u4Tmp & bMaskHWord) >> 16;
-
-	pCoexSta->highPriorityTx = regHPTx;
-	pCoexSta->highPriorityRx = regHPRx;
-	pCoexSta->lowPriorityTx = regLPTx;
-	pCoexSta->lowPriorityRx = regLPRx;
-
-	/*  reset counter */
-	pBtCoexist->fBtcWrite1Byte(pBtCoexist, 0x76e, 0xc);
-}
-
 static void halbtc8723b2ant_QueryBtInfo(struct btc_coexist *pBtCoexist)
 {
 	u8 	H2C_Parameter[1] = {0};
@@ -2423,386 +2395,6 @@ void EXhalbtc8723b2ant_InitCoexDm(struct btc_coexist *pBtCoexist)
 	halbtc8723b2ant_InitCoexDm(pBtCoexist);
 }
 
-void EXhalbtc8723b2ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
-{
-	struct btc_board_info *pBoardInfo = &pBtCoexist->boardInfo;
-	struct btc_stack_info *pStackInfo = &pBtCoexist->stackInfo;
-	struct btc_bt_link_info *pBtLinkInfo = &pBtCoexist->btLinkInfo;
-	u8 *cliBuf = pBtCoexist->cliBuf;
-	u8 u1Tmp[4], i, btInfoExt, psTdmaCase = 0;
-	u32 u4Tmp[4];
-	bool bRoam = false, bScan = false, bLink = false;
-	bool bBtHsOn = false, bWifiBusy = false;
-	s32 wifiRssi = 0, btHsRssi = 0;
-	u32 wifiBw, wifiTrafficDir, faOfdm, faCck;
-	u8 wifiDot11Chnl, wifiHsChnl;
-	u32 fwVer = 0, btPatchVer = 0;
-	u8 apNum = 0;
-
-	CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n ============[BT Coexist info]============");
-	CL_PRINTF(cliBuf);
-
-	if (pBtCoexist->bManualControl) {
-		CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n ============[Under Manual Control]============");
-		CL_PRINTF(cliBuf);
-		CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n ==========================================");
-		CL_PRINTF(cliBuf);
-	}
-
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %d/ %d ", "Ant PG number/ Ant mechanism:", \
-		pBoardInfo->pgAntNum,
-		pBoardInfo->btdmAntNum
-	);
-	CL_PRINTF(cliBuf);
-
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %s / %d", "BT stack/ hci ext ver", \
-		(pStackInfo->bProfileNotified ? "Yes" : "No"),
-		pStackInfo->hciVersion
-	);
-	CL_PRINTF(cliBuf);
-
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_U4_BT_PATCH_VER, &btPatchVer);
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_U4_WIFI_FW_VER, &fwVer);
-	CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = %d_%x/ 0x%x/ 0x%x(%d)", "CoexVer/ FwVer/ PatchVer", \
-		GLCoexVerDate8723b2Ant, GLCoexVer8723b2Ant, fwVer, btPatchVer, btPatchVer);
-	CL_PRINTF(cliBuf);
-
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_HS_OPERATION, &bBtHsOn);
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_U1_WIFI_DOT11_CHNL, &wifiDot11Chnl);
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_U1_WIFI_HS_CHNL, &wifiHsChnl);
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %d / %d(%d)", "Dot11 channel / HsChnl(HsMode)", \
-		wifiDot11Chnl,
-		wifiHsChnl,
-		bBtHsOn
-	);
-	CL_PRINTF(cliBuf);
-
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %02x %02x %02x ", "H2C Wifi inform bt chnl Info", \
-		pCoexDm->wifiChnlInfo[0],
-		pCoexDm->wifiChnlInfo[1],
-		pCoexDm->wifiChnlInfo[2]
-	);
-	CL_PRINTF(cliBuf);
-
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_S4_WIFI_RSSI, &wifiRssi);
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_S4_HS_RSSI, &btHsRssi);
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_U1_AP_NUM, &apNum);
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %d/ %d/ %d", "Wifi rssi/ HS rssi/ AP#", \
-		wifiRssi,
-		btHsRssi,
-		apNum
-	);
-	CL_PRINTF(cliBuf);
-
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_SCAN, &bScan);
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_LINK, &bLink);
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_ROAM, &bRoam);
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %d/ %d/ %d ", "Wifi bLink/ bRoam/ bScan", \
-		bLink,
-		bRoam,
-		bScan
-	);
-	CL_PRINTF(cliBuf);
-
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_U4_WIFI_BW, &wifiBw);
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_BUSY, &bWifiBusy);
-	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_U4_WIFI_TRAFFIC_DIRECTION, &wifiTrafficDir);
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %s / %s/ %s ", "Wifi status", \
-		("2.4G"),
-		((BTC_WIFI_BW_LEGACY == wifiBw) ? "Legacy" : (((BTC_WIFI_BW_HT40 == wifiBw) ? "HT40" : "HT20"))),
-		((!bWifiBusy) ? "idle" : ((BTC_WIFI_TRAFFIC_TX == wifiTrafficDir) ? "uplink" : "downlink"))
-	);
-	CL_PRINTF(cliBuf);
-
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = [%s/ %d/ %d] ", "BT [status/ rssi/ retryCnt]", \
-		((pBtCoexist->btInfo.bBtDisabled) ? ("disabled") : ((pCoexSta->bC2hBtInquiryPage) ? ("inquiry/page scan") : ((BT_8723B_2ANT_BT_STATUS_NON_CONNECTED_IDLE == pCoexDm->btStatus) ? "non-connected idle" :
-		((BT_8723B_2ANT_BT_STATUS_CONNECTED_IDLE == pCoexDm->btStatus) ? "connected-idle" : "busy")))),
-		pCoexSta->btRssi,
-		pCoexSta->btRetryCnt
-	);
-	CL_PRINTF(cliBuf);
-
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %d / %d / %d / %d", "SCO/HID/PAN/A2DP", \
-		pBtLinkInfo->bScoExist,
-		pBtLinkInfo->bHidExist,
-		pBtLinkInfo->bPanExist,
-		pBtLinkInfo->bA2dpExist
-	);
-	CL_PRINTF(cliBuf);
-	pBtCoexist->fBtcDispDbgMsg(pBtCoexist, BTC_DBG_DISP_BT_LINK_INFO);
-
-	btInfoExt = pCoexSta->btInfoExt;
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %s", "BT Info A2DP rate", \
-		(btInfoExt & BIT0) ? "Basic rate" : "EDR rate"
-	);
-	CL_PRINTF(cliBuf);
-
-	for (i = 0; i < BT_INFO_SRC_8723B_2ANT_MAX; i++) {
-		if (pCoexSta->btInfoC2hCnt[i]) {
-			CL_SPRINTF(
-				cliBuf,
-				BT_TMP_BUF_SIZE,
-				"\r\n %-35s = %02x %02x %02x %02x %02x %02x %02x(%d)", GLBtInfoSrc8723b2Ant[i], \
-				pCoexSta->btInfoC2h[i][0],
-				pCoexSta->btInfoC2h[i][1],
-				pCoexSta->btInfoC2h[i][2],
-				pCoexSta->btInfoC2h[i][3],
-				pCoexSta->btInfoC2h[i][4],
-				pCoexSta->btInfoC2h[i][5],
-				pCoexSta->btInfoC2h[i][6],
-				pCoexSta->btInfoC2hCnt[i]
-			);
-			CL_PRINTF(cliBuf);
-		}
-	}
-
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %s/%s", "PS state, IPS/LPS", \
-		((pCoexSta->bUnderIps ? "IPS ON" : "IPS OFF")),
-		((pCoexSta->bUnderLps ? "LPS ON" : "LPS OFF"))
-	);
-	CL_PRINTF(cliBuf);
-	pBtCoexist->fBtcDispDbgMsg(pBtCoexist, BTC_DBG_DISP_FW_PWR_MODE_CMD);
-
-	/*  Sw mechanism */
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s", "============[Sw mechanism]============"
-	);
-	CL_PRINTF(cliBuf);
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %d/ %d/ %d ", "SM1[ShRf/ LpRA/ LimDig]", \
-		pCoexDm->bCurRfRxLpfShrink,
-		pCoexDm->bCurLowPenaltyRa,
-		pCoexDm->bLimitedDig
-	);
-	CL_PRINTF(cliBuf);
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %d/ %d/ %d(0x%x) ",
-		"SM2[AgcT/ AdcB/ SwDacSwing(lvl)]", \
-		pCoexDm->bCurAgcTableEn,
-		pCoexDm->bCurAdcBackOff,
-		pCoexDm->bCurDacSwingOn,
-		pCoexDm->curDacSwingLvl
-	);
-	CL_PRINTF(cliBuf);
-
-	/*  Fw mechanism */
-	CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s", "============[Fw mechanism]============");
-	CL_PRINTF(cliBuf);
-
-	psTdmaCase = pCoexDm->curPsTdma;
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %02x %02x %02x %02x %02x case-%d (auto:%d)", "PS TDMA", \
-		pCoexDm->psTdmaPara[0],
-		pCoexDm->psTdmaPara[1],
-		pCoexDm->psTdmaPara[2],
-		pCoexDm->psTdmaPara[3],
-		pCoexDm->psTdmaPara[4],
-		psTdmaCase, pCoexDm->bAutoTdmaAdjust
-	);
-	CL_PRINTF(cliBuf);
-
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %d/ %d ", "DecBtPwr/ IgnWlanAct", \
-		pCoexDm->curBtDecPwrLvl,
-		pCoexDm->bCurIgnoreWlanAct
-	);
-	CL_PRINTF(cliBuf);
-
-	/*  Hw setting */
-	CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s", "============[Hw setting]============");
-	CL_PRINTF(cliBuf);
-
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = 0x%x", "RF-A, 0x1e initVal", \
-		pCoexDm->btRf0x1eBackup
-	);
-	CL_PRINTF(cliBuf);
-
-	u1Tmp[0] = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x778);
-	u4Tmp[0] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x880);
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = 0x%x/ 0x%x", "0x778/0x880[29:25]", \
-		u1Tmp[0],
-		(u4Tmp[0] & 0x3e000000) >> 25
-	);
-	CL_PRINTF(cliBuf);
-
-
-	u4Tmp[0] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x948);
-	u1Tmp[0] = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x67);
-	u1Tmp[1] = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x765);
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = 0x%x/ 0x%x/ 0x%x", "0x948/ 0x67[5] / 0x765", \
-		u4Tmp[0],
-		((u1Tmp[0] & 0x20) >> 5),
-		u1Tmp[1]
-	);
-	CL_PRINTF(cliBuf);
-
-	u4Tmp[0] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x92c);
-	u4Tmp[1] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x930);
-	u4Tmp[2] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x944);
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = 0x%x/ 0x%x/ 0x%x", "0x92c[1:0]/ 0x930[7:0]/0x944[1:0]", \
-		u4Tmp[0] & 0x3,
-		u4Tmp[1] & 0xff,
-		u4Tmp[2] & 0x3
-	);
-	CL_PRINTF(cliBuf);
-
-
-	u1Tmp[0] = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x39);
-	u1Tmp[1] = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x40);
-	u4Tmp[0] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x4c);
-	u1Tmp[2] = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x64);
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = 0x%x/ 0x%x/ 0x%x/ 0x%x", "0x38[11]/0x40/0x4c[24:23]/0x64[0]", \
-		((u1Tmp[0] & 0x8) >> 3),
-		u1Tmp[1],
-		((u4Tmp[0] & 0x01800000) >> 23),
-		u1Tmp[2] & 0x1
-	);
-	CL_PRINTF(cliBuf);
-
-	u4Tmp[0] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x550);
-	u1Tmp[0] = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x522);
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = 0x%x/ 0x%x", "0x550(bcn ctrl)/0x522", \
-		u4Tmp[0],
-		u1Tmp[0]
-	);
-	CL_PRINTF(cliBuf);
-
-	u4Tmp[0] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0xc50);
-	u1Tmp[0] = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x49c);
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = 0x%x/ 0x%x", "0xc50(dig)/0x49c(null-drop)", \
-		u4Tmp[0] & 0xff,
-		u1Tmp[0]
-	);
-	CL_PRINTF(cliBuf);
-
-	u4Tmp[0] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0xda0);
-	u4Tmp[1] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0xda4);
-	u4Tmp[2] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0xda8);
-	u4Tmp[3] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0xcf0);
-
-	u1Tmp[0] = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0xa5b);
-	u1Tmp[1] = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0xa5c);
-
-	faOfdm =
-		((u4Tmp[0] & 0xffff0000) >> 16) +
-		((u4Tmp[1] & 0xffff0000) >> 16) +
-		(u4Tmp[1] & 0xffff) +  (u4Tmp[2] & 0xffff) + \
-		((u4Tmp[3] & 0xffff0000) >> 16) +
-		(u4Tmp[3] & 0xffff);
-
-	faCck = (u1Tmp[0] << 8) + u1Tmp[1];
-
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = 0x%x/ 0x%x/ 0x%x", "OFDM-CCA/OFDM-FA/CCK-FA", \
-		u4Tmp[0] & 0xffff,
-		faOfdm,
-		faCck
-	);
-	CL_PRINTF(cliBuf);
-
-	u4Tmp[0] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x6c0);
-	u4Tmp[1] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x6c4);
-	u4Tmp[2] = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x6c8);
-	u1Tmp[0] = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x6cc);
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = 0x%x/ 0x%x/ 0x%x/ 0x%x", "0x6c0/0x6c4/0x6c8/0x6cc(coexTable)", \
-		u4Tmp[0],
-		u4Tmp[1],
-		u4Tmp[2],
-		u1Tmp[0]
-	);
-	CL_PRINTF(cliBuf);
-
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %d/ %d", "0x770(high-pri rx/tx)", \
-		pCoexSta->highPriorityRx,
-		pCoexSta->highPriorityTx
-	);
-	CL_PRINTF(cliBuf);
-	CL_SPRINTF(
-		cliBuf,
-		BT_TMP_BUF_SIZE,
-		"\r\n %-35s = %d/ %d", "0x774(low-pri rx/tx)", \
-		pCoexSta->lowPriorityRx,
-		pCoexSta->lowPriorityTx
-	);
-	CL_PRINTF(cliBuf);
-
-	halbtc8723b2ant_MonitorBtCtr(pBtCoexist);
-	pBtCoexist->fBtcDispDbgMsg(pBtCoexist, BTC_DBG_DISP_COEX_STATISTICS);
-}
-
-
 void EXhalbtc8723b2ant_IpsNotify(struct btc_coexist *pBtCoexist, u8 type)
 {
 	if (BTC_IPS_ENTER == type) {
diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.h b/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.h
index 80db3ba34a3f..1896ac54614c 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.h
+++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.h
@@ -144,4 +144,3 @@ void EXhalbtc8723b2ant_BtInfoNotify(
 void EXhalbtc8723b2ant_HaltNotify(struct btc_coexist *pBtCoexist);
 void EXhalbtc8723b2ant_PnpNotify(struct btc_coexist *pBtCoexist, u8 pnpState);
 void EXhalbtc8723b2ant_Periodical(struct btc_coexist *pBtCoexist);
-void EXhalbtc8723b2ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist);
diff --git a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
index deb57fa15eaf..af50674b2a65 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
+++ b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
@@ -85,10 +85,6 @@ enum {
 #define WIFI_P2P_GO_CONNECTED			BIT3
 #define WIFI_P2P_GC_CONNECTED			BIT4
 
-/*  following is for command line utility */
-#define CL_SPRINTF	snprintf
-#define CL_PRINTF	DCMD_Printf
-
 struct btc_board_info {
 	/*  The following is some board information */
 	u8 btChipType;
@@ -384,7 +380,6 @@ struct btc_coexist {
 	bool bInitilized;
 	bool bStopCoexDm;
 	bool bManualControl;
-	u8 *cliBuf;
 	struct btc_statistics statistics;
 	u8 pwrModeVal[10];
 
@@ -408,8 +403,6 @@ struct btc_coexist {
 
 	/*  fill h2c related */
 	BFP_BTC_FILL_H2C fBtcFillH2c;
-	/*  other */
-	BFP_BTC_DISP_DBG_MSG fBtcDispDbgMsg;
 	/*  normal get/set related */
 	BFP_BTC_GET fBtcGet;
 	BFP_BTC_SET fBtcSet;
@@ -440,6 +433,5 @@ void EXhalbtcoutsrc_Periodical(struct btc_coexist *pBtCoexist);
 void EXhalbtcoutsrc_SetChipType(u8 chipType);
 void EXhalbtcoutsrc_SetAntNum(u8 type, u8 antNum);
 void EXhalbtcoutsrc_SetSingleAntPath(u8 singleAntPath);
-void EXhalbtcoutsrc_DisplayBtCoexInfo(struct btc_coexist *pBtCoexist);
 
 #endif
diff --git a/drivers/staging/rtl8723bs/hal/Mp_Precomp.h b/drivers/staging/rtl8723bs/hal/Mp_Precomp.h
index 3ed1142a9896..f08823a8dd7b 100644
--- a/drivers/staging/rtl8723bs/hal/Mp_Precomp.h
+++ b/drivers/staging/rtl8723bs/hal/Mp_Precomp.h
@@ -12,8 +12,6 @@
 
 #define BT_TMP_BUF_SIZE	100
 
-#define DCMD_Printf			DBG_BT_INFO
-
 #ifdef bEnable
 #undef bEnable
 #endif
diff --git a/drivers/staging/rtl8723bs/hal/hal_btcoex.c b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
index 472005537b1b..6e165d808bbd 100644
--- a/drivers/staging/rtl8723bs/hal/hal_btcoex.c
+++ b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
@@ -17,52 +17,8 @@ struct btc_coexist GLBtCoexist;
 static u8 GLBtcWiFiInScanState;
 static u8 GLBtcWiFiInIQKState;
 
-static u8 GLBtcDbgBuf[BT_TMP_BUF_SIZE];
-
-struct btcdbginfo { /* _btcoexdbginfo */
-	u8 *info;
-	u32 size; /*  buffer total size */
-	u32 len; /*  now used length */
-};
-
-static struct btcdbginfo GLBtcDbgInfo;
-
 #define	BT_Operation(Adapter)						false
 
-static void DBG_BT_INFO_INIT(struct btcdbginfo *pinfo, u8 *pbuf, u32 size)
-{
-	if (!pinfo)
-		return;
-
-	memset(pinfo, 0, sizeof(struct btcdbginfo));
-
-	if (pbuf && size) {
-		pinfo->info = pbuf;
-		pinfo->size = size;
-	}
-}
-
-void DBG_BT_INFO(u8 *dbgmsg)
-{
-	struct btcdbginfo *pinfo;
-	u32 msglen;
-	u8 *pbuf;
-
-
-	pinfo = &GLBtcDbgInfo;
-
-	if (!pinfo->info)
-		return;
-
-	msglen = strlen(dbgmsg);
-	if (pinfo->len + msglen > pinfo->size)
-		return;
-
-	pbuf = pinfo->info + pinfo->len;
-	memcpy(pbuf, dbgmsg, msglen);
-	pinfo->len += msglen;
-}
-
 /*  */
 /* 		Debug related function */
 /*  */
@@ -608,17 +564,6 @@ static u8 halbtcoutsrc_Set(void *pBtcContext, u8 setType, void *pInBuf)
 	return ret;
 }
 
-static void halbtcoutsrc_DisplayFwPwrModeCmd(struct btc_coexist *pBtCoexist)
-{
-	u8 *cliBuf = pBtCoexist->cliBuf;
-
-	CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = %02x %02x %02x %02x %02x %02x ", "Power mode cmd ", \
-		pBtCoexist->pwrModeVal[0], pBtCoexist->pwrModeVal[1],
-		pBtCoexist->pwrModeVal[2], pBtCoexist->pwrModeVal[3],
-		pBtCoexist->pwrModeVal[4], pBtCoexist->pwrModeVal[5]);
-	CL_PRINTF(cliBuf);
-}
-
 /*  */
 /* 		IO related function */
 /*  */
@@ -830,25 +775,6 @@ static void halbtcoutsrc_FillH2cCmd(void *pBtcContext, u8 elementId, u32 cmdLen,
 	rtw_hal_fill_h2c_cmd(padapter, elementId, cmdLen, pCmdBuffer);
 }
 
-static void halbtcoutsrc_DisplayDbgMsg(void *pBtcContext, u8 dispType)
-{
-	struct btc_coexist *pBtCoexist;
-
-
-	pBtCoexist = (struct btc_coexist *)pBtcContext;
-	switch (dispType) {
-	case BTC_DBG_DISP_COEX_STATISTICS:
-		break;
-	case BTC_DBG_DISP_BT_LINK_INFO:
-		break;
-	case BTC_DBG_DISP_FW_PWR_MODE_CMD:
-		halbtcoutsrc_DisplayFwPwrModeCmd(pBtCoexist);
-		break;
-	default:
-		break;
-	}
-}
-
 /*  */
 /* 		Extern functions called by other module */
 /*  */
@@ -908,15 +834,12 @@ void hal_btcoex_Initialize(void *padapter)
 	pBtCoexist->fBtcGetRfReg = halbtcoutsrc_GetRfReg;
 
 	pBtCoexist->fBtcFillH2c = halbtcoutsrc_FillH2cCmd;
-	pBtCoexist->fBtcDispDbgMsg = halbtcoutsrc_DisplayDbgMsg;
 
 	pBtCoexist->fBtcGet = halbtcoutsrc_Get;
 	pBtCoexist->fBtcSet = halbtcoutsrc_Set;
 	pBtCoexist->fBtcGetBtReg = halbtcoutsrc_GetBtReg;
 	pBtCoexist->fBtcSetBtReg = halbtcoutsrc_SetBtReg;
 
-	pBtCoexist->cliBuf = &GLBtcDbgBuf[0];
-
 	pBtCoexist->boardInfo.singleAntPath = 0;
 
 	GLBtcWiFiInScanState = false;
@@ -1220,21 +1143,6 @@ void EXhalbtcoutsrc_SetSingleAntPath(u8 singleAntPath)
 	GLBtCoexist.boardInfo.singleAntPath = singleAntPath;
 }
 
-void EXhalbtcoutsrc_DisplayBtCoexInfo(struct btc_coexist *pBtCoexist)
-{
-	if (!halbtcoutsrc_IsBtCoexistAvailable(pBtCoexist))
-		return;
-
-	halbtcoutsrc_LeaveLowPower(pBtCoexist);
-
-	if (pBtCoexist->boardInfo.btdmAntNum == 2)
-		EXhalbtc8723b2ant_DisplayCoexInfo(pBtCoexist);
-	else if (pBtCoexist->boardInfo.btdmAntNum == 1)
-		EXhalbtc8723b1ant_DisplayCoexInfo(pBtCoexist);
-
-	halbtcoutsrc_NormalLowPower(pBtCoexist);
-}
-
 /*
  * Description:
  *Run BT-Coexist mechanism or not
@@ -1447,15 +1355,3 @@ void hal_btcoex_RecordPwrMode(struct adapter *padapter, u8 *pCmdBuf, u8 cmdLen)
 {
 	memcpy(GLBtCoexist.pwrModeVal, pCmdBuf, cmdLen);
 }
-
-void hal_btcoex_DisplayBtCoexInfo(struct adapter *padapter, u8 *pbuf, u32 bufsize)
-{
-	struct btcdbginfo *pinfo;
-
-
-	pinfo = &GLBtcDbgInfo;
-	DBG_BT_INFO_INIT(pinfo, pbuf, bufsize);
-	EXhalbtcoutsrc_DisplayBtCoexInfo(&GLBtCoexist);
-	DBG_BT_INFO_INIT(pinfo, NULL, 0);
-}
-
diff --git a/drivers/staging/rtl8723bs/include/hal_btcoex.h b/drivers/staging/rtl8723bs/include/hal_btcoex.h
index 849fb90b43b7..78599d3521bf 100644
--- a/drivers/staging/rtl8723bs/include/hal_btcoex.h
+++ b/drivers/staging/rtl8723bs/include/hal_btcoex.h
@@ -20,8 +20,6 @@ struct bt_coexist {
 	u8 bInitlized;
 };
 
-void DBG_BT_INFO(u8 *dbgmsg);
-
 void hal_btcoex_SetBTCoexist(struct adapter *padapter, u8 bBtExist);
 bool hal_btcoex_IsBtExist(struct adapter *padapter);
 bool hal_btcoex_IsBtDisabled(struct adapter *);
@@ -54,6 +52,5 @@ u8 hal_btcoex_RpwmVal(struct adapter *);
 u8 hal_btcoex_LpsVal(struct adapter *);
 u32 hal_btcoex_GetRaMask(struct adapter *);
 void hal_btcoex_RecordPwrMode(struct adapter *padapter, u8 *pCmdBuf, u8 cmdLen);
-void hal_btcoex_DisplayBtCoexInfo(struct adapter *, u8 *pbuf, u32 bufsize);
 
 #endif /*  !__HAL_BTCOEX_H__ */
-- 
2.20.1

