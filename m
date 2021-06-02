Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38927398973
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 14:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhFBM1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 08:27:42 -0400
Received: from mail-ej1-f43.google.com ([209.85.218.43]:42747 "EHLO
        mail-ej1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbhFBM1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 08:27:37 -0400
Received: by mail-ej1-f43.google.com with SMTP id qq22so3527757ejb.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 05:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+R4hHqOH9P3sICteAf7/IDg//TYDCjFSsnb52hqNJ5I=;
        b=iv9I9+QvITbV69Rff1OpnEA5bBUHAVWzWpdO7aXWzzBZEJ7gZPmemEwdlNxm0QEc+j
         4NfEYcQb3XrpneNgSHAWVMKL8etlMNDRDaG4nUz69XPTdSF1KIbh2tizMz5wiTJ8/kKQ
         a0/Oarr8jvFJyySPxWNMXxheMHrCJMozraK73RWaoL5JKx7sV1DQJ6/KxN4rdZKQfSLo
         HvUJ5H6+8ryO3/Uiuzybp6HY45IOiWlOmCgUEe3dJQ2z2mVcnj27kwfxObUgbTmSv69H
         A67Q3GGn+lcNuOXuqhvYK5oZvWMCrYPiuXwB8cFq+s2D/B4LY8fEjwLyfLcAb1UQLbtV
         YgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+R4hHqOH9P3sICteAf7/IDg//TYDCjFSsnb52hqNJ5I=;
        b=tnx/jsNPBgkyxanZxDkPK2ZtWmshroPU2tYvzruB1Vf2jktoLbgdO/KBFEvPF/i67R
         7bXfg6A2VB5zUd1nglBBDM41wyQXCbih3UB8Z/B4kvAUnMAZ+DQOHb4hs7pwwrHVJNwW
         whuPkdyjJaVJQIdxqte6q+WFaUNUCwDGL55artILP7JEocoY1qCLowAwMninsyU/umxI
         Wl94HWy6aTJhM919K2YflG1Ps7L6qMCE5WL+3jVWiw/oU+KSarTisCBarb+CIDz8F6LV
         xa0hLs0Vvvt5/qQwd6sYj7xxJyZJ5iC1WGCgvwoIMpqXcB6BIncOFXuTybVH0aOk3XlC
         c6qg==
X-Gm-Message-State: AOAM530xaz1eSDHUqiatctjZtzhIO42kCXKCb7YFYl7Ukqn7SOSEBHp2
        EMHwaGsVKi8Yv9cagkQ0WyBeng==
X-Google-Smtp-Source: ABdhPJzRB4dwH8Kzf7fjEFcg93w4v9fB2NgesaKxQM9FV0j1q1UMhGqqoTDROsBBP3bgZuYaqZXk6g==
X-Received: by 2002:a17:906:35cd:: with SMTP id p13mr20673578ejb.24.1622636687952;
        Wed, 02 Jun 2021 05:24:47 -0700 (PDT)
Received: from localhost.localdomain (dh207-96-250.xnet.hr. [88.207.96.250])
        by smtp.googlemail.com with ESMTPSA id z17sm8539340ejc.69.2021.06.02.05.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 05:24:47 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        robh+dt@kernel.org, lee.jones@linaro.org, p.zabel@pengutronix.de,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     luka.perkov@sartura.hr, jmp@epiphyte.org, pmenzel@molgen.mpg.de,
        buczek@molgen.mpg.de, Robert Marko <robert.marko@sartura.hr>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v4 2/6] gpio: Add Delta TN48M CPLD GPIO driver
Date:   Wed,  2 Jun 2021 14:24:35 +0200
Message-Id: <20210602122439.2084775-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602122439.2084775-1-robert.marko@sartura.hr>
References: <20210602122439.2084775-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delta TN48M CPLD is used as a GPIO expander for the SFP GPIOs.

It is a mix of input only and output only pins.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/Kconfig      | 12 ++++++
 drivers/gpio/Makefile     |  1 +
 drivers/gpio/gpio-tn48m.c | 89 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+)
 create mode 100644 drivers/gpio/gpio-tn48m.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index e3607ec4c2e8..472f7764508e 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1310,6 +1310,18 @@ config GPIO_TIMBERDALE
 	help
 	Add support for the GPIO IP in the timberdale FPGA.
 
+config GPIO_TN48M_CPLD
+	tristate "Delta Networks TN48M switch CPLD GPIO driver"
+	depends on MFD_TN48M_CPLD
+	select GPIO_REGMAP
+	help
+	  This enables support for the GPIOs found on the Delta
+	  Networks TN48M switch CPLD.
+	  They are used for inputs and outputs on the SFP slots.
+
+	  This driver can also be built as a module. If so, the
+	  module will be called gpio-tn48m.
+
 config GPIO_TPS65086
 	tristate "TI TPS65086 GPO"
 	depends on MFD_TPS65086
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index c58a90a3c3b1..271fb806475e 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -145,6 +145,7 @@ obj-$(CONFIG_GPIO_TEGRA186)		+= gpio-tegra186.o
 obj-$(CONFIG_GPIO_TEGRA)		+= gpio-tegra.o
 obj-$(CONFIG_GPIO_THUNDERX)		+= gpio-thunderx.o
 obj-$(CONFIG_GPIO_TIMBERDALE)		+= gpio-timberdale.o
+obj-$(CONFIG_GPIO_TN48M_CPLD)		+= gpio-tn48m.o
 obj-$(CONFIG_GPIO_TPIC2810)		+= gpio-tpic2810.o
 obj-$(CONFIG_GPIO_TPS65086)		+= gpio-tps65086.o
 obj-$(CONFIG_GPIO_TPS65218)		+= gpio-tps65218.o
diff --git a/drivers/gpio/gpio-tn48m.c b/drivers/gpio/gpio-tn48m.c
new file mode 100644
index 000000000000..41484c002826
--- /dev/null
+++ b/drivers/gpio/gpio-tn48m.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Delta TN48M CPLD GPIO driver
+ *
+ * Copyright 2021 Sartura Ltd
+ *
+ * Author: Robert Marko <robert.marko@sartura.hr>
+ */
+
+#include <linux/device.h>
+#include <linux/gpio/driver.h>
+#include <linux/gpio/regmap.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+enum tn48m_gpio_type {
+	TN48M_SFP_TX_DISABLE = 1,
+	TN48M_SFP_PRESENT,
+	TN48M_SFP_LOS,
+};
+
+static int tn48m_gpio_probe(struct platform_device *pdev)
+{
+	struct gpio_regmap_config config = {0};
+	enum tn48m_gpio_type type;
+	struct regmap *regmap;
+	u32 base;
+	int ret;
+
+	if (!pdev->dev.parent)
+		return -ENODEV;
+
+	type = (uintptr_t)device_get_match_data(&pdev->dev);
+	if (!type)
+		return -ENODEV;
+
+	ret = device_property_read_u32(&pdev->dev, "reg", &base);
+	if (ret)
+		return -EINVAL;
+
+	regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!regmap)
+		return -ENODEV;
+
+	config.regmap = regmap;
+	config.parent = &pdev->dev;
+	config.ngpio = 4;
+
+	switch (type) {
+	case TN48M_SFP_TX_DISABLE:
+		config.reg_set_base = base;
+		break;
+	case TN48M_SFP_PRESENT:
+		config.reg_dat_base = base;
+		break;
+	case TN48M_SFP_LOS:
+		config.reg_dat_base = base;
+		break;
+	default:
+		dev_err(&pdev->dev, "unknown type %d\n", type);
+		return -ENODEV;
+	}
+
+	return PTR_ERR_OR_ZERO(devm_gpio_regmap_register(&pdev->dev, &config));
+}
+
+static const struct of_device_id tn48m_gpio_of_match[] = {
+	{ .compatible = "delta,tn48m-gpio-sfp-tx-disable", .data = (void *)TN48M_SFP_TX_DISABLE },
+	{ .compatible = "delta,tn48m-gpio-sfp-present", .data = (void *)TN48M_SFP_PRESENT },
+	{ .compatible = "delta,tn48m-gpio-sfp-los", .data = (void *)TN48M_SFP_LOS },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tn48m_gpio_of_match);
+
+static struct platform_driver tn48m_gpio_driver = {
+	.driver = {
+		.name = "delta-tn48m-gpio",
+		.of_match_table = tn48m_gpio_of_match,
+	},
+	.probe = tn48m_gpio_probe,
+};
+module_platform_driver(tn48m_gpio_driver);
+
+MODULE_AUTHOR("Robert Marko <robert.marko@sartura.hr>");
+MODULE_DESCRIPTION("Delta TN48M CPLD GPIO driver");
+MODULE_LICENSE("GPL");
-- 
2.31.1

