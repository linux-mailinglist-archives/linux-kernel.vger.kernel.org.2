Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10CC305FD6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 16:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbhA0PkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 10:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236245AbhA0Pe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 10:34:56 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA97C061786
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 07:34:15 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id i7so1809004pgc.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 07:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RW+ddIYgRpxVAudma0S26NHqjC8I6ofivy+rOJrw1Q8=;
        b=EHWrP9QsvCwkvbps77tSaxpjJ9H/c0Zz7EZ9HE2lnFPgzJLxgVwpnK9y/8x/2y/XAg
         0nX3CZm7Rki2IIYoF26e01YkqmQT5oL0stGZxeMbDc6SaPzfLZqD0blXYt3Eyv+GbN6j
         wO9fSEbHEO0mSVT6GnTADEoGYIhXRrJvu2FN6XQIIXfusIBGwVOXIVymvuAuSnm1oJkI
         M6+Ysbe+duSlyCQ0+es+kGPia8gX+s7QEPl23gb1qQINUyZ3RI72xJ7QOGTl4LDTgxmH
         +fWB3kvyJiBomPSJaHuaOnjvLD9bTZJH7vFWrHFAmWekcUKKgzhzu+wern6H4CqIHTQG
         lE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RW+ddIYgRpxVAudma0S26NHqjC8I6ofivy+rOJrw1Q8=;
        b=WxWA2WerpH6XkYDyyieCVciBVfpqaVwEYGhA90O4vScTYjuPqu/0UZWC9BTv566t+Q
         0OZo/y1R3bRt+u7kEYfBZy+SdoiQopIaPJJdCeqNzF+QZ+jcv2/K+bA2GzQf/CAykLtj
         kx+JNt60x6xx2cGwJXPOTkJn6mlw6LLE5LlHiFwn0LBaTPejiJSn1R/t5wtlM/TuiIee
         gMB3zs+fNmDS3mg9k5S9WjYTNfGit/51oNSXMQ4IoAt5qa0pEtpLVILUAKIW4xwmyPgc
         98ekuek61/gjMTNTb2zdNFouGGlRRD3aBpfCzc7NmCoJOPHLemTvmm4b4rxhFPYLXzzW
         CzHg==
X-Gm-Message-State: AOAM532zIyPQqACAHqp2aj0eHtXXpPsd/3IGjW31sLOVnLsyWX+GsO4w
        jplJepyZzxq/YlPd8b3DD+FXud4tn2Plqw==
X-Google-Smtp-Source: ABdhPJwnvS+C1yPBauKsIL47Gm4afzay1A+L/yIS458o1HDZHhY5VKUnuanmwmvlurr2u11GQLQ9Jw==
X-Received: by 2002:a62:1794:0:b029:1be:c822:52c3 with SMTP id 142-20020a6217940000b02901bec82252c3mr11101428pfx.66.1611761654835;
        Wed, 27 Jan 2021 07:34:14 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id c19sm2727621pfc.122.2021.01.27.07.34.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 07:34:13 -0800 (PST)
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
Subject: [PATCH V3 6/6] x86_32: use cpu_current_thread_sp0 instead of cpu_tss_rw.x86_tss.sp1
Date:   Thu, 28 Jan 2021 00:32:22 +0800
Message-Id: <20210127163231.12709-7-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210127163231.12709-1-jiangshanlai@gmail.com>
References: <20210127163231.12709-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

sp1 is not used by hardware and is used as thread.sp0.  We should just
use new percpu variable.

And remove unneeded TSS_sp1.

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
index 886d32da1318..4265884c33e7 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -774,6 +774,8 @@ static inline void spin_lock_prefetch(const void *x)
 
 #define KSTK_ESP(task)		(task_pt_regs(task)->sp)
 
+DECLARE_PER_CPU(unsigned long, cpu_current_thread_sp0);
+
 #else
 #define INIT_THREAD { }
 
diff --git a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/switch_to.h
index b5f0d2ff47e4..e27eb7974797 100644
--- a/arch/x86/include/asm/switch_to.h
+++ b/arch/x86/include/asm/switch_to.h
@@ -69,7 +69,7 @@ static inline void update_task_stack(struct task_struct *task)
 	if (static_cpu_has(X86_FEATURE_XENPV))
 		load_sp0(task->thread.sp0);
 	else
-		this_cpu_write(cpu_tss_rw.x86_tss.sp1, task->thread.sp0);
+		this_cpu_write(cpu_current_thread_sp0, task->thread.sp0);
 #else
 	/* Xen PV enters the kernel on the thread stack. */
 	if (static_cpu_has(X86_FEATURE_XENPV))
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
index f3d7fd7e9684..b2c37d369137 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1789,12 +1789,19 @@ EXPORT_PER_CPU_SYMBOL(__preempt_count);
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
+EXPORT_PER_CPU_SYMBOL(cpu_current_thread_sp0);
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

