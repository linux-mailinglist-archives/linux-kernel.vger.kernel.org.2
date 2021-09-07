Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039604030A3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 00:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347855AbhIGWCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 18:02:00 -0400
Received: from home.keithp.com ([63.227.221.253]:56256 "EHLO elaine.keithp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347495AbhIGWBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 18:01:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by elaine.keithp.com (Postfix) with ESMTP id 263123F30864;
        Tue,  7 Sep 2021 15:00:20 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
        by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id uccwbHGFUJ_y; Tue,  7 Sep 2021 15:00:19 -0700 (PDT)
Received: from keithp.com (168-103-156-98.tukw.qwest.net [168.103.156.98])
        by elaine.keithp.com (Postfix) with ESMTPSA id 655EA3F30861;
        Tue,  7 Sep 2021 15:00:19 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1000)
        id DED9A1E6013C; Tue,  7 Sep 2021 15:00:40 -0700 (PDT)
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
Subject: [PATCH 6/7] ARM: Use TPIDRPRW for current
Date:   Tue,  7 Sep 2021 15:00:37 -0700
Message-Id: <20210907220038.91021-7-keithpac@amazon.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210907220038.91021-1-keithpac@amazon.com>
References: <20210904060908.1310204-1-keithp@keithp.com>
 <20210907220038.91021-1-keithpac@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Store current task pointer in CPU thread ID register TPIDRPRW so that
accessing it doesn't depend on being able to locate thread_info off of
the kernel stack pointer.

Signed-off-by: Keith Packard <keithpac@amazon.com>
---
 arch/arm/Kconfig                 |  4 +++
 arch/arm/include/asm/assembler.h |  8 +++++
 arch/arm/include/asm/current.h   | 52 ++++++++++++++++++++++++++++++++
 arch/arm/kernel/entry-armv.S     |  4 +++
 arch/arm/kernel/setup.c          |  1 +
 arch/arm/kernel/smp.c            |  1 +
 6 files changed, 70 insertions(+)
 create mode 100644 arch/arm/include/asm/current.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 24804f11302d..414fe23fd5ac 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1172,6 +1172,10 @@ config SMP_ON_UP
 
 	  If you don't know what to do here, say Y.
 
+config CURRENT_POINTER_IN_TPIDRPRW
+	def_bool y
+	depends on (CPU_V6K || CPU_V7) && !CPU_V6
+
 config ARM_CPU_TOPOLOGY
 	bool "Support cpu topology definition"
 	depends on SMP && CPU_V7
diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index e2b1fd558bf3..ea12fe3bb589 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -209,6 +209,14 @@
 	mov	\rd, \rd, lsl #THREAD_SIZE_ORDER + PAGE_SHIFT
 	.endm
 
+/*
+ * Set current task_info
+ * @src: Source register containing task_struct pointer
+ */
+	.macro	set_current src : req
+	mcr	p15, 0, \src, c13, c0, 4
+	.endm
+
 /*
  * Increment/decrement the preempt count.
  */
diff --git a/arch/arm/include/asm/current.h b/arch/arm/include/asm/current.h
new file mode 100644
index 000000000000..153a2ea18747
--- /dev/null
+++ b/arch/arm/include/asm/current.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright © 2021 Keith Packard <keithp@keithp.com>
+ */
+
+#ifndef _ASM_ARM_CURRENT_H_
+#define _ASM_ARM_CURRENT_H_
+
+#ifndef __ASSEMBLY__
+
+register unsigned long current_stack_pointer asm ("sp");
+
+/*
+ * Same as asm-generic/current.h, except that we store current
+ * in TPIDRPRW. TPIDRPRW only exists on V6K and V7
+ */
+#ifdef CONFIG_CURRENT_POINTER_IN_TPIDRPRW
+
+struct task_struct;
+
+static inline void set_current(struct task_struct *tsk)
+{
+	/* Set TPIDRPRW */
+	asm volatile("mcr p15, 0, %0, c13, c0, 4" : : "r" (tsk) : "memory");
+}
+
+static __always_inline struct task_struct *get_current(void)
+{
+	struct task_struct *tsk;
+
+	/*
+	 * Read TPIDRPRW.
+	 * We want to allow caching the value, so avoid using volatile and
+	 * instead use a fake stack read to hazard against barrier().
+	 */
+	asm("mrc p15, 0, %0, c13, c0, 4" : "=r" (tsk)
+		: "Q" (*(const unsigned long *)current_stack_pointer));
+
+	return tsk;
+}
+#define current get_current()
+#else
+
+#define set_current(tsk) do {} while (0)
+
+#include <asm-generic/current.h>
+
+#endif /* CONFIG_SMP */
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_ARM_CURRENT_H_ */
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 0ea8529a4872..db3947ee9c3e 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -761,6 +761,10 @@ ENTRY(__switch_to)
 	ldr	r6, [r2, #TI_CPU_DOMAIN]
 #endif
 	switch_tls r1, r4, r5, r3, r7
+#ifdef CONFIG_CURRENT_POINTER_IN_TPIDRPRW
+	ldr	r7, [r2, #TI_TASK]
+	set_current r7
+#endif
 #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_SMP)
 	ldr	r7, [r2, #TI_TASK]
 	ldr	r8, =__stack_chk_guard
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index d0dc60afe54f..2fdf8c31d6c9 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -586,6 +586,7 @@ void __init smp_setup_processor_id(void)
 	u32 mpidr = is_smp() ? read_cpuid_mpidr() & MPIDR_HWID_BITMASK : 0;
 	u32 cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
 
+	set_current(&init_task);
 	cpu_logical_map(0) = cpu;
 	for (i = 1; i < nr_cpu_ids; ++i)
 		cpu_logical_map(i) = i == cpu ? 0 : i;
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 8ccf10b34f08..09771916442a 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -410,6 +410,7 @@ asmlinkage void secondary_start_kernel(unsigned int cpu, struct task_struct *tas
 {
 	struct mm_struct *mm = &init_mm;
 
+	set_current(task);
 	secondary_biglittle_init();
 
 	/*
-- 
2.33.0

