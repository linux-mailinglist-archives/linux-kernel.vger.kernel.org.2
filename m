Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4FE64412F4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 06:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhKAFXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 01:23:06 -0400
Received: from [113.204.237.245] ([113.204.237.245]:39182 "EHLO
        test.cqplus1.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229882AbhKAFXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 01:23:04 -0400
X-Greylist: delayed 869 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Nov 2021 01:23:03 EDT
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 172.28.114.216
        by cqmailgates with MailGates ESMTP Server V5.0(16723:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Mon, 01 Nov 2021 13:02:44 +0800 (CST)
From:   Qin Jian <qinjian@cqplus1.com>
To:     robh+dt@kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, maz@kernel.org,
        p.zabel@pengutronix.de, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        wells.lu@sunplus.com, Qin Jian <qinjian@cqplus1.com>
Subject: [PATCH v3 4/8] reset: Add Sunplus SP7021 reset driver
Date:   Mon,  1 Nov 2021 13:01:54 +0800
Message-Id: <c6f0aaef57b25705af988797ede5ab7119852a5c.1635737544.git.qinjian@cqplus1.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1635737544.git.qinjian@cqplus1.com>
References: <cover.1635737544.git.qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset driver for Sunplus SP7021 SoC.

Signed-off-by: Qin Jian <qinjian@cqplus1.com>
---
 MAINTAINERS                   |   1 +
 drivers/reset/Kconfig         |   8 ++
 drivers/reset/Makefile        |   1 +
 drivers/reset/reset-sunplus.c | 159 ++++++++++++++++++++++++++++++++++
 4 files changed, 169 insertions(+)
 create mode 100644 drivers/reset/reset-sunplus.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 652f42cab..6caffd6d0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2662,6 +2662,7 @@ S:	Maintained
 W:	https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
 F:	Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml
 F:	Documentation/devicetree/bindings/reset/sunplus,reset.yaml
+F:	drivers/reset/reset-sunplus.c
 F:	include/dt-bindings/reset/sp-sp7021.h
 
 ARM/Synaptics SoC support
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index be799a5ab..50695ab47 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -249,6 +249,14 @@ config RESET_TI_SYSCON
 	  you wish to use the reset framework for such memory-mapped devices,
 	  say Y here. Otherwise, say N.
 
+config RESET_SUNPLUS
+	bool "Sunplus SoCs Reset Driver"
+	help
+	  This enables the reset driver support for Sunplus SP7021 SoC family.
+	  Say Y if you want to control reset signals by the reset controller.
+	  Otherwise, say N.
+	  This driver is selected automatically by platform config.
+
 config RESET_UNIPHIER
 	tristate "Reset controller driver for UniPhier SoCs"
 	depends on ARCH_UNIPHIER || COMPILE_TEST
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 21d46d886..f03403e97 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_RESET_RZG2L_USBPHY_CTRL) += reset-rzg2l-usbphy-ctrl.o
 obj-$(CONFIG_RESET_SCMI) += reset-scmi.o
 obj-$(CONFIG_RESET_SIMPLE) += reset-simple.o
 obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
+obj-$(CONFIG_RESET_SUNPLUS) += reset-sunplus.o
 obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
 obj-$(CONFIG_RESET_TI_SCI) += reset-ti-sci.o
 obj-$(CONFIG_RESET_TI_SYSCON) += reset-ti-syscon.o
diff --git a/drivers/reset/reset-sunplus.c b/drivers/reset/reset-sunplus.c
new file mode 100644
index 000000000..696efd75e
--- /dev/null
+++ b/drivers/reset/reset-sunplus.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * SP7021 reset driver
+ *
+ * Copyright (C) Sunplus Technology Co., Ltd.
+ *       All rights reserved.
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <linux/reboot.h>
+
+#if defined(CONFIG_SOC_SP7021)
+#include <dt-bindings/reset/sp-sp7021.h>
+#elif defined(CONFIG_SOC_Q645)
+#include <dt-bindings/reset/sp-q645.h>
+#endif
+
+#define BITASSERT(id, val)          ((1 << (16 + id)) | (val << id))
+
+
+struct sp_reset_data {
+	struct reset_controller_dev	rcdev;
+	void __iomem			*membase;
+} sp_reset;
+
+
+static inline struct sp_reset_data *
+to_sp_reset_data(struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct sp_reset_data, rcdev);
+}
+
+static int sp_reset_update(struct reset_controller_dev *rcdev,
+			      unsigned long id, bool assert)
+{
+	struct sp_reset_data *data = to_sp_reset_data(rcdev);
+	int reg_width = sizeof(u32)/2;
+	int bank = id / (reg_width * BITS_PER_BYTE);
+	int offset = id % (reg_width * BITS_PER_BYTE);
+	void __iomem *addr;
+
+	addr = data->membase + (bank * 4);
+
+	if (assert)
+		writel(BITASSERT(offset, 1), addr);
+	else
+		writel(BITASSERT(offset, 0), addr);
+
+	return 0;
+}
+
+static int sp_reset_assert(struct reset_controller_dev *rcdev,
+			      unsigned long id)
+{
+	return sp_reset_update(rcdev, id, true);
+}
+
+
+static int sp_reset_deassert(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	return sp_reset_update(rcdev, id, false);
+}
+
+static int sp_reset_status(struct reset_controller_dev *rcdev,
+			      unsigned long id)
+{
+	struct sp_reset_data *data = to_sp_reset_data(rcdev);
+	int reg_width = sizeof(u32)/2;
+	int bank = id / (reg_width * BITS_PER_BYTE);
+	int offset = id % (reg_width * BITS_PER_BYTE);
+	u32 reg;
+
+	reg = readl(data->membase + (bank * 4));
+
+	return !!(reg & BIT(offset));
+}
+
+static int sp_restart(struct notifier_block *this, unsigned long mode,
+				void *cmd)
+{
+	sp_reset_assert(&sp_reset.rcdev, RST_SYSTEM);
+	sp_reset_deassert(&sp_reset.rcdev, RST_SYSTEM);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block sp_restart_nb = {
+	.notifier_call = sp_restart,
+	.priority = 192,
+};
+
+static const struct reset_control_ops sp_reset_ops = {
+	.assert		= sp_reset_assert,
+	.deassert	= sp_reset_deassert,
+	.status		= sp_reset_status,
+};
+
+static const struct of_device_id sp_reset_dt_ids[] = {
+	{ .compatible = "sunplus,sp7021-reset", },
+	{ .compatible = "sunplus,q645-reset", },
+	{ /* sentinel */ },
+};
+
+static int sp_reset_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct sp_reset_data *data = &sp_reset;
+	void __iomem *membase;
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	membase = devm_ioremap(dev, res->start, resource_size(res));
+	if (IS_ERR(membase))
+		return PTR_ERR(membase);
+
+	data->membase = membase;
+	data->rcdev.owner = THIS_MODULE;
+	data->rcdev.nr_resets = RST_MAX;
+	data->rcdev.ops = &sp_reset_ops;
+	data->rcdev.of_node = dev->of_node;
+	register_restart_handler(&sp_restart_nb);
+
+	return devm_reset_controller_register(dev, &data->rcdev);
+}
+
+static struct platform_driver sp_reset_driver = {
+	.probe	= sp_reset_probe,
+	.driver = {
+		.name = "sunplus-reset",
+		.of_match_table	= sp_reset_dt_ids,
+	},
+};
+
+static int __init sp_reset_init(void)
+{
+	return platform_driver_register(&sp_reset_driver);
+}
+arch_initcall(sp_reset_init);
+
+MODULE_AUTHOR("Edwin Chiu <edwin.chiu@sunplus.com>");
+MODULE_DESCRIPTION("Sunplus Reset Driver");
+MODULE_LICENSE("GPL");
-- 
2.33.1

