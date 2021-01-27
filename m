Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B614305FC8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 16:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236335AbhA0Phc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 10:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235928AbhA0Pco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 10:32:44 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A07AC0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 07:32:04 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id jx18so1569426pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 07:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=as5GizHsylFLHZ2B76fHu3xlwPfopZftZapmvXZfdBI=;
        b=CYLwleVpMfSFP9AstaDMlOQhlocXNFYOWMjxMxcHfsTm9vzYU879jOq1KWHyi+mNN2
         2pzdXJ8Oqycpr+NOibJO5oQiC0vYn7uSAlPj0bcTjuepguGgXQVI5tJOx8v5w+hNp7OQ
         LLZ/+K3RTpQ9jurvEoHdf/CvQ1e+x71OiQHIiifiCcYKMRfJOgJSvtsNlJjbM+ZtyQTw
         1AZBOYRlDwhY4x4qjum5v1Ar3gnX+5XZmn2q3SlF5QAcSvsgqlWEDnv7nAX5bHN15H5H
         yEoeFhp9U5tC3bFMqYcQ7nxW4abZ5lAWVLPKfVsh4GDvmqYlAYqhEbntJtHMu8yVypST
         kVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=as5GizHsylFLHZ2B76fHu3xlwPfopZftZapmvXZfdBI=;
        b=TYAVKqYZgiPw6iWePHODnCoyt0fw6POeMJvkgl5IxZ8uMhtU0Vd3xWAtY7Zhv0OE6U
         AZTUbbHwXqs+WBXAfi3734CRAWdKW6nfKgaoIPtebLqV8Mh2GvSiHqApidq2kVy4KZqe
         ckZveJhqd4iNpwHL1cXnWdj3grfwGOoPJhJ8SpHcAFXYv6dQrBRBQrnZHRNWHawiZQiA
         uS5fDcutKlYZtkCx+FNeGFwlERWSEfSF3vONcrZhs+miVD6XmX+UnxHA81eOlaTKAsvV
         gQgWMGL0+SHzDkkv0sG3r24sszgtJFHTZPaXkhyr07dlUYDJVZCwcWtS6tPabEQvoWAc
         9umg==
X-Gm-Message-State: AOAM532JrK8iwRU9pWE8UkFPgRllo8pruTNWpyFAVqa+rlBvWKnEP5hH
        lNhKWkgSCr2NOpykodOKu5RwFuvDPWRgM99R
X-Google-Smtp-Source: ABdhPJzu/I45zcJDPgf7+KGD8vR4QgBJkvc0lY/jJNAnPyHpjnHKQlOMc55gv/rbeIMDjguCZydm0A==
X-Received: by 2002:a17:90b:1997:: with SMTP id mv23mr6323040pjb.177.1611761523442;
        Wed, 27 Jan 2021 07:32:03 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id i9sm2900691pfo.146.2021.01.27.07.32.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 07:32:02 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
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
Subject: [PATCH V3 1/6] x86_64: move cpu_current_top_of_stack out of TSS
Date:   Thu, 28 Jan 2021 00:32:17 +0800
Message-Id: <20210127163231.12709-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210127163231.12709-1-jiangshanlai@gmail.com>
References: <20210127163231.12709-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

When X86_BUG_CPU_MELTDOWN & KPTI, cpu_current_top_of_stack lives in the
TSS which is also in the user CR3 and it becomes a coveted fruit.  An
attacker can fetch the kernel stack top from it and continue next steps
of actions based on the kernel stack.

The address might not be very usefull for attacker, but it is not so
necessary to be in TSS either.  It is only accessed when CR3 is kernel CR3
and gs_base is kernel gs_base which means it can be in any percpu variable.

The major reason it is in TSS might be performance because it is hot in
cache and tlb since we just access sp2 as the scratch space in syscall.

So we can move it to a percpu variable near other hot percpu variables,
such as current_task, __preempt_count, and they are in the same
cache line.

tools/testing/selftests/seccomp/seccomp_benchmark desn't show any
performance lost in "getpid native" result.  And actually, the result
changes from 93ns before patch to 92ns after patch when !KPTI, and the
test is very stable although the test desn't show a higher degree of
precision but enough to know it doesn't cause degression for the test.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/include/asm/processor.h   | 10 ----------
 arch/x86/include/asm/switch_to.h   |  7 +------
 arch/x86/include/asm/thread_info.h |  6 ------
 arch/x86/kernel/cpu/common.c       |  3 +++
 arch/x86/kernel/process.c          |  7 +------
 arch/x86/mm/pti.c                  |  7 +++----
 6 files changed, 8 insertions(+), 32 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index c20a52b5534b..886d32da1318 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -314,11 +314,6 @@ struct x86_hw_tss {
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
@@ -428,12 +423,7 @@ struct irq_stack {
 
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
index 9f69cc497f4b..b5f0d2ff47e4 100644
--- a/arch/x86/include/asm/switch_to.h
+++ b/arch/x86/include/asm/switch_to.h
@@ -71,12 +71,7 @@ static inline void update_task_stack(struct task_struct *task)
 	else
 		this_cpu_write(cpu_tss_rw.x86_tss.sp1, task->thread.sp0);
 #else
-	/*
-	 * x86-64 updates x86_tss.sp1 via cpu_current_top_of_stack. That
-	 * doesn't work on x86-32 because sp1 and
-	 * cpu_current_top_of_stack have different values (because of
-	 * the non-zero stack-padding on 32bit).
-	 */
+	/* Xen PV enters the kernel on the thread stack. */
 	if (static_cpu_has(X86_FEATURE_XENPV))
 		load_sp0(task_top_of_stack(task));
 #endif
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 0d751d5da702..3dc93d8df425 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -197,12 +197,6 @@ static inline int arch_within_stack_frames(const void * const stack,
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
index 35ad8480c464..f3d7fd7e9684 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1745,6 +1745,9 @@ DEFINE_PER_CPU(unsigned int, irq_count) __visible = -1;
 DEFINE_PER_CPU(int, __preempt_count) = INIT_PREEMPT_COUNT;
 EXPORT_PER_CPU_SYMBOL(__preempt_count);
 
+DEFINE_PER_CPU(unsigned long, cpu_current_top_of_stack) = TOP_OF_INIT_STACK;
+EXPORT_PER_CPU_SYMBOL(cpu_current_top_of_stack);
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

