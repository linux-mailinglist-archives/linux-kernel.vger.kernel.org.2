Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C2034D0C9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 15:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbhC2NAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 09:00:43 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:37845 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbhC2NAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 09:00:21 -0400
Received: by mail-lf1-f42.google.com with SMTP id q29so18230982lfb.4;
        Mon, 29 Mar 2021 06:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5cuEkWsts5CYm8tzF18/ipAE9RcejE/Tr2lA/A3e7EE=;
        b=H68mRpgK2wqtwKVL52A/XK7Q/psxP1kT4vZXek4/O7+Hyr6ZqvGgvnMwEOqOVf9i5C
         nse/T0qD1ZRqICvnkEqlJkLU+6paQJKqqgzBd65CJnxRQvlUVCbP2K2ZmKXgW30x2eAZ
         c/4+Hknuxy2BMRprffs3msV6j86f69SHLzcNMiXHA7cVpyKY/SvCCvK6HZ+WFLtNYykU
         6LOnSsEHuFiye/gJ/WdQq1l1YJRjDC5lyFs9iUDtxRS50vorytcI7y7DpfTW+8s0o7pW
         W6dn8HkRLPBBrCk4dgBjqFZh3qYvas4eE9YTCO+Ydc9q2Bn33CO+rDMvlO3b+7si0w3D
         esAQ==
X-Gm-Message-State: AOAM5326ZRLZizV+wcFyjc1DyvTg2+fo2yS4j7ZzDPJOYRNjvIoy3eN5
        KGCex+p6WE+1Gtf3jcUfV24=
X-Google-Smtp-Source: ABdhPJx2mlhd+2xIytYJ0VJGbLsLlnBBpw0YSunyfF6gdod0AB0h5RWeVDJ8g1oRHK+9q7NueHtPMA==
X-Received: by 2002:ac2:5444:: with SMTP id d4mr16866969lfn.126.1617022819870;
        Mon, 29 Mar 2021 06:00:19 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::2])
        by smtp.gmail.com with ESMTPSA id m6sm1917321lfb.150.2021.03.29.06.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 06:00:19 -0700 (PDT)
Date:   Mon, 29 Mar 2021 16:00:13 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Subject: [PATCH v5 16/19] regulator: bd71815: use ramp-delay helper
Message-ID: <31db9c2bf1e9e1883d8caf4bf3b90475a8a1166e.1617020713.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1617020713.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617020713.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use generic regamp ramp-delay helper function instead of implementing own.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
Changes since v4:
 - new patch
 drivers/regulator/bd71815-regulator.c | 37 +++++----------------------
 1 file changed, 6 insertions(+), 31 deletions(-)

diff --git a/drivers/regulator/bd71815-regulator.c b/drivers/regulator/bd71815-regulator.c
index b1448e34c629..00bab1307c14 100644
--- a/drivers/regulator/bd71815-regulator.c
+++ b/drivers/regulator/bd71815-regulator.c
@@ -264,36 +264,7 @@ static int buck12_set_hw_dvs_levels(struct device_node *np,
  * 10: 2.50mV/usec	10mV 4uS
  * 11: 1.25mV/usec	10mV 8uS
  */
-static int bd7181x_buck12_set_ramp_delay(struct regulator_dev *rdev,
-					 int ramp_delay)
-{
-	struct bd71815_pmic *pmic = rdev_get_drvdata(rdev);
-	int id = rdev->desc->id;
-	unsigned int ramp_value = BD71815_BUCK_RAMPRATE_10P00MV;
-
-	switch (ramp_delay) {
-	case 1 ... 1250:
-		ramp_value = BD71815_BUCK_RAMPRATE_1P25MV;
-		break;
-	case 1251 ... 2500:
-		ramp_value = BD71815_BUCK_RAMPRATE_2P50MV;
-		break;
-	case 2501 ... 5000:
-		ramp_value = BD71815_BUCK_RAMPRATE_5P00MV;
-		break;
-	case 5001 ... 10000:
-		ramp_value = BD71815_BUCK_RAMPRATE_10P00MV;
-		break;
-	default:
-		ramp_value = BD71815_BUCK_RAMPRATE_10P00MV;
-		dev_err(pmic->dev,
-			"%s: ramp_delay: %d not supported, setting 10000mV//us\n",
-			rdev->desc->name, ramp_delay);
-	}
-
-	return regmap_update_bits(pmic->regmap, BD71815_REG_BUCK1_MODE + id*0x1,
-			BD71815_BUCK_RAMPRATE_MASK, ramp_value << 6);
-}
+static const unsigned int bd7181x_ramp_table[] = { 1250, 2500, 5000, 10000 };
 
 static int bd7181x_led_set_current_limit(struct regulator_dev *rdev,
 					int min_uA, int max_uA)
@@ -429,7 +400,7 @@ static const struct regulator_ops bd7181x_buck12_regulator_ops = {
 	.set_voltage_sel = bd7181x_buck12_set_voltage_sel,
 	.get_voltage_sel = bd7181x_buck12_get_voltage_sel,
 	.set_voltage_time_sel = regulator_set_voltage_time_sel,
-	.set_ramp_delay = bd7181x_buck12_set_ramp_delay,
+	.set_ramp_delay = regulator_set_ramp_delay_regmap,
 };
 
 static const struct regulator_ops bd7181x_led_regulator_ops = {
@@ -499,6 +470,10 @@ static const struct regulator_ops bd7181x_led_regulator_ops = {
 			.vsel_mask = 0x3f,				\
 			.enable_reg = (ereg),				\
 			.enable_mask = 0x04,				\
+			.ramp_reg = (ereg),				\
+			.ramp_mask = BD71815_BUCK_RAMPRATE_MASK,	\
+			.ramp_delay_table = bd7181x_ramp_table,		\
+			.n_ramp_values = ARRAY_SIZE(bd7181x_ramp_table),\
 			.of_parse_cb = buck12_set_hw_dvs_levels,	\
 		},							\
 		.dvs = (_dvs),						\
-- 
2.25.4


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
