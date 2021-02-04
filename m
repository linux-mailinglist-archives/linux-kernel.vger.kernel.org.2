Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277A03101ED
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 02:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbhBEA6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 19:58:41 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44088 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbhBEA6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 19:58:34 -0500
Message-Id: <20210204211154.257738890@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612486671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=LRoYx/sN/6fGHrYmqcqE4m7BBH+wq/jA6E6B6rHy2BE=;
        b=aZmC330fjO7MUouCGUtJlFPOspfHIyy9HS90Jlk5SO6/K8lLowXsz8BjynZQSPS9BT+6eB
        Qvl7XM6EExFHhR1+hTYd0pCe0LWltAlZWCiqQ3Tq42x5tE9opzbepyFvdFQF7jKcD1q1hU
        rnBNjH8MU+ThdSdlbUMojGzLyH3AsuEl8xK0fWWgynpWTrFPXFV1+vGB+yU99+gy7ye1/t
        4TVMgky2b77L+puqJuXNokdcCnRnOtzrRGhmX98is6B2WJS9miSmfqKRYCww21C/MKhZ/g
        Niu2M3meWcpDc0QRAEVvveND5ksztoTwp3Srl/qVd3KwzNUFhZIm2iQaOCdXLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612486671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=LRoYx/sN/6fGHrYmqcqE4m7BBH+wq/jA6E6B6rHy2BE=;
        b=cms7vrgcVSnlnrjp0Py2UROiY4tzS5EIRtrXtfSXwRgXmRa4UqbtzIa/nyRqAw7Ql4TqRs
        QuJRGcKXFWjzYwDA==
Date:   Thu, 04 Feb 2021 21:49:05 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>
Subject: [patch 02/12] x86/irq: Sanitize irq stack tracking
References: <20210204204903.350275743@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recursion protection for hard interrupt stacks is an unsigned int per
CPU variable initialized to -1 named __irq_count. 

The irq stack switching is only done when the variable is -1, which creates
worse code than just checking for 0. When the stack switching happens it
uses this_cpu_add/sub(1), but there is no reason to do so. It simply can
use straight writes. This is a historical leftover from the low level ASM
code which used inc and jz to make a decision.

Rename it to hardirq_stack_inuse, make it a bool and use plain stores.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/irq_stack.h |   14 +++++++-------
 arch/x86/include/asm/processor.h |    2 +-
 arch/x86/kernel/cpu/common.c     |    2 +-
 arch/x86/kernel/process_64.c     |    2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -9,7 +9,7 @@
 #ifdef CONFIG_X86_64
 static __always_inline bool irqstack_active(void)
 {
-	return __this_cpu_read(irq_count) != -1;
+	return __this_cpu_read(hardirq_stack_inuse);
 }
 
 void asm_call_on_stack(void *sp, void (*func)(void), void *arg);
@@ -22,9 +22,9 @@ static __always_inline void __run_on_irq
 {
 	void *tos = __this_cpu_read(hardirq_stack_ptr);
 
-	__this_cpu_add(irq_count, 1);
+	__this_cpu_write(hardirq_stack_inuse, true);
 	asm_call_on_stack(tos - 8, func, NULL);
-	__this_cpu_sub(irq_count, 1);
+	__this_cpu_write(hardirq_stack_inuse, false);
 }
 
 static __always_inline void
@@ -33,9 +33,9 @@ static __always_inline void
 {
 	void *tos = __this_cpu_read(hardirq_stack_ptr);
 
-	__this_cpu_add(irq_count, 1);
+	__this_cpu_write(hardirq_stack_inuse, true);
 	asm_call_sysvec_on_stack(tos - 8, func, regs);
-	__this_cpu_sub(irq_count, 1);
+	__this_cpu_write(hardirq_stack_inuse, false);
 }
 
 static __always_inline void
@@ -44,9 +44,9 @@ static __always_inline void
 {
 	void *tos = __this_cpu_read(hardirq_stack_ptr);
 
-	__this_cpu_add(irq_count, 1);
+	__this_cpu_write(hardirq_stack_inuse, true);
 	asm_call_irq_on_stack(tos - 8, func, desc);
-	__this_cpu_sub(irq_count, 1);
+	__this_cpu_write(hardirq_stack_inuse, false);
 }
 
 #else /* CONFIG_X86_64 */
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -454,7 +454,7 @@ static inline unsigned long cpu_kernelmo
 	return (unsigned long)per_cpu(fixed_percpu_data.gs_base, cpu);
 }
 
-DECLARE_PER_CPU(unsigned int, irq_count);
+DECLARE_PER_CPU(bool, hardirq_stack_inuse);
 extern asmlinkage void ignore_sysret(void);
 
 /* Save actual FS/GS selectors and bases to current->thread */
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1740,7 +1740,7 @@ DEFINE_PER_CPU(struct task_struct *, cur
 EXPORT_PER_CPU_SYMBOL(current_task);
 
 DEFINE_PER_CPU(struct irq_stack *, hardirq_stack_ptr);
-DEFINE_PER_CPU(unsigned int, irq_count) __visible = -1;
+DEFINE_PER_CPU(bool, hardirq_stack_inuse);
 
 DEFINE_PER_CPU(int, __preempt_count) = INIT_PREEMPT_COUNT;
 EXPORT_PER_CPU_SYMBOL(__preempt_count);
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -539,7 +539,7 @@ void compat_start_thread(struct pt_regs
 	int cpu = smp_processor_id();
 
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ENTRY) &&
-		     this_cpu_read(irq_count) != -1);
+		     this_cpu_read(hardirq_stack_inuse));
 
 	if (!test_thread_flag(TIF_NEED_FPU_LOAD))
 		switch_fpu_prepare(prev_fpu, cpu);

