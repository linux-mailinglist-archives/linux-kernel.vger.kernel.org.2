Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E74F38FF0C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 12:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhEYK3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 06:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbhEYK3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 06:29:08 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1F6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 03:27:39 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id e17so12650117pfl.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 03:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MOvKkPXAh8i0kp5Ux/Gw2sbb4gBNUwWY/S4AVzfdHPY=;
        b=wD4t2nqT6lAivvz8cFl5t+Wv8yFyOxT7+ZtDlaS2kviVRNghzJshGL9cnnveIXI3TN
         R78F+KivnD6KkS8ziF41gLxwVR8/l7oB2CmYnZ1BbwhJH9U+bP2eutmHOcg9p5zKnPWK
         id7jqbnebgLybq2dbBGTNpW7QlElrlrpj7Yx2AhWEhki3pYfByE/+esa18ZWumArdFDp
         T5GqUvJyu7xuJXtjACZUDFj8qhM9nRpWdKfHbLaPpLCGZvcLN6r2fOx8SNLPyq7AUdCD
         b1YOfykkpjX2+yBJEAoRTPOryUSDR8hO3o8Q5fgNbC+tJNRV50mKvHMVawoOVYMUjA73
         y2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MOvKkPXAh8i0kp5Ux/Gw2sbb4gBNUwWY/S4AVzfdHPY=;
        b=nGOxgFIa0va0C9kqR7u2QzbibKJ4Q80xM4II/f3AS8rDA+oRaw6vGQbevYC3fElW81
         0POtuzwE/R/QdSjbKE3sQrdtxDWnJOMEPnluICQ5trjF9Qx+QPQXYh17NTJES7PGOoQZ
         BBLVPX0gTvrqJUrPINmt8MPCsEEGpmIZlhKvCBsU8JA2hbANANjWziM4buxhKV3Bn0ja
         nNsY3Q+1Pzb2dbMDT9msqX5zi3P4y4QVlWlGn8gHMyX1a0/p+I2jgonAXgg9dofDRY0P
         mpyK9R5XkL5IQEiOKvePcbuWkQX0wrVsgeBDJ5DXtGjXmGacPsxj9TqIJZxE3Se/6tsd
         3D4Q==
X-Gm-Message-State: AOAM530yYxPuBTnKGCTvnbEEWDZe7NY5ytxCMPr5MZnZjxJdFT/y7Idw
        bq51L52SdhSJ7yITk2Sz9fBbqA==
X-Google-Smtp-Source: ABdhPJwy5M3Tk79n1RC1FgDEM7qhHXmJiZsHaO7gmBV2siGvTH5u5IXo1HlZY+NeDt++7K0E124m2g==
X-Received: by 2002:a63:3d87:: with SMTP id k129mr18228624pga.57.1621938458946;
        Tue, 25 May 2021 03:27:38 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id s23sm1713723pjg.15.2021.05.25.03.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 03:27:38 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: mp886x: Convert to use regulator_set_ramp_delay_regmap
Date:   Tue, 25 May 2021 18:27:08 +0800
Message-Id: <20210525102708.2519323-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regulator_set_ramp_delay_regmap instead of open-coded.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/mp886x.c | 32 +++++++-------------------------
 1 file changed, 7 insertions(+), 25 deletions(-)

diff --git a/drivers/regulator/mp886x.c b/drivers/regulator/mp886x.c
index a84fd74081de..8ad4722eca4b 100644
--- a/drivers/regulator/mp886x.c
+++ b/drivers/regulator/mp886x.c
@@ -26,7 +26,7 @@
 
 struct mp886x_cfg_info {
 	const struct regulator_ops *rops;
-	const int slew_rates[8];
+	const unsigned int slew_rates[8];
 	const int switch_freq[4];
 	const u8 fs_reg;
 	const u8 fs_shift;
@@ -42,28 +42,6 @@ struct mp886x_device_info {
 	unsigned int sel;
 };
 
-static int mp886x_set_ramp(struct regulator_dev *rdev, int ramp)
-{
-	struct mp886x_device_info *di = rdev_get_drvdata(rdev);
-	const struct mp886x_cfg_info *ci = di->ci;
-	int reg = -1, i;
-
-	for (i = 0; i < ARRAY_SIZE(ci->slew_rates); i++) {
-		if (ramp <= ci->slew_rates[i])
-			reg = i;
-		else
-			break;
-	}
-
-	if (reg < 0) {
-		dev_err(di->dev, "unsupported ramp value %d\n", ramp);
-		return -EINVAL;
-	}
-
-	return regmap_update_bits(rdev->regmap, MP886X_SYSCNTLREG1,
-				  MP886X_SLEW_MASK, reg << MP886X_SLEW_SHIFT);
-}
-
 static void mp886x_set_switch_freq(struct mp886x_device_info *di,
 				   struct regmap *regmap,
 				   u32 freq)
@@ -169,7 +147,7 @@ static const struct regulator_ops mp8869_regulator_ops = {
 	.is_enabled = regulator_is_enabled_regmap,
 	.set_mode = mp886x_set_mode,
 	.get_mode = mp886x_get_mode,
-	.set_ramp_delay = mp886x_set_ramp,
+	.set_ramp_delay = regulator_set_ramp_delay_regmap,
 };
 
 static const struct mp886x_cfg_info mp8869_ci = {
@@ -248,7 +226,7 @@ static const struct regulator_ops mp8867_regulator_ops = {
 	.is_enabled = regulator_is_enabled_regmap,
 	.set_mode = mp886x_set_mode,
 	.get_mode = mp886x_get_mode,
-	.set_ramp_delay = mp886x_set_ramp,
+	.set_ramp_delay = regulator_set_ramp_delay_regmap,
 };
 
 static const struct mp886x_cfg_info mp8867_ci = {
@@ -290,6 +268,10 @@ static int mp886x_regulator_register(struct mp886x_device_info *di,
 	rdesc->uV_step = 10000;
 	rdesc->vsel_reg = MP886X_VSEL;
 	rdesc->vsel_mask = 0x3f;
+	rdesc->ramp_reg = MP886X_SYSCNTLREG1;
+	rdesc->ramp_mask = MP886X_SLEW_MASK;
+	rdesc->ramp_delay_table = di->ci->slew_rates;
+	rdesc->n_ramp_values = ARRAY_SIZE(di->ci->slew_rates);
 	rdesc->owner = THIS_MODULE;
 
 	rdev = devm_regulator_register(di->dev, &di->desc, config);
-- 
2.25.1

