Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4743B35A9BD
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 02:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235356AbhDJAzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 20:55:23 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:4438 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235347AbhDJAzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 20:55:21 -0400
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 09 Apr 2021 17:55:07 -0700
X-QCInternal: smtphost
Received: from gurus-linux.qualcomm.com (HELO gurus-linux.localdomain) ([10.46.162.81])
  by ironmsg05-sd.qualcomm.com with ESMTP; 09 Apr 2021 17:55:03 -0700
Received: by gurus-linux.localdomain (Postfix, from userid 383780)
        id 04C301B5F; Fri,  9 Apr 2021 17:55:02 -0700 (PDT)
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org,
        Guru Das Srinagesh <gurus@codeaurora.org>
Subject: [PATCH v2 3/3] mfd: pm8008: Add driver for QCOM PM8008 PMIC
Date:   Fri,  9 Apr 2021 17:55:02 -0700
Message-Id: <7b92e4132fc3433b78f64c5031b9ad15d8dda625.1618015804.git.gurus@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1618015804.git.gurus@codeaurora.org>
References: <cover.1618015804.git.gurus@codeaurora.org>
In-Reply-To: <cover.1618015804.git.gurus@codeaurora.org>
References: <cover.1618015804.git.gurus@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm Technologies, Inc. PM8008 is a dedicated camera PMIC that
integrates all the necessary power management, housekeeping, and
interface support functions into a single IC. Its key features include
overtemperature protection, low-dropout linear regulators, GPIOs, and an
I2C interface.

Add an MFD driver to support it.

Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
---
 drivers/mfd/Kconfig       |  15 +++
 drivers/mfd/Makefile      |   1 +
 drivers/mfd/qcom-pm8008.c | 284 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 300 insertions(+)
 create mode 100644 drivers/mfd/qcom-pm8008.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index b74efa4..d75f937 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2087,6 +2087,21 @@ config MFD_ACER_A500_EC
 	  The controller itself is ENE KB930, it is running firmware
 	  customized for the specific needs of the Acer A500 hardware.
 
+config MFD_QCOM_PM8008
+	tristate "QCOM PM8008 Power Management IC"
+	depends on I2C && OF
+	select REGMAP_I2C
+	select REGMAP_IRQ
+	help
+	  Select this option to get support for the Qualcomm Technologies, Inc.
+	  PM8008 PMIC chip. PM8008 is a dedicated camera PMIC that integrates
+	  all the necessary power management, housekeeping, and interface
+	  support functions into a single IC. This driver provides common
+	  support for accessing the device by instantiating all the child nodes
+	  under it in the device tree. Additional drivers must be enabled in
+	  order to use the functionality of the device.
+
+
 menu "Multimedia Capabilities Port drivers"
 	depends on ARCH_SA1100
 
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 834f546..a5dda823 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -264,6 +264,7 @@ obj-$(CONFIG_MFD_ROHM_BD718XX)	+= rohm-bd718x7.o
 obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
 obj-$(CONFIG_MFD_KHADAS_MCU) 	+= khadas-mcu.o
 obj-$(CONFIG_MFD_ACER_A500_EC)	+= acer-ec-a500.o
+obj-$(CONFIG_MFD_QCOM_PM8008)	+= qcom-pm8008.o
 
 obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
 obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+= simple-mfd-i2c.o
diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
new file mode 100644
index 0000000..9315389
--- /dev/null
+++ b/drivers/mfd/qcom-pm8008.c
@@ -0,0 +1,284 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/bitops.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/of_device.h>
+#include <dt-bindings/mfd/qcom-pm8008.h>
+
+#define I2C_INTR_STATUS_BASE	0x0550
+#define INT_RT_STS_OFFSET	0x10
+#define INT_SET_TYPE_OFFSET	0x11
+#define INT_POL_HIGH_OFFSET	0x12
+#define INT_POL_LOW_OFFSET	0x13
+#define INT_LATCHED_CLR_OFFSET	0x14
+#define INT_EN_SET_OFFSET	0x15
+#define INT_EN_CLR_OFFSET	0x16
+#define INT_LATCHED_STS_OFFSET	0x18
+
+enum {
+	PM8008_MISC,
+	PM8008_TEMP_ALARM,
+	PM8008_GPIO1,
+	PM8008_GPIO2,
+	PM8008_NUM_PERIPHS,
+};
+
+#define PM8008_PERIPH_0_BASE	0x900
+#define PM8008_PERIPH_1_BASE	0x2400
+#define PM8008_PERIPH_2_BASE	0xC000
+#define PM8008_PERIPH_3_BASE	0xC100
+
+#define PM8008_TEMP_ALARM_ADDR	PM8008_PERIPH_1_BASE
+#define PM8008_GPIO1_ADDR	PM8008_PERIPH_2_BASE
+#define PM8008_GPIO2_ADDR	PM8008_PERIPH_3_BASE
+
+#define PM8008_STATUS_BASE	(PM8008_PERIPH_0_BASE | INT_LATCHED_STS_OFFSET)
+#define PM8008_MASK_BASE	(PM8008_PERIPH_0_BASE | INT_EN_SET_OFFSET)
+#define PM8008_UNMASK_BASE	(PM8008_PERIPH_0_BASE | INT_EN_CLR_OFFSET)
+#define PM8008_TYPE_BASE	(PM8008_PERIPH_0_BASE | INT_SET_TYPE_OFFSET)
+#define PM8008_ACK_BASE		(PM8008_PERIPH_0_BASE | INT_LATCHED_CLR_OFFSET)
+#define PM8008_POLARITY_HI_BASE	(PM8008_PERIPH_0_BASE | INT_POL_HIGH_OFFSET)
+#define PM8008_POLARITY_LO_BASE	(PM8008_PERIPH_0_BASE | INT_POL_LOW_OFFSET)
+
+#define ADDRESS_OFFSET(paddr, base)	(paddr - base)
+
+#define PM8008_PERIPH_OFFSET(paddr)	\
+	ADDRESS_OFFSET(paddr, PM8008_PERIPH_0_BASE)
+
+struct pm8008_data {
+	struct device *dev;
+	struct regmap *regmap;
+	int irq;
+	struct regmap_irq_chip_data *irq_data;
+};
+
+static unsigned int p0_offs[] = {PM8008_PERIPH_OFFSET(PM8008_PERIPH_0_BASE)};
+static unsigned int p1_offs[] = {PM8008_PERIPH_OFFSET(PM8008_PERIPH_1_BASE)};
+static unsigned int p2_offs[] = {PM8008_PERIPH_OFFSET(PM8008_PERIPH_2_BASE)};
+static unsigned int p3_offs[] = {PM8008_PERIPH_OFFSET(PM8008_PERIPH_3_BASE)};
+
+static struct regmap_irq_sub_irq_map pm8008_sub_reg_offsets[] = {
+	REGMAP_IRQ_MAIN_REG_OFFSET(p0_offs),
+	REGMAP_IRQ_MAIN_REG_OFFSET(p1_offs),
+	REGMAP_IRQ_MAIN_REG_OFFSET(p2_offs),
+	REGMAP_IRQ_MAIN_REG_OFFSET(p3_offs),
+};
+
+static unsigned int pm8008_virt_regs[] = {
+	PM8008_POLARITY_HI_BASE,
+	PM8008_POLARITY_LO_BASE,
+};
+
+enum {
+	POLARITY_HI_INDEX,
+	POLARITY_LO_INDEX,
+	PM8008_NUM_VIRT_REGS,
+};
+
+static struct regmap_irq pm8008_irqs[] = {
+	/* MISC IRQs*/
+	REGMAP_IRQ_REG(PM8008_IRQ_MISC_UVLO,	PM8008_MISC,	BIT(0)),
+	REGMAP_IRQ_REG(PM8008_IRQ_MISC_OVLO,	PM8008_MISC,	BIT(1)),
+	REGMAP_IRQ_REG(PM8008_IRQ_MISC_OTST2,	PM8008_MISC,	BIT(2)),
+	REGMAP_IRQ_REG(PM8008_IRQ_MISC_OTST3,	PM8008_MISC,	BIT(3)),
+	REGMAP_IRQ_REG(PM8008_IRQ_MISC_LDO_OCP,	PM8008_MISC,	BIT(4)),
+	/* TEMP_ALARM IRQs */
+	REGMAP_IRQ_REG(PM8008_IRQ_TEMP_ALARM,	PM8008_TEMP_ALARM, BIT(0)),
+	/* GPIO1 IRQs */
+	REGMAP_IRQ_REG(PM8008_IRQ_GPIO1,	PM8008_GPIO1,	BIT(0)),
+	/* GPIO2 IRQs */
+	REGMAP_IRQ_REG(PM8008_IRQ_GPIO2,	PM8008_GPIO2,	BIT(0)),
+};
+
+static int pm8008_set_type_virt(unsigned int **virt_buf,
+				      unsigned int type, unsigned long hwirq,
+				      int reg)
+{
+	switch (type) {
+	case IRQ_TYPE_EDGE_FALLING:
+	case IRQ_TYPE_LEVEL_LOW:
+		virt_buf[POLARITY_HI_INDEX][reg] &= ~pm8008_irqs[hwirq].mask;
+		virt_buf[POLARITY_LO_INDEX][reg] |= pm8008_irqs[hwirq].mask;
+		break;
+
+	case IRQ_TYPE_EDGE_RISING:
+	case IRQ_TYPE_LEVEL_HIGH:
+		virt_buf[POLARITY_HI_INDEX][reg] |= pm8008_irqs[hwirq].mask;
+		virt_buf[POLARITY_LO_INDEX][reg] &= ~pm8008_irqs[hwirq].mask;
+		break;
+
+	case IRQ_TYPE_EDGE_BOTH:
+		virt_buf[POLARITY_HI_INDEX][reg] |= pm8008_irqs[hwirq].mask;
+		virt_buf[POLARITY_LO_INDEX][reg] |= pm8008_irqs[hwirq].mask;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static struct regmap_irq_chip pm8008_irq_chip = {
+	.name			= "pm8008_irq",
+	.main_status		= I2C_INTR_STATUS_BASE,
+	.num_main_regs		= 1,
+	.num_virt_regs		= PM8008_NUM_VIRT_REGS,
+	.irqs			= pm8008_irqs,
+	.num_irqs		= ARRAY_SIZE(pm8008_irqs),
+	.num_regs		= PM8008_NUM_PERIPHS,
+	.not_fixed_stride	= true,
+	.sub_reg_offsets	= pm8008_sub_reg_offsets,
+	.set_type_virt		= pm8008_set_type_virt,
+	.status_base		= PM8008_STATUS_BASE,
+	.mask_base		= PM8008_MASK_BASE,
+	.unmask_base		= PM8008_UNMASK_BASE,
+	.type_base		= PM8008_TYPE_BASE,
+	.ack_base		= PM8008_ACK_BASE,
+	.virt_reg_base		= pm8008_virt_regs,
+	.num_type_reg		= PM8008_NUM_PERIPHS,
+};
+
+static struct regmap_config qcom_mfd_regmap_cfg = {
+	.reg_bits	= 16,
+	.val_bits	= 8,
+	.max_register	= 0xFFFF,
+};
+
+static int pm8008_init(struct pm8008_data *chip)
+{
+	int rc;
+
+	/*
+	 * Set TEMP_ALARM peripheral's TYPE so that the regmap-irq framework
+	 * reads this as the default value instead of zero, the HW default.
+	 * This is required to enable the writing of TYPE registers in
+	 * regmap_irq_sync_unlock().
+	 */
+	rc = regmap_write(chip->regmap,
+			 (PM8008_TEMP_ALARM_ADDR | INT_SET_TYPE_OFFSET),
+			 BIT(0));
+	if (rc)
+		return rc;
+
+	/* Do the same for GPIO1 and GPIO2 peripherals */
+	rc = regmap_write(chip->regmap,
+			 (PM8008_GPIO1_ADDR | INT_SET_TYPE_OFFSET), BIT(0));
+	if (rc)
+		return rc;
+
+	rc = regmap_write(chip->regmap,
+			 (PM8008_GPIO2_ADDR | INT_SET_TYPE_OFFSET), BIT(0));
+
+	return rc;
+}
+
+static int pm8008_probe_irq_peripherals(struct pm8008_data *chip,
+					int client_irq)
+{
+	int rc, i;
+	struct regmap_irq_type *type;
+	struct regmap_irq_chip_data *irq_data;
+
+	rc = pm8008_init(chip);
+	if (rc) {
+		dev_err(chip->dev, "Init failed: %d\n", rc);
+		return rc;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(pm8008_irqs); i++) {
+		type = &pm8008_irqs[i].type;
+
+		type->type_reg_offset	  = pm8008_irqs[i].reg_offset;
+		type->type_rising_val	  = pm8008_irqs[i].mask;
+		type->type_falling_val	  = pm8008_irqs[i].mask;
+		type->type_level_high_val = 0;
+		type->type_level_low_val  = 0;
+
+		if (type->type_reg_offset == PM8008_MISC)
+			type->types_supported = IRQ_TYPE_EDGE_RISING;
+		else
+			type->types_supported = (IRQ_TYPE_EDGE_BOTH |
+				IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW);
+	}
+
+	rc = devm_regmap_add_irq_chip(chip->dev, chip->regmap, client_irq,
+			IRQF_SHARED, 0, &pm8008_irq_chip, &irq_data);
+	if (rc) {
+		dev_err(chip->dev, "Failed to add IRQ chip: %d\n", rc);
+		return rc;
+	}
+
+	return 0;
+}
+
+static int pm8008_probe(struct i2c_client *client,
+			     const struct i2c_device_id *id)
+{
+	int rc;
+	struct pm8008_data *chip;
+
+	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->dev = &client->dev;
+	chip->regmap = devm_regmap_init_i2c(client, &qcom_mfd_regmap_cfg);
+	if (!chip->regmap)
+		return -ENODEV;
+
+	i2c_set_clientdata(client, chip);
+
+	if (of_find_property(chip->dev->of_node, "interrupt-controller",
+			     NULL)) {
+		rc = pm8008_probe_irq_peripherals(chip, client->irq);
+		if (rc)
+			dev_err(chip->dev, "Failed to probe irq periphs: %d\n",
+				rc);
+	}
+
+	return devm_of_platform_populate(chip->dev);
+}
+
+static int pm8008_remove(struct i2c_client *client)
+{
+	i2c_set_clientdata(client, NULL);
+
+	return 0;
+}
+
+static const struct of_device_id pm8008_match[] = {
+	{ .compatible = "qcom,pm8008", },
+	{ },
+};
+
+static const struct i2c_device_id pm8008_id[] = {
+	{ "pm8008", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, pm8008_id);
+
+static struct i2c_driver pm8008_mfd_driver = {
+	.driver = {
+		.name = "mfd-pm8008",
+		.of_match_table = pm8008_match,
+	},
+	.probe		= pm8008_probe,
+	.remove		= pm8008_remove,
+	.id_table	= pm8008_id,
+};
+module_i2c_driver(pm8008_mfd_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("i2c:qcom-pm8008");
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

