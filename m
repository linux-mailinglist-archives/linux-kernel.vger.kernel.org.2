Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC48438D355
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 06:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbhEVEJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 00:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhEVEJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 00:09:49 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F1BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 21:08:24 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c12so4775427pfl.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 21:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PT2dBZq34aO6mGS8gktu3A3htZwyT9GEl0OpNV4QlJI=;
        b=vJK+wvpemTweS0bWXL9997x85UqqpLXUfzTKMoOUhQrPjASrsPz83w/8uTiDIXUBSO
         2d0WQ8/wGz1m3jsAT2K4BtWL8lbqefWQlTrIaCyLbVqTEIZ1qLVbNAQ1SXL1ON8iwzPU
         +W4xw5U7sy7GdvUrwc/0Lw3wV37/9nnCIJ7dhKHR2qREOj0CzsAQkyyhRUg6TNzAvlMk
         z+bJLFAPVJo3dpytx9sjRKeulRtZek19ALBj9iwCOnIkJaIZpDydmM9RIf8Hocv7QkKb
         E65Dhj/XdpvCPXX/NNUUkuiuAoATUVfSWsuaqctefsooauVa4fmQJgxiJDD0ljt7YsFa
         xwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PT2dBZq34aO6mGS8gktu3A3htZwyT9GEl0OpNV4QlJI=;
        b=SGkEDHYL+SSjlgO+qQBtxCnyj8O42zxb7qrjGKv56MtXKd8ITbEndvH3syYZ9a5n2/
         uBxWabq5EeXrAMS3uesK5YSndf3+cV8r+jLMnznE6moF0T8E7Q00D6TkMMNm4GCZ03KF
         Ixo8cy0Sx87BCNl9K6gQHXihzdFDcM7UKPsHiftLCLMFNKmHRD+MKOwXlLaqf9Ew1FtL
         pZNwyIfVpmPdf5Tw07An4ijpbAYeyVs7jo+OLBjsB4dh0hQ3L1YGGHCDj3jo8Ciy4F5k
         Qh9w8kWpBXy6iUYlPjlwZUe53n+PfcTuhZfjeZZYjJdUgOC5zrAVbT5xlJPyK2vbIaN0
         rCgA==
X-Gm-Message-State: AOAM5337P3eBtPbFPjFdWavvoDWRSRkW8r2+Jn5aY/rmD4TYDCZmaPKP
        Zks0IMkiRYCsL6P7yzGY83Q+Yw==
X-Google-Smtp-Source: ABdhPJxewj6srqb07e75LOeczL90sjwwn66FYu4/EZ5/xMC/HRqZYxIvDOoO3VkTs7VK6FghALN+SA==
X-Received: by 2002:a65:644d:: with SMTP id s13mr2109879pgv.362.1621656503807;
        Fri, 21 May 2021 21:08:23 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id t7sm5131477pju.4.2021.05.21.21.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 21:08:23 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: max8973: Convert to use regulator_set_ramp_delay_regmap
Date:   Sat, 22 May 2021 12:08:14 +0800
Message-Id: <20210522040814.2042397-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regulator_set_ramp_delay_regmap instead of open-coded.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/max8973-regulator.c | 37 +++++++--------------------
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/drivers/regulator/max8973-regulator.c b/drivers/regulator/max8973-regulator.c
index 9aee1444181d..8da8f9b6c4fd 100644
--- a/drivers/regulator/max8973-regulator.c
+++ b/drivers/regulator/max8973-regulator.c
@@ -265,33 +265,6 @@ static unsigned int max8973_dcdc_get_mode(struct regulator_dev *rdev)
 		REGULATOR_MODE_FAST : REGULATOR_MODE_NORMAL;
 }
 
-static int max8973_set_ramp_delay(struct regulator_dev *rdev,
-		int ramp_delay)
-{
-	struct max8973_chip *max = rdev_get_drvdata(rdev);
-	unsigned int control;
-	int ret;
-
-	/* Set ramp delay */
-	if (ramp_delay <= 12000)
-		control = MAX8973_RAMP_12mV_PER_US;
-	else if (ramp_delay <= 25000)
-		control = MAX8973_RAMP_25mV_PER_US;
-	else if (ramp_delay <= 50000)
-		control = MAX8973_RAMP_50mV_PER_US;
-	else if (ramp_delay <= 200000)
-		control = MAX8973_RAMP_200mV_PER_US;
-	else
-		return -EINVAL;
-
-	ret = regmap_update_bits(max->regmap, MAX8973_CONTROL1,
-			MAX8973_RAMP_MASK, control);
-	if (ret < 0)
-		dev_err(max->dev, "register %d update failed, %d",
-				MAX8973_CONTROL1, ret);
-	return ret;
-}
-
 static int max8973_set_current_limit(struct regulator_dev *rdev,
 		int min_ua, int max_ua)
 {
@@ -341,6 +314,10 @@ static int max8973_get_current_limit(struct regulator_dev *rdev)
 	return 9000000;
 }
 
+static const unsigned int max8973_buck_ramp_table[] = {
+	12000, 25000, 50000, 200000
+};
+
 static const struct regulator_ops max8973_dcdc_ops = {
 	.get_voltage_sel	= max8973_dcdc_get_voltage_sel,
 	.set_voltage_sel	= max8973_dcdc_set_voltage_sel,
@@ -348,7 +325,7 @@ static const struct regulator_ops max8973_dcdc_ops = {
 	.set_mode		= max8973_dcdc_set_mode,
 	.get_mode		= max8973_dcdc_get_mode,
 	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
-	.set_ramp_delay		= max8973_set_ramp_delay,
+	.set_ramp_delay		= regulator_set_ramp_delay_regmap,
 };
 
 static int max8973_init_dcdc(struct max8973_chip *max,
@@ -694,6 +671,10 @@ static int max8973_probe(struct i2c_client *client,
 	max->desc.min_uV = MAX8973_MIN_VOLATGE;
 	max->desc.uV_step = MAX8973_VOLATGE_STEP;
 	max->desc.n_voltages = MAX8973_BUCK_N_VOLTAGE;
+	max->desc.ramp_reg = MAX8973_CONTROL1;
+	max->desc.ramp_mask = MAX8973_RAMP_MASK;
+	max->desc.ramp_delay_table = max8973_buck_ramp_table;
+	max->desc.n_ramp_values = ARRAY_SIZE(max8973_buck_ramp_table);
 
 	max->dvs_gpio = (pdata->dvs_gpio) ? pdata->dvs_gpio : -EINVAL;
 	max->enable_external_control = pdata->enable_ext_control;
-- 
2.25.1

