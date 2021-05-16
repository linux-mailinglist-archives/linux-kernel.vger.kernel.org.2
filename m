Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB6E381EC0
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 14:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbhEPMcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 08:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbhEPMb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 08:31:59 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3119C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 05:30:43 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id a11so1725679plh.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 05:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uEpsBQ7rbIhP4Lk4USk29pB1/Jh9hlfSvj6sx/s54ew=;
        b=CPh518p/r8+QMg9oy2zojCmiPG000e/X5GAIQdUmXiiAX8TKjTKiDsogH5MuYx2cSP
         +PrErEO5kTBoYRvO6TGrOFqB2IChBhkIKR4XY6wr3VIR4P2K+EzF3dQfOeBm0ijZ2lX+
         ZWHAU6fbSafvSd6UwtzzID1byTAP1kUGlUPyKsdMcw33seFgNKYnOfLdXo7i3wQFXWmw
         uo8AoyUDwoXdabsGyLpMfBq6bHHWKlXbZee+yNfpQ+LZDm3Lctr95jEutIAehzq3p7DC
         bP/YYiCXdPdn3zbS8ET5tTA0cgvn2K+lh0BFgpqepY4D60+KizWbw7etXQSMRTQKKL8r
         tjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uEpsBQ7rbIhP4Lk4USk29pB1/Jh9hlfSvj6sx/s54ew=;
        b=Kv83EwN8RhJFFl03Wgybn5cQwC59UNXe/kWoVU/S3Ck1IuYCOM0FY8mw4lP/ujwXNU
         XRoiW1+e3qwrVvE9VQBu3yl2xbL+8wA6i1YuE34zaNWTFbABsybVHUjdr4BZmnQOPZA/
         DOd0rNdQCtzfv0NO24tppYjSv7AIwqQcX80xxuzMaqjPDm5PCfBONfkzejWPz+7/bNHc
         c9gWlCh8LLDGyicMkqjBsXq1MwVARLNkAVH4d0G8hBMEVzU6DFYoOY2KYsDL4yphj8bB
         dAFWzoZ/uQRVFW51UQ3u7CuTLo3Tm0wfP/Ktib+sW6ofQ3ZTOku5dYd2hxy4aRhE9Q8v
         91yQ==
X-Gm-Message-State: AOAM532ez39q+OuHlD+l2xFuay8GjaFTJooNNDiqNcmPc7GcmUtcUUUF
        BzPCgGMkmwabWcSjqsdUYIo=
X-Google-Smtp-Source: ABdhPJxKi7aaoJ2oTE+wusMlkpoH9EasCm6Ge0iNmg9wM5wsjtnsjRUyHskEs5grSdg7Dqxer7lLGg==
X-Received: by 2002:a17:902:6ac6:b029:ee:e9ac:59f9 with SMTP id i6-20020a1709026ac6b02900eee9ac59f9mr55255447plt.58.1621168243305;
        Sun, 16 May 2021 05:30:43 -0700 (PDT)
Received: from localhost.localdomain ([111.223.96.126])
        by smtp.gmail.com with ESMTPSA id k186sm8004318pgk.82.2021.05.16.05.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 05:30:42 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     gregkh@linuxfoundation.org, marcocesati@gmail.com,
        dan.carpenter@oracle.com, fabioaiuto83@gmail.com,
        fmdefrancesco@gmail.com, eantoranz@gmail.com, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        skhan@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 3/7] Staging: rtl8723bs: fix indentation in HalBtc8723b1Ant.c
Date:   Sun, 16 May 2021 08:29:23 -0400
Message-Id: <20210516122927.1132356-4-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210516122927.1132356-1-desmondcheongzx@gmail.com>
References: <20210516122927.1132356-1-desmondcheongzx@gmail.com>
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

