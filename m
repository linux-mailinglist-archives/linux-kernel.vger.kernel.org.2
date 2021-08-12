Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F673EA743
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 17:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238466AbhHLPOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 11:14:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59132 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238263AbhHLPNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 11:13:31 -0400
Date:   Thu, 12 Aug 2021 15:13:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628781185;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RZjB76MpQ4KrY9ozhFnZ1SyYBMp8o4EKCMi1yTdXwL8=;
        b=lXaogvlf6aX5m/prC7uLorKtya2svyFMPh/riwgdN1h/D0waj4IaLRsAdVp3AVuHzohFWj
        mJh33D3ER8cth+kOpEXIDG/0eWrfm/FdAXKqZ4yQFjtkMsHu/PrrmC3MgwFRRFaKJmF2Z/
        YgFlEvsel0PxFkuZfNApsltE214BzWwM3TQ20jf6TeBYWyHk2UnP4HgkTPZwFDw922bzpZ
        LkRI12bKFHr1CjlN2kblhGjQCWLdB2qHldBBooBsG9vfHeBdrKiZ6BDpKJj5r1ac3U0Gmt
        JhQgKcDF2g7dYQz+WZAjeLLgFQ8b0ETozWVQxMizLXZFN3uCkQV2jCOsXJpiag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628781185;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RZjB76MpQ4KrY9ozhFnZ1SyYBMp8o4EKCMi1yTdXwL8=;
        b=qpEUl0VTtFobG+vJyZLn53eNVZ/2DBPPaNO4ei59zd1bgteR8i8ZYDNYHOzbhhshg6AUC2
        dbKjGR6NOkTp15Cg==
From:   "irqchip-bot for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] genirq: Add chip flag to denote automatic
 IRQ (un)masking
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210629125010.458872-2-valentin.schneider@arm.com>
References: <20210629125010.458872-2-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <162878118453.395.5778052479716307137.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     e0c1a5b24f5b278149c54581427e92728cddf5f6
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/e0c1a5b24f5b278149c54581427e92728cddf5f6
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Tue, 29 Jun 2021 13:49:58 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 12 Aug 2021 15:48:19 +01:00

genirq: Add chip flag to denote automatic IRQ (un)masking

Some IRQ chips such as the Arm GICs automagically mask / unmask an
IRQ during the handling of said IRQ. This renders further mask / unmask
operations within the flow handlers redundant, which we do want to leverage
as masking by itself is not cheap (Distributor access via MMIO for GICs).

This is different from having a chip->irq_mask_ack() callback as this
masking is:
- inherent to the chip->irq_ack() and *cannot* be omitted
- a *different* masking state than chip->irq_mask() (chip->irq_mask() is
  idempotent, chip->irq_ack() really isn't)

Add a chip flag, IRQCHIP_AUTOMASKS_FLOW, to denote chips with such
behaviour. Add a new IRQ data flag, IRQD_IRQ_FLOW_MASKED, to keep this
flow-induced mask state separate from regular mask / unmask operations
(IRQD_IRQ_MASKED).

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210629125010.458872-2-valentin.schneider@arm.com
---
 include/linux/irq.h    | 10 ++++++++++
 kernel/irq/chip.c      |  5 +++++
 kernel/irq/debugfs.c   |  2 ++
 kernel/irq/internals.h |  5 +++++
 4 files changed, 22 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 8e9a9ae..ef17924 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -221,6 +221,8 @@ struct irq_data {
  *				  irq_chip::irq_set_affinity() when deactivated.
  * IRQD_IRQ_ENABLED_ON_SUSPEND	- Interrupt is enabled on suspend by irq pm if
  *				  irqchip have flag IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND set.
+ * IRQD_IRQ_FLOW_MASKED         - Interrupt is masked by ACK. Only EOI can
+ *                                clear this.
  */
 enum {
 	IRQD_TRIGGER_MASK		= 0xf,
@@ -247,6 +249,7 @@ enum {
 	IRQD_HANDLE_ENFORCE_IRQCTX	= (1 << 28),
 	IRQD_AFFINITY_ON_ACTIVATE	= (1 << 29),
 	IRQD_IRQ_ENABLED_ON_SUSPEND	= (1 << 30),
+	IRQD_IRQ_FLOW_MASKED            = (1 << 31),
 };
 
 #define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, state_use_accessors)
@@ -351,6 +354,11 @@ static inline bool irqd_irq_masked(struct irq_data *d)
 	return __irqd_to_state(d) & IRQD_IRQ_MASKED;
 }
 
+static inline bool irqd_irq_flow_masked(struct irq_data *d)
+{
+	return __irqd_to_state(d) & IRQD_IRQ_FLOW_MASKED;
+}
+
 static inline bool irqd_irq_inprogress(struct irq_data *d)
 {
 	return __irqd_to_state(d) & IRQD_IRQ_INPROGRESS;
@@ -569,6 +577,7 @@ struct irq_chip {
  * IRQCHIP_SUPPORTS_NMI:              Chip can deliver NMIs, only for root irqchips
  * IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND:  Invokes __enable_irq()/__disable_irq() for wake irqs
  *                                    in the suspend path if they are in disabled state
+ * IRQCHIP_AUTOMASKS_FLOW:            chip->ack() masks and chip->eoi() unmasks
  */
 enum {
 	IRQCHIP_SET_TYPE_MASKED			= (1 <<  0),
@@ -581,6 +590,7 @@ enum {
 	IRQCHIP_SUPPORTS_LEVEL_MSI		= (1 <<  7),
 	IRQCHIP_SUPPORTS_NMI			= (1 <<  8),
 	IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND	= (1 <<  9),
+	IRQCHIP_AUTOMASKS_FLOW                  = (1 <<  10),
 };
 
 #include <linux/irqdesc.h>
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 7f04c7d..21a21ba 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -173,6 +173,11 @@ static void irq_state_clr_masked(struct irq_desc *desc)
 	irqd_clear(&desc->irq_data, IRQD_IRQ_MASKED);
 }
 
+static void irq_state_clr_flow_masked(struct irq_desc *desc)
+{
+	irqd_clear(&desc->irq_data, IRQD_IRQ_FLOW_MASKED);
+}
+
 static void irq_state_clr_started(struct irq_desc *desc)
 {
 	irqd_clear(&desc->irq_data, IRQD_IRQ_STARTED);
diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index e4cff35..3ae8362 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -58,6 +58,7 @@ static const struct irq_bit_descr irqchip_flags[] = {
 	BIT_MASK_DESCR(IRQCHIP_SUPPORTS_LEVEL_MSI),
 	BIT_MASK_DESCR(IRQCHIP_SUPPORTS_NMI),
 	BIT_MASK_DESCR(IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND),
+	BIT_MASK_DESCR(IRQCHIP_AUTOMASKS_FLOW),
 };
 
 static void
@@ -103,6 +104,7 @@ static const struct irq_bit_descr irqdata_states[] = {
 	BIT_MASK_DESCR(IRQD_IRQ_STARTED),
 	BIT_MASK_DESCR(IRQD_IRQ_DISABLED),
 	BIT_MASK_DESCR(IRQD_IRQ_MASKED),
+	BIT_MASK_DESCR(IRQD_IRQ_FLOW_MASKED),
 	BIT_MASK_DESCR(IRQD_IRQ_INPROGRESS),
 
 	BIT_MASK_DESCR(IRQD_PER_CPU),
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 5436352..b6c1cce 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -245,6 +245,11 @@ static inline void irq_state_set_masked(struct irq_desc *desc)
 	irqd_set(&desc->irq_data, IRQD_IRQ_MASKED);
 }
 
+static inline void irq_state_set_flow_masked(struct irq_desc *desc)
+{
+	irqd_set(&desc->irq_data, IRQD_IRQ_FLOW_MASKED);
+}
+
 #undef __irqd_to_state
 
 static inline void __kstat_incr_irqs_this_cpu(struct irq_desc *desc)
