Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD424379929
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 23:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbhEJVad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 17:30:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39180 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhEJVab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 17:30:31 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620682165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j9Qbbt7A8AJoZPzHjz4yTss/LBcLQ7nLzy6/asaHCJs=;
        b=OB2E14jD0RWymNOCab57IemIdoZcUMqnVCrVmN48tbQMbfXnGq3KXTzilOl9R4tDS0fkGZ
        ojsk5HmLMUD9qWEGExEFXbuCgBulstL/+E8J96M+GOpdO6p9yMsGD9p6L9fS0QgMqedQYb
        YFqFQEWLdLmnSzztq3HuamltCpvjn3YsH/pJzQlDQ+9CcD+Ap6iLg3SZFyJzXQtwB2XdxV
        NMtgNTQ+1aGDpTiznhT2ph8BcYA5R8b56pfhu3bEaq4S8srp1XL2fTPgVNGhABgzigCBJe
        i28FNdHgE7+BJORSChpdNsrjk69kxWKkmD9U9frAtj3TtFsOUD0NUmlvmTPMvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620682165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j9Qbbt7A8AJoZPzHjz4yTss/LBcLQ7nLzy6/asaHCJs=;
        b=0W5eQyIzRqZMPzzan3PPry5/3WXWwTLNbq+17sZWtFij3+RCd9hAIW3b8HZO6scVzWAcSq
        uPgpltviLnAdsRAg==
To:     Lai Jiangshan <laijs@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        Borislav Petkov <bp@suse.de>
Subject: [patch 1/2 v2] x86/cpu: Init AP exception handling from cpu_init_secondary()
In-Reply-To: <87wns8ko48.ffs@nanos.tec.linutronix.de>
References: <20210507110210.147106915@linutronix.de> <20210507114000.429303187@linutronix.de> <ccbd2f11-bb74-19bd-cf5c-d524625f9a0d@linux.alibaba.com> <87wns8ko48.ffs@nanos.tec.linutronix.de>
Date:   Mon, 10 May 2021 23:29:25 +0200
Message-ID: <87k0o6gtvu.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

SEV-ES guests require properly setup task register with which the TSS
descriptor in the GDT can be located so that the IST-type #VC exception
handler which they need to function properly, can be executed.

This setup needs to happen before attempting to load microcode in
ucode_cpu_init() on secondary CPUs which can cause such #VC exceptions.

Simplify the machinery by running that exception setup from a new function
cpu_init_secondary() and explicitly call cpu_init_exception_handling() for
the boot CPU before cpu_init(). The latter prepares for fixing and
simplifying the exception/IST setup on the boot CPU.

There should be no functional changes resulting from this patch.

[ tglx: Reworked it so cpu_init_exception_handling() stays seperate ]

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Utilize cpu_init_secondary() - Lai
---
 arch/x86/include/asm/processor.h |    1 +
 arch/x86/kernel/cpu/common.c     |   24 +++++++++++-------------
 arch/x86/kernel/smpboot.c        |    3 +--
 arch/x86/kernel/traps.c          |    4 +---
 4 files changed, 14 insertions(+), 18 deletions(-)

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -663,6 +663,7 @@ extern void load_direct_gdt(int);
 extern void load_fixmap_gdt(int);
 extern void load_percpu_segment(int);
 extern void cpu_init(void);
+extern void cpu_init_secondary(void);
 extern void cpu_init_exception_handling(void);
 extern void cr4_init(void);
 
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1938,13 +1938,12 @@ void cpu_init_exception_handling(void)
 
 /*
  * cpu_init() initializes state that is per-CPU. Some data is already
- * initialized (naturally) in the bootstrap process, such as the GDT
- * and IDT. We reload them nevertheless, this function acts as a
- * 'CPU state barrier', nothing should get across.
+ * initialized (naturally) in the bootstrap process, such as the GDT.  We
+ * reload it nevertheless, this function acts as a 'CPU state barrier',
+ * nothing should get across.
  */
 void cpu_init(void)
 {
-	struct tss_struct *tss = this_cpu_ptr(&cpu_tss_rw);
 	struct task_struct *cur = current;
 	int cpu = raw_smp_processor_id();
 
@@ -1957,8 +1956,6 @@ void cpu_init(void)
 	    early_cpu_to_node(cpu) != NUMA_NO_NODE)
 		set_numa_node(early_cpu_to_node(cpu));
 #endif
-	setup_getcpu(cpu);
-
 	pr_debug("Initializing CPU#%d\n", cpu);
 
 	if (IS_ENABLED(CONFIG_X86_64) || cpu_feature_enabled(X86_FEATURE_VME) ||
@@ -1970,7 +1967,6 @@ void cpu_init(void)
 	 * and set up the GDT descriptor:
 	 */
 	switch_to_new_gdt(cpu);
-	load_current_idt();
 
 	if (IS_ENABLED(CONFIG_X86_64)) {
 		loadsegment(fs, 0);
@@ -1990,12 +1986,6 @@ void cpu_init(void)
 	initialize_tlbstate_and_flush();
 	enter_lazy_tlb(&init_mm, cur);
 
-	/* Initialize the TSS. */
-	tss_setup_ist(tss);
-	tss_setup_io_bitmap(tss);
-	set_tss_desc(cpu, &get_cpu_entry_area(cpu)->tss.x86_tss);
-
-	load_TR_desc();
 	/*
 	 * sp0 points to the entry trampoline stack regardless of what task
 	 * is running.
@@ -2017,6 +2007,14 @@ void cpu_init(void)
 	load_fixmap_gdt(cpu);
 }
 
+#ifdef CONFIG_SMP
+void cpu_init_secondary(void)
+{
+	cpu_init_exception_handling();
+	cpu_init();
+}
+#endif
+
 /*
  * The microcode loader calls this upon late microcode load to recheck features,
  * only when microcode has been updated. Caller holds microcode_mutex and CPU
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -232,8 +232,7 @@ static void notrace start_secondary(void
 	load_cr3(swapper_pg_dir);
 	__flush_tlb_all();
 #endif
-	cpu_init_exception_handling();
-	cpu_init();
+	cpu_init_secondary();
 	rcu_cpu_starting(raw_smp_processor_id());
 	x86_cpuinit.early_percpu_clock_init();
 	preempt_disable();
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1162,9 +1162,7 @@ void __init trap_init(void)
 
 	idt_setup_traps();
 
-	/*
-	 * Should be a barrier for any external CPU state:
-	 */
+	cpu_init_exception_handling();
 	cpu_init();
 
 	idt_setup_ist_traps();
