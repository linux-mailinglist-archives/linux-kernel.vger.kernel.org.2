Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E403B77C1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 20:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbhF2SXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 14:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235071AbhF2SXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 14:23:24 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C892C061760;
        Tue, 29 Jun 2021 11:20:57 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id t3so10994321edt.12;
        Tue, 29 Jun 2021 11:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h0zp9c8GYaiYKUAv6eUT71QHbk6kPshdSqicnQkyE6Q=;
        b=GrqadTrRLB1OVbXTgLZ0P82nA1TBRs/l2MN3GRvhnSYuPRq/H3zpCF1MRX7nxKN08V
         HhbFjFNMlAeFW+NSEsnSabrZVMfLa6p7urTMraGuxuabRcMLGmDKozGEEsPMJ9TR5TnZ
         +lNGazmW4Y/IkGfe4zIqhihhU7VU9khmzdJA7O+2bQNkjtvqjSTd+CulzsSBtLgANBye
         vfY6Pt8wtJdh6w7W0VzRMBFDFdaOZnaJOC7zx5qhPsb9PnTTu7K06EwKoqvupG8PATCs
         zsLdY60UccbpYwwPnHcOsXiQgCPWhHur4kVKl+oBokgegYtNFaQD/Rnv5jiqb9ySNwke
         QS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h0zp9c8GYaiYKUAv6eUT71QHbk6kPshdSqicnQkyE6Q=;
        b=TgZnpue1yQNdy/6MbYQmE2bNVB9qQz8iNUIuNh9PR5qNpDhRWXz+sMVcW4t9+w7Q1v
         qxiLSWcYMS1ra9bbgjAijmA3RUat2tHfNrSkPRtSlvd8VMB9ACLHgafs0f760Y28XOYr
         5Wd0gwy6yrMzEXT2CUSSVgWOhN88TTOf6HjRdouwcwlVKpDgTrwnrSGWG0+MDR2kZViz
         efUPRIm3onoLO5WcufkmOyTRcHvmy+WXuvGRGjee/+IGsWxV7b3WAwKysgXst5NTnqvJ
         sI4FqdO+S/bqYppyTO7YnbdBRAid2ydLvKIE22pu42GXa1Ph9E6mmLAKMkICAmFaRc74
         3oaQ==
X-Gm-Message-State: AOAM533hamp4r16HS52h+Ujfha+B7iUNhe/kiHNt5ZJna8O5ZGWzrXeA
        gHVDrYFEyttXVTfjS6XhjVc=
X-Google-Smtp-Source: ABdhPJxd3rITz9Rmq4AnFZFiP+aFgBj8RiN+lMf0hdEoCzeVQixzQC8yslUroVWHRPPIAnXyr1BYAg==
X-Received: by 2002:a50:f692:: with SMTP id d18mr41389020edn.202.1624990855557;
        Tue, 29 Jun 2021 11:20:55 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-c0d8-f500-f22f-74ff-fe21-0725.c23.pool.telefonica.de. [2a01:c23:c0d8:f500:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id v5sm11565678edt.55.2021.06.29.11.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 11:20:54 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     robh+dt@kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     kishon@ti.com, vkoul@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 2/2] phy: amlogic: Add a new driver for the HDMI TX PHY on Meson8/8b/8m2
Date:   Tue, 29 Jun 2021 20:20:47 +0200
Message-Id: <20210629182047.893415-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210629182047.893415-1-martin.blumenstingl@googlemail.com>
References: <20210629182047.893415-1-martin.blumenstingl@googlemail.com>
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
 drivers/phy/amlogic/Kconfig              |  10 ++
 drivers/phy/amlogic/Makefile             |   1 +
 drivers/phy/amlogic/phy-meson8-hdmi-tx.c | 162 +++++++++++++++++++++++
 3 files changed, 173 insertions(+)
 create mode 100644 drivers/phy/amlogic/phy-meson8-hdmi-tx.c

diff --git a/drivers/phy/amlogic/Kconfig b/drivers/phy/amlogic/Kconfig
index db5d0cd757e3..486ca23aba32 100644
--- a/drivers/phy/amlogic/Kconfig
+++ b/drivers/phy/amlogic/Kconfig
@@ -2,6 +2,16 @@
 #
 # Phy drivers for Amlogic platforms
 #
+config PHY_MESON8_HDMI_TX
+	tristate "Meson8, Meson8b and Meson8m2 HDMI TX PHY driver"
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
index 000000000000..ba5a4de54811
--- /dev/null
+++ b/drivers/phy/amlogic/phy-meson8-hdmi-tx.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Meson8, Meson8b and Meson8m2 HDMI TX PHY.
+ *
+ * Copyright (C) 2021 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
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
+#include <linux/property.h>
+#include <linux/regmap.h>
+
+#define HHI_HDMI_PHY_CNTL0				0x0
+	#define HHI_HDMI_PHY_CNTL0_HDMI_CTL1		GENMASK(31, 16)
+	#define HHI_HDMI_PHY_CNTL0_HDMI_CTL0		GENMASK(15, 0)
+
+#define HHI_HDMI_PHY_CNTL1				0x4
+	#define HHI_HDMI_PHY_CNTL1_CLOCK_ENABLE		BIT(1)
+	#define HHI_HDMI_PHY_CNTL1_SOFT_RESET		BIT(0)
+
+#define HHI_HDMI_PHY_CNTL2				0x8
+
+struct phy_meson8_hdmi_tx_priv {
+	struct regmap		*hhi;
+	struct clk		*tmds_clk;
+	unsigned int		reg_offset;
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
+	regmap_write(priv->hhi, priv->reg_offset + HHI_HDMI_PHY_CNTL0,
+		     FIELD_PREP(HHI_HDMI_PHY_CNTL0_HDMI_CTL1, 0x08c3) |
+		     FIELD_PREP(HHI_HDMI_PHY_CNTL0_HDMI_CTL0, hdmi_ctl0));
+
+	regmap_write(priv->hhi, priv->reg_offset + HHI_HDMI_PHY_CNTL1, 0x0);
+
+	/* Reset three times, just like the vendor driver does */
+	for (i = 0; i < 3; i++) {
+		regmap_write(priv->hhi, priv->reg_offset + HHI_HDMI_PHY_CNTL1,
+			     HHI_HDMI_PHY_CNTL1_CLOCK_ENABLE |
+			     HHI_HDMI_PHY_CNTL1_SOFT_RESET);
+		usleep_range(1000, 2000);
+
+		regmap_write(priv->hhi, priv->reg_offset + HHI_HDMI_PHY_CNTL1,
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
+	regmap_write(priv->hhi, priv->reg_offset + HHI_HDMI_PHY_CNTL0,
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
+	u32 reg[2];
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	ret = device_property_read_u32_array(&pdev->dev, "reg", reg,
+					     ARRAY_SIZE(reg));
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to parse the 'reg' property\n");
+
+	priv->reg_offset = reg[0];
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
2.32.0

