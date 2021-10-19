Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8C6433525
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 13:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235481AbhJSLzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 07:55:06 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:33797 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235389AbhJSLzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 07:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634644372; x=1666180372;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xHiXWttoWRrm/beEWOAnfisZSYuxz1U3FcEgkhFLrcA=;
  b=L1vt99QSysKCCbfYFfBsXfT2y2D+/aYe3cstsAQcn7E6ZmrAGmSaBFuv
   81qECLggdzYEVPMl83jEFUcBm5NDIJkseWNapPjGHpXdpw00WxVhCTtn6
   YOtyAS5HuZx3jU7grqO27YgjL4Vuz5gKQn8ST/k11KLZCUOfQx/VY7FeM
   IgkhZXWj7aTrSRF31h/iKaDVEdeM4SgUt9YBIUplk9uOrOysqatuvsXdc
   ZdjE4Bd9GcVgSUynqSMzNw46/8A5k6mHEzAtRxXiI5smjsyQUUlDDURnL
   /d24sDnVDxwPSKmAZbKJ1yQofhCUZQsRtFRCQO7XyB82DdG1/AYd4mUSb
   g==;
IronPort-SDR: L8jNEeq8Gh9fTFamaCcXugiCfZjsM0XCkKtR+dS9I6Q/MYqva8CGVB1Yxfp8S/CvOeM7v1FO2h
 1eoGYg/lCsmbRAcVfoa1K/bYlVmGn7Ugrp8lMS8BP5w97AJkQS83J4iKpKMrxVtMjYbqE/V2SZ
 yRHNIEkD5UR6J0zlIYMgGzgpVZB32HPbO+MBiEmHakGYz9TfM8qVnrqm5yFnwbEk89H0WQG6XX
 50bItXh+ZIcWgKzxwCdTnWprvqyI7KMEg7kIgNCTDkcmo7fTqHDlfGQBBe5qw63NwM30gCdqCc
 jMhPLt8vyc5ckpnTubDJmzLj
X-IronPort-AV: E=Sophos;i="5.85,384,1624345200"; 
   d="scan'208";a="140862183"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Oct 2021 04:52:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 19 Oct 2021 04:52:52 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 19 Oct 2021 04:52:50 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Horatiu Vultur" <horatiu.vultur@microchip.com>
Subject: [PATCH 2/2] reset: lan966x: Add support for the phy reset on lan966x
Date:   Tue, 19 Oct 2021 13:52:05 +0200
Message-ID: <20211019115205.1516311-3-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211019115205.1516311-1-horatiu.vultur@microchip.com>
References: <20211019115205.1516311-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a driver to release the reset of the PHYs on lan966x.
There are 2 mdio buses on lan966x. One which is internal and has 2 PHYs
and one is external.
On the internal one it is required to release the HW reset of the phys
by writing specific register and while on the external one is required
to toggle a GPIO pin.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/reset/Kconfig                       |  8 ++
 drivers/reset/Makefile                      |  1 +
 drivers/reset/reset-microchip-lan966x-phy.c | 93 +++++++++++++++++++++
 3 files changed, 102 insertions(+)
 create mode 100644 drivers/reset/reset-microchip-lan966x-phy.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 36ce6c8bcf1e..94e1c0e7d343 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -122,6 +122,14 @@ config RESET_MCHP_SPARX5
 	help
 	  This driver supports switch core reset for the Microchip Sparx5 SoC.
 
+config RESET_MCHP_LAN966X_PHY
+	bool "Microchip lan966x phy reset driver"
+	depends on SOC_LAN966 || COMPILE_TEST
+	select MFD_SYSCON
+	help
+	  This driver supports the release of phy reset for the
+	  Microchip lan966x SoC.
+
 config RESET_MESON
 	tristate "Meson Reset Driver"
 	depends on ARCH_MESON || COMPILE_TEST
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 21d46d8869ff..2d7699aafb6c 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_RESET_K210) += reset-k210.o
 obj-$(CONFIG_RESET_LANTIQ) += reset-lantiq.o
 obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
 obj-$(CONFIG_RESET_MCHP_SPARX5) += reset-microchip-sparx5.o
+obj-$(CONFIG_RESET_MCHP_LAN966X_PHY) += reset-microchip-lan966x-phy.o
 obj-$(CONFIG_RESET_MESON) += reset-meson.o
 obj-$(CONFIG_RESET_MESON_AUDIO_ARB) += reset-meson-audio-arb.o
 obj-$(CONFIG_RESET_NPCM) += reset-npcm.o
diff --git a/drivers/reset/reset-microchip-lan966x-phy.c b/drivers/reset/reset-microchip-lan966x-phy.c
new file mode 100644
index 000000000000..63dd6a7bc62f
--- /dev/null
+++ b/drivers/reset/reset-microchip-lan966x-phy.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <linux/gpio/consumer.h>
+#include <linux/of_device.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+
+#define CUPHY_REG_OFF	0x10
+#define CUPHY_REG_BIT	0
+
+struct lan966x_phy_reset_context {
+	void __iomem *internal_phy_ctrl;
+	struct gpio_desc *external_phy_ctrl;
+	struct reset_controller_dev rcdev;
+};
+
+static int lan966x_phy_reset(struct reset_controller_dev *rcdev,
+			     unsigned long id)
+{
+	struct lan966x_phy_reset_context *ctx =
+		container_of(rcdev, struct lan966x_phy_reset_context, rcdev);
+	u32 val;
+
+	/* In case there are external PHYs toggle the GPIO to release the reset
+	 * of the PHYs
+	 */
+	if (ctx->external_phy_ctrl) {
+		gpiod_direction_output(ctx->external_phy_ctrl, 1);
+		gpiod_set_value(ctx->external_phy_ctrl, 0);
+		gpiod_set_value(ctx->external_phy_ctrl, 1);
+		gpiod_set_value(ctx->external_phy_ctrl, 0);
+	}
+
+	/* Release the reset of internal PHY */
+	val = readl(ctx->internal_phy_ctrl + CUPHY_REG_OFF);
+	val |= BIT(CUPHY_REG_BIT);
+	writel(val, ctx->internal_phy_ctrl + CUPHY_REG_OFF);
+
+	return 0;
+}
+
+static const struct reset_control_ops lan966x_phy_reset_ops = {
+	.reset = lan966x_phy_reset,
+};
+
+static int lan966x_phy_reset_probe(struct platform_device *pdev)
+{
+	struct device_node *dn = pdev->dev.of_node;
+	struct lan966x_phy_reset_context *ctx;
+
+	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->internal_phy_ctrl = devm_platform_ioremap_resource_byname(pdev, "phy");
+	if (IS_ERR(ctx->internal_phy_ctrl))
+		return dev_err_probe(&pdev->dev, PTR_ERR(ctx->internal_phy_ctrl),
+				     "Could not get resource 0\n");
+
+	ctx->external_phy_ctrl = devm_gpiod_get_optional(&pdev->dev,
+							 "external-phy-reset",
+							 GPIOD_OUT_LOW);
+	if (IS_ERR(ctx->external_phy_ctrl))
+		return dev_err_probe(&pdev->dev, PTR_ERR(ctx->external_phy_ctrl),
+				     "Could not get reset GPIO\n");
+
+	ctx->rcdev.owner = THIS_MODULE;
+	ctx->rcdev.nr_resets = 1;
+	ctx->rcdev.ops = &lan966x_phy_reset_ops;
+	ctx->rcdev.of_node = dn;
+
+	return devm_reset_controller_register(&pdev->dev, &ctx->rcdev);
+}
+
+static const struct of_device_id lan966x_phy_reset_of_match[] = {
+	{ .compatible = "microchip,lan966x-phy-reset", },
+	{ }
+};
+
+static struct platform_driver lan966x_phy_reset_driver = {
+	.probe = lan966x_phy_reset_probe,
+	.driver = {
+		.name = "lan966x-phy-reset",
+		.of_match_table = lan966x_phy_reset_of_match,
+	},
+};
+
+static int __init lan966x_phy_reset_init(void)
+{
+	return platform_driver_register(&lan966x_phy_reset_driver);
+}
+postcore_initcall(lan966x_phy_reset_init);
-- 
2.33.0

