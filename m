Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9C63BE8C5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 15:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhGGNb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 09:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbhGGNbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 09:31:50 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62071C06175F;
        Wed,  7 Jul 2021 06:29:09 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id i13so1051247plb.10;
        Wed, 07 Jul 2021 06:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3tXFf65jE+peM5K4uuLXTZYS3D5Fe8qF8gNC6VOLOJw=;
        b=oT81E56K1vyONefpVuCGGhQL+jV16a0aCVBZQmg+BKXTDmBe4elaSnYx3IV94WXh1L
         uPpEVBHZTDUjG/gWaPuc/hYKu/iAF8TB10aajnXeJ1ey+KyC+gSRdrEpZ6/p+VuHEqmC
         v36RrqTp67viTDa4WXxST736cfRzoLQWuqFPWcj++3Q7ON4tEW/1dq2F6CToFGeiL1Ew
         zeTQ4MXIXQ4CGOTzu5OMqqq23XIM4Dr62TEcQ61TLp9fLLSB+p0bUQa4rUSmVNltQqdT
         14EkAgggPhg9jd6r+veJohnXhWZwmuqyG0ixkX+sBDd+cypHdyeMY1y//qCFIkRE2Yqn
         k5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3tXFf65jE+peM5K4uuLXTZYS3D5Fe8qF8gNC6VOLOJw=;
        b=cx+58TDOM5MTL/hUGQDiZ/UCcgY8b+ypfd/Pio/+F5NOwm8seoXDT5ffcbvLtZWZCO
         Qu8C66npQ0vWLyL3GUzeERNPPw/T0wUEdVFnKKzeKb4ktaJ+7zaJ0/z5ySS8fu2LCfSc
         CUTR3DiVu3mIYPJeFhkcRgVDdmkcH3JB+FuhLpHHO72ob4xCsXUZRZVwBirSheycFFpv
         yii0AMgXU36BSr5twL8/amZtT28HfbowTiVAwBxAmLASJkWsOF6YgyLAFPUluUNvNmL7
         GZZXUW2lI02F6ajjG+BUBsT8ZWrmpN/euBrNOMnf77TcZ9iTpfamfEFUu3deTi0Wb28S
         FMhw==
X-Gm-Message-State: AOAM531n9amkrc+aQGoy4PXIwD2EJaHWXNiQnvYt7/tjZkZthRL91P9c
        F0k2xF/3TdTkWCvxyeRgEGk=
X-Google-Smtp-Source: ABdhPJxU6rO6rpBoxqUMzjm+1AIvTrm5klHOSH4fRVlWwR/UnkvvTvKrIeE2zLKK6U8aXTGV3i2XjA==
X-Received: by 2002:a17:90a:f0d4:: with SMTP id fa20mr6231060pjb.22.1625664548922;
        Wed, 07 Jul 2021 06:29:08 -0700 (PDT)
Received: from localhost.lan (p1284205-ipngn14601marunouchi.tokyo.ocn.ne.jp. [153.205.193.205])
        by smtp.gmail.com with ESMTPSA id v1sm18267745pjg.19.2021.07.07.06.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 06:29:07 -0700 (PDT)
Received: from x2.lan (localhost [127.0.0.1])
        by localhost.lan (Postfix) with ESMTPSA id 6627F9029DE;
        Wed,  7 Jul 2021 13:29:05 +0000 (GMT)
From:   Vincent Pelletier <plr.vincent@gmail.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Subject: [PATCH v3 2/3] hwmon: da9063: HWMON driver
Date:   Wed,  7 Jul 2021 13:25:03 +0000
Message-Id: <2c24ef5953401e80d92c907704bffeff1d024de0.1625662290.git.plr.vincent@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <c06db13bb5076a8ee48e38a74caf3b81e4a2d1f8.1625662290.git.plr.vincent@gmail.com>
References: <c06db13bb5076a8ee48e38a74caf3b81e4a2d1f8.1625662290.git.plr.vincent@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the HWMON driver for DA9063

Originally-from: Opensource [Steve Twiss] <stwiss.opensource@diasemi.com>
Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
---
Changes in v3:
- changed original author's Signed-off-by into an Originally-from.
- dropped license boilerplate
- only return ETIMEOUT if ADC result is not ready by the time the IRQ
  either triggered or timed out
- removed unnecessary lists
- changed a duplicate init_comptetion into a more useful reinit_completion
- dropped unused platform_set_drvdata
- moved temperature offset reading from mfd driver

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
 drivers/hwmon/da9063-hwmon.c | 260 +++++++++++++++++++++++++++++++++++
 3 files changed, 271 insertions(+)
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
index 000000000000..6367685536a1
--- /dev/null
+++ b/drivers/hwmon/da9063-hwmon.c
@@ -0,0 +1,260 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* da9063-hwmon.c - Hardware monitor support for DA9063
+ * Copyright (C) 2014 Dialog Semiconductor Ltd.
+ * Copyright (C) 2021 Vincent Pelletier <plr.vincent@gmail.com>
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
+	val = (channel & DA9063_ADC_MUX_MASK) | DA9063_ADC_MAN;
+	ret = regmap_update_bits(hwmon->da9063->regmap, DA9063_REG_ADC_MAN,
+				 DA9063_ADC_MUX_MASK | DA9063_ADC_MAN, val);
+	if (ret < 0)
+		goto err_mread;
+
+	ret = wait_for_completion_timeout(&hwmon->adc_ready,
+					  msecs_to_jiffies(100));
+	reinit_completion(&hwmon->adc_ready);
+	if (ret == 0)
+		dev_dbg(hwmon->da9063->dev,
+			"Timeout while waiting for ADC completion IRQ\n");
+
+	ret = regmap_read(hwmon->da9063->regmap, DA9063_REG_ADC_MAN, &adc_man);
+	if (ret < 0)
+		goto err_mread;
+
+	/* data value is not ready */
+	if (adc_man & DA9063_ADC_MAN) {
+		ret = -ETIMEDOUT;
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
+		adc_channel = DA9063_CHAN_TJUNC;
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
+		*str = "TJUNC";
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
+	unsigned int tmp;
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
+	ret = regmap_read(da9063->regmap, DA9063_REG_T_OFFSET, &tmp);
+	if (ret < 0) {
+		tmp = 0;
+		dev_warn(&pdev->dev,
+			 "Temperature trimming value cannot be read (defaulting to 0)\n");
+	}
+	hwmon->tjunc_offset = (signed char) tmp;
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
+MODULE_AUTHOR("Vincent Pelletier <plr.vincent@gmail.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DA9063_DRVNAME_HWMON);
-- 
2.32.0

