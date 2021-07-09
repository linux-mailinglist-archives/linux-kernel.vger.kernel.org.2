Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006413C217D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 11:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbhGIJZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 05:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhGIJZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 05:25:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AECC0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 02:23:09 -0700 (PDT)
Date:   Fri, 09 Jul 2021 09:23:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625822586;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BD9IA4lW18hMcxqDf8zG0RUBQ7QwW0N/dSCMjbStrJM=;
        b=sQ4FKwB4g7IqftBKZJ29zPUb8rEYJnoyOv/KwvASYl3X6RnFou8PMhzMj2aF5hcFQC8y08
        yDUTwYYaJP0zBXROlY1RTyAd0qn3FUp16YqQqaGg0UVCz6stGLjRb5zMQTe6bUXrkLQ9Z0
        GFnrcMHqLG86srMS7DXKr++p7oxLbKJSG0IXapWV52gGX7v+lDqlbbP5JwYuz0+9ZNuanh
        xF3QFYpVF+YVSJQj8HUgPfvL+FgCJOCk2cLyoSLplKAbTZfjr0UaLwWmZU07udYLR618Lm
        WC37lVfF38Rog8N5lC+IDv1tV4yXzsORB46DBpll83MiWWuDsYZ0yJ6QBSNIyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625822586;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BD9IA4lW18hMcxqDf8zG0RUBQ7QwW0N/dSCMjbStrJM=;
        b=96ZnaviVnTrytDa8PyZKVGsdc9Us27Tw+SkIc67t0/lJO5S9drzj/nuFxMQcrOyWpC+7gm
        JhgJwAYQPEL7Q8BQ==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/mips: Fix RCU violation when
 using irqdomain lookup on interrupt entry
Cc:     Guenter Roeck <linux@roeck-us.net>, Marc Zyngier <maz@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Serge Semin <fancer.lancer@gmail.com>, tglx@linutronix.de
In-Reply-To: <20210705172352.GA56304@roeck-us.net>
References: <20210705172352.GA56304@roeck-us.net>
MIME-Version: 1.0
Message-ID: <162582258557.395.2971332851330260594.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     1fee9db9b42d821e8007289d4eea74bdf85b1543
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/1fee9db9b42d821e8007289d4eea74bdf85b1543
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 06 Jul 2021 11:38:59 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 09 Jul 2021 10:18:58 +01:00

irqchip/mips: Fix RCU violation when using irqdomain lookup on interrupt entry

Since d4a45c68dc81 ("irqdomain: Protect the linear revmap with RCU"),
any irqdomain lookup requires the RCU read lock to be held.

This assumes that the architecture code will be structured such as
irq_enter() will be called *before* the interrupt is looked up
in the irq domain. However, this isn't the case for MIPS, and a number
of drivers are structured to do it the other way around when handling
an interrupt in their root irqchip (secondary irqchips are OK by
construction).

This results in a RCU splat on a lockdep-enabled kernel when the kernel
takes an interrupt from idle, as reported by Guenter Roeck.

Note that this could have fired previously if any driver had used
tree-based irqdomain, which always had the RCU requirement.

To solve this, provide a MIPS-specific helper (do_domain_IRQ())
as the pendent of do_IRQ() that will do thing in the right order
(and maybe save some cycles in the process).

Ideally, MIPS would be moved over to using handle_domain_irq(),
but that's much more ambitious.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
[maz: add dependency on CONFIG_IRQ_DOMAIN after report from the kernelci bot]
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Serge Semin <fancer.lancer@gmail.com>
Link: https://lore.kernel.org/r/20210705172352.GA56304@roeck-us.net
Link: https://lore.kernel.org/r/20210706110647.3979002-1-maz@kernel.org
---
 arch/mips/include/asm/irq.h      |  3 +++
 arch/mips/kernel/irq.c           | 16 ++++++++++++++++
 drivers/irqchip/irq-mips-cpu.c   | 10 ++++++----
 drivers/irqchip/irq-mips-gic.c   |  8 ++++----
 drivers/irqchip/irq-pic32-evic.c |  5 ++---
 5 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/arch/mips/include/asm/irq.h b/arch/mips/include/asm/irq.h
index d1477ec..57561e0 100644
--- a/arch/mips/include/asm/irq.h
+++ b/arch/mips/include/asm/irq.h
@@ -57,6 +57,9 @@ asmlinkage void plat_irq_dispatch(void);
 
 extern void do_IRQ(unsigned int irq);
 
+struct irq_domain;
+extern void do_domain_IRQ(struct irq_domain *domain, unsigned int irq);
+
 extern void arch_init_irq(void);
 extern void spurious_interrupt(void);
 
diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
index 85b6c60..d20e002 100644
--- a/arch/mips/kernel/irq.c
+++ b/arch/mips/kernel/irq.c
@@ -21,6 +21,7 @@
 #include <linux/kallsyms.h>
 #include <linux/kgdb.h>
 #include <linux/ftrace.h>
+#include <linux/irqdomain.h>
 
 #include <linux/atomic.h>
 #include <linux/uaccess.h>
@@ -107,3 +108,18 @@ void __irq_entry do_IRQ(unsigned int irq)
 	irq_exit();
 }
 
+#ifdef CONFIG_IRQ_DOMAIN
+void __irq_entry do_domain_IRQ(struct irq_domain *domain, unsigned int hwirq)
+{
+	struct irq_desc *desc;
+
+	irq_enter();
+	check_stack_overflow();
+
+	desc = irq_resolve_mapping(domain, hwirq);
+	if (likely(desc))
+		handle_irq_desc(desc);
+
+	irq_exit();
+}
+#endif
diff --git a/drivers/irqchip/irq-mips-cpu.c b/drivers/irqchip/irq-mips-cpu.c
index 0bbb0b2..0c7ae71 100644
--- a/drivers/irqchip/irq-mips-cpu.c
+++ b/drivers/irqchip/irq-mips-cpu.c
@@ -127,7 +127,6 @@ static struct irq_chip mips_mt_cpu_irq_controller = {
 asmlinkage void __weak plat_irq_dispatch(void)
 {
 	unsigned long pending = read_c0_cause() & read_c0_status() & ST0_IM;
-	unsigned int virq;
 	int irq;
 
 	if (!pending) {
@@ -137,12 +136,15 @@ asmlinkage void __weak plat_irq_dispatch(void)
 
 	pending >>= CAUSEB_IP;
 	while (pending) {
+		struct irq_domain *d;
+
 		irq = fls(pending) - 1;
 		if (IS_ENABLED(CONFIG_GENERIC_IRQ_IPI) && irq < 2)
-			virq = irq_linear_revmap(ipi_domain, irq);
+			d = ipi_domain;
 		else
-			virq = irq_linear_revmap(irq_domain, irq);
-		do_IRQ(virq);
+			d = irq_domain;
+
+		do_domain_IRQ(d, irq);
 		pending &= ~BIT(irq);
 	}
 }
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index b146e06..54c7092 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -169,8 +169,8 @@ static void gic_handle_shared_int(bool chained)
 			generic_handle_domain_irq(gic_irq_domain,
 						  GIC_SHARED_TO_HWIRQ(intr));
 		else
-			do_IRQ(irq_find_mapping(gic_irq_domain,
-						GIC_SHARED_TO_HWIRQ(intr)));
+			do_domain_IRQ(gic_irq_domain,
+				      GIC_SHARED_TO_HWIRQ(intr));
 	}
 }
 
@@ -320,8 +320,8 @@ static void gic_handle_local_int(bool chained)
 			generic_handle_domain_irq(gic_irq_domain,
 						  GIC_LOCAL_TO_HWIRQ(intr));
 		else
-			do_IRQ(irq_find_mapping(gic_irq_domain,
-						GIC_LOCAL_TO_HWIRQ(intr)));
+			do_domain_IRQ(gic_irq_domain,
+				      GIC_LOCAL_TO_HWIRQ(intr));
 	}
 }
 
diff --git a/drivers/irqchip/irq-pic32-evic.c b/drivers/irqchip/irq-pic32-evic.c
index 34c4b4f..1d9bb28 100644
--- a/drivers/irqchip/irq-pic32-evic.c
+++ b/drivers/irqchip/irq-pic32-evic.c
@@ -42,11 +42,10 @@ static void __iomem *evic_base;
 
 asmlinkage void __weak plat_irq_dispatch(void)
 {
-	unsigned int irq, hwirq;
+	unsigned int hwirq;
 
 	hwirq = readl(evic_base + REG_INTSTAT) & 0xFF;
-	irq = irq_linear_revmap(evic_irq_domain, hwirq);
-	do_IRQ(irq);
+	do_domain_IRQ(evic_irq_domain, hwirq);
 }
 
 static struct evic_chip_data *irqd_to_priv(struct irq_data *data)
