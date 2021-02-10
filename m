Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3483166F2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 13:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhBJMl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 07:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbhBJMjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:39:35 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F268C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 04:38:55 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id u143so1176723pfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 04:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uaf7EhO2iScvfMqVO7nJy+zZhMk+TRiQ2X6ZvNrje10=;
        b=CX65ID6PYe2C2gSYkvsd3vAkpQzmOG6yDZQO1vBqtPbbvi+VH5YWKesfC8smWq4+PW
         +ApJ9Yyf+1cz3QlJSCj8FxSjWp+mNZ4iZFOPiblDn3NoEqwjUl9SG/xhzhmI5/HWHrov
         7pobPQl3bUiJcSXnjaSCRR3P5JV4foN6M7awQQ0GWRBdqDIVNP018fltDK7IoNnrcG5V
         mZc3Fq2/28FMThpr6LPwEsLzM0ACvOwiBQ3Dr5DdSnQ0cZeO6UUKpGYaLSk4SxXoqFxk
         hVQXVxwahXuYDTE0s79Pi9cL7ddB73KYeDprtP2NfVB5HHe9SOZwsbjPTU5pjnjcngFj
         qpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uaf7EhO2iScvfMqVO7nJy+zZhMk+TRiQ2X6ZvNrje10=;
        b=P0VZuRuLwIn9N30PIDm6Ss7UOGiEiNEYi/pwM89E8YKDreZpcYwe5RWaQNUWqpuwUy
         ec2ztpQeZy2vZ5qczlhNpInOA6JTqUF+0+vVVCnd3oCdZf7C9564Ah5CASV74nnsPfLw
         jfUbcIyjHXnf8pG/b5Ccy5I/3AYaX6uqgGr7EubMX37CA64FsZ77EGlbgU59NU62o8Pw
         b6WvRqsaml0Ci7jNQGIPM7ClWjthSj3qEMG3ohCMIRiPQiA/SV+7fNrDv3aYJBxWcSK6
         tZVlhO+oDI20sIlvSMLyKHX9IsBAMxUP0guLMMdfS60IxdRQJmzS7wgFPik4Xb5I4Aa9
         M95Q==
X-Gm-Message-State: AOAM5318HAFIlCaPZyf5iJfTlRByAsc3Ac1t1hXYPvAsZ5RoOzvUSl98
        308mSwr4FsG+rIudc/ZPC/fJyTJ3MxU=
X-Google-Smtp-Source: ABdhPJzT88069tp0gyMutAuNPX9HVOr2oRDcbg96C1bl7uGm2lGrBTSg8qq9bjOrBSUAm63dI3V/jw==
X-Received: by 2002:a63:1b22:: with SMTP id b34mr2900542pgb.337.1612960734910;
        Wed, 10 Feb 2021 04:38:54 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id i1sm2445838pfq.158.2021.02.10.04.38.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Feb 2021 04:38:54 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Balbir Singh <sblbir@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Kees Cook <keescook@chromium.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Brian Gerst <brgerst@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Mike Rapoport <rppt@kernel.org>, Mike Hommey <mh@glandium.org>,
        Mark Gross <mgross@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Anthony Steinhauser <asteinhauser@google.com>,
        Jay Lang <jaytlang@mit.edu>,
        "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: [PATCH V4 1/6] x86/entry/64: Move cpu_current_top_of_stack out of TSS
Date:   Wed, 10 Feb 2021 21:39:12 +0800
Message-Id: <20210210133917.2414-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210210133917.2414-1-jiangshanlai@gmail.com>
References: <20210210133917.2414-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

In x86_64, cpu_current_top_of_stack is an alias of cpu_tss_rw.x86_tss.sp1.

When the CPU has meltdown vulnerability(X86_BUG_CPU_MELTDOWN), it would
become a coveted fruit even if kernel pagetable isolation is enabled since
CPU TSS must also be in the user CR3.  An attacker can fetch the kernel
stack top from it through the said vulnerability and continue next steps
of actions based on the kernel stack.

Besides the possible leakage of the address of the kernel stack, it is
not necessary to be in TSS either.  Although it is also heavily used
in the entry code, it is only used when CR3 is already the kernel CR3
and gs_base is already the kernel gs_base which means it can be a normal
percpu variable instead of an alias to a field in TSS.

The major reason it reuses a filed in TSS is performance because TSS is
normally hot in cache and TLB since entry_SYSCALL_64 uses sp2 as scratch
space to stash the user RSP value.

This patch makes it be a percpu variable near other hot percpu variables,
such as current_task, __preempt_count, and they are in the same
cache line.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
tools/testing/selftests/seccomp/seccomp_benchmark desn't show any
performance lost in "getpid native" result.  And actually, the result
changes from 93ns before patch to 92ns after patch when !KPTI, and the
test is very stable although the test desn't show a higher degree of
precision but enough to know it doesn't cause degression for the test.

 arch/x86/include/asm/processor.h   | 10 ----------
 arch/x86/include/asm/switch_to.h   |  6 ------
 arch/x86/include/asm/thread_info.h |  6 ------
 arch/x86/kernel/cpu/common.c       |  3 +++
 arch/x86/kernel/process.c          |  7 +------
 arch/x86/mm/pti.c                  |  7 +++----
 6 files changed, 7 insertions(+), 32 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index a411466a6e74..e197de05d0aa 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -316,11 +316,6 @@ struct x86_hw_tss {
 struct x86_hw_tss {
 	u32			reserved1;
 	u64			sp0;
-
-	/*
-	 * We store cpu_current_top_of_stack in sp1 so it's always accessible.
-	 * Linux does not use ring 1, so sp1 is not otherwise needed.
-	 */
 	u64			sp1;
 
 	/*
@@ -430,12 +425,7 @@ struct irq_stack {
 
 DECLARE_PER_CPU(struct irq_stack *, hardirq_stack_ptr);
 
-#ifdef CONFIG_X86_32
 DECLARE_PER_CPU(unsigned long, cpu_current_top_of_stack);
-#else
-/* The RO copy can't be accessed with this_cpu_xyz(), so use the RW copy. */
-#define cpu_current_top_of_stack cpu_tss_rw.x86_tss.sp1
-#endif
 
 #ifdef CONFIG_X86_64
 struct fixed_percpu_data {
diff --git a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/switch_to.h
index 9f69cc497f4b..f0ba06bcba0b 100644
--- a/arch/x86/include/asm/switch_to.h
+++ b/arch/x86/include/asm/switch_to.h
@@ -71,12 +71,6 @@ static inline void update_task_stack(struct task_struct *task)
 	else
 		this_cpu_write(cpu_tss_rw.x86_tss.sp1, task->thread.sp0);
 #else
-	/*
-	 * x86-64 updates x86_tss.sp1 via cpu_current_top_of_stack. That
-	 * doesn't work on x86-32 because sp1 and
-	 * cpu_current_top_of_stack have different values (because of
-	 * the non-zero stack-padding on 32bit).
-	 */
 	if (static_cpu_has(X86_FEATURE_XENPV))
 		load_sp0(task_top_of_stack(task));
 #endif
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 33b637442b9e..f72404991d01 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -199,12 +199,6 @@ static inline int arch_within_stack_frames(const void * const stack,
 #endif
 }
 
-#else /* !__ASSEMBLY__ */
-
-#ifdef CONFIG_X86_64
-# define cpu_current_top_of_stack (cpu_tss_rw + TSS_sp1)
-#endif
-
 #endif
 
 #ifdef CONFIG_COMPAT
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 9215b91bc044..9c531ec73f5c 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1748,6 +1748,9 @@ DEFINE_PER_CPU(unsigned int, irq_count) __visible = -1;
 DEFINE_PER_CPU(int, __preempt_count) = INIT_PREEMPT_COUNT;
 EXPORT_PER_CPU_SYMBOL(__preempt_count);
 
+DEFINE_PER_CPU(unsigned long, cpu_current_top_of_stack) = TOP_OF_INIT_STACK;
+EXPORT_PER_CPU_SYMBOL_GPL(cpu_current_top_of_stack);
+
 /* May not be marked __init: used by software suspend */
 void syscall_init(void)
 {
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 145a7ac0c19a..296de77da4b2 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -63,14 +63,9 @@ __visible DEFINE_PER_CPU_PAGE_ALIGNED(struct tss_struct, cpu_tss_rw) = {
 		 */
 		.sp0 = (1UL << (BITS_PER_LONG-1)) + 1,
 
-		/*
-		 * .sp1 is cpu_current_top_of_stack.  The init task never
-		 * runs user code, but cpu_current_top_of_stack should still
-		 * be well defined before the first context switch.
-		 */
+#ifdef CONFIG_X86_32
 		.sp1 = TOP_OF_INIT_STACK,
 
-#ifdef CONFIG_X86_32
 		.ss0 = __KERNEL_DS,
 		.ss1 = __KERNEL_CS,
 #endif
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 1aab92930569..e101cd87d038 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -440,10 +440,9 @@ static void __init pti_clone_user_shared(void)
 
 	for_each_possible_cpu(cpu) {
 		/*
-		 * The SYSCALL64 entry code needs to be able to find the
-		 * thread stack and needs one word of scratch space in which
-		 * to spill a register.  All of this lives in the TSS, in
-		 * the sp1 and sp2 slots.
+		 * The SYSCALL64 entry code needs one word of scratch space
+		 * in which to spill a register.  It lives in the sp2 slot
+		 * of the CPU's TSS.
 		 *
 		 * This is done for all possible CPUs during boot to ensure
 		 * that it's propagated to all mms.
-- 
2.19.1.6.gb485710b

