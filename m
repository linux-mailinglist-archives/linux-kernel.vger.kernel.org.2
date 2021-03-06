Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7028032FDFA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 00:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhCFXXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 18:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhCFXWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 18:22:36 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D99DC06174A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 15:22:36 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id e7so13068901lft.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Mar 2021 15:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PU+EgNhAp2fLCw1jyVh/GbMDR5z8PSYByiH6xTF5I/s=;
        b=sdC1FYh4WgeWKZZTC/uajdFBkvkOf6/BahLm3r2+4Q9c2cj30t1410Y5+7nWoj8P4U
         AfWe4D9U1eDHzjLT59jFwtF4AySv0fpRJiACfZagUHcHWypg24+UbFBEEWTCHMzmv5xc
         vYUZQZMcQqmrto72S18c36FSV+e6luzrtvvYAF/1e9MKoMfrxt4x8gKxiVq2kVWRpz0q
         OytlxpqIp7uPzNA/ziGqcimVuabDpEUNwUhwsltHRh2ZrVGznM/gGiyhE+46cKt4D6zZ
         Hxn6rmzmE2Zy9YfCv3U7NdAq5lA/H8C527Yuks2GxoRhOyUT487wmgMDiMEnpj62Qknw
         ssqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PU+EgNhAp2fLCw1jyVh/GbMDR5z8PSYByiH6xTF5I/s=;
        b=aWIDSI5e1xcTl1YssSowa6ViSLNyp10lEzcyP6T0SVFVPwbMu25437NRePuK1p3t+l
         SJ9BoOuVTV7ZkbgDuTYsLPmL86xTsJgYlxqAWvuGIPbC/tAYbiF9i/2iQUgE+HXxXg7s
         Jo461MfsW0Zc+65m2/EAFPRz0hjGAbpEAblJ3UQckIhOVOe4giJAZ+2Ng95GAQefSR9V
         oCoHX5HPDAvG94Q8RmCE8Qrj8NgDDBL5BIP3gIfPLP8zdEypl77jhH9B6rZjLqT0sYh1
         MMH8IXOi/Xd5xKV3UmJPGxbfoAUaZPpyORksMsyFwuMWcNtpUdB2kEaapyVOOCt/DZb+
         TJeg==
X-Gm-Message-State: AOAM532SHn1LKF5/YPHLjcURU2MQJwhIkhenkAFO/slahmwQG5kQ9QPx
        fQrK94oXq+mM/INjKU+OgiDQCFDaKjFl6ASU
X-Google-Smtp-Source: ABdhPJxIBAQzYpl0jLme35Ue6Ik5wKaO7cW1I4s3ad7FLUN2v2KGs3Zv+GqXRIDBuGKoxTExOct5hQ==
X-Received: by 2002:a19:86c3:: with SMTP id i186mr9542579lfd.434.1615072949074;
        Sat, 06 Mar 2021 15:22:29 -0800 (PST)
Received: from localhost.localdomain (c-d7cb225c.014-348-6c756e10.bbcust.telenor.se. [92.34.203.215])
        by smtp.gmail.com with ESMTPSA id v129sm801452lfa.43.2021.03.06.15.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 15:22:28 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] mfd: ab8500: Drop bm disable parameter
Date:   Sun,  7 Mar 2021 00:22:27 +0100
Message-Id: <20210306232227.2401176-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nobody is passing the module parameter to disable the
battery management portions so just drop this parameter.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Rebased on v5.12-rc, seems to have been missed for v5.12
  merge window.
---
 drivers/mfd/ab8500-core.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index a9037911162b..db72d27070d9 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -121,12 +121,6 @@
 static DEFINE_SPINLOCK(on_stat_lock);
 static u8 turn_on_stat_mask = 0xFF;
 static u8 turn_on_stat_set;
-static bool no_bm; /* No battery management */
-/*
- * not really modular, but the easiest way to keep compat with existing
- * bootargs behaviour is to continue using module_param here.
- */
-module_param(no_bm, bool, S_IRUGO);
 
 #define AB9540_MODEM_CTRL2_REG			0x23
 #define AB9540_MODEM_CTRL2_SWDBBRSTN_BIT	BIT(2)
@@ -1255,14 +1249,12 @@ static int ab8500_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (!no_bm) {
-		/* Add battery management devices */
-		ret = mfd_add_devices(ab8500->dev, 0, ab8500_bm_devs,
-				      ARRAY_SIZE(ab8500_bm_devs), NULL,
-				      0, ab8500->domain);
-		if (ret)
-			dev_err(ab8500->dev, "error adding bm devices\n");
-	}
+	/* Add battery management devices */
+	ret = mfd_add_devices(ab8500->dev, 0, ab8500_bm_devs,
+			      ARRAY_SIZE(ab8500_bm_devs), NULL,
+			      0, ab8500->domain);
+	if (ret)
+		dev_err(ab8500->dev, "error adding bm devices\n");
 
 	if (((is_ab8505(ab8500) || is_ab9540(ab8500)) &&
 			ab8500->chip_id >= AB8500_CUT2P0) || is_ab8540(ab8500))
-- 
2.29.2

