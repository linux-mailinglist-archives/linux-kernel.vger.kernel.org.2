Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8B5413AFC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 21:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbhIUTtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 15:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbhIUTs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 15:48:58 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2B9C061575
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 12:47:29 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id u15so94112wru.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 12:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2RaM47LQV/52zCwJbo6eQ5bF3wcnrcfvMA50DonDyK4=;
        b=ej000TeqDup/ftYW2AuyCmJ8s6WSebMHaayLl8PlnljWS7zEg61INQRtdAhtkYhc6v
         Qgi85ZPgF6Z+pUxbw6Ndckq3X4oEesCZlRYEdM8Jc8AzEfiV7/XeR+IO97mtO1NSdtzP
         6c+265fp431tnLzDbYVxORWS9nqeDkZo2X1RB8SNE2asSvHgD1pxjSNz/NdUAWxg2IaB
         3fJq++O9Y6zkyYWt++/ilOlHjb8mo1AnGNxXk3tCaQM0nIQz8QA9uZKWkFMBMueH2FXL
         gD95gOm3ri1MGo0ZPuzAQBogYBMlPdzUZbilzY6mRnKpKJE8hhx3FcVohUhYmpxTo94F
         6B6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2RaM47LQV/52zCwJbo6eQ5bF3wcnrcfvMA50DonDyK4=;
        b=vL1xEpA7imjNcqNeMoP4rChCBce9RNRW2pOgRNwHJWTzCFUwE3OYSU0YDNOr1J3FKr
         t1yAWf/W8reZkENw/WcDQxYbOfca6UxGup9+UNd/zYRfXfOaCmON7XBRiohDJbYE3EhE
         6wggg/U4HozmzisKcX5J2OhWQ5k4E1ndGY3bqC+3pzhmkcSaRbJSWPTH3RQYBGjg36js
         3O2tR6YAgR0e6YobMDmQdi7kjCqpn2Nk7TQ4YTPRi5j9iRW/H40nSAHSo8PxQXZt/Ztx
         XgaZ6BgYkGa98hYAAfAwonQRYsHVb3w3Yp2SSAzNxsEeHk89mzwHA9b+rVAG/Vas34K8
         S4iQ==
X-Gm-Message-State: AOAM533hLxH0ymj1xDy7axL3Rni75mstRpZpd33tnORsRmvC8IAvnTNK
        CCX0KbxRswBMtPGREqX5Wbk=
X-Google-Smtp-Source: ABdhPJzPVvFgtxyqIiZiZ/za41vJfFYBca9/ZAdkR2dfj12JEDXSMf639O0Pf2MxQSSBshWEPfahhQ==
X-Received: by 2002:a05:6000:18ab:: with SMTP id b11mr25443620wri.131.1632253648332;
        Tue, 21 Sep 2021 12:47:28 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id s13sm3891243wmc.47.2021.09.21.12.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 12:47:27 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 7/8] staging: r8188eu: remove DynamicTxHighPowerLvl from struct dm_priv
Date:   Tue, 21 Sep 2021 21:46:57 +0200
Message-Id: <20210921194658.10654-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210921194658.10654-1-straube.linux@gmail.com>
References: <20210921194658.10654-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field DynamicTxHighPowerLvl of struct dm_priv is set but never
used. Remove it and remove now unused variables from
odm_DynamicTxPowerInit().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c             | 4 ----
 drivers/staging/r8188eu/include/rtl8188e_dm.h | 3 ---
 2 files changed, 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 555060bdfdd9..87f0ea84819a 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -1180,10 +1180,6 @@ bool ODM_RAStateCheck(struct odm_dm_struct *pDM_Odm, s32 RSSI, bool bForceUpdate
 
 void odm_DynamicTxPowerInit(struct odm_dm_struct *pDM_Odm)
 {
-	struct adapter *Adapter = pDM_Odm->Adapter;
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(Adapter);
-	struct dm_priv	*pdmpriv = &pHalData->dmpriv;
-	pdmpriv->DynamicTxHighPowerLvl = TxHighPwrLevel_Normal;
 }
 
 /* 3============================================================ */
diff --git a/drivers/staging/r8188eu/include/rtl8188e_dm.h b/drivers/staging/r8188eu/include/rtl8188e_dm.h
index bfe300730c16..a4399b119a74 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_dm.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_dm.h
@@ -27,9 +27,6 @@ struct	dm_priv {
 	int	EntryMaxUndecoratedSmoothedPWDB;
 	int	MinUndecoratedPWDBForDM;
 	int	LastMinUndecoratedPWDBForDM;
-
-	/* for High Power */
-	u8 DynamicTxHighPowerLvl;/* Tx Power Control for Near/Far Range */
 };
 
 void rtl8188e_init_dm_priv(struct adapter *adapt);
-- 
2.33.0

