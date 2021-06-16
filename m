Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0933AA303
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 20:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbhFPSSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 14:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbhFPSSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 14:18:14 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B141AC061574;
        Wed, 16 Jun 2021 11:16:06 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id w21so390409edv.3;
        Wed, 16 Jun 2021 11:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FPqFOIozSf3rCtTwt0M6d7A7pQkgsZ7Nkc9uZmlkjQw=;
        b=QF5kcheVWSpTYigPXp+dpjcgzatxaVrO836eSGfy2efQdWfePZiKbCxXsxq5syeZp0
         8Q43txMkMs+sgmkC9XYInYKgn40GF9V9lSM6AXXdpHyOYHcCHzBXzYfuSXDZOjSxFYv1
         pFlS1gDCk7xenKlHUfprqUC48lOkKuWMFUcVihwr6G3Sv8DuSYldIiulyAqmlalkr3Ls
         MGPlUCTUcCcOleF3FbmtTLDiIpMZJINXuY5806F88WG+L6faDzTLyxZD/EXrp0LlcxTD
         FCPHJMcTbZQqKcE0SUtNZzJNz+CKESaIV2eCVn8WIQ1Xc9nsmOHRcQUz164PfkIJN9tL
         js6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=FPqFOIozSf3rCtTwt0M6d7A7pQkgsZ7Nkc9uZmlkjQw=;
        b=Ybt2vihxbxJo35Z7oni4iB9aik2AMkfDejDl+1pqzfS3DNXJ+ozGSfG7SRqLY9SVMJ
         X8iH5e5kFY9HErMD1QetkhClbQYfXLCF3wP90BuKJEPl+VT/uRnErb/sYTkb13tVTyIk
         xbIQ3MJ2zmG326iJ+UUEAJuSFkLeMxKEpK04s2RNe2mdcOGHzWCQn0G/wjVo5dvcEPc8
         HfcEC7S2wGl+sstxVQYi7cfvqBMKrNWgyTgtTHqXjq3pT9rFncGRc48xpLxpQQyyGR/U
         r97GEd4MqKyD6POkqlrYXKCLNV+qE0zB63nbsRjcSFako/NLAgu+56H7lA4nUMmcrtUJ
         toKQ==
X-Gm-Message-State: AOAM532EHcs/a9+BrqZY6n7VzYqtjh5g4c5w2iYffL4il3b+W6IOSVGm
        7AvYQt7WBblU4uwQ6o0eNuU=
X-Google-Smtp-Source: ABdhPJyWhchKjMBPSgvIT27uKnGgyaH/QtdfuQFChyoM9Mk9uAqmXIgfcohy56M6Ik7QnaVcjCyroA==
X-Received: by 2002:aa7:c64e:: with SMTP id z14mr1225528edr.119.1623867365278;
        Wed, 16 Jun 2021 11:16:05 -0700 (PDT)
Received: from stitch.. ([82.192.166.82])
        by smtp.gmail.com with ESMTPSA id p10sm2439599edy.86.2021.06.16.11.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 11:16:04 -0700 (PDT)
Sender: Emil Renner Berthing <emil.renner.berthing@gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Samin Guo <samin.guo@starfivetech.com>
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] hwmon: (sfctemp) Add StarFive JH7100 temperature sensor
Date:   Wed, 16 Jun 2021 20:15:45 +0200
Message-Id: <20210616181545.496149-3-kernel@esmil.dk>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210616181545.496149-1-kernel@esmil.dk>
References: <20210616181545.496149-1-kernel@esmil.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register definitions based on sfctemp driver in the StarFive
5.10 kernel by Samin Guo <samin.guo@starfivetech.com>.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---

@Samin: Only the register definitions and conversion constants are left
from your driver, but still it would be really nice if you could reply
to this mail with your Signed-off-by. Thanks!


 drivers/hwmon/Kconfig   |   9 ++
 drivers/hwmon/Makefile  |   1 +
 drivers/hwmon/sfctemp.c | 309 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 319 insertions(+)
 create mode 100644 drivers/hwmon/sfctemp.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 87624902ea80..fa7562920dfa 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1751,6 +1751,15 @@ config SENSORS_STTS751
 	  This driver can also be built as a module. If so, the module
 	  will be called stts751.
 
+config SENSORS_SFCTEMP
+	tristate "Starfive JH7100 temperature sensor"
+	help
+	  If you say yes here you get support for temperature sensor
+	  on the Starfive JH7100 SoC.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called sfctemp.
+
 config SENSORS_SMM665
 	tristate "Summit Microelectronics SMM665"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 59e78bc212cf..3723eb580bf3 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -167,6 +167,7 @@ obj-$(CONFIG_SENSORS_SBTSI)	+= sbtsi_temp.o
 obj-$(CONFIG_SENSORS_SCH56XX_COMMON)+= sch56xx-common.o
 obj-$(CONFIG_SENSORS_SCH5627)	+= sch5627.o
 obj-$(CONFIG_SENSORS_SCH5636)	+= sch5636.o
+obj-$(CONFIG_SENSORS_SFCTEMP)	+= sfctemp.o
 obj-$(CONFIG_SENSORS_SL28CPLD)	+= sl28cpld-hwmon.o
 obj-$(CONFIG_SENSORS_SHT15)	+= sht15.o
 obj-$(CONFIG_SENSORS_SHT21)	+= sht21.o
diff --git a/drivers/hwmon/sfctemp.c b/drivers/hwmon/sfctemp.c
new file mode 100644
index 000000000000..62a838063e4e
--- /dev/null
+++ b/drivers/hwmon/sfctemp.c
@@ -0,0 +1,309 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Emil Renner Berthing <kernel@esmil.dk>
+ * Copyright (C) 2021 Samin Guo <samin.guo@starfivetech.com>
+ */
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/hwmon.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+/* TempSensor reset. The RSTN can be de-asserted once the analog core has
+ * powered up. Trst(min 100ns)
+ * 0:reset  1:de-assert */
+#define SFCTEMP_RSTN     BIT(0)
+
+/* TempSensor analog core power down. The analog core will be powered up
+ * Tpu(min 50us) after PD is de-asserted. RSTN should be held low until the
+ * analog core is powered up.
+ * 0:power up  1:power down */
+#define SFCTEMP_PD       BIT(1)
+
+/* TempSensor start conversion enable.
+ * 0:disable  1:enable */
+#define SFCTEMP_RUN      BIT(2)
+
+/* TempSensor calibration mode enable.
+ * 0:disable  1:enable */
+#define SFCTEMP_CAL      BIT(4)
+
+/* TempSensor signature enable. Generate a toggle value outputting on DOUT for
+ * test purpose.
+ * 0:disable  1:enable */
+#define SFCTEMP_SGN      BIT(5)
+
+/* TempSensor test access control.
+ * 0000:normal 0001:Test1  0010:Test2  0011:Test3
+ * 0100:Test4  1000:Test8  1001:Test9 */
+#define SFCTEMP_TM_Pos   12
+#define SFCTEMP_TM_Msk   GENMASK(15, 12)
+
+/* TempSensor conversion value output.
+ * Temp(c)=DOUT*Y/4094 - K */
+#define SFCTEMP_DOUT_Pos 16
+#define SFCTEMP_DOUT_Msk GENMASK(27, 16)
+
+/* TempSensor digital test output. */
+#define SFCTEMP_DIGO     BIT(31)
+
+/* DOUT to Celcius conversion constants */
+#define SFCTEMP_Y1000 237500L
+#define SFCTEMP_Z       4094L
+#define SFCTEMP_K1000  81100L
+
+struct sfctemp {
+	struct mutex lock;
+	struct completion conversion_done;
+	void __iomem *regs;
+	bool enabled;
+};
+
+static irqreturn_t sfctemp_isr(int irq, void *data)
+{
+	struct sfctemp *sfctemp = data;
+
+	complete(&sfctemp->conversion_done);
+	return IRQ_HANDLED;
+}
+
+static void sfctemp_power_up(struct sfctemp *sfctemp)
+{
+	/* make sure we're powered down first */
+	writel(SFCTEMP_PD, sfctemp->regs);
+	udelay(1);
+
+	writel(0, sfctemp->regs);
+	/* wait t_pu(50us) + t_rst(100ns) */
+	usleep_range(60, 200);
+
+	/* de-assert reset */
+	writel(SFCTEMP_RSTN, sfctemp->regs);
+	udelay(1); /* wait t_su(500ps) */
+}
+
+static void sfctemp_power_down(struct sfctemp *sfctemp)
+{
+	writel(SFCTEMP_PD, sfctemp->regs);
+}
+
+static void sfctemp_run_single(struct sfctemp *sfctemp)
+{
+	writel(SFCTEMP_RSTN | SFCTEMP_RUN, sfctemp->regs);
+	udelay(1);
+	writel(SFCTEMP_RSTN, sfctemp->regs);
+}
+
+static int sfctemp_enable(struct sfctemp *sfctemp)
+{
+	mutex_lock(&sfctemp->lock);
+	if (sfctemp->enabled)
+		goto done;
+
+	sfctemp_power_up(sfctemp);
+	sfctemp->enabled = true;
+done:
+	mutex_unlock(&sfctemp->lock);
+	return 0;
+}
+
+static int sfctemp_disable(struct sfctemp *sfctemp)
+{
+	mutex_lock(&sfctemp->lock);
+	if (!sfctemp->enabled)
+		goto done;
+
+	sfctemp_power_down(sfctemp);
+	sfctemp->enabled = false;
+done:
+	mutex_unlock(&sfctemp->lock);
+	return 0;
+}
+
+static int sfctemp_convert(struct sfctemp *sfctemp, long *val)
+{
+	long ret;
+
+	mutex_lock(&sfctemp->lock);
+	if (!sfctemp->enabled) {
+		ret = -ENODATA;
+		goto out;
+	}
+
+	sfctemp_run_single(sfctemp);
+
+	ret = wait_for_completion_interruptible_timeout(&sfctemp->conversion_done,
+			                                msecs_to_jiffies(10));
+	if (ret < 0)
+		goto out;
+
+	/* calculate temperature in milli Celcius */
+	*val = (long)((readl(sfctemp->regs) & SFCTEMP_DOUT_Msk) >> SFCTEMP_DOUT_Pos)
+		* SFCTEMP_Y1000 / SFCTEMP_Z - SFCTEMP_K1000;
+
+	ret = 0;
+out:
+	mutex_unlock(&sfctemp->lock);
+	return ret;
+}
+
+static umode_t sfctemp_is_visible(const void *data, enum hwmon_sensor_types type,
+				  u32 attr, int channel)
+{
+	switch (type) {
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_enable:
+			return 0644;
+		case hwmon_temp_input:
+			return 0444;
+		}
+		return 0;
+	default:
+		return 0;
+	}
+}
+
+static int sfctemp_read(struct device *dev, enum hwmon_sensor_types type,
+			u32 attr, int channel, long *val)
+{
+	struct sfctemp *sfctemp = dev_get_drvdata(dev);
+
+	switch (type) {
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_enable:
+			*val = sfctemp->enabled;
+			return 0;
+		case hwmon_temp_input:
+			return sfctemp_convert(sfctemp, val);
+		}
+		return -EINVAL;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int sfctemp_write(struct device *dev, enum hwmon_sensor_types type,
+			 u32 attr, int channel, long val)
+{
+	struct sfctemp *sfctemp = dev_get_drvdata(dev);
+
+	switch (type) {
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_enable:
+			if (val == 0)
+				return sfctemp_disable(sfctemp);
+			if (val == 1)
+				return sfctemp_enable(sfctemp);
+			break;
+		}
+		return -EINVAL;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct hwmon_channel_info *sfctemp_info[] = {
+	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
+	HWMON_CHANNEL_INFO(temp, HWMON_T_ENABLE | HWMON_T_INPUT),
+	NULL
+};
+
+static const struct hwmon_ops sfctemp_hwmon_ops = {
+	.is_visible = sfctemp_is_visible,
+	.read = sfctemp_read,
+	.write = sfctemp_write,
+};
+
+static const struct hwmon_chip_info sfctemp_chip_info = {
+	.ops = &sfctemp_hwmon_ops,
+	.info = sfctemp_info,
+};
+
+static int sfctemp_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device *hwmon_dev;
+	struct resource *mem;
+	struct sfctemp *sfctemp;
+	long val;
+	int ret;
+
+	sfctemp = devm_kzalloc(dev, sizeof(*sfctemp), GFP_KERNEL);
+	if (!sfctemp)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, sfctemp);
+	mutex_init(&sfctemp->lock);
+	init_completion(&sfctemp->conversion_done);
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	sfctemp->regs = devm_ioremap_resource(dev, mem);
+	if (IS_ERR(sfctemp->regs))
+		return PTR_ERR(sfctemp->regs);
+
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_request_irq(dev, ret, sfctemp_isr,
+			       IRQF_SHARED, pdev->name, sfctemp);
+	if (ret) {
+		dev_err(dev, "request irq failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = sfctemp_enable(sfctemp);
+	if (ret)
+		return ret;
+
+	hwmon_dev = hwmon_device_register_with_info(dev, pdev->name, sfctemp,
+						    &sfctemp_chip_info, NULL);
+	if (IS_ERR(hwmon_dev))
+		return PTR_ERR(hwmon_dev);
+
+	/* do a conversion to check everything works */
+	ret = sfctemp_convert(sfctemp, &val);
+	if (ret) {
+		hwmon_device_unregister(hwmon_dev);
+		return ret;
+	}
+
+	dev_info(dev, "%ld.%03ld C\n", val / 1000, val % 1000);
+	return 0;
+}
+
+static int sfctemp_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct sfctemp *sfctemp = dev_get_drvdata(dev);
+
+	hwmon_device_unregister(dev);
+	return sfctemp_disable(sfctemp);
+}
+
+static const struct of_device_id sfctemp_of_match[] = {
+	{ .compatible = "starfive,jh7100-temp" },
+	{ /* sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(of, sfctemp_of_match);
+
+static struct platform_driver sfctemp_driver = {
+	.driver = {
+		.name = "sfctemp",
+		.of_match_table = of_match_ptr(sfctemp_of_match),
+	},
+	.probe  = sfctemp_probe,
+	.remove = sfctemp_remove,
+};
+module_platform_driver(sfctemp_driver);
+
+MODULE_AUTHOR("Emil Renner Berthing");
+MODULE_DESCRIPTION("StarFive JH7100 temperature sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.32.0

