Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EC543AFD5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 12:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbhJZKSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 06:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbhJZKS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 06:18:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20671C061767
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 03:16:05 -0700 (PDT)
Date:   Tue, 26 Oct 2021 10:16:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635243363;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=F1UHYCrgjERNSxUeSnbu6qm7NMiYZdwpydZp4wqeAec=;
        b=oU1HooqQH1DWSM59msyETKUUE8IItZiEB0tkfSDE4L22Zvowa+eu7+oRPwz4U/2YKHDS7g
        b0D3iM8mTNO6jfXaig7y/IBhKSjH24Z5VIv0RvvIWDKqbdZQYFoq9BO2rmt3masuMnWVGw
        QXr4kTqQkDWLdk+K44h/vFOXSBBw/JX/tz63wOamV6XXpxNjZV1rRVutbx27I4Zle1U1lD
        oZLkNKVOyDl3Cw4j/XjkzddmXkjUzNR0Qjc7o+fm4tLH5NRGi2IO4BXkukqY9Ck4Rp6lrQ
        C7k8Q1+iY6L3gOnkWvuXO2LVHJ+7NuvnSFNBl5h0gJsABe5I5+aqvTBpQsPCuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635243363;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=F1UHYCrgjERNSxUeSnbu6qm7NMiYZdwpydZp4wqeAec=;
        b=0TAUQN/FZSwHHAfLFsG0B8fMG8xtkI+MO2hSjuzV2e2chPBhpK3oJDAHrMCXuW41xCPd75
        luu8DQvrXhRribBg==
From:   "irqchip-bot for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irq: add a (temporary)
 CONFIG_HANDLE_DOMAIN_IRQ_IRQENTRY
Cc:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
MIME-Version: 1.0
Message-ID: <163524336289.626.10915082360280931649.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     2fe35f8ee726466f0898ba60c5868c6f9a1ac566
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/2fe35f8ee726466f0898ba60c5868c6f9a1ac566
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Tue, 19 Oct 2021 11:12:31 +01:00
Committer:     Mark Rutland <mark.rutland@arm.com>
CommitterDate: Mon, 25 Oct 2021 10:05:30 +01:00

irq: add a (temporary) CONFIG_HANDLE_DOMAIN_IRQ_IRQENTRY

Going forward we want architecture/entry code to perform all the
necessary work to enter/exit IRQ context, with irqchip code merely
handling the mapping of the interrupt to any handler(s). Among other
reasons, this is necessary to consistently fix some longstanding issues
with the ordering of lockdep/RCU/tracing instrumentation which many
architectures get wrong today in their entry code.

Importantly, rcu_irq_{enter,exit}() must be called precisely once per
IRQ exception, so that rcu_is_cpu_rrupt_from_idle() can correctly
identify when an interrupt was taken from an idle context which must be
explicitly preempted. Currently handle_domain_irq() calls
rcu_irq_{enter,exit}() via irq_{enter,exit}(), but entry code needs to
be able to call rcu_irq_{enter,exit}() earlier for correct ordering
across lockdep/RCU/tracing updates for sequences such as:

  lockdep_hardirqs_off(CALLER_ADDR0);
  rcu_irq_enter();
  trace_hardirqs_off_finish();

To permit each architecture to be converted to the new style in turn,
this patch adds a new CONFIG_HANDLE_DOMAIN_IRQ_IRQENTRY selected by all
current users of HANDLE_DOMAIN_IRQ, which gates the existing behaviour.
When CONFIG_HANDLE_DOMAIN_IRQ_IRQENTRY is not selected,
handle_domain_irq() requires entry code to perform the
irq_{enter,exit}() work, with an explicit check for this matching the
style of handle_domain_nmi().

Subsequent patches will:

1) Add the necessary IRQ entry accounting to each architecture in turn,
   dropping CONFIG_HANDLE_DOMAIN_IRQ_IRQENTRY from that architecture's
   Kconfig.

2) Remove CONFIG_HANDLE_DOMAIN_IRQ_IRQENTRY once it is no longer
   selected.

3) Convert irqchip drivers to consistently use
   generic_handle_domain_irq() rather than handle_domain_irq().

4) Remove handle_domain_irq() and CONFIG_HANDLE_DOMAIN_IRQ.

... which should leave us with a clear split of responsiblity across the
entry and irqchip code, making it possible to perform additional
cleanups and fixes for the aforementioned longstanding issues with entry
code.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/arm/Kconfig      |  1 +
 arch/arm64/Kconfig    |  1 +
 arch/csky/Kconfig     |  1 +
 arch/openrisc/Kconfig |  1 +
 arch/riscv/Kconfig    |  1 +
 kernel/irq/Kconfig    |  4 ++++
 kernel/irq/irqdesc.c  | 30 ++++++++++++++++++++++++++++++
 7 files changed, 39 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fc19642..f18aff8 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -65,6 +65,7 @@ config ARM
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
 	select HANDLE_DOMAIN_IRQ
+	select HANDLE_DOMAIN_IRQ_IRQENTRY
 	select HARDIRQS_SW_RESEND
 	select HAVE_ARCH_AUDITSYSCALL if AEABI && !OABI_COMPAT
 	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5c7ae4c..553239a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -134,6 +134,7 @@ config ARM64
 	select GENERIC_GETTIMEOFDAY
 	select GENERIC_VDSO_TIME_NS
 	select HANDLE_DOMAIN_IRQ
+	select HANDLE_DOMAIN_IRQ_IRQENTRY
 	select HARDIRQS_SW_RESEND
 	select HAVE_MOVE_PMD
 	select HAVE_MOVE_PUD
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 9d4d898..45f03f6 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -18,6 +18,7 @@ config CSKY
 	select DMA_DIRECT_REMAP
 	select IRQ_DOMAIN
 	select HANDLE_DOMAIN_IRQ
+	select HANDLE_DOMAIN_IRQ_IRQENTRY
 	select DW_APB_TIMER_OF
 	select GENERIC_IOREMAP
 	select GENERIC_LIB_ASHLDI3
diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index e804026..ed783a6 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -14,6 +14,7 @@ config OPENRISC
 	select OF_EARLY_FLATTREE
 	select IRQ_DOMAIN
 	select HANDLE_DOMAIN_IRQ
+	select HANDLE_DOMAIN_IRQ_IRQENTRY
 	select GPIOLIB
 	select HAVE_ARCH_TRACEHOOK
 	select SPARSE_IRQ
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 301a542..7406530 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -63,6 +63,7 @@ config RISCV
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL if MMU && 64BIT
 	select HANDLE_DOMAIN_IRQ
+	select HANDLE_DOMAIN_IRQ_IRQENTRY
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE if !XIP_KERNEL
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index fbc54c2..897dfc5 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -100,6 +100,10 @@ config IRQ_MSI_IOMMU
 config HANDLE_DOMAIN_IRQ
 	bool
 
+# Legacy behaviour; architectures should call irq_{enter,exit}() themselves
+config HANDLE_DOMAIN_IRQ_IRQENTRY
+	bool
+
 config IRQ_TIMINGS
 	bool
 
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index e25d4bd..5677a84 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -676,6 +676,7 @@ int generic_handle_domain_irq(struct irq_domain *domain, unsigned int hwirq)
 EXPORT_SYMBOL_GPL(generic_handle_domain_irq);
 
 #ifdef CONFIG_HANDLE_DOMAIN_IRQ
+#ifdef CONFIG_HANDLE_DOMAIN_IRQ_IRQENTRY
 /**
  * handle_domain_irq - Invoke the handler for a HW irq belonging to a domain,
  *                     usually for a root interrupt controller
@@ -699,6 +700,35 @@ int handle_domain_irq(struct irq_domain *domain,
 	set_irq_regs(old_regs);
 	return ret;
 }
+#else
+/**
+ * handle_domain_irq - Invoke the handler for a HW irq belonging to a domain,
+ *                     usually for a root interrupt controller
+ * @domain:	The domain where to perform the lookup
+ * @hwirq:	The HW irq number to convert to a logical one
+ * @regs:	Register file coming from the low-level handling code
+ *
+ * 		This function must be called from an IRQ context.
+ *
+ * Returns:	0 on success, or -EINVAL if conversion has failed
+ */
+int handle_domain_irq(struct irq_domain *domain,
+		      unsigned int hwirq, struct pt_regs *regs)
+{
+	struct pt_regs *old_regs = set_irq_regs(regs);
+	int ret;
+
+	/*
+	 * IRQ context needs to be setup earlier.
+	 */
+	WARN_ON(!in_irq());
+
+	ret = generic_handle_domain_irq(domain, hwirq);
+
+	set_irq_regs(old_regs);
+	return ret;
+}
+#endif
 
 /**
  * handle_domain_nmi - Invoke the handler for a HW irq belonging to a domain
