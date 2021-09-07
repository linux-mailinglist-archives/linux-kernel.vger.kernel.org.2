Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15B54030A6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 00:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347672AbhIGWCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 18:02:05 -0400
Received: from home.keithp.com ([63.227.221.253]:56072 "EHLO elaine.keithp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344772AbhIGWB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 18:01:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by elaine.keithp.com (Postfix) with ESMTP id 977CB3F30865;
        Tue,  7 Sep 2021 15:00:20 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
        by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 8zM7JNQ355Md; Tue,  7 Sep 2021 15:00:20 -0700 (PDT)
Received: from keithp.com (168-103-156-98.tukw.qwest.net [168.103.156.98])
        by elaine.keithp.com (Postfix) with ESMTPSA id 7AF273F30868;
        Tue,  7 Sep 2021 15:00:19 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1000)
        id DB4811E6013B; Tue,  7 Sep 2021 15:00:40 -0700 (PDT)
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
Subject: [PATCH 5/7] ARM: Stop using TPIDRPRW to hold per_cpu_offset
Date:   Tue,  7 Sep 2021 15:00:36 -0700
Message-Id: <20210907220038.91021-6-keithpac@amazon.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210907220038.91021-1-keithpac@amazon.com>
References: <20210904060908.1310204-1-keithp@keithp.com>
 <20210907220038.91021-1-keithpac@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're going to store TPIDRPRW here instead

Signed-off-by: Keith Packard <keithpac@amazon.com>
---
 arch/arm/include/asm/percpu.h | 31 -------------------------------
 arch/arm/kernel/setup.c       |  7 -------
 arch/arm/kernel/smp.c         |  3 ---
 3 files changed, 41 deletions(-)

diff --git a/arch/arm/include/asm/percpu.h b/arch/arm/include/asm/percpu.h
index e2fcb3cfd3de..eeafcd6a3e01 100644
--- a/arch/arm/include/asm/percpu.h
+++ b/arch/arm/include/asm/percpu.h
@@ -7,37 +7,6 @@
 
 register unsigned long current_stack_pointer asm ("sp");
 
-/*
- * Same as asm-generic/percpu.h, except that we store the per cpu offset
- * in the TPIDRPRW. TPIDRPRW only exists on V6K and V7
- */
-#if defined(CONFIG_SMP) && !defined(CONFIG_CPU_V6)
-static inline void set_my_cpu_offset(unsigned long off)
-{
-	/* Set TPIDRPRW */
-	asm volatile("mcr p15, 0, %0, c13, c0, 4" : : "r" (off) : "memory");
-}
-
-static inline unsigned long __my_cpu_offset(void)
-{
-	unsigned long off;
-
-	/*
-	 * Read TPIDRPRW.
-	 * We want to allow caching the value, so avoid using volatile and
-	 * instead use a fake stack read to hazard against barrier().
-	 */
-	asm("mrc p15, 0, %0, c13, c0, 4" : "=r" (off)
-		: "Q" (*(const unsigned long *)current_stack_pointer));
-
-	return off;
-}
-#define __my_cpu_offset __my_cpu_offset()
-#else
-#define set_my_cpu_offset(x)	do {} while(0)
-
-#endif /* CONFIG_SMP */
-
 #include <asm-generic/percpu.h>
 
 #endif /* _ASM_ARM_PERCPU_H_ */
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index ca0201635fac..d0dc60afe54f 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -590,13 +590,6 @@ void __init smp_setup_processor_id(void)
 	for (i = 1; i < nr_cpu_ids; ++i)
 		cpu_logical_map(i) = i == cpu ? 0 : i;
 
-	/*
-	 * clear __my_cpu_offset on boot CPU to avoid hang caused by
-	 * using percpu variable early, for example, lockdep will
-	 * access percpu variable inside lock_release
-	 */
-	set_my_cpu_offset(0);
-
 	pr_info("Booting Linux on physical CPU 0x%x\n", mpidr);
 }
 
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 5e999f1f1aea..8ccf10b34f08 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -410,8 +410,6 @@ asmlinkage void secondary_start_kernel(unsigned int cpu, struct task_struct *tas
 {
 	struct mm_struct *mm = &init_mm;
 
-	set_my_cpu_offset(per_cpu_offset(cpu));
-
 	secondary_biglittle_init();
 
 	/*
@@ -495,7 +493,6 @@ void __init smp_cpus_done(unsigned int max_cpus)
 
 void __init smp_prepare_boot_cpu(void)
 {
-	set_my_cpu_offset(per_cpu_offset(smp_processor_id()));
 }
 
 void __init smp_prepare_cpus(unsigned int max_cpus)
-- 
2.33.0

