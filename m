Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9361D3166F8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 13:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbhBJMmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 07:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbhBJMjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:39:53 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57663C06178A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 04:39:13 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id fa16so1044117pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 04:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Anr17AOj6wqQTwhdNv/kAJYm2dfAiJNxhQbV5ccrn8=;
        b=kFI08f+RfKVbxyWqDdEGhzYWFb5MQir0ohVNW+/z6UsCIainZ68zUBM88gsPHXAjc8
         3jpIj+vDT1ZySazG3zcv9VfqFOt1i9loO74qYmqS+5zjuWwtvT3mTrhF8kwLglnGBICJ
         nKTXO7JPUForifvgzLPpicFRNxV1AoJs0so7LGJSh4pJ21vu0uFU67vMLXVFLfDRhuh1
         VPuBEJcL0eriE8KND4BbXkLxH7FcOZl2kTBmOxwDo3T6SQ4IWHSX0+qBGx5vOZ3Dta5I
         W3nzqQgfCjkB6cDgkmFr1xCpUUBivPZ7f16g/3gG7NygSIhhZf4fSAQAFWth+GyObPDY
         XI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Anr17AOj6wqQTwhdNv/kAJYm2dfAiJNxhQbV5ccrn8=;
        b=Q0Qt4dpfjJ+2yO1Kb18NX8QlxEiwkMYlF7XRaial9vzUhSl3twL3GS4rXzISZgAIV1
         ivkhByYuPuuXGsn/XGNBuFXWT2jtr5I9yd6mV45dcyNOuuBWGEW++FowW9L6Mgo9EPUd
         f1PIAEhVJ5FMEL7c9C8Hbepv6uQOiM5Gj4YZQInbJHT84uxJzGoX3QmqicGu6wKOwkAJ
         yiYOurxX7VtUTcSWnJlwELUBNcIwxzs5W6rZ4F7+WoMtS9vUh3WO00vISortH3l+BgZF
         wJaTpupn+GQ17pxYh5kZi7uVWnNxx2pYbgDZyJ7UvcllWDD9cVVPVWUFw6XOTre12Qw2
         QqgQ==
X-Gm-Message-State: AOAM531OoS+Zha4EZSh4XWqum8d1YtWZZCmIQFTKIYSbSk3GWVhJHVMa
        VsD/7sak4+leVSZofYSNRPdkaZriI90=
X-Google-Smtp-Source: ABdhPJzTNUdx2AZYExiOs9p9C4/UoIlxjAp00LenvGGT9Vf35QX62gutIPgkXr+lKKzjegvYCKCgtg==
X-Received: by 2002:a17:90a:9f94:: with SMTP id o20mr3014349pjp.209.1612960752737;
        Wed, 10 Feb 2021 04:39:12 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id x4sm2208720pfm.64.2021.02.10.04.39.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Feb 2021 04:39:11 -0800 (PST)
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
Subject: [PATCH V4 6/6] x86/entry/32: Introduce cpu_current_thread_sp0 to replace cpu_tss_rw.x86_tss.sp1
Date:   Wed, 10 Feb 2021 21:39:17 +0800
Message-Id: <20210210133917.2414-7-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210210133917.2414-1-jiangshanlai@gmail.com>
References: <20210210133917.2414-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

TSS sp1 is not used by hardware and is used as a copy of thread.sp0.

It should just use a percpu variable instead, so we introduce
cpu_current_thread_sp0 for it.

And we remove the unneeded TSS_sp1.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_32.S        | 6 +++---
 arch/x86/include/asm/processor.h | 2 ++
 arch/x86/include/asm/switch_to.h | 2 +-
 arch/x86/kernel/asm-offsets.c    | 1 -
 arch/x86/kernel/cpu/common.c     | 9 ++++++++-
 arch/x86/kernel/process.c        | 2 --
 6 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index d5b5b43fd0c0..55dcf5c35141 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -472,7 +472,7 @@
 	movl	%esp, %esi
 
 	/* Load top of task-stack into %edi */
-	movl	PER_CPU_VAR(cpu_tss_rw + TSS_sp1), %edi
+	movl	PER_CPU_VAR(cpu_current_thread_sp0), %edi
 
 	/* Special case - entry from kernel mode via entry stack */
 #ifdef CONFIG_VM86
@@ -658,7 +658,7 @@
 	movl	PER_CPU_VAR(cpu_tss_rw + TSS_sp0), %edi
 
 	/* Bytes on the task-stack to ecx */
-	movl	PER_CPU_VAR(cpu_tss_rw + TSS_sp1), %ecx
+	movl	PER_CPU_VAR(cpu_current_thread_sp0), %ecx
 	subl	%esi, %ecx
 
 	/* Allocate stack-frame on entry-stack */
@@ -916,7 +916,7 @@ SYM_FUNC_START(entry_SYSENTER_32)
 
 	/* Switch to task stack */
 	movl	%esp, %eax
-	movl	PER_CPU_VAR(cpu_tss_rw + TSS_sp1), %esp
+	movl	PER_CPU_VAR(cpu_current_thread_sp0), %esp
 
 .Lsysenter_past_esp:
 	pushl	$__USER_DS		/* pt_regs->ss */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index e197de05d0aa..a40bade32105 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -776,6 +776,8 @@ static inline void spin_lock_prefetch(const void *x)
 
 #define KSTK_ESP(task)		(task_pt_regs(task)->sp)
 
+DECLARE_PER_CPU(unsigned long, cpu_current_thread_sp0);
+
 #else
 #define INIT_THREAD { }
 
diff --git a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/switch_to.h
index f0ba06bcba0b..eb0d3ae8a54d 100644
--- a/arch/x86/include/asm/switch_to.h
+++ b/arch/x86/include/asm/switch_to.h
@@ -69,7 +69,7 @@ static inline void update_task_stack(struct task_struct *task)
 	if (static_cpu_has(X86_FEATURE_XENPV))
 		load_sp0(task->thread.sp0);
 	else
-		this_cpu_write(cpu_tss_rw.x86_tss.sp1, task->thread.sp0);
+		this_cpu_write(cpu_current_thread_sp0, task->thread.sp0);
 #else
 	if (static_cpu_has(X86_FEATURE_XENPV))
 		load_sp0(task_top_of_stack(task));
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 60b9f42ce3c1..3b63b6062792 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -98,6 +98,5 @@ static void __used common(void)
 
 	/* Offset for fields in tss_struct */
 	OFFSET(TSS_sp0, tss_struct, x86_tss.sp0);
-	OFFSET(TSS_sp1, tss_struct, x86_tss.sp1);
 	OFFSET(TSS_sp2, tss_struct, x86_tss.sp2);
 }
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 9c531ec73f5c..86485d55949e 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1792,12 +1792,19 @@ EXPORT_PER_CPU_SYMBOL(__preempt_count);
 /*
  * On x86_32, vm86 modifies tss.sp0, so sp0 isn't a reliable way to find
  * the top of the kernel stack.  Use an extra percpu variable to track the
- * top of the kernel stack directly.
+ * top of the kernel stack directly and an percpu variable to track the
+ * thread.sp0 for using in entry code.  cpu_current_top_of_stack and
+ * cpu_current_thread_sp0 are different value because of the non-zero
+ * stack-padding on 32bit.  See more comment at TOP_OF_KERNEL_STACK_PADDING
+ * and vm86.
  */
 DEFINE_PER_CPU(unsigned long, cpu_current_top_of_stack) =
 	(unsigned long)&init_thread_union + THREAD_SIZE;
 EXPORT_PER_CPU_SYMBOL(cpu_current_top_of_stack);
 
+DEFINE_PER_CPU(unsigned long, cpu_current_thread_sp0) = TOP_OF_INIT_STACK;
+EXPORT_PER_CPU_SYMBOL_GPL(cpu_current_thread_sp0);
+
 #ifdef CONFIG_STACKPROTECTOR
 DEFINE_PER_CPU_ALIGNED(struct stack_canary, stack_canary);
 #endif
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 296de77da4b2..e6d4b5399a81 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -64,8 +64,6 @@ __visible DEFINE_PER_CPU_PAGE_ALIGNED(struct tss_struct, cpu_tss_rw) = {
 		.sp0 = (1UL << (BITS_PER_LONG-1)) + 1,
 
 #ifdef CONFIG_X86_32
-		.sp1 = TOP_OF_INIT_STACK,
-
 		.ss0 = __KERNEL_DS,
 		.ss1 = __KERNEL_CS,
 #endif
-- 
2.19.1.6.gb485710b

