Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA4443AF03
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 11:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbhJZJ2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 05:28:21 -0400
Received: from foss.arm.com ([217.140.110.172]:55576 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234981AbhJZJ2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 05:28:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4EF5C1FB;
        Tue, 26 Oct 2021 02:25:49 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 98C6E3F70D;
        Tue, 26 Oct 2021 02:25:46 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     aou@eecs.berkeley.edu, catalin.marinas@arm.com,
        deanbo422@gmail.com, green.hu@gmail.com, guoren@kernel.org,
        jonas@southpole.se, kernelfans@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        mark.rutland@arm.com, maz@kernel.org, nickhu@andestech.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com, shorne@gmail.com,
        stefan.kristiansson@saunalahti.fi, tglx@linutronix.de,
        tsbogend@alpha.franken.de, vgupta@kernel.org,
        vladimir.murzin@arm.com, will@kernel.org
Subject: [PATCH v2 10/17] irq: add a (temporary) CONFIG_HANDLE_DOMAIN_IRQ_IRQENTRY
Date:   Tue, 26 Oct 2021 10:24:57 +0100
Message-Id: <20211026092504.27071-11-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20211026092504.27071-1-mark.rutland@arm.com>
References: <20211026092504.27071-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index fc196421b2ce..f18aff82c27b 100644
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
index 5c7ae4c3954b..553239a5a5f7 100644
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
index 9d4d898df76b..45f03f674a61 100644
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
index e804026b4797..ed783a67065e 100644
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
index 301a54233c7e..740653063a56 100644
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
index fbc54c2a7f23..897dfc552bb0 100644
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
index e25d4bddf3d8..5677a849cf1f 100644
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
-- 
2.11.0

