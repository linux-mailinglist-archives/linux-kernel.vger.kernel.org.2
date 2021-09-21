Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA7F413AF8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 21:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbhIUTs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 15:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbhIUTsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 15:48:54 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EADC061757
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 12:47:25 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t8so144887wrq.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 12:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MdVxaNtvGER8omnGE7pPYp9QywtUqFSyvheRb5loYHk=;
        b=cYtAf/zFXKrW/Xkrd/8L1tQXJUXCXh2/7veJwgqqACknRANvsWbqtzhYMz0gAnUkNi
         tiQzOdXbxRIMsUmVawztc9Wg3y0VsAavXWvMUbf41JhnAhQ7NgR3BO1+gbnfI1k7kWO3
         Y4OQNQ8bWOTfar7WLaRMGOgTU0+TULKgFTFHZOS6/QwVzv7+vAbqchuhUEI+WEjAr1nG
         zy2AVHpxhQ5PTUnJIgN0rT1W+frvywAzSyGH5tkHHY17PWIF3uplraWYTf5WT0MPEAB0
         KmVseIeDTAyBOaiMnR1NmeZCdtRnrXBgF2uj/hUZcB9h5iHweWgKQYuYW8DCJZgntl17
         ITIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MdVxaNtvGER8omnGE7pPYp9QywtUqFSyvheRb5loYHk=;
        b=xqn+UVD039ooQFwgJcQxP2Q2J1lRXXh9iYW4+1gvTxG6+qv2x4YEmGBqXi7b4hwIYQ
         cOxqZO4nu6joVVsqUPvOAKM+aVVVd5Nu7t2/S+OkU4/qZYgOIq65T0WW1GUKxXmjxe4N
         kHIYSA9fsiEx8elksLPaMZjE2OVe8KdUmE+Xfekk61ZHGPhurG58j1W51JY5mQmjA/Ka
         PItQbO2CAIDEbAJY7lYpKwxDAUvXv/o7m4uGhIV/BR8rI+LyFWunYlEDrisc6PPyPqG9
         U8p+lCZeUj8mm8itvfFxJSGNO7wFfSpWFUngEpYsp4x1J7hiNK7BmMFaVZuY8LZpStnh
         7PMA==
X-Gm-Message-State: AOAM531O1fOmZInPwDcVWw73hd7p/1Wz2mRsKXQPG4a8Kt4bXT6LBPqK
        SN80+Swwci9SXj0FpiXo+e4=
X-Google-Smtp-Source: ABdhPJzNh2rY81R+jcDnUOjFGii6pcq8EzqDLmi6Yruz93Hpu1/j201QsFKjgeu2Mqzkgc8zt8II6A==
X-Received: by 2002:a5d:55cf:: with SMTP id i15mr36111668wrw.224.1632253644046;
        Tue, 21 Sep 2021 12:47:24 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id s13sm3891243wmc.47.2021.09.21.12.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 12:47:23 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/8] staging: r8188eu: remove odm_DynamicTxPower()
Date:   Tue, 21 Sep 2021 21:46:53 +0200
Message-Id: <20210921194658.10654-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210921194658.10654-1-straube.linux@gmail.com>
References: <20210921194658.10654-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function odm_DynamicTxPower() does nothing, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c             | 27 -------------------
 drivers/staging/r8188eu/include/odm_precomp.h |  1 -
 2 files changed, 28 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index e39c79db7667..c691a6a90fa9 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -216,7 +216,6 @@ void ODM_DMWatchdog(struct odm_dm_struct *pDM_Odm)
 
 	ODM_TXPowerTrackingCheck(pDM_Odm);
 	odm_EdcaTurboCheck(pDM_Odm);
-	odm_DynamicTxPower(pDM_Odm);
 
 	odm_dtc(pDM_Odm);
 }
@@ -1189,32 +1188,6 @@ void odm_DynamicTxPowerInit(struct odm_dm_struct *pDM_Odm)
 	pdmpriv->DynamicTxHighPowerLvl = TxHighPwrLevel_Normal;
 }
 
-void odm_DynamicTxPower(struct odm_dm_struct *pDM_Odm)
-{
-	/*  For AP/ADSL use struct rtl8192cd_priv * */
-	/*  For CE/NIC use struct adapter * */
-
-	if (!(pDM_Odm->SupportAbility & ODM_BB_DYNAMIC_TXPWR))
-		return;
-
-	/*  2012/01/12 MH According to Luke's suggestion, only high power will support the feature. */
-	if (!pDM_Odm->ExtPA)
-		return;
-
-	/*  2011/09/29 MH In HW integration first stage, we provide 4 different handle to operate */
-	/*  at the same time. In the stage2/3, we need to prive universal interface and merge all */
-	/*  HW dynamic mechanism. */
-	switch	(pDM_Odm->SupportPlatform) {
-	case	ODM_MP:
-	case	ODM_CE:
-		break;
-	case	ODM_AP:
-		break;
-	case	ODM_ADSL:
-		break;
-	}
-}
-
 /* 3============================================================ */
 /* 3 RSSI Monitor */
 /* 3============================================================ */
diff --git a/drivers/staging/r8188eu/include/odm_precomp.h b/drivers/staging/r8188eu/include/odm_precomp.h
index 1d6e93b13d7d..43f8e6849a45 100644
--- a/drivers/staging/r8188eu/include/odm_precomp.h
+++ b/drivers/staging/r8188eu/include/odm_precomp.h
@@ -49,7 +49,6 @@ void odm_RefreshRateAdaptiveMaskMP(struct odm_dm_struct *pDM_Odm);
 void odm_DynamicBBPowerSaving(struct odm_dm_struct *pDM_Odm);
 void odm_SwAntDivChkAntSwitch(struct odm_dm_struct *pDM_Odm, u8 Step);
 void odm_EdcaTurboCheck(struct odm_dm_struct *pDM_Odm);
-void odm_DynamicTxPower(struct odm_dm_struct *pDM_Odm);
 void odm_CommonInfoSelfInit(struct odm_dm_struct *pDM_Odm);
 void odm_SwAntDivInit(struct odm_dm_struct *pDM_Odm);
 void odm_RSSIMonitorCheck(struct odm_dm_struct *pDM_Odm);
-- 
2.33.0

