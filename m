Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A483870DA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 07:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346349AbhEREpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 00:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237964AbhEREpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 00:45:12 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2845FC061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 21:43:54 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id j12so6140913pgh.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 21:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HKwu0lqBG+B5BRwBPFuYvjIJcXhBUQclaujuOz/bG0M=;
        b=q+1ZJ3E3kaMOeiiNYIJND/7sGytHhhLR+QeyxhiPAUokPv/keoq+wTeUNw3X9o3bWZ
         JxtyEZXYVRVoPvWO+IgN3AhWjkDlWikAtlTeWRyuVzhMdSFru6nJpKpx/qXIWy0w/CVx
         SusQ6KKC3DDGwl+V3YU7NfduVTS+WtqV1ssMecfZsokb8IAIMr0Lsb35ubS/TCzoZGcf
         WVq4IMBc0fKvcxo0/Fpqt//Ty3NdgzPzQLvPcifPCWUD40kuVkB6/QF4G7CvKn/APQQh
         sRYFByUFkbZvf5WVLV+UnrrFXBfackwL/6W8wL9TL/LCT94u2hYrGO1KX33rNNzRyzT+
         JIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HKwu0lqBG+B5BRwBPFuYvjIJcXhBUQclaujuOz/bG0M=;
        b=lyK3anzVTdv3tpg7uuxfAjGhjA+eVoW/V96hgr8RUh6twdkDIJbRj82cnsb16Luvby
         1k0JinmYMzNaF0xvSwH0d1jvY2KMhYoXXRTHgj9EF78GW2PS1fGP9mHy70kD6EGXskiQ
         TBkDWypozQZc9uM6D8BNilUyFisO048DbvSfE7DF5AAR3icsbhejqR+3WN/5TpVm3+6l
         nBQcqkufSR6XnU3VoRqORKdU1SuVw/MhhAlpdaeQc+TfWqNRxzq2Ox0KA6GZzkI6yakS
         A6FGrEktB//sYivhEqLjD16Na52+I01i9TYU1uiQHsb4A4VfeM51l/Zu2e+A0eVbUnnJ
         kNVA==
X-Gm-Message-State: AOAM530Xm61IPv4085zrPz3hNdl64Vb+A4xwXpRJytw9PUCCtRuP7FNw
        20RYyg4SNhbx4Gy6CLCsUzw=
X-Google-Smtp-Source: ABdhPJwW3Oi7BDdJ/gVKhzYhpc61QKC5F40KXotVm60iFMPhjTvwqxs5/5jwnieTTjtx0WKWZDqUkg==
X-Received: by 2002:a63:4b5b:: with SMTP id k27mr3216835pgl.368.1621313033411;
        Mon, 17 May 2021 21:43:53 -0700 (PDT)
Received: from localhost.localdomain ([203.126.139.7])
        by smtp.gmail.com with ESMTPSA id t15sm357538pjh.0.2021.05.17.21.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 21:43:52 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     gregkh@linuxfoundation.org, marcocesati@gmail.com,
        dan.carpenter@oracle.com, fabioaiuto83@gmail.com,
        fmdefrancesco@gmail.com, eantoranz@gmail.com, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        skhan@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2 4/7] Staging: rtl8723bs: fix comparison formatting in HalBtc8723b1Ant.c
Date:   Tue, 18 May 2021 00:41:16 -0400
Message-Id: <20210518044119.2960494-5-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210518044119.2960494-1-desmondcheongzx@gmail.com>
References: <20210518044119.2960494-1-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes the following checkpatch.pl warnings:

WARNING: Comparisons should place the constant on the right side of the test
+		BT_8723B_1ANT_BT_STATUS_NON_CONNECTED_IDLE == pCoexDm->btStatus

WARNING: Comparisons should place the constant on the right side of the test
+		(BT_8723B_1ANT_BT_STATUS_NON_CONNECTED_IDLE == pCoexDm->btStatus)

WARNING: Comparisons should place the constant on the right side of the test
+		(BT_8723B_1ANT_BT_STATUS_CONNECTED_IDLE == pCoexDm->btStatus)

WARNING: Comparisons should place the constant on the right side of the test
+		(BT_8723B_1ANT_BT_STATUS_CONNECTED_IDLE == pCoexDm->btStatus)

WARNING: Comparisons should place the constant on the right side of the test
+		(BT_8723B_1ANT_BT_STATUS_CONNECTED_IDLE != pCoexDm->btStatus)

WARNING: Comparisons should place the constant on the right side of the test
+		(BT_8723B_1ANT_WIFI_STATUS_NON_CONNECTED_ASSO_AUTH_SCAN == wifiStatus) ||

WARNING: Comparisons should place the constant on the right side of the test
+		(BT_8723B_1ANT_WIFI_STATUS_CONNECTED_SCAN == wifiStatus) ||

WARNING: Comparisons should place the constant on the right side of the test
+		(BT_8723B_1ANT_WIFI_STATUS_CONNECTED_SPECIAL_PKT == wifiStatus)

WARNING: Comparisons should place the constant on the right side of the test
+		if (BT_8723B_1ANT_WIFI_STATUS_CONNECTED_IDLE == wifiStatus) {

WARNING: Comparisons should place the constant on the right side of the test
+	if (BT_8723B_1ANT_BT_STATUS_ACL_BUSY == pCoexDm->btStatus) {

WARNING: Comparisons should place the constant on the right side of the test
+		(BT_8723B_1ANT_BT_STATUS_SCO_BUSY == pCoexDm->btStatus) ||

WARNING: Comparisons should place the constant on the right side of the test
+		(BT_8723B_1ANT_BT_STATUS_ACL_SCO_BUSY == pCoexDm->btStatus)

WARNING: Comparisons should place the constant on the right side of the test
+	if (BT_8723B_1ANT_BT_STATUS_ACL_BUSY == pCoexDm->btStatus) {

WARNING: Comparisons should place the constant on the right side of the test
+		(BT_8723B_1ANT_BT_STATUS_SCO_BUSY == pCoexDm->btStatus) ||

WARNING: Comparisons should place the constant on the right side of the test
+		(BT_8723B_1ANT_BT_STATUS_ACL_SCO_BUSY == pCoexDm->btStatus)

WARNING: Comparisons should place the constant on the right side of the test
+		BT_8723B_1ANT_BT_STATUS_ACL_BUSY == pCoexDm->btStatus &&

WARNING: Comparisons should place the constant on the right side of the test
+		if (BT_8723B_1ANT_BT_STATUS_ACL_BUSY == pCoexDm->btStatus) {

WARNING: Comparisons should place the constant on the right side of the test
+			(BT_8723B_1ANT_BT_STATUS_SCO_BUSY == pCoexDm->btStatus) ||

WARNING: Comparisons should place the constant on the right side of the test
+			(BT_8723B_1ANT_BT_STATUS_ACL_SCO_BUSY == pCoexDm->btStatus)

WARNING: Comparisons should place the constant on the right side of the test
+		if (BT_8723B_1ANT_BT_STATUS_ACL_BUSY == pCoexDm->btStatus) {

WARNING: Comparisons should place the constant on the right side of the test
+			(BT_8723B_1ANT_BT_STATUS_SCO_BUSY == pCoexDm->btStatus) ||

WARNING: Comparisons should place the constant on the right side of the test
+			(BT_8723B_1ANT_BT_STATUS_ACL_SCO_BUSY == pCoexDm->btStatus)

WARNING: Comparisons should place the constant on the right side of the test
+		(BT_8723B_1ANT_BT_STATUS_ACL_BUSY == pCoexDm->btStatus) ||

WARNING: Comparisons should place the constant on the right side of the test
+		(BT_8723B_1ANT_BT_STATUS_SCO_BUSY == pCoexDm->btStatus) ||

WARNING: Comparisons should place the constant on the right side of the test
+		(BT_8723B_1ANT_BT_STATUS_ACL_SCO_BUSY == pCoexDm->btStatus)

WARNING: Comparisons should place the constant on the right side of the test
+		((bWifiUnderBMode) ? "11b" : ((BTC_WIFI_BW_LEGACY == wifiBw) ? "11bg" : (((BTC_WIFI_BW_HT40 == wifiBw) ? "HT40" : "HT20")))),

WARNING: Comparisons should place the constant on the right side of the test
+		((!bWifiBusy) ? "idle" : ((BTC_WIFI_TRAFFIC_TX == wifiTrafficDir) ? "uplink" : "downlink")),

WARNING: Comparisons should place the constant on the right side of the test
+		((pBtCoexist->btInfo.bBtDisabled) ? ("disabled") : ((pCoexSta->bC2hBtInquiryPage) ? ("inquiry/page scan") : ((BT_8723B_1ANT_BT_STATUS_NON_CONNECTED_IDLE == pCoexDm->btStatus) ? "non-connected idle" :

WARNING: Comparisons should place the constant on the right side of the test
+		((BT_8723B_1ANT_BT_STATUS_CONNECTED_IDLE == pCoexDm->btStatus) ? "connected-idle" : "busy")))),

WARNING: Comparisons should place the constant on the right side of the test
+	if (BTC_IPS_ENTER == type) {

WARNING: Comparisons should place the constant on the right side of the test
+	} else if (BTC_IPS_LEAVE == type) {

WARNING: Comparisons should place the constant on the right side of the test
+	if (BTC_LPS_ENABLE == type) {

WARNING: Comparisons should place the constant on the right side of the test
+	} else if (BTC_LPS_DISABLE == type) {

WARNING: Comparisons should place the constant on the right side of the test
+	if (BTC_SCAN_START == type) {

WARNING: Comparisons should place the constant on the right side of the test
+	if (BTC_SCAN_START == type) {

WARNING: Comparisons should place the constant on the right side of the test
+	} else if (BTC_SCAN_FINISH == type) {

WARNING: Comparisons should place the constant on the right side of the test
+	if (BTC_ASSOCIATE_START == type) {

WARNING: Comparisons should place the constant on the right side of the test
+	if (BTC_ASSOCIATE_START == type) {

WARNING: Comparisons should place the constant on the right side of the test
+	} else if (BTC_ASSOCIATE_FINISH == type) {

WARNING: Comparisons should place the constant on the right side of the test
+	if (BTC_MEDIA_CONNECT == type) {

WARNING: Comparisons should place the constant on the right side of the test
+	if ((BTC_MEDIA_CONNECT == type) && (wifiCentralChnl <= 14)) {

WARNING: Comparisons should place the constant on the right side of the test
+		if (BTC_WIFI_BW_HT40 == wifiBw)

WARNING: Comparisons should place the constant on the right side of the test
+		BTC_PACKET_DHCP == type ||

WARNING: Comparisons should place the constant on the right side of the test
+		BTC_PACKET_EAPOL == type ||

WARNING: Comparisons should place the constant on the right side of the test
+		BTC_PACKET_ARP == type

WARNING: Comparisons should place the constant on the right side of the test
+		if (BTC_PACKET_ARP == type) {

WARNING: Comparisons should place the constant on the right side of the test
+		BTC_PACKET_DHCP == type ||

WARNING: Comparisons should place the constant on the right side of the test
+		BTC_PACKET_EAPOL == type ||

WARNING: Comparisons should place the constant on the right side of the test
+		((BTC_PACKET_ARP == type) && (pCoexSta->bWiFiIsHighPriTask))

WARNING: Comparisons should place the constant on the right side of the test
+	if (BT_INFO_SRC_8723B_1ANT_WIFI_FW != rspSource) {

WARNING: Comparisons should place the constant on the right side of the test
+		if (BT_8723B_1ANT_BT_STATUS_ACL_BUSY != pCoexDm->btStatus)

WARNING: Comparisons should place the constant on the right side of the test
+		(BT_8723B_1ANT_BT_STATUS_ACL_BUSY == pCoexDm->btStatus) ||

WARNING: Comparisons should place the constant on the right side of the test
+		(BT_8723B_1ANT_BT_STATUS_SCO_BUSY == pCoexDm->btStatus) ||

WARNING: Comparisons should place the constant on the right side of the test
+		(BT_8723B_1ANT_BT_STATUS_ACL_SCO_BUSY == pCoexDm->btStatus)

WARNING: Comparisons should place the constant on the right side of the test
+	if (BTC_WIFI_PNP_SLEEP == pnpState) {

WARNING: Comparisons should place the constant on the right side of the test
+	} else if (BTC_WIFI_PNP_WAKE_UP == pnpState) {

Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
---
 .../staging/rtl8723bs/hal/HalBtc8723b1Ant.c   | 112 +++++++++---------
 1 file changed, 56 insertions(+), 56 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
index 63d0eec572ec..97831d04959b 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
+++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
@@ -1317,35 +1317,35 @@ static bool halbtc8723b1ant_IsCommonAction(struct btc_coexist *pBtCoexist)
 
 	if (
 		!bWifiConnected &&
-		BT_8723B_1ANT_BT_STATUS_NON_CONNECTED_IDLE == pCoexDm->btStatus
+		pCoexDm->btStatus == BT_8723B_1ANT_BT_STATUS_NON_CONNECTED_IDLE
 	) {
 		/* halbtc8723b1ant_SwMechanism(pBtCoexist, false); */
 
 		bCommon = true;
 	} else if (
 		bWifiConnected &&
-		(BT_8723B_1ANT_BT_STATUS_NON_CONNECTED_IDLE == pCoexDm->btStatus)
+		(pCoexDm->btStatus == BT_8723B_1ANT_BT_STATUS_NON_CONNECTED_IDLE)
 	) {
 		/* halbtc8723b1ant_SwMechanism(pBtCoexist, false); */
 
 		bCommon = true;
 	} else if (
 		!bWifiConnected &&
-		(BT_8723B_1ANT_BT_STATUS_CONNECTED_IDLE == pCoexDm->btStatus)
+		(pCoexDm->btStatus == BT_8723B_1ANT_BT_STATUS_CONNECTED_IDLE)
 	) {
 		/* halbtc8723b1ant_SwMechanism(pBtCoexist, false); */
 
 		bCommon = true;
 	} else if (
 		bWifiConnected &&
-		(BT_8723B_1ANT_BT_STATUS_CONNECTED_IDLE == pCoexDm->btStatus)
+		(pCoexDm->btStatus == BT_8723B_1ANT_BT_STATUS_CONNECTED_IDLE)
 	) {
 		/* halbtc8723b1ant_SwMechanism(pBtCoexist, false); */
 
 		bCommon = true;
 	} else if (
 		!bWifiConnected &&
-		(BT_8723B_1ANT_BT_STATUS_CONNECTED_IDLE != pCoexDm->btStatus)
+		(pCoexDm->btStatus != BT_8723B_1ANT_BT_STATUS_CONNECTED_IDLE)
 	) {
 		/* halbtc8723b1ant_SwMechanism(pBtCoexist, false); */
 
@@ -1367,9 +1367,9 @@ static void halbtc8723b1ant_TdmaDurationAdjustForAcl(
 	u8 retryCount = 0, btInfoExt;
 
 	if (
-		(BT_8723B_1ANT_WIFI_STATUS_NON_CONNECTED_ASSO_AUTH_SCAN == wifiStatus) ||
-		(BT_8723B_1ANT_WIFI_STATUS_CONNECTED_SCAN == wifiStatus) ||
-		(BT_8723B_1ANT_WIFI_STATUS_CONNECTED_SPECIAL_PKT == wifiStatus)
+		(wifiStatus == BT_8723B_1ANT_WIFI_STATUS_NON_CONNECTED_ASSO_AUTH_SCAN) ||
+		(wifiStatus == BT_8723B_1ANT_WIFI_STATUS_CONNECTED_SCAN) ||
+		(wifiStatus == BT_8723B_1ANT_WIFI_STATUS_CONNECTED_SPECIAL_PKT)
 	) {
 		if (
 			pCoexDm->curPsTdma != 1 &&
@@ -1676,7 +1676,7 @@ static void halbtc8723b1ant_ActionWifiConnectedBtAclBusy(
 		pCoexDm->bAutoTdmaAdjust = false;
 		return;
 	} else if (pBtLinkInfo->bA2dpOnly) { /* A2DP */
-		if (BT_8723B_1ANT_WIFI_STATUS_CONNECTED_IDLE == wifiStatus) {
+		if (wifiStatus == BT_8723B_1ANT_WIFI_STATUS_CONNECTED_IDLE) {
 			halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 32);
 			halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 4);
 			pCoexDm->bAutoTdmaAdjust = false;
@@ -1731,7 +1731,7 @@ static void halbtc8723b1ant_ActionWifiNotConnectedScan(
 	halbtc8723b1ant_PowerSaveState(pBtCoexist, BTC_PS_WIFI_NATIVE, 0x0, 0x0);
 
 	/*  tdma and coex table */
-	if (BT_8723B_1ANT_BT_STATUS_ACL_BUSY == pCoexDm->btStatus) {
+	if (pCoexDm->btStatus == BT_8723B_1ANT_BT_STATUS_ACL_BUSY) {
 		if (pBtLinkInfo->bA2dpExist) {
 			halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 32);
 			halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 4);
@@ -1743,8 +1743,8 @@ static void halbtc8723b1ant_ActionWifiNotConnectedScan(
 			halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 4);
 		}
 	} else if (
-		(BT_8723B_1ANT_BT_STATUS_SCO_BUSY == pCoexDm->btStatus) ||
-		(BT_8723B_1ANT_BT_STATUS_ACL_SCO_BUSY == pCoexDm->btStatus)
+		(pCoexDm->btStatus == BT_8723B_1ANT_BT_STATUS_SCO_BUSY) ||
+		(pCoexDm->btStatus == BT_8723B_1ANT_BT_STATUS_ACL_SCO_BUSY)
 	) {
 		halbtc8723b1ant_ActionBtScoHidOnlyBusy(
 			pBtCoexist, BT_8723B_1ANT_WIFI_STATUS_CONNECTED_SCAN
@@ -1788,7 +1788,7 @@ static void halbtc8723b1ant_ActionWifiConnectedScan(struct btc_coexist *pBtCoexi
 	halbtc8723b1ant_PowerSaveState(pBtCoexist, BTC_PS_WIFI_NATIVE, 0x0, 0x0);
 
 	/*  tdma and coex table */
-	if (BT_8723B_1ANT_BT_STATUS_ACL_BUSY == pCoexDm->btStatus) {
+	if (pCoexDm->btStatus == BT_8723B_1ANT_BT_STATUS_ACL_BUSY) {
 		if (pBtLinkInfo->bA2dpExist) {
 			halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 32);
 			halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 4);
@@ -1800,8 +1800,8 @@ static void halbtc8723b1ant_ActionWifiConnectedScan(struct btc_coexist *pBtCoexi
 			halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 4);
 		}
 	} else if (
-		(BT_8723B_1ANT_BT_STATUS_SCO_BUSY == pCoexDm->btStatus) ||
-		(BT_8723B_1ANT_BT_STATUS_ACL_SCO_BUSY == pCoexDm->btStatus)
+		(pCoexDm->btStatus == BT_8723B_1ANT_BT_STATUS_SCO_BUSY) ||
+		(pCoexDm->btStatus == BT_8723B_1ANT_BT_STATUS_ACL_SCO_BUSY)
 	) {
 		halbtc8723b1ant_ActionBtScoHidOnlyBusy(
 			pBtCoexist, BT_8723B_1ANT_WIFI_STATUS_CONNECTED_SCAN
@@ -1867,7 +1867,7 @@ static void halbtc8723b1ant_ActionWifiConnected(struct btc_coexist *pBtCoexist)
 	/*  power save state */
 	if (
 		!bApEnable &&
-		BT_8723B_1ANT_BT_STATUS_ACL_BUSY == pCoexDm->btStatus &&
+		pCoexDm->btStatus == BT_8723B_1ANT_BT_STATUS_ACL_BUSY &&
 		!pBtCoexist->btLinkInfo.bHidOnly
 	) {
 		if (pBtCoexist->btLinkInfo.bA2dpOnly) { /* A2DP */
@@ -1898,14 +1898,14 @@ static void halbtc8723b1ant_ActionWifiConnected(struct btc_coexist *pBtCoexist)
 
 	/*  tdma and coex table */
 	if (!bWifiBusy) {
-		if (BT_8723B_1ANT_BT_STATUS_ACL_BUSY == pCoexDm->btStatus) {
+		if (pCoexDm->btStatus == BT_8723B_1ANT_BT_STATUS_ACL_BUSY) {
 			halbtc8723b1ant_ActionWifiConnectedBtAclBusy(
 				pBtCoexist,
 				BT_8723B_1ANT_WIFI_STATUS_CONNECTED_IDLE
 			);
 		} else if (
-			(BT_8723B_1ANT_BT_STATUS_SCO_BUSY == pCoexDm->btStatus) ||
-			(BT_8723B_1ANT_BT_STATUS_ACL_SCO_BUSY == pCoexDm->btStatus)
+			(pCoexDm->btStatus == BT_8723B_1ANT_BT_STATUS_SCO_BUSY) ||
+			(pCoexDm->btStatus == BT_8723B_1ANT_BT_STATUS_ACL_SCO_BUSY)
 		) {
 			halbtc8723b1ant_ActionBtScoHidOnlyBusy(pBtCoexist,
 				BT_8723B_1ANT_WIFI_STATUS_CONNECTED_IDLE);
@@ -1918,14 +1918,14 @@ static void halbtc8723b1ant_ActionWifiConnected(struct btc_coexist *pBtCoexist)
 				halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 7);
 		}
 	} else {
-		if (BT_8723B_1ANT_BT_STATUS_ACL_BUSY == pCoexDm->btStatus) {
+		if (pCoexDm->btStatus == BT_8723B_1ANT_BT_STATUS_ACL_BUSY) {
 			halbtc8723b1ant_ActionWifiConnectedBtAclBusy(
 				pBtCoexist,
 				BT_8723B_1ANT_WIFI_STATUS_CONNECTED_BUSY
 			);
 		} else if (
-			(BT_8723B_1ANT_BT_STATUS_SCO_BUSY == pCoexDm->btStatus) ||
-			(BT_8723B_1ANT_BT_STATUS_ACL_SCO_BUSY == pCoexDm->btStatus)
+			(pCoexDm->btStatus == BT_8723B_1ANT_BT_STATUS_SCO_BUSY) ||
+			(pCoexDm->btStatus == BT_8723B_1ANT_BT_STATUS_ACL_SCO_BUSY)
 		) {
 			halbtc8723b1ant_ActionBtScoHidOnlyBusy(
 				pBtCoexist,
@@ -2010,9 +2010,9 @@ static void halbtc8723b1ant_RunCoexistMechanism(struct btc_coexist *pBtCoexist)
 		return;
 
 	if (
-		(BT_8723B_1ANT_BT_STATUS_ACL_BUSY == pCoexDm->btStatus) ||
-		(BT_8723B_1ANT_BT_STATUS_SCO_BUSY == pCoexDm->btStatus) ||
-		(BT_8723B_1ANT_BT_STATUS_ACL_SCO_BUSY == pCoexDm->btStatus)
+		(pCoexDm->btStatus == BT_8723B_1ANT_BT_STATUS_ACL_BUSY) ||
+		(pCoexDm->btStatus == BT_8723B_1ANT_BT_STATUS_SCO_BUSY) ||
+		(pCoexDm->btStatus == BT_8723B_1ANT_BT_STATUS_ACL_SCO_BUSY)
 	){
 		bIncreaseScanDevNum = true;
 	}
@@ -2361,8 +2361,8 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 		BT_TMP_BUF_SIZE,
 		"\r\n %-35s = %s / %s/ %s/ AP =%d/ %s ", "Wifi status", \
 		(bWifiUnder5G ? "5G" : "2.4G"),
-		((bWifiUnderBMode) ? "11b" : ((BTC_WIFI_BW_LEGACY == wifiBw) ? "11bg" : (((BTC_WIFI_BW_HT40 == wifiBw) ? "HT40" : "HT20")))),
-		((!bWifiBusy) ? "idle" : ((BTC_WIFI_TRAFFIC_TX == wifiTrafficDir) ? "uplink" : "downlink")),
+		((bWifiUnderBMode) ? "11b" : ((wifiBw == BTC_WIFI_BW_LEGACY) ? "11bg" : (((wifiBw == BTC_WIFI_BW_HT40) ? "HT40" : "HT20")))),
+		((!bWifiBusy) ? "idle" : ((wifiTrafficDir == BTC_WIFI_TRAFFIC_TX) ? "uplink" : "downlink")),
 		pCoexSta->nScanAPNum,
 		(pCoexSta->bCCKLock) ? "Lock" : "noLock"
 	);
@@ -2389,8 +2389,8 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 		cliBuf,
 		BT_TMP_BUF_SIZE,
 		"\r\n %-35s = [%s/ %d/ %d/ %d] ", "BT [status/ rssi/ retryCnt/ popCnt]", \
-		((pBtCoexist->btInfo.bBtDisabled) ? ("disabled") : ((pCoexSta->bC2hBtInquiryPage) ? ("inquiry/page scan") : ((BT_8723B_1ANT_BT_STATUS_NON_CONNECTED_IDLE == pCoexDm->btStatus) ? "non-connected idle" :
-		((BT_8723B_1ANT_BT_STATUS_CONNECTED_IDLE == pCoexDm->btStatus) ? "connected-idle" : "busy")))),
+		((pBtCoexist->btInfo.bBtDisabled) ? ("disabled") : ((pCoexSta->bC2hBtInquiryPage) ? ("inquiry/page scan") : ((pCoexDm->btStatus == BT_8723B_1ANT_BT_STATUS_NON_CONNECTED_IDLE) ? "non-connected idle" :
+																					((pCoexDm->btStatus == BT_8723B_1ANT_BT_STATUS_CONNECTED_IDLE) ? "connected-idle" : "busy")))),
 		pCoexSta->btRssi, pCoexSta->btRetryCnt, pCoexSta->popEventCnt
 	);
 	CL_PRINTF(cliBuf);
@@ -2680,13 +2680,13 @@ void EXhalbtc8723b1ant_IpsNotify(struct btc_coexist *pBtCoexist, u8 type)
 	if (pBtCoexist->bManualControl ||	pBtCoexist->bStopCoexDm)
 		return;
 
-	if (BTC_IPS_ENTER == type) {
+	if (type == BTC_IPS_ENTER) {
 		pCoexSta->bUnderIps = true;
 
 		halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, false, 0);
 		halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 0);
 		halbtc8723b1ant_SetAntPath(pBtCoexist, BTC_ANT_PATH_BT, false, true);
-	} else if (BTC_IPS_LEAVE == type) {
+	} else if (type == BTC_IPS_LEAVE) {
 		pCoexSta->bUnderIps = false;
 
 		halbtc8723b1ant_InitHwConfig(pBtCoexist, false, false);
@@ -2700,9 +2700,9 @@ void EXhalbtc8723b1ant_LpsNotify(struct btc_coexist *pBtCoexist, u8 type)
 	if (pBtCoexist->bManualControl || pBtCoexist->bStopCoexDm)
 		return;
 
-	if (BTC_LPS_ENABLE == type)
+	if (type == BTC_LPS_ENABLE)
 		pCoexSta->bUnderLps = true;
-	else if (BTC_LPS_DISABLE == type)
+	else if (type == BTC_LPS_DISABLE)
 		pCoexSta->bUnderLps = false;
 }
 
@@ -2720,7 +2720,7 @@ void EXhalbtc8723b1ant_ScanNotify(struct btc_coexist *pBtCoexist, u8 type)
 	if (pBtCoexist->bManualControl || pBtCoexist->bStopCoexDm)
 		return;
 
-	if (BTC_SCAN_START == type) {
+	if (type == BTC_SCAN_START) {
 		pCoexSta->bWiFiIsHighPriTask = true;
 
 		halbtc8723b1ant_PsTdma(pBtCoexist, FORCE_EXEC, false, 8);  /* Force antenna setup for no scan result issue */
@@ -2763,12 +2763,12 @@ void EXhalbtc8723b1ant_ScanNotify(struct btc_coexist *pBtCoexist, u8 type)
 		return;
 	}
 
-	if (BTC_SCAN_START == type) {
+	if (type == BTC_SCAN_START) {
 		if (!bWifiConnected)	/*  non-connected scan */
 			halbtc8723b1ant_ActionWifiNotConnectedScan(pBtCoexist);
 		else	/*  wifi is connected */
 			halbtc8723b1ant_ActionWifiConnectedScan(pBtCoexist);
-	} else if (BTC_SCAN_FINISH == type) {
+	} else if (type == BTC_SCAN_FINISH) {
 		if (!bWifiConnected)	/*  non-connected scan */
 			halbtc8723b1ant_ActionWifiNotConnected(pBtCoexist);
 		else
@@ -2791,7 +2791,7 @@ void EXhalbtc8723b1ant_ConnectNotify(struct btc_coexist *pBtCoexist, u8 type)
 	)
 		return;
 
-	if (BTC_ASSOCIATE_START == type) {
+	if (type == BTC_ASSOCIATE_START) {
 		pCoexSta->bWiFiIsHighPriTask = true;
 		 pCoexDm->nArpCnt = 0;
 	} else {
@@ -2817,9 +2817,9 @@ void EXhalbtc8723b1ant_ConnectNotify(struct btc_coexist *pBtCoexist, u8 type)
 		return;
 	}
 
-	if (BTC_ASSOCIATE_START == type) {
+	if (type == BTC_ASSOCIATE_START) {
 		halbtc8723b1ant_ActionWifiNotConnectedAssoAuth(pBtCoexist);
-	} else if (BTC_ASSOCIATE_FINISH == type) {
+	} else if (type == BTC_ASSOCIATE_FINISH) {
 		pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_CONNECTED, &bWifiConnected);
 		if (!bWifiConnected) /*  non-connected scan */
 			halbtc8723b1ant_ActionWifiNotConnected(pBtCoexist);
@@ -2842,7 +2842,7 @@ void EXhalbtc8723b1ant_MediaStatusNotify(struct btc_coexist *pBtCoexist, u8 type
 	)
 		return;
 
-	if (BTC_MEDIA_CONNECT == type) {
+	if (type == BTC_MEDIA_CONNECT) {
 		pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_UNDER_B_MODE, &bWifiUnderBMode);
 
 		/* Set CCK Tx/Rx high Pri except 11b mode */
@@ -2867,13 +2867,13 @@ void EXhalbtc8723b1ant_MediaStatusNotify(struct btc_coexist *pBtCoexist, u8 type
 
 	/*  only 2.4G we need to inform bt the chnl mask */
 	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_U1_WIFI_CENTRAL_CHNL, &wifiCentralChnl);
-	if ((BTC_MEDIA_CONNECT == type) && (wifiCentralChnl <= 14)) {
+	if ((type == BTC_MEDIA_CONNECT) && (wifiCentralChnl <= 14)) {
 		/* H2C_Parameter[0] = 0x1; */
 		H2C_Parameter[0] = 0x0;
 		H2C_Parameter[1] = wifiCentralChnl;
 		pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_U4_WIFI_BW, &wifiBw);
 
-		if (BTC_WIFI_BW_HT40 == wifiBw)
+		if (wifiBw == BTC_WIFI_BW_HT40)
 			H2C_Parameter[2] = 0x30;
 		else
 			H2C_Parameter[2] = 0x20;
@@ -2902,11 +2902,11 @@ void EXhalbtc8723b1ant_SpecialPacketNotify(struct btc_coexist *pBtCoexist, u8 ty
 		return;
 
 	if (
-		BTC_PACKET_DHCP == type ||
-		BTC_PACKET_EAPOL == type ||
-		BTC_PACKET_ARP == type
+		type == BTC_PACKET_DHCP ||
+		type == BTC_PACKET_EAPOL ||
+		type == BTC_PACKET_ARP
 	) {
-		if (BTC_PACKET_ARP == type) {
+		if (type == BTC_PACKET_ARP) {
 			pCoexDm->nArpCnt++;
 
 			if (pCoexDm->nArpCnt >= 10) /*  if APR PKT > 10 after connect, do not go to ActionWifiConnectedSpecialPacket(pBtCoexist) */
@@ -2946,9 +2946,9 @@ void EXhalbtc8723b1ant_SpecialPacketNotify(struct btc_coexist *pBtCoexist, u8 ty
 	}
 
 	if (
-		BTC_PACKET_DHCP == type ||
-		BTC_PACKET_EAPOL == type ||
-		((BTC_PACKET_ARP == type) && (pCoexSta->bWiFiIsHighPriTask))
+		type == BTC_PACKET_DHCP ||
+		type == BTC_PACKET_EAPOL ||
+		((type == BTC_PACKET_ARP) && (pCoexSta->bWiFiIsHighPriTask))
 	)
 		halbtc8723b1ant_ActionWifiConnectedSpecialPacket(pBtCoexist);
 }
@@ -2975,7 +2975,7 @@ void EXhalbtc8723b1ant_BtInfoNotify(
 			btInfo = tmpBuf[i];
 	}
 
-	if (BT_INFO_SRC_8723B_1ANT_WIFI_FW != rspSource) {
+	if (rspSource != BT_INFO_SRC_8723B_1ANT_WIFI_FW) {
 		pCoexSta->btRetryCnt = pCoexSta->btInfoC2h[rspSource][2] & 0xf;
 
 		if (pCoexSta->btRetryCnt >= 1)
@@ -3068,7 +3068,7 @@ void EXhalbtc8723b1ant_BtInfoNotify(
 	) {
 		pCoexDm->btStatus = BT_8723B_1ANT_BT_STATUS_SCO_BUSY;
 	} else if (btInfo & BT_INFO_8723B_1ANT_B_ACL_BUSY) {
-		if (BT_8723B_1ANT_BT_STATUS_ACL_BUSY != pCoexDm->btStatus)
+		if (pCoexDm->btStatus != BT_8723B_1ANT_BT_STATUS_ACL_BUSY)
 			pCoexDm->bAutoTdmaAdjust = false;
 
 		pCoexDm->btStatus = BT_8723B_1ANT_BT_STATUS_ACL_BUSY;
@@ -3077,9 +3077,9 @@ void EXhalbtc8723b1ant_BtInfoNotify(
 	}
 
 	if (
-		(BT_8723B_1ANT_BT_STATUS_ACL_BUSY == pCoexDm->btStatus) ||
-		(BT_8723B_1ANT_BT_STATUS_SCO_BUSY == pCoexDm->btStatus) ||
-		(BT_8723B_1ANT_BT_STATUS_ACL_SCO_BUSY == pCoexDm->btStatus)
+		(pCoexDm->btStatus == BT_8723B_1ANT_BT_STATUS_ACL_BUSY) ||
+		(pCoexDm->btStatus == BT_8723B_1ANT_BT_STATUS_SCO_BUSY) ||
+		(pCoexDm->btStatus == BT_8723B_1ANT_BT_STATUS_ACL_SCO_BUSY)
 	)
 		bBtBusy = true;
 	else
@@ -3104,14 +3104,14 @@ void EXhalbtc8723b1ant_HaltNotify(struct btc_coexist *pBtCoexist)
 
 void EXhalbtc8723b1ant_PnpNotify(struct btc_coexist *pBtCoexist, u8 pnpState)
 {
-	if (BTC_WIFI_PNP_SLEEP == pnpState) {
+	if (pnpState == BTC_WIFI_PNP_SLEEP) {
 		halbtc8723b1ant_PowerSaveState(pBtCoexist, BTC_PS_WIFI_NATIVE, 0x0, 0x0);
 		halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, false, 0);
 		halbtc8723b1ant_CoexTableWithType(pBtCoexist, NORMAL_EXEC, 2);
 		halbtc8723b1ant_SetAntPath(pBtCoexist, BTC_ANT_PATH_BT, false, true);
 
 		pBtCoexist->bStopCoexDm = true;
-	} else if (BTC_WIFI_PNP_WAKE_UP == pnpState) {
+	} else if (pnpState == BTC_WIFI_PNP_WAKE_UP) {
 		pBtCoexist->bStopCoexDm = false;
 		halbtc8723b1ant_InitHwConfig(pBtCoexist, false, false);
 		halbtc8723b1ant_InitCoexDm(pBtCoexist);
-- 
2.25.1

