Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7683AFBFD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 06:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhFVEf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 00:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhFVEf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 00:35:56 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E87EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 21:33:40 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a127so4874559pfa.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 21:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TL1C4ayL5XZ2hPx9/5foLLPjQJdcMChbly2YuYC6wmU=;
        b=mit5VIVB6sgI8q2HtYGkyGWd3ZA0qRBsF3N+eCUB1pSzfrAJ4fqwp/EaUbcEIb1lKI
         Ym+PxS7BVKXoqGU1GIaOO+gVByg8pAk9+8iBbqM+nz0mCNWsn98krIEf9Tl1r/NmR8j6
         i7K3nSWNJCJXmwgqHP663P/oKRGdNqKdWYcFvPXhtCUFFu+VpRD6wto0kBYMoGW0U1QW
         4LDHW9eaewW3KLFM9brQwkm3Zy/DaDujqvVwtKTwONlmcPclifXAut1t32VHoTRbIYQ9
         TJQ7FtsghOnIiOGdBsioNpLayLF3zt/0srbhDK9SRr2GA9AbNOOm8FTUkmLNzyQ8TtVg
         2rXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TL1C4ayL5XZ2hPx9/5foLLPjQJdcMChbly2YuYC6wmU=;
        b=JLr6l0yy22SMtEfhKhbzXX6CSk2zm8EtRbHb6zoI5uOg9XaQwrkZsIOzELKQ3eYi/A
         UEqXenA7HWvmWuOjX0pTJtgeJ1n/v2P1IFWN7WrH7ArZ3Zaq4/J27gzoG9Y4rZ6Vn06X
         hvxDv9qvK9K9DFGQ9zMB+UouXq+PvAbhiH/NjLuq+McEV0FlKBmcd01X9Vfd9IcepAM1
         EngfZAHBeF3DFx3irbGqyjuMO6k2UKhC8lKuEc73GLnTj9M3LNR7yZOXgv9CLhKHtto5
         hFfU56QHOi2fGVRXhchlpkHWTxYcB/hH2flc9a79eEA2uyXmH878t2AbADLCl0BibBRE
         raoQ==
X-Gm-Message-State: AOAM5300YMg+fdBZMmBXwkMocCRk95CLw8UvEmgL20OWdmxVlEH8EjoB
        vDOvyfmSbypY4W9PLkr2T0u4HA==
X-Google-Smtp-Source: ABdhPJziBb5xg1tnlSfTCT8915h69yzvhqm+QdBQZrNq2iz/h0eBqAJAP5d8LvY3PMFEE8aeYoYj/Q==
X-Received: by 2002:aa7:99db:0:b029:301:ef28:cdf9 with SMTP id v27-20020aa799db0000b0290301ef28cdf9mr1715117pfi.11.1624336419505;
        Mon, 21 Jun 2021 21:33:39 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id em14sm724299pjb.25.2021.06.21.21.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 21:33:39 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: hi6421v600: Fix setting wrong driver_data
Date:   Tue, 22 Jun 2021 12:33:29 +0800
Message-Id: <20210622043329.392072-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current code set "config.driver_data = sreg" but sreg only init the mutex,
the othere fields are just zero. Fix it by pass *info to config.driver_data
so each regulator can get corresponding data by rdev_get_drvdata().

Separate enable_mutex from struct hi6421_spmi_reg_info since only need one
mutex for the driver.

Fixes: d2dfd50a0b57 ("staging: hikey9xx: hi6421v600-regulator: move LDO config from DT")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/hi6421v600-regulator.c | 26 ++++++++++++++----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/hi6421v600-regulator.c b/drivers/regulator/hi6421v600-regulator.c
index b5a19938fd3a..21153ee03a3f 100644
--- a/drivers/regulator/hi6421v600-regulator.c
+++ b/drivers/regulator/hi6421v600-regulator.c
@@ -16,13 +16,15 @@
 #include <linux/regulator/driver.h>
 #include <linux/spmi.h>
 
+struct hi6421_spmi_reg_priv {
+	/* Serialize regulator enable logic */
+	struct mutex enable_mutex;
+};
+
 struct hi6421_spmi_reg_info {
 	struct regulator_desc	desc;
 	u8			eco_mode_mask;
 	u32			eco_uA;
-
-	/* Serialize regulator enable logic */
-	struct mutex enable_mutex;
 };
 
 static const unsigned int ldo3_voltages[] = {
@@ -96,11 +98,12 @@ static const unsigned int ldo34_voltages[] = {
 
 static int hi6421_spmi_regulator_enable(struct regulator_dev *rdev)
 {
-	struct hi6421_spmi_reg_info *sreg = rdev_get_drvdata(rdev);
+	struct hi6421_spmi_reg_priv *priv;
 	int ret;
 
+	priv = dev_get_drvdata(rdev->dev.parent);
 	/* cannot enable more than one regulator at one time */
-	mutex_lock(&sreg->enable_mutex);
+	mutex_lock(&priv->enable_mutex);
 
 	ret = regmap_update_bits(rdev->regmap, rdev->desc->enable_reg,
 				 rdev->desc->enable_mask,
@@ -109,7 +112,7 @@ static int hi6421_spmi_regulator_enable(struct regulator_dev *rdev)
 	/* Avoid powering up multiple devices at the same time */
 	usleep_range(rdev->desc->off_on_delay, rdev->desc->off_on_delay + 60);
 
-	mutex_unlock(&sreg->enable_mutex);
+	mutex_unlock(&priv->enable_mutex);
 
 	return ret;
 }
@@ -225,7 +228,7 @@ static int hi6421_spmi_regulator_probe(struct platform_device *pdev)
 {
 	struct device *pmic_dev = pdev->dev.parent;
 	struct regulator_config config = { };
-	struct hi6421_spmi_reg_info *sreg;
+	struct hi6421_spmi_reg_priv *priv;
 	struct hi6421_spmi_reg_info *info;
 	struct device *dev = &pdev->dev;
 	struct hi6421_spmi_pmic *pmic;
@@ -241,17 +244,18 @@ static int hi6421_spmi_regulator_probe(struct platform_device *pdev)
 	if (WARN_ON(!pmic))
 		return -ENODEV;
 
-	sreg = devm_kzalloc(dev, sizeof(*sreg), GFP_KERNEL);
-	if (!sreg)
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
 		return -ENOMEM;
 
-	mutex_init(&sreg->enable_mutex);
+	mutex_init(&priv->enable_mutex);
+	platform_set_drvdata(pdev, priv);
 
 	for (i = 0; i < ARRAY_SIZE(regulator_info); i++) {
 		info = &regulator_info[i];
 
 		config.dev = pdev->dev.parent;
-		config.driver_data = sreg;
+		config.driver_data = info;
 		config.regmap = pmic->regmap;
 
 		rdev = devm_regulator_register(dev, &info->desc, &config);
-- 
2.25.1

