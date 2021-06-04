Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475C839C017
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 21:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhFDTFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 15:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhFDTFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 15:05:46 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DD5C061766;
        Fri,  4 Jun 2021 12:03:59 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso4724193wmc.1;
        Fri, 04 Jun 2021 12:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Twf9jLAwNkQLT/Ujy3oKloWts7LR/OdCMpxXY26zthg=;
        b=MP1bQU74xRmIPbbCW5IfT+gtc1NZbEbx9s8o/Qh6TED2ofeYU181cNMzQJKG7vAr2D
         CkfCrALUhSJuXNr2NpeMOCYqOu7yQzZ3FV3mVNu+smsnfyt9mUlkxhxmNA30estAfJur
         wOU6Z6m5uvF71GLaV9tm9FbPwDFAuOQ7NuMxrImxqpg+KL4C4z1J0aiwHg1EEFCQBPs+
         oIul4zenm0OZlgRuf98T5OCFRNi9Puy1qbMfd0A9DPbpoD7YKnE3x+kKVWS04FW07BG7
         zRNtwzSFrvQTQjfhIQNK2ifJv+Jbu0ueqJyhY6GckpNU5C47tvJTiSFemdkIV9mR7msf
         oD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Twf9jLAwNkQLT/Ujy3oKloWts7LR/OdCMpxXY26zthg=;
        b=jJOF2X42Af6AUBXYZWmpojcKWYTCG0dFjf8jB5gWGCEVDrVd+ghzYLkCfZwMv6iM3M
         uFvZrau4T1Sj90YvS13I+94tiAqnDXXD8J7X1Qblv6nJ5fEz9FhMshBVw49QJTwjAjZw
         nQbkyFQW5KnMIljvwsV3f4Q9SLIrqwpL5RnSBs3/5do5k9wroiNuZqrwzTpUWcCj1Y/2
         SgrVuD8IaRADeuKxcYc3J6o7I4ne1mRWgXhURvSBRaTzGxHYEBx/d9fRsqyEjkDvomho
         3nobK4qVWBerJrmMS2y0H2+AvpEckC3gvFGazEFW47qd8AfFMK8c3/dRVEnNpToCGu62
         IBXw==
X-Gm-Message-State: AOAM533xBptTACX05fITAEiI3ZmnvLVeY16C6BlToL1TKwYgDbScccdY
        AbThCT8q75X0OzhAtIfRS8s=
X-Google-Smtp-Source: ABdhPJytzExsCF3VUCig9c0sedFUkKAZMizhqxJiYlsmCY4WJCwJJhIj+2PCmu37/Tn7SInLTg5y3Q==
X-Received: by 2002:a7b:c4d2:: with SMTP id g18mr4973716wmk.25.1622833437623;
        Fri, 04 Jun 2021 12:03:57 -0700 (PDT)
Received: from localhost.localdomain (p200300f137127c00f22f74fffe210725.dip0.t-ipconnect.de. [2003:f1:3712:7c00:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id x10sm7576200wrt.65.2021.06.04.12.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 12:03:57 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     robh+dt@kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     kishon@ti.com, vkoul@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/2] phy: amlogic: Add a new driver for the HDMI TX PHY on Meson8/8b/8m2
Date:   Fri,  4 Jun 2021 21:03:38 +0200
Message-Id: <20210604190338.2248295-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210604190338.2248295-1-martin.blumenstingl@googlemail.com>
References: <20210604190338.2248295-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic Meson8/8b/8m2 have a built-in HDMI PHY in the HHI register
region. Unfortunately only few register bits are documented. For
HHI_HDMI_PHY_CNTL0 the magic numbers are taken from the 3.10 vendor
kernel.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/phy/amlogic/Kconfig              |  11 ++
 drivers/phy/amlogic/Makefile             |   1 +
 drivers/phy/amlogic/phy-meson8-hdmi-tx.c | 150 +++++++++++++++++++++++
 3 files changed, 162 insertions(+)
 create mode 100644 drivers/phy/amlogic/phy-meson8-hdmi-tx.c

diff --git a/drivers/phy/amlogic/Kconfig b/drivers/phy/amlogic/Kconfig
index db5d0cd757e3..e6c3a2a8b769 100644
--- a/drivers/phy/amlogic/Kconfig
+++ b/drivers/phy/amlogic/Kconfig
@@ -2,6 +2,17 @@
 #
 # Phy drivers for Amlogic platforms
 #
+config PHY_MESON8_HDMI_TX
+	tristate "Meson8, Meson8b and Meson8m2 HDMI TX PHY driver"
+	default ARCH_MESON
+	depends on (ARCH_MESON && ARM) || COMPILE_TEST
+	depends on OF
+	select MFD_SYSCON
+	help
+	  Enable this to support the HDMI TX PHYs found in Meson8,
+	  Meson8b and Meson8m2 SoCs.
+	  If unsure, say N.
+
 config PHY_MESON8B_USB2
 	tristate "Meson8, Meson8b, Meson8m2 and GXBB USB2 PHY driver"
 	default ARCH_MESON
diff --git a/drivers/phy/amlogic/Makefile b/drivers/phy/amlogic/Makefile
index 8fa07fbd0d92..c0886c850bb0 100644
--- a/drivers/phy/amlogic/Makefile
+++ b/drivers/phy/amlogic/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_PHY_MESON8_HDMI_TX)		+= phy-meson8-hdmi-tx.o
 obj-$(CONFIG_PHY_MESON8B_USB2)			+= phy-meson8b-usb2.o
 obj-$(CONFIG_PHY_MESON_GXL_USB2)		+= phy-meson-gxl-usb2.o
 obj-$(CONFIG_PHY_MESON_G12A_USB2)		+= phy-meson-g12a-usb2.o
diff --git a/drivers/phy/amlogic/phy-meson8-hdmi-tx.c b/drivers/phy/amlogic/phy-meson8-hdmi-tx.c
new file mode 100644
index 000000000000..8f13960a4492
--- /dev/null
+++ b/drivers/phy/amlogic/phy-meson8-hdmi-tx.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Meson8, Meson8b and Meson8m2 HDMI TX PHY.
+ *
+ * Copyright (C) 2020 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define HHI_HDMI_PHY_CNTL0				0x3a0
+	#define HHI_HDMI_PHY_CNTL0_HDMI_CTL1		GENMASK(31, 16)
+	#define HHI_HDMI_PHY_CNTL0_HDMI_CTL0		GENMASK(15, 0)
+
+#define HHI_HDMI_PHY_CNTL1				0x3a4
+	#define HHI_HDMI_PHY_CNTL1_CLOCK_ENABLE		BIT(1)
+	#define HHI_HDMI_PHY_CNTL1_SOFT_RESET		BIT(0)
+
+#define HHI_HDMI_PHY_CNTL2				0x3a8
+
+struct phy_meson8_hdmi_tx_priv {
+	struct regmap		*hhi;
+	struct clk		*tmds_clk;
+};
+
+static int phy_meson8_hdmi_tx_init(struct phy *phy)
+{
+	struct phy_meson8_hdmi_tx_priv *priv = phy_get_drvdata(phy);
+
+	return clk_prepare_enable(priv->tmds_clk);
+}
+
+static int phy_meson8_hdmi_tx_exit(struct phy *phy)
+{
+	struct phy_meson8_hdmi_tx_priv *priv = phy_get_drvdata(phy);
+
+	clk_disable_unprepare(priv->tmds_clk);
+
+	return 0;
+}
+
+static int phy_meson8_hdmi_tx_power_on(struct phy *phy)
+{
+	struct phy_meson8_hdmi_tx_priv *priv = phy_get_drvdata(phy);
+	unsigned int i;
+	u16 hdmi_ctl0;
+
+	if (clk_get_rate(priv->tmds_clk) >= 2970UL * 1000 * 1000)
+		hdmi_ctl0 = 0x1e8b;
+	else
+		hdmi_ctl0 = 0x4d0b;
+
+	regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL0,
+		     FIELD_PREP(HHI_HDMI_PHY_CNTL0_HDMI_CTL1, 0x08c3) |
+		     FIELD_PREP(HHI_HDMI_PHY_CNTL0_HDMI_CTL0, hdmi_ctl0));
+
+	regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL1, 0x00000000);
+
+	/* Reset three times, just like the vendor driver does */
+	for (i = 0; i < 3; i++) {
+		regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL1,
+			     HHI_HDMI_PHY_CNTL1_CLOCK_ENABLE |
+			     HHI_HDMI_PHY_CNTL1_SOFT_RESET);
+		usleep_range(1000, 2000);
+
+		regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL1,
+			     HHI_HDMI_PHY_CNTL1_CLOCK_ENABLE);
+		usleep_range(1000, 2000);
+	}
+
+	return 0;
+}
+
+static int phy_meson8_hdmi_tx_power_off(struct phy *phy)
+{
+	struct phy_meson8_hdmi_tx_priv *priv = phy_get_drvdata(phy);
+
+	regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL0,
+		     FIELD_PREP(HHI_HDMI_PHY_CNTL0_HDMI_CTL1, 0x0841) |
+		     FIELD_PREP(HHI_HDMI_PHY_CNTL0_HDMI_CTL0, 0x8d00));
+
+	return 0;
+}
+
+static const struct phy_ops phy_meson8_hdmi_tx_ops = {
+	.init		= phy_meson8_hdmi_tx_init,
+	.exit		= phy_meson8_hdmi_tx_exit,
+	.power_on	= phy_meson8_hdmi_tx_power_on,
+	.power_off	= phy_meson8_hdmi_tx_power_off,
+	.owner		= THIS_MODULE,
+};
+
+static int phy_meson8_hdmi_tx_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct phy_meson8_hdmi_tx_priv *priv;
+	struct phy_provider *phy_provider;
+	struct phy *phy;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->hhi = syscon_node_to_regmap(np->parent);
+	if (IS_ERR(priv->hhi))
+		return PTR_ERR(priv->hhi);
+
+	priv->tmds_clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(priv->tmds_clk))
+		return PTR_ERR(priv->tmds_clk);
+
+	phy = devm_phy_create(&pdev->dev, np, &phy_meson8_hdmi_tx_ops);
+	if (IS_ERR(phy))
+		return PTR_ERR(phy);
+
+	phy_set_drvdata(phy, priv);
+
+	phy_provider = devm_of_phy_provider_register(&pdev->dev,
+						     of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static const struct of_device_id phy_meson8_hdmi_tx_of_match[] = {
+	{ .compatible = "amlogic,meson8-hdmi-tx-phy" },
+	{ .compatible = "amlogic,meson8b-hdmi-tx-phy" },
+	{ .compatible = "amlogic,meson8m2-hdmi-tx-phy" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, phy_meson8_hdmi_tx_of_match);
+
+static struct platform_driver phy_meson8_hdmi_tx_driver = {
+	.probe	= phy_meson8_hdmi_tx_probe,
+	.driver	= {
+		.name		= "phy-meson8-hdmi-tx",
+		.of_match_table	= phy_meson8_hdmi_tx_of_match,
+	},
+};
+module_platform_driver(phy_meson8_hdmi_tx_driver);
+
+MODULE_AUTHOR("Martin Blumenstingl <martin.blumenstingl@googlemail.com>");
+MODULE_DESCRIPTION("Meson8, Meson8b and Meson8m2 HDMI TX PHY driver");
+MODULE_LICENSE("GPL v2");
-- 
2.31.1

