Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C512C43AFD6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 12:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbhJZKSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 06:18:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60736 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235209AbhJZKS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 06:18:29 -0400
Date:   Tue, 26 Oct 2021 10:16:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635243365;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=d3NM74yP0H4FhK5uYjO+jR9/pNSPPMcPdlVzx5lJFss=;
        b=o6iPH+5GdUlTqCaJUWuH8cgbRgo1DnGCkdOK3VhVoOI4Inwqe+nfdni/pEDzehQpRWyKmP
        ldiO3OP5uZ4TNXNp2au9ZPfq04fGve3rCaWPQZe5118dfPgB4izcH/1koUFCiVy7MjzUyG
        22YhWq2x9wMi+nO95M6QRO/QOJr1wb83Vn9nAS1vr5Wkn+1DYBLDFzreKBJpojZ8HoLJbx
        F8ZETEKYUbSFfXAIMelHIlNC0elEFjG1SOwlQVoE+bwCoXZra4J2PkAeYADg4adUU8lD8U
        WtWYuSfbz72j6KNZRlisVzpSxjCnWKD+h69bjNhxvbSoauiblRUmPtoPMLpepA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635243365;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=d3NM74yP0H4FhK5uYjO+jR9/pNSPPMcPdlVzx5lJFss=;
        b=iDY1XGacN15rgYadq5wpCsb7+CIF9iwcj3SHNUFqOyQuMN2slZnxxDmRls0+usy/FhYURh
        P38jcw/6NyXG6bBA==
From:   "irqchip-bot for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irq: nds32: avoid CONFIG_HANDLE_DOMAIN_IRQ
Cc:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Greentime Hu <green.hu@gmail.com>,
        Nick Hu <nickhu@andestech.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <deanbo422@gmail.com>
MIME-Version: 1.0
Message-ID: <163524336361.626.10880278941583546333.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     6f877e13c24d8b7b96a2f4e78f13a2bdfd401c8b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/6f877e13c24d8b7b96a2f4e78f13a2bdfd401c8b
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Wed, 20 Oct 2021 11:36:08 +01:00
Committer:     Mark Rutland <mark.rutland@arm.com>
CommitterDate: Mon, 25 Oct 2021 10:05:29 +01:00

irq: nds32: avoid CONFIG_HANDLE_DOMAIN_IRQ

In preparation for removing HANDLE_DOMAIN_IRQ, have arch/nds32 perform
all the necessary IRQ entry accounting in its entry code.

Currently arch/nds32 is tightly coupled with the ativic32 irqchip, and
while the entry code should logically live under arch/nds32/, moving the
entry logic there makes things more convoluted. So for now, place the
entry logic in the ativic32 irqchip, but separated into a separate
function to make the split of responsibility clear.

In future this should probably use GENERIC_IRQ_MULTI_HANDLER to cleanly
decouple this.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Greentime Hu <green.hu@gmail.com>
Cc: Nick Hu <nickhu@andestech.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vincent Chen <deanbo422@gmail.com>
---
 arch/nds32/Kconfig             |  1 -
 drivers/irqchip/irq-ativic32.c | 22 ++++++++++++++++++++--
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
index aea26e7..4d1421b 100644
--- a/arch/nds32/Kconfig
+++ b/arch/nds32/Kconfig
@@ -27,7 +27,6 @@ config NDS32
 	select GENERIC_LIB_MULDI3
 	select GENERIC_LIB_UCMPDI2
 	select GENERIC_TIME_VSYSCALL
-	select HANDLE_DOMAIN_IRQ
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_EXIT_THREAD
diff --git a/drivers/irqchip/irq-ativic32.c b/drivers/irqchip/irq-ativic32.c
index 476d602..223dd2f 100644
--- a/drivers/irqchip/irq-ativic32.c
+++ b/drivers/irqchip/irq-ativic32.c
@@ -5,11 +5,14 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
+#include <linux/hardirq.h>
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
 #include <linux/irqchip.h>
 #include <nds32_intrinsic.h>
 
+#include <asm/irq_regs.h>
+
 unsigned long wake_mask;
 
 static void ativic32_ack_irq(struct irq_data *data)
@@ -103,10 +106,25 @@ static irq_hw_number_t get_intr_src(void)
 		- NDS32_VECTOR_offINTERRUPT;
 }
 
-asmlinkage void asm_do_IRQ(struct pt_regs *regs)
+static void ativic32_handle_irq(struct pt_regs *regs)
 {
 	irq_hw_number_t hwirq = get_intr_src();
-	handle_domain_irq(root_domain, hwirq, regs);
+	generic_handle_domain_irq(root_domain, hwirq);
+}
+
+/*
+ * TODO: convert nds32 to GENERIC_IRQ_MULTI_HANDLER so that this entry logic
+ * can live in arch code.
+ */
+asmlinkage void asm_do_IRQ(struct pt_regs *regs)
+{
+	struct pt_regs *old_regs;
+
+	irq_enter();
+	old_regs = set_irq_regs(regs);
+	ativic32_handle_irq(regs);
+	set_irq_regs(old_regs);
+	irq_exit();
 }
 
 int __init ativic32_init_irq(struct device_node *node, struct device_node *parent)
