Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B32937B09C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 23:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhEKVPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 17:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbhEKVOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 17:14:52 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C47C061761
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 14:13:45 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id q136so20250483qka.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 14:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b72fKOovaeqtjkj9FQ1/n1gGi227A+jdIfBr09UGC6s=;
        b=st6pwXZo0BLFK+v31GgCqjAag4Ndlr+jXYUYbBirBNWljs+s7LiN1fvo821LVUEEZm
         uHYxoDc0T6c5C9JfyPD9jftF8se16cMQ5BBhWciKN16ZSKV47mZoGn1Qlq01QnmwaLB8
         dkfeQrAheyXD14RT6iNxxdH47zeNj8u+YYNZUGfD3UZITS1OemrlIt1S2BQlkj6ajy5U
         yQ1X6w8TPSOvxyQfpTygKMPmjB3i0KufseGxheQgMkc79fP5miekC6FEyQApkXcFZ+Ls
         B37Lq6ZM2jrr+J0zf6kt2Bys+aVJb9E23zQ13971+s9zxwO0Vi0HcMO+f/Tpt4NmTl3z
         8vJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b72fKOovaeqtjkj9FQ1/n1gGi227A+jdIfBr09UGC6s=;
        b=aCCRBpKDS+bip0h9fsZ56ePEnEmeSck8ZWyQ4yayiej3ATWdRXJnKmC4CId/lLq+QC
         /yjjJwv12PJQfcxRgQyTG/e9chGHI+2QJBQHwMLP2I0sv9NRm8HMWdY06REwy2je6eVg
         WXVKNKsYBlbc2VE+O68qYeHFxAMgIMwyV2J/n0tn10AI/eihXfOZ3Tz+3VxqOhh7a8ZF
         qSvFpBls6dYPv0MKVoIpjL7by2+Ejdd6hj7qTrzVXXiI9UIeDqKqWpDQ/R5Aat5v85XT
         KGwUNC6SXDjNH+CM0Fz41Yp+0lOYKB4AS4foTiTB9YhJdBOCEFFmWEYv1KZS3TBZOrZb
         i8mw==
X-Gm-Message-State: AOAM532xYDvTP8tRkvgjWMB+09Y38vHhRwGHeYDUAoYH+PpQ+bavhVdf
        jBMKqR1Wy4K62Tm7zI+V1N0=
X-Google-Smtp-Source: ABdhPJyDscTT7WH4GNF+uE19yA4kvdkZA4iLIQ+HyaP6T31VOHciHR7/FoKnZoum+W2zbsQ+XSjCmw==
X-Received: by 2002:a05:620a:4543:: with SMTP id u3mr29723196qkp.118.1620767624188;
        Tue, 11 May 2021 14:13:44 -0700 (PDT)
Received: from master-laptop.sparksnet ([2601:153:980:85b1:f9ba:6614:640b:eee1])
        by smtp.gmail.com with ESMTPSA id g64sm14780392qkf.41.2021.05.11.14.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 14:13:43 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH 3/3] regulator: fan53555: fix tcs4525 function names
Date:   Tue, 11 May 2021 17:13:35 -0400
Message-Id: <20210511211335.2935163-4-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210511211335.2935163-1-pgwipeout@gmail.com>
References: <20210511211335.2935163-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tcs4525 is based off the fan53526.
Rename the tcs4525 functions to align with this.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 drivers/regulator/fan53555.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/fan53555.c b/drivers/regulator/fan53555.c
index 16f28f9df6a1..2695be617373 100644
--- a/drivers/regulator/fan53555.c
+++ b/drivers/regulator/fan53555.c
@@ -67,7 +67,7 @@ enum fan53555_vendor {
 	FAN53526_VENDOR_FAIRCHILD = 0,
 	FAN53555_VENDOR_FAIRCHILD,
 	FAN53555_VENDOR_SILERGY,
-	FAN53555_VENDOR_TCS,
+	FAN53526_VENDOR_TCS,
 };
 
 enum {
@@ -233,7 +233,7 @@ static int fan53555_set_ramp(struct regulator_dev *rdev, int ramp)
 		slew_rate_t = slew_rates;
 		slew_rate_n = ARRAY_SIZE(slew_rates);
 		break;
-	case FAN53555_VENDOR_TCS:
+	case FAN53526_VENDOR_TCS:
 		slew_rate_t = tcs_slew_rates;
 		slew_rate_n = ARRAY_SIZE(tcs_slew_rates);
 		break;
@@ -370,7 +370,7 @@ static int fan53555_voltages_setup_silergy(struct fan53555_device_info *di)
 	return 0;
 }
 
-static int fan53555_voltages_setup_tcs(struct fan53555_device_info *di)
+static int fan53526_voltages_setup_tcs(struct fan53555_device_info *di)
 {
 	switch (di->chip_id) {
 	case TCS4525_CHIP_ID_12:
@@ -420,7 +420,7 @@ static int fan53555_device_setup(struct fan53555_device_info *di,
 			return -EINVAL;
 		}
 		break;
-	case FAN53555_VENDOR_TCS:
+	case FAN53526_VENDOR_TCS:
 		switch (pdata->sleep_vsel_id) {
 		case FAN53555_VSEL_ID_0:
 			di->sleep_reg = TCS4525_VSEL0;
@@ -459,7 +459,7 @@ static int fan53555_device_setup(struct fan53555_device_info *di,
 		di->mode_reg = di->vol_reg;
 		di->mode_mask = VSEL_MODE;
 		break;
-	case FAN53555_VENDOR_TCS:
+	case FAN53526_VENDOR_TCS:
 		di->mode_reg = TCS4525_COMMAND;
 
 		switch (pdata->sleep_vsel_id) {
@@ -487,8 +487,8 @@ static int fan53555_device_setup(struct fan53555_device_info *di,
 	case FAN53555_VENDOR_SILERGY:
 		ret = fan53555_voltages_setup_silergy(di);
 		break;
-	case FAN53555_VENDOR_TCS:
-		ret = fan53555_voltages_setup_tcs(di);
+	case FAN53526_VENDOR_TCS:
+		ret = fan53526_voltages_setup_tcs(di);
 		break;
 	default:
 		dev_err(di->dev, "vendor %d not supported!\n", di->vendor);
@@ -563,7 +563,7 @@ static const struct of_device_id __maybe_unused fan53555_dt_ids[] = {
 		.data = (void *)FAN53555_VENDOR_SILERGY,
 	}, {
 		.compatible = "tcs,tcs4525",
-		.data = (void *)FAN53555_VENDOR_TCS
+		.data = (void *)FAN53526_VENDOR_TCS
 	},
 	{ }
 };
@@ -671,7 +671,7 @@ static const struct i2c_device_id fan53555_id[] = {
 		.driver_data = FAN53555_VENDOR_SILERGY
 	}, {
 		.name = "tcs4525",
-		.driver_data = FAN53555_VENDOR_TCS
+		.driver_data = FAN53526_VENDOR_TCS
 	},
 	{ },
 };
-- 
2.25.1

