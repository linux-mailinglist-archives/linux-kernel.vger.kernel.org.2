Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC09414E61
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 18:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236691AbhIVQwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 12:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236680AbhIVQwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 12:52:36 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B822C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 09:51:06 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0efa00329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:fa00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CF93A1EC0545;
        Wed, 22 Sep 2021 18:51:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632329465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CaIemHGFshtBcK+j0v3sBw3csRZ8k9zCHBEP7bhP+Io=;
        b=JarX5NW+jYQ98yhGzOra1m3Hojs7w+IlYGaSQ8gKCjsMOM8zWSZGxe+qotaW7K6HCgLUjZ
        OKChgXgxmm0mKv1ynoLYW9LnwRkHTF+b/ppaBNYL95PFE4t10aQ6f8VW1Ker7U3TG9Syn+
        PQhcfz78psQ4PXz4X5oL6Sj1QIV9l1E=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/5] x86/mce: Get rid of machine_check_vector
Date:   Wed, 22 Sep 2021 18:50:58 +0200
Message-Id: <20210922165101.18951-3-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210922165101.18951-1-bp@alien8.de>
References: <20210922165101.18951-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Get rid of the indirect function pointer and use flags settings instead
to steer execution.

Now that it is not an indirect call any longer, drop the instrumentation
annotation for objtool too.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/mce.h         | 10 ------
 arch/x86/kernel/cpu/mce/core.c     | 57 ++++++++++++++----------------
 arch/x86/kernel/cpu/mce/internal.h | 29 ++++++++++++---
 arch/x86/kernel/cpu/mce/p5.c       |  6 +---
 arch/x86/kernel/cpu/mce/winchip.c  |  6 +---
 5 files changed, 53 insertions(+), 55 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 258ef6d9955c..813b4f5b0dd6 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -215,16 +215,6 @@ static inline int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
 					     u64 lapic_id) { return -EINVAL; }
 #endif
 
-#ifdef CONFIG_X86_ANCIENT_MCE
-void intel_p5_mcheck_init(struct cpuinfo_x86 *c);
-void winchip_mcheck_init(struct cpuinfo_x86 *c);
-static inline void enable_p5_mce(void) { mce_p5_enabled = 1; }
-#else
-static inline void intel_p5_mcheck_init(struct cpuinfo_x86 *c) {}
-static inline void winchip_mcheck_init(struct cpuinfo_x86 *c) {}
-static inline void enable_p5_mce(void) {}
-#endif
-
 void mce_setup(struct mce *m);
 void mce_log(struct mce *m);
 DECLARE_PER_CPU(struct device *, mce_device);
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index aaede7ed9f77..7aff9a503d1c 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1328,6 +1328,15 @@ static void queue_task_work(struct mce *m, char *msg, void (*func)(struct callba
 	task_work_add(current, &current->mce_kill_me, TWA_RESUME);
 }
 
+/* Handle unconfigured int18 (should never happen) */
+static noinstr void unexpected_machine_check(struct pt_regs *regs)
+{
+	instrumentation_begin();
+	pr_err("CPU#%d: Unexpected int18 (Machine Check)\n",
+	       smp_processor_id());
+	instrumentation_end();
+}
+
 /*
  * The actual machine check handler. This only handles real
  * exceptions when something got corrupted coming in through int 18.
@@ -1348,36 +1357,43 @@ static void queue_task_work(struct mce *m, char *msg, void (*func)(struct callba
  */
 noinstr void do_machine_check(struct pt_regs *regs)
 {
+	int worst = 0, order, no_way_out, kill_current_task, lmce;
 	DECLARE_BITMAP(valid_banks, MAX_NR_BANKS);
 	DECLARE_BITMAP(toclear, MAX_NR_BANKS);
 	struct mca_config *cfg = &mca_cfg;
 	struct mce m, *final;
 	char *msg = NULL;
-	int worst = 0;
+
+	if (unlikely(mce_flags.p5))
+		return pentium_machine_check(regs);
+	else if (unlikely(mce_flags.winchip))
+		return winchip_machine_check(regs);
+	else if (unlikely(!mca_cfg.initialized))
+		return unexpected_machine_check(regs);
 
 	/*
 	 * Establish sequential order between the CPUs entering the machine
 	 * check handler.
 	 */
-	int order = -1;
+	order = -1;
 
 	/*
 	 * If no_way_out gets set, there is no safe way to recover from this
 	 * MCE.  If mca_cfg.tolerant is cranked up, we'll try anyway.
 	 */
-	int no_way_out = 0;
+	no_way_out = 0;
 
 	/*
 	 * If kill_current_task is not set, there might be a way to recover from this
 	 * error.
 	 */
-	int kill_current_task = 0;
+	kill_current_task = 0;
 
 	/*
 	 * MCEs are always local on AMD. Same is determined by MCG_STATUS_LMCES
 	 * on Intel.
 	 */
-	int lmce = 1;
+	lmce = 1;
 
 	this_cpu_inc(mce_exception_count);
 
@@ -1855,9 +1871,11 @@ static int __mcheck_cpu_ancient_init(struct cpuinfo_x86 *c)
 	switch (c->x86_vendor) {
 	case X86_VENDOR_INTEL:
 		intel_p5_mcheck_init(c);
+		mce_flags.p5 = 1;
 		return 1;
 	case X86_VENDOR_CENTAUR:
 		winchip_mcheck_init(c);
+		mce_flags.winchip = 1;
 		return 1;
 	default:
 		return 0;
@@ -2012,18 +2030,6 @@ bool filter_mce(struct mce *m)
 	return false;
 }
 
-/* Handle unconfigured int18 (should never happen) */
-static noinstr void unexpected_machine_check(struct pt_regs *regs)
-{
-	instrumentation_begin();
-	pr_err("CPU#%d: Unexpected int18 (Machine Check)\n",
-	       smp_processor_id());
-	instrumentation_end();
-}
-
-/* Call the installed machine check handler for this CPU setup. */
-void (*machine_check_vector)(struct pt_regs *) = unexpected_machine_check;
-
 static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 {
 	irqentry_state_t irq_state;
@@ -2034,31 +2040,22 @@ static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 	 * Only required when from kernel mode. See
 	 * mce_check_crashing_cpu() for details.
 	 */
-	if (machine_check_vector == do_machine_check &&
-	    mce_check_crashing_cpu())
+	if (mca_cfg.initialized && mce_check_crashing_cpu())
 		return;
 
 	irq_state = irqentry_nmi_enter(regs);
-	/*
-	 * The call targets are marked noinstr, but objtool can't figure
-	 * that out because it's an indirect call. Annotate it.
-	 */
-	instrumentation_begin();
 
-	machine_check_vector(regs);
+	do_machine_check(regs);
 
-	instrumentation_end();
 	irqentry_nmi_exit(regs, irq_state);
 }
 
 static __always_inline void exc_machine_check_user(struct pt_regs *regs)
 {
 	irqentry_enter_from_user_mode(regs);
-	instrumentation_begin();
 
-	machine_check_vector(regs);
+	do_machine_check(regs);
 
-	instrumentation_end();
 	irqentry_exit_to_user_mode(regs);
 }
 
@@ -2125,7 +2122,7 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
 		return;
 	}
 
-	machine_check_vector = do_machine_check;
+	mca_cfg.initialized = 1;
 
 	__mcheck_cpu_init_early(c);
 	__mcheck_cpu_init_generic();
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 09cb5ab9a81d..d71d6c5c3ef0 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -8,9 +8,6 @@
 #include <linux/device.h>
 #include <asm/mce.h>
 
-/* Pointer to the installed machine check handler for this CPU setup. */
-extern void (*machine_check_vector)(struct pt_regs *);
-
 enum severity_level {
 	MCE_NO_SEVERITY,
 	MCE_DEFERRED_SEVERITY,
@@ -126,7 +123,9 @@ struct mca_config {
 	      ser			: 1,
 	      recovery			: 1,
 	      bios_cmci_threshold	: 1,
-	      __reserved		: 59;
+	      /* Proper #MC exception handler is set */
+	      initialized		: 1,
+	      __reserved		: 58;
 
 	s8 bootlog;
 	int tolerant;
@@ -162,7 +161,13 @@ struct mce_vendor_flags {
 	/* AMD-style error thresholding banks present. */
 	amd_threshold		: 1,
 
-	__reserved_0		: 60;
+	/* Pentium, family 5-style MCA */
+	p5			: 1,
+
+	/* Centaur Winchip C6-style MCA */
+	winchip			: 1,
+
+	__reserved_0		: 58;
 };
 
 extern struct mce_vendor_flags mce_flags;
@@ -195,4 +200,18 @@ __visible bool ex_handler_wrmsr_fault(const struct exception_table_entry *fixup,
 				      unsigned long error_code,
 				      unsigned long fault_addr);
 
+#ifdef CONFIG_X86_ANCIENT_MCE
+void intel_p5_mcheck_init(struct cpuinfo_x86 *c);
+void winchip_mcheck_init(struct cpuinfo_x86 *c);
+noinstr void pentium_machine_check(struct pt_regs *regs);
+noinstr void winchip_machine_check(struct pt_regs *regs);
+static inline void enable_p5_mce(void) { mce_p5_enabled = 1; }
+#else
+static inline void intel_p5_mcheck_init(struct cpuinfo_x86 *c) {}
+static inline void winchip_mcheck_init(struct cpuinfo_x86 *c) {}
+static inline void enable_p5_mce(void) {}
+static inline void pentium_machine_check(struct pt_regs *regs) {}
+static inline void winchip_machine_check(struct pt_regs *regs) {}
+#endif
+
 #endif /* __X86_MCE_INTERNAL_H__ */
diff --git a/arch/x86/kernel/cpu/mce/p5.c b/arch/x86/kernel/cpu/mce/p5.c
index 19e90cae8e97..2272ad53fc33 100644
--- a/arch/x86/kernel/cpu/mce/p5.c
+++ b/arch/x86/kernel/cpu/mce/p5.c
@@ -21,7 +21,7 @@
 int mce_p5_enabled __read_mostly;
 
 /* Machine check handler for Pentium class Intel CPUs: */
-static noinstr void pentium_machine_check(struct pt_regs *regs)
+noinstr void pentium_machine_check(struct pt_regs *regs)
 {
 	u32 loaddr, hi, lotype;
 
@@ -54,10 +54,6 @@ void intel_p5_mcheck_init(struct cpuinfo_x86 *c)
 	if (!cpu_has(c, X86_FEATURE_MCE))
 		return;
 
-	machine_check_vector = pentium_machine_check;
-	/* Make sure the vector pointer is visible before we enable MCEs: */
-	wmb();
-
 	/* Read registers before enabling: */
 	rdmsr(MSR_IA32_P5_MC_ADDR, l, h);
 	rdmsr(MSR_IA32_P5_MC_TYPE, l, h);
diff --git a/arch/x86/kernel/cpu/mce/winchip.c b/arch/x86/kernel/cpu/mce/winchip.c
index 9c9f0abd2d7f..6c99f2941909 100644
--- a/arch/x86/kernel/cpu/mce/winchip.c
+++ b/arch/x86/kernel/cpu/mce/winchip.c
@@ -17,7 +17,7 @@
 #include "internal.h"
 
 /* Machine check handler for WinChip C6: */
-static noinstr void winchip_machine_check(struct pt_regs *regs)
+noinstr void winchip_machine_check(struct pt_regs *regs)
 {
 	instrumentation_begin();
 	pr_emerg("CPU0: Machine Check Exception.\n");
@@ -30,10 +30,6 @@ void winchip_mcheck_init(struct cpuinfo_x86 *c)
 {
 	u32 lo, hi;
 
-	machine_check_vector = winchip_machine_check;
-	/* Make sure the vector pointer is visible before we enable MCEs: */
-	wmb();
-
 	rdmsr(MSR_IDT_FCR1, lo, hi);
 	lo |= (1<<2);	/* Enable EIERRINT (int 18 MCE) */
 	lo &= ~(1<<4);	/* Enable MCE */
-- 
2.29.2

