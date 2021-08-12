Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4493EA742
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 17:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238443AbhHLPOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 11:14:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59138 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237934AbhHLPNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 11:13:30 -0400
Date:   Thu, 12 Aug 2021 15:13:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628781184;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8pwB2KnSjjWDJmxUmIR83odCw/lepEZ/3G0mZcNtzKY=;
        b=V2gBzp4nBplyXGyYFz/9wonmQrV+SipNDLZvLV+Zgp1sU5rqSZM/kkz53Yd8Yi/Li538TD
        KRFRVJOcl1aWLXiqfFFcCkvu9Nxz7n2q+xPu+OW6C9388aAGWf9A1rWLsTTFgF6XBP8gsH
        hxaOwESS6LNGlkabBPFNWesJlyUIu+nCdy0Y9zY8ctct97KNNgq2AFmVt/1rT5CmEmBRBb
        LeGVDjx/A+fC/5+JKH+zuaFLxU/fY4BS8T7JhxHZ+QOGQztPI4sV7OLFQqP0p02E9jC2xq
        rRtisOmRjbV+QAMOlIdzX9kHUV42IbxFdYppc5Rbqj579jlLl4nbqupLWhGXiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628781184;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8pwB2KnSjjWDJmxUmIR83odCw/lepEZ/3G0mZcNtzKY=;
        b=nRplYVjZ/Ccodb0XxbQb8wuceuuPLV76fKdAlFRM/oJgNYazPoiJ1Ow8CjIuvjgEXYTVO/
        /gOm8smnazn33VAQ==
From:   "irqchip-bot for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] genirq: Define ack_irq() and eoi_irq() helpers
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210629125010.458872-3-valentin.schneider@arm.com>
References: <20210629125010.458872-3-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <162878118397.395.14906983715913631744.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     635e4fd40660d189e1a83973ddd663abf7bbc849
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/635e4fd40660d189e1a83973ddd663abf7bbc849
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Tue, 29 Jun 2021 13:49:59 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 12 Aug 2021 15:48:19 +01:00

genirq: Define ack_irq() and eoi_irq() helpers

The newly-added IRQCHIP_AUTOMASKS_FLOW flag requires some additional
bookkeeping around chip->{irq_ack, irq_eoi}() calls. Define wrappers around
those chip callbacks to drive the IRQD_IRQ_FLOW_MASKED state of an IRQ when
the chip has the IRQCHIP_AUTOMASKS_FLOW flag.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210629125010.458872-3-valentin.schneider@arm.com
---
 kernel/irq/chip.c      | 16 ++++++++++++++++
 kernel/irq/internals.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 21a21ba..793dbd8 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -408,6 +408,22 @@ void irq_percpu_disable(struct irq_desc *desc, unsigned int cpu)
 	cpumask_clear_cpu(cpu, desc->percpu_enabled);
 }
 
+void ack_irq(struct irq_desc *desc)
+{
+	desc->irq_data.chip->irq_ack(&desc->irq_data);
+
+	if (desc->irq_data.chip->flags & IRQCHIP_AUTOMASKS_FLOW)
+		irq_state_set_flow_masked(desc);
+}
+
+void eoi_irq(struct irq_desc *desc)
+{
+	desc->irq_data.chip->irq_eoi(&desc->irq_data);
+
+	if (desc->irq_data.chip->flags & IRQCHIP_AUTOMASKS_FLOW)
+		irq_state_clr_flow_masked(desc);
+}
+
 static inline void mask_ack_irq(struct irq_desc *desc)
 {
 	if (desc->irq_data.chip->irq_mask_ack) {
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index b6c1cce..6d6a621 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -87,6 +87,8 @@ extern void irq_enable(struct irq_desc *desc);
 extern void irq_disable(struct irq_desc *desc);
 extern void irq_percpu_enable(struct irq_desc *desc, unsigned int cpu);
 extern void irq_percpu_disable(struct irq_desc *desc, unsigned int cpu);
+extern void ack_irq(struct irq_desc *desc);
+extern void eoi_irq(struct irq_desc *desc);
 extern void mask_irq(struct irq_desc *desc);
 extern void unmask_irq(struct irq_desc *desc);
 extern void unmask_threaded_irq(struct irq_desc *desc);
