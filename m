Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90A8936F76E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 10:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhD3I5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 04:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhD3I4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 04:56:55 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B70C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 01:56:05 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id j6so8639597pfh.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 01:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ezstn2+TJo7OH4UI4kUdN4jJn9aj9ubBietLmSjgkvY=;
        b=iFSiNByYCQgxD8BSK5WO4CSD7L7jeL5Zg++NGHM5xBYgp2iVgDoQMsvZzqvC+pJjAy
         9wcLuJ2pvbH8dVwR0ZA1gOLjA8RwyPLoPOKRpuNVZ+j5trd3CbXz2XVVomTm/WhTJb27
         T2EMf1fSdhE4QV69Q1cd4ZHgA/ZZqwX+Rkwyao995xx76Prmqvv8XioQ7EN2udcvSHlc
         BdcvpT0r5DYSL7DRUIEc9h0GGSbKGdJhT/RRYLM4xkPq+7hpt9Hlov6BWe3iP1bOvflz
         B0fMxz+7ym7iFKI12mhnnxYdgR8jJpBLGhokCInq14ApubCpSxbwEwMP5LhQ+qHVwDd7
         Z1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ezstn2+TJo7OH4UI4kUdN4jJn9aj9ubBietLmSjgkvY=;
        b=tE1kI+ySiPLskfiPIp9LYb+4mhEC8RdG1cdaHlUgLvdWZzvMwcxvtuk6DKvO6EoWuh
         pg9Md9WupfuiPOnIRGtve5RhdCIh7f5y4hz5XHimFNr1etWaaRxLi/W9XetL4/Vv75QY
         Dn2FIgRSaaurFka8dYL4s0+BC+0z4k2U9cMOLsYMUw1+tcvvaNJRkbHwleHVYdaF0d5J
         GMrqhOdHcnojFUCLR4mODMjDq1pwkH0+Sc9rOZmaYXpS+ps4JH0jEHfrSrNXKJ5K+Ii7
         0a/tfCfhtNtTULxVQSJMebuo/CIFAWebjbKJEoRP0Vc7+a8BKqL4mddUNEfQy0zz9yN9
         P8sA==
X-Gm-Message-State: AOAM530y18NxYCBtSJGBGEM6jzk2UsKhA1COBS7kBgVQfF1CDm1TJBR2
        5XOW2i4LMYdyAlAwVEquKAg68A==
X-Google-Smtp-Source: ABdhPJxRyRAUAvotE/SC7WEYq/6Cm2sIS72BkwGmgJ0dSLA0+Am0tsS9ERjwKRsUbeu9gQAMaei9tA==
X-Received: by 2002:a05:6a00:1687:b029:253:f417:4dba with SMTP id k7-20020a056a001687b0290253f4174dbamr3960874pfc.5.1619772964922;
        Fri, 30 Apr 2021 01:56:04 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id w8sm1395172pjq.10.2021.04.30.01.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 01:56:04 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Guodong Xu <guodong.xu@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: hi6421v600: Remove unneeded *pmic from struct hi6421_spmi_reg_info
Date:   Fri, 30 Apr 2021 16:55:55 +0800
Message-Id: <20210430085555.1127994-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use rdev->regmap instead of pmic->regmap.
With this change, hi6421_spmi_regulator_disable can be removed and use
regulator_disable_regmap instead.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/hi6421v600-regulator.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/regulator/hi6421v600-regulator.c b/drivers/regulator/hi6421v600-regulator.c
index f6a14e9c3cbf..feddb0b5d4f1 100644
--- a/drivers/regulator/hi6421v600-regulator.c
+++ b/drivers/regulator/hi6421v600-regulator.c
@@ -18,7 +18,6 @@
 
 struct hi6421_spmi_reg_info {
 	struct regulator_desc	desc;
-	struct hi6421_spmi_pmic *pmic;
 	u8			eco_mode_mask;
 	u32			eco_uA;
 
@@ -98,13 +97,12 @@ static const unsigned int ldo34_voltages[] = {
 static int hi6421_spmi_regulator_enable(struct regulator_dev *rdev)
 {
 	struct hi6421_spmi_reg_info *sreg = rdev_get_drvdata(rdev);
-	struct hi6421_spmi_pmic *pmic = sreg->pmic;
 	int ret;
 
 	/* cannot enable more than one regulator at one time */
 	mutex_lock(&sreg->enable_mutex);
 
-	ret = regmap_update_bits(pmic->regmap, rdev->desc->enable_reg,
+	ret = regmap_update_bits(rdev->regmap, rdev->desc->enable_reg,
 				 rdev->desc->enable_mask,
 				 rdev->desc->enable_mask);
 
@@ -116,22 +114,12 @@ static int hi6421_spmi_regulator_enable(struct regulator_dev *rdev)
 	return ret;
 }
 
-static int hi6421_spmi_regulator_disable(struct regulator_dev *rdev)
-{
-	struct hi6421_spmi_reg_info *sreg = rdev_get_drvdata(rdev);
-	struct hi6421_spmi_pmic *pmic = sreg->pmic;
-
-	return regmap_update_bits(pmic->regmap, rdev->desc->enable_reg,
-				  rdev->desc->enable_mask, 0);
-}
-
 static unsigned int hi6421_spmi_regulator_get_mode(struct regulator_dev *rdev)
 {
 	struct hi6421_spmi_reg_info *sreg = rdev_get_drvdata(rdev);
-	struct hi6421_spmi_pmic *pmic = sreg->pmic;
 	u32 reg_val;
 
-	regmap_read(pmic->regmap, rdev->desc->enable_reg, &reg_val);
+	regmap_read(rdev->regmap, rdev->desc->enable_reg, &reg_val);
 
 	if (reg_val & sreg->eco_mode_mask)
 		return REGULATOR_MODE_IDLE;
@@ -143,7 +131,6 @@ static int hi6421_spmi_regulator_set_mode(struct regulator_dev *rdev,
 					  unsigned int mode)
 {
 	struct hi6421_spmi_reg_info *sreg = rdev_get_drvdata(rdev);
-	struct hi6421_spmi_pmic *pmic = sreg->pmic;
 	u32 val;
 
 	switch (mode) {
@@ -157,7 +144,7 @@ static int hi6421_spmi_regulator_set_mode(struct regulator_dev *rdev,
 		return -EINVAL;
 	}
 
-	return regmap_update_bits(pmic->regmap, rdev->desc->enable_reg,
+	return regmap_update_bits(rdev->regmap, rdev->desc->enable_reg,
 				  sreg->eco_mode_mask, val);
 }
 
@@ -177,7 +164,7 @@ hi6421_spmi_regulator_get_optimum_mode(struct regulator_dev *rdev,
 static const struct regulator_ops hi6421_spmi_ldo_rops = {
 	.is_enabled = regulator_is_enabled_regmap,
 	.enable = hi6421_spmi_regulator_enable,
-	.disable = hi6421_spmi_regulator_disable,
+	.disable = regulator_disable_regmap,
 	.list_voltage = regulator_list_voltage_table,
 	.map_voltage = regulator_map_voltage_iterate,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
@@ -258,7 +245,6 @@ static int hi6421_spmi_regulator_probe(struct platform_device *pdev)
 	if (!sreg)
 		return -ENOMEM;
 
-	sreg->pmic = pmic;
 	mutex_init(&sreg->enable_mutex);
 
 	for (i = 0; i < ARRAY_SIZE(regulator_info); i++) {
-- 
2.25.1

