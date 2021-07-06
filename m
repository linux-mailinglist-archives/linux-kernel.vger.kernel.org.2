Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2793BC447
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 02:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhGFAFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 20:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhGFAFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 20:05:07 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B669DC06175F;
        Mon,  5 Jul 2021 17:02:29 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id l11so12524986pji.5;
        Mon, 05 Jul 2021 17:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PKWeYXTBN7W6ZwW0JqC0fI34QU1Yyh7Wh5yE0KkK/+g=;
        b=nrpqhmOAvF2mVCtnxGr5oTMnBtkrVS9RD7oF+ikEeoJy/Y+EthYB0KZBiST8TjseU5
         U6X6YBprVxhTyEmRCd0PZf/IBk0Wn1A1ZN9XXGcaFzf3mB2v9PEu+Spe0l4EfSIqCyxN
         4Y4lgclaZn8yVEGV+Bvt6RjK89WCOUPNFvxjlOMht6tw4PRluOVSyP0fo7pL2q3nsOsT
         8re2ZQjdaiq7SDGTFpmE6hy9mvNORKLA85bFUj8SYmIzAqNrvPXVZ+OWEJoNn8ffZEZw
         SAuGfx6qT3rwmkUIoYAePzZpp+B9cfnVEe6+K7GPWPYk2dE59ou7xxl/rfIz3k8EUxQ6
         xqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PKWeYXTBN7W6ZwW0JqC0fI34QU1Yyh7Wh5yE0KkK/+g=;
        b=tMO55U6ik/CsSv/4uRmyI/d7lAfyo9YtIkd3Gcs+2mX/c2awIoZGMylrN9luzRri6F
         20aKGs3o7xcV7cxBO2mogUymrmfpUZhZh1tZd4uNjbJ/kp1UanPV/iNrXsFUEhfjqmBL
         HsUc4X0X+LN94Ox8yTl+8F7fVSth5BB/VeVLOQ8QxttaXfrPGk2+5r4p98P5M2QjMu8M
         80WJrO1wQZqzEy64dS6xpUP1FbehqZlIwBrNttLRETmrFcN/EYjSTYLYg7GwUMVolHuX
         t7/jRRuowT4q9DpPqQZqjTEHnLzuIndGEN9xuav/2a8n/7cfqR/SXhlWf4vKSP8AHQfj
         Vjpg==
X-Gm-Message-State: AOAM5326DJUyuzKQGDYpEIGKQ9fVlDPfzCXChVDoITNAH/K0hsv2E0YG
        tdpo3srkkHr5W4xBMZZS4Es=
X-Google-Smtp-Source: ABdhPJyYkiKzk8dSVA8c1RRIgdBluZTHvKlBMfuGmc69r+OY9LdNnPMwItKN8uW6VhuyjaMPZZ/GpQ==
X-Received: by 2002:a17:90a:4586:: with SMTP id v6mr17585829pjg.36.1625529749197;
        Mon, 05 Jul 2021 17:02:29 -0700 (PDT)
Received: from localhost.lan (p1284205-ipngn14601marunouchi.tokyo.ocn.ne.jp. [153.205.193.205])
        by smtp.gmail.com with ESMTPSA id b3sm14316427pfi.179.2021.07.05.17.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 17:02:28 -0700 (PDT)
Received: from x2.lan (localhost [127.0.0.1])
        by localhost.lan (Postfix) with ESMTPSA id 00EE39029DE;
        Tue,  6 Jul 2021 00:02:26 +0000 (GMT)
From:   Vincent Pelletier <plr.vincent@gmail.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Subject: [PATCH 2/3] hwmon: da9063: HWMON driver
Date:   Tue,  6 Jul 2021 00:01:56 +0000
Message-Id: <dcf98496c32a5fa76a7a0c99863934ef363f3b11.1625529219.git.plr.vincent@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1182ccb1b0bac9276967f4a11d971bd135c611f2.1625529219.git.plr.vincent@gmail.com>
References: <1182ccb1b0bac9276967f4a11d971bd135c611f2.1625529219.git.plr.vincent@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>

Add the HWMON driver for DA9063

Signed-off-by: Opensource [Steve Twiss] <stwiss.opensource@diasemi.com>

Simplify and modernise the code a bit.
Add minimal of_match_table.
Fix logic inversion in detecting conversion end.
Drop support for ADCIN: these are multi-purpose channels and must not
be reconfigured unless explicitly authorised by the board description.

Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
---
This patch depends on patch 1/3.
Originally submitted by Steve Twiss in 2014:
  https://marc.info/?l=linux-kernel&m=139560868309857&w=2

 drivers/hwmon/Kconfig                |  10 +
 drivers/hwmon/Makefile               |   1 +
 drivers/hwmon/da9063-hwmon.c         | 287 +++++++++++++++++++++++++++
 include/linux/mfd/da9063/registers.h |  34 ++++
 4 files changed, 332 insertions(+)
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
index 000000000000..35b5bb0290ca
--- /dev/null
+++ b/drivers/hwmon/da9063-hwmon.c
@@ -0,0 +1,287 @@
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
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/platform_device.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/regmap.h>
+#include <linux/mfd/da9063/core.h>
+#include <linux/mod_devicetable.h>
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
+static int da9063_adc_convert(struct da9063_hwmon *hwmon, int channel,
+			      int *value)
+{
+	int val = *value;
+	int ret = 0;
+
+	switch (channel) {
+	case DA9063_CHAN_VSYS:
+		val = ((DA9063_5V5 - DA9063_2V5) * val) / DA9063_ADC_MAX +
+			DA9063_2V5;
+		break;
+	case DA9063_CHAN_TJUNC:
+		val -= hwmon->tjunc_offset;
+		val = DA9063_TJUNC_M * val + DA9063_TJUNC_O;
+		break;
+	case DA9063_CHAN_VBBAT:
+		val = (DA9063_5V0 * val) / DA9063_ADC_MAX;
+		break;
+	default:
+		ret = -EINVAL;
+		goto err_convert;
+	}
+
+	*value = val;
+err_convert:
+	return ret;
+}
+
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
+	complete(&hwmon->adc_ready);
+	return IRQ_HANDLED;
+}
+
+static ssize_t da9063_adc_show(struct device *dev,
+			       struct device_attribute *devattr, char *buf)
+{
+	struct da9063_hwmon *hwmon = dev_get_drvdata(dev);
+	int channel = to_sensor_dev_attr(devattr)->index;
+	int val;
+	int ret;
+
+	switch (channel) {
+	case DA9063_CHAN_VSYS:
+	case DA9063_CHAN_TJUNC:
+	case DA9063_CHAN_VBBAT:
+		/* fallthrough for internal measures */
+		val = da9063_adc_manual_read(hwmon, channel);
+		if (val < 0) {
+			dev_err(dev, "ADC read error %d\n", val);
+			return val;
+		}
+		break;
+
+	default:
+		/* error case */
+		ret = -EINVAL;
+		goto err_read;
+	}
+
+	ret = da9063_adc_convert(hwmon, channel, &val);
+	if (ret < 0) {
+		dev_err(dev, "Failed to convert ADC value %d\n", ret);
+		goto err_read;
+	}
+
+	return sprintf(buf, "%d\n", val);
+err_read:
+	return ret;
+}
+
+
+static ssize_t da9063_label_show(struct device *dev,
+				 struct device_attribute *devattr, char *buf)
+{
+	int channel = to_sensor_dev_attr(devattr)->index;
+	char *label;
+
+	switch (channel) {
+	case DA9063_CHAN_VSYS:
+		label = "VSYS";
+		break;
+	case DA9063_CHAN_TJUNC:
+		label = "TJUNC";
+		break;
+	case DA9063_CHAN_VBBAT:
+		label = "VBBAT";
+		break;
+	default:
+		label = "UNKNOWN";
+	}
+
+	return sprintf(buf, "%s\n", label);
+}
+
+static SENSOR_DEVICE_ATTR_RO(in0_input,
+			  da9063_adc, DA9063_CHAN_VSYS);
+static SENSOR_DEVICE_ATTR_RO(in0_label,
+			  da9063_label, DA9063_CHAN_VSYS);
+
+static SENSOR_DEVICE_ATTR_RO(in4_input,
+			  da9063_adc, DA9063_CHAN_VBBAT);
+static SENSOR_DEVICE_ATTR_RO(in4_label,
+			  da9063_label, DA9063_CHAN_VBBAT);
+
+static SENSOR_DEVICE_ATTR_RO(temp1_input,
+			  da9063_adc, DA9063_CHAN_TJUNC);
+static SENSOR_DEVICE_ATTR_RO(temp1_label,
+			  da9063_label, DA9063_CHAN_TJUNC);
+
+static struct attribute *da9063_attrs[] = {
+	&sensor_dev_attr_in0_input.dev_attr.attr,
+	&sensor_dev_attr_in0_label.dev_attr.attr,
+	&sensor_dev_attr_in4_input.dev_attr.attr,
+	&sensor_dev_attr_in4_label.dev_attr.attr,
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_label.dev_attr.attr,
+	NULL
+};
+
+ATTRIBUTE_GROUPS(da9063);
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
+	hwmon_dev = devm_hwmon_device_register_with_groups(&pdev->dev,
+							   "da9063",
+							   hwmon, da9063_groups);
+
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static const struct of_device_id da9063_dt_ids[] = {
+	{ .compatible = DA9063_DRVNAME_HWMON, },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, da9063_dt_ids);
+
+static struct platform_driver da9063_hwmon_driver = {
+	.probe = da9063_hwmon_probe,
+	.driver = {
+		.name = DA9063_DRVNAME_HWMON,
+		.of_match_table = da9063_dt_ids,
+	},
+};
+module_platform_driver(da9063_hwmon_driver);
+
+MODULE_DESCRIPTION("Hardware monitor support device driver for Dialog DA9063");
+MODULE_AUTHOR("S Twiss <stwiss.opensource@diasemi.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DA9063_DRVNAME_HWMON);
diff --git a/include/linux/mfd/da9063/registers.h b/include/linux/mfd/da9063/registers.h
index 6e0f66a2e727..297631ddda39 100644
--- a/include/linux/mfd/da9063/registers.h
+++ b/include/linux/mfd/da9063/registers.h
@@ -512,6 +512,7 @@
 
 /* DA9063_REG_GPIO_0_1 (addr=0x15) */
 #define	DA9063_GPIO0_PIN_MASK			0x03
+#define	DA9063_GPIO0_PIN_MASK_SHIFT		0
 #define		DA9063_GPIO0_PIN_ADCIN1		0x00
 #define		DA9063_GPIO0_PIN_GPI		0x01
 #define		DA9063_GPIO0_PIN_GPO_OD		0x02
@@ -523,6 +524,7 @@
 #define		DA9063_GPIO0_TYPE_GPO_VDD_IO2	0x04
 #define	DA9063_GPIO0_NO_WAKEUP			0x08
 #define	DA9063_GPIO1_PIN_MASK			0x30
+#define	DA9063_GPIO1_PIN_MASK_SHIFT		4
 #define		DA9063_GPIO1_PIN_ADCIN2_COMP	0x00
 #define		DA9063_GPIO1_PIN_GPI		0x10
 #define		DA9063_GPIO1_PIN_GPO_OD		0x20
@@ -536,6 +538,7 @@
 
 /* DA9063_REG_GPIO_2_3 (addr=0x16) */
 #define	DA9063_GPIO2_PIN_MASK			0x03
+#define	DA9063_GPIO2_PIN_MASK_SHIFT		0
 #define		DA9063_GPIO2_PIN_ADCIN3		0x00
 #define		DA9063_GPIO2_PIN_GPI		0x01
 #define		DA9063_GPIO2_PIN_GPO_PSS	0x02
@@ -851,6 +854,7 @@
 #define	DA9063_VSYS_VAL_BASE			0x00
 
 /* DA9063_REG_ADC_RES_L (addr=0x37) */
+#define	DA9063_ADC_RES_L_SHIFT			6
 #define	DA9063_ADC_RES_L_BITS			2
 #define	DA9063_ADC_RES_L_MASK			0xC0
 
@@ -1014,6 +1018,36 @@
 #define DA9063_GPIO_DIM				0x80
 #define DA9063_GPIO_PWM_MASK			0x7F
 
+/* DA9063_REG_ADC_CFG (addr=0xC9) */
+#define DA9063_REG_ADCIN1_CUR_MASK		0x03
+#define DA9063_REG_ADCIN1_CUR_SHIFT		0
+#define		DA9063_ADCIN1_CUR_1UA		0x00
+#define		DA9063_ADCIN1_CUR_2UA		0x01
+#define		DA9063_ADCIN1_CUR_10UA		0x02
+#define		DA9063_ADCIN1_CUR_40UA		0x03
+#define DA9063_REG_ADCIN2_CUR_MASK		0x0C
+#define DA9063_REG_ADCIN2_CUR_SHIFT		2
+#define		DA9063_ADCIN2_CUR_1UA		0x00
+#define		DA9063_ADCIN2_CUR_2UA		0x01
+#define		DA9063_ADCIN2_CUR_10UA		0x02
+#define		DA9063_ADCIN2_CUR_40UA		0x03
+#define DA9063_REG_ADCIN3_CUR_MASK		0x10
+#define DA9063_REG_ADCIN3_CUR_SHIFT		4
+#define		DA9063_ADCIN3_CUR_10UA		0x00
+#define		DA9063_ADCIN3_CUR_40UA		0x01
+#define DA9063_REG_ADCIN1_DEB_MASK		0x20
+#define DA9063_REG_ADCIN1_DEB_SHIFT		5
+#define		DA9063_ADCIN1_DEB_OFF		0x00
+#define		DA9063_ADCIN1_DEB_ON		0x01
+#define DA9063_REG_ADCIN2_DEB_MASK		0x40
+#define DA9063_REG_ADCIN2_DEB_SHIFT		6
+#define		DA9063_ADCIN2_DEB_OFF		0x00
+#define		DA9063_ADCIN2_DEB_ON		0x01
+#define DA9063_REG_ADCIN3_DEB_MASK		0x80
+#define DA9063_REG_ADCIN3_DEB_SHIFT		7
+#define		DA9063_ADCIN3_DEB_OFF		0x00
+#define		DA9063_ADCIN3_DEB_ON		0x01
+
 /* DA9063_REG_CONFIG_H (addr=0x10D) */
 #define DA9063_PWM_CLK_MASK			0x01
 #define		DA9063_PWM_CLK_PWM2MHZ		0x00
-- 
2.32.0

