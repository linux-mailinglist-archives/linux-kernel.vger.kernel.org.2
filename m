Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0105839312D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 16:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236494AbhE0Ooh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 10:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234521AbhE0Ooc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 10:44:32 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D753BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 07:42:58 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id g18so755088pfr.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 07:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F7WH66xwuCDzW8vfgxrtubuRlmQWSD9ABG/o2vLo7Xs=;
        b=QLGxBF1p+hD9DirkU8Z6pnkackIY/QXBh5Ssz3LYYzELCCksvemxdAuikCR7SLuK+V
         zbp1JqVw+cCv0xJBjQAiEF5477lXhWUkDn6VH0Pl6eY4JacftWKfJYWjojoErW/hO0eZ
         6JL7d3GRlfomGCHqxz9Gyhqaedc+3oNAXU0vYgnnBt++Lb9J9/LQ/RM6JluBXvUBaexd
         gxWusJZz7pxejjeRwtTT2C3ok4ZlfCxUKQlKjFyfjlHMbvNX7HtUwAcWxWhUfjR/2n/0
         Z2kfFbeji6xdql6KELsZAN/gzGeuRw9bvhb2bP5fMqOv89NQoQez+gBVnq6edhWs9Nin
         2zQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F7WH66xwuCDzW8vfgxrtubuRlmQWSD9ABG/o2vLo7Xs=;
        b=CRd/rkN/2EpcZtCz2/B70VKDetUtNKmoGkm4s06pioVDX6G2v1gWr9boM11miwxm61
         zYSUSNALGq87Gueu0uJUb+fwSADJgtMiAD5dLIUh3LhHttRHWdX5qLUJ2gfDEPyMsX1n
         Yi9Xdi6oaH7n6NqxG1kZVZY0EUqkHcjRQ7nsunPcxnXxRKDT1uf7oiTIoAiJrHvuWvox
         +H9WSee9QO2wVcV4tkrun0eVD0n4xrkFFNICryv+shwDKTuP6CyVzNQSzvP6iXgQfaah
         hLU0dMx1oi8TRpHIEjZdD2gOnfZhOVpU5S0xR2ZTRF6xMF6DJulFJ7BQYCgsXsl7XYAT
         rT3Q==
X-Gm-Message-State: AOAM532FrvK+ABKJ48vl/XPcBTzpRHRJwuGu0U2wj1NA7WtVZpMW3ImS
        kQrQ2psXYsTUZNFe0e/azqdQaQ==
X-Google-Smtp-Source: ABdhPJzREi8bDtUemg1uyGK+v8Qgr6Fq2U6W9eIc4+RW+kzN30ScZoFAwiE6breY4TzB9KciRn+7cg==
X-Received: by 2002:a63:e53:: with SMTP id 19mr4020905pgo.328.1622126578246;
        Thu, 27 May 2021 07:42:58 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id b23sm2153579pft.162.2021.05.27.07.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 07:42:57 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Daniel Jeong <gshark.jeong@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: lp8755: Convert to use regulator_set_ramp_delay_regmap
Date:   Thu, 27 May 2021 22:42:48 +0800
Message-Id: <20210527144248.247992-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regulator_set_ramp_delay_regmap instead of open-coded.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/lp8755.c | 55 ++++++--------------------------------
 1 file changed, 8 insertions(+), 47 deletions(-)

diff --git a/drivers/regulator/lp8755.c b/drivers/regulator/lp8755.c
index 13c535711265..321bec6e3f8d 100644
--- a/drivers/regulator/lp8755.c
+++ b/drivers/regulator/lp8755.c
@@ -136,52 +136,9 @@ static unsigned int lp8755_buck_get_mode(struct regulator_dev *rdev)
 	return 0;
 }
 
-static int lp8755_buck_set_ramp(struct regulator_dev *rdev, int ramp)
-{
-	int ret;
-	unsigned int regval = 0x00;
-	enum lp8755_bucks id = rdev_get_id(rdev);
-
-	/* uV/us */
-	switch (ramp) {
-	case 0 ... 230:
-		regval = 0x07;
-		break;
-	case 231 ... 470:
-		regval = 0x06;
-		break;
-	case 471 ... 940:
-		regval = 0x05;
-		break;
-	case 941 ... 1900:
-		regval = 0x04;
-		break;
-	case 1901 ... 3800:
-		regval = 0x03;
-		break;
-	case 3801 ... 7500:
-		regval = 0x02;
-		break;
-	case 7501 ... 15000:
-		regval = 0x01;
-		break;
-	case 15001 ... 30000:
-		regval = 0x00;
-		break;
-	default:
-		dev_err(&rdev->dev,
-			"Not supported ramp value %d %s\n", ramp, __func__);
-		return -EINVAL;
-	}
-
-	ret = regmap_update_bits(rdev->regmap, 0x07 + id, 0x07, regval);
-	if (ret < 0)
-		goto err_i2c;
-	return ret;
-err_i2c:
-	dev_err(&rdev->dev, "i2c access error %s\n", __func__);
-	return ret;
-}
+static const unsigned int lp8755_buck_ramp_table[] = {
+	30000, 15000, 7500, 3800, 1900, 940, 470, 230
+};
 
 static const struct regulator_ops lp8755_buck_ops = {
 	.map_voltage = regulator_map_voltage_linear,
@@ -194,7 +151,7 @@ static const struct regulator_ops lp8755_buck_ops = {
 	.enable_time = lp8755_buck_enable_time,
 	.set_mode = lp8755_buck_set_mode,
 	.get_mode = lp8755_buck_get_mode,
-	.set_ramp_delay = lp8755_buck_set_ramp,
+	.set_ramp_delay = regulator_set_ramp_delay_regmap,
 };
 
 #define lp8755_rail(_id) "lp8755_buck"#_id
@@ -269,6 +226,10 @@ static int lp8755_init_data(struct lp8755_chip *pchip)
 	.enable_mask = LP8755_BUCK_EN_M,\
 	.vsel_reg = LP8755_REG_BUCK##_id,\
 	.vsel_mask = LP8755_BUCK_VOUT_M,\
+	.ramp_reg = (LP8755_BUCK##_id) + 0x7,\
+	.ramp_mask = 0x7,\
+	.ramp_delay_table = lp8755_buck_ramp_table,\
+	.n_ramp_values = ARRAY_SIZE(lp8755_buck_ramp_table),\
 }
 
 static const struct regulator_desc lp8755_regulators[] = {
-- 
2.25.1

