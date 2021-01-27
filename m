Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C2F305A2A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236721AbhA0Loi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:44:38 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:3316 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236760AbhA0L3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:29:00 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10RBQ0fc027981;
        Wed, 27 Jan 2021 03:27:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=dkk3eo4AE3XQRtSLjQvxLjDUzlfO96EIux8Flb1KVio=;
 b=ZBT+5uJ4MmNW+5myvtzn+UWJRHKJWkPj+k4fEz9O5rn8S3yJXrtP1Pe833alEKGiRIqH
 lIpCGHbs0/jg392bop3j1+l2ToIOIIzVNtWweUkPfOdGAFkqNUgFNH4ML2TtNY/KQ1p9
 5BmH5B7i8GxE6GqvP1hKnar5/01rT3gcwVuxSf72mClq27BFCtUWoDu+L+6x4KVLTk4F
 TlsEqRzB+r+sFvdEslb3QDuGSX9jNEULe1Mb2A9JFYhMxqMeeUpjEIt1X2W5slw3zcv/
 ajH4qPx/+dRzqiLtfgJ92l51JnkZFgx6yb+rbgW8PuuN/ALAlwP5xdXy6nd0vz90tFJD dw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 36b1xpgt2d-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 27 Jan 2021 03:27:56 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 27 Jan
 2021 03:27:51 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 27 Jan
 2021 03:27:50 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 27 Jan 2021 03:27:50 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id B2C473F7040;
        Wed, 27 Jan 2021 03:27:46 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <lkundrak@v3.sk>,
        <linux@armlinux.org.uk>, <sebastian.hesselbarth@gmail.com>,
        <gregory.clement@bootlin.com>, <andrew@lunn.ch>,
        <robh+dt@kernel.org>, <vkoul@kernel.org>, <kishon@ti.com>,
        <miquel.raynal@bootlin.com>, <mw@semihalf.com>, <jaz@semihalf.com>,
        <nadavh@marvell.com>, <stefanc@marvell.com>, <bpeled@marvell.com>,
        "Konstantin Porotchkin" <kostap@marvell.com>
Subject: [PATCH 1/4] drivers: phy: add support for Armada CP110 UTMI PHY
Date:   Wed, 27 Jan 2021 13:27:16 +0200
Message-ID: <20210127112719.30632-2-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210127112719.30632-1-kostap@marvell.com>
References: <20210127112719.30632-1-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-27_04:2021-01-27,2021-01-27 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Porotchkin <kostap@marvell.com>

Add support for Marvell CP110 UTMI PHY driver allowing the USB2
port configuration independently from the boot loader setup.
The CP110/CP115 dies have 2 UTMI PHYs that could be connected
to two USB host controllers or to single USB device controller.
Since there is only one USB device controller on die, only one
of the UTMI PHYs could work in USB device mode.

Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
---
 drivers/phy/marvell/Kconfig                |   8 +
 drivers/phy/marvell/Makefile               |   1 +
 drivers/phy/marvell/phy-mvebu-cp110-utmi.c | 372 ++++++++++++++++++++
 3 files changed, 381 insertions(+)
 create mode 100644 drivers/phy/marvell/phy-mvebu-cp110-utmi.c

diff --git a/drivers/phy/marvell/Kconfig b/drivers/phy/marvell/Kconfig
index 6c96f2bf5266..9208839019bd 100644
--- a/drivers/phy/marvell/Kconfig
+++ b/drivers/phy/marvell/Kconfig
@@ -67,6 +67,14 @@ config PHY_MVEBU_CP110_COMPHY
 	  lanes can be used by various controllers (Ethernet, sata, usb,
 	  PCIe...).
 
+config PHY_MVEBU_CP110_UTMI
+	tristate "Marvell CP110 UTMI driver"
+	depends on ARCH_MVEBU || COMPILE_TEST
+	depends on OF
+	select GENERIC_PHY
+	help
+	  Enable this to support Marvell CP110 UTMI PHY driver.
+
 config PHY_MVEBU_SATA
 	def_bool y
 	depends on ARCH_DOVE || MACH_DOVE || MACH_KIRKWOOD
diff --git a/drivers/phy/marvell/Makefile b/drivers/phy/marvell/Makefile
index 7f296ef02829..90862c4daa26 100644
--- a/drivers/phy/marvell/Makefile
+++ b/drivers/phy/marvell/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_PHY_MVEBU_A3700_COMPHY)	+= phy-mvebu-a3700-comphy.o
 obj-$(CONFIG_PHY_MVEBU_A3700_UTMI)	+= phy-mvebu-a3700-utmi.o
 obj-$(CONFIG_PHY_MVEBU_A38X_COMPHY)	+= phy-armada38x-comphy.o
 obj-$(CONFIG_PHY_MVEBU_CP110_COMPHY)	+= phy-mvebu-cp110-comphy.o
+obj-$(CONFIG_PHY_MVEBU_CP110_UTMI)	+= phy-mvebu-cp110-utmi.o
 obj-$(CONFIG_PHY_MVEBU_SATA)		+= phy-mvebu-sata.o
 obj-$(CONFIG_PHY_PXA_28NM_HSIC)		+= phy-pxa-28nm-hsic.o
 obj-$(CONFIG_PHY_PXA_28NM_USB2)		+= phy-pxa-28nm-usb2.o
diff --git a/drivers/phy/marvell/phy-mvebu-cp110-utmi.c b/drivers/phy/marvell/phy-mvebu-cp110-utmi.c
new file mode 100644
index 000000000000..3a7499b24671
--- /dev/null
+++ b/drivers/phy/marvell/phy-mvebu-cp110-utmi.c
@@ -0,0 +1,372 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Marvell
+ *
+ * Authors:
+ *   Konstantin Porotchkin <kostap@marvell.com>
+ *
+ * Marvell CP110 UTMI PHY driver
+ */
+
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define UTMI_PHY_PORTS				2
+
+/* CP110 UTMI register macro definetions */
+#define SYSCON_USB_CFG_REG			0x420
+#define   USB_CFG_DEVICE_EN_MASK		BIT(0)
+#define   USB_CFG_DEVICE_MUX_OFFSET		1
+#define   USB_CFG_DEVICE_MUX_MASK		BIT(1)
+#define   USB_CFG_PLL_MASK			BIT(25)
+
+#define SYSCON_UTMI_CFG_REG(id)			(0x440 + (id) * 4)
+#define   UTMI_PHY_CFG_PU_MASK			BIT(5)
+
+#define UTMI_PLL_CTRL_REG			0x0
+#define   PLL_REFDIV_OFFSET			0
+#define   PLL_REFDIV_MASK			GENMASK(6, 0)
+#define   PLL_REFDIV_VAL			0x5
+#define   PLL_FBDIV_OFFSET			16
+#define   PLL_FBDIV_MASK			GENMASK(24, 16)
+#define   PLL_FBDIV_VAL				0x60
+#define   PLL_SEL_LPFR_MASK			GENMASK(29, 28)
+#define   PLL_RDY				BIT(31)
+#define UTMI_CAL_CTRL_REG			0x8
+#define   IMPCAL_VTH_OFFSET			8
+#define   IMPCAL_VTH_MASK			GENMASK(10, 8)
+#define   IMPCAL_VTH_VAL			0x7
+#define   IMPCAL_DONE				BIT(23)
+#define   PLLCAL_DONE				BIT(31)
+#define UTMI_TX_CH_CTRL_REG			0xC
+#define   DRV_EN_LS_OFFSET			12
+#define   DRV_EN_LS_MASK			GENMASK(15, 12)
+#define   IMP_SEL_LS_OFFSET			16
+#define   IMP_SEL_LS_MASK			GENMASK(19, 16)
+#define   TX_AMP_OFFSET				20
+#define   TX_AMP_MASK				GENMASK(22, 20)
+#define   TX_AMP_VAL				0x4
+#define UTMI_RX_CH_CTRL0_REG			0x14
+#define   SQ_DET_EN				BIT(15)
+#define   SQ_ANA_DTC_SEL			BIT(28)
+#define UTMI_RX_CH_CTRL1_REG			0x18
+#define   SQ_AMP_CAL_OFFSET			0
+#define   SQ_AMP_CAL_MASK			GENMASK(2, 0)
+#define   SQ_AMP_CAL_VAL			1
+#define   SQ_AMP_CAL_EN				BIT(3)
+#define UTMI_CTRL_STATUS0_REG			0x24
+#define   SUSPENDM				BIT(22)
+#define   TEST_SEL				BIT(25)
+#define UTMI_CHGDTC_CTRL_REG			0x38
+#define   VDAT_OFFSET				8
+#define   VDAT_MASK				GENMASK(9, 8)
+#define   VDAT_VAL				1
+#define   VSRC_OFFSET				10
+#define   VSRC_MASK				GENMASK(11, 10)
+#define   VSRC_VAL				1
+
+#define PLL_LOCK_DELAY_US			10000
+#define PLL_LOCK_TIMEOUT_US			1000000
+
+#define PORT_REGS(p)				((p)->priv->regs + (p)->id * 0x1000)
+
+/**
+ * struct mvebu_cp110_utmi - PHY driver data
+ *
+ * @regs: PHY registers
+ * @syscom: Regmap with system controller registers
+ * @dev: device driver handle
+ * @caps: PHY capabilities
+ */
+struct mvebu_cp110_utmi {
+	void __iomem *regs;
+	struct regmap *syscon;
+	struct device *dev;
+	const struct phy_ops *ops;
+};
+
+/**
+ * struct mvebu_cp110_utmi_port - PHY port data
+ *
+ * @priv: PHY driver data
+ * @id: PHY port ID
+ * @device_mode: PHY connection - 1 for USB device, 0 for USB host
+ */
+struct mvebu_cp110_utmi_port {
+	struct mvebu_cp110_utmi *priv;
+	u32 id;
+	bool device_mode;
+};
+
+static void mvebu_cp110_utmi_port_setup(struct mvebu_cp110_utmi_port *port)
+{
+	u32 reg;
+
+	/*
+	 * Setup PLL. 40MHz clock used to be the default, being 25MHz now.
+	 * See the functional specification for details.
+	 */
+	reg = readl(PORT_REGS(port) + UTMI_PLL_CTRL_REG);
+	reg &= ~(PLL_REFDIV_MASK | PLL_FBDIV_MASK | PLL_SEL_LPFR_MASK);
+	reg |= (PLL_REFDIV_VAL << PLL_REFDIV_OFFSET) |
+	       (PLL_FBDIV_VAL << PLL_FBDIV_OFFSET);
+	writel(reg, PORT_REGS(port) + UTMI_PLL_CTRL_REG);
+
+	/* Impedance Calibration Threshold Setting */
+	reg = readl(PORT_REGS(port) + UTMI_CAL_CTRL_REG);
+	reg &= ~IMPCAL_VTH_MASK;
+	reg |= IMPCAL_VTH_VAL << IMPCAL_VTH_OFFSET;
+	writel(reg, PORT_REGS(port) + UTMI_CAL_CTRL_REG);
+
+	/* Set LS TX driver strength coarse control */
+	reg = readl(PORT_REGS(port) + UTMI_TX_CH_CTRL_REG);
+	reg &= ~TX_AMP_MASK;
+	reg |= TX_AMP_VAL << TX_AMP_OFFSET;
+	writel(reg, PORT_REGS(port) + UTMI_TX_CH_CTRL_REG);
+
+	/* Disable SQ and enable analog squelch detect */
+	reg = readl(PORT_REGS(port) + UTMI_RX_CH_CTRL0_REG);
+	reg &= ~SQ_DET_EN;
+	reg |= SQ_ANA_DTC_SEL;
+	writel(reg, PORT_REGS(port) + UTMI_RX_CH_CTRL0_REG);
+
+	/*
+	 * Set External squelch calibration number and
+	 * enable the External squelch calibration
+	 */
+	reg = readl(PORT_REGS(port) + UTMI_RX_CH_CTRL1_REG);
+	reg &= ~SQ_AMP_CAL_MASK;
+	reg |= (SQ_AMP_CAL_VAL << SQ_AMP_CAL_OFFSET) | SQ_AMP_CAL_EN;
+	writel(reg, PORT_REGS(port) + UTMI_RX_CH_CTRL1_REG);
+
+	/*
+	 * Set Control VDAT Reference Voltage - 0.325V and
+	 * Control VSRC Reference Voltage - 0.6V
+	 */
+	reg = readl(PORT_REGS(port) + UTMI_CHGDTC_CTRL_REG);
+	reg &= ~(VDAT_MASK | VSRC_MASK);
+	reg |= (VDAT_VAL << VDAT_OFFSET) | (VSRC_VAL << VSRC_OFFSET);
+	writel(reg, PORT_REGS(port) + UTMI_CHGDTC_CTRL_REG);
+}
+
+static int mvebu_cp110_utmi_phy_power_off(struct phy *phy)
+{
+	struct mvebu_cp110_utmi_port *port = phy_get_drvdata(phy);
+	struct mvebu_cp110_utmi *utmi = port->priv;
+	int i;
+
+	/* Power down UTMI PHY port */
+	regmap_clear_bits(utmi->syscon, SYSCON_UTMI_CFG_REG(port->id),
+			  UTMI_PHY_CFG_PU_MASK);
+
+	for (i = 0; i < UTMI_PHY_PORTS; i++) {
+		int test = regmap_test_bits(utmi->syscon,
+					    SYSCON_UTMI_CFG_REG(i),
+					    UTMI_PHY_CFG_PU_MASK);
+		/* skip PLL shutdown if there are active UTMI PHY ports */
+		if (test != 0)
+			return 0;
+	}
+
+	/* PLL Power down if all UTMI PHYs are down */
+	regmap_clear_bits(utmi->syscon, SYSCON_USB_CFG_REG, USB_CFG_PLL_MASK);
+
+	return 0;
+}
+
+static int mvebu_cp110_utmi_phy_power_on(struct phy *phy)
+{
+	struct mvebu_cp110_utmi_port *port = phy_get_drvdata(phy);
+	struct mvebu_cp110_utmi *utmi = port->priv;
+	struct device *dev = &phy->dev;
+	int ret;
+	u32 reg;
+
+	/* It is necessary to power off UTMI before configuration */
+	ret = mvebu_cp110_utmi_phy_power_off(phy);
+	if (ret) {
+		dev_err(dev, "UTMI power OFF before power ON failed\n");
+		return ret;
+	}
+
+	/*
+	 * If UTMI port is connected to USB Device controller,
+	 * configure the USB MUX prior to UTMI PHY initialization.
+	 * The single USB device controller can be connected
+	 * to UTMI0 or to UTMI1 PHY port, but not to both.
+	 */
+	if (port->device_mode) {
+		regmap_update_bits(utmi->syscon, SYSCON_USB_CFG_REG,
+				   USB_CFG_DEVICE_EN_MASK | USB_CFG_DEVICE_MUX_MASK,
+				   USB_CFG_DEVICE_EN_MASK |
+				   (port->id << USB_CFG_DEVICE_MUX_OFFSET));
+	}
+
+	/* Set Test suspendm mode and enable Test UTMI select */
+	reg = readl(PORT_REGS(port) + UTMI_CTRL_STATUS0_REG);
+	reg |= SUSPENDM | TEST_SEL;
+	writel(reg, PORT_REGS(port) + UTMI_CTRL_STATUS0_REG);
+
+	/* Wait for UTMI power down */
+	mdelay(1);
+
+	/* PHY port setup first */
+	mvebu_cp110_utmi_port_setup(port);
+
+	/* Power UP UTMI PHY */
+	regmap_set_bits(utmi->syscon, SYSCON_UTMI_CFG_REG(port->id),
+			UTMI_PHY_CFG_PU_MASK);
+
+	/* Disable Test UTMI select */
+	reg = readl(PORT_REGS(port) + UTMI_CTRL_STATUS0_REG);
+	reg &= ~TEST_SEL;
+	writel(reg, PORT_REGS(port) + UTMI_CTRL_STATUS0_REG);
+
+	/* Wait for impedance calibration */
+	ret = readl_poll_timeout(PORT_REGS(port) + UTMI_CAL_CTRL_REG, reg,
+				 reg & IMPCAL_DONE,
+				 PLL_LOCK_DELAY_US, PLL_LOCK_TIMEOUT_US);
+	if (ret) {
+		dev_err(dev, "Failed to end UTMI impedance calibration\n");
+		return ret;
+	}
+
+	/* Wait for PLL calibration */
+	ret = readl_poll_timeout(PORT_REGS(port) + UTMI_CAL_CTRL_REG, reg,
+				 reg & PLLCAL_DONE,
+				 PLL_LOCK_DELAY_US, PLL_LOCK_TIMEOUT_US);
+	if (ret) {
+		dev_err(dev, "Failed to end UTMI PLL calibration\n");
+		return ret;
+	}
+
+	/* Wait for PLL ready */
+	ret = readl_poll_timeout(PORT_REGS(port) + UTMI_PLL_CTRL_REG, reg,
+				 reg & PLL_RDY,
+				 PLL_LOCK_DELAY_US, PLL_LOCK_TIMEOUT_US);
+	if (ret) {
+		dev_err(dev, "PLL is not ready\n");
+		return ret;
+	}
+
+	/* PLL Power up */
+	regmap_set_bits(utmi->syscon, SYSCON_USB_CFG_REG, USB_CFG_PLL_MASK);
+
+	return 0;
+}
+
+static const struct phy_ops mvebu_cp110_utmi_phy_ops = {
+	.power_on = mvebu_cp110_utmi_phy_power_on,
+	.power_off = mvebu_cp110_utmi_phy_power_off,
+	.owner = THIS_MODULE,
+};
+
+static const struct of_device_id mvebu_cp110_utmi_of_match[] = {
+	{ .compatible = "marvell,cp110-utmi-phy" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mvebu_cp110_utmi_of_match);
+
+static int mvebu_cp110_utmi_phy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mvebu_cp110_utmi *utmi;
+	struct phy_provider *provider;
+	struct device_node *child;
+	u32 usb_devices = 0;
+
+	utmi = devm_kzalloc(dev, sizeof(*utmi), GFP_KERNEL);
+	if (!utmi)
+		return -ENOMEM;
+
+	utmi->dev = dev;
+
+	/* Get system controller region */
+	utmi->syscon = syscon_regmap_lookup_by_phandle(dev->of_node,
+						       "marvell,system-controller");
+	if (IS_ERR(utmi->syscon)) {
+		dev_err(dev, "Missing UTMI system controller\n");
+		return PTR_ERR(utmi->syscon);
+	}
+
+	/* Get UTMI memory region */
+	utmi->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(utmi->regs))
+		return PTR_ERR(utmi->regs);
+
+	for_each_available_child_of_node(dev->of_node, child) {
+		struct mvebu_cp110_utmi_port *port;
+		struct phy *phy;
+		int ret;
+		u32 val;
+
+		ret = of_property_read_u32(child, "reg", &val);
+		if (ret < 0) {
+			dev_err(dev, "missing 'reg' property (%d)\n", ret);
+			continue;
+		}
+
+		if (val >= UTMI_PHY_PORTS) {
+			dev_err(dev, "invalid 'reg' property\n");
+			continue;
+		}
+
+		port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
+		if (!port) {
+			of_node_put(child);
+			return -ENOMEM;
+		}
+
+		port->device_mode = false;
+		if (of_property_read_bool(child, "marvell,cp110-utmi-device-mode")) {
+			usb_devices++;
+			if (usb_devices > 1)
+				dev_err(dev,
+					"Single USB device allowed! Port%d set as host\n", val);
+			else
+				port->device_mode = true;
+		}
+
+		/* Retrieve PHY capabilities */
+		utmi->ops = &mvebu_cp110_utmi_phy_ops;
+
+		/* Instantiate the PHY */
+		phy = devm_phy_create(dev, child, utmi->ops);
+		if (IS_ERR(phy)) {
+			dev_err(dev, "Failed to create the UTMI PHY\n");
+			of_node_put(child);
+			return PTR_ERR(phy);
+		}
+
+		port->priv = utmi;
+		port->id = val;
+		phy_set_drvdata(phy, port);
+
+		/* Ensure the PHY is powered off */
+		mvebu_cp110_utmi_phy_power_off(phy);
+	}
+
+	dev_set_drvdata(dev, utmi);
+	provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(provider);
+}
+
+static struct platform_driver mvebu_cp110_utmi_driver = {
+	.probe	= mvebu_cp110_utmi_phy_probe,
+	.driver	= {
+		.name		= "mvebu-cp110-utmi-phy",
+		.of_match_table	= mvebu_cp110_utmi_of_match,
+	 },
+};
+module_platform_driver(mvebu_cp110_utmi_driver);
+
+MODULE_AUTHOR("Konstatin Porotchkin <kostap@marvell.com>");
+MODULE_DESCRIPTION("Marvell Armada CP110 UTMI PHY driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

