Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876404030A5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 00:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347648AbhIGWCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 18:02:03 -0400
Received: from home.keithp.com ([63.227.221.253]:56300 "EHLO elaine.keithp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347559AbhIGWBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 18:01:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by elaine.keithp.com (Postfix) with ESMTP id 9155B3F30861;
        Tue,  7 Sep 2021 15:00:20 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
        by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id cyWcFQXC8t4y; Tue,  7 Sep 2021 15:00:20 -0700 (PDT)
Received: from keithp.com (168-103-156-98.tukw.qwest.net [168.103.156.98])
        by elaine.keithp.com (Postfix) with ESMTPSA id 71C3F3F30862;
        Tue,  7 Sep 2021 15:00:19 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1000)
        id E25F31E6013D; Tue,  7 Sep 2021 15:00:40 -0700 (PDT)
From:   Keith Packard <keithpac@amazon.com>
To:     linux-kernel@vger.kernel.org
Cc:     Abbott Liu <liuwenliang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Christoph Lameter <cl@linux.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jens Axboe <axboe@kernel.dk>, Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        Keith Packard <keithpac@amazon.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Russell King <linux@armlinux.org.uk>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Wolfram Sang (Renesas)" <wsa+renesas@sang-engineering.com>,
        YiFei Zhu <yifeifz2@illinois.edu>
Subject: [PATCH 7/7] ARM: Move thread_info into task_struct (v7 only)
Date:   Tue,  7 Sep 2021 15:00:38 -0700
Message-Id: <20210907220038.91021-8-keithpac@amazon.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210907220038.91021-1-keithpac@amazon.com>
References: <20210904060908.1310204-1-keithp@keithp.com>
 <20210907220038.91021-1-keithpac@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This avoids many stack overflow attacks which modified the thread_info
structure by moving that into the task_struct as is done is almost all
other architectures.

This depends on having 'current' stored in the TPIDRPRW register as
that allows us to find thread_info and task_struct once the
thread_info cannot be located using the kernel stack pointer.

Signed-off-by: Keith Packard <keithpac@amazon.com>
---
 arch/arm/Kconfig                   |  1 +
 arch/arm/include/asm/assembler.h   |  4 ++++
 arch/arm/include/asm/thread_info.h | 12 +++++++++++-
 arch/arm/kernel/asm-offsets.c      |  4 ++++
 arch/arm/kernel/entry-armv.S       |  4 ++++
 arch/arm/vfp/vfpmodule.c           |  9 +++++++++
 6 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 414fe23fd5ac..5846b4f5444b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -128,6 +128,7 @@ config ARM
 	select RTC_LIB
 	select SET_FS
 	select SYS_SUPPORTS_APM_EMULATION
+	select THREAD_INFO_IN_TASK if CURRENT_POINTER_IN_TPIDRPRW
 	# Above selects are sorted alphabetically; please add new ones
 	# according to that.  Thanks.
 	help
diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index ea12fe3bb589..b23d2b87184a 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -203,10 +203,14 @@
  * Get current thread_info.
  */
 	.macro	get_thread_info, rd
+#ifdef CONFIG_THREAD_INFO_IN_TASK
+	mrc	p15, 0, \rd, c13, c0, 4
+#else
  ARM(	mov	\rd, sp, lsr #THREAD_SIZE_ORDER + PAGE_SHIFT	)
  THUMB(	mov	\rd, sp			)
  THUMB(	lsr	\rd, \rd, #THREAD_SIZE_ORDER + PAGE_SHIFT	)
 	mov	\rd, \rd, lsl #THREAD_SIZE_ORDER + PAGE_SHIFT
+#endif
 	.endm
 
 /*
diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 70d4cbc49ae1..6b67703ca16a 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -55,8 +55,10 @@ struct thread_info {
 	unsigned long		flags;		/* low level flags */
 	int			preempt_count;	/* 0 => preemptable, <0 => bug */
 	mm_segment_t		addr_limit;	/* address limit */
+#ifndef CONFIG_THREAD_INFO_IN_TASK
 	struct task_struct	*task;		/* main task structure */
 	__u32			cpu;		/* cpu */
+#endif
 	__u32			cpu_domain;	/* cpu domain */
 #ifdef CONFIG_STACKPROTECTOR_PER_TASK
 	unsigned long		stack_canary;
@@ -75,14 +77,21 @@ struct thread_info {
 #endif
 };
 
+#ifdef CONFIG_THREAD_INFO_IN_TASK
+#define INIT_THREAD_INFO_TASK(tsk)
+#else
+#define INIT_THREAD_INFO_TASK(tsk) .task = &tsk,
+#endif
+
 #define INIT_THREAD_INFO(tsk)						\
 {									\
-	.task		= &tsk,						\
+	INIT_THREAD_INFO_TASK(tsk)					\
 	.flags		= 0,						\
 	.preempt_count	= INIT_PREEMPT_COUNT,				\
 	.addr_limit	= KERNEL_DS,					\
 }
 
+#ifndef CONFIG_THREAD_INFO_IN_TASK
 /*
  * how to get the thread information struct from C
  */
@@ -93,6 +102,7 @@ static inline struct thread_info *current_thread_info(void)
 	return (struct thread_info *)
 		(current_stack_pointer & ~(THREAD_SIZE - 1));
 }
+#endif
 
 #define thread_saved_pc(tsk)	\
 	((unsigned long)(task_thread_info(tsk)->cpu_context.pc))
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 70993af22d80..2a6745f7423e 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -44,8 +44,12 @@ int main(void)
   DEFINE(TI_FLAGS,		offsetof(struct thread_info, flags));
   DEFINE(TI_PREEMPT,		offsetof(struct thread_info, preempt_count));
   DEFINE(TI_ADDR_LIMIT,		offsetof(struct thread_info, addr_limit));
+#ifdef CONFIG_THREAD_INFO_IN_TASK
+  DEFINE(TI_CPU,		offsetof(struct task_struct, cpu));
+#else
   DEFINE(TI_TASK,		offsetof(struct thread_info, task));
   DEFINE(TI_CPU,		offsetof(struct thread_info, cpu));
+#endif
   DEFINE(TI_CPU_DOMAIN,		offsetof(struct thread_info, cpu_domain));
   DEFINE(TI_CPU_SAVE,		offsetof(struct thread_info, cpu_context));
   DEFINE(TI_USED_CP,		offsetof(struct thread_info, used_cp));
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index db3947ee9c3e..5ae687c8c7b8 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -762,9 +762,13 @@ ENTRY(__switch_to)
 #endif
 	switch_tls r1, r4, r5, r3, r7
 #ifdef CONFIG_CURRENT_POINTER_IN_TPIDRPRW
+#ifdef CONFIG_THREAD_INFO_IN_TASK
+	set_current r2
+#else
 	ldr	r7, [r2, #TI_TASK]
 	set_current r7
 #endif
+#endif
 #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_SMP)
 	ldr	r7, [r2, #TI_TASK]
 	ldr	r8, =__stack_chk_guard
diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index d7a3818da671..84a691da59fa 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -158,7 +158,12 @@ static void vfp_thread_copy(struct thread_info *thread)
  */
 static int vfp_notifier(struct notifier_block *self, unsigned long cmd, void *v)
 {
+#ifdef CONFIG_THREAD_INFO_IN_TASK
+	struct task_struct *tsk = v;
+	struct thread_info *thread = &tsk->thread_info;
+#else
 	struct thread_info *thread = v;
+#endif
 	u32 fpexc;
 #ifdef CONFIG_SMP
 	unsigned int cpu;
@@ -169,7 +174,11 @@ static int vfp_notifier(struct notifier_block *self, unsigned long cmd, void *v)
 		fpexc = fmrx(FPEXC);
 
 #ifdef CONFIG_SMP
+#ifdef CONFIG_THREAD_INFO_IN_TASK
+		cpu = tsk->cpu;
+#else
 		cpu = thread->cpu;
+#endif
 
 		/*
 		 * On SMP, if VFP is enabled, save the old state in
-- 
2.33.0

