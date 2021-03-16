Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A9633D05C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 10:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbhCPJLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 05:11:11 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:15499 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbhCPJKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 05:10:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1615885824; x=1647421824;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bsY9xqeFhQlA+1yz1j/n0X8Ohp707XUoclyGAVYqWfc=;
  b=TVRPAk3yqeqF3Xj3ALZk+XUUDCsLdAB3iWdvfutYh0NvivGmQXCbsNho
   Yl1yElxo0KNYVtsROuR/F8uCTNp2jzwvP/wiBiiY53pQ6ECsJe1v4XHIc
   b2qlgzBaZ/cm+MwNY9pFyBDf2yBxRlrOJrX6YtaOD0BnZ4SZBMud6p4Vf
   y3zDy8NpNcP7rCr94x2gknUi1V2Kat0eNioWeGWAC0pRTq22k0l+0Aisu
   4HPxJt1f1hCJn+vnW3cnnR8xUlIigUsVOTZP2tNXH8tHjJ9nYqs1vMRvL
   KKXcB5nf2bLDX1FQ70g83MoYOPxreD6xI8e7E/hDAawHGy84ZfgbdGh+K
   w==;
IronPort-SDR: WXn338GUR9kSpiH333v67v2x6q9/yXoY6llw8qQ4pCLxwSFTW//DuD6fa/FHLXegjyPznXPSea
 VcZvXlPiJPil2XCKLXQcl/zMPDFzo1gwbQrULADy5dZA06wCSbOBWcFZFvjMgbFlrnO3mS2Dph
 CqAdejXwlOoHDpDEP/1ei5hHcJvrP+aYNZYOQ7xqVR2x14L0VBSao3Kec3isE3+j9HGHlm/tgB
 lFyzpzFbGaIGILtYRrZF9GdGjJT7zEJ7PyydafXr1/2M2+WZS2O2KqdVOnZeuvY7CTOxmFWMff
 2Cs=
X-IronPort-AV: E=Sophos;i="5.81,251,1610434800"; 
   d="scan'208";a="47683718"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Mar 2021 02:08:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 16 Mar 2021 02:08:53 -0700
Received: from mchp-dev-shegelun.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 16 Mar 2021 02:08:52 -0700
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
CC:     Steen Hegelund <steen.hegelund@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v8 2/3] reset: mchp: sparx5: add switch reset driver
Date:   Tue, 16 Mar 2021 10:08:38 +0100
Message-ID: <20210316090839.3207930-3-steen.hegelund@microchip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210316090839.3207930-1-steen.hegelund@microchip.com>
References: <20210316090839.3207930-1-steen.hegelund@microchip.com>
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
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/reset/Kconfig                  |   8 ++
 drivers/reset/Makefile                 |   1 +
 drivers/reset/reset-microchip-sparx5.c | 146 +++++++++++++++++++++++++
 3 files changed, 155 insertions(+)
 create mode 100644 drivers/reset/reset-microchip-sparx5.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 4171c6f76385..c26798092ccf 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -111,6 +111,14 @@ config RESET_LPC18XX
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
index 65a118a91b27..c1d6aa9b1b52 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_RESET_INTEL_GW) += reset-intel-gw.o
 obj-$(CONFIG_RESET_K210) += reset-k210.o
 obj-$(CONFIG_RESET_LANTIQ) += reset-lantiq.o
 obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
+obj-$(CONFIG_RESET_MCHP_SPARX5) += reset-microchip-sparx5.o
 obj-$(CONFIG_RESET_MESON) += reset-meson.o
 obj-$(CONFIG_RESET_MESON_AUDIO_ARB) += reset-meson-audio-arb.o
 obj-$(CONFIG_RESET_NPCM) += reset-npcm.o
diff --git a/drivers/reset/reset-microchip-sparx5.c b/drivers/reset/reset-microchip-sparx5.c
new file mode 100644
index 000000000000..cff39a643a14
--- /dev/null
+++ b/drivers/reset/reset-microchip-sparx5.c
@@ -0,0 +1,146 @@
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
+#define SOFT_RESET_REG 0x00
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
+static int mchp_sparx5_map_syscon(struct platform_device *pdev, char *name,
+				  struct regmap **target)
+{
+	struct device_node *syscon_np;
+	struct regmap *regmap;
+	int err;
+
+	syscon_np = of_parse_phandle(pdev->dev.of_node, name, 0);
+	if (!syscon_np)
+		return -ENODEV;
+	regmap = syscon_node_to_regmap(syscon_np);
+	of_node_put(syscon_np);
+	if (IS_ERR(regmap)) {
+		err = PTR_ERR(regmap);
+		dev_err(&pdev->dev, "No '%s' map: %d\n", name, err);
+		return err;
+	}
+	*target = regmap;
+	return 0;
+}
+
+static int mchp_sparx5_map_io(struct platform_device *pdev, int index,
+			      struct regmap **target)
+{
+	struct resource *res;
+	struct regmap *map;
+	void __iomem *mem;
+
+	mem = devm_platform_get_and_ioremap_resource(pdev, index, &res);
+	if (!mem) {
+		dev_err(&pdev->dev, "Could not map resource %d\n", index);
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
+	err = mchp_sparx5_map_syscon(pdev, "cpu-syscon", &ctx->cpu_ctrl);
+	if (err)
+		return err;
+	err = mchp_sparx5_map_io(pdev, 0, &ctx->gcb_ctrl);
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
+	{ }
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
2.30.2

