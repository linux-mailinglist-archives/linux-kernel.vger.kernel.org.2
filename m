Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F65834D0BC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 15:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhC2M7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 08:59:38 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:37581 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbhC2M7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 08:59:12 -0400
Received: by mail-lf1-f53.google.com with SMTP id q29so18224942lfb.4;
        Mon, 29 Mar 2021 05:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jfHxEj2A/gJhrIjTGvqiQOWPNM93N/Km1CsIkoTYEkg=;
        b=J9J2WNOC7cSKT9TbYLpIGKJjGn32lbd4jQMqImd+VBeshcw3eeYKFdwbpqs2n9zw5o
         U/wGn/59pztuJele95oUBZxAPpmwsJ16fZi/J40XKkrceFnogELnGh4hwYClqKlw8KvX
         xNRUDt26pPZJkChI7qYp9TH0QZ2QO0g2ZlSBhvTpsy34GjaLZEAT1Y3ZaeDk6O4cUmSk
         ErQMDDSGFenOmYsvg9AClSGfzEezkqg8V6XlJomoVdKfHGNhB79blqfFP1A4Fjps9NQt
         j2mFn3dS/w0K5jyHV7hI0P+tSGKZcuPzGd2BAf9gLv0gtaEyEvHr9II+labpZ7bemqYf
         dlaA==
X-Gm-Message-State: AOAM533J67OSJufTxy8xDCZrwc6kUZLLV2IeW8h48o+9m09zbC78C5th
        SrE1RjgVxFmmd6q3GRjqJQA=
X-Google-Smtp-Source: ABdhPJx2G8hPAXa16TStU29b5H9af5ao9230s1c6nAxAQ1maan4oAL4CJf05I2k7fQm2odTtlMvWVg==
X-Received: by 2002:a05:6512:20c6:: with SMTP id u6mr16081823lfr.493.1617022750926;
        Mon, 29 Mar 2021 05:59:10 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::2])
        by smtp.gmail.com with ESMTPSA id e25sm2432217ljo.113.2021.03.29.05.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 05:59:10 -0700 (PDT)
Date:   Mon, 29 Mar 2021 15:59:04 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Subject: [PATCH v5 13/19] regulator: Add regmap helper for ramp-delay setting
Message-ID: <f101f1db564cf32cb58719c77af0b00d7236bb89.1617020713.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1617020713.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617020713.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quite a few regulator ICs do support setting ramp-delay by writing a value
matching the delay to a ramp-delay register.

Provide a simple helper for table-based delay setting.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
Changes since v4:
 - new patch
 drivers/regulator/helpers.c      | 65 ++++++++++++++++++++++++++++++++
 include/linux/regulator/driver.h |  5 +++
 2 files changed, 70 insertions(+)

diff --git a/drivers/regulator/helpers.c b/drivers/regulator/helpers.c
index 3e19ecbf7267..0e16e31c968f 100644
--- a/drivers/regulator/helpers.c
+++ b/drivers/regulator/helpers.c
@@ -901,3 +901,68 @@ bool regulator_is_equal(struct regulator *reg1, struct regulator *reg2)
 	return reg1->rdev == reg2->rdev;
 }
 EXPORT_SYMBOL_GPL(regulator_is_equal);
+
+static int find_closest_bigger(unsigned int target, const unsigned int *table,
+			       unsigned int num_sel, unsigned int *sel)
+{
+	unsigned int s, tmp, max, maxsel = 0;
+	bool found = false;
+
+	max = table[0];
+
+	for (s = 0; s < num_sel; s++) {
+		if (table[s] > max) {
+			max = table[s];
+			maxsel = s;
+		}
+		if (table[s] >= target) {
+			if (!found || table[s] - target < tmp - target) {
+				tmp = table[s];
+				*sel = s;
+				found = true;
+				if (tmp == target)
+					break;
+			}
+		}
+	}
+
+	if (!found) {
+		*sel = maxsel;
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * regulator_set_ramp_delay_regmap - set_ramp_delay() helper
+ *
+ * @rdev: regulator to operate on
+ *
+ * Regulators that use regmap for their register I/O can set the ramp_reg
+ * and ramp_mask fields in their descriptor and then use this as their
+ * set_ramp_delay operation, saving some code.
+ */
+int regulator_set_ramp_delay_regmap(struct regulator_dev *rdev, int ramp_delay)
+{
+	int ret;
+	unsigned int sel;
+
+	if (!rdev->desc->n_ramp_values)
+		return -EINVAL;
+
+	ret = find_closest_bigger(ramp_delay, rdev->desc->ramp_delay_table,
+				  rdev->desc->n_ramp_values, &sel);
+
+	if (ret) {
+		dev_warn(rdev_get_dev(rdev),
+			 "Can't set ramp-delay %u, setting %u\n", ramp_delay,
+			 rdev->desc->ramp_delay_table[sel]);
+	}
+
+	sel <<= ffs(rdev->desc->ramp_mask) - 1;
+
+	return regmap_update_bits(rdev->regmap, rdev->desc->ramp_reg,
+				  rdev->desc->ramp_mask, sel);
+}
+EXPORT_SYMBOL_GPL(regulator_set_ramp_delay_regmap);
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 39a540111645..597ed117086f 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -373,6 +373,10 @@ struct regulator_desc {
 	unsigned int pull_down_reg;
 	unsigned int pull_down_mask;
 	unsigned int pull_down_val_on;
+	unsigned int ramp_reg;
+	unsigned int ramp_mask;
+	const unsigned int *ramp_delay_table;
+	unsigned int n_ramp_values;
 
 	unsigned int enable_time;
 
@@ -535,6 +539,7 @@ int regulator_set_current_limit_regmap(struct regulator_dev *rdev,
 				       int min_uA, int max_uA);
 int regulator_get_current_limit_regmap(struct regulator_dev *rdev);
 void *regulator_get_init_drvdata(struct regulator_init_data *reg_init_data);
+int regulator_set_ramp_delay_regmap(struct regulator_dev *rdev, int ramp_delay);
 
 /*
  * Helper functions intended to be used by regulator drivers prior registering
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
