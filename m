Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C5D42B94C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 09:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238566AbhJMHiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 03:38:51 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:3106 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238555AbhJMHis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 03:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634110607; x=1665646607;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cCT4fzrTtwp6irb/rWugaiZG5AFjFhTJLNHPlqgsV0U=;
  b=SLw08HzNtaXXyViFsgDqpXiql8dt63TM/fVsu/4pBkqj3DMqMKnr0g9C
   OkYojhbBRdmL1WQEd/Eubpd/vumQpUN7uDO2l7WBpQYaFlxOMrByf7LnH
   WkpuylhhbuBDKn0BzFTjM+MY1sOM2YRcws/sbv9gbJUk/JHx93pfMGHRQ
   +jWXPd1fdhPgDo+jxaBdLEwT9Q6tQHl6iMzaZjJXdTtgf0ZW6jyhzVQE5
   f90yiC/kBaXel0BbIwMs9xYLpiRtF6tHne61SAP5A4us3S27dtDFiMPPk
   rr0u9zRwb4+vmGyAMOm0RCq0KkrDOHh6tFUf20lH0Jx4amOVVTa/lcp6x
   g==;
IronPort-SDR: 5pSpjh9AFsmfNc6Rouv3P2MJuFuAWorgDcQyffvfen6bHF+vEgK/p/q5W352NyY9qefZ/X88AQ
 Bn+A1qYlOwL7dktPgeUAUNWFx0JIClTqpd7y1hx9byYhlMt3DBoxQy+vpPuLnxBr9bJJ3RvHwS
 4sBMQaC5/tNKrz+7UVzW/wRXpSUniIqaOC0b1T/O7MgPIbgGpww2h2SamJ5q+izo72ehv6VQ2S
 gemuvctX12etFFJs3/HuwyaoZRycZ0S6loYTA49dIdzVJ/DTWS9nSllPQlGXOZJlTExjBaxgvA
 DYrqW8vVnHtHduCZhEX6fnXW
X-IronPort-AV: E=Sophos;i="5.85,369,1624345200"; 
   d="scan'208";a="139534707"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Oct 2021 00:36:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 13 Oct 2021 00:36:44 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 13 Oct 2021 00:36:43 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>, <andrew@lunn.ch>,
        <lars.povlsen@microchip.com>, <Steen.Hegelund@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH v3 2/2] reset: mchp: sparx5: Extend support for lan966x
Date:   Wed, 13 Oct 2021 09:38:07 +0200
Message-ID: <20211013073807.2282230-3-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211013073807.2282230-1-horatiu.vultur@microchip.com>
References: <20211013073807.2282230-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch extends sparx5 driver to support also the lan966x. The
process to reset the switch is the same only it has different offsets.
Therefore make the driver more generic and add support for lan966x.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/reset/Kconfig                  |  2 +-
 drivers/reset/reset-microchip-sparx5.c | 81 +++++++++++++++++++++++---
 2 files changed, 74 insertions(+), 9 deletions(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index be799a5abf8a..36ce6c8bcf1e 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -116,7 +116,7 @@ config RESET_LPC18XX
 
 config RESET_MCHP_SPARX5
 	bool "Microchip Sparx5 reset driver"
-	depends on ARCH_SPARX5 || COMPILE_TEST
+	depends on ARCH_SPARX5 || SOC_LAN966 || COMPILE_TEST
 	default y if SPARX5_SWITCH
 	select MFD_SYSCON
 	help
diff --git a/drivers/reset/reset-microchip-sparx5.c b/drivers/reset/reset-microchip-sparx5.c
index f01e7db8e83b..211ee338e4b6 100644
--- a/drivers/reset/reset-microchip-sparx5.c
+++ b/drivers/reset/reset-microchip-sparx5.c
@@ -6,6 +6,7 @@
  * The Sparx5 Chip Register Model can be browsed at this location:
  * https://github.com/microchip-ung/sparx-5_reginfo
  */
+#include <linux/gpio/consumer.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of_device.h>
 #include <linux/module.h>
@@ -13,15 +14,22 @@
 #include <linux/regmap.h>
 #include <linux/reset-controller.h>
 
-#define PROTECT_REG    0x84
-#define PROTECT_BIT    BIT(10)
-#define SOFT_RESET_REG 0x00
-#define SOFT_RESET_BIT BIT(1)
+struct reset_props {
+	u32 protect_reg;
+	u32 protect_bit;
+	u32 reset_reg;
+	u32 reset_bit;
+	u32 cuphy_reg;
+	u32 cuphy_bit;
+};
 
 struct mchp_reset_context {
 	struct regmap *cpu_ctrl;
 	struct regmap *gcb_ctrl;
+	struct regmap *cuphy_ctrl;
 	struct reset_controller_dev rcdev;
+	const struct reset_props *props;
+	struct gpio_desc *phy_reset_gpio;
 };
 
 static struct regmap_config sparx5_reset_regmap_config = {
@@ -36,17 +44,39 @@ static int sparx5_switch_reset(struct reset_controller_dev *rcdev,
 	struct mchp_reset_context *ctx =
 		container_of(rcdev, struct mchp_reset_context, rcdev);
 	u32 val;
+	int err;
 
 	/* Make sure the core is PROTECTED from reset */
-	regmap_update_bits(ctx->cpu_ctrl, PROTECT_REG, PROTECT_BIT, PROTECT_BIT);
+	regmap_update_bits(ctx->cpu_ctrl, ctx->props->protect_reg,
+			   ctx->props->protect_bit, ctx->props->protect_bit);
 
 	/* Start soft reset */
-	regmap_write(ctx->gcb_ctrl, SOFT_RESET_REG, SOFT_RESET_BIT);
+	regmap_write(ctx->gcb_ctrl, ctx->props->reset_reg,
+		     ctx->props->reset_bit);
 
 	/* Wait for soft reset done */
-	return regmap_read_poll_timeout(ctx->gcb_ctrl, SOFT_RESET_REG, val,
-					(val & SOFT_RESET_BIT) == 0,
+	err = regmap_read_poll_timeout(ctx->gcb_ctrl, ctx->props->reset_reg, val,
+					(val & ctx->props->reset_bit) == 0,
 					1, 100);
+	if (err)
+		return err;
+
+	if (!ctx->cuphy_ctrl)
+		return 0;
+
+	/* In case there are external PHYs toggle the GPIO to release the reset
+	 * of the PHYs
+	 */
+	if (ctx->phy_reset_gpio) {
+		gpiod_direction_output(ctx->phy_reset_gpio, 1);
+		gpiod_set_value(ctx->phy_reset_gpio, 0);
+		gpiod_set_value(ctx->phy_reset_gpio, 1);
+		gpiod_set_value(ctx->phy_reset_gpio, 0);
+	}
+
+	/* Release the reset of internal PHY */
+	return regmap_update_bits(ctx->cuphy_ctrl, ctx->props->cuphy_reg,
+				  ctx->props->cuphy_bit, ctx->props->cuphy_bit);
 }
 
 static const struct reset_control_ops sparx5_reset_ops = {
@@ -111,17 +141,52 @@ static int mchp_sparx5_reset_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	/* This resource is required on lan966x, to take the internal PHYs out
+	 * of reset
+	 */
+	err = mchp_sparx5_map_syscon(pdev, "cuphy-syscon", &ctx->cuphy_ctrl);
+	if (err && err != -ENODEV)
+		return err;
+
 	ctx->rcdev.owner = THIS_MODULE;
 	ctx->rcdev.nr_resets = 1;
 	ctx->rcdev.ops = &sparx5_reset_ops;
 	ctx->rcdev.of_node = dn;
+	ctx->props = device_get_match_data(&pdev->dev);
+
+	ctx->phy_reset_gpio = devm_gpiod_get_optional(&pdev->dev, "phy-reset",
+						      GPIOD_OUT_LOW);
+	if (IS_ERR(ctx->phy_reset_gpio)) {
+		dev_err(&pdev->dev, "Could not get reset GPIO\n");
+		return PTR_ERR(ctx->phy_reset_gpio);
+	}
 
 	return devm_reset_controller_register(&pdev->dev, &ctx->rcdev);
 }
 
+static const struct reset_props reset_props_sparx5 = {
+	.protect_reg    = 0x84,
+	.protect_bit    = BIT(10),
+	.reset_reg      = 0x0,
+	.reset_bit      = BIT(1),
+};
+
+static const struct reset_props reset_props_lan966x = {
+	.protect_reg    = 0x88,
+	.protect_bit    = BIT(5),
+	.reset_reg      = 0x0,
+	.reset_bit      = BIT(1),
+	.cuphy_reg       = 0x10,
+	.cuphy_bit       = BIT(0),
+};
+
 static const struct of_device_id mchp_sparx5_reset_of_match[] = {
 	{
 		.compatible = "microchip,sparx5-switch-reset",
+		.data = &reset_props_sparx5,
+	}, {
+		.compatible = "microchip,lan966x-switch-reset",
+		.data = &reset_props_lan966x,
 	},
 	{ }
 };
-- 
2.33.0

