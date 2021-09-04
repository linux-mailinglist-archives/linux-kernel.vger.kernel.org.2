Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4FD4009FC
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 08:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbhIDGKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 02:10:15 -0400
Received: from home.keithp.com ([63.227.221.253]:35976 "EHLO elaine.keithp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229741AbhIDGKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 02:10:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by elaine.keithp.com (Postfix) with ESMTP id 15FF63F30827;
        Fri,  3 Sep 2021 23:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
        t=1630735729; bh=PmftFApdBNNqz89hFQkVDDliTNHU+BbcKqGZIu6pgHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EF9XhzVKGIkiYRU7dczV4cfv/RYKUIbeKCtV3OsuSpInmr+st8exiLGdt8YPlo7eD
         dyGaidd5tUISfgWlK6/KRvLcMqSG66+5tL/6RBFDohGCO4qd74CNnVl9em+ZqT+hXV
         J9CMD/VSNZqWGnTfSi8k86Pt0taSxUXD2Clc/rBw02yTftKQqOA5SLMiz9solaka/a
         XsUteZ7IST0l55HFEyhkRfqR0pHP4u1tvA1hKWyafU8m4nV03RHI90sJXW0hM5YkhR
         /y9DeBpItEbrdqvH3roSf/N3wH+pWJCt+LEtT8I1fFDR1mBhmwaT16UdSQCKVbRYZs
         +lKdoPd+S6uxA==
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
        by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 25zMPoEb7fL1; Fri,  3 Sep 2021 23:08:48 -0700 (PDT)
Received: from keithp.com (168-103-156-98.tukw.qwest.net [168.103.156.98])
        by elaine.keithp.com (Postfix) with ESMTPSA id 6B6653F30824;
        Fri,  3 Sep 2021 23:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
        t=1630735728; bh=PmftFApdBNNqz89hFQkVDDliTNHU+BbcKqGZIu6pgHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MC+bvN8W+jWUvtmW7474jGVvNledzo4KDC8BNNJefY0zSDmkq5m4ZNJMqKdmw0VIV
         ZvHajcpJpMWpTjfB8AzOVi4PW2TgVSctuFFBD/rQBB/mSE4HHpmjy+Cs1d/B97Ywln
         a40ePfgjaxEnOOFUVaeFA1iejXnAm2WeEc8yE78MSWo6KpSO5LIQN40z3Zy7vh7rmk
         Rblslc+Nwff7ilo0rSm66xMPtYnzGiVBZoFhGWXXc6jv8tqZ1uIrMNVe3UvvQONbXM
         v9kWBYP1mBz1YP9x+4p2UJGKYdChWbWvCCcmOC8dscHV6Yl/LVCU7qdpSagC2lCNjW
         jbrDkUuwtG9nw==
Received: by keithp.com (Postfix, from userid 1000)
        id 7908B1E6013B; Fri,  3 Sep 2021 23:09:10 -0700 (PDT)
From:   Keith Packard <keithp@keithp.com>
To:     linux-kernel@vger.kernel.org
Cc:     Abbott Liu <liuwenliang@huawei.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
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
        Kees Cook <keescook@chromium.org>,
        Keith Packard <keithp@keithp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Wolfram Sang (Renesas)" <wsa+renesas@sang-engineering.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Keith Packard <keithpac@amazon.com>
Subject: [PATCH 1/3] ARM: Pass cpu number to secondary_start_kernel
Date:   Fri,  3 Sep 2021 23:09:06 -0700
Message-Id: <20210904060908.1310204-2-keithp@keithp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904060908.1310204-1-keithp@keithp.com>
References: <20210902155429.3987201-1-keithp@keithp.com>
 <20210904060908.1310204-1-keithp@keithp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of pulling the CPU value out of the thread_info struct, pass
it as an argument. When first initializing secondary processors, this
is done by stashing the value in the secondary_data struct. When
restarting idle processors, the previous CPU value is passed.

Because the cpu is now known at the top of secondary_start_kernel, the
per_cpu_offset value can now be set at this point, instead of in
cpu_init where it was also incorrectly setting the per_cpu_offset for
the boot processor before that value had been computed.

Signed-off-by: Keith Packard <keithpac@amazon.com>
---
 arch/arm/include/asm/smp.h   |  3 ++-
 arch/arm/kernel/head-nommu.S |  1 +
 arch/arm/kernel/head.S       |  1 +
 arch/arm/kernel/setup.c      |  6 ------
 arch/arm/kernel/smp.c        | 14 +++++++++-----
 5 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 5d508f5d56c4..86a7fd721556 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -48,7 +48,7 @@ extern void set_smp_ipi_range(int ipi_base, int nr_ipi);
  * Called from platform specific assembly code, this is the
  * secondary CPU entry point.
  */
-asmlinkage void secondary_start_kernel(void);
+asmlinkage void secondary_start_kernel(unsigned int cpu);
 
 
 /*
@@ -61,6 +61,7 @@ struct secondary_data {
 	};
 	unsigned long swapper_pg_dir;
 	void *stack;
+	unsigned int cpu;
 };
 extern struct secondary_data secondary_data;
 extern void secondary_startup(void);
diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index 0fc814bbc34b..5aa8ef42717f 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -114,6 +114,7 @@ ENTRY(secondary_startup)
 	add	r12, r12, r10
 	ret	r12
 1:	bl	__after_proc_init
+	ldr	r0, [r7, #16]			@ set up cpu number
 	ldr	sp, [r7, #12]			@ set up the stack pointer
 	mov	fp, #0
 	b	secondary_start_kernel
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 7f62c5eccdf3..0e541af738e2 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -394,6 +394,7 @@ ENDPROC(secondary_startup_arm)
 
 ENTRY(__secondary_switched)
 	ldr_l	r7, secondary_data + 12		@ get secondary_data.stack
+	ldr_l	r0, secondary_data + 16		@ get secondary_data.cpu
 	mov	sp, r7
 	mov	fp, #0
 	b	secondary_start_kernel
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 73ca7797b92f..ca0201635fac 100644
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
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 74679240a9d8..55cb1689a4b3 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -153,6 +153,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
 	secondary_data.pgdir = virt_to_phys(idmap_pgd);
 	secondary_data.swapper_pg_dir = get_arch_pgd(swapper_pg_dir);
 #endif
+	secondary_data.cpu = cpu;
 	sync_cache_w(&secondary_data);
 
 	/*
@@ -373,11 +374,14 @@ void arch_cpu_idle_dead(void)
 	 * cpu initialisation.  There's some initialisation which needs
 	 * to be repeated to undo the effects of taking the CPU offline.
 	 */
-	__asm__("mov	sp, %0\n"
+	__asm__("mov	r0, %1\n"
+	"	mov	sp, %0\n"
 	"	mov	fp, #0\n"
 	"	b	secondary_start_kernel"
 		:
-		: "r" (task_stack_page(current) + THREAD_SIZE - 8));
+		: "r" (task_stack_page(current) + THREAD_SIZE - 8),
+		  "r" (cpu)
+		: "r0");
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
@@ -400,10 +404,11 @@ static void smp_store_cpu_info(unsigned int cpuid)
  * This is the secondary CPU boot entry.  We're using this CPUs
  * idle thread stack, but a set of temporary page tables.
  */
-asmlinkage void secondary_start_kernel(void)
+asmlinkage void secondary_start_kernel(unsigned int cpu)
 {
 	struct mm_struct *mm = &init_mm;
-	unsigned int cpu;
+
+	set_my_cpu_offset(per_cpu_offset(cpu));
 
 	secondary_biglittle_init();
 
@@ -420,7 +425,6 @@ asmlinkage void secondary_start_kernel(void)
 	 * All kernel threads share the same mm context; grab a
 	 * reference and switch to it.
 	 */
-	cpu = smp_processor_id();
 	mmgrab(mm);
 	current->active_mm = mm;
 	cpumask_set_cpu(cpu, mm_cpumask(mm));
-- 
2.33.0

