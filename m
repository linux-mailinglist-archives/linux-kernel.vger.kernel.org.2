Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E7A3C65A1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 23:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbhGLVtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 17:49:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229555AbhGLVtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 17:49:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6474161242;
        Mon, 12 Jul 2021 21:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626126410;
        bh=WJG/ocs5W2Sk0uKRotxoUlG1FHrLFq1eVrWQh+t63GI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=puGTg+E0X/UMAlMGt3iAaJcxqhzhjSJabkGr5/tkjIXd0aaU8+hqlxxRAD68WWjWs
         J2fWDhU0o9h0bTAM5pglgpbzjkA4zCXU0ohES/IfaeSygnVngmue/qYN+rmBsTMVQF
         BWgiUz4ZE2HUFc1m0a+95yWgbghyfqi/gmGXQ77n2qSgoItgeRGLZ2cok/8gjdCYWA
         wlxdRDbrpjyT7cAnF9mxmngSRq/rLTW9w8OZyzBTlMU7jsHkCANumeoqHm8BG2hGrs
         AWd6YY2WPAHfyRzFMfZlS+McUXDgpXJssE/A/p55L1G1Ys+7Bq3gkfVlWXBgQ0FMup
         370J3J0PXDb0g==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m33lI-005VRR-9y; Mon, 12 Jul 2021 23:46:48 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Manivannan Sadhasivam" <mani@kernel.org>,
        "Rob Herring" <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: [PATCH v4 5/8] phy: HiSilicon: Add driver for Kirin 960 PCIe PHY
Date:   Mon, 12 Jul 2021 23:46:43 +0200
Message-Id: <5501f28372f1f3ce1f86288c3de056d2799370a7.1626126198.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626126198.git.mchehab+huawei@kernel.org>
References: <cover.1626126198.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pcie-kirin PCIe driver contains internally a PHY interface for
a Kirin 960. As we'll be adding support also for Kirin 970 PHY, we
need to first split the PHY into a separate driver.

So, add a new driver with just the PHY part of
drivers/pci/controller/dwc/pcie-kirin.c.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/phy/hisilicon/Kconfig           |  10 +
 drivers/phy/hisilicon/Makefile          |   1 +
 drivers/phy/hisilicon/phy-hi3660-pcie.c | 325 ++++++++++++++++++++++++
 3 files changed, 336 insertions(+)
 create mode 100644 drivers/phy/hisilicon/phy-hi3660-pcie.c

diff --git a/drivers/phy/hisilicon/Kconfig b/drivers/phy/hisilicon/Kconfig
index 4d008cfc279c..30b7f1187965 100644
--- a/drivers/phy/hisilicon/Kconfig
+++ b/drivers/phy/hisilicon/Kconfig
@@ -23,6 +23,16 @@ config PHY_HI3660_USB
 
 	  To compile this driver as a module, choose M here.
 
+config PHY_HI3660_PCIE
+	tristate "hi3660 PCIe PHY support"
+	depends on (ARCH_HISI && ARM64) || COMPILE_TEST
+	select GENERIC_PHY
+	select MFD_SYSCON
+	help
+	  Enable this to support the HiSilicon hi3660 PCIe PHY.
+
+	  To compile this driver as a module, choose M here.
+
 config PHY_HI3670_USB
 	tristate "hi3670 USB PHY support"
 	depends on (ARCH_HISI && ARM64) || COMPILE_TEST
diff --git a/drivers/phy/hisilicon/Makefile b/drivers/phy/hisilicon/Makefile
index 51729868145b..3c3d70dd7469 100644
--- a/drivers/phy/hisilicon/Makefile
+++ b/drivers/phy/hisilicon/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_PHY_HI6220_USB)		+= phy-hi6220-usb.o
 obj-$(CONFIG_PHY_HI3660_USB)		+= phy-hi3660-usb3.o
+obj-$(CONFIG_PHY_HI3660_PCIE)		+= phy-hi3660-pcie.o
 obj-$(CONFIG_PHY_HI3670_USB)		+= phy-hi3670-usb3.o
 obj-$(CONFIG_PHY_HISTB_COMBPHY)		+= phy-histb-combphy.o
 obj-$(CONFIG_PHY_HISI_INNO_USB2)	+= phy-hisi-inno-usb2.o
diff --git a/drivers/phy/hisilicon/phy-hi3660-pcie.c b/drivers/phy/hisilicon/phy-hi3660-pcie.c
new file mode 100644
index 000000000000..130314b0e8cb
--- /dev/null
+++ b/drivers/phy/hisilicon/phy-hi3660-pcie.c
@@ -0,0 +1,325 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe phy driver for Kirin 960
+ *
+ * Copyright (C) 2017 HiSilicon Electronics Co., Ltd.
+ *		https://www.huawei.com
+ *
+ * Copyright (C) 2021 Huawei Electronics Co., Ltd.
+ *		https://www.huawei.com
+ *
+ * Author:
+ *	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+ */
+
+#include <linux/clk.h>
+#include <linux/gpio.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_gpio.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define REF_CLK_FREQ			100000000
+
+/* info located in APB PHY */
+#define PCIE_APB_PHY_CTRL0	0x0
+#define PCIE_APB_PHY_CTRL1	0x4
+#define PCIE_APB_PHY_STATUS0   0x400
+#define PIPE_CLK_STABLE		BIT(19)
+#define PHY_REF_PAD_BIT		BIT(8)
+#define PHY_PWR_DOWN_BIT	BIT(22)
+#define PHY_RST_ACK_BIT		BIT(16)
+
+/* info located in sysctrl */
+#define SCTRL_PCIE_CMOS_OFFSET	0x60
+#define SCTRL_PCIE_CMOS_BIT	0x10
+#define SCTRL_PCIE_ISO_OFFSET	0x44
+#define SCTRL_PCIE_ISO_BIT	0x30
+#define SCTRL_PCIE_HPCLK_OFFSET	0x190
+#define SCTRL_PCIE_HPCLK_BIT	0x184000
+#define SCTRL_PCIE_OE_OFFSET	0x14a
+#define PCIE_DEBOUNCE_PARAM	0xF0F400
+#define PCIE_OE_BYPASS		(0x3 << 28)
+
+/* peri_crg ctrl */
+#define CRGCTRL_PCIE_ASSERT_OFFSET	0x88
+#define CRGCTRL_PCIE_ASSERT_BIT		0x8c000000
+
+/* Time for delay */
+#define REF_2_PERST_MIN		20000
+#define REF_2_PERST_MAX		25000
+#define PERST_2_ACCESS_MIN	10000
+#define PERST_2_ACCESS_MAX	12000
+#define PIPE_CLK_WAIT_MIN	550
+#define PIPE_CLK_WAIT_MAX	600
+#define TIME_CMOS_MIN		100
+#define TIME_CMOS_MAX		105
+#define TIME_PHY_PD_MIN		10
+#define TIME_PHY_PD_MAX		11
+
+struct hi3660_pcie_phy {
+	struct device	*dev;
+	void __iomem	*base;
+	struct regmap	*crgctrl;
+	struct regmap	*sysctrl;
+	struct clk	*apb_sys_clk;
+	struct clk	*apb_phy_clk;
+	struct clk	*phy_ref_clk;
+	struct clk	*pcie_aclk;
+	struct clk	*pcie_aux_clk;
+	int		gpio_id_reset;
+};
+
+/* Registers in PCIePHY */
+static inline void kirin_apb_phy_writel(struct hi3660_pcie_phy *hi3660_pcie_phy,
+					u32 val, u32 reg)
+{
+	writel(val, hi3660_pcie_phy->base + reg);
+}
+
+static inline u32 kirin_apb_phy_readl(struct hi3660_pcie_phy *hi3660_pcie_phy,
+				      u32 reg)
+{
+	return readl(hi3660_pcie_phy->base + reg);
+}
+
+static void hi3660_pcie_phy_oe_enable(struct hi3660_pcie_phy *phy)
+{
+	u32 val;
+
+	regmap_read(phy->sysctrl, SCTRL_PCIE_OE_OFFSET, &val);
+	val |= PCIE_DEBOUNCE_PARAM;
+	val &= ~PCIE_OE_BYPASS;
+	regmap_write(phy->sysctrl, SCTRL_PCIE_OE_OFFSET, val);
+}
+
+
+static int kirin_pcie_clk_ctrl(struct hi3660_pcie_phy *phy, bool enable)
+{
+	int ret = 0;
+
+	if (!enable)
+		goto close_clk;
+
+	ret = clk_set_rate(phy->phy_ref_clk, REF_CLK_FREQ);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(phy->phy_ref_clk);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(phy->apb_sys_clk);
+	if (ret)
+		goto apb_sys_fail;
+
+	ret = clk_prepare_enable(phy->apb_phy_clk);
+	if (ret)
+		goto apb_phy_fail;
+
+	ret = clk_prepare_enable(phy->pcie_aclk);
+	if (ret)
+		goto aclk_fail;
+
+	ret = clk_prepare_enable(phy->pcie_aux_clk);
+	if (ret)
+		goto aux_clk_fail;
+
+	return 0;
+
+close_clk:
+	clk_disable_unprepare(phy->pcie_aux_clk);
+aux_clk_fail:
+	clk_disable_unprepare(phy->pcie_aclk);
+aclk_fail:
+	clk_disable_unprepare(phy->apb_phy_clk);
+apb_phy_fail:
+	clk_disable_unprepare(phy->apb_sys_clk);
+apb_sys_fail:
+	clk_disable_unprepare(phy->phy_ref_clk);
+
+	return ret;
+}
+
+static int hi3660_pcie_phy_power_on(struct phy *generic_phy)
+{
+	struct hi3660_pcie_phy *phy = phy_get_drvdata(generic_phy);
+	struct device *dev = phy->dev;
+	u32 reg_val;
+	int ret;
+
+	/* Power supply for Host */
+	regmap_write(phy->sysctrl,
+		     SCTRL_PCIE_CMOS_OFFSET, SCTRL_PCIE_CMOS_BIT);
+	usleep_range(TIME_CMOS_MIN, TIME_CMOS_MAX);
+
+	hi3660_pcie_phy_oe_enable(phy);
+
+	ret = kirin_pcie_clk_ctrl(phy, true);
+	if (ret)
+		return ret;
+
+	/* ISO disable, PCIeCtrl, PHY assert and clk gate clear */
+	regmap_write(phy->sysctrl,
+		     SCTRL_PCIE_ISO_OFFSET, SCTRL_PCIE_ISO_BIT);
+	regmap_write(phy->crgctrl,
+		     CRGCTRL_PCIE_ASSERT_OFFSET, CRGCTRL_PCIE_ASSERT_BIT);
+	regmap_write(phy->sysctrl,
+		     SCTRL_PCIE_HPCLK_OFFSET, SCTRL_PCIE_HPCLK_BIT);
+
+	reg_val = kirin_apb_phy_readl(phy, PCIE_APB_PHY_CTRL1);
+	reg_val &= ~PHY_REF_PAD_BIT;
+	kirin_apb_phy_writel(phy, reg_val, PCIE_APB_PHY_CTRL1);
+
+	reg_val = kirin_apb_phy_readl(phy, PCIE_APB_PHY_CTRL0);
+	reg_val &= ~PHY_PWR_DOWN_BIT;
+	kirin_apb_phy_writel(phy, reg_val, PCIE_APB_PHY_CTRL0);
+	usleep_range(TIME_PHY_PD_MIN, TIME_PHY_PD_MAX);
+
+	reg_val = kirin_apb_phy_readl(phy, PCIE_APB_PHY_CTRL1);
+	reg_val &= ~PHY_RST_ACK_BIT;
+	kirin_apb_phy_writel(phy, reg_val, PCIE_APB_PHY_CTRL1);
+
+	usleep_range(PIPE_CLK_WAIT_MIN, PIPE_CLK_WAIT_MAX);
+	reg_val = kirin_apb_phy_readl(phy, PCIE_APB_PHY_STATUS0);
+	if (reg_val & PIPE_CLK_STABLE) {
+		dev_err(dev, "PIPE clk is not stable\n");
+		ret = -EINVAL;
+		goto disable_clks;
+	}
+
+	/* perst assert Endpoint */
+	if (!gpio_request(phy->gpio_id_reset, "pcie_perst")) {
+		usleep_range(REF_2_PERST_MIN, REF_2_PERST_MAX);
+		ret = gpio_direction_output(phy->gpio_id_reset, 1);
+		if (ret)
+			goto disable_clks;
+		usleep_range(PERST_2_ACCESS_MIN, PERST_2_ACCESS_MAX);
+		return 0;
+	}
+
+disable_clks:
+	kirin_pcie_clk_ctrl(phy, false);
+	return ret;
+}
+
+static int hi3660_pcie_phy_power_off(struct phy *generic_phy)
+{
+	struct hi3660_pcie_phy *phy = phy_get_drvdata(generic_phy);
+
+	/* Drop power supply for Host */
+	regmap_write(phy->sysctrl, SCTRL_PCIE_CMOS_OFFSET, 0x00);
+
+	kirin_pcie_clk_ctrl(phy, false);
+
+	return 0;
+}
+
+static const struct phy_ops hi3660_phy_ops = {
+	.power_on	= hi3660_pcie_phy_power_on,
+	.power_off	= hi3660_pcie_phy_power_off,
+	.owner		= THIS_MODULE,
+};
+
+static int kirin_pcie_get_resources(struct hi3660_pcie_phy *phy,
+				    struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+
+	/* syscon */
+	phy->crgctrl = syscon_regmap_lookup_by_compatible("hisilicon,hi3660-crgctrl");
+	if (IS_ERR(phy->crgctrl))
+		return PTR_ERR(phy->crgctrl);
+
+	phy->sysctrl = syscon_regmap_lookup_by_compatible("hisilicon,hi3660-sctrl");
+	if (IS_ERR(phy->sysctrl))
+		return PTR_ERR(phy->sysctrl);
+
+	/* clocks */
+	phy->phy_ref_clk = devm_clk_get(dev, "pcie_phy_ref");
+	if (IS_ERR(phy->phy_ref_clk))
+		return PTR_ERR(phy->phy_ref_clk);
+
+	phy->pcie_aux_clk = devm_clk_get(dev, "pcie_aux");
+	if (IS_ERR(phy->pcie_aux_clk))
+		return PTR_ERR(phy->pcie_aux_clk);
+
+	phy->apb_phy_clk = devm_clk_get(dev, "pcie_apb_phy");
+	if (IS_ERR(phy->apb_phy_clk))
+		return PTR_ERR(phy->apb_phy_clk);
+
+	phy->apb_sys_clk = devm_clk_get(dev, "pcie_apb_sys");
+	if (IS_ERR(phy->apb_sys_clk))
+		return PTR_ERR(phy->apb_sys_clk);
+
+	phy->pcie_aclk = devm_clk_get(dev, "pcie_aclk");
+	if (IS_ERR(phy->pcie_aclk))
+		return PTR_ERR(phy->pcie_aclk);
+
+	/* registers */
+	phy->base = devm_platform_ioremap_resource_byname(pdev, "phy");
+	if (IS_ERR(phy->base))
+		return PTR_ERR(phy->base);
+
+	/* gpios */
+	phy->gpio_id_reset = of_get_named_gpio(dev->of_node,
+					       "reset-gpios", 0);
+	if (phy->gpio_id_reset == -EPROBE_DEFER) {
+		return -EPROBE_DEFER;
+	} else if (!gpio_is_valid(phy->gpio_id_reset)) {
+		dev_err(dev, "unable to get a valid gpio pin\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int hi3660_pcie_phy_probe(struct platform_device *pdev)
+{
+	struct phy_provider *phy_provider;
+	struct device *dev = &pdev->dev;
+	struct hi3660_pcie_phy *phy;
+	struct phy *generic_phy;
+	int ret;
+
+	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
+	if (!phy)
+		return -ENOMEM;
+
+	phy->dev = dev;
+
+	ret = kirin_pcie_get_resources(phy, pdev);
+	if (ret)
+		return ret;
+
+	generic_phy = devm_phy_create(dev, dev->of_node, &hi3660_phy_ops);
+	if (IS_ERR(generic_phy)) {
+		dev_err(dev, "failed to create PHY\n");
+		return PTR_ERR(generic_phy);
+	}
+
+	phy_set_drvdata(generic_phy, phy);
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static const struct of_device_id hi3660_pcie_phy_match[] = {
+	{
+		.compatible = "hisilicon,hi960-pcie-phy",
+	},
+	{},
+};
+
+static struct platform_driver hi3660_pcie_phy_driver = {
+	.probe	= hi3660_pcie_phy_probe,
+	.driver = {
+		.of_match_table	= hi3660_pcie_phy_match,
+		.name		= "hi3660_pcie_phy",
+		.suppress_bind_attrs = true,
+	}
+};
+builtin_platform_driver(hi3660_pcie_phy_driver);
-- 
2.31.1

