Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B9834D0A7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 14:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhC2M55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 08:57:57 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:33450 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhC2M5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 08:57:41 -0400
Received: by mail-lj1-f180.google.com with SMTP id 15so15879208ljj.0;
        Mon, 29 Mar 2021 05:57:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UJNxYjxrYMcId07K6NsPlynPvsrOQqM+TOZJRJlcxV0=;
        b=FsNlsRcoqQdcAO99DklRAyuMnM0su+ortDoRzgaYWn8tWfLk6/pvizT4svuzRkLVxO
         NIxbvy4cqvbGhOYK0YLeD1ReHFfoYBW8N+9dJWD+BuuixJXgn7G39sKNb3jav4RJ9g/I
         xreUkf/CrQo1J7muxLF+4Wq/7GO9mvPuDzcoaq4EpAc4joj+m/TbMjLF51GWRepEirx4
         zJHYsRK8XIYNKxJM89K519elIwrWGytHQLkPqKn0SY5hRcLPM5182BMfVRC42qLUgOQx
         Asst3aD4chLszszJRlE8AqAuL+0hAfyK4yvQayaJBKeJEg8dhxlGEtdOHG9AUNu+rmok
         zsAg==
X-Gm-Message-State: AOAM533H79927FcZWva1XdnacxGwGlhNWleONBYqaQRPIkls77jN2CJx
        kGXnTGG9t/JDZ/AO4n0axeQ=
X-Google-Smtp-Source: ABdhPJx7/4UdgSOjVVfPgToQqq1yxgLT5E6TYnTbWd0q+VpDRtRmr88wF4Na+h1uPQTqbswOgHCZ1g==
X-Received: by 2002:a2e:9c1:: with SMTP id 184mr18228750ljj.481.1617022660003;
        Mon, 29 Mar 2021 05:57:40 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::2])
        by smtp.gmail.com with ESMTPSA id z10sm1823970lfa.201.2021.03.29.05.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 05:57:39 -0700 (PDT)
Date:   Mon, 29 Mar 2021 15:57:33 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Subject: [PATCH v5 10/19] regulator: helpers: Export helper voltage listing
Message-ID: <1200ef7a50c84327ada019b85f6527b4fc9b5ce1.1617020713.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1617020713.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617020713.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers need to translate voltage values to selectors prior regulator
registration. Currently a regulator_desc based list_voltages helper is only
exported for regulators using the linear_ranges. Export similar helper also
for regulators using simple linear mapping.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
Changes since v3:
 - No changes
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
