Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47CDE330B89
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 11:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhCHKoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 05:44:00 -0500
Received: from mail-lf1-f41.google.com ([209.85.167.41]:35736 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbhCHKny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 05:43:54 -0500
Received: by mail-lf1-f41.google.com with SMTP id e7so20308892lft.2;
        Mon, 08 Mar 2021 02:43:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zv7MUOzY1W6g6IXEp1WB+uFs9gUT+Dobp3SWJ4RPHow=;
        b=LQmtowJ1cySq0grzTqcL1j3FqHgm9XwUYdONXLrMs+9XrktrksghuXWvUExjjdfjFC
         QyU55YZiP38WTxfoddaDOA71hxk36/bk7voPcmoOnP54UTpu3k4ur9QGTDPGk3S78z6I
         kI/DJLJOuqtbLHKNcpfE96Lf+Rl8KJxP4LyhfuTkIpbOR1a0dHJlIiYs52XyMDIOZB0h
         Zq33H0bqJ3p9w102mPnaUHNhd++s9LQY9gPT7qt3eD0apAuaiyBwP98JrPul+D5zcbtY
         4J/noca0yxpuYDMmCivlOwR2+PyvPhRLnZB4v7M2kxOlnjbMdh6+/iOllGPrUNuosEJf
         NfXA==
X-Gm-Message-State: AOAM533zYnmXed2Fomxvnclbfp7mqpjCrAFyNR3xF3/KvdEO6U5fxyBw
        PUb4FtGJ+i2Ei7JeyAEImqc=
X-Google-Smtp-Source: ABdhPJytISpF5ATwjC+qQzUEnYHVk6a1kkIt/pnKqq5c/3/WLTsLs+CnjL9V0vswH4/kcKp22Hi7Mw==
X-Received: by 2002:a05:6512:118f:: with SMTP id g15mr14096427lfr.274.1615200232909;
        Mon, 08 Mar 2021 02:43:52 -0800 (PST)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id k29sm1312919lfj.125.2021.03.08.02.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 02:43:52 -0800 (PST)
Date:   Mon, 8 Mar 2021 12:43:46 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Subject: [PATCH v3 09/15] regulator: helpers: Export helper voltage listing
Message-ID: <b268bd3426dd7b1099674388ec42dd9fa21726da.1615198094.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1615198094.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1615198094.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers need to translate voltage values to selectors prior regulator
registration. Currently a regulator_desc based list_voltages helper is only
exported for regulators using the linear_ranges. Export similar helper also
for regulators using simple linear mapping.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/regulator/helpers.c      | 36 +++++++++++++++++++++++++-------
 include/linux/regulator/driver.h |  2 ++
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/helpers.c b/drivers/regulator/helpers.c
index f42b394a0c46..3e19ecbf7267 100644
--- a/drivers/regulator/helpers.c
+++ b/drivers/regulator/helpers.c
@@ -508,6 +508,33 @@ int regulator_map_voltage_pickable_linear_range(struct regulator_dev *rdev,
 }
 EXPORT_SYMBOL_GPL(regulator_map_voltage_pickable_linear_range);
 
+/**
+ * regulator_desc_list_voltage_linear - List voltages with simple calculation
+ *
+ * @desc: Regulator desc for regulator which volatges are to be listed
+ * @selector: Selector to convert into a voltage
+ *
+ * Regulators with a simple linear mapping between voltages and
+ * selectors can set min_uV and uV_step in the regulator descriptor
+ * and then use this function prior regulator registration to list
+ * the voltages. This is useful when voltages need to be listed during
+ * device-tree parsing.
+ */
+int regulator_desc_list_voltage_linear(const struct regulator_desc *desc,
+				       unsigned int selector)
+{
+	if (selector >= desc->n_voltages)
+		return -EINVAL;
+
+	if (selector < desc->linear_min_sel)
+		return 0;
+
+	selector -= desc->linear_min_sel;
+
+	return desc->min_uV + (desc->uV_step * selector);
+}
+EXPORT_SYMBOL_GPL(regulator_desc_list_voltage_linear);
+
 /**
  * regulator_list_voltage_linear - List voltages with simple calculation
  *
@@ -521,14 +548,7 @@ EXPORT_SYMBOL_GPL(regulator_map_voltage_pickable_linear_range);
 int regulator_list_voltage_linear(struct regulator_dev *rdev,
 				  unsigned int selector)
 {
-	if (selector >= rdev->desc->n_voltages)
-		return -EINVAL;
-	if (selector < rdev->desc->linear_min_sel)
-		return 0;
-
-	selector -= rdev->desc->linear_min_sel;
-
-	return rdev->desc->min_uV + (rdev->desc->uV_step * selector);
+	return regulator_desc_list_voltage_linear(rdev->desc, selector);
 }
 EXPORT_SYMBOL_GPL(regulator_list_voltage_linear);
 
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index d7c77ee370f3..39a540111645 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -543,4 +543,6 @@ void *regulator_get_init_drvdata(struct regulator_init_data *reg_init_data);
 int regulator_desc_list_voltage_linear_range(const struct regulator_desc *desc,
 					     unsigned int selector);
 
+int regulator_desc_list_voltage_linear(const struct regulator_desc *desc,
+				       unsigned int selector);
 #endif
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
