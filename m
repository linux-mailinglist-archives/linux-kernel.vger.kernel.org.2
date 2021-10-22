Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391C743746E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 11:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbhJVJPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 05:15:04 -0400
Received: from [113.204.237.245] ([113.204.237.245]:46674 "EHLO
        test.cqplus1.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232161AbhJVJPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 05:15:02 -0400
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 172.28.114.216
        by cqmailgates with MailGates ESMTP Server V5.0(10970:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Fri, 22 Oct 2021 17:12:24 +0800 (CST)
From:   qinjian <qinjian@cqplus1.com>
To:     p.zabel@pengutronix.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        wells.lu@sunplus.com, qinjian <qinjian@cqplus1.com>
Subject: [PATCH] reset: Add Sunplus SP7021 reset driver
Date:   Fri, 22 Oct 2021 17:11:57 +0800
Message-Id: <20211022091157.456755-1-qinjian@cqplus1.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset driver for Sunplus SP7021 SoC.

Signed-off-by: qinjian <qinjian@cqplus1.com>
---
 MAINTAINERS                   |   1 +
 drivers/reset/Kconfig         |   9 ++
 drivers/reset/Makefile        |   1 +
 drivers/reset/reset-sunplus.c | 159 ++++++++++++++++++++++++++++++++++
 4 files changed, 170 insertions(+)
 create mode 100644 drivers/reset/reset-sunplus.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4279615e3..60534498b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2665,6 +2665,7 @@ F:	Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.ya
 F:	Documentation/devicetree/bindings/reset/sunplus,reset.yaml
 F:	drivers/clk/clk-sp7021.c
 F:	drivers/irqchip/irq-sp7021-intc.c
+F:	drivers/reset/reset-sunplus.c
 F:	include/dt-bindings/clock/sp-sp7021.h
 F:	include/dt-bindings/interrupt-controller/sp7021-intc.h
 F:	include/dt-bindings/reset/sp-sp7021.h
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index be799a5ab..3e2e49998 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -249,6 +249,15 @@ config RESET_TI_SYSCON
 	  you wish to use the reset framework for such memory-mapped devices,
 	  say Y here. Otherwise, say N.
 
+config RESET_SUNPLUS
+	bool "Sunplus SoCs Reset Driver"
+	default SOC_SP7021 || SOC_Q645
+	help
+	  This enables the reset driver support for Sunplus SP7021 and Q645
+	  SoC family. Say Y if you want to control reset signals by the reset
+	  controller. Otherwise, say N.
+	  This will be enabled by default.
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
index 000000000..f74836fa1
--- /dev/null
+++ b/drivers/reset/reset-sunplus.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0
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

