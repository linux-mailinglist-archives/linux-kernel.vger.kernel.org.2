Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69AED3BEC4F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 18:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhGGQg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 12:36:26 -0400
Received: from foss.arm.com ([217.140.110.172]:40622 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229975AbhGGQgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 12:36:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 236511042;
        Wed,  7 Jul 2021 09:33:44 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AB1CE3F694;
        Wed,  7 Jul 2021 09:33:42 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] s390: preempt: Fix preempt_count initialization
Date:   Wed,  7 Jul 2021 17:33:38 +0100
Message-Id: <20210707163338.1623014-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

S390's init_idle_preempt_count(p, cpu) doesn't actually let us initialize the
preempt_count of the requested CPU's idle task: it unconditionally writes
to the current CPU's. This clearly conflicts with idle_threads_init(),
which intends to initialize *all* the idle tasks, including their
preempt_count (or their CPU's, if the arch uses a per-CPU preempt_count).

Unfortunately, it seems the way s390 does things doesn't let us initialize
every possible CPU's preempt_count early on, as the pages where this
resides are only allocated when a CPU is brought up and are freed when it
is brought down.

Let the arch-specific code set a CPU's preempt_count when its lowcore is
allocated, and turn init_idle_preempt_count() into an empty stub.

Fixes: f1a0a376ca0c ("sched/core: Initialize the idle task with preemption disabled")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 arch/s390/include/asm/preempt.h | 16 ++++------------
 arch/s390/kernel/setup.c        |  1 +
 arch/s390/kernel/smp.c          |  1 +
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/s390/include/asm/preempt.h b/arch/s390/include/asm/preempt.h
index 23ff51be7e29..d9d5350cc3ec 100644
--- a/arch/s390/include/asm/preempt.h
+++ b/arch/s390/include/asm/preempt.h
@@ -29,12 +29,6 @@ static inline void preempt_count_set(int pc)
 				  old, new) != old);
 }
 
-#define init_task_preempt_count(p)	do { } while (0)
-
-#define init_idle_preempt_count(p, cpu)	do { \
-	S390_lowcore.preempt_count = PREEMPT_DISABLED; \
-} while (0)
-
 static inline void set_preempt_need_resched(void)
 {
 	__atomic_and(~PREEMPT_NEED_RESCHED, &S390_lowcore.preempt_count);
@@ -88,12 +82,6 @@ static inline void preempt_count_set(int pc)
 	S390_lowcore.preempt_count = pc;
 }
 
-#define init_task_preempt_count(p)	do { } while (0)
-
-#define init_idle_preempt_count(p, cpu)	do { \
-	S390_lowcore.preempt_count = PREEMPT_DISABLED; \
-} while (0)
-
 static inline void set_preempt_need_resched(void)
 {
 }
@@ -130,6 +118,10 @@ static inline bool should_resched(int preempt_offset)
 
 #endif /* CONFIG_HAVE_MARCH_Z196_FEATURES */
 
+#define init_task_preempt_count(p)	do { } while (0)
+/* Deferred to CPU bringup time */
+#define init_idle_preempt_count(p, cpu)	do { } while (0)
+
 #ifdef CONFIG_PREEMPTION
 extern void preempt_schedule(void);
 #define __preempt_schedule() preempt_schedule()
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 5aab59ad5688..382d73da134c 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -466,6 +466,7 @@ static void __init setup_lowcore_dat_off(void)
 	lc->br_r1_trampoline = 0x07f1;	/* br %r1 */
 	lc->return_lpswe = gen_lpswe(__LC_RETURN_PSW);
 	lc->return_mcck_lpswe = gen_lpswe(__LC_RETURN_MCCK_PSW);
+	lc->preempt_count = PREEMPT_DISABLED;
 
 	set_prefix((u32)(unsigned long) lc);
 	lowcore_ptr[0] = lc;
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 111909aeb8d2..1fb483e06a64 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -219,6 +219,7 @@ static int pcpu_alloc_lowcore(struct pcpu *pcpu, int cpu)
 	lc->br_r1_trampoline = 0x07f1;	/* br %r1 */
 	lc->return_lpswe = gen_lpswe(__LC_RETURN_PSW);
 	lc->return_mcck_lpswe = gen_lpswe(__LC_RETURN_MCCK_PSW);
+	lc->preempt_count = PREEMPT_DISABLED;
 	if (nmi_alloc_per_cpu(lc))
 		goto out_stack;
 	lowcore_ptr[cpu] = lc;
-- 
2.25.1

