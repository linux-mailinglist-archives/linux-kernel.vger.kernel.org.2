Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5FF42A384
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 13:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbhJLLn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 07:43:27 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:63556 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236281AbhJLLnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 07:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634038881; x=1665574881;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1LpXZZxvThioP6dpkUFesh3lL0PPL0maOPs8nipS5I0=;
  b=1Nk/tdEnPhKWzqr5wTQeXdUawWInMelAclrAs6D9LdxcChvuKdDOuJ/1
   gyI9wjOrFHz5fSh/QdabZ4bdOO6q08zy/qrDk+GHxA9LCwscgKTbR+hjw
   0Ga56lJsrbj4rBildn53hnNRYZTMWDfWjyJrXHW+L97lsLlnLyNfU9F4N
   SofCNW+I6kMSrYc/QkrkYZhe96aU65fEE+YR9m4mywy7qvqiROV/zX5bE
   hMbMvTvHY1ZyE1FLqt30wGgbzBQQvhobfxZgKZ5BXmD6ck4Av0gFYDlfc
   woYfIbQDk3/4sldXhLQyyC2+1q8ybvQEQcpesMsRvzsBttV0Z5wStPmQ3
   Q==;
IronPort-SDR: jVKpLKOZggnYkS0yTxugrNsEib5bQc51aFTkCpDoEUjtXQLdZOtOxFANecv55R6WW9fYD1DloJ
 Dts4xpjYXozM6FBw2QjUbaOPaIXE266uRH3hn/Jk6nvnc54S5qhY/ilU/c4pCABtyJi5JBxaNd
 w+IQ9PPqK+1/KIDrEZb+W1dT0SgkQPFybeWmQqeEe9xIG4TrWfaD0F/86y5QRDUdgASSlc3+YJ
 WpSqZjEGU9MsdvaSySl9Yn+O/B0XQ3idfs1A8FIYTgS8cxWsSbTXMylbDOFPdpgPrYZdqc+6Gj
 IkPfnWgA83WO/QHz46N6dn4V
X-IronPort-AV: E=Sophos;i="5.85,367,1624345200"; 
   d="scan'208";a="139395349"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Oct 2021 04:41:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 12 Oct 2021 04:41:19 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 12 Oct 2021 04:41:17 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>, <andrew@lunn.ch>,
        <lars.povlsen@microchip.com>, <Steen.Hegelund@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH v2 2/2] reset: mchp: sparx5: Extend support for lan966x
Date:   Tue, 12 Oct 2021 13:42:38 +0200
Message-ID: <20211012114238.2060101-3-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211012114238.2060101-1-horatiu.vultur@microchip.com>
References: <20211012114238.2060101-1-horatiu.vultur@microchip.com>
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
 drivers/reset/reset-microchip-sparx5.c | 80 +++++++++++++++++++++++---
 2 files changed, 73 insertions(+), 9 deletions(-)

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
index f01e7db8e83b..6594ab5c15fe 100644
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
+	struct gpio_desc *reset_gpio;
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
+	if (ctx->reset_gpio) {
+		gpiod_direction_output(ctx->reset_gpio, 1);
+		gpiod_set_value(ctx->reset_gpio, 0);
+		gpiod_set_value(ctx->reset_gpio, 1);
+		gpiod_set_value(ctx->reset_gpio, 0);
+	}
+
+	/* Release the reset of internal PHY */
+	return regmap_update_bits(ctx->cuphy_ctrl, ctx->props->cuphy_reg,
+				  ctx->props->cuphy_bit, ctx->props->cuphy_bit);
 }
 
 static const struct reset_control_ops sparx5_reset_ops = {
@@ -111,17 +141,51 @@ static int mchp_sparx5_reset_probe(struct platform_device *pdev)
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
+	ctx->reset_gpio = devm_gpiod_get_optional(&pdev->dev, NULL, GPIOD_OUT_LOW);
+	if (IS_ERR(ctx->reset_gpio)) {
+		dev_err(&pdev->dev, "Could not get reset GPIO\n");
+		return PTR_ERR(ctx->reset_gpio);
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

