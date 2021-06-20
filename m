Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E00B3ADE78
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 15:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbhFTNaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 09:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhFTNaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 09:30:12 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1583C061574
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 06:27:59 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id q192so5030525pfc.7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 06:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N6uZq36dS/oX68jn9X3RcGurTAGP6qc6OesnlzNrU9k=;
        b=sEbNwPawciQa0LFw8A53gbFhPv/WpzYkomMk7eN1FV9AgJdK4nkkqk4Ev2APevmHzM
         OB9uDQXI/1TKovII/gnCO8EPzSwV9SStStv4dnMPaqmvhjWrEG09Wzwnnp6SXJIf+5Ly
         vxFCHLIrdmxqL2wXIaSZBAuCjemMH72EoDFApS5F8KNlbg2Sf+F05891NWVj040uLBSv
         u+3so56qrRqJsgHw4OGLQfPa1ZCFolbZaIAQtOIxMEhBL27G9zfdUtZn1t5soYjjddjn
         TvbZ8n+G+j950rixf6fZS6HhLdH2H5uUDDVRigEIoz9kE4ZOgrDn069Gj//PIAKzecJj
         lc/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N6uZq36dS/oX68jn9X3RcGurTAGP6qc6OesnlzNrU9k=;
        b=HTP33VVMTeHbk9SUxLS8T0Tqdm6Jr2/hJAHyK8pi+8m0RHLhgZz/eDDO5R9hAowCMy
         GOxz3L5dDdpnIlGLlxWgxYsUUm2mVik+4AQ5uXDn2WZtMdzCluFeJ7Wl6ICxenTtXXfr
         +BrrvIoK+QVCq4iVppwmZlhRgGCrMCyt6HygtUbX7Z85dfmpM9gME4e0OomyEXfNR5HB
         pPWGD5LD32PV65+kk+Y8C/fHWf5darSJOQIhBtlI0LLpag5hD4EgSyn+awGKeomGlG4n
         plA9/bPgxMGnjrOxRoWJxCDhFGMjUfF8kfjHNlGL+Vo8/4+TSKDrNHKU9qbYP6wK0GBk
         KEjQ==
X-Gm-Message-State: AOAM533Bd8lvw3+g+DoApmYVPlIAAN5psngyxvsXY25+e0JkjKyVrEu0
        POpwO9o0BIh403k/0U667kVEzIXH7WL5QW9r
X-Google-Smtp-Source: ABdhPJz5XnfVNM/CP4k6eR/KT53EdagrKipAkXyTK2YDOz6SuFI/D4QNVYfIZzBo3GB1EWKG3GEgjw==
X-Received: by 2002:a63:f557:: with SMTP id e23mr19218401pgk.55.1624195679227;
        Sun, 20 Jun 2021 06:27:59 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id x5sm1625883pff.37.2021.06.20.06.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 06:27:58 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        Hao Fang <fanghao11@huawei.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: hi655x: Fix pass wrong pointer to config.driver_data
Date:   Sun, 20 Jun 2021 21:27:15 +0800
Message-Id: <20210620132715.60215-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current code sets config.driver_data to a zero initialized regulator
which is obviously wrong. Fix it.

Fixes: 4618119b9be5 ("regulator: hi655x: enable regulator for hi655x PMIC")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/hi655x-regulator.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/hi655x-regulator.c b/drivers/regulator/hi655x-regulator.c
index 68cdb173196d..556bb73f3329 100644
--- a/drivers/regulator/hi655x-regulator.c
+++ b/drivers/regulator/hi655x-regulator.c
@@ -72,7 +72,7 @@ enum hi655x_regulator_id {
 static int hi655x_is_enabled(struct regulator_dev *rdev)
 {
 	unsigned int value = 0;
-	struct hi655x_regulator *regulator = rdev_get_drvdata(rdev);
+	const struct hi655x_regulator *regulator = rdev_get_drvdata(rdev);
 
 	regmap_read(rdev->regmap, regulator->status_reg, &value);
 	return (value & rdev->desc->enable_mask);
@@ -80,7 +80,7 @@ static int hi655x_is_enabled(struct regulator_dev *rdev)
 
 static int hi655x_disable(struct regulator_dev *rdev)
 {
-	struct hi655x_regulator *regulator = rdev_get_drvdata(rdev);
+	const struct hi655x_regulator *regulator = rdev_get_drvdata(rdev);
 
 	return regmap_write(rdev->regmap, regulator->disable_reg,
 			    rdev->desc->enable_mask);
@@ -169,7 +169,6 @@ static const struct hi655x_regulator regulators[] = {
 static int hi655x_regulator_probe(struct platform_device *pdev)
 {
 	unsigned int i;
-	struct hi655x_regulator *regulator;
 	struct hi655x_pmic *pmic;
 	struct regulator_config config = { };
 	struct regulator_dev *rdev;
@@ -180,22 +179,17 @@ static int hi655x_regulator_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	regulator = devm_kzalloc(&pdev->dev, sizeof(*regulator), GFP_KERNEL);
-	if (!regulator)
-		return -ENOMEM;
-
-	platform_set_drvdata(pdev, regulator);
-
 	config.dev = pdev->dev.parent;
 	config.regmap = pmic->regmap;
-	config.driver_data = regulator;
 	for (i = 0; i < ARRAY_SIZE(regulators); i++) {
+		config.driver_data = (void *) &regulators[i];
+
 		rdev = devm_regulator_register(&pdev->dev,
 					       &regulators[i].rdesc,
 					       &config);
 		if (IS_ERR(rdev)) {
 			dev_err(&pdev->dev, "failed to register regulator %s\n",
-				regulator->rdesc.name);
+				regulators[i].rdesc.name);
 			return PTR_ERR(rdev);
 		}
 	}
-- 
2.25.1

