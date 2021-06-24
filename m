Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9603B2AFE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 11:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbhFXJFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 05:05:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230342AbhFXJFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 05:05:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A979613EA;
        Thu, 24 Jun 2021 09:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624525373;
        bh=019P/KC++1O9I5A618srAyOsY75+lmPzT3Xeomq71Hc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZCsm7+i5feJPbSyc6lHgvhBq1UIK699bWAGVpigIG5sP7ax476ESFpl28U48PA/A4
         oUrfVMhsF1sQO7Vh2Dp4Z+SKtDaVILRVlBJJdclge/Iy7jkh69Pyp1zJ4BY1G7NRez
         oY2pePzP2dJyzpBQqMTLdtERbvVE1Zr/izYsr/ILtaM4zThiCcsJzgJD3+IC0h4WKE
         Xq4PmOBy+pNPkv4S+1zc8FXQvumBGRejm0io+8OQk5sSmqC5+tR4LQYJekOQ+EtL2A
         w2ThQqpCUeGSuBZsXxz47V/4pFZEnX64ocVdAWP4aHId72enkXOwFM3L91nOk/OVWd
         MF1GwRoEkHkxw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lwLG6-003jsB-UL; Thu, 24 Jun 2021 11:02:50 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH RESEND v6 6/8] mfd: hi6421-spmi-pmic: move driver from staging
Date:   Thu, 24 Jun 2021 11:01:10 +0200
Message-Id: <1ad2cbbd182d18ba2cae716fb5f1497b1cabbdbe.1624525118.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1624525118.git.mchehab+huawei@kernel.org>
References: <cover.1624525118.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is ready for mainstream. So, move it out of staging.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../mfd/hisilicon,hi6421-spmi-pmic.yaml       | 134 ++++++++
 MAINTAINERS                                   |   7 +
 drivers/mfd/Kconfig                           |  16 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/hi6421-spmi-pmic.c                | 316 ++++++++++++++++++
 drivers/staging/Kconfig                       |   2 -
 drivers/staging/Makefile                      |   1 -
 drivers/staging/hikey9xx/Kconfig              |  19 --
 drivers/staging/hikey9xx/Makefile             |   3 -
 drivers/staging/hikey9xx/TODO                 |   5 -
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c   | 316 ------------------
 .../hikey9xx/hisilicon,hi6421-spmi-pmic.yaml  | 134 --------
 12 files changed, 474 insertions(+), 480 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
 create mode 100644 drivers/mfd/hi6421-spmi-pmic.c
 delete mode 100644 drivers/staging/hikey9xx/Kconfig
 delete mode 100644 drivers/staging/hikey9xx/Makefile
 delete mode 100644 drivers/staging/hikey9xx/TODO
 delete mode 100644 drivers/staging/hikey9xx/hi6421-spmi-pmic.c
 delete mode 100644 drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml

diff --git a/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
new file mode 100644
index 000000000000..8e355cddd437
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
@@ -0,0 +1,134 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/hisilicon,hi6421-spmi-pmic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HiSilicon 6421v600 SPMI PMIC
+
+maintainers:
+  - Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+
+description: |
+  HiSilicon 6421v600 should be connected inside a MIPI System Power Management
+  (SPMI) bus. It provides interrupts and power supply.
+
+  The GPIO and interrupt settings are represented as part of the top-level PMIC
+  node.
+
+  The SPMI controller part is provided by
+  Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
+
+properties:
+  $nodename:
+    pattern: "pmic@[0-9a-f]"
+
+  compatible:
+    const: hisilicon,hi6421v600-spmi
+
+  reg:
+    maxItems: 1
+
+  '#interrupt-cells':
+    const: 2
+
+  interrupt-controller: true
+
+  gpios:
+    maxItems: 1
+    description: GPIO used for IRQs
+
+  regulators:
+    type: object
+
+    properties:
+      '#address-cells':
+        const: 1
+
+      '#size-cells':
+        const: 0
+
+    patternProperties:
+      '^ldo[0-9]+@[0-9a-f]$':
+        type: object
+
+        $ref: "/schemas/regulator/regulator.yaml#"
+
+required:
+  - compatible
+  - reg
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    /* pmic properties */
+
+    pmic: pmic@0 {
+      compatible = "hisilicon,hi6421-spmi";
+      reg = <0 0>;
+
+      #interrupt-cells = <2>;
+      interrupt-controller;
+      gpios = <&gpio28 0 0>;
+
+      regulators {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ldo3: LDO3 {
+          regulator-name = "ldo3";
+          regulator-min-microvolt = <1500000>;
+          regulator-max-microvolt = <2000000>;
+          regulator-boot-on;
+        };
+
+        ldo4: LDO4 {
+          regulator-name = "ldo4";
+          regulator-min-microvolt = <1725000>;
+          regulator-max-microvolt = <1900000>;
+          regulator-boot-on;
+        };
+
+        ldo9: LDO9 {
+          regulator-name = "ldo9";
+          regulator-min-microvolt = <1750000>;
+          regulator-max-microvolt = <3300000>;
+          regulator-boot-on;
+        };
+
+        ldo15: LDO15 {
+          regulator-name = "ldo15";
+          regulator-min-microvolt = <1800000>;
+          regulator-max-microvolt = <3000000>;
+          regulator-always-on;
+        };
+
+        ldo16: LDO16 {
+          regulator-name = "ldo16";
+          regulator-min-microvolt = <1800000>;
+          regulator-max-microvolt = <3000000>;
+          regulator-boot-on;
+        };
+
+        ldo17: LDO17 {
+          regulator-name = "ldo17";
+          regulator-min-microvolt = <2500000>;
+          regulator-max-microvolt = <3300000>;
+        };
+
+        ldo33: LDO33 {
+          regulator-name = "ldo33";
+          regulator-min-microvolt = <2500000>;
+          regulator-max-microvolt = <3300000>;
+          regulator-boot-on;
+        };
+
+        ldo34: LDO34 {
+          regulator-name = "ldo34";
+          regulator-min-microvolt = <2600000>;
+          regulator-max-microvolt = <3300000>;
+        };
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 9a69e3810964..89e84b050de6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8291,6 +8291,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml
 F:	drivers/spmi/hisi-spmi-controller.c
 
+HISILICON SPMI PMIC DRIVER FOR HIKEY 6421v600
+M:	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
+F:	drivers/mfd/hi6421-spmi-pmic.c
+
 HISILICON STAGING DRIVERS FOR HIKEY 960/970
 M:	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
 S:	Maintained
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 5c7f2b100191..99b8da2548b5 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -509,6 +509,22 @@ config MFD_HI6421_PMIC
 	  menus in order to enable them.
 	  We communicate with the Hi6421 via memory-mapped I/O.
 
+config MFD_HI6421_SPMI
+	tristate "HiSilicon Hi6421v600 SPMI PMU/Codec IC"
+	depends on OF
+	depends on SPMI
+	select MFD_CORE
+	select REGMAP_SPMI
+	help
+	  Add support for HiSilicon Hi6421v600 SPMI PMIC. Hi6421 includes
+	  multi-functions, such as regulators, RTC, codec, Coulomb counter,
+	  etc.
+
+	  This driver includes core APIs _only_. You have to select
+	  individual components like voltage regulators under corresponding
+	  menus in order to enable them.
+	  We communicate with the Hi6421v600 via a SPMI bus.
+
 config MFD_HI655X_PMIC
 	tristate "HiSilicon Hi655X series PMU/Codec IC"
 	depends on ARCH_HISI || COMPILE_TEST
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 4f6d2b8a5f76..e87230fc61ac 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -232,6 +232,7 @@ obj-$(CONFIG_MFD_IPAQ_MICRO)	+= ipaq-micro.o
 obj-$(CONFIG_MFD_IQS62X)	+= iqs62x.o
 obj-$(CONFIG_MFD_MENF21BMC)	+= menf21bmc.o
 obj-$(CONFIG_MFD_HI6421_PMIC)	+= hi6421-pmic-core.o
+obj-$(CONFIG_MFD_HI6421_SPMI)	+= hi6421-spmi-pmic.o
 obj-$(CONFIG_MFD_HI655X_PMIC)   += hi655x-pmic.o
 obj-$(CONFIG_MFD_DLN2)		+= dln2.o
 obj-$(CONFIG_MFD_RT5033)	+= rt5033.o
diff --git a/drivers/mfd/hi6421-spmi-pmic.c b/drivers/mfd/hi6421-spmi-pmic.c
new file mode 100644
index 000000000000..2b7172560df7
--- /dev/null
+++ b/drivers/mfd/hi6421-spmi-pmic.c
@@ -0,0 +1,316 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device driver for regulators in HISI PMIC IC
+ *
+ * Copyright (c) 2013 Linaro Ltd.
+ * Copyright (c) 2011 Hisilicon.
+ * Copyright (c) 2020-2021 Huawei Technologies Co., Ltd
+ */
+
+#include <linux/bitops.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/hi6421-spmi-pmic.h>
+#include <linux/module.h>
+#include <linux/of_gpio.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/spmi.h>
+
+enum hi6421_spmi_pmic_irq_list {
+	OTMP = 0,
+	VBUS_CONNECT,
+	VBUS_DISCONNECT,
+	ALARMON_R,
+	HOLD_6S,
+	HOLD_1S,
+	POWERKEY_UP,
+	POWERKEY_DOWN,
+	OCP_SCP_R,
+	COUL_R,
+	SIM0_HPD_R,
+	SIM0_HPD_F,
+	SIM1_HPD_R,
+	SIM1_HPD_F,
+
+	PMIC_IRQ_LIST_MAX
+};
+
+#define HISI_IRQ_BANK_SIZE		2
+
+/*
+ * IRQ number for the power key button and mask for both UP and DOWN IRQs
+ */
+#define HISI_POWERKEY_IRQ_NUM		0
+#define HISI_IRQ_POWERKEY_UP_DOWN	(BIT(POWERKEY_DOWN) | BIT(POWERKEY_UP))
+
+/*
+ * Registers for IRQ address and IRQ mask bits
+ *
+ * Please notice that we need to regmap a larger region, as other
+ * registers are used by the regulators.
+ * See drivers/regulator/hi6421-regulator.c.
+ */
+#define SOC_PMIC_IRQ_MASK_0_ADDR	0x0202
+#define SOC_PMIC_IRQ0_ADDR		0x0212
+
+/*
+ * The IRQs are mapped as:
+ *
+ *	======================  =============   ============	=====
+ *	IRQ			MASK REGISTER	IRQ REGISTER	BIT
+ *	======================  =============   ============	=====
+ *	OTMP			0x0202		0x212		bit 0
+ *	VBUS_CONNECT		0x0202		0x212		bit 1
+ *	VBUS_DISCONNECT		0x0202		0x212		bit 2
+ *	ALARMON_R		0x0202		0x212		bit 3
+ *	HOLD_6S			0x0202		0x212		bit 4
+ *	HOLD_1S			0x0202		0x212		bit 5
+ *	POWERKEY_UP		0x0202		0x212		bit 6
+ *	POWERKEY_DOWN		0x0202		0x212		bit 7
+ *
+ *	OCP_SCP_R		0x0203		0x213		bit 0
+ *	COUL_R			0x0203		0x213		bit 1
+ *	SIM0_HPD_R		0x0203		0x213		bit 2
+ *	SIM0_HPD_F		0x0203		0x213		bit 3
+ *	SIM1_HPD_R		0x0203		0x213		bit 4
+ *	SIM1_HPD_F		0x0203		0x213		bit 5
+ *	======================  =============   ============	=====
+ *
+ * Each mask register contains 8 bits. The ancillary macros below
+ * convert a number from 0 to 14 into a register address and a bit mask
+ */
+#define HISI_IRQ_MASK_REG(irq_data)	(SOC_PMIC_IRQ_MASK_0_ADDR + \
+					 (irqd_to_hwirq(irq_data) / BITS_PER_BYTE))
+#define HISI_IRQ_MASK_BIT(irq_data)	BIT(irqd_to_hwirq(irq_data) & (BITS_PER_BYTE - 1))
+#define HISI_8BITS_MASK			GENMASK(BITS_PER_BYTE - 1, 0)
+
+static const struct mfd_cell hi6421v600_devs[] = {
+	{ .name = "hi6421v600-regulator", },
+};
+
+static irqreturn_t hi6421_spmi_irq_handler(int irq, void *priv)
+{
+	struct hi6421_spmi_pmic *ddata = (struct hi6421_spmi_pmic *)priv;
+	unsigned long pending;
+	unsigned int in;
+	int i, offset;
+
+	for (i = 0; i < HISI_IRQ_BANK_SIZE; i++) {
+		regmap_read(ddata->regmap, SOC_PMIC_IRQ0_ADDR + i, &in);
+
+		/* Mark pending IRQs as handled */
+		pending = HISI_8BITS_MASK & in;
+		regmap_write(ddata->regmap, SOC_PMIC_IRQ0_ADDR + i, pending);
+
+		if (i == HISI_POWERKEY_IRQ_NUM &&
+		    (pending & HISI_IRQ_POWERKEY_UP_DOWN) == HISI_IRQ_POWERKEY_UP_DOWN) {
+			/*
+			 * If both powerkey down and up IRQs are received,
+			 * handle them at the right order
+			 */
+			generic_handle_irq(ddata->irqs[POWERKEY_DOWN]);
+			generic_handle_irq(ddata->irqs[POWERKEY_UP]);
+			pending &= ~HISI_IRQ_POWERKEY_UP_DOWN;
+		}
+
+		if (!pending)
+			continue;
+
+		for_each_set_bit(offset, &pending, BITS_PER_BYTE) {
+			generic_handle_irq(ddata->irqs[offset + i * BITS_PER_BYTE]);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void hi6421_spmi_irq_mask(struct irq_data *d)
+{
+	struct hi6421_spmi_pmic *ddata = irq_data_get_irq_chip_data(d);
+	unsigned long flags;
+	unsigned int data;
+	u32 offset;
+
+	offset = HISI_IRQ_MASK_REG(d);
+
+	spin_lock_irqsave(&ddata->lock, flags);
+
+	regmap_read(ddata->regmap, offset, &data);
+	data |= HISI_IRQ_MASK_BIT(d);
+	regmap_write(ddata->regmap, offset, data);
+
+	spin_unlock_irqrestore(&ddata->lock, flags);
+}
+
+static void hi6421_spmi_irq_unmask(struct irq_data *d)
+{
+	struct hi6421_spmi_pmic *ddata = irq_data_get_irq_chip_data(d);
+	u32 data, offset;
+	unsigned long flags;
+
+	offset = HISI_IRQ_MASK_REG(d);
+
+	spin_lock_irqsave(&ddata->lock, flags);
+
+	regmap_read(ddata->regmap, offset, &data);
+	data &= ~HISI_IRQ_MASK_BIT(d);
+	regmap_write(ddata->regmap, offset, data);
+
+	spin_unlock_irqrestore(&ddata->lock, flags);
+}
+
+static struct irq_chip hi6421_spmi_pmu_irqchip = {
+	.name		= "hi6421v600-irq",
+	.irq_mask	= hi6421_spmi_irq_mask,
+	.irq_unmask	= hi6421_spmi_irq_unmask,
+	.irq_disable	= hi6421_spmi_irq_mask,
+	.irq_enable	= hi6421_spmi_irq_unmask,
+};
+
+static int hi6421_spmi_irq_map(struct irq_domain *d, unsigned int virq,
+			       irq_hw_number_t hw)
+{
+	struct hi6421_spmi_pmic *ddata = d->host_data;
+
+	irq_set_chip_and_handler_name(virq, &hi6421_spmi_pmu_irqchip,
+				      handle_simple_irq, "hi6421v600");
+	irq_set_chip_data(virq, ddata);
+	irq_set_irq_type(virq, IRQ_TYPE_NONE);
+
+	return 0;
+}
+
+static const struct irq_domain_ops hi6421_spmi_domain_ops = {
+	.map	= hi6421_spmi_irq_map,
+	.xlate	= irq_domain_xlate_twocell,
+};
+
+static void hi6421_spmi_pmic_irq_init(struct hi6421_spmi_pmic *ddata)
+{
+	int i;
+	unsigned int pending;
+
+	/* Mask all IRQs */
+	for (i = 0; i < HISI_IRQ_BANK_SIZE; i++)
+		regmap_write(ddata->regmap, SOC_PMIC_IRQ_MASK_0_ADDR + i,
+			     HISI_8BITS_MASK);
+
+	/* Mark all IRQs as handled */
+	for (i = 0; i < HISI_IRQ_BANK_SIZE; i++) {
+		regmap_read(ddata->regmap, SOC_PMIC_IRQ0_ADDR + i, &pending);
+		regmap_write(ddata->regmap, SOC_PMIC_IRQ0_ADDR + i,
+			     HISI_8BITS_MASK);
+	}
+}
+
+static const struct regmap_config regmap_config = {
+	.reg_bits		= 16,
+	.val_bits		= BITS_PER_BYTE,
+	.max_register		= 0xffff,
+	.fast_io		= true
+};
+
+static int hi6421_spmi_pmic_probe(struct spmi_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct hi6421_spmi_pmic *ddata;
+	unsigned int virq;
+	int ret, i;
+
+	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
+
+	ddata->regmap = devm_regmap_init_spmi_ext(pdev, &regmap_config);
+	if (IS_ERR(ddata->regmap))
+		return PTR_ERR(ddata->regmap);
+
+	spin_lock_init(&ddata->lock);
+
+	ddata->dev = dev;
+
+	ddata->gpio = of_get_gpio(np, 0);
+	if (ddata->gpio < 0)
+		return ddata->gpio;
+
+	if (!gpio_is_valid(ddata->gpio))
+		return -EINVAL;
+
+	ret = devm_gpio_request_one(dev, ddata->gpio, GPIOF_IN, "pmic");
+	if (ret < 0) {
+		dev_err(dev, "Failed to request gpio%d\n", ddata->gpio);
+		return ret;
+	}
+
+	ddata->irq = gpio_to_irq(ddata->gpio);
+
+	hi6421_spmi_pmic_irq_init(ddata);
+
+	ddata->irqs = devm_kzalloc(dev, PMIC_IRQ_LIST_MAX * sizeof(int), GFP_KERNEL);
+	if (!ddata->irqs)
+		return -ENOMEM;
+
+	ddata->domain = irq_domain_add_simple(np, PMIC_IRQ_LIST_MAX, 0,
+					      &hi6421_spmi_domain_ops, ddata);
+	if (!ddata->domain) {
+		dev_err(dev, "Failed to create IRQ domain\n");
+		return -ENODEV;
+	}
+
+	for (i = 0; i < PMIC_IRQ_LIST_MAX; i++) {
+		virq = irq_create_mapping(ddata->domain, i);
+		if (!virq) {
+			dev_err(dev, "Failed to map H/W IRQ\n");
+			return -ENOSPC;
+		}
+		ddata->irqs[i] = virq;
+	}
+
+	ret = request_threaded_irq(ddata->irq, hi6421_spmi_irq_handler, NULL,
+				   IRQF_TRIGGER_LOW | IRQF_SHARED | IRQF_NO_SUSPEND,
+				   "pmic", ddata);
+	if (ret < 0) {
+		dev_err(dev, "Failed to start IRQ handling thread: error %d\n",
+			ret);
+		return ret;
+	}
+
+	dev_set_drvdata(&pdev->dev, ddata);
+
+	ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
+				   hi6421v600_devs, ARRAY_SIZE(hi6421v600_devs),
+				   NULL, 0, NULL);
+	if (ret < 0)
+		dev_err(dev, "Failed to add child devices: %d\n", ret);
+
+	return ret;
+}
+
+static void hi6421_spmi_pmic_remove(struct spmi_device *pdev)
+{
+	struct hi6421_spmi_pmic *ddata = dev_get_drvdata(&pdev->dev);
+
+	free_irq(ddata->irq, ddata);
+}
+
+static const struct of_device_id pmic_spmi_id_table[] = {
+	{ .compatible = "hisilicon,hi6421-spmi" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pmic_spmi_id_table);
+
+static struct spmi_driver hi6421_spmi_pmic_driver = {
+	.driver = {
+		.name	= "hi6421-spmi-pmic",
+		.of_match_table = pmic_spmi_id_table,
+	},
+	.probe	= hi6421_spmi_pmic_probe,
+	.remove	= hi6421_spmi_pmic_remove,
+};
+module_spmi_driver(hi6421_spmi_pmic_driver);
+
+MODULE_DESCRIPTION("HiSilicon Hi6421v600 SPMI PMIC driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index b7ae5bdc4eb5..5b4267d3ed6b 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -104,6 +104,4 @@ source "drivers/staging/qlge/Kconfig"
 
 source "drivers/staging/wfx/Kconfig"
 
-source "drivers/staging/hikey9xx/Kconfig"
-
 endif # STAGING
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 075c979bfe7c..7179cdcaafe7 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -42,4 +42,3 @@ obj-$(CONFIG_FIELDBUS_DEV)     += fieldbus/
 obj-$(CONFIG_KPC2000)		+= kpc2000/
 obj-$(CONFIG_QLGE)		+= qlge/
 obj-$(CONFIG_WFX)		+= wfx/
-obj-y				+= hikey9xx/
diff --git a/drivers/staging/hikey9xx/Kconfig b/drivers/staging/hikey9xx/Kconfig
deleted file mode 100644
index 9f53df9068fe..000000000000
--- a/drivers/staging/hikey9xx/Kconfig
+++ /dev/null
@@ -1,19 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-
-# to be placed at drivers/mfd
-config MFD_HI6421_SPMI
-	tristate "HiSilicon Hi6421v600 SPMI PMU/Codec IC"
-	depends on HAS_IOMEM
-	depends on OF
-	depends on SPMI
-	select MFD_CORE
-	select REGMAP_SPMI
-	help
-	  Add support for HiSilicon Hi6421v600 SPMI PMIC. Hi6421 includes
-	  multi-functions, such as regulators, RTC, codec, Coulomb counter,
-	  etc.
-
-	  This driver includes core APIs _only_. You have to select
-	  individual components like voltage regulators under corresponding
-	  menus in order to enable them.
-	  We communicate with the Hi6421v600 via a SPMI bus.
diff --git a/drivers/staging/hikey9xx/Makefile b/drivers/staging/hikey9xx/Makefile
deleted file mode 100644
index e3108d7dd849..000000000000
--- a/drivers/staging/hikey9xx/Makefile
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-
-obj-$(CONFIG_MFD_HI6421_SPMI)		+= hi6421-spmi-pmic.o
diff --git a/drivers/staging/hikey9xx/TODO b/drivers/staging/hikey9xx/TODO
deleted file mode 100644
index 65e7996a3066..000000000000
--- a/drivers/staging/hikey9xx/TODO
+++ /dev/null
@@ -1,5 +0,0 @@
-ToDo list:
-
-- Port other drivers needed by Hikey 960/970;
-- Test drivers on Hikey 960;
-- Validate device tree bindings.
diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
deleted file mode 100644
index 2b7172560df7..000000000000
--- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
+++ /dev/null
@@ -1,316 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device driver for regulators in HISI PMIC IC
- *
- * Copyright (c) 2013 Linaro Ltd.
- * Copyright (c) 2011 Hisilicon.
- * Copyright (c) 2020-2021 Huawei Technologies Co., Ltd
- */
-
-#include <linux/bitops.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/mfd/core.h>
-#include <linux/mfd/hi6421-spmi-pmic.h>
-#include <linux/module.h>
-#include <linux/of_gpio.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-#include <linux/spmi.h>
-
-enum hi6421_spmi_pmic_irq_list {
-	OTMP = 0,
-	VBUS_CONNECT,
-	VBUS_DISCONNECT,
-	ALARMON_R,
-	HOLD_6S,
-	HOLD_1S,
-	POWERKEY_UP,
-	POWERKEY_DOWN,
-	OCP_SCP_R,
-	COUL_R,
-	SIM0_HPD_R,
-	SIM0_HPD_F,
-	SIM1_HPD_R,
-	SIM1_HPD_F,
-
-	PMIC_IRQ_LIST_MAX
-};
-
-#define HISI_IRQ_BANK_SIZE		2
-
-/*
- * IRQ number for the power key button and mask for both UP and DOWN IRQs
- */
-#define HISI_POWERKEY_IRQ_NUM		0
-#define HISI_IRQ_POWERKEY_UP_DOWN	(BIT(POWERKEY_DOWN) | BIT(POWERKEY_UP))
-
-/*
- * Registers for IRQ address and IRQ mask bits
- *
- * Please notice that we need to regmap a larger region, as other
- * registers are used by the regulators.
- * See drivers/regulator/hi6421-regulator.c.
- */
-#define SOC_PMIC_IRQ_MASK_0_ADDR	0x0202
-#define SOC_PMIC_IRQ0_ADDR		0x0212
-
-/*
- * The IRQs are mapped as:
- *
- *	======================  =============   ============	=====
- *	IRQ			MASK REGISTER	IRQ REGISTER	BIT
- *	======================  =============   ============	=====
- *	OTMP			0x0202		0x212		bit 0
- *	VBUS_CONNECT		0x0202		0x212		bit 1
- *	VBUS_DISCONNECT		0x0202		0x212		bit 2
- *	ALARMON_R		0x0202		0x212		bit 3
- *	HOLD_6S			0x0202		0x212		bit 4
- *	HOLD_1S			0x0202		0x212		bit 5
- *	POWERKEY_UP		0x0202		0x212		bit 6
- *	POWERKEY_DOWN		0x0202		0x212		bit 7
- *
- *	OCP_SCP_R		0x0203		0x213		bit 0
- *	COUL_R			0x0203		0x213		bit 1
- *	SIM0_HPD_R		0x0203		0x213		bit 2
- *	SIM0_HPD_F		0x0203		0x213		bit 3
- *	SIM1_HPD_R		0x0203		0x213		bit 4
- *	SIM1_HPD_F		0x0203		0x213		bit 5
- *	======================  =============   ============	=====
- *
- * Each mask register contains 8 bits. The ancillary macros below
- * convert a number from 0 to 14 into a register address and a bit mask
- */
-#define HISI_IRQ_MASK_REG(irq_data)	(SOC_PMIC_IRQ_MASK_0_ADDR + \
-					 (irqd_to_hwirq(irq_data) / BITS_PER_BYTE))
-#define HISI_IRQ_MASK_BIT(irq_data)	BIT(irqd_to_hwirq(irq_data) & (BITS_PER_BYTE - 1))
-#define HISI_8BITS_MASK			GENMASK(BITS_PER_BYTE - 1, 0)
-
-static const struct mfd_cell hi6421v600_devs[] = {
-	{ .name = "hi6421v600-regulator", },
-};
-
-static irqreturn_t hi6421_spmi_irq_handler(int irq, void *priv)
-{
-	struct hi6421_spmi_pmic *ddata = (struct hi6421_spmi_pmic *)priv;
-	unsigned long pending;
-	unsigned int in;
-	int i, offset;
-
-	for (i = 0; i < HISI_IRQ_BANK_SIZE; i++) {
-		regmap_read(ddata->regmap, SOC_PMIC_IRQ0_ADDR + i, &in);
-
-		/* Mark pending IRQs as handled */
-		pending = HISI_8BITS_MASK & in;
-		regmap_write(ddata->regmap, SOC_PMIC_IRQ0_ADDR + i, pending);
-
-		if (i == HISI_POWERKEY_IRQ_NUM &&
-		    (pending & HISI_IRQ_POWERKEY_UP_DOWN) == HISI_IRQ_POWERKEY_UP_DOWN) {
-			/*
-			 * If both powerkey down and up IRQs are received,
-			 * handle them at the right order
-			 */
-			generic_handle_irq(ddata->irqs[POWERKEY_DOWN]);
-			generic_handle_irq(ddata->irqs[POWERKEY_UP]);
-			pending &= ~HISI_IRQ_POWERKEY_UP_DOWN;
-		}
-
-		if (!pending)
-			continue;
-
-		for_each_set_bit(offset, &pending, BITS_PER_BYTE) {
-			generic_handle_irq(ddata->irqs[offset + i * BITS_PER_BYTE]);
-		}
-	}
-
-	return IRQ_HANDLED;
-}
-
-static void hi6421_spmi_irq_mask(struct irq_data *d)
-{
-	struct hi6421_spmi_pmic *ddata = irq_data_get_irq_chip_data(d);
-	unsigned long flags;
-	unsigned int data;
-	u32 offset;
-
-	offset = HISI_IRQ_MASK_REG(d);
-
-	spin_lock_irqsave(&ddata->lock, flags);
-
-	regmap_read(ddata->regmap, offset, &data);
-	data |= HISI_IRQ_MASK_BIT(d);
-	regmap_write(ddata->regmap, offset, data);
-
-	spin_unlock_irqrestore(&ddata->lock, flags);
-}
-
-static void hi6421_spmi_irq_unmask(struct irq_data *d)
-{
-	struct hi6421_spmi_pmic *ddata = irq_data_get_irq_chip_data(d);
-	u32 data, offset;
-	unsigned long flags;
-
-	offset = HISI_IRQ_MASK_REG(d);
-
-	spin_lock_irqsave(&ddata->lock, flags);
-
-	regmap_read(ddata->regmap, offset, &data);
-	data &= ~HISI_IRQ_MASK_BIT(d);
-	regmap_write(ddata->regmap, offset, data);
-
-	spin_unlock_irqrestore(&ddata->lock, flags);
-}
-
-static struct irq_chip hi6421_spmi_pmu_irqchip = {
-	.name		= "hi6421v600-irq",
-	.irq_mask	= hi6421_spmi_irq_mask,
-	.irq_unmask	= hi6421_spmi_irq_unmask,
-	.irq_disable	= hi6421_spmi_irq_mask,
-	.irq_enable	= hi6421_spmi_irq_unmask,
-};
-
-static int hi6421_spmi_irq_map(struct irq_domain *d, unsigned int virq,
-			       irq_hw_number_t hw)
-{
-	struct hi6421_spmi_pmic *ddata = d->host_data;
-
-	irq_set_chip_and_handler_name(virq, &hi6421_spmi_pmu_irqchip,
-				      handle_simple_irq, "hi6421v600");
-	irq_set_chip_data(virq, ddata);
-	irq_set_irq_type(virq, IRQ_TYPE_NONE);
-
-	return 0;
-}
-
-static const struct irq_domain_ops hi6421_spmi_domain_ops = {
-	.map	= hi6421_spmi_irq_map,
-	.xlate	= irq_domain_xlate_twocell,
-};
-
-static void hi6421_spmi_pmic_irq_init(struct hi6421_spmi_pmic *ddata)
-{
-	int i;
-	unsigned int pending;
-
-	/* Mask all IRQs */
-	for (i = 0; i < HISI_IRQ_BANK_SIZE; i++)
-		regmap_write(ddata->regmap, SOC_PMIC_IRQ_MASK_0_ADDR + i,
-			     HISI_8BITS_MASK);
-
-	/* Mark all IRQs as handled */
-	for (i = 0; i < HISI_IRQ_BANK_SIZE; i++) {
-		regmap_read(ddata->regmap, SOC_PMIC_IRQ0_ADDR + i, &pending);
-		regmap_write(ddata->regmap, SOC_PMIC_IRQ0_ADDR + i,
-			     HISI_8BITS_MASK);
-	}
-}
-
-static const struct regmap_config regmap_config = {
-	.reg_bits		= 16,
-	.val_bits		= BITS_PER_BYTE,
-	.max_register		= 0xffff,
-	.fast_io		= true
-};
-
-static int hi6421_spmi_pmic_probe(struct spmi_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
-	struct hi6421_spmi_pmic *ddata;
-	unsigned int virq;
-	int ret, i;
-
-	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
-	if (!ddata)
-		return -ENOMEM;
-
-	ddata->regmap = devm_regmap_init_spmi_ext(pdev, &regmap_config);
-	if (IS_ERR(ddata->regmap))
-		return PTR_ERR(ddata->regmap);
-
-	spin_lock_init(&ddata->lock);
-
-	ddata->dev = dev;
-
-	ddata->gpio = of_get_gpio(np, 0);
-	if (ddata->gpio < 0)
-		return ddata->gpio;
-
-	if (!gpio_is_valid(ddata->gpio))
-		return -EINVAL;
-
-	ret = devm_gpio_request_one(dev, ddata->gpio, GPIOF_IN, "pmic");
-	if (ret < 0) {
-		dev_err(dev, "Failed to request gpio%d\n", ddata->gpio);
-		return ret;
-	}
-
-	ddata->irq = gpio_to_irq(ddata->gpio);
-
-	hi6421_spmi_pmic_irq_init(ddata);
-
-	ddata->irqs = devm_kzalloc(dev, PMIC_IRQ_LIST_MAX * sizeof(int), GFP_KERNEL);
-	if (!ddata->irqs)
-		return -ENOMEM;
-
-	ddata->domain = irq_domain_add_simple(np, PMIC_IRQ_LIST_MAX, 0,
-					      &hi6421_spmi_domain_ops, ddata);
-	if (!ddata->domain) {
-		dev_err(dev, "Failed to create IRQ domain\n");
-		return -ENODEV;
-	}
-
-	for (i = 0; i < PMIC_IRQ_LIST_MAX; i++) {
-		virq = irq_create_mapping(ddata->domain, i);
-		if (!virq) {
-			dev_err(dev, "Failed to map H/W IRQ\n");
-			return -ENOSPC;
-		}
-		ddata->irqs[i] = virq;
-	}
-
-	ret = request_threaded_irq(ddata->irq, hi6421_spmi_irq_handler, NULL,
-				   IRQF_TRIGGER_LOW | IRQF_SHARED | IRQF_NO_SUSPEND,
-				   "pmic", ddata);
-	if (ret < 0) {
-		dev_err(dev, "Failed to start IRQ handling thread: error %d\n",
-			ret);
-		return ret;
-	}
-
-	dev_set_drvdata(&pdev->dev, ddata);
-
-	ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
-				   hi6421v600_devs, ARRAY_SIZE(hi6421v600_devs),
-				   NULL, 0, NULL);
-	if (ret < 0)
-		dev_err(dev, "Failed to add child devices: %d\n", ret);
-
-	return ret;
-}
-
-static void hi6421_spmi_pmic_remove(struct spmi_device *pdev)
-{
-	struct hi6421_spmi_pmic *ddata = dev_get_drvdata(&pdev->dev);
-
-	free_irq(ddata->irq, ddata);
-}
-
-static const struct of_device_id pmic_spmi_id_table[] = {
-	{ .compatible = "hisilicon,hi6421-spmi" },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, pmic_spmi_id_table);
-
-static struct spmi_driver hi6421_spmi_pmic_driver = {
-	.driver = {
-		.name	= "hi6421-spmi-pmic",
-		.of_match_table = pmic_spmi_id_table,
-	},
-	.probe	= hi6421_spmi_pmic_probe,
-	.remove	= hi6421_spmi_pmic_remove,
-};
-module_spmi_driver(hi6421_spmi_pmic_driver);
-
-MODULE_DESCRIPTION("HiSilicon Hi6421v600 SPMI PMIC driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml b/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
deleted file mode 100644
index 8e355cddd437..000000000000
--- a/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
+++ /dev/null
@@ -1,134 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/mfd/hisilicon,hi6421-spmi-pmic.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: HiSilicon 6421v600 SPMI PMIC
-
-maintainers:
-  - Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
-
-description: |
-  HiSilicon 6421v600 should be connected inside a MIPI System Power Management
-  (SPMI) bus. It provides interrupts and power supply.
-
-  The GPIO and interrupt settings are represented as part of the top-level PMIC
-  node.
-
-  The SPMI controller part is provided by
-  Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
-
-properties:
-  $nodename:
-    pattern: "pmic@[0-9a-f]"
-
-  compatible:
-    const: hisilicon,hi6421v600-spmi
-
-  reg:
-    maxItems: 1
-
-  '#interrupt-cells':
-    const: 2
-
-  interrupt-controller: true
-
-  gpios:
-    maxItems: 1
-    description: GPIO used for IRQs
-
-  regulators:
-    type: object
-
-    properties:
-      '#address-cells':
-        const: 1
-
-      '#size-cells':
-        const: 0
-
-    patternProperties:
-      '^ldo[0-9]+@[0-9a-f]$':
-        type: object
-
-        $ref: "/schemas/regulator/regulator.yaml#"
-
-required:
-  - compatible
-  - reg
-  - regulators
-
-additionalProperties: false
-
-examples:
-  - |
-    /* pmic properties */
-
-    pmic: pmic@0 {
-      compatible = "hisilicon,hi6421-spmi";
-      reg = <0 0>;
-
-      #interrupt-cells = <2>;
-      interrupt-controller;
-      gpios = <&gpio28 0 0>;
-
-      regulators {
-        #address-cells = <1>;
-        #size-cells = <0>;
-
-        ldo3: LDO3 {
-          regulator-name = "ldo3";
-          regulator-min-microvolt = <1500000>;
-          regulator-max-microvolt = <2000000>;
-          regulator-boot-on;
-        };
-
-        ldo4: LDO4 {
-          regulator-name = "ldo4";
-          regulator-min-microvolt = <1725000>;
-          regulator-max-microvolt = <1900000>;
-          regulator-boot-on;
-        };
-
-        ldo9: LDO9 {
-          regulator-name = "ldo9";
-          regulator-min-microvolt = <1750000>;
-          regulator-max-microvolt = <3300000>;
-          regulator-boot-on;
-        };
-
-        ldo15: LDO15 {
-          regulator-name = "ldo15";
-          regulator-min-microvolt = <1800000>;
-          regulator-max-microvolt = <3000000>;
-          regulator-always-on;
-        };
-
-        ldo16: LDO16 {
-          regulator-name = "ldo16";
-          regulator-min-microvolt = <1800000>;
-          regulator-max-microvolt = <3000000>;
-          regulator-boot-on;
-        };
-
-        ldo17: LDO17 {
-          regulator-name = "ldo17";
-          regulator-min-microvolt = <2500000>;
-          regulator-max-microvolt = <3300000>;
-        };
-
-        ldo33: LDO33 {
-          regulator-name = "ldo33";
-          regulator-min-microvolt = <2500000>;
-          regulator-max-microvolt = <3300000>;
-          regulator-boot-on;
-        };
-
-        ldo34: LDO34 {
-          regulator-name = "ldo34";
-          regulator-min-microvolt = <2600000>;
-          regulator-max-microvolt = <3300000>;
-        };
-      };
-    };
-- 
2.31.1

