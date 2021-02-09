Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE356315CE7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235312AbhBJCHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234577AbhBJAyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 19:54:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEA4C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 16:53:30 -0800 (PST)
Message-Id: <20210210002512.228830141@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612918408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=3QPJMmY/KRWc3v7cEmj04T0n9X2QYpdtB0Yg+DWLtq8=;
        b=zSd0jm7hGNSMwVOHC6QgPwxXk2HI00tUui3CE6rvUqPAGGmo6w8to4RlIP3C+79chr7YTB
        3R6kgkKum5oyPEKhhf7HMbbgCR8/7uQ+qdjyntF9mt20/z1XQSbaFpd97A5HKoTcJuV49d
        3fzzOIUpr9M6oGS6E5zb8i6X0dFORPBdHFVRZpgMWaWBm8ytv/vDjCGg1AtAwV2fPZURtW
        ZtaYkFUOinVteP2m591KFHVQYV0jOZ4uf+IurMuBnvIoHEakoiRP/Nfj8bc8eiRFFuUZV0
        lTqiy6R/cpn25AOhr5/UHg+AxuF/scqriuzn61elXz9CIB5W/qAWtTBh71QJ0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612918408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=3QPJMmY/KRWc3v7cEmj04T0n9X2QYpdtB0Yg+DWLtq8=;
        b=P3hsvq89lhaN+TgSJbvdHdnmPd6afw4S3Jk8PuToqMm4YgbFdZF2BBnFnX9Le1Irw7twHt
        Eow+8DUe4tWW8dAQ==
Date:   Wed, 10 Feb 2021 00:40:43 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Helge Deller <deller@gmx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rich Felker <dalias@libc.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Subject: [patch V2 02/13] x86/irq: Sanitize irq stack tracking
References: <20210209234041.127454039@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The recursion protection for hard interrupt stacks is an unsigned int per
CPU variable initialized to -1 named __irq_count. 

The irq stack switching is only done when the variable is -1, which creates
worse code than just checking for 0. When the stack switching happens it
uses this_cpu_add/sub(1), but there is no reason to do so. It simply can
use straight writes. This is a historical leftover from the low level ASM
code which used inc and jz to make a decision.

Rename it to hardirq_stack_inuse, make it a bool and use plain stores.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>

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


