Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2371B3F46FC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 10:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbhHWI4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 04:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235652AbhHWI4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 04:56:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB3AC061757
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 01:56:00 -0700 (PDT)
Date:   Mon, 23 Aug 2021 08:55:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629708959;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mNa5QxuYY9taMMim3Q0hL0TIPonuPw4yAdGpTEvBRQI=;
        b=ABWvVXyY7butuLy09rtNGOnoiEABAClIYqSPrYLutVDwDT+W7tMmToek3dB4N/rzunaTlU
        nOJ6rWDRIFEMtZwQVEZPjpe5YNEXJFoEo91gI4bjmF2+/GGxL7LdaDagRHnWR6Y1t3QFCR
        /u5CGB9nrmPq10crqBLieafZ9RczEzkbZ4+QVN9zv+msNfeDSXejTOgzTZVk/tLHGfFBoX
        Nn0VALB2KCX8RTdv+4VyO7rX46Pbu8ePryob71ZtW8qg9yYtHzcnLtfjEXX3xPIkPN9mXv
        0OGEnM2ZFoyg0IsQSBGHYrhsEBfWaOi7TOUBZJEeDcqmoeZM/R3n8X+H4iTQhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629708959;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mNa5QxuYY9taMMim3Q0hL0TIPonuPw4yAdGpTEvBRQI=;
        b=vXwG8WLRCOhhhfp4WmNXtywtu6KeQVlIUFHdGO7grrh507ZvmODDmurfXEqGVFHQvwvW5K
        DxfuY465ORC1EsAA==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/qcom-pdc: Trim unused levels of
 the interrupt hierarchy
Cc:     Marc Zyngier <maz@kernel.org>, Maulik Shah <mkshah@codeaurora.org>,
        tglx@linutronix.de
In-Reply-To: <1629705880-27877-3-git-send-email-mkshah@codeaurora.org>
References: <1629705880-27877-3-git-send-email-mkshah@codeaurora.org>
MIME-Version: 1.0
Message-ID: <162970895783.25758.16183336890093219869.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     9d4f24bfe043274d9274bcfe223b901bd8fb7182
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/9d4f24bfe043274d9274bcfe223b901bd8fb7182
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 23 Aug 2021 13:34:40 +05:30
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 23 Aug 2021 09:45:31 +01:00

irqchip/qcom-pdc: Trim unused levels of the interrupt hierarchy

The QCOM PDC driver creates a bunch of unnecessary levels in
the interrupt hierarchy when dealing with non-wakeup-capable
interrupts. By definition, these lines are terminated at the
PDC level, and everything below this is completely fake.

This also results in additional complexity as most of the
callbacks have to check for the validity of the parent level.
Needless to say, this doesn't look very good.

Solve this by disconnecting the interrupt hierarchy below
the last valid level, and considerably simplify the handling
of all the other interrupts by avoiding now unnecessary cheks.
In most cases, the standard irq_*_parent() handlers are directly
used.

This also cures an issue reporting by Maulik where gpio_to_irq()
returns an error after having observed a set of invalid levels.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
Tested-by: Maulik Shah <mkshah@codeaurora.org>
Link: https://lore.kernel.org/r/1629705880-27877-3-git-send-email-mkshah@codeaurora.org
---
 drivers/irqchip/qcom-pdc.c | 68 +++++--------------------------------
 1 file changed, 11 insertions(+), 57 deletions(-)

diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index 32d5920..173e652 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -53,26 +53,6 @@ static u32 pdc_reg_read(int reg, u32 i)
 	return readl_relaxed(pdc_base + reg + i * sizeof(u32));
 }
 
-static int qcom_pdc_gic_get_irqchip_state(struct irq_data *d,
-					  enum irqchip_irq_state which,
-					  bool *state)
-{
-	if (d->hwirq == GPIO_NO_WAKE_IRQ)
-		return 0;
-
-	return irq_chip_get_parent_state(d, which, state);
-}
-
-static int qcom_pdc_gic_set_irqchip_state(struct irq_data *d,
-					  enum irqchip_irq_state which,
-					  bool value)
-{
-	if (d->hwirq == GPIO_NO_WAKE_IRQ)
-		return 0;
-
-	return irq_chip_set_parent_state(d, which, value);
-}
-
 static void pdc_enable_intr(struct irq_data *d, bool on)
 {
 	int pin_out = d->hwirq;
@@ -91,38 +71,16 @@ static void pdc_enable_intr(struct irq_data *d, bool on)
 
 static void qcom_pdc_gic_disable(struct irq_data *d)
 {
-	if (d->hwirq == GPIO_NO_WAKE_IRQ)
-		return;
-
 	pdc_enable_intr(d, false);
 	irq_chip_disable_parent(d);
 }
 
 static void qcom_pdc_gic_enable(struct irq_data *d)
 {
-	if (d->hwirq == GPIO_NO_WAKE_IRQ)
-		return;
-
 	pdc_enable_intr(d, true);
 	irq_chip_enable_parent(d);
 }
 
-static void qcom_pdc_gic_mask(struct irq_data *d)
-{
-	if (d->hwirq == GPIO_NO_WAKE_IRQ)
-		return;
-
-	irq_chip_mask_parent(d);
-}
-
-static void qcom_pdc_gic_unmask(struct irq_data *d)
-{
-	if (d->hwirq == GPIO_NO_WAKE_IRQ)
-		return;
-
-	irq_chip_unmask_parent(d);
-}
-
 /*
  * GIC does not handle falling edge or active low. To allow falling edge and
  * active low interrupts to be handled at GIC, PDC has an inverter that inverts
@@ -159,14 +117,10 @@ enum pdc_irq_config_bits {
  */
 static int qcom_pdc_gic_set_type(struct irq_data *d, unsigned int type)
 {
-	int pin_out = d->hwirq;
 	enum pdc_irq_config_bits pdc_type;
 	enum pdc_irq_config_bits old_pdc_type;
 	int ret;
 
-	if (pin_out == GPIO_NO_WAKE_IRQ)
-		return 0;
-
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
 		pdc_type = PDC_EDGE_RISING;
@@ -191,8 +145,8 @@ static int qcom_pdc_gic_set_type(struct irq_data *d, unsigned int type)
 		return -EINVAL;
 	}
 
-	old_pdc_type = pdc_reg_read(IRQ_i_CFG, pin_out);
-	pdc_reg_write(IRQ_i_CFG, pin_out, pdc_type);
+	old_pdc_type = pdc_reg_read(IRQ_i_CFG, d->hwirq);
+	pdc_reg_write(IRQ_i_CFG, d->hwirq, pdc_type);
 
 	ret = irq_chip_set_type_parent(d, type);
 	if (ret)
@@ -216,12 +170,12 @@ static int qcom_pdc_gic_set_type(struct irq_data *d, unsigned int type)
 static struct irq_chip qcom_pdc_gic_chip = {
 	.name			= "PDC",
 	.irq_eoi		= irq_chip_eoi_parent,
-	.irq_mask		= qcom_pdc_gic_mask,
-	.irq_unmask		= qcom_pdc_gic_unmask,
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
 	.irq_disable		= qcom_pdc_gic_disable,
 	.irq_enable		= qcom_pdc_gic_enable,
-	.irq_get_irqchip_state	= qcom_pdc_gic_get_irqchip_state,
-	.irq_set_irqchip_state	= qcom_pdc_gic_set_irqchip_state,
+	.irq_get_irqchip_state	= irq_chip_get_parent_state,
+	.irq_set_irqchip_state	= irq_chip_set_parent_state,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_set_type		= qcom_pdc_gic_set_type,
 	.flags			= IRQCHIP_MASK_ON_SUSPEND |
@@ -282,7 +236,7 @@ static int qcom_pdc_alloc(struct irq_domain *domain, unsigned int virq,
 
 	parent_hwirq = get_parent_hwirq(hwirq);
 	if (parent_hwirq == PDC_NO_PARENT_IRQ)
-		return 0;
+		return irq_domain_disconnect_hierarchy(domain->parent, virq);
 
 	if (type & IRQ_TYPE_EDGE_BOTH)
 		type = IRQ_TYPE_EDGE_RISING;
@@ -319,17 +273,17 @@ static int qcom_pdc_gpio_alloc(struct irq_domain *domain, unsigned int virq,
 	if (ret)
 		return ret;
 
+	if (hwirq == GPIO_NO_WAKE_IRQ)
+		return irq_domain_disconnect_hierarchy(domain, virq);
+
 	ret = irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
 					    &qcom_pdc_gic_chip, NULL);
 	if (ret)
 		return ret;
 
-	if (hwirq == GPIO_NO_WAKE_IRQ)
-		return 0;
-
 	parent_hwirq = get_parent_hwirq(hwirq);
 	if (parent_hwirq == PDC_NO_PARENT_IRQ)
-		return 0;
+		return irq_domain_disconnect_hierarchy(domain->parent, virq);
 
 	if (type & IRQ_TYPE_EDGE_BOTH)
 		type = IRQ_TYPE_EDGE_RISING;
