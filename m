Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C2F4009FE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 08:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbhIDGKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 02:10:25 -0400
Received: from home.keithp.com ([63.227.221.253]:36028 "EHLO elaine.keithp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232700AbhIDGKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 02:10:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by elaine.keithp.com (Postfix) with ESMTP id ADD2C3F30823;
        Fri,  3 Sep 2021 23:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
        t=1630735729; bh=r0xjnWX8kE9bb/74dzYlSkCXEjBA3QT3WBW2iIime7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pqt0z1tTN3RLmjPMQ5LHxjjAOdPSkz3USC0JCSyxVLg+2M3oOmkdjlhQluRSQPScG
         s/fmocrSKNlql2MlaTQhVYscrst/H2R0PPKFhaaayAqxXPh5BzzZ4Azorl6AwBQTkH
         dNm3IwfN5cjwt4mSittOfURqyjbhJmIkCu95rcC1Qr4mX8aFConRJblXLtidZi87Mf
         /reDINIS0nq9jQmBmLtWDnNgf2R08rvYQQauB2qit530t0ytISzs9FVyDHKWwsJmTn
         uRRBNoRyb5zWyF/QvMcNjVoPexAEAbyFtPPQ/l1biB2Gqf+nbfAmRxRQp2nZQf+r7T
         EEoY1BTWegqPw==
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
        by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 2EHHIQER57nx; Fri,  3 Sep 2021 23:08:49 -0700 (PDT)
Received: from keithp.com (168-103-156-98.tukw.qwest.net [168.103.156.98])
        by elaine.keithp.com (Postfix) with ESMTPSA id 83D483F30825;
        Fri,  3 Sep 2021 23:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
        t=1630735728; bh=r0xjnWX8kE9bb/74dzYlSkCXEjBA3QT3WBW2iIime7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GORCUsDp4XKT5V6v7owTa9dWXyGtLChRZ6ObQkydLY7xVt4SLludDB4sUBy9598CH
         XnZEvWUBgmptcGCc8R8oZKCWCi5WukDASW4OEhg2wtX/6yO1zMb+PxMVsW83ExQSNL
         k6tfrWrRlrjM8F8UpafdwONfrJdT/CmcoNjlLtbw4z9P1DeAqFAPcuJrkxh801NhnN
         iNXo23wB9cAUksIstJd67ftSDkJYT0ZKMdb3na/oRs58ezwJh6KCSsqDX9NOZUS3nb
         05/oR6KBQtPzAkXrom5jSQcVklqEQM8uq0WY/rbfbFskMCPBvPVF24fHpniy3iCJmG
         R0QJdU6zPT4+g==
Received: by keithp.com (Postfix, from userid 1000)
        id 7FA051E6013D; Fri,  3 Sep 2021 23:09:10 -0700 (PDT)
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
Subject: [PATCH 3/3] ARM: Add per-cpu variable cpu_number (v7 only)
Date:   Fri,  3 Sep 2021 23:09:08 -0700
Message-Id: <20210904060908.1310204-4-keithp@keithp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904060908.1310204-1-keithp@keithp.com>
References: <20210902155429.3987201-1-keithp@keithp.com>
 <20210904060908.1310204-1-keithp@keithp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Holds the cpu value for each cpu to make accessing this variable more
efficient than fetching the current task struct and pulling the cpu
value from there.

This code is only enabled when THREAD_INFO_IN_TASK is selected, which
is currently only enabled for v7 hardware.

Signed-off-by: Keith Packard <keithpac@amazon.com>
---
 arch/arm/Makefile          |  8 --------
 arch/arm/include/asm/smp.h | 17 +++--------------
 arch/arm/kernel/smp.c      | 16 ++++++++++++++++
 3 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 71a2ba4549d3..415c3514573a 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -284,14 +284,6 @@ stack_protector_prepare: prepare0
 	$(eval GCC_PLUGINS_CFLAGS += $(SSP_PLUGIN_CFLAGS))
 endif
 
-ifdef CONFIG_SMP
-prepare: task_cpu_prepare
-
-PHONY += task_cpu_prepare
-task_cpu_prepare: prepare0
-	$(eval KBUILD_CFLAGS += -D_TSK_CPU=$(shell awk '{if ($$2 == "TSK_CPU") print $$3;}' include/generated/asm-offsets.h))
-endif
-
 all:	$(notdir $(KBUILD_IMAGE))
 
 
diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 1c38d1fde641..67d21233bdfe 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -16,21 +16,10 @@
 #endif
 
 #ifdef CONFIG_THREAD_INFO_IN_TASK
-/*
- * This is particularly ugly: it appears we can't actually get the definition
- * of task_struct here, but we need access to the CPU this task is running on.
- * Instead of using task_struct we're using TSK_CPU which is extracted from
- * asm-offsets.h by kbuild to get the current processor ID.
- *
- * This also needs to be safeguarded when building asm-offsets.s because at
- * that time TSK_CPU is not defined yet.
- */
-#ifndef _TSK_CPU
-#define raw_smp_processor_id()		(0)
-#else
-#define raw_smp_processor_id()		(*(unsigned int *)((void *)current + _TSK_CPU))
-#endif
+#define raw_smp_processor_id() this_cpu_read(cpu_number)
+#define __smp_processor_id() __this_cpu_read(cpu_number)
 
+DECLARE_PER_CPU_READ_MOSTLY(unsigned int, cpu_number);
 #else
 #define raw_smp_processor_id() (current_thread_info()->cpu)
 #endif
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index be0ede16dbb1..a33397618f1e 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -56,6 +56,8 @@ DEFINE_PER_CPU(struct task_struct *, current_task) ____cacheline_aligned =
 	&init_task;
 EXPORT_PER_CPU_SYMBOL(current_task);
 
+DEFINE_PER_CPU_READ_MOSTLY(unsigned int, cpu_number);
+EXPORT_PER_CPU_SYMBOL(cpu_number);
 #endif
 
 /*
@@ -510,6 +512,9 @@ void __init smp_prepare_boot_cpu(void)
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 	unsigned int ncores = num_possible_cpus();
+#ifdef CONFIG_THREAD_INFO_IN_TASK
+	unsigned int cpu;
+#endif
 
 	init_cpu_topology();
 
@@ -521,6 +526,17 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	if (max_cpus > ncores)
 		max_cpus = ncores;
 
+#ifdef CONFIG_THREAD_INFO_IN_TASK
+	/*
+	 * Initialize the cpu_number value for each cpu before we
+	 * start it. This ensures that the value is valid during cpu
+	 * initialization, even before the idle task_struct cpu member
+	 * is set
+	 */
+	for_each_possible_cpu(cpu)
+		per_cpu(cpu_number, cpu) = cpu;
+#endif
+
 	if (ncores > 1 && max_cpus) {
 		/*
 		 * Initialise the present map, which describes the set of CPUs
-- 
2.33.0

