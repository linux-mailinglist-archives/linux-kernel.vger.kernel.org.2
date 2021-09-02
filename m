Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67DAF3FF08F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 17:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345990AbhIBP4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 11:56:15 -0400
Received: from home.keithp.com ([63.227.221.253]:52906 "EHLO elaine.keithp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345969AbhIBP4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 11:56:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by elaine.keithp.com (Postfix) with ESMTP id 01E283F30807;
        Thu,  2 Sep 2021 08:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
        t=1630598090; bh=Pd4Yuax0ipKl3ivjgoP5KtRXR7CBpfUA02EaUQQXcF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ejqPO/3IwEzpOjWiyIRStfI4VUj+EiWXAaaW2v+Jt8xcwdY5EkdhHDAX2LfNlzpdY
         GzLGtCuu1C6+p9Z34Uj/snEumbDvsK2aD2+GaGX3EgUM8mtaS+RkJgEqjbeFD9ucaF
         LMiFFe9xuO5BSijzJHDQoWOvRuSfoA1VFyBmi1J89vTaukOeDjL3V/dbS8dGMXHo4K
         O3YnM1EKEevH+uVBdeLYnq4KEPR72/xaBYQhPxKEqNW+MipNQeGH7TOcbnmvey62OK
         nE9+TOpsCraE1DUP8Rnqy7Gvwved98thq38X0TM+k/XnDcRvEjteBIA5+z+d8Cfnvi
         hs5wHziYkxaLA==
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
        by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id QkfV7z0sagRc; Thu,  2 Sep 2021 08:54:46 -0700 (PDT)
Received: from keithp.com (168-103-156-98.tukw.qwest.net [168.103.156.98])
        by elaine.keithp.com (Postfix) with ESMTPSA id D36AE3F30802;
        Thu,  2 Sep 2021 08:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
        t=1630598086; bh=Pd4Yuax0ipKl3ivjgoP5KtRXR7CBpfUA02EaUQQXcF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LcBZet2tvQ6QJCxGMAE2F1LPXyK1aTQE2zuZ9y5y9SAHCTAuXr1XcLIbK4sp47Qw7
         SvVpavS18hVZ74VYtyGdYNtMOPy+tUNGMWcbpRtPvuo0pBVmr5ZnMBIlJzULvGmsS2
         7dtdhUadIL0DxUGNTAsEsSanuKFanhWxzRansp/PhwGQBDlVRxnd5U1VcGA4x74hUk
         5DIKZvTJ6J07XJZS7evvt1TEMXHLEu4m6jskiSUM2Z9kLwvE2OK57kbPHzQwsagwcp
         9vW6Sk68kJv35It622VlRoZKvcGWdkNHGhbIL9BKBq0CtvEGXXVjnAnZILgyq6+taB
         PlY7iHh3Eu9Sg==
Received: by keithp.com (Postfix, from userid 1000)
        id E14731E60119; Thu,  2 Sep 2021 08:55:07 -0700 (PDT)
From:   Keith Packard <keithp@keithp.com>
To:     linux-kernel@vger.kernel.org
Cc:     Abbott Liu <liuwenliang@huawei.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Jens Axboe <axboe@kernel.dk>, Jian Cai <jiancai@google.com>,
        Joe Perches <joe@perches.com>,
        Keith Packard <keithp@keithp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Maninder Singh <maninder1.s@samsung.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vaneet Narang <v.narang@samsung.com>,
        "Wolfram Sang (Renesas)" <wsa+renesas@sang-engineering.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Keith Packard <keithpac@amazon.com>
Subject: [PATCH 2/2] ARM: Move thread_info into task_struct
Date:   Thu,  2 Sep 2021 08:54:28 -0700
Message-Id: <20210902155429.3987201-3-keithp@keithp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210902155429.3987201-1-keithp@keithp.com>
References: <20210902155429.3987201-1-keithp@keithp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This avoids many stack overflow attacks which modified the thread_info
structure by moving that into the task_struct as is done is almost all
other architectures.

The task_struct is now referenced by a per-cpu variable,
'current_task', allowing the current one on each cpu to be located
from both C and assembly.

This also involved removing the 'cpu' member from the thread_info
struct and using the one found in the task_struct instead. That is
mostly used in asm code, where it might reasonably be replaced with
the recent per-cpu 'cpu_number' variable.

Signed-off-by: Keith Packard <keithpac@amazon.com>
---
 arch/arm/Kconfig                   |  1 +
 arch/arm/include/asm/assembler.h   | 63 ++++++++++++++++++++++++------
 arch/arm/include/asm/current.h     | 36 +++++++++++++++++
 arch/arm/include/asm/smp.h         |  1 +
 arch/arm/include/asm/thread_info.h | 14 -------
 arch/arm/include/asm/tls.h         |  4 +-
 arch/arm/include/asm/uaccess-asm.h |  6 +--
 arch/arm/kernel/asm-offsets.c      | 31 ++++++++-------
 arch/arm/kernel/entry-armv.S       | 45 ++++++++++-----------
 arch/arm/kernel/entry-common.S     | 20 +++++-----
 arch/arm/kernel/entry-v7m.S        | 12 +++---
 arch/arm/kernel/iwmmxt.S           | 14 +++----
 arch/arm/kernel/process.c          |  1 +
 arch/arm/kernel/setup.c            |  9 ++---
 arch/arm/kernel/smp.c              | 12 +++++-
 arch/arm/lib/copy_from_user.S      |  4 +-
 arch/arm/lib/copy_to_user.S        |  4 +-
 arch/arm/mach-ep93xx/crunch-bits.S |  2 +-
 arch/arm/vfp/entry.S               |  4 +-
 arch/arm/vfp/vfpmodule.c           | 29 +++++++-------
 20 files changed, 193 insertions(+), 119 deletions(-)
 create mode 100644 arch/arm/include/asm/current.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 24804f11302d..1be16c7d7360 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -128,6 +128,7 @@ config ARM
 	select RTC_LIB
 	select SET_FS
 	select SYS_SUPPORTS_APM_EMULATION
+	select THREAD_INFO_IN_TASK
 	# Above selects are sorted alphabetically; please add new ones
 	# according to that.  Thanks.
 	help
diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index e2b1fd558bf3..7723beed5cd9 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -200,13 +200,54 @@
 	.endr
 
 /*
- * Get current thread_info.
+ * Get per-CPU offset
+ * rd: Destination register
  */
-	.macro	get_thread_info, rd
- ARM(	mov	\rd, sp, lsr #THREAD_SIZE_ORDER + PAGE_SHIFT	)
- THUMB(	mov	\rd, sp			)
- THUMB(	lsr	\rd, \rd, #THREAD_SIZE_ORDER + PAGE_SHIFT	)
-	mov	\rd, \rd, lsl #THREAD_SIZE_ORDER + PAGE_SHIFT
+	.macro this_cpu_offset rd:req
+	mrc p15, 0, \rd, c13, c0, 4
+	.endm
+
+/*
+ * Load a per-cpu variable
+ * @dst: Destination register to receive value
+ * @sym: The name of the per-cpu variable
+ * @tmp: scratch register
+ */
+	.macro ldr_this_cpu dst : req, sym : req, tmp : req
+	movw	\dst, #:lower16:\sym
+	movt	\dst, #:upper16:\sym
+	this_cpu_offset \tmp
+	ldr	\dst, [\dst, \tmp]
+	.endm
+
+/*
+ * Store a value in a per-cpu variable
+ * @src: Source register with value
+ * @sym: The name of the per-cpu variable
+ * @t1: scratch register 1
+ * @t2: scratch register 2
+ */
+	.macro str_this_cpu src : req, sym : req, t1 : req, t2 : req
+	movw	\t1, #:lower16:\sym
+	movt	\t1, #:upper16:\sym
+	this_cpu_offset \t2
+	str	\src, [\t1, \t2]
+	.endm
+	
+/*
+ * Get current task_info
+ * @dst: Destination register to receive current task
+ * @tmp: scratch register
+ */
+	.macro get_current, dst : req, tmp : req
+	ldr_this_cpu \dst, current_task, \tmp
+	.endm
+
+/*
+ * Set current task info
+ */
+	.macro	set_current_task rs : req, t1 : req, t2 : req
+	str_this_cpu \rs, current_task, \t1, \t2
 	.endm
 
 /*
@@ -214,19 +255,19 @@
  */
 #ifdef CONFIG_PREEMPT_COUNT
 	.macro	inc_preempt_count, ti, tmp
-	ldr	\tmp, [\ti, #TI_PREEMPT]	@ get preempt count
+	ldr	\tmp, [\ti, #TSK_TI_PREEMPT]	@ get preempt count
 	add	\tmp, \tmp, #1			@ increment it
-	str	\tmp, [\ti, #TI_PREEMPT]
+	str	\tmp, [\ti, #TSK_TI_PREEMPT]
 	.endm
 
 	.macro	dec_preempt_count, ti, tmp
-	ldr	\tmp, [\ti, #TI_PREEMPT]	@ get preempt count
+	ldr	\tmp, [\ti, #TSK_TI_PREEMPT]	@ get preempt count
 	sub	\tmp, \tmp, #1			@ decrement it
-	str	\tmp, [\ti, #TI_PREEMPT]
+	str	\tmp, [\ti, #TSK_TI_PREEMPT]
 	.endm
 
 	.macro	dec_preempt_count_ti, ti, tmp
-	get_thread_info \ti
+	get_task_info \ti, \tmp
 	dec_preempt_count \ti, \tmp
 	.endm
 #else
diff --git a/arch/arm/include/asm/current.h b/arch/arm/include/asm/current.h
new file mode 100644
index 000000000000..b389c4c0005c
--- /dev/null
+++ b/arch/arm/include/asm/current.h
@@ -0,0 +1,36 @@
+/*
+ * Copyright © 2021 Keith Packard <keithp@keithp.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#ifndef _ASM_ARM_CURRENT_H
+#define _ASM_ARM_CURRENT_H
+
+#include <linux/compiler.h>
+#include <linux/thread_info.h>
+#include <asm/percpu.h>
+
+#ifndef __ASSEMBLY__
+struct task_struct;
+
+DECLARE_PER_CPU(struct task_struct *, current_task);
+
+static __always_inline struct task_struct *get_current(void)
+{
+	return raw_cpu_read(current_task);
+}
+
+#define current get_current()
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_ARM_CURRENT_H */
diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 3aca2c2089bc..02989d094fd8 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -64,6 +64,7 @@ struct secondary_data {
 	};
 	unsigned long swapper_pg_dir;
 	void *stack;
+	unsigned int cpu;
 };
 extern struct secondary_data secondary_data;
 extern void secondary_startup(void);
diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 70d4cbc49ae1..995ca0bcb7b1 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -55,8 +55,6 @@ struct thread_info {
 	unsigned long		flags;		/* low level flags */
 	int			preempt_count;	/* 0 => preemptable, <0 => bug */
 	mm_segment_t		addr_limit;	/* address limit */
-	struct task_struct	*task;		/* main task structure */
-	__u32			cpu;		/* cpu */
 	__u32			cpu_domain;	/* cpu domain */
 #ifdef CONFIG_STACKPROTECTOR_PER_TASK
 	unsigned long		stack_canary;
@@ -77,23 +75,11 @@ struct thread_info {
 
 #define INIT_THREAD_INFO(tsk)						\
 {									\
-	.task		= &tsk,						\
 	.flags		= 0,						\
 	.preempt_count	= INIT_PREEMPT_COUNT,				\
 	.addr_limit	= KERNEL_DS,					\
 }
 
-/*
- * how to get the thread information struct from C
- */
-static inline struct thread_info *current_thread_info(void) __attribute_const__;
-
-static inline struct thread_info *current_thread_info(void)
-{
-	return (struct thread_info *)
-		(current_stack_pointer & ~(THREAD_SIZE - 1));
-}
-
 #define thread_saved_pc(tsk)	\
 	((unsigned long)(task_thread_info(tsk)->cpu_context.pc))
 #define thread_saved_sp(tsk)	\
diff --git a/arch/arm/include/asm/tls.h b/arch/arm/include/asm/tls.h
index 5a66c3b13c92..309e870e70a3 100644
--- a/arch/arm/include/asm/tls.h
+++ b/arch/arm/include/asm/tls.h
@@ -14,7 +14,7 @@
 	mrc	p15, 0, \tmp2, c13, c0, 2	@ get the user r/w register
 	mcr	p15, 0, \tp, c13, c0, 3		@ set TLS register
 	mcr	p15, 0, \tpuser, c13, c0, 2	@ and the user r/w register
-	str	\tmp2, [\base, #TI_TP_VALUE + 4] @ save it
+	str	\tmp2, [\base, #TSK_TI_TP_VALUE + 4] @ save it
 	.endm
 
 	.macro switch_tls_v6, base, tp, tpuser, tmp1, tmp2
@@ -26,7 +26,7 @@
 	mrcne	p15, 0, \tmp2, c13, c0, 2	@ get the user r/w register
 	mcrne	p15, 0, \tp, c13, c0, 3		@ yes, set TLS register
 	mcrne	p15, 0, \tpuser, c13, c0, 2	@ set user r/w register
-	strne	\tmp2, [\base, #TI_TP_VALUE + 4] @ save it
+	strne	\tmp2, [\base, #TSK_TI_TP_VALUE + 4] @ save it
 	.endm
 
 	.macro switch_tls_software, base, tp, tpuser, tmp1, tmp2
diff --git a/arch/arm/include/asm/uaccess-asm.h b/arch/arm/include/asm/uaccess-asm.h
index e6eb7a2aaf1e..1c79d851a396 100644
--- a/arch/arm/include/asm/uaccess-asm.h
+++ b/arch/arm/include/asm/uaccess-asm.h
@@ -84,9 +84,9 @@
 	 * if \disable is set.
 	 */
 	.macro	uaccess_entry, tsk, tmp0, tmp1, tmp2, disable
-	ldr	\tmp1, [\tsk, #TI_ADDR_LIMIT]
+	ldr	\tmp1, [\tsk, #TSK_TI_ADDR_LIMIT]
 	ldr	\tmp2, =TASK_SIZE
-	str	\tmp2, [\tsk, #TI_ADDR_LIMIT]
+	str	\tmp2, [\tsk, #TSK_TI_ADDR_LIMIT]
  DACR(	mrc	p15, 0, \tmp0, c3, c0, 0)
  DACR(	str	\tmp0, [sp, #SVC_DACR])
 	str	\tmp1, [sp, #SVC_ADDR_LIMIT]
@@ -108,7 +108,7 @@
 	.macro	uaccess_exit, tsk, tmp0, tmp1
 	ldr	\tmp1, [sp, #SVC_ADDR_LIMIT]
  DACR(	ldr	\tmp0, [sp, #SVC_DACR])
-	str	\tmp1, [\tsk, #TI_ADDR_LIMIT]
+	str	\tmp1, [\tsk, #TSK_TI_ADDR_LIMIT]
  DACR(	mcr	p15, 0, \tmp0, c3, c0, 0)
 	.endm
 
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 70993af22d80..9de799481fb2 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -41,33 +41,34 @@ int main(void)
   DEFINE(TSK_STACK_CANARY,	offsetof(struct task_struct, stack_canary));
 #endif
   BLANK();
-  DEFINE(TI_FLAGS,		offsetof(struct thread_info, flags));
-  DEFINE(TI_PREEMPT,		offsetof(struct thread_info, preempt_count));
-  DEFINE(TI_ADDR_LIMIT,		offsetof(struct thread_info, addr_limit));
-  DEFINE(TI_TASK,		offsetof(struct thread_info, task));
-  DEFINE(TI_CPU,		offsetof(struct thread_info, cpu));
-  DEFINE(TI_CPU_DOMAIN,		offsetof(struct thread_info, cpu_domain));
-  DEFINE(TI_CPU_SAVE,		offsetof(struct thread_info, cpu_context));
-  DEFINE(TI_USED_CP,		offsetof(struct thread_info, used_cp));
-  DEFINE(TI_TP_VALUE,		offsetof(struct thread_info, tp_value));
-  DEFINE(TI_FPSTATE,		offsetof(struct thread_info, fpstate));
+  DEFINE(TSK_TI_FLAGS,		offsetof(struct task_struct, thread_info.flags));
+  DEFINE(TSK_TI_PREEMPT,	offsetof(struct task_struct, thread_info.preempt_count));
+  DEFINE(TSK_TI_ADDR_LIMIT,	offsetof(struct task_struct, thread_info.addr_limit));
+  DEFINE(TSK_TI_CPU_DOMAIN,	offsetof(struct task_struct, thread_info.cpu_domain));
+  DEFINE(TSK_TI_CPU_SAVE,	offsetof(struct task_struct, thread_info.cpu_context));
+  DEFINE(TSK_TI_USED_CP,	offsetof(struct task_struct, thread_info.used_cp));
+  DEFINE(TSK_TI_TP_VALUE,	offsetof(struct task_struct, thread_info.tp_value));
+  DEFINE(TSK_TI_FPSTATE,	offsetof(struct task_struct, thread_info.fpstate));
+#ifdef CONFIG_SMP
+  DEFINE(TSK_CPU,		offsetof(struct task_struct, cpu));
+#endif
 #ifdef CONFIG_VFP
-  DEFINE(TI_VFPSTATE,		offsetof(struct thread_info, vfpstate));
+  DEFINE(TSK_TI_VFPSTATE,	offsetof(struct task_struct, thread_info.vfpstate));
 #ifdef CONFIG_SMP
   DEFINE(VFP_CPU,		offsetof(union vfp_state, hard.cpu));
 #endif
 #endif
 #ifdef CONFIG_ARM_THUMBEE
-  DEFINE(TI_THUMBEE_STATE,	offsetof(struct thread_info, thumbee_state));
+  DEFINE(TSK_TI_THUMBEE_STATE,	offsetof(struct task_struct, thread_info.thumbee_state));
 #endif
 #ifdef CONFIG_IWMMXT
-  DEFINE(TI_IWMMXT_STATE,	offsetof(struct thread_info, fpstate.iwmmxt));
+  DEFINE(TSK_TI_IWMMXT_STATE,	offsetof(struct task_struct, thread_info.fpstate.iwmmxt));
 #endif
 #ifdef CONFIG_CRUNCH
-  DEFINE(TI_CRUNCH_STATE,	offsetof(struct thread_info, crunchstate));
+  DEFINE(TSK_TI_CRUNCH_STATE,	offsetof(struct task_struct, thread_info.crunchstate));
 #endif
 #ifdef CONFIG_STACKPROTECTOR_PER_TASK
-  DEFINE(TI_STACK_CANARY,	offsetof(struct thread_info, stack_canary));
+  DEFINE(TSK_TI_STACK_CANARY,	offsetof(struct task_struct, thread_info.stack_canary));
 #endif
   DEFINE(THREAD_SZ_ORDER,	THREAD_SIZE_ORDER);
   BLANK();
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 0ea8529a4872..2196e4dd7877 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -179,7 +179,7 @@ ENDPROC(__und_invalid)
 	@
 	stmia	r7, {r2 - r6}
 
-	get_thread_info tsk
+	get_current tsk, r0
 	uaccess_entry tsk, r0, r1, r2, \uaccess
 
 	.if \trace
@@ -205,8 +205,8 @@ __irq_svc:
 	irq_handler
 
 #ifdef CONFIG_PREEMPTION
-	ldr	r8, [tsk, #TI_PREEMPT]		@ get preempt count
-	ldr	r0, [tsk, #TI_FLAGS]		@ get flags
+	ldr	r8, [tsk, #TSK_TI_PREEMPT]	@ get preempt count
+	ldr	r0, [tsk, #TSK_TI_FLAGS]	@ get flags
 	teq	r8, #0				@ if preempt count != 0
 	movne	r0, #0				@ force flags to 0
 	tst	r0, #_TIF_NEED_RESCHED
@@ -223,7 +223,7 @@ ENDPROC(__irq_svc)
 svc_preempt:
 	mov	r8, lr
 1:	bl	preempt_schedule_irq		@ irq en/disable is done inside
-	ldr	r0, [tsk, #TI_FLAGS]		@ get new tasks TI_FLAGS
+	ldr	r0, [tsk, #TSK_TI_FLAGS]	@ get new tasks TI_FLAGS
 	tst	r0, #_TIF_NEED_RESCHED
 	reteq	r8				@ go again
 	b	1b
@@ -260,7 +260,7 @@ __und_svc:
 	bl	__und_fault
 
 __und_svc_finish:
-	get_thread_info tsk
+	get_current tsk, r5
 	ldr	r5, [sp, #S_PSR]		@ Get SVC cpsr
 	svc_exit r5				@ return from exception
  UNWIND(.fnend		)
@@ -428,7 +428,7 @@ __irq_usr:
 	usr_entry
 	kuser_cmpxchg_check
 	irq_handler
-	get_thread_info tsk
+	get_current tsk, why
 	mov	why, #0
 	b	ret_to_user_from_irq
  UNWIND(.fnend		)
@@ -572,12 +572,12 @@ ENDPROC(__und_usr)
 	@ Fall-through from Thumb-2 __und_usr
 	@
 #ifdef CONFIG_NEON
-	get_thread_info r10			@ get current thread
+	get_current r10, r6			@ get current thread
 	adr	r6, .LCneon_thumb_opcodes
 	b	2f
 #endif
 call_fpe:
-	get_thread_info r10			@ get current thread
+	get_current r10, r6			@ get current thread
 #ifdef CONFIG_NEON
 	adr	r6, .LCneon_arm_opcodes
 2:	ldr	r5, [r6], #4			@ mask value
@@ -588,8 +588,8 @@ call_fpe:
 	cmp	r8, r7				@ NEON instruction?
 	bne	2b
 	mov	r7, #1
-	strb	r7, [r10, #TI_USED_CP + 10]	@ mark CP#10 as used
-	strb	r7, [r10, #TI_USED_CP + 11]	@ mark CP#11 as used
+	strb	r7, [r10, #TSK_TI_USED_CP + 10]	@ mark CP#10 as used
+	strb	r7, [r10, #TSK_TI_USED_CP + 11]	@ mark CP#11 as used
 	b	do_vfp				@ let VFP handler handle this
 1:
 #endif
@@ -599,12 +599,12 @@ call_fpe:
 	and	r8, r0, #0x00000f00		@ mask out CP number
  THUMB(	lsr	r8, r8, #8		)
 	mov	r7, #1
-	add	r6, r10, #TI_USED_CP
+	add	r6, r10, #TSK_TI_USED_CP
  ARM(	strb	r7, [r6, r8, lsr #8]	)	@ set appropriate used_cp[]
  THUMB(	strb	r7, [r6, r8]		)	@ set appropriate used_cp[]
 #ifdef CONFIG_IWMMXT
 	@ Test if we need to give access to iWMMXt coprocessors
-	ldr	r5, [r10, #TI_FLAGS]
+	ldr	r5, [r10, #TSK_TI_FLAGS]
 	rsbs	r7, r8, #(1 << 8)		@ CP 0 or 1 only
 	movscs	r7, r5, lsr #(TIF_USING_IWMMXT + 1)
 	bcs	iwmmxt_task_enable
@@ -674,7 +674,7 @@ call_fpe:
 
 do_fpe:
 	ldr	r4, .LCfp
-	add	r10, r10, #TI_FPSTATE		@ r10 = workspace
+	add	r10, r10, #TSK_TI_FPSTATE	@ r10 = workspace
 	ldr	pc, [r4]			@ Call FP module USR entry point
 
 /*
@@ -722,7 +722,7 @@ __pabt_usr:
 ENTRY(ret_from_exception)
  UNWIND(.fnstart	)
  UNWIND(.cantunwind	)
-	get_thread_info tsk
+	get_current tsk, why
 	mov	why, #0
 	b	ret_to_user
  UNWIND(.fnend		)
@@ -735,7 +735,7 @@ __fiq_usr:
 	kuser_cmpxchg_check
 	mov	r0, sp				@ struct pt_regs *regs
 	bl	handle_fiq_as_nmi
-	get_thread_info tsk
+	get_current tsk, r0
 	restore_user_regs fast = 0, offset = 0
  UNWIND(.fnend		)
 ENDPROC(__fiq_usr)
@@ -748,21 +748,21 @@ ENDPROC(__fiq_usr)
 ENTRY(__switch_to)
  UNWIND(.fnstart	)
  UNWIND(.cantunwind	)
-	add	ip, r1, #TI_CPU_SAVE
+	add	ip, r1, #TSK_TI_CPU_SAVE
  ARM(	stmia	ip!, {r4 - sl, fp, sp, lr} )	@ Store most regs on stack
  THUMB(	stmia	ip!, {r4 - sl, fp}	   )	@ Store most regs on stack
  THUMB(	str	sp, [ip], #4		   )
  THUMB(	str	lr, [ip], #4		   )
-	ldr	r4, [r2, #TI_TP_VALUE]
-	ldr	r5, [r2, #TI_TP_VALUE + 4]
+	ldr	r4, [r2, #TSK_TI_TP_VALUE]
+	ldr	r5, [r2, #TSK_TI_TP_VALUE + 4]
 #ifdef CONFIG_CPU_USE_DOMAINS
 	mrc	p15, 0, r6, c3, c0, 0		@ Get domain register
-	str	r6, [r1, #TI_CPU_DOMAIN]	@ Save old domain register
-	ldr	r6, [r2, #TI_CPU_DOMAIN]
+	str	r6, [r1, #TSK_TI_CPU_DOMAIN]	@ Save old domain register
+	ldr	r6, [r2, #TSK_TI_CPU_DOMAIN]
 #endif
 	switch_tls r1, r4, r5, r3, r7
 #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_SMP)
-	ldr	r7, [r2, #TI_TASK]
+	ldr	r7, [r2, #TSK_TI_TASK]
 	ldr	r8, =__stack_chk_guard
 	.if (TSK_STACK_CANARY > IMM12_MASK)
 	add	r7, r7, #TSK_STACK_CANARY & ~IMM12_MASK
@@ -772,8 +772,9 @@ ENTRY(__switch_to)
 #ifdef CONFIG_CPU_USE_DOMAINS
 	mcr	p15, 0, r6, c3, c0, 0		@ Set domain register
 #endif
+	set_current_task r2, r4, r5
 	mov	r5, r0
-	add	r4, r2, #TI_CPU_SAVE
+	add	r4, r2, #TSK_TI_CPU_SAVE
 	ldr	r0, =thread_notify_head
 	mov	r1, #THREAD_NOTIFY_SWITCH
 	bl	atomic_notifier_call_chain
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 7f0b7aba1498..7a5044dbfc24 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -49,11 +49,11 @@ __ret_fast_syscall:
  UNWIND(.fnstart	)
  UNWIND(.cantunwind	)
 	disable_irq_notrace			@ disable interrupts
-	ldr	r2, [tsk, #TI_ADDR_LIMIT]
+	ldr	r2, [tsk, #TSK_TI_ADDR_LIMIT]
 	ldr	r1, =TASK_SIZE
 	cmp	r2, r1
 	blne	addr_limit_check_failed
-	ldr	r1, [tsk, #TI_FLAGS]		@ re-check for syscall tracing
+	ldr	r1, [tsk, #TSK_TI_FLAGS]	@ re-check for syscall tracing
 	movs	r1, r1, lsl #16
 	bne	fast_work_pending
 
@@ -87,11 +87,11 @@ __ret_fast_syscall:
 	bl	do_rseq_syscall
 #endif
 	disable_irq_notrace			@ disable interrupts
-	ldr	r2, [tsk, #TI_ADDR_LIMIT]
+	ldr	r2, [tsk, #TSK_TI_ADDR_LIMIT]
 	ldr     r1, =TASK_SIZE
 	cmp     r2, r1
 	blne	addr_limit_check_failed
-	ldr	r1, [tsk, #TI_FLAGS]		@ re-check for syscall tracing
+	ldr	r1, [tsk, #TSK_TI_FLAGS]	@ re-check for syscall tracing
 	movs	r1, r1, lsl #16
 	beq	no_work_pending
  UNWIND(.fnend		)
@@ -129,11 +129,11 @@ ret_slow_syscall:
 #endif
 	disable_irq_notrace			@ disable interrupts
 ENTRY(ret_to_user_from_irq)
-	ldr	r2, [tsk, #TI_ADDR_LIMIT]
+	ldr	r2, [tsk, #TSK_TI_ADDR_LIMIT]
 	ldr     r1, =TASK_SIZE
 	cmp	r2, r1
 	blne	addr_limit_check_failed
-	ldr	r1, [tsk, #TI_FLAGS]
+	ldr	r1, [tsk, #TSK_TI_FLAGS]
 	movs	r1, r1, lsl #16
 	bne	slow_work_pending
 no_work_pending:
@@ -156,7 +156,7 @@ ENTRY(ret_from_fork)
 	movne	r0, r4
 	badrne	lr, 1f
 	retne	r5
-1:	get_thread_info tsk
+1:	get_current tsk, r1
 	b	ret_slow_syscall
 ENDPROC(ret_from_fork)
 
@@ -243,7 +243,7 @@ ENTRY(vector_swi)
 	bic	scno, scno, #0xff000000		@ mask off SWI op-code
 	eor	scno, scno, #__NR_SYSCALL_BASE	@ check OS number
 #endif
-	get_thread_info tsk
+	get_current tsk, r10
 	/*
 	 * Reload the registers that may have been corrupted on entry to
 	 * the syscall assembly (by tracing or context tracking.)
@@ -251,7 +251,7 @@ ENTRY(vector_swi)
  TRACE(	ldmia	sp, {r0 - r3}		)
 
 local_restart:
-	ldr	r10, [tsk, #TI_FLAGS]		@ check for syscall tracing
+	ldr	r10, [tsk, #TSK_TI_FLAGS]	@ check for syscall tracing
 	stmdb	sp!, {r4, r5}			@ push fifth and sixth args
 
 	tst	r10, #_TIF_SYSCALL_WORK		@ are we tracing syscalls?
@@ -278,7 +278,7 @@ local_restart:
 9001:
 	sub	lr, saved_pc, #4
 	str	lr, [sp, #S_PC]
-	get_thread_info tsk
+	get_current tsk, r1
 	b	ret_fast_syscall
 #endif
 ENDPROC(vector_swi)
diff --git a/arch/arm/kernel/entry-v7m.S b/arch/arm/kernel/entry-v7m.S
index d0e898608d30..4de5ee2a432d 100644
--- a/arch/arm/kernel/entry-v7m.S
+++ b/arch/arm/kernel/entry-v7m.S
@@ -57,8 +57,8 @@ __irq_entry:
 	tst	r0, V7M_SCB_ICSR_RETTOBASE
 	beq	2f
 
-	get_thread_info tsk
-	ldr	r2, [tsk, #TI_FLAGS]
+	get_current tsk, r2
+	ldr	r2, [tsk, #TSK_TI_FLAGS]
 	movs	r2, r2, lsl #16
 	beq	2f			@ no work pending
 	mov	r0, #V7M_SCB_ICSR_PENDSVSET
@@ -83,7 +83,7 @@ __pendsv_entry:
 	str	r0, [r1, V7M_SCB_ICSR]	@ clear PendSV
 
 	@ execute the pending work, including reschedule
-	get_thread_info tsk
+	get_current tsk, why
 	mov	why, #0
 	b	ret_to_user_from_irq
 ENDPROC(__pendsv_entry)
@@ -96,17 +96,19 @@ ENDPROC(__pendsv_entry)
 ENTRY(__switch_to)
 	.fnstart
 	.cantunwind
-	add	ip, r1, #TI_CPU_SAVE
+	add	ip, r1, #TSK_TI_CPU_SAVE
 	stmia	ip!, {r4 - r11}		@ Store most regs on stack
 	str	sp, [ip], #4
 	str	lr, [ip], #4
 	mov	r5, r0
-	add	r4, r2, #TI_CPU_SAVE
+	add	r4, r2, #TSK_TI_CPU_SAVE
 	ldr	r0, =thread_notify_head
 	mov	r1, #THREAD_NOTIFY_SWITCH
 	bl	atomic_notifier_call_chain
 	mov	ip, r4
 	mov	r0, r5
+	ldr	r7, [r2, #TSK_TI_TASK]
+	set_current_task r7, r4, r5
 	ldmia	ip!, {r4 - r11}		@ Load all regs saved previously
 	ldr	sp, [ip]
 	ldr	pc, [ip, #4]!
diff --git a/arch/arm/kernel/iwmmxt.S b/arch/arm/kernel/iwmmxt.S
index d2b4ac06e4ed..f709914b9029 100644
--- a/arch/arm/kernel/iwmmxt.S
+++ b/arch/arm/kernel/iwmmxt.S
@@ -84,7 +84,7 @@ ENTRY(iwmmxt_task_enable)
 	PJ4(mcr	p15, 0, r2, c1, c0, 2)
 
 	ldr	r3, =concan_owner
-	add	r0, r10, #TI_IWMMXT_STATE	@ get task Concan save area
+	add	r0, r10, #TSK_TI_IWMMXT_STATE	@ get task Concan save area
 	ldr	r2, [sp, #60]			@ current task pc value
 	ldr	r1, [r3]			@ get current Concan owner
 	str	r0, [r3]			@ this task now owns Concan regs
@@ -96,7 +96,7 @@ ENTRY(iwmmxt_task_enable)
 	bl	concan_save
 
 #ifdef CONFIG_PREEMPT_COUNT
-	get_thread_info r10
+	get_current r10, r3
 #endif
 4:	dec_preempt_count r10, r3
 	ret	r9				@ normal exit from exception
@@ -199,7 +199,7 @@ ENTRY(iwmmxt_task_disable)
 	msr	cpsr_c, r2
 
 	ldr	r3, =concan_owner
-	add	r2, r0, #TI_IWMMXT_STATE	@ get task Concan save area
+	add	r2, r0, #TSK_TI_IWMMXT_STATE	@ get task Concan save area
 	ldr	r1, [r3]			@ get current Concan owner
 	teq	r1, #0				@ any current owner?
 	beq	1f				@ no: quit
@@ -251,7 +251,7 @@ ENTRY(iwmmxt_task_copy)
 	msr	cpsr_c, r2
 
 	ldr	r3, =concan_owner
-	add	r2, r0, #TI_IWMMXT_STATE	@ get task Concan save area
+	add	r2, r0, #TSK_TI_IWMMXT_STATE	@ get task Concan save area
 	ldr	r3, [r3]			@ get current Concan owner
 	teq	r2, r3				@ does this task own it...
 	beq	1f
@@ -289,7 +289,7 @@ ENTRY(iwmmxt_task_restore)
 	msr	cpsr_c, r2
 
 	ldr	r3, =concan_owner
-	add	r2, r0, #TI_IWMMXT_STATE	@ get task Concan save area
+	add	r2, r0, #TSK_TI_IWMMXT_STATE	@ get task Concan save area
 	ldr	r3, [r3]			@ get current Concan owner
 	bic	r2, r2, #0x7			@ 64-bit alignment
 	teq	r2, r3				@ does this task own it...
@@ -328,7 +328,7 @@ ENTRY(iwmmxt_task_switch)
 	bne	1f				@ yes: block them for next task
 
 	ldr	r2, =concan_owner
-	add	r3, r0, #TI_IWMMXT_STATE	@ get next task Concan save area
+	add	r3, r0, #TSK_TI_IWMMXT_STATE	@ get next task Concan save area
 	ldr	r2, [r2]			@ get current Concan owner
 	teq	r2, r3				@ next task owns it?
 	retne	lr				@ no: leave Concan disabled
@@ -355,7 +355,7 @@ ENTRY(iwmmxt_task_release)
 	orr	ip, r2, #PSR_I_BIT		@ disable interrupts
 	msr	cpsr_c, ip
 	ldr	r3, =concan_owner
-	add	r0, r0, #TI_IWMMXT_STATE	@ get task Concan save area
+	add	r0, r0, #TSK_TI_IWMMXT_STATE	@ get task Concan save area
 	ldr	r1, [r3]			@ get current Concan owner
 	eors	r0, r0, r1			@ if equal...
 	streq	r0, [r3]			@ then clear ownership
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 6324f4db9b02..c7539f319f96 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -27,6 +27,7 @@
 #include <linux/random.h>
 #include <linux/hw_breakpoint.h>
 #include <linux/leds.h>
+#include <linux/percpu.h>
 
 #include <asm/processor.h>
 #include <asm/thread_notify.h>
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 73ca7797b92f..a5a52817948a 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -532,12 +532,6 @@ void notrace cpu_init(void)
 		BUG();
 	}
 
-	/*
-	 * This only works on resume and secondary cores. For booting on the
-	 * boot cpu, smp_prepare_boot_cpu is called after percpu area setup.
-	 */
-	set_my_cpu_offset(per_cpu_offset(cpu));
-
 	cpu_proc_init();
 
 	/*
@@ -733,6 +727,9 @@ static void __init setup_processor(void)
 	elf_hwcap_fixup();
 
 	cacheid_init();
+
+	set_my_cpu_offset(per_cpu_offset(0));
+
 	cpu_init();
 }
 
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 0457e25109c6..9b584811baad 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -51,6 +51,10 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/ipi.h>
 
+DEFINE_PER_CPU(struct task_struct *, current_task) ____cacheline_aligned =
+	&init_task;
+EXPORT_PER_CPU_SYMBOL(current_task);
+
 DEFINE_PER_CPU_READ_MOSTLY(unsigned int, cpu_number);
 EXPORT_PER_CPU_SYMBOL(cpu_number);
 
@@ -156,8 +160,11 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
 	secondary_data.pgdir = virt_to_phys(idmap_pgd);
 	secondary_data.swapper_pg_dir = get_arch_pgd(swapper_pg_dir);
 #endif
+	secondary_data.cpu = cpu;
 	sync_cache_w(&secondary_data);
 
+	per_cpu(current_task, cpu) = idle;
+
 	/*
 	 * Now bring the CPU into our world.
 	 */
@@ -406,7 +413,9 @@ static void smp_store_cpu_info(unsigned int cpuid)
 asmlinkage void secondary_start_kernel(void)
 {
 	struct mm_struct *mm = &init_mm;
-	unsigned int cpu;
+	unsigned int cpu = secondary_data.cpu;
+
+	set_my_cpu_offset(per_cpu_offset(cpu));
 
 	secondary_biglittle_init();
 
@@ -423,7 +432,6 @@ asmlinkage void secondary_start_kernel(void)
 	 * All kernel threads share the same mm context; grab a
 	 * reference and switch to it.
 	 */
-	cpu = smp_processor_id();
 	mmgrab(mm);
 	current->active_mm = mm;
 	cpumask_set_cpu(cpu, mm_cpumask(mm));
diff --git a/arch/arm/lib/copy_from_user.S b/arch/arm/lib/copy_from_user.S
index f8016e3db65d..4ed04f91ed0d 100644
--- a/arch/arm/lib/copy_from_user.S
+++ b/arch/arm/lib/copy_from_user.S
@@ -109,8 +109,8 @@
 
 ENTRY(arm_copy_from_user)
 #ifdef CONFIG_CPU_SPECTRE
-	get_thread_info r3
-	ldr	r3, [r3, #TI_ADDR_LIMIT]
+	get_current r3, ip
+	ldr	r3, [r3, #TSK_TI_ADDR_LIMIT]
 	uaccess_mask_range_ptr r1, r2, r3, ip
 #endif
 
diff --git a/arch/arm/lib/copy_to_user.S b/arch/arm/lib/copy_to_user.S
index ebfe4cb3d912..229061cfb5b0 100644
--- a/arch/arm/lib/copy_to_user.S
+++ b/arch/arm/lib/copy_to_user.S
@@ -109,8 +109,8 @@
 ENTRY(__copy_to_user_std)
 WEAK(arm_copy_to_user)
 #ifdef CONFIG_CPU_SPECTRE
-	get_thread_info r3
-	ldr	r3, [r3, #TI_ADDR_LIMIT]
+	get_current r3, ip
+	ldr	r3, [r3, #TSK_TI_ADDR_LIMIT]
 	uaccess_mask_range_ptr r0, r2, r3, ip
 #endif
 
diff --git a/arch/arm/mach-ep93xx/crunch-bits.S b/arch/arm/mach-ep93xx/crunch-bits.S
index fb2dbf76f09e..dad62e3d4b03 100644
--- a/arch/arm/mach-ep93xx/crunch-bits.S
+++ b/arch/arm/mach-ep93xx/crunch-bits.S
@@ -192,7 +192,7 @@ crunch_load:
 
 1:
 #ifdef CONFIG_PREEMPT_COUNT
-	get_thread_info r10
+	get_task_info r10, r3
 #endif
 2:	dec_preempt_count r10, r3
 	ret	lr
diff --git a/arch/arm/vfp/entry.S b/arch/arm/vfp/entry.S
index 27b0a1f27fbd..003554f8393d 100644
--- a/arch/arm/vfp/entry.S
+++ b/arch/arm/vfp/entry.S
@@ -24,8 +24,8 @@
 ENTRY(do_vfp)
 	inc_preempt_count r10, r4
  	ldr	r4, .LCvfp
-	ldr	r11, [r10, #TI_CPU]	@ CPU number
-	add	r10, r10, #TI_VFPSTATE	@ r10 = workspace
+	ldr	r11, [r10, #TSK_CPU]	@ CPU number
+	add	r10, r10, #TSK_TI_VFPSTATE	@ r10 = workspace
 	ldr	pc, [r4]		@ call VFP entry point
 ENDPROC(do_vfp)
 
diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 2cb355c1b5b7..4e2707fba8fd 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -143,22 +143,22 @@ static void vfp_thread_copy(struct thread_info *thread)
  *  THREAD_NOFTIFY_SWTICH:
  *   - the previously running thread will not be scheduled onto another CPU.
  *   - the next thread to be run (v) will not be running on another CPU.
- *   - thread->cpu is the local CPU number
+ *   - tsk->cpu is the local CPU number
  *   - not preemptible as we're called in the middle of a thread switch
  *  THREAD_NOTIFY_FLUSH:
  *   - the thread (v) will be running on the local CPU, so
- *	v === current_thread_info()
- *   - thread->cpu is the local CPU number at the time it is accessed,
+ *	v === current
+ *   - tsk->cpu is the local CPU number at the time it is accessed,
  *	but may change at any time.
  *   - we could be preempted if tree preempt rcu is enabled, so
- *	it is unsafe to use thread->cpu.
+ *	it is unsafe to use tsk->cpu.
  *  THREAD_NOTIFY_EXIT
  *   - we could be preempted if tree preempt rcu is enabled, so
- *	it is unsafe to use thread->cpu.
+ *	it is unsafe to use tsk->cpu.
  */
 static int vfp_notifier(struct notifier_block *self, unsigned long cmd, void *v)
 {
-	struct thread_info *thread = v;
+	struct task_struct *tsk = v;
 	u32 fpexc;
 #ifdef CONFIG_SMP
 	unsigned int cpu;
@@ -169,7 +169,7 @@ static int vfp_notifier(struct notifier_block *self, unsigned long cmd, void *v)
 		fpexc = fmrx(FPEXC);
 
 #ifdef CONFIG_SMP
-		cpu = thread->cpu;
+		cpu = tsk->cpu;
 
 		/*
 		 * On SMP, if VFP is enabled, save the old state in
@@ -188,15 +188,15 @@ static int vfp_notifier(struct notifier_block *self, unsigned long cmd, void *v)
 		break;
 
 	case THREAD_NOTIFY_FLUSH:
-		vfp_thread_flush(thread);
+		vfp_thread_flush(&tsk->thread_info);
 		break;
 
 	case THREAD_NOTIFY_EXIT:
-		vfp_thread_exit(thread);
+		vfp_thread_exit(&tsk->thread_info);
 		break;
 
 	case THREAD_NOTIFY_COPY:
-		vfp_thread_copy(thread);
+		vfp_thread_copy(&tsk->thread_info);
 		break;
 	}
 
@@ -448,26 +448,25 @@ void __init vfp_disable(void)
 #ifdef CONFIG_CPU_PM
 static int vfp_pm_suspend(void)
 {
-	struct thread_info *ti = current_thread_info();
 	u32 fpexc = fmrx(FPEXC);
 
 	/* if vfp is on, then save state for resumption */
 	if (fpexc & FPEXC_EN) {
 		pr_debug("%s: saving vfp state\n", __func__);
-		vfp_save_state(&ti->vfpstate, fpexc);
+		vfp_save_state(&current->thread_info.vfpstate, fpexc);
 
 		/* disable, just in case */
 		fmxr(FPEXC, fmrx(FPEXC) & ~FPEXC_EN);
-	} else if (vfp_current_hw_state[ti->cpu]) {
+	} else if (vfp_current_hw_state[current->cpu]) {
 #ifndef CONFIG_SMP
 		fmxr(FPEXC, fpexc | FPEXC_EN);
-		vfp_save_state(vfp_current_hw_state[ti->cpu], fpexc);
+		vfp_save_state(vfp_current_hw_state[current->cpu], fpexc);
 		fmxr(FPEXC, fpexc);
 #endif
 	}
 
 	/* clear any information we had about last context state */
-	vfp_current_hw_state[ti->cpu] = NULL;
+	vfp_current_hw_state[current->cpu] = NULL;
 
 	return 0;
 }
-- 
2.33.0

