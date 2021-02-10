Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3801B3160A2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 09:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbhBJIKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 03:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbhBJII0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 03:08:26 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CBBC0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 00:07:45 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id u14so1021700wmq.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 00:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fHWF5TDlNwWGy88TN4XkKblCivGgDwghMb/yRIfXJVc=;
        b=cinsfMD2U8mM0GToap11SPbtnC99Qfbe+bDzIyZs8ZgtVYwzcyy9ov4Otk+ESVw6W+
         enU7QIVLrG26UvZoVOkpQR7ZYeIo0echDDgmZABpzXZ1/jONrJkVazvXpfRbyB4tcS/x
         RHItnpJglH1r9NTQuB0Q8VsCiPbF5KBV4qCpaj/XFcZ6m/alLzgUxpCJAQIcFIJP8dQP
         kq5cfw4X9cGevzuSetMbWmZmfXvbZiL3/7OMwJCyGE5VWK8ZANmlu4j/JyJt6itPRv1h
         KqoD5NY36X70mtsPx21Q4QIXI+Cqhndc2nQS0IB2lZ1CXuo26qMh20ZRQKWEZiQ877bK
         pLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fHWF5TDlNwWGy88TN4XkKblCivGgDwghMb/yRIfXJVc=;
        b=AhJhm6ryAzvUhyZiqEM3/T7USWdXQgVW6/TgudD6v+8YNipwN3eNu/nBZQ+kEzNed3
         A6pzFvBmCxlS4BkOCehZkKp0ALT157xZOp9NcNTtT9g92DlTfC/MJi4mjPSOmyALpvmV
         kDQ76fL742Mu7vJ0ePL4JrT0u9Go5jwUzIhFHqEaG8iL1VkrWw89cxauW5gUoEN5ecPT
         79wMHQMTEy7ZiHaSXVqj2VwWtJTqRBexb2TV1zBxew5XnM7R9k15XaLK9vW6dHRA+6+q
         CzHfnbi9SgV1YJ4YwDruZMkUoEGJggfalEXO1akthgdyK5GCH0cq6ZP9SjhnqTMRC7KX
         r8TA==
X-Gm-Message-State: AOAM530Yjuq5YpS4IWgzjiHQmD5HP68e4vasxh+h83rqyYpA/0ujyXBo
        95Xo3eGqQBBYlu0UY01br0wk9Q==
X-Google-Smtp-Source: ABdhPJyvyg0OOoJX/A+h1gkHVGS9Wu4fKqsYe0hXvbtoB5ZO1e+KN/++IwDacRxiYyAOFACphiYfrw==
X-Received: by 2002:a05:600c:3589:: with SMTP id p9mr1782867wmq.18.1612944464625;
        Wed, 10 Feb 2021 00:07:44 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:d403:f5fa:8912:cba5])
        by smtp.gmail.com with ESMTPSA id c18sm12856597wmk.0.2021.02.10.00.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 00:07:44 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     vkoul@kernel.org, kishon@ti.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 2/2] phy: amlogic: Add G12A Analog MIPI D-PHY driver
Date:   Wed, 10 Feb 2021 09:07:36 +0100
Message-Id: <20210210080736.771803-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210210080736.771803-1-narmstrong@baylibre.com>
References: <20210210080736.771803-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic G12A SoCs embeds an Analog MIPI D-PHY used to communicate with DSI
panels.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/phy/amlogic/Kconfig                   |  12 ++
 drivers/phy/amlogic/Makefile                  |   1 +
 .../amlogic/phy-meson-g12a-mipi-dphy-analog.c | 177 ++++++++++++++++++
 3 files changed, 190 insertions(+)
 create mode 100644 drivers/phy/amlogic/phy-meson-g12a-mipi-dphy-analog.c

diff --git a/drivers/phy/amlogic/Kconfig b/drivers/phy/amlogic/Kconfig
index db5d0cd757e3..ac898a102bcc 100644
--- a/drivers/phy/amlogic/Kconfig
+++ b/drivers/phy/amlogic/Kconfig
@@ -49,6 +49,18 @@ config PHY_MESON_G12A_USB3_PCIE
 	  in Meson G12A SoCs.
 	  If unsure, say N.
 
+config PHY_MESON_G12A_MIPI_DPHY_ANALOG
+	tristate "Meson G12A MIPI Analog DPHY driver"
+	default ARCH_MESON
+	depends on OF && (ARCH_MESON || COMPILE_TEST)
+	select GENERIC_PHY
+	select REGMAP_MMIO
+	select GENERIC_PHY_MIPI_DPHY
+	help
+	  Enable this to support the Meson MIPI Analog DPHY found in Meson G12A
+	  SoCs.
+	  If unsure, say N.
+
 config PHY_MESON_AXG_PCIE
 	tristate "Meson AXG PCIE PHY driver"
 	default ARCH_MESON
diff --git a/drivers/phy/amlogic/Makefile b/drivers/phy/amlogic/Makefile
index 8fa07fbd0d92..2eada0a683ca 100644
--- a/drivers/phy/amlogic/Makefile
+++ b/drivers/phy/amlogic/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_PHY_MESON8B_USB2)			+= phy-meson8b-usb2.o
 obj-$(CONFIG_PHY_MESON_GXL_USB2)		+= phy-meson-gxl-usb2.o
 obj-$(CONFIG_PHY_MESON_G12A_USB2)		+= phy-meson-g12a-usb2.o
 obj-$(CONFIG_PHY_MESON_G12A_USB3_PCIE)		+= phy-meson-g12a-usb3-pcie.o
+obj-$(CONFIG_PHY_MESON_G12A_MIPI_DPHY_ANALOG)	+= phy-meson-g12a-mipi-dphy-analog.o
 obj-$(CONFIG_PHY_MESON_AXG_PCIE)		+= phy-meson-axg-pcie.o
 obj-$(CONFIG_PHY_MESON_AXG_MIPI_PCIE_ANALOG)	+= phy-meson-axg-mipi-pcie-analog.o
 obj-$(CONFIG_PHY_MESON_AXG_MIPI_DPHY)		+= phy-meson-axg-mipi-dphy.o
diff --git a/drivers/phy/amlogic/phy-meson-g12a-mipi-dphy-analog.c b/drivers/phy/amlogic/phy-meson-g12a-mipi-dphy-analog.c
new file mode 100644
index 000000000000..6e9d416c0552
--- /dev/null
+++ b/drivers/phy/amlogic/phy-meson-g12a-mipi-dphy-analog.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Meson G12A MIPI DSI Analog PHY
+ *
+ * Copyright (C) 2018 Amlogic, Inc. All rights reserved
+ * Copyright (C) 2020 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/module.h>
+#include <linux/phy/phy.h>
+#include <linux/regmap.h>
+#include <linux/delay.h>
+#include <linux/mfd/syscon.h>
+#include <linux/platform_device.h>
+#include <dt-bindings/phy/phy.h>
+
+#define HHI_MIPI_CNTL0 0x00
+#define		HHI_MIPI_CNTL0_DIF_REF_CTL1	GENMASK(31, 16)
+#define		HHI_MIPI_CNTL0_DIF_REF_CTL0	GENMASK(15, 0)
+
+#define HHI_MIPI_CNTL1 0x04
+#define		HHI_MIPI_CNTL1_BANDGAP		BIT(16)
+#define		HHI_MIPI_CNTL2_DIF_REF_CTL2	GENMASK(15, 0)
+
+#define HHI_MIPI_CNTL2 0x08
+#define		HHI_MIPI_CNTL2_DIF_TX_CTL1	GENMASK(31, 16)
+#define		HHI_MIPI_CNTL2_CH_EN		GENMASK(15, 11)
+#define		HHI_MIPI_CNTL2_DIF_TX_CTL0	GENMASK(10, 0)
+
+#define DSI_LANE_0				BIT(4)
+#define DSI_LANE_1				BIT(3)
+#define DSI_LANE_CLK				BIT(2)
+#define DSI_LANE_2				BIT(1)
+#define DSI_LANE_3				BIT(0)
+
+struct phy_g12a_mipi_dphy_analog_priv {
+	struct phy *phy;
+	struct regmap *regmap;
+	struct phy_configure_opts_mipi_dphy config;
+};
+
+static int phy_g12a_mipi_dphy_analog_configure(struct phy *phy,
+					       union phy_configure_opts *opts)
+{
+	struct phy_g12a_mipi_dphy_analog_priv *priv = phy_get_drvdata(phy);
+	int ret;
+
+	ret = phy_mipi_dphy_config_validate(&opts->mipi_dphy);
+	if (ret)
+		return ret;
+
+	memcpy(&priv->config, opts, sizeof(priv->config));
+
+	return 0;
+}
+
+static int phy_g12a_mipi_dphy_analog_power_on(struct phy *phy)
+{
+	struct phy_g12a_mipi_dphy_analog_priv *priv = phy_get_drvdata(phy);
+	unsigned int reg;
+
+	regmap_write(priv->regmap, HHI_MIPI_CNTL0,
+		     FIELD_PREP(HHI_MIPI_CNTL0_DIF_REF_CTL0, 0x8) |
+		     FIELD_PREP(HHI_MIPI_CNTL0_DIF_REF_CTL1, 0xa487));
+
+	regmap_write(priv->regmap, HHI_MIPI_CNTL1,
+		     FIELD_PREP(HHI_MIPI_CNTL2_DIF_REF_CTL2, 0x2e) |
+		     HHI_MIPI_CNTL1_BANDGAP);
+
+	regmap_write(priv->regmap, HHI_MIPI_CNTL2,
+		     FIELD_PREP(HHI_MIPI_CNTL2_DIF_TX_CTL0, 0x459) |
+		     FIELD_PREP(HHI_MIPI_CNTL2_DIF_TX_CTL1, 0x2680));
+
+	reg = DSI_LANE_CLK;
+	switch (priv->config.lanes) {
+	case 4:
+		reg |= DSI_LANE_3;
+		fallthrough;
+	case 3:
+		reg |= DSI_LANE_2;
+		fallthrough;
+	case 2:
+		reg |= DSI_LANE_1;
+		fallthrough;
+	case 1:
+		reg |= DSI_LANE_0;
+		break;
+	default:
+		reg = 0;
+	}
+
+	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL2,
+			   HHI_MIPI_CNTL2_CH_EN,
+			   FIELD_PREP(HHI_MIPI_CNTL2_CH_EN, reg));
+
+	return 0;
+}
+
+static int phy_g12a_mipi_dphy_analog_power_off(struct phy *phy)
+{
+	struct phy_g12a_mipi_dphy_analog_priv *priv = phy_get_drvdata(phy);
+
+	regmap_write(priv->regmap, HHI_MIPI_CNTL0, 0);
+	regmap_write(priv->regmap, HHI_MIPI_CNTL1, 0);
+	regmap_write(priv->regmap, HHI_MIPI_CNTL2, 0);
+
+	return 0;
+}
+
+static const struct phy_ops phy_g12a_mipi_dphy_analog_ops = {
+	.configure = phy_g12a_mipi_dphy_analog_configure,
+	.power_on = phy_g12a_mipi_dphy_analog_power_on,
+	.power_off = phy_g12a_mipi_dphy_analog_power_off,
+	.owner = THIS_MODULE,
+};
+
+static int phy_g12a_mipi_dphy_analog_probe(struct platform_device *pdev)
+{
+	struct phy_provider *phy;
+	struct device *dev = &pdev->dev;
+	struct phy_g12a_mipi_dphy_analog_priv *priv;
+	struct device_node *np = dev->of_node;
+	struct regmap *map;
+	int ret;
+
+	priv = devm_kmalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	/* Get the hhi system controller node */
+	map = syscon_node_to_regmap(of_get_parent(dev->of_node));
+	if (IS_ERR(map)) {
+		dev_err(dev,
+			"failed to get HHI regmap\n");
+		return PTR_ERR(map);
+	}
+
+	priv->regmap = map;
+
+	priv->phy = devm_phy_create(dev, np, &phy_g12a_mipi_dphy_analog_ops);
+	if (IS_ERR(priv->phy)) {
+		ret = PTR_ERR(priv->phy);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to create PHY\n");
+		return ret;
+	}
+
+	phy_set_drvdata(priv->phy, priv);
+	dev_set_drvdata(dev, priv);
+
+	phy = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(phy);
+}
+
+static const struct of_device_id phy_g12a_mipi_dphy_analog_of_match[] = {
+	{
+		.compatible = "amlogic,g12a-mipi-dphy-analog",
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, phy_g12a_mipi_dphy_analog_of_match);
+
+static struct platform_driver phy_g12a_mipi_dphy_analog_driver = {
+	.probe = phy_g12a_mipi_dphy_analog_probe,
+	.driver = {
+		.name = "phy-meson-g12a-mipi-dphy-analog",
+		.of_match_table = phy_g12a_mipi_dphy_analog_of_match,
+	},
+};
+module_platform_driver(phy_g12a_mipi_dphy_analog_driver);
+
+MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
+MODULE_DESCRIPTION("Meson G12A MIPI Analog D-PHY driver");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

