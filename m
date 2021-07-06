Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346C93BD8CA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 16:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbhGFOr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 10:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbhGFOqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 10:46:55 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAC6C05BD15;
        Tue,  6 Jul 2021 07:34:56 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id in17-20020a17090b4391b0290170ba0ec7fcso1617794pjb.4;
        Tue, 06 Jul 2021 07:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=eNF9oLx4kExTiaLBg2YNFpP2TX4DRf3vplo9WVWF7eY=;
        b=WHXZ49ydnWLrfNjX8TuLD9hdH5mspFA7k/Po3Mr6ojp5XqWnajQX6fnn4X0aCEOZXy
         jEk8kUJyutHkBFOCIPFJZhIR2cWlezDOKEVe0hY74rFnk/eCma/llrpOAZ12QT0uzXxn
         K+vx0fJebwZjUJ4S4svkM28u5av7JkeAEVnlTaIXlzUTPIbRaa7W3r9kFQDNQG+Fj6GC
         Ow6MTF7aFIxizVrgwoeHRxKtKIHB8nbkaG41m1tyIXi6HTCNEjE43IHFqdSZRSo1CnNg
         04Luoz2MWVjKwg9n+KzBLcY/w9y7q5IUTX42bwJXLuYB48MxdhWh4OaKiWHnk1Mo4Cz7
         j1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eNF9oLx4kExTiaLBg2YNFpP2TX4DRf3vplo9WVWF7eY=;
        b=r0TMy8wCfxsEC3CQ49KHoF81tSqiv5NL5OVSp0naIIszel1VsvEj0sBPJfWVtiQeQ8
         ldVnFUECj1ZXPE8BxH9a7syEvL6L2+0cHsYxwKkI31YcvmjEdfKnmQLDnlAdlztxL/99
         ylJQW6Jdn+cHidHQPBmc9csCzQ6EpCDh3ZoegM91pyUkQmdBcF3PI2PrDb9S4dixn5tm
         0kTcD+/sCfvfaSDdYoh5G5X75PNaAYK+JgNWZh1NP33Qv5PnB/WiMiEJ9sPIci+ZBrqT
         3equc8oVOxOc22kKlnBmmMdTxjOBA8Efvr/vCQ1LSf7EW4KOtiuyZvy8jsL0rs6bV36l
         eISA==
X-Gm-Message-State: AOAM530xbEBJz+DftcsjGlXbK98pfC7ctHS/r2g/gugdy7r2vxtQT8JX
        U7c3vDN0m2UtLrlYVosn2dQ=
X-Google-Smtp-Source: ABdhPJzeEs+VDyKty9PqyICHj2TywJv/nH1jHqGx2LOEnSamdxbGnqVra9GNH0gDBf8iiFvHU8ewDg==
X-Received: by 2002:a17:90a:7546:: with SMTP id q64mr851863pjk.174.1625582096252;
        Tue, 06 Jul 2021 07:34:56 -0700 (PDT)
Received: from localhost.lan (p1284205-ipngn14601marunouchi.tokyo.ocn.ne.jp. [153.205.193.205])
        by smtp.gmail.com with ESMTPSA id w17sm14761636pjh.54.2021.07.06.07.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 07:34:54 -0700 (PDT)
Received: from x2.lan (localhost [127.0.0.1])
        by localhost.lan (Postfix) with ESMTPSA id 7C3899029DE;
        Tue,  6 Jul 2021 14:34:52 +0000 (GMT)
From:   Vincent Pelletier <plr.vincent@gmail.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Subject: [PATCH 2/3] hwmon: da9063: HWMON driver
Date:   Tue,  6 Jul 2021 14:34:48 +0000
Message-Id: <dff04323fc1b0177c1c08d3670333a839af4c268.1625581991.git.plr.vincent@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <850a353432cd676f96889cede291232abf58918d.1625581991.git.plr.vincent@gmail.com>
References: <850a353432cd676f96889cede291232abf58918d.1625581991.git.plr.vincent@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>

Add the HWMON driver for DA9063

Signed-off-by: Opensource [Steve Twiss] <stwiss.opensource@diasemi.com>

Simplify and modernise the code a bit.
Fix logic inversion in detecting conversion end.
Drop support for ADCIN: these are multi-purpose channels and must not
be reconfigured unless explicitly authorised by the board description.

Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
---
Changes in v2:
- drop of_match_table: this should be meaningless in such sub-function
  driver (at least judging by other sub-function drivers for the da9063)
- sort includes
- switch to devm_hwmon_device_register_with_info
- registers.h changes moved to patch 1
- add SPDX header

This patch depends on patch 1/3.
Originally submitted by Steve Twiss in 2014:
  https://marc.info/?l=linux-kernel&m=139560868309857&w=2

 drivers/hwmon/Kconfig        |  10 ++
 drivers/hwmon/Makefile       |   1 +
 drivers/hwmon/da9063-hwmon.c | 275 +++++++++++++++++++++++++++++++++++
 3 files changed, 286 insertions(+)
 create mode 100644 drivers/hwmon/da9063-hwmon.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 87624902ea80..17244cfaa855 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -515,6 +515,16 @@ config SENSORS_DA9055
 	  This driver can also be built as a module. If so, the module
 	  will be called da9055-hwmon.
 
+config SENSORS_DA9063
+	tristate "Dialog Semiconductor DA9063"
+	depends on MFD_DA9063
+	help
+	  If you say yes here you get support for the hardware
+	  monitoring features of the DA9063 Power Management IC.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called da9063-hwmon.
+
 config SENSORS_I5K_AMB
 	tristate "FB-DIMM AMB temperature sensor on Intel 5000 series chipsets"
 	depends on PCI
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 59e78bc212cf..6855711ed9ec 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -60,6 +60,7 @@ obj-$(CONFIG_SENSORS_CORSAIR_CPRO) += corsair-cpro.o
 obj-$(CONFIG_SENSORS_CORSAIR_PSU) += corsair-psu.o
 obj-$(CONFIG_SENSORS_DA9052_ADC)+= da9052-hwmon.o
 obj-$(CONFIG_SENSORS_DA9055)+= da9055-hwmon.o
+obj-$(CONFIG_SENSORS_DA9063)	+= da9063-hwmon.o
 obj-$(CONFIG_SENSORS_DELL_SMM)	+= dell-smm-hwmon.o
 obj-$(CONFIG_SENSORS_DME1737)	+= dme1737.o
 obj-$(CONFIG_SENSORS_DRIVETEMP)	+= drivetemp.o
diff --git a/drivers/hwmon/da9063-hwmon.c b/drivers/hwmon/da9063-hwmon.c
new file mode 100644
index 000000000000..f020be5d5d6b
--- /dev/null
+++ b/drivers/hwmon/da9063-hwmon.c
@@ -0,0 +1,275 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* da9063-hwmon.c - Hardware monitor support for DA9063
+ * Copyright (C) 2014 Dialog Semiconductor Ltd.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Library General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Library General Public License for more details.
+ */
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mfd/da9063/core.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#define DA9063_ADC_RES	(1 << (DA9063_ADC_RES_L_BITS + DA9063_ADC_RES_M_BITS))
+#define DA9063_ADC_MAX	(DA9063_ADC_RES - 1)
+#define DA9063_2V5	2500
+#define DA9063_5V0	5000
+#define DA9063_5V5	5500
+#define DA9063_TJUNC_M	-398
+#define DA9063_TJUNC_O	330000
+#define DA9063_VBBAT_M	2048
+
+enum da9063_adc {
+	DA9063_CHAN_VSYS = DA9063_ADC_MUX_VSYS,
+	DA9063_CHAN_ADCIN1 = DA9063_ADC_MUX_ADCIN1,
+	DA9063_CHAN_ADCIN2 = DA9063_ADC_MUX_ADCIN2,
+	DA9063_CHAN_ADCIN3 = DA9063_ADC_MUX_ADCIN3,
+	DA9063_CHAN_TJUNC = DA9063_ADC_MUX_T_SENSE,
+	DA9063_CHAN_VBBAT = DA9063_ADC_MUX_VBBAT,
+	DA9063_CHAN_LDO_G1 = DA9063_ADC_MUX_LDO_G1,
+	DA9063_CHAN_LDO_G2 = DA9063_ADC_MUX_LDO_G2,
+	DA9063_CHAN_LDO_G3 = DA9063_ADC_MUX_LDO_G3
+};
+
+struct da9063_hwmon {
+	struct da9063 *da9063;
+	struct mutex hwmon_mutex;
+	struct completion adc_ready;
+	signed char tjunc_offset;
+};
+
+static int da9063_adc_manual_read(struct da9063_hwmon *hwmon, int channel)
+{
+	int ret;
+	unsigned char val;
+	unsigned char data[2];
+	int adc_man;
+
+	mutex_lock(&hwmon->hwmon_mutex);
+
+	init_completion(&hwmon->adc_ready);
+
+	val = (channel & DA9063_ADC_MUX_MASK) | DA9063_ADC_MAN;
+	ret = regmap_update_bits(hwmon->da9063->regmap, DA9063_REG_ADC_MAN,
+				 DA9063_ADC_MUX_MASK | DA9063_ADC_MAN, val);
+	if (ret < 0)
+		goto err_mread;
+
+	ret = wait_for_completion_timeout(&hwmon->adc_ready,
+					  msecs_to_jiffies(1000));
+	if (ret == 0) {
+		ret = -ETIMEDOUT;
+		goto err_mread;
+	}
+
+	ret = regmap_read(hwmon->da9063->regmap, DA9063_REG_ADC_MAN, &adc_man);
+	if (ret < 0)
+		goto err_mread;
+
+	/* data value is not ready */
+	if (adc_man & DA9063_ADC_MAN) {
+		ret = -EINVAL;
+		goto err_mread;
+	}
+
+	ret = regmap_bulk_read(hwmon->da9063->regmap,
+			       DA9063_REG_ADC_RES_L, data, 2);
+	if (ret < 0)
+		goto err_mread;
+
+	ret = (data[0] & DA9063_ADC_RES_L_MASK) >> DA9063_ADC_RES_L_SHIFT;
+	ret |= data[1] << DA9063_ADC_RES_L_BITS;
+err_mread:
+	mutex_unlock(&hwmon->hwmon_mutex);
+	return ret;
+}
+
+static irqreturn_t da9063_hwmon_irq_handler(int irq, void *irq_data)
+{
+	struct da9063_hwmon *hwmon = irq_data;
+
+	complete(&hwmon->adc_ready);
+	return IRQ_HANDLED;
+}
+
+static umode_t da9063_is_visible(const void *drvdata, enum
+				 hwmon_sensor_types type, u32 attr, int channel)
+{
+	return 0444;
+}
+
+static const enum da9063_adc da9063_in_index[] = {
+	DA9063_CHAN_VSYS, DA9063_CHAN_VBBAT
+};
+
+static const enum da9063_adc da9063_temp_index[] = {
+	DA9063_CHAN_TJUNC
+};
+
+static int da9063_read(struct device *dev, enum hwmon_sensor_types type,
+		       u32 attr, int channel, long *val)
+{
+	struct da9063_hwmon *hwmon = dev_get_drvdata(dev);
+	enum da9063_adc adc_channel;
+	int tmp;
+
+	switch (type) {
+	case hwmon_in:
+		if (attr != hwmon_in_input)
+			return -EOPNOTSUPP;
+		adc_channel = da9063_in_index[channel];
+		break;
+	case hwmon_temp:
+		if (attr != hwmon_temp_input)
+			return -EOPNOTSUPP;
+		adc_channel = da9063_temp_index[channel];
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	tmp = da9063_adc_manual_read(hwmon, adc_channel);
+	if (tmp < 0)
+		return tmp;
+
+	switch (adc_channel) {
+	case DA9063_CHAN_VSYS:
+		*val = ((DA9063_5V5 - DA9063_2V5) * tmp) / DA9063_ADC_MAX +
+			DA9063_2V5;
+		break;
+	case DA9063_CHAN_TJUNC:
+		tmp -= hwmon->tjunc_offset;
+		*val = DA9063_TJUNC_M * tmp + DA9063_TJUNC_O;
+		break;
+	case DA9063_CHAN_VBBAT:
+		*val = (DA9063_5V0 * tmp) / DA9063_ADC_MAX;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const char * const da9063_in_name[] = {
+	"VSYS", "VBBAT"
+};
+
+static const char * const da9063_temp_name[] = {
+	"TJUNC"
+};
+
+static int da9063_read_string(struct device *dev, enum hwmon_sensor_types type,
+			      u32 attr, int channel, const char **str)
+{
+	switch (type) {
+	case hwmon_in:
+		if (attr != hwmon_in_label)
+			return -EOPNOTSUPP;
+		*str = da9063_in_name[channel];
+		break;
+	case hwmon_temp:
+		if (attr != hwmon_temp_label)
+			return -EOPNOTSUPP;
+		*str = da9063_temp_name[channel];
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static const struct hwmon_ops da9063_ops = {
+	.is_visible = da9063_is_visible,
+	.read = da9063_read,
+	.read_string = da9063_read_string,
+};
+
+static const struct hwmon_channel_info *da9063_channel_info[] = {
+	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
+	HWMON_CHANNEL_INFO(in,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL),
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT | HWMON_T_LABEL),
+	NULL
+};
+
+static const struct hwmon_chip_info da9063_chip_info = {
+	.ops = &da9063_ops,
+	.info = da9063_channel_info,
+};
+
+static int da9063_hwmon_probe(struct platform_device *pdev)
+{
+	struct da9063 *da9063 = dev_get_drvdata(pdev->dev.parent);
+	struct da9063_hwmon *hwmon;
+	struct device *hwmon_dev;
+	int irq;
+	int ret;
+
+	hwmon = devm_kzalloc(&pdev->dev, sizeof(struct da9063_hwmon),
+			     GFP_KERNEL);
+	if (!hwmon)
+		return -ENOMEM;
+
+	mutex_init(&hwmon->hwmon_mutex);
+	init_completion(&hwmon->adc_ready);
+	hwmon->da9063 = da9063;
+
+	irq = platform_get_irq_byname(pdev, DA9063_DRVNAME_HWMON);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+					da9063_hwmon_irq_handler,
+					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+					"HWMON", hwmon);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to request IRQ.\n");
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, hwmon);
+
+	/* set trim temperature offset to value read at startup */
+	hwmon->tjunc_offset = (signed char)hwmon->da9063->t_offset;
+
+	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev, "da9063",
+							 hwmon,
+							 &da9063_chip_info,
+							 NULL);
+
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static struct platform_driver da9063_hwmon_driver = {
+	.probe = da9063_hwmon_probe,
+	.driver = {
+		.name = DA9063_DRVNAME_HWMON,
+	},
+};
+module_platform_driver(da9063_hwmon_driver);
+
+MODULE_DESCRIPTION("Hardware monitor support device driver for Dialog DA9063");
+MODULE_AUTHOR("S Twiss <stwiss.opensource@diasemi.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DA9063_DRVNAME_HWMON);
-- 
2.32.0

