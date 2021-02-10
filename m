Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6AC316233
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 10:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbhBJJ2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 04:28:05 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:12997 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbhBJJVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 04:21:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1612948893; x=1644484893;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W+Xd47Rsh6yVe21wSNKhDlXOb2mrznVlUifqMeQomj4=;
  b=uy8pJKCzfP56dqBtWyJfQedw2YR+btIbAfpQG2z9t8EvRO43/p1gkPv0
   aR8MKEffklBpGOME7S8DYRrKUMFDghn97a4ITXBisNkyDDq94cuGV4P8I
   Wc+O7A+oc/yACZPjfmc6CvftjByZ7Snb4o3kpQ5GTll1e80hPk3JYVZdM
   HH1WCqKb8xNZbx0D8iIcdHiVwpclCXR8VhK5yHi7PSU5yN9HQf0t0DZ6L
   eYvgcbFhoqGrgG26CXlJ2v07I9M49CaMYKwRxKv/r/bbFw/0SRRWKNU+h
   z6sh4b9D0B0rSpD2BBfoedKB+xRanveYM+hEozjv6q1pSQZku+l86Yp6o
   w==;
IronPort-SDR: iWrJ/maBtm41H3qdBSgDv05ZPY9KQB8QshSSb7RuxDEhR96Sppf2WxJAJfDz1ueM9Su5yPVxs5
 9l3pRWMiGLoSHKCUI9DLUCM6AsnjIZIUW4WrZz3SB3ESOgf32BWpcP1jeDBNzbi+/e9AQ3ubk2
 3pZ3S9qQIYKB4wdujQFzYoY8dWG4G7yhvXIqDP+nomKV5++nx8od2HU8Fbn7FDD5RenSqV6EUB
 ifYt7/3DA5vquznY2f2i0n8jcdqC/h9zTWsrLpWcGdTncmGHPXj3dw/3styb9YB6PHMqddMuib
 isE=
X-IronPort-AV: E=Sophos;i="5.81,167,1610434800"; 
   d="scan'208";a="114529569"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Feb 2021 02:20:06 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 10 Feb 2021 02:20:06 -0700
Received: from mchp-dev-shegelun.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 10 Feb 2021 02:20:04 -0700
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
CC:     Steen Hegelund <steen.hegelund@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v5 2/3] reset: mchp: sparx5: add switch reset driver
Date:   Wed, 10 Feb 2021 10:19:51 +0100
Message-ID: <20210210091952.2013027-3-steen.hegelund@microchip.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210091952.2013027-1-steen.hegelund@microchip.com>
References: <20210210091952.2013027-1-steen.hegelund@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Sparx5 Switch SoC has a number of components that can be reset
indiviually, but at least the Switch Core needs to be in a well defined
state at power on, when any of the Sparx5 drivers starts to access the
Switch Core, this reset driver is available.

The reset driver is loaded early via the postcore_initcall interface, and
will then be available for the other Sparx5 drivers (SGPIO, SwitchDev etc)
that are loaded next, and the first of them to be loaded can perform the
one-time Switch Core reset that is needed.

The driver has protection so that the system busses, DDR controller, PCI-E
and ARM A53 CPU and a few other subsystems are not touched by the reset.

Signed-off-by: Steen Hegelund <steen.hegelund@microchip.com>
---
 drivers/reset/Kconfig                  |   8 ++
 drivers/reset/Makefile                 |   1 +
 drivers/reset/reset-microchip-sparx5.c | 130 +++++++++++++++++++++++++
 3 files changed, 139 insertions(+)
 create mode 100644 drivers/reset/reset-microchip-sparx5.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 71ab75a46491..05c240c47a8a 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -101,6 +101,14 @@ config RESET_LPC18XX
 	help
 	  This enables the reset controller driver for NXP LPC18xx/43xx SoCs.
 
+config RESET_MCHP_SPARX5
+	bool "Microchip Sparx5 reset driver"
+	depends on HAS_IOMEM || COMPILE_TEST
+	default y if SPARX5_SWITCH
+	select MFD_SYSCON
+	help
+	  This driver supports switch core reset for the Microchip Sparx5 SoC.
+
 config RESET_MESON
 	tristate "Meson Reset Driver"
 	depends on ARCH_MESON || COMPILE_TEST
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 1054123fd187..341fd9ab4bf6 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
 obj-$(CONFIG_RESET_INTEL_GW) += reset-intel-gw.o
 obj-$(CONFIG_RESET_LANTIQ) += reset-lantiq.o
 obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
+obj-$(CONFIG_RESET_MCHP_SPARX5) += reset-microchip-sparx5.o
 obj-$(CONFIG_RESET_MESON) += reset-meson.o
 obj-$(CONFIG_RESET_MESON_AUDIO_ARB) += reset-meson-audio-arb.o
 obj-$(CONFIG_RESET_NPCM) += reset-npcm.o
diff --git a/drivers/reset/reset-microchip-sparx5.c b/drivers/reset/reset-microchip-sparx5.c
new file mode 100644
index 000000000000..b243a12af085
--- /dev/null
+++ b/drivers/reset/reset-microchip-sparx5.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Microchip Sparx5 Switch Reset driver
+ *
+ * Copyright (c) 2020 Microchip Technology Inc. and its subsidiaries.
+ *
+ * The Sparx5 Chip Register Model can be browsed at this location:
+ * https://github.com/microchip-ung/sparx-5_reginfo
+ */
+#include <linux/mfd/syscon.h>
+#include <linux/of_device.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset-controller.h>
+
+#define PROTECT_REG    0x84
+#define PROTECT_BIT    BIT(10)
+#define SOFT_RESET_REG 0x08
+#define SOFT_RESET_BIT BIT(1)
+
+struct mchp_reset_context {
+	struct regmap *cpu_ctrl;
+	struct regmap *gcb_ctrl;
+	struct reset_controller_dev rcdev;
+};
+
+static struct regmap_config sparx5_reset_regmap_config = {
+	.reg_bits	= 32,
+	.val_bits	= 32,
+	.reg_stride	= 4,
+};
+
+static int sparx5_switch_reset(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	struct mchp_reset_context *ctx =
+		container_of(rcdev, struct mchp_reset_context, rcdev);
+	u32 val;
+
+	/* Make sure the core is PROTECTED from reset */
+	regmap_update_bits(ctx->cpu_ctrl, PROTECT_REG, PROTECT_BIT, PROTECT_BIT);
+
+	/* Start soft reset */
+	regmap_write(ctx->gcb_ctrl, SOFT_RESET_REG, SOFT_RESET_BIT);
+
+	/* Wait for soft reset done */
+	return regmap_read_poll_timeout(ctx->gcb_ctrl, SOFT_RESET_REG, val,
+					(val & SOFT_RESET_BIT) == 0,
+					1, 100);
+}
+
+static const struct reset_control_ops sparx5_reset_ops = {
+	.reset = sparx5_switch_reset,
+};
+
+static int mchp_sparx5_map_io(struct platform_device *pdev, char *name,
+			      struct regmap **target)
+{
+	struct resource *res;
+	void __iomem *mem;
+	struct regmap *map;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
+	if (!res) {
+		dev_err(&pdev->dev, "No '%s' resource\n", name);
+		return -ENODEV;
+	}
+	mem = devm_ioremap(&pdev->dev, res->start, res->end - res->start + 1);
+	if (!mem) {
+		dev_err(&pdev->dev, "Could not map '%s' resource\n", name);
+		return -ENXIO;
+	}
+	sparx5_reset_regmap_config.name = res->name;
+	map = devm_regmap_init_mmio(&pdev->dev, mem, &sparx5_reset_regmap_config);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+	*target = map;
+	return 0;
+}
+
+static int mchp_sparx5_reset_probe(struct platform_device *pdev)
+{
+	struct device_node *dn = pdev->dev.of_node;
+	struct mchp_reset_context *ctx;
+	int err;
+
+	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	err = mchp_sparx5_map_io(pdev, "cpu", &ctx->cpu_ctrl);
+	if (err)
+		return err;
+	err = mchp_sparx5_map_io(pdev, "gcb", &ctx->gcb_ctrl);
+	if (err)
+		return err;
+
+	ctx->rcdev.owner = THIS_MODULE;
+	ctx->rcdev.nr_resets = 1;
+	ctx->rcdev.ops = &sparx5_reset_ops;
+	ctx->rcdev.of_node = dn;
+
+	return devm_reset_controller_register(&pdev->dev, &ctx->rcdev);
+}
+
+static const struct of_device_id mchp_sparx5_reset_of_match[] = {
+	{
+		.compatible = "microchip,sparx5-switch-reset",
+	},
+	{ /*sentinel*/ }
+};
+
+static struct platform_driver mchp_sparx5_reset_driver = {
+	.probe = mchp_sparx5_reset_probe,
+	.driver = {
+		.name = "sparx5-switch-reset",
+		.of_match_table = mchp_sparx5_reset_of_match,
+	},
+};
+
+static int __init mchp_sparx5_reset_init(void)
+{
+	return platform_driver_register(&mchp_sparx5_reset_driver);
+}
+
+postcore_initcall(mchp_sparx5_reset_init);
+
+MODULE_DESCRIPTION("Microchip Sparx5 switch reset driver");
+MODULE_AUTHOR("Steen Hegelund <steen.hegelund@microchip.com>");
+MODULE_LICENSE("Dual MIT/GPL");
-- 
2.30.0

