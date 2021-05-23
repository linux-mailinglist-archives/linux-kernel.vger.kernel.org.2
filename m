Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D844B38DC3C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 19:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbhEWRrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 13:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbhEWRrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 13:47:20 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C34C061574
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 10:45:52 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id i13so29208326edb.9
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 10:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jfkC1uoHsvXviOGr7sUFuZ43nsQ29t7jlxfCG6pCO6M=;
        b=iqW4Lp7tzy9DYECYdus8Weyzx2+cCadoFDigFaqPLObtdNV1hRgbsnCl8he3z0OiX3
         WQXIhHljGMXwOa1+fH3OhYC4oON7TnJAfH4hA9SmG6Jgzz2r7914dZE0l6QIvbRUStVL
         xx2PUSun3B5wYe1VFx5aD1lg7bl9xxvBI4ZU/93wZUEEwJ71Yyw26gsSJoGrmEyDi5xx
         8ZlhPqkLR9Pl86Ph8oqKoVeQ+8uR5mUp4r7iUz6YPJQxFEG+ZboPPc/dBHo+YIv7Kl4J
         BvipRrCQAXeF8FNy8+vydu9ZyGUtEQl2R4k5y1squELJ7OKgFJpdt1WkujSN5yWh3P1N
         6LUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jfkC1uoHsvXviOGr7sUFuZ43nsQ29t7jlxfCG6pCO6M=;
        b=gitMXgAxqva8d1CjYpi2btrWWN0wgEPaQNiNFnw14QxNdfIjPObtHA/qJNs8gtrcMr
         FYnhE9Ref+yj9tOEyESCW6o2JFPZMrtOJyaFL52cnV84w1UGEdVOpipb9xQX3dN20fYK
         ZkSwgNfwpFegpwQDL7lxK1CY5/xIsYHcL3o8X08+vt26mP4bIzwdhtdzhmURYr3vbo3s
         vw/bTaLSSsG3ZKGyo1kuGQ3GMffgSKokRxJZf5ntQ5w2W5m8eTVa8+LemmLSyIqP8au2
         sn4XiV+qnZ6dj4WOaR5nUvnqJVRBsEnIPNsnxtN8nFZdz8NApGE9iQmOBtrE3NMzmIbL
         qVpQ==
X-Gm-Message-State: AOAM531T+yrmJXG004yzgyIJNdd0D+amHOJ6ewwPDXDJ/o2OmtqD6DcZ
        fcqcmek3pCX06Z0z1eAMl3Z6+on8fgLpWA==
X-Google-Smtp-Source: ABdhPJyHl2WTCgNJsQgxc4Gxs3dOOWqgdfxZvzEEywpggTuLBWtg2KHVdWhdrhTmqLkXhyyomRERbw==
X-Received: by 2002:a05:6402:30a2:: with SMTP id df2mr21207995edb.176.1621791951055;
        Sun, 23 May 2021 10:45:51 -0700 (PDT)
Received: from linux.local (host-79-52-107-152.retail.telecomitalia.it. [79.52.107.152])
        by smtp.gmail.com with ESMTPSA id md21sm6817627ejb.110.2021.05.23.10.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 10:45:50 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] staging: rtl8723bs: hal: Remove set but unused variables
Date:   Sun, 23 May 2021 19:45:47 +0200
Message-Id: <20210523174547.20646-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed set but unused variables. Issue detected by GCC running with
the warning option -Wunused-but-set-variable. Removed the storage of
the values returned but left the reads because it is possible
that removing them can prevent the hardware from working properly.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
index 518d5354bda4..adfdc4f14b08 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
+++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
@@ -2706,9 +2706,6 @@ void EXhalbtc8723b1ant_ScanNotify(struct btc_coexist *pBtCoexist, u8 type)
 	bool bBtCtrlAggBufSize = false;
 	u8 aggBufSize = 5;
 
-	u8 u1Tmpa, u1Tmpb;
-	u32 u4Tmp;
-
 	if (pBtCoexist->bManualControl || pBtCoexist->bStopCoexDm)
 		return;
 
@@ -2716,9 +2713,9 @@ void EXhalbtc8723b1ant_ScanNotify(struct btc_coexist *pBtCoexist, u8 type)
 		pCoexSta->bWiFiIsHighPriTask = true;
 
 		halbtc8723b1ant_PsTdma(pBtCoexist, FORCE_EXEC, false, 8);  /* Force antenna setup for no scan result issue */
-		u4Tmp = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x948);
-		u1Tmpa = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x765);
-		u1Tmpb = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x67);
+		pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x948);
+		pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x765);
+		pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x67);
 	} else {
 		pCoexSta->bWiFiIsHighPriTask = false;
 
-- 
2.31.1

