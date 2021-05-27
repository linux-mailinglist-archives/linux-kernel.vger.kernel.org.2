Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5E9393655
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 21:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbhE0Tfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 15:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235341AbhE0Tff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 15:35:35 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728A7C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 12:34:02 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id m124so682842pgm.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 12:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=URynco1M9J1CS+xfeICx2Aic9FrXa16sZQX08FVwppI=;
        b=JWbp66autvivqvE6xXnUM0mrSHamWBlfCoWy1ZWALj8VvW28WyM4tOz9rD6Y2fn6mo
         /oyZGbXmTh/osJD4yS8R/bJPNtVCB2fh7Y3x1mx6DyPm6KaanPvqp5TbRN5CiTLDrzN6
         OkGmPaOpcJl0Qi0zelOJkqfUm26+PNgv66hjyoIfYfqJWbheVsudGZq5FG7FWv07+fjb
         DvytOQ0MZag+Z7ghIgGS1PavZhi99FRB/mE07FrmnefM7tUcEvLPplRLjbzLGZmoH/S7
         GLvYfNxr0eQw8tCUESt5VdSmJZ5rr8eOgCMoCDVuBOIFMnzkgI4pSCU4MdCvc1le2VaL
         zwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=URynco1M9J1CS+xfeICx2Aic9FrXa16sZQX08FVwppI=;
        b=A3ausqxOCNrXouTvJBO1Vu0CjNI9FDOQqOXy1DYD2UwXBKpwpYdmkVMYfEn3EXsmbR
         OpiA/Seb3NqhODKKMuKfol6JXyYrC4sD0WN60x+t3fo/UcykTeo/TJ9Sb/8mGL8uQnMJ
         N7KxbzIbGbo4qPIu9hBdjUWCiGTowWiAtahly/vbupcaL8ocSqAqa6i70U+67ME3yBy8
         wcMP82/0VsmpN8Z+qhsuCvE6t7kkG4umuJKZxSDgln4dlwoNld6zw2RhlX5p1TnrbZc8
         XeWJAy/kQYaceWv0pH27PzNQJIzD+RNWyu70B+VgeYQOCsixTWzqFQKfVE4e3TmPerJP
         LTfg==
X-Gm-Message-State: AOAM531zxUXEjOzSpcji+U2IPkOQWTB2PWDcLy/A4bpbaA+zbzyVmWHV
        yvPoAd4wsiCuE8C0na5E/+g=
X-Google-Smtp-Source: ABdhPJz+sXAlNDFgt9lhiOhSziH4x+rRM+NKppPo928SUPKY+IkClmNYEWstUNHj1eJ2L2PCXYdb0g==
X-Received: by 2002:a63:cc11:: with SMTP id x17mr5165595pgf.159.1622144041765;
        Thu, 27 May 2021 12:34:01 -0700 (PDT)
Received: from nhaiderx-mobl1.gar.corp.intel.com ([2409:4063:2381:b5a9:2c37:cdf5:a1b0:c566])
        by smtp.gmail.com with ESMTPSA id w123sm2475357pfb.109.2021.05.27.12.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 12:34:01 -0700 (PDT)
From:   nizamhaider786@gmail.com
To:     laforge@gnumonks.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Nijam Haider <nizamhaider786@gmail.com>
Subject: [PATCH V3 1/2] char: pcmcia: cm4000_cs: Fix failure handling
Date:   Fri, 28 May 2021 01:03:50 +0530
Message-Id: <20210527193351.638-1-nizamhaider786@gmail.com>
X-Mailer: git-send-email 2.31.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nijam Haider <nizamhaider786@gmail.com>

Handled failure cases of device_create()

Signed-off-by: Nijam Haider <nizamhaider786@gmail.com>
---
V2 -> V3: Added label and moved the cleanup code
V1 -> V2: Added description and changelog
---
 drivers/char/pcmcia/cm4000_cs.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/char/pcmcia/cm4000_cs.c b/drivers/char/pcmcia/cm4000_cs.c
index 89681f07bc78..e4a79866fbf3 100644
--- a/drivers/char/pcmcia/cm4000_cs.c
+++ b/drivers/char/pcmcia/cm4000_cs.c
@@ -1783,6 +1783,7 @@ static int cm4000_probe(struct pcmcia_device *link)
 {
 	struct cm4000_dev *dev;
 	int i, ret;
+	struct device *dev_ret;
 
 	for (i = 0; i < CM4000_MAX_DEV; i++)
 		if (dev_table[i] == NULL)
@@ -1808,15 +1809,22 @@ static int cm4000_probe(struct pcmcia_device *link)
 	init_waitqueue_head(&dev->readq);
 
 	ret = cm4000_config(link, i);
-	if (ret) {
-		dev_table[i] = NULL;
-		kfree(dev);
-		return ret;
-	}
-
-	device_create(cmm_class, NULL, MKDEV(major, i), NULL, "cmm%d", i);
+	if (ret)
+		goto err_config;
 
+	dev_ret = device_create(cmm_class, NULL, MKDEV(major, i), NULL, "cmm%d", i);
+	if (IS_ERR(dev_ret)) {
+		dev_err(&link->dev, "device_create failed for %d\n", i);
+		goto err_device_create;
+	}
 	return 0;
+
+err_device_create:
+	cm4000_release(link);
+err_config:
+	dev_table[i] = NULL;
+	kfree(dev);
+	return -ENODEV;
 }
 
 static void cm4000_detach(struct pcmcia_device *link)
-- 
2.17.1

