Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B263B17E7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 12:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhFWKOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 06:14:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230234AbhFWKNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 06:13:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79F766112D;
        Wed, 23 Jun 2021 10:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624443093;
        bh=auiFcU9ExT26MGvZvhvCPjkM1N8BFB1NIzZfoqhOcyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aKE82scmQW5iRDm/hM9eJshJqNfV7RULHl1Yrbl2IJpii9OKYIm9/mqtObUSGxo6w
         wFb3MDG1l0Apf1Bj5nfez8pucK33shcNyVpfpqL0951KbtNaHbXNuwHm6vwhGgu5vB
         qgl7Lx1EdlpuvUB2l21PZbYYr/b2RXTLJfEBLh3cso3E31HrHObiahce/+48zpBLTY
         rRRHUU/0ZxLbAngnZmEtcgiguvll6Qhjurk+0f3QoPMPxSMo0CMeB4QUhj2b6rSmyK
         MP3pzlhUlCX0gsuO7rFPzCxKB8zbxquLRDeBpvozX9R/sxGmbGJggeuLAY5sEvPfJW
         toCpFL7WrF+tA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lvzr1-002pFb-6E; Wed, 23 Jun 2021 12:11:31 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v6 3/8] staging: phy-hi3670-usb3: do some additional cleanups
Date:   Wed, 23 Jun 2021 12:11:25 +0200
Message-Id: <3ec94bcd15ea822f6a8602f8bfd195c88aaf0c2c.1624442566.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1624442566.git.mchehab+huawei@kernel.org>
References: <cover.1624442566.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before moving this driver out of staging, do a couple of
cleanups, in order to make the driver clearer.

No functional changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c   | 89 +++++++++++--------
 .../hikey9xx/hisilicon,hi6421-spmi-pmic.yaml  |  7 +-
 2 files changed, 57 insertions(+), 39 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
index 626140cb96f2..2b7172560df7 100644
--- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
+++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
@@ -33,17 +33,27 @@ enum hi6421_spmi_pmic_irq_list {
 	SIM0_HPD_F,
 	SIM1_HPD_R,
 	SIM1_HPD_F,
-	PMIC_IRQ_LIST_MAX,
+
+	PMIC_IRQ_LIST_MAX
 };
 
-#define HISI_IRQ_ARRAY			2
-#define HISI_IRQ_NUM			(HISI_IRQ_ARRAY * 8)
+#define HISI_IRQ_BANK_SIZE		2
 
-#define HISI_IRQ_KEY_NUM		0
+/*
+ * IRQ number for the power key button and mask for both UP and DOWN IRQs
+ */
+#define HISI_POWERKEY_IRQ_NUM		0
+#define HISI_IRQ_POWERKEY_UP_DOWN	(BIT(POWERKEY_DOWN) | BIT(POWERKEY_UP))
 
-#define HISI_BITS			8
-#define HISI_IRQ_KEY_VALUE		(BIT(POWERKEY_DOWN) | BIT(POWERKEY_UP))
-#define HISI_MASK			GENMASK(HISI_BITS - 1, 0)
+/*
+ * Registers for IRQ address and IRQ mask bits
+ *
+ * Please notice that we need to regmap a larger region, as other
+ * registers are used by the regulators.
+ * See drivers/regulator/hi6421-regulator.c.
+ */
+#define SOC_PMIC_IRQ_MASK_0_ADDR	0x0202
+#define SOC_PMIC_IRQ0_ADDR		0x0212
 
 /*
  * The IRQs are mapped as:
@@ -67,13 +77,14 @@ enum hi6421_spmi_pmic_irq_list {
  *	SIM1_HPD_R		0x0203		0x213		bit 4
  *	SIM1_HPD_F		0x0203		0x213		bit 5
  *	======================  =============   ============	=====
+ *
+ * Each mask register contains 8 bits. The ancillary macros below
+ * convert a number from 0 to 14 into a register address and a bit mask
  */
-#define SOC_PMIC_IRQ_MASK_0_ADDR	0x0202
-#define SOC_PMIC_IRQ0_ADDR		0x0212
-
-#define IRQ_MASK_REGISTER(irq_data)	(SOC_PMIC_IRQ_MASK_0_ADDR + \
-					 (irqd_to_hwirq(irq_data) >> 3))
-#define IRQ_MASK_BIT(irq_data)		BIT(irqd_to_hwirq(irq_data) & 0x07)
+#define HISI_IRQ_MASK_REG(irq_data)	(SOC_PMIC_IRQ_MASK_0_ADDR + \
+					 (irqd_to_hwirq(irq_data) / BITS_PER_BYTE))
+#define HISI_IRQ_MASK_BIT(irq_data)	BIT(irqd_to_hwirq(irq_data) & (BITS_PER_BYTE - 1))
+#define HISI_8BITS_MASK			GENMASK(BITS_PER_BYTE - 1, 0)
 
 static const struct mfd_cell hi6421v600_devs[] = {
 	{ .name = "hi6421v600-regulator", },
@@ -86,23 +97,30 @@ static irqreturn_t hi6421_spmi_irq_handler(int irq, void *priv)
 	unsigned int in;
 	int i, offset;
 
-	for (i = 0; i < HISI_IRQ_ARRAY; i++) {
+	for (i = 0; i < HISI_IRQ_BANK_SIZE; i++) {
 		regmap_read(ddata->regmap, SOC_PMIC_IRQ0_ADDR + i, &in);
-		pending = HISI_MASK & in;
+
+		/* Mark pending IRQs as handled */
+		pending = HISI_8BITS_MASK & in;
 		regmap_write(ddata->regmap, SOC_PMIC_IRQ0_ADDR + i, pending);
 
-		if (i == HISI_IRQ_KEY_NUM &&
-		    (pending & HISI_IRQ_KEY_VALUE) == HISI_IRQ_KEY_VALUE) {
+		if (i == HISI_POWERKEY_IRQ_NUM &&
+		    (pending & HISI_IRQ_POWERKEY_UP_DOWN) == HISI_IRQ_POWERKEY_UP_DOWN) {
+			/*
+			 * If both powerkey down and up IRQs are received,
+			 * handle them at the right order
+			 */
 			generic_handle_irq(ddata->irqs[POWERKEY_DOWN]);
 			generic_handle_irq(ddata->irqs[POWERKEY_UP]);
-			pending &= (~HISI_IRQ_KEY_VALUE);
+			pending &= ~HISI_IRQ_POWERKEY_UP_DOWN;
 		}
 
 		if (!pending)
 			continue;
 
-		for_each_set_bit(offset, &pending, HISI_BITS)
-			generic_handle_irq(ddata->irqs[offset + i * HISI_BITS]);
+		for_each_set_bit(offset, &pending, BITS_PER_BYTE) {
+			generic_handle_irq(ddata->irqs[offset + i * BITS_PER_BYTE]);
+		}
 	}
 
 	return IRQ_HANDLED;
@@ -115,12 +133,12 @@ static void hi6421_spmi_irq_mask(struct irq_data *d)
 	unsigned int data;
 	u32 offset;
 
-	offset = IRQ_MASK_REGISTER(d);
+	offset = HISI_IRQ_MASK_REG(d);
 
 	spin_lock_irqsave(&ddata->lock, flags);
 
 	regmap_read(ddata->regmap, offset, &data);
-	data |= IRQ_MASK_BIT(d);
+	data |= HISI_IRQ_MASK_BIT(d);
 	regmap_write(ddata->regmap, offset, data);
 
 	spin_unlock_irqrestore(&ddata->lock, flags);
@@ -132,20 +150,19 @@ static void hi6421_spmi_irq_unmask(struct irq_data *d)
 	u32 data, offset;
 	unsigned long flags;
 
-	offset = (irqd_to_hwirq(d) >> 3);
-	offset += SOC_PMIC_IRQ_MASK_0_ADDR;
+	offset = HISI_IRQ_MASK_REG(d);
 
 	spin_lock_irqsave(&ddata->lock, flags);
 
 	regmap_read(ddata->regmap, offset, &data);
-	data &= ~(1 << (irqd_to_hwirq(d) & 0x07));
+	data &= ~HISI_IRQ_MASK_BIT(d);
 	regmap_write(ddata->regmap, offset, data);
 
 	spin_unlock_irqrestore(&ddata->lock, flags);
 }
 
 static struct irq_chip hi6421_spmi_pmu_irqchip = {
-	.name		= "hisi-irq",
+	.name		= "hi6421v600-irq",
 	.irq_mask	= hi6421_spmi_irq_mask,
 	.irq_unmask	= hi6421_spmi_irq_unmask,
 	.irq_disable	= hi6421_spmi_irq_mask,
@@ -158,7 +175,7 @@ static int hi6421_spmi_irq_map(struct irq_domain *d, unsigned int virq,
 	struct hi6421_spmi_pmic *ddata = d->host_data;
 
 	irq_set_chip_and_handler_name(virq, &hi6421_spmi_pmu_irqchip,
-				      handle_simple_irq, "hisi");
+				      handle_simple_irq, "hi6421v600");
 	irq_set_chip_data(virq, ddata);
 	irq_set_irq_type(virq, IRQ_TYPE_NONE);
 
@@ -175,20 +192,22 @@ static void hi6421_spmi_pmic_irq_init(struct hi6421_spmi_pmic *ddata)
 	int i;
 	unsigned int pending;
 
-	for (i = 0; i < HISI_IRQ_ARRAY; i++)
+	/* Mask all IRQs */
+	for (i = 0; i < HISI_IRQ_BANK_SIZE; i++)
 		regmap_write(ddata->regmap, SOC_PMIC_IRQ_MASK_0_ADDR + i,
-			     HISI_MASK);
+			     HISI_8BITS_MASK);
 
-	for (i = 0; i < HISI_IRQ_ARRAY; i++) {
+	/* Mark all IRQs as handled */
+	for (i = 0; i < HISI_IRQ_BANK_SIZE; i++) {
 		regmap_read(ddata->regmap, SOC_PMIC_IRQ0_ADDR + i, &pending);
 		regmap_write(ddata->regmap, SOC_PMIC_IRQ0_ADDR + i,
-			     HISI_MASK);
+			     HISI_8BITS_MASK);
 	}
 }
 
 static const struct regmap_config regmap_config = {
 	.reg_bits		= 16,
-	.val_bits		= HISI_BITS,
+	.val_bits		= BITS_PER_BYTE,
 	.max_register		= 0xffff,
 	.fast_io		= true
 };
@@ -230,18 +249,18 @@ static int hi6421_spmi_pmic_probe(struct spmi_device *pdev)
 
 	hi6421_spmi_pmic_irq_init(ddata);
 
-	ddata->irqs = devm_kzalloc(dev, HISI_IRQ_NUM * sizeof(int), GFP_KERNEL);
+	ddata->irqs = devm_kzalloc(dev, PMIC_IRQ_LIST_MAX * sizeof(int), GFP_KERNEL);
 	if (!ddata->irqs)
 		return -ENOMEM;
 
-	ddata->domain = irq_domain_add_simple(np, HISI_IRQ_NUM, 0,
+	ddata->domain = irq_domain_add_simple(np, PMIC_IRQ_LIST_MAX, 0,
 					      &hi6421_spmi_domain_ops, ddata);
 	if (!ddata->domain) {
 		dev_err(dev, "Failed to create IRQ domain\n");
 		return -ENODEV;
 	}
 
-	for (i = 0; i < HISI_IRQ_NUM; i++) {
+	for (i = 0; i < PMIC_IRQ_LIST_MAX; i++) {
 		virq = irq_create_mapping(ddata->domain, i);
 		if (!virq) {
 			dev_err(dev, "Failed to map H/W IRQ\n");
diff --git a/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml b/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
index 3b23ad56b31a..8e355cddd437 100644
--- a/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
+++ b/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
@@ -17,7 +17,7 @@ description: |
   node.
 
   The SPMI controller part is provided by
-  drivers/staging/hikey9xx/hisilicon,hisi-spmi-controller.yaml.
+  Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
 
 properties:
   $nodename:
@@ -32,12 +32,11 @@ properties:
   '#interrupt-cells':
     const: 2
 
-  interrupt-controller:
-    description:
-      Identify that the PMIC is capable of behaving as an interrupt controller.
+  interrupt-controller: true
 
   gpios:
     maxItems: 1
+    description: GPIO used for IRQs
 
   regulators:
     type: object
-- 
2.31.1

