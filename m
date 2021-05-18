Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858CE3870EE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 07:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346331AbhEREoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 00:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237964AbhEREoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 00:44:37 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61900C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 21:43:19 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id b7so238065plg.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 21:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I6WhL1PpTCyWACZgwSEwTO4odDW7Vfe+3XlFCiuIyHg=;
        b=EWNm3sT8VONYUaxKQdVSbDHgSV57aFBf9ShB/WWGFlLAnrKd1TBZIgYlyHA0f9Mun4
         xZvYqpOXaR90R1vWLu+XvpUliqLcVYh2s5U4Ks3P1Npzm1d9lt9BMXZB+zJNJBZNOaG0
         YrKuv9iceFrTF3ZvqMu/5LQq3zAR+Wm2hnJ82zXsVcXsqBWHjQHf0aJIprhmk4mDExgl
         qOmLL/kzFCs07AbE1vHvAGEMiZ+0L2JtYs1v/6nBN5FDS0wagsUhg2GbUNY+5RyIXYms
         5OtRi5PSfKYo7OeZcGfkSODqK+Sg6OJsZm50FZoDOH5665q7ek9gHasYxdnyMee08a3x
         8jHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I6WhL1PpTCyWACZgwSEwTO4odDW7Vfe+3XlFCiuIyHg=;
        b=akX4gDkiz2RWz7TiOmh0qaI+FwaIG2iJJkr4vsbtS3NUlsh2/AUKKzWDZD/RZa6ZLG
         XVgppA1rb0h2JzLu+FNVMOZoKAjVoJd1MrgJVYnt/Lbx7efWdXOv+z+rojXzTucK5dC0
         gv7CzKCE46bHF0Ya5mfLFxWMuBJbnTR2+wTt+D0LWliyxkWl+Xs6vpWIN7LXVeq4Ik/T
         e1fomHAAaqi91DXYhS4SwD5HP26uVvRr83drcykUQETUIfx7Kz9UAw5YGBeyBDzZ4Ser
         W5+w30WaavacHWATSaKv5gmZPdXUSjhXbsyFs33oCbAhtFQ+4ijKGB+LX2QSONJZDgyi
         g3aw==
X-Gm-Message-State: AOAM532/Sk4K3a5l239wLkftiZFyX6ibx2KxmfDhp/5y2iqmOHzAaE7+
        QjkGhvuZbDhGXzjIimKaP4I=
X-Google-Smtp-Source: ABdhPJwdaTjhcVBqBnXjCbwU90yrrcSGf3XVzEEaZs7y4abhvIoHuCiTUAaI4EuKnLVtxji5xI3w0w==
X-Received: by 2002:a17:90a:ac12:: with SMTP id o18mr2992507pjq.65.1621312998910;
        Mon, 17 May 2021 21:43:18 -0700 (PDT)
Received: from localhost.localdomain ([203.126.139.7])
        by smtp.gmail.com with ESMTPSA id t15sm357538pjh.0.2021.05.17.21.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 21:43:18 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     gregkh@linuxfoundation.org, marcocesati@gmail.com,
        dan.carpenter@oracle.com, fabioaiuto83@gmail.com,
        fmdefrancesco@gmail.com, eantoranz@gmail.com, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        skhan@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2 2/7] Staging: rtl8723bs: fix spaces in HalBtc8723b1Ant.c
Date:   Tue, 18 May 2021 00:41:14 -0400
Message-Id: <20210518044119.2960494-3-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210518044119.2960494-1-desmondcheongzx@gmail.com>
References: <20210518044119.2960494-1-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes the following checkpatch.pl errors:

WARNING: please, no space before tabs
+^I/* ^IRx Aggregation related setting */$

WARNING: please, no space before tabs
+^Iu8 ^IH2C_Parameter[1] = {0};$

WARNING: please, no space before tabs
+^Iu8 ^IH2C_Parameter[6] = {0};$

WARNING: please, no space before tabs
+^I/* u32 ^I^IfwVer = 0; */$

WARNING: please, no space before tabs
+/* ^ISoftware Coex Mechanism start */$

WARNING: please, no space before tabs
+/* ^INon-Software Coex Mechanism start */$

WARNING: please, no space before tabs
+^I/* ^IBIT0: "0" for no antenna inverse; "1" for antenna inverse */$

WARNING: please, no space before tabs
+^I/* ^IBIT1: "0" for internal switch; "1" for external switch */$

WARNING: please, no space before tabs
+^I/* ^IBIT2: "0" for one antenna; "1" for two antenna */$

Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
---
 .../staging/rtl8723bs/hal/HalBtc8723b1Ant.c    | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
index 85bf45cabecd..49f37aa16cc4 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
+++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
@@ -231,7 +231,7 @@ static void halbtc8723b1ant_LimitedRx(
 	u8 rxAggSize = aggBufSize;
 
 	/*  */
-	/* 	Rx Aggregation related setting */
+	/*	Rx Aggregation related setting */
 	/*  */
 	pBtCoexist->fBtcSet(
 		pBtCoexist, BTC_SET_BL_TO_REJ_AP_AGG_PKT, &bRejectRxAgg
@@ -250,7 +250,7 @@ static void halbtc8723b1ant_LimitedRx(
 
 static void halbtc8723b1ant_QueryBtInfo(struct btc_coexist *pBtCoexist)
 {
-	u8 	H2C_Parameter[1] = {0};
+	u8 H2C_Parameter[1] = {0};
 
 	pCoexSta->bC2hBtInfoReqSent = true;
 
@@ -606,7 +606,7 @@ static void halbtc8723b1ant_SetSwPenaltyTxRateAdaptive(
 	struct btc_coexist *pBtCoexist, bool bLowPenaltyRa
 )
 {
-	u8 	H2C_Parameter[6] = {0};
+	u8 H2C_Parameter[6] = {0};
 
 	H2C_Parameter[0] = 0x6;	/*  opCode, 0x6 = Retry_Penalty */
 
@@ -1038,7 +1038,7 @@ static void halbtc8723b1ant_PsTdma(
 	u8 rssiAdjustVal = 0;
 	u8 psTdmaByte4Val = 0x50, psTdmaByte0Val = 0x51, psTdmaByte3Val =  0x10;
 	s8 nWiFiDurationAdjust = 0x0;
-	/* u32 		fwVer = 0; */
+	/* u32 fwVer = 0; */
 
 	pCoexDm->bCurPsTdmaOn = bTurnOn;
 	pCoexDm->curPsTdma = type;
@@ -1575,13 +1575,13 @@ static void halbtc8723b1ant_PowerSaveState(
 
 /*  */
 /*  */
-/* 	Software Coex Mechanism start */
+/*	Software Coex Mechanism start */
 /*  */
 /*  */
 
 /*  */
 /*  */
-/* 	Non-Software Coex Mechanism start */
+/*	Non-Software Coex Mechanism start */
 /*  */
 /*  */
 static void halbtc8723b1ant_ActionWifiMultiPort(struct btc_coexist *pBtCoexist)
@@ -2166,9 +2166,9 @@ void EXhalbtc8723b1ant_PowerOnSetting(struct btc_coexist *pBtCoexist)
 	/*  */
 	/*  S0 or S1 setting and Local register setting(By the setting fw can get ant number, S0/S1, ... info) */
 	/*  Local setting bit define */
-	/* 	BIT0: "0" for no antenna inverse; "1" for antenna inverse */
-	/* 	BIT1: "0" for internal switch; "1" for external switch */
-	/* 	BIT2: "0" for one antenna; "1" for two antenna */
+	/*	BIT0: "0" for no antenna inverse; "1" for antenna inverse */
+	/*	BIT1: "0" for internal switch; "1" for external switch */
+	/*	BIT2: "0" for one antenna; "1" for two antenna */
 	/*  NOTE: here default all internal switch and 1-antenna ==> BIT1 = 0 and BIT2 = 0 */
 	if (pBtCoexist->chipInterface == BTC_INTF_USB) {
 		/*  fixed at S0 for USB interface */
-- 
2.25.1

