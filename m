Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1DD444D82
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 04:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhKDDHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 23:07:00 -0400
Received: from [113.204.237.245] ([113.204.237.245]:53792 "EHLO
        test.cqplus1.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229603AbhKDDG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 23:06:57 -0400
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 172.28.114.216
        by cqmailgates with MailGates ESMTP Server V5.0(16723:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Thu, 04 Nov 2021 10:58:09 +0800 (CST)
From:   Qin Jian <qinjian@cqplus1.com>
To:     robh+dt@kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, maz@kernel.org,
        p.zabel@pengutronix.de, linux@armlinux.org.uk, broonie@kernel.org,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, wells.lu@sunplus.com,
        Qin Jian <qinjian@cqplus1.com>
Subject: [PATCH v4 04/10] reset: Add Sunplus SP7021 reset driver
Date:   Thu,  4 Nov 2021 10:57:01 +0800
Message-Id: <f4c5d72cf9886621ae5266195b51c2007a06665e.1635993377.git.qinjian@cqplus1.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1635993377.git.qinjian@cqplus1.com>
References: <cover.1635993377.git.qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset driver for Sunplus SP7021 SoC.

Signed-off-by: Qin Jian <qinjian@cqplus1.com>
---
 MAINTAINERS                   |   1 +
 drivers/reset/Kconfig         |   9 +++
 drivers/reset/Makefile        |   1 +
 drivers/reset/reset-sunplus.c | 133 ++++++++++++++++++++++++++++++++++
 4 files changed, 144 insertions(+)
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
index be799a5ab..5cdd022ad 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -224,6 +224,15 @@ config RESET_SOCFPGA
 	  This enables the reset driver for the SoCFPGA ARMv7 platforms. This
 	  driver gets initialized early during platform init calls.
 
+config RESET_SUNPLUS
+	bool "Sunplus SoCs Reset Driver"
+	depends on ARCH_SUNPLUS || COMPILE_TEST
+	help
+	  This enables the reset driver support for Sunplus SP7021 SoC family.
+	  Say Y if you want to control reset signals by the reset controller.
+	  Otherwise, say N.
+	  This driver is selected automatically by arm/mach-sunplus platform config.
+
 config RESET_SUNXI
 	bool "Allwinner SoCs Reset Driver" if COMPILE_TEST && !ARCH_SUNXI
 	default ARCH_SUNXI
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
index 000000000..6e29407d4
--- /dev/null
+++ b/drivers/reset/reset-sunplus.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * SP7021 reset driver
+ *
+ * Copyright (C) Sunplus Technology Co., Ltd.
+ *       All rights reserved.
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
+/* HIWORD_MASK */
+#define BITASSERT(id, val)	((1 << (16 + id)) | (val << id))
+
+struct sp_reset_data {
+	struct reset_controller_dev	rcdev;
+	void __iomem *membase;
+} *sp_reset;
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
+	int reg_width = sizeof(u32) / 2;
+	int bank = id / (reg_width * BITS_PER_BYTE);
+	int offset = id % (reg_width * BITS_PER_BYTE);
+	void __iomem *addr = data->membase + (bank * 4);
+
+	writel(BITASSERT(offset, assert), addr);
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
+	int reg_width = sizeof(u32) / 2;
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
+	sp_reset_assert(&sp_reset->rcdev, 0);
+	sp_reset_deassert(&sp_reset->rcdev, 0);
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
+	{ /* sentinel */ },
+};
+
+static int sp_reset_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	void __iomem *membase;
+	struct resource *res;
+
+	sp_reset = devm_kzalloc(&pdev->dev, sizeof(*sp_reset), GFP_KERNEL);
+	if (!sp_reset)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	membase = devm_ioremap_resource(dev, res);
+	if (IS_ERR(membase))
+		return PTR_ERR(membase);
+
+	sp_reset->membase = membase;
+	sp_reset->rcdev.owner = THIS_MODULE;
+	sp_reset->rcdev.nr_resets = resource_size(res) / 4 * 16; /* HIWORD_MASK */
+	sp_reset->rcdev.ops = &sp_reset_ops;
+	sp_reset->rcdev.of_node = dev->of_node;
+	register_restart_handler(&sp_restart_nb);
+
+	return devm_reset_controller_register(dev, &sp_reset->rcdev);
+}
+
+static struct platform_driver sp_reset_driver = {
+	.probe	= sp_reset_probe,
+	.driver = {
+		.name = "sunplus-reset",
+		.of_match_table	= sp_reset_dt_ids,
+	},
+};
+module_platform_driver(sp_reset_driver);
+
+MODULE_AUTHOR("Edwin Chiu <edwin.chiu@sunplus.com>");
+MODULE_DESCRIPTION("Sunplus Reset Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.33.1

