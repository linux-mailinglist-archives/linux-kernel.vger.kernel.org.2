Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73F23DB769
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 12:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238574AbhG3Kvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 06:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238543AbhG3Kvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 06:51:32 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BC2C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 03:51:26 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id l19so14666498pjz.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 03:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=workware-net-au.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eUV5nhL5QABYzSLeXK88oyatwPt6Dns+LgdiyB39L3A=;
        b=JZz7/1b+6xO0d2CXQG2M+4cqJ/Df/EaCm1OGhxdaEj18vuefNVknh1SNs0uM9IIQ1i
         FCOSX6qfWJlq4ulzWt1KYJD9WrX0NBhfOPddV2jVOeen+CzqF9fOT89JZnrENmZZVHTw
         nuv2iSXmoj9DLQYSXfdE88l/mYcUtJaUMes6yMge2xwaO42UO+IUAcwmg/YYaAemMLE4
         1AFCSGVNGiavdbaR/olnHFCaQ0QgZzBduEubTJ/Qly8CGKPI7DKHFyZE0uT4gpR1Rlzy
         o3/FDtU45gek7w5gwopj2fpYRPlN4Sa7pzzdxPCTguiNfcOMUhMcMt8r173SiJqa9eZt
         UmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eUV5nhL5QABYzSLeXK88oyatwPt6Dns+LgdiyB39L3A=;
        b=BTVOsVDAfRLWGIhYcXaiQH7tgrITQhuNiA7ZCVEfV2ZX3j7XB1Za4GVkO5x3ABWZog
         A1/TJzgS71KyL3L/AjMIeG8g8fKMbWaxbrehmfkzJVLepfFcU3PiLuazWjMBCfLjH6co
         C+IaP7qkAxpdVCrjkHiNlB1sz6KWqkeVAwigYxZ6/fzvp1QT/t0NGF5CvmjhnxCRQrhE
         fJg3cGvBD4Fgd8zgXv2tE1wjmSXfbgp44vWHoGaoTA/X9mujFlD3StvG3v+GlmqlnsyI
         FYweWRRWO0EZ4Uhp/vw/sAGWz500BFxr70LPc92OWQSMjap0WbJSY0AGzUHcIWwZ8Tqt
         lCkA==
X-Gm-Message-State: AOAM532nAmCcKLmt4j+CXWT14X6UOweawFCsuEFnOVpWaQLIn1Go57B/
        XCSyjkCJ5HxkG6/q+AuCaFMjdA==
X-Google-Smtp-Source: ABdhPJzwNCu1Uf2wgff23wJkV6LR2TaRS0u1Vu6IM9EMm8XredlJFm4xRDD2CB3QXTUjlKr7yVUv4w==
X-Received: by 2002:a17:902:c202:b029:12c:9970:bdf9 with SMTP id 2-20020a170902c202b029012c9970bdf9mr94247pll.30.1627642286219;
        Fri, 30 Jul 2021 03:51:26 -0700 (PDT)
Received: from workware.net.au (117-20-69-228.751445.bne.nbn.aussiebb.net. [117.20.69.228])
        by smtp.gmail.com with ESMTPSA id h14sm1922347pfo.47.2021.07.30.03.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 03:51:25 -0700 (PDT)
From:   Steve Bennett <steveb@workware.net.au>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Steve Bennett <steveb@workware.net.au>
Subject: [PATCH] net: phy: micrel: Fix detection of ksz87xx switch
Date:   Fri, 30 Jul 2021 20:51:20 +1000
Message-Id: <20210730105120.93743-1-steveb@workware.net.au>
X-Mailer: git-send-email 2.24.2 (Apple Git-127)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous logic was wrong such that the ksz87xx
switch was not identified correctly.

Signed-off-by: Steve Bennett <steveb@workware.net.au>
---
 drivers/net/phy/micrel.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 4d53886f7d51..a4acec02c8cb 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -401,11 +401,11 @@ static int ksz8041_config_aneg(struct phy_device *phydev)
 }
 
 static int ksz8051_ksz8795_match_phy_device(struct phy_device *phydev,
-					    const u32 ksz_phy_id)
+					    const u32 ksz_8051)
 {
 	int ret;
 
-	if ((phydev->phy_id & MICREL_PHY_ID_MASK) != ksz_phy_id)
+	if ((phydev->phy_id & MICREL_PHY_ID_MASK) != PHY_ID_KSZ8051)
 		return 0;
 
 	ret = phy_read(phydev, MII_BMSR);
@@ -418,7 +418,7 @@ static int ksz8051_ksz8795_match_phy_device(struct phy_device *phydev,
 	 * the switch does not.
 	 */
 	ret &= BMSR_ERCAP;
-	if (ksz_phy_id == PHY_ID_KSZ8051)
+	if (ksz_8051)
 		return ret;
 	else
 		return !ret;
@@ -426,7 +426,7 @@ static int ksz8051_ksz8795_match_phy_device(struct phy_device *phydev,
 
 static int ksz8051_match_phy_device(struct phy_device *phydev)
 {
-	return ksz8051_ksz8795_match_phy_device(phydev, PHY_ID_KSZ8051);
+	return ksz8051_ksz8795_match_phy_device(phydev, 1);
 }
 
 static int ksz8081_config_init(struct phy_device *phydev)
@@ -535,7 +535,7 @@ static int ksz8061_config_init(struct phy_device *phydev)
 
 static int ksz8795_match_phy_device(struct phy_device *phydev)
 {
-	return ksz8051_ksz8795_match_phy_device(phydev, PHY_ID_KSZ87XX);
+	return ksz8051_ksz8795_match_phy_device(phydev, 0);
 }
 
 static int ksz9021_load_values_from_of(struct phy_device *phydev,
-- 
2.24.2 (Apple Git-127)

