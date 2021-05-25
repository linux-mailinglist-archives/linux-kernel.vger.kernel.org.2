Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3B9390120
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 14:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbhEYMmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 08:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbhEYMmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 08:42:00 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A9AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 05:40:29 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id u7so7719183plq.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 05:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2N4dAd5lfUN8BZ7LLducedLUzeb6/WJJK8osT2X1nug=;
        b=PQJJMZAT7Cqwz/d/UdXrHikWAwwrq5mriUciH4Pi01zb0FPk2+nv5uU3odiMUCPPX1
         jL3zbQ39pA5qvJ6TmNh2ovNjMeh9QeHmJ1g43Y1BlzGbaNakqKvuTUtxvU4RpbvgwwQr
         FDcmjOla5iP2ygwGelaY/d545jW3yeT1Oa7ibeh2QQCRzU20Erf8O2a9+bzRTwL3zziF
         IHqUfV76KtzKij5QndOKk6VKxk9+6NhZs+Gsx+m3jibIyizg+jaK7WkFf70nRRxCvDpy
         YyGBLWV3zw93SiX/KCA5OB4mTRazXDFWjmtL87Yu/mw3nJLbfLUG+RDJO+5WI5fzuxZB
         gVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2N4dAd5lfUN8BZ7LLducedLUzeb6/WJJK8osT2X1nug=;
        b=V2e/A4+ISiheApXt+AIyCsHZNtm740PZBI2/pTwFV0b2ny/jpa4gULOWlqm8UVHm0L
         Kxroqshf5iG4ihYrXdAUgkNbwQ88EsVKV5sZKpKiugyXJLCp7a2jQkcXV5kdrsT171yn
         s0h9xOO4TGGsgnTFdvfGDjNc1a0fsmOCLbxPzvK2835dVBKLQV92GC2Q+ilUEbubcWCN
         qcQ0ypJFEbdf2cn+WZsEqCFisCz1HfmUW/ziGvWHZOTPTMH2AP2goZT4v+4Ir5OcJqO2
         yXTfmMFByKc6mM3aiLYaKcfAdyI0sCle8pqAlka8zQy/EFfBWV9T2R8wvwc4Jfx3wUdu
         KilQ==
X-Gm-Message-State: AOAM530PfLifviLu9kJHa2LDB3MC5nlNnTfIyw/AcmwoUCr+V4cufx9a
        +VhnPvacf1tbhxIaCjTB+Bqn4w==
X-Google-Smtp-Source: ABdhPJx3kH1VuwvaWaTspCfcfYY/nLsGGuIf12k9Buzj1u3YM+UAqHfGM1ANeBEBfeIAtf9ftq3Tng==
X-Received: by 2002:a17:902:b687:b029:eb:6491:b3f7 with SMTP id c7-20020a170902b687b02900eb6491b3f7mr30361593pls.38.1621946428666;
        Tue, 25 May 2021 05:40:28 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id i8sm14586927pgt.58.2021.05.25.05.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 05:40:28 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Yunfan Zhang <yfzhang@marvell.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: fan53555: Convert to use regulator_set_ramp_delay_regmap
Date:   Tue, 25 May 2021 20:40:17 +0800
Message-Id: <20210525124017.2550029-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210525124017.2550029-1-axel.lin@ingics.com>
References: <20210525124017.2550029-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regulator_set_ramp_delay_regmap instead of open-coded.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/fan53555.c | 63 ++++++++++--------------------------
 1 file changed, 17 insertions(+), 46 deletions(-)

diff --git a/drivers/regulator/fan53555.c b/drivers/regulator/fan53555.c
index 9770a4df83d4..eb67500ad279 100644
--- a/drivers/regulator/fan53555.c
+++ b/drivers/regulator/fan53555.c
@@ -126,7 +126,8 @@ struct fan53555_device_info {
 	/* Slew rate */
 	unsigned int slew_reg;
 	unsigned int slew_mask;
-	unsigned int slew_shift;
+	const unsigned int *ramp_delay_table;
+	unsigned int n_ramp_values;
 	unsigned int slew_rate;
 };
 
@@ -200,7 +201,7 @@ static unsigned int fan53555_get_mode(struct regulator_dev *rdev)
 		return REGULATOR_MODE_NORMAL;
 }
 
-static const int slew_rates[] = {
+static const unsigned int slew_rates[] = {
 	64000,
 	32000,
 	16000,
@@ -211,51 +212,13 @@ static const int slew_rates[] = {
 	  500,
 };
 
-static const int tcs_slew_rates[] = {
+static const unsigned int tcs_slew_rates[] = {
 	18700,
 	 9300,
 	 4600,
 	 2300,
 };
 
-static int fan53555_set_ramp(struct regulator_dev *rdev, int ramp)
-{
-	struct fan53555_device_info *di = rdev_get_drvdata(rdev);
-	int regval = -1, i;
-	const int *slew_rate_t;
-	int slew_rate_n;
-
-	switch (di->vendor) {
-	case FAN53526_VENDOR_FAIRCHILD:
-	case FAN53555_VENDOR_FAIRCHILD:
-	case FAN53555_VENDOR_SILERGY:
-		slew_rate_t = slew_rates;
-		slew_rate_n = ARRAY_SIZE(slew_rates);
-		break;
-	case FAN53526_VENDOR_TCS:
-		slew_rate_t = tcs_slew_rates;
-		slew_rate_n = ARRAY_SIZE(tcs_slew_rates);
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	for (i = 0; i < slew_rate_n; i++) {
-		if (ramp <= slew_rate_t[i])
-			regval = i;
-		else
-			break;
-	}
-
-	if (regval < 0) {
-		dev_err(di->dev, "unsupported ramp value %d\n", ramp);
-		return -EINVAL;
-	}
-
-	return regmap_update_bits(rdev->regmap, di->slew_reg,
-				  di->slew_mask, regval << di->slew_shift);
-}
-
 static const struct regulator_ops fan53555_regulator_ops = {
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
@@ -268,7 +231,7 @@ static const struct regulator_ops fan53555_regulator_ops = {
 	.is_enabled = regulator_is_enabled_regmap,
 	.set_mode = fan53555_set_mode,
 	.get_mode = fan53555_get_mode,
-	.set_ramp_delay = fan53555_set_ramp,
+	.set_ramp_delay = regulator_set_ramp_delay_regmap,
 	.set_suspend_enable = fan53555_set_suspend_enable,
 	.set_suspend_disable = fan53555_set_suspend_disable,
 };
@@ -298,7 +261,8 @@ static int fan53526_voltages_setup_fairchild(struct fan53555_device_info *di)
 
 	di->slew_reg = FAN53555_CONTROL;
 	di->slew_mask = CTL_SLEW_MASK;
-	di->slew_shift = CTL_SLEW_SHIFT;
+	di->ramp_delay_table = slew_rates;
+	di->n_ramp_values = ARRAY_SIZE(slew_rates);
 	di->vsel_count = FAN53526_NVOLTAGES;
 
 	return 0;
@@ -343,7 +307,8 @@ static int fan53555_voltages_setup_fairchild(struct fan53555_device_info *di)
 	}
 	di->slew_reg = FAN53555_CONTROL;
 	di->slew_mask = CTL_SLEW_MASK;
-	di->slew_shift = CTL_SLEW_SHIFT;
+	di->ramp_delay_table = slew_rates;
+	di->n_ramp_values = ARRAY_SIZE(slew_rates);
 	di->vsel_count = FAN53555_NVOLTAGES;
 
 	return 0;
@@ -365,7 +330,8 @@ static int fan53555_voltages_setup_silergy(struct fan53555_device_info *di)
 	}
 	di->slew_reg = FAN53555_CONTROL;
 	di->slew_mask = CTL_SLEW_MASK;
-	di->slew_shift = CTL_SLEW_SHIFT;
+	di->ramp_delay_table = slew_rates;
+	di->n_ramp_values = ARRAY_SIZE(slew_rates);
 	di->vsel_count = FAN53555_NVOLTAGES;
 
 	return 0;
@@ -377,7 +343,8 @@ static int fan53526_voltages_setup_tcs(struct fan53555_device_info *di)
 	case TCS4525_CHIP_ID_12:
 		di->slew_reg = TCS4525_TIME;
 		di->slew_mask = TCS_SLEW_MASK;
-		di->slew_shift = TCS_SLEW_SHIFT;
+		di->ramp_delay_table = tcs_slew_rates;
+		di->n_ramp_values = ARRAY_SIZE(tcs_slew_rates);
 
 		/* Init voltage range and step */
 		di->vsel_min = 600000;
@@ -516,6 +483,10 @@ static int fan53555_regulator_register(struct fan53555_device_info *di,
 	rdesc->uV_step = di->vsel_step;
 	rdesc->vsel_reg = di->vol_reg;
 	rdesc->vsel_mask = di->vsel_count - 1;
+	rdesc->ramp_reg = di->slew_reg;
+	rdesc->ramp_mask = di->slew_mask;
+	rdesc->ramp_delay_table = di->ramp_delay_table;
+	rdesc->n_ramp_values = di->n_ramp_values;
 	rdesc->owner = THIS_MODULE;
 
 	rdev = devm_regulator_register(di->dev, &di->desc, config);
-- 
2.25.1

