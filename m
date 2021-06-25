Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822493B3DF3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 09:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhFYHso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 03:48:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:40266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230019AbhFYHsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 03:48:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B07B6142B;
        Fri, 25 Jun 2021 07:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624607172;
        bh=dJgdpxx4XKktl7lU3lDDCBKK5S888Fg8X9rHYWGF1AE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ql4OhMkjtqAvuisbCVJeVWuOKUPXY49hXEaWg0cBKD5KicyM+LMFiPBszNfi3UqNx
         Yy4H9tCEwpTZyv85aYfmr195lRWuosFeG8YNB1+cOIQCWaCttbshQZM301B+43WxPU
         nRevhM0jvOwR+rw9KBltR8L1x+NS57eqH62N8O2Ba37G4AAbLktsxfC7VQsT3lXjfr
         FlbqI5lm6H+m1M+lfBblkFr/bYZhZ/HWiAkASUyvWJNj7EfNsiktEhozfZ4ZUr/jG/
         qQPgr5u9gPz9ULK0vr0IlHApsfS+9tchhR8ia5EoK2AKs8YJjqrQIAUsTiKt6u37PT
         dTI4Eqjdnx2bQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lwgXS-004aec-Iv; Fri, 25 Jun 2021 09:46:10 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Lee Jones" <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v8 09/12] staging: hi6421-spmi-pmic: cleanup some macros
Date:   Fri, 25 Jun 2021 09:46:01 +0200
Message-Id: <95341999de15b395242b5b7850ec5e727420ce19.1624606660.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1624606660.git.mchehab+huawei@kernel.org>
References: <cover.1624606660.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before moving this driver out of staging, cleanup the macros,
in order to make the driver clearer.

No functional changes.

Suggested-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c | 86 +++++++++++++--------
 1 file changed, 53 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
index 590c3c0e0b33..d98643af72ae 100644
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
+#define HISI_8BITS_MASK			0xff
 
 static const struct mfd_cell hi6421v600_devs[] = {
 	{ .name = "hi6421v600-regulator", },
@@ -86,23 +97,31 @@ static irqreturn_t hi6421_spmi_irq_handler(int irq, void *priv)
 	unsigned int in;
 	int i, offset;
 
-	for (i = 0; i < HISI_IRQ_ARRAY; i++) {
+	for (i = 0; i < HISI_IRQ_BANK_SIZE; i++) {
 		regmap_read(ddata->regmap, SOC_PMIC_IRQ0_ADDR + i, &in);
-		pending = HISI_MASK & in;
-		regmap_write(ddata->regmap, SOC_PMIC_IRQ0_ADDR + i, pending);
 
-		if (i == HISI_IRQ_KEY_NUM &&
-		    (pending & HISI_IRQ_KEY_VALUE) == HISI_IRQ_KEY_VALUE) {
+		/* Mark pending IRQs as handled */
+		regmap_write(ddata->regmap, SOC_PMIC_IRQ0_ADDR + i, in);
+
+		pending = in & HISI_8BITS_MASK;
+
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
@@ -115,12 +134,12 @@ static void hi6421_spmi_irq_mask(struct irq_data *d)
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
@@ -132,13 +151,12 @@ static void hi6421_spmi_irq_unmask(struct irq_data *d)
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
@@ -175,14 +193,16 @@ static void hi6421_spmi_pmic_irq_init(struct hi6421_spmi_pmic *ddata)
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
 
@@ -230,18 +250,18 @@ static int hi6421_spmi_pmic_probe(struct spmi_device *pdev)
 
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
-- 
2.31.1

