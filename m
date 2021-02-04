Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE223101EF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 02:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbhBEA6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 19:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbhBEA6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 19:58:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F139DC0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 16:57:54 -0800 (PST)
Message-Id: <20210204211154.410462790@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612486672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Ec7qT5feaQJD+vqNR+Inh5MykR8KVU7uTCahPRakOBM=;
        b=PNdNBJKALw6C4fqsd3wbRy1LudCNnQcGWCbsn8kaKPHQqZQqMnT6SliLj03bFHjP3J1gTv
        G+fu8LEOCtfNs3Q8QS5Uv8c5MVtlJCeb0UkpXmceU4tSHBCxPInHH9z4ky6+iH4dljpxns
        OyR0EY4HJiuPMsFroF7vRGc79pMSHLRRDGIivdfqw/KN/DGE8te5C7+EGDBe0XXaRf8FpA
        icT16aVJHSYjcqSX3Xu2iTDybeKOkXNHhe4IhspFRJ80dOZUmVkPHsNTzODBk8iz1OhEzZ
        0wtdSDhoTp4C1C6oLEbTadY/FOVbx/HvaDkAug5ZGl7tCIhHltSAmcNiyQvLGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612486672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Ec7qT5feaQJD+vqNR+Inh5MykR8KVU7uTCahPRakOBM=;
        b=iTfhpPhHyMvXsuvxWosq6xps0kLLswmAwAxb8ZYoHTvFfnTgJf9J+PMqXoRKaYnfGMzqha
        IXYjrNBBwEhx76BQ==
Date:   Thu, 04 Feb 2021 21:49:06 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>
Subject: [patch 03/12] x86/irq/64: Adjust the per CPU irq stack pointer by 8
References: <20210204204903.350275743@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The per CPU hardirq_stack_ptr contains the pointer to the irq stack in the
form that it is ready to be assigned to [ER]SP so that the first push ends
up on the top entry of the stack.

But the stack switching on 64 bit has the following rules:

    1) Store the current stack pointer (RSP) in the top most stack entry
       to allow the unwinder to link back to the previous stack

    2) Set RSP to the top most stack entry

    3) Invoke functions on the irq stack

    4) Pop RSP from the top most stack entry (stored in #1) so it's back
       to the original stack.

That requires all stack switching code to decrement the stored pointer by 8
in order to be able to store the current RSP and then set RSP to that
location. That's a pointless exercise.

Do the -8 adjustment right when storing the pointer and make the data type
a void pointer to avoid confusion vs. the struct irq_stack data type which
is on 64bit only used to declare the backing store. Move the definition
next to the inuse flag so they end up in the same cache line.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/irq_stack.h |    6 +++---
 arch/x86/include/asm/processor.h |    7 +++----
 arch/x86/kernel/cpu/common.c     |    2 +-
 arch/x86/kernel/dumpstack_64.c   |   22 ++++++++++++++++------
 arch/x86/kernel/irq_64.c         |    6 ++++--
 5 files changed, 27 insertions(+), 16 deletions(-)

--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -23,7 +23,7 @@ static __always_inline void __run_on_irq
 	void *tos = __this_cpu_read(hardirq_stack_ptr);
 
 	__this_cpu_write(hardirq_stack_inuse, true);
-	asm_call_on_stack(tos - 8, func, NULL);
+	asm_call_on_stack(tos, func, NULL);
 	__this_cpu_write(hardirq_stack_inuse, false);
 }
 
@@ -34,7 +34,7 @@ static __always_inline void
 	void *tos = __this_cpu_read(hardirq_stack_ptr);
 
 	__this_cpu_write(hardirq_stack_inuse, true);
-	asm_call_sysvec_on_stack(tos - 8, func, regs);
+	asm_call_sysvec_on_stack(tos, func, regs);
 	__this_cpu_write(hardirq_stack_inuse, false);
 }
 
@@ -45,7 +45,7 @@ static __always_inline void
 	void *tos = __this_cpu_read(hardirq_stack_ptr);
 
 	__this_cpu_write(hardirq_stack_inuse, true);
-	asm_call_irq_on_stack(tos - 8, func, desc);
+	asm_call_irq_on_stack(tos, func, desc);
 	__this_cpu_write(hardirq_stack_inuse, false);
 }
 
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -426,8 +426,6 @@ struct irq_stack {
 	char		stack[IRQ_STACK_SIZE];
 } __aligned(IRQ_STACK_SIZE);
 
-DECLARE_PER_CPU(struct irq_stack *, hardirq_stack_ptr);
-
 #ifdef CONFIG_X86_32
 DECLARE_PER_CPU(unsigned long, cpu_current_top_of_stack);
 #else
@@ -454,6 +452,7 @@ static inline unsigned long cpu_kernelmo
 	return (unsigned long)per_cpu(fixed_percpu_data.gs_base, cpu);
 }
 
+DECLARE_PER_CPU(void *, hardirq_stack_ptr);
 DECLARE_PER_CPU(bool, hardirq_stack_inuse);
 extern asmlinkage void ignore_sysret(void);
 
@@ -473,9 +472,9 @@ struct stack_canary {
 };
 DECLARE_PER_CPU_ALIGNED(struct stack_canary, stack_canary);
 #endif
-/* Per CPU softirq stack pointer */
+DECLARE_PER_CPU(struct irq_stack *, hardirq_stack_ptr);
 DECLARE_PER_CPU(struct irq_stack *, softirq_stack_ptr);
-#endif	/* X86_64 */
+#endif	/* !X86_64 */
 
 extern unsigned int fpu_kernel_xstate_size;
 extern unsigned int fpu_user_xstate_size;
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1739,7 +1739,7 @@ DEFINE_PER_CPU(struct task_struct *, cur
 	&init_task;
 EXPORT_PER_CPU_SYMBOL(current_task);
 
-DEFINE_PER_CPU(struct irq_stack *, hardirq_stack_ptr);
+DEFINE_PER_CPU(void *, hardirq_stack_ptr);
 DEFINE_PER_CPU(bool, hardirq_stack_inuse);
 
 DEFINE_PER_CPU(int, __preempt_count) = INIT_PREEMPT_COUNT;
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -128,12 +128,21 @@ static __always_inline bool in_exception
 
 static __always_inline bool in_irq_stack(unsigned long *stack, struct stack_info *info)
 {
-	unsigned long *end   = (unsigned long *)this_cpu_read(hardirq_stack_ptr);
-	unsigned long *begin = end - (IRQ_STACK_SIZE / sizeof(long));
+	unsigned long *end = (unsigned long *)this_cpu_read(hardirq_stack_ptr);
+	unsigned long *begin;
 
 	/*
-	 * This is a software stack, so 'end' can be a valid stack pointer.
-	 * It just means the stack is empty.
+	 * @end points directly to the top most stack entry to avoid a -8
+	 * adjustment in the stack switch hotpath. Adjust it back before
+	 * calculating @begin.
+	 */
+	end++;
+	begin = end - (IRQ_STACK_SIZE / sizeof(long));
+
+	/*
+	 * Due to the switching logic RSP can never be == @end because the
+	 * final operation is 'popq %rsp' which means after that RSP points
+	 * to the original stack and not to @end.
 	 */
 	if (stack < begin || stack >= end)
 		return false;
@@ -143,8 +152,9 @@ static __always_inline bool in_irq_stack
 	info->end	= end;
 
 	/*
-	 * The next stack pointer is the first thing pushed by the entry code
-	 * after switching to the irq stack.
+	 * The next stack pointer is stored at the top of the irq stack
+	 * before switching to the irq stack. Actual stack entries are all
+	 * below that.
 	 */
 	info->next_sp = (unsigned long *)*(end - 1);
 
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -48,7 +48,8 @@ static int map_irq_stack(unsigned int cp
 	if (!va)
 		return -ENOMEM;
 
-	per_cpu(hardirq_stack_ptr, cpu) = va + IRQ_STACK_SIZE;
+	/* Store actual TOS to avoid adjustment in the hotpath */
+	per_cpu(hardirq_stack_ptr, cpu) = va + IRQ_STACK_SIZE - 8;
 	return 0;
 }
 #else
@@ -60,7 +61,8 @@ static int map_irq_stack(unsigned int cp
 {
 	void *va = per_cpu_ptr(&irq_stack_backing_store, cpu);
 
-	per_cpu(hardirq_stack_ptr, cpu) = va + IRQ_STACK_SIZE;
+	/* Store actual TOS to avoid adjustment in the hotpath */
+	per_cpu(hardirq_stack_ptr, cpu) = va + IRQ_STACK_SIZE - 8;
 	return 0;
 }
 #endif

