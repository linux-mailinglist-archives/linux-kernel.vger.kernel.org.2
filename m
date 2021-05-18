Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDFA3870E9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 07:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346347AbhEREpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 00:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237964AbhEREo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 00:44:57 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B9DC061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 21:43:39 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id q2so6479020pfh.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 21:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uEpsBQ7rbIhP4Lk4USk29pB1/Jh9hlfSvj6sx/s54ew=;
        b=T5zUbW45c6BVkoMmsswh42owtMM7k4zeAhTXGTzGofmwzPkrX1D9f3mlBatE6TvNw5
         8guiOoZLVX/eck67OiintMjzQl52WapyEpeigJOpWfLAPjaJsecsXO3XLl3iVsOyiW/1
         4bmMeyRFTlF9+DncG2gR5Z3bWtRqW6kMUa7DynH/NqLSxZf/2cx2b8lFmw1dkHYAt65n
         A0gDpdIxytqia72eFA1470yRAyhEsmOrOcRKwkiN86UXQDP0RtTgCJAh1cvpKZXaGfdZ
         kXkCTyilERxU3gYYgNBT4Pb1Fe/BCCRbdAX85RTPwVa4V2YtZPtcAwymVMAHOv2LMMfA
         v2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uEpsBQ7rbIhP4Lk4USk29pB1/Jh9hlfSvj6sx/s54ew=;
        b=iod1hPbW7dSKfJYZq3sHvdDh3y4Ah2PJgcZZgNy4iCqdWVmQHzEFzk+CiEVeF1rYfn
         tu4rR9Cge5ZnrFq11+DMJO0R9XDRb8EAUfKXHROhYcskh+SyKQ/p7gm0g0lU5/ZX3G69
         /CSs9tcjN2kvGXyELVR3DwkiieMu5P1EoevzQzsVQ6YJv+MdBHkNm6CZol+clnIyMcfi
         bLR7FGGQZBMV9vE7MaBsL5J+uuY/H+Xj0eqw4Tcpt8G1Jzv8tLqkqAstKSVEfcoRqd1Y
         TI9KDNHMqQg6eztkXNkMVUoQaXNm7nxzMl5x87EBfgDUK5igDuCW4n80kmojQnDWkMCZ
         Gu4w==
X-Gm-Message-State: AOAM531U0nPGvTJX90PSuOsPmKIN4ExMfmwM1gJ/oL1trd1v0Mey06QF
        oBWiOiudjyVynVw/eiNdNus=
X-Google-Smtp-Source: ABdhPJxeYGrQzUynRjf15rgfUfkpAWLJTpnimfMRZbXDVXjcQcZztueFXFu8Xu9guAJsxnixZmzu2Q==
X-Received: by 2002:a63:f717:: with SMTP id x23mr3133606pgh.141.1621313019016;
        Mon, 17 May 2021 21:43:39 -0700 (PDT)
Received: from localhost.localdomain ([203.126.139.7])
        by smtp.gmail.com with ESMTPSA id t15sm357538pjh.0.2021.05.17.21.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 21:43:38 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     gregkh@linuxfoundation.org, marcocesati@gmail.com,
        dan.carpenter@oracle.com, fabioaiuto83@gmail.com,
        fmdefrancesco@gmail.com, eantoranz@gmail.com, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        skhan@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2 3/7] Staging: rtl8723bs: fix indentation in HalBtc8723b1Ant.c
Date:   Tue, 18 May 2021 00:41:15 -0400
Message-Id: <20210518044119.2960494-4-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210518044119.2960494-1-desmondcheongzx@gmail.com>
References: <20210518044119.2960494-1-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes the following checkpatch.pl errors:

WARNING: suspect code indent for conditional statements (32, 33)
+				if (nCCKLockCounter < 5)
+				 nCCKLockCounter++;

WARNING: suspect code indent for conditional statements (32, 33)
+				if (nCCKLockCounter > 0)
+				 nCCKLockCounter--;

WARNING: suspect code indent for conditional statements (24, 26)
+			if (nCCKLockCounter > 0)
+			  nCCKLockCounter--;

WARNING: suspect code indent for conditional statements (16, 17)
+		if (nCCKLockCounter >= 5)
+		 pCoexSta->bCCKLock = true;

WARNING: suspect code indent for conditional statements (16, 17)
+		else
+		 pCoexSta->bCCKLock = false;

WARNING: suspect code indent for conditional statements (16, 17)
+		if (nCCKLockCounter == 0)
+		 pCoexSta->bCCKLock = false;

WARNING: suspect code indent for conditional statements (16, 17)
+		else
+		 pCoexSta->bCCKLock = true;

WARNING: suspect code indent for conditional statements (16, 25)
+		if (bScan || bLink || bRoam) {
+			 if (bScan)

WARNING: Statements should start on a tabstop
+			 if (bScan)

WARNING: Statements should start on a tabstop
+			 else

Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
---
 .../staging/rtl8723bs/hal/HalBtc8723b1Ant.c    | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
index 49f37aa16cc4..63d0eec572ec 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
+++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
@@ -361,15 +361,15 @@ static void halbtc8723b1ant_MonitorWiFiCtr(struct btc_coexist *pBtCoexist)
 				)
 			) {
 				if (nCCKLockCounter < 5)
-				 nCCKLockCounter++;
+					nCCKLockCounter++;
 			} else {
 				if (nCCKLockCounter > 0)
-				 nCCKLockCounter--;
+					nCCKLockCounter--;
 			}
 
 		} else {
 			if (nCCKLockCounter > 0)
-			  nCCKLockCounter--;
+				nCCKLockCounter--;
 		}
 	} else {
 		if (nCCKLockCounter > 0)
@@ -379,14 +379,14 @@ static void halbtc8723b1ant_MonitorWiFiCtr(struct btc_coexist *pBtCoexist)
 	if (!pCoexSta->bPreCCKLock) {
 
 		if (nCCKLockCounter >= 5)
-		 pCoexSta->bCCKLock = true;
+			pCoexSta->bCCKLock = true;
 		else
-		 pCoexSta->bCCKLock = false;
+			pCoexSta->bCCKLock = false;
 	} else {
 		if (nCCKLockCounter == 0)
-		 pCoexSta->bCCKLock = false;
+			pCoexSta->bCCKLock = false;
 		else
-		 pCoexSta->bCCKLock = true;
+			pCoexSta->bCCKLock = true;
 	}
 
 	pCoexSta->bPreCCKLock =  pCoexSta->bCCKLock;
@@ -2084,9 +2084,9 @@ static void halbtc8723b1ant_RunCoexistMechanism(struct btc_coexist *pBtCoexist)
 		pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_ROAM, &bRoam);
 
 		if (bScan || bLink || bRoam) {
-			 if (bScan)
+			if (bScan)
 				halbtc8723b1ant_ActionWifiNotConnectedScan(pBtCoexist);
-			 else
+			else
 				halbtc8723b1ant_ActionWifiNotConnectedAssoAuth(pBtCoexist);
 		} else
 			halbtc8723b1ant_ActionWifiNotConnected(pBtCoexist);
-- 
2.25.1

