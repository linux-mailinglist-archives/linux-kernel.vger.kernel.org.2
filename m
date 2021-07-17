Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43CF3CC25A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 11:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbhGQKCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 06:02:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233033AbhGQKBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 06:01:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9A9F6115A;
        Sat, 17 Jul 2021 09:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626515904;
        bh=GUsFlZhuzVANkOErAPBqVhLDvFKE8+q8zyE/JK/xt1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NydSpW0cP3euzA9AFZs4yi2pfXYgHxd0fxvbOk5PU7Ue/GXq71SVpTOFIgcE+teDA
         39HxhwH4wClT+NS/uwteqq6XXPu644Dkw20UOpfDqepMi4XlnkHAAouit0HN37Lf8Z
         N65MKE8iDYXx4UDDmS4KvHTXr+G9MULKS8rL07Do/qE2FKFyPP36pi160qdzGUesb7
         dZWHYZyF0UpE2AuKR1/rEPk96A3chi/sNJ/qoNkVolxhIeSq/SQcTWgz7qCn7m6VHE
         o1RXdqQDQzvC2TAmBtlGFFo2cklpvyXJCB55tAqzoEv0qDg418ycvMaayAtx9kRNKQ
         2qfT3yLiiageg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m4h5R-0007KC-UI; Sat, 17 Jul 2021 11:58:21 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v14 4/9] staging: hikey9xx: split hi6421v600 irq into a separate driver
Date:   Sat, 17 Jul 2021 11:58:15 +0200
Message-Id: <709e01c9ffafe6cd0ecb23336b44f9bcde2b5bc2.1626515862.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626515862.git.mchehab+huawei@kernel.org>
References: <cover.1626515862.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per MFD subsystem requirements, split the IRQ part of the
driver into a separate one with just the IRQ handling code
and the powerkey support.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/misc/Kconfig                          |  10 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/hi6421v600-irq.c                 | 307 ++++++++++++++++++
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c   | 239 +-------------
 .../hikey9xx/hisilicon,hi6421-spmi-pmic.yaml  |   2 +-
 include/linux/mfd/hi6421-spmi-pmic.h          |   4 -
 6 files changed, 322 insertions(+), 241 deletions(-)
 create mode 100644 drivers/misc/hi6421v600-irq.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index f4fb5c52b863..29294c52d5af 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -208,6 +208,16 @@ config CS5535_CLOCK_EVENT_SRC
 	  MFGPTs have a better resolution and max interval than the
 	  generic PIT, and are suitable for use as high-res timers.
 
+config HI6421V600_IRQ
+	tristate "HiSilicon Hi6421v600 IRQ and powerkey"
+	depends on OF
+	depends on SPMI
+	select MFD_CORE
+	select REGMAP_SPMI
+	help
+	  This driver provides IRQ handling for Hi6421v600, used on
+	  some Kirin chipsets, like the one at Hikey 970.
+
 config HP_ILO
 	tristate "Channel interface driver for the HP iLO processor"
 	depends on PCI
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index e92a56d4442f..f91cab8c3d55 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -57,3 +57,4 @@ obj-$(CONFIG_HABANA_AI)		+= habanalabs/
 obj-$(CONFIG_UACCE)		+= uacce/
 obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
 obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
+obj-$(CONFIG_HI6421V600_IRQ)	+= hi6421v600-irq.o
diff --git a/drivers/misc/hi6421v600-irq.c b/drivers/misc/hi6421v600-irq.c
new file mode 100644
index 000000000000..08535e97ff43
--- /dev/null
+++ b/drivers/misc/hi6421v600-irq.c
@@ -0,0 +1,307 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device driver for irqs in HISI PMIC IC
+ *
+ * Copyright (c) 2013 Linaro Ltd.
+ * Copyright (c) 2011 Hisilicon.
+ * Copyright (c) 2020-2021 Huawei Technologies Co., Ltd.
+ */
+
+#include <linux/bitops.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/mfd/hi6421-spmi-pmic.h>
+#include <linux/module.h>
+#include <linux/of_gpio.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/irqdomain.h>
+#include <linux/regmap.h>
+
+struct hi6421v600_irq {
+	struct device		*dev;
+	struct irq_domain	*domain;
+	int			irq;
+	unsigned int		*irqs;
+	struct regmap		*regmap;
+
+	/* Protect IRQ mask changes */
+	spinlock_t		lock;
+};
+
+enum hi6421v600_irq_list {
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
+ * registers are used by the irqs.
+ * See drivers/irq/hi6421-irq.c.
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
+#define HISI_8BITS_MASK			0xff
+
+static irqreturn_t hi6421v600_irq_handler(int irq, void *__priv)
+{
+	struct hi6421v600_irq *priv = __priv;
+	unsigned long pending;
+	unsigned int in;
+	int i, offset;
+
+	for (i = 0; i < HISI_IRQ_BANK_SIZE; i++) {
+		regmap_read(priv->regmap, SOC_PMIC_IRQ0_ADDR + i, &in);
+
+		/* Mark pending IRQs as handled */
+		regmap_write(priv->regmap, SOC_PMIC_IRQ0_ADDR + i, in);
+
+		pending = in & HISI_8BITS_MASK;
+
+		if (i == HISI_POWERKEY_IRQ_NUM &&
+		    (pending & HISI_IRQ_POWERKEY_UP_DOWN) == HISI_IRQ_POWERKEY_UP_DOWN) {
+			/*
+			 * If both powerkey down and up IRQs are received,
+			 * handle them at the right order
+			 */
+			generic_handle_irq(priv->irqs[POWERKEY_DOWN]);
+			generic_handle_irq(priv->irqs[POWERKEY_UP]);
+			pending &= ~HISI_IRQ_POWERKEY_UP_DOWN;
+		}
+
+		if (!pending)
+			continue;
+
+		for_each_set_bit(offset, &pending, BITS_PER_BYTE) {
+			generic_handle_irq(priv->irqs[offset + i * BITS_PER_BYTE]);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void hi6421v600_irq_mask(struct irq_data *d)
+{
+	struct hi6421v600_irq *priv = irq_data_get_irq_chip_data(d);
+	unsigned long flags;
+	unsigned int data;
+	u32 offset;
+
+	offset = HISI_IRQ_MASK_REG(d);
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	regmap_read(priv->regmap, offset, &data);
+	data |= HISI_IRQ_MASK_BIT(d);
+	regmap_write(priv->regmap, offset, data);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+}
+
+static void hi6421v600_irq_unmask(struct irq_data *d)
+{
+	struct hi6421v600_irq *priv = irq_data_get_irq_chip_data(d);
+	u32 data, offset;
+	unsigned long flags;
+
+	offset = HISI_IRQ_MASK_REG(d);
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	regmap_read(priv->regmap, offset, &data);
+	data &= ~HISI_IRQ_MASK_BIT(d);
+	regmap_write(priv->regmap, offset, data);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+}
+
+static struct irq_chip hi6421v600_pmu_irqchip = {
+	.name		= "hi6421v600-irq",
+	.irq_mask	= hi6421v600_irq_mask,
+	.irq_unmask	= hi6421v600_irq_unmask,
+	.irq_disable	= hi6421v600_irq_mask,
+	.irq_enable	= hi6421v600_irq_unmask,
+};
+
+static int hi6421v600_irq_map(struct irq_domain *d, unsigned int virq,
+			      irq_hw_number_t hw)
+{
+	struct hi6421v600_irq *priv = d->host_data;
+
+	irq_set_chip_and_handler_name(virq, &hi6421v600_pmu_irqchip,
+				      handle_simple_irq, "hi6421v600");
+	irq_set_chip_data(virq, priv);
+	irq_set_irq_type(virq, IRQ_TYPE_NONE);
+
+	return 0;
+}
+
+static const struct irq_domain_ops hi6421v600_domain_ops = {
+	.map	= hi6421v600_irq_map,
+	.xlate	= irq_domain_xlate_twocell,
+};
+
+static void hi6421v600_irq_init(struct hi6421v600_irq *priv)
+{
+	int i;
+	unsigned int pending;
+
+	/* Mask all IRQs */
+	for (i = 0; i < HISI_IRQ_BANK_SIZE; i++)
+		regmap_write(priv->regmap, SOC_PMIC_IRQ_MASK_0_ADDR + i,
+			     HISI_8BITS_MASK);
+
+	/* Mark all IRQs as handled */
+	for (i = 0; i < HISI_IRQ_BANK_SIZE; i++) {
+		regmap_read(priv->regmap, SOC_PMIC_IRQ0_ADDR + i, &pending);
+		regmap_write(priv->regmap, SOC_PMIC_IRQ0_ADDR + i,
+			     HISI_8BITS_MASK);
+	}
+}
+
+static int hi6421v600_irq_probe(struct platform_device *pdev)
+{
+	struct device *pmic_dev = pdev->dev.parent;
+	struct device_node *np = pmic_dev->of_node;
+	struct platform_device *pmic_pdev;
+	struct device *dev = &pdev->dev;
+	struct hi6421v600_irq *priv;
+	struct hi6421_spmi_pmic *pmic;
+	unsigned int virq;
+	int i, ret;
+
+	/*
+	 * This driver is meant to be called by hi6421-spmi-core,
+	 * which should first set drvdata. If this doesn't happen, hit
+	 * a warn on and return.
+	 */
+	pmic = dev_get_drvdata(pmic_dev);
+	if (WARN_ON(!pmic))
+		return -ENODEV;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	priv->regmap = pmic->regmap;
+
+	spin_lock_init(&priv->lock);
+
+	pmic_pdev = container_of(pmic_dev, struct platform_device, dev);
+
+	priv->irq = platform_get_irq(pmic_pdev, 0);
+	if (priv->irq < 0) {
+		dev_err(dev, "Error %d when getting IRQs\n", priv->irq);
+		return priv->irq;
+	}
+
+	platform_set_drvdata(pdev, priv);
+
+	hi6421v600_irq_init(priv);
+
+	priv->irqs = devm_kzalloc(dev, PMIC_IRQ_LIST_MAX * sizeof(int), GFP_KERNEL);
+	if (!priv->irqs)
+		return -ENOMEM;
+
+	priv->domain = irq_domain_add_simple(np, PMIC_IRQ_LIST_MAX, 0,
+					     &hi6421v600_domain_ops, priv);
+	if (!priv->domain) {
+		dev_err(dev, "Failed to create IRQ domain\n");
+		return -ENODEV;
+	}
+
+	for (i = 0; i < PMIC_IRQ_LIST_MAX; i++) {
+		virq = irq_create_mapping(priv->domain, i);
+		if (!virq) {
+			dev_err(dev, "Failed to map H/W IRQ\n");
+			return -ENODEV;
+		}
+		priv->irqs[i] = virq;
+	}
+
+	ret = devm_request_threaded_irq(dev,
+					priv->irq, hi6421v600_irq_handler,
+					NULL,
+					IRQF_TRIGGER_LOW | IRQF_SHARED | IRQF_NO_SUSPEND,
+					"pmic", priv);
+	if (ret < 0) {
+		dev_err(dev, "Failed to start IRQ handling thread: error %d\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct platform_device_id hi6421v600_irq_table[] = {
+	{ .name = "hi6421v600-irq" },
+	{},
+};
+MODULE_DEVICE_TABLE(platform, hi6421v600_irq_table);
+
+static struct platform_driver hi6421v600_irq_driver = {
+	.id_table = hi6421v600_irq_table,
+	.driver = {
+		.name = "hi6421v600-irq",
+	},
+	.probe	= hi6421v600_irq_probe,
+};
+module_platform_driver(hi6421v600_irq_driver);
+
+MODULE_DESCRIPTION("HiSilicon Hi6421v600 IRQ driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
index 0ffd8b7fecf5..4f136826681b 100644
--- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
+++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
@@ -7,205 +7,19 @@
  * Copyright (c) 2020-2021 Huawei Technologies Co., Ltd.
  */
 
-#include <linux/bitops.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/hi6421-spmi-pmic.h>
 #include <linux/module.h>
-#include <linux/of_gpio.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/spmi.h>
 
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
-#define HISI_8BITS_MASK			0xff
-
 static const struct mfd_cell hi6421v600_devs[] = {
+	{ .name = "hi6421v600-irq", },
 	{ .name = "hi6421v600-regulator", },
 };
 
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
-		regmap_write(ddata->regmap, SOC_PMIC_IRQ0_ADDR + i, in);
-
-		pending = in & HISI_8BITS_MASK;
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
 static const struct regmap_config regmap_config = {
 	.reg_bits	= 16,
 	.val_bits	= BITS_PER_BYTE,
@@ -216,12 +30,8 @@ static const struct regmap_config regmap_config = {
 static int hi6421_spmi_pmic_probe(struct spmi_device *sdev)
 {
 	struct device *dev = &sdev->dev;
-	struct device_node *np = dev->of_node;
+	int ret;
 	struct hi6421_spmi_pmic *ddata;
-	struct platform_device *pdev;
-	unsigned int virq;
-	int ret, i;
-
 	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
 	if (!ddata)
 		return -ENOMEM;
@@ -230,51 +40,8 @@ static int hi6421_spmi_pmic_probe(struct spmi_device *sdev)
 	if (IS_ERR(ddata->regmap))
 		return PTR_ERR(ddata->regmap);
 
-	spin_lock_init(&ddata->lock);
-
 	ddata->dev = dev;
 
-	pdev = container_of(dev, struct platform_device, dev);
-
-	ddata->irq = platform_get_irq(pdev, 0);
-	if (ddata->irq < 0) {
-		dev_err(dev, "Error %d when getting IRQs\n", ddata->irq);
-		return ddata->irq;
-	}
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
-			return -ENODEV;
-		}
-		ddata->irqs[i] = virq;
-	}
-
-	ret = devm_request_threaded_irq(dev,
-					ddata->irq, hi6421_spmi_irq_handler,
-					NULL,
-				        IRQF_TRIGGER_LOW | IRQF_SHARED | IRQF_NO_SUSPEND,
-				        "pmic", ddata);
-	if (ret < 0) {
-		dev_err(dev, "Failed to start IRQ handling thread: error %d\n",
-			ret);
-		return ret;
-	}
-
 	dev_set_drvdata(&sdev->dev, ddata);
 
 	ret = devm_mfd_add_devices(&sdev->dev, PLATFORM_DEVID_NONE,
diff --git a/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml b/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
index 5a3b1cbfd639..63f49080001d 100644
--- a/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
+++ b/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
@@ -63,7 +63,7 @@ examples:
   - |
 
     pmic: pmic@0 {
-      compatible = "hisilicon,hi6421-spmi";
+      compatible = "hisilicon,hi6421v600-spmi";
       reg = <0 0>;
 
       #interrupt-cells = <2>;
diff --git a/include/linux/mfd/hi6421-spmi-pmic.h b/include/linux/mfd/hi6421-spmi-pmic.h
index 254430c897d6..e5b8dbf828b6 100644
--- a/include/linux/mfd/hi6421-spmi-pmic.h
+++ b/include/linux/mfd/hi6421-spmi-pmic.h
@@ -19,10 +19,6 @@ struct hi6421_spmi_pmic {
 	struct resource				*res;
 	struct device				*dev;
 	void __iomem				*regs;
-	spinlock_t				lock;
-	struct irq_domain			*domain;
-	int					irq;
-	unsigned int				*irqs;
 	struct regmap				*regmap;
 };
 
-- 
2.31.1

