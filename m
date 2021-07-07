Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D033BEF5D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 20:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbhGGSmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 14:42:01 -0400
Received: from foss.arm.com ([217.140.110.172]:42912 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232460AbhGGSlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 14:41:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7CE11042;
        Wed,  7 Jul 2021 11:38:38 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5F5F93F694;
        Wed,  7 Jul 2021 11:38:37 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc: preempt: Don't touch the idle task's preempt_count during hotplug
Date:   Wed,  7 Jul 2021 19:38:31 +0100
Message-Id: <20210707183831.2106509-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Powerpc currently resets a CPU's idle task preempt_count to 0 before said
task starts executing the secondary startup routine (and becomes an idle
task proper).

This conflicts with commit

  f1a0a376ca0c ("sched/core: Initialize the idle task with preemption disabled")

which initializes all of the idle tasks' preempt_count to PREEMPT_DISABLED
during smp_init(). Note that this was superfluous before said commit, as
back then the hotplug machinery would invoke init_idle() via
idle_thread_get(), which would have already reset the CPU's idle task's
preempt_count to PREEMPT_ENABLED.

Get rid of this preempt_count write.

Cc: Guenter Roeck <linux@roeck-us.net>
Fixes: f1a0a376ca0c ("sched/core: Initialize the idle task with preemption disabled")
Reported-by: Bharata B Rao <bharata@linux.ibm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 arch/powerpc/platforms/cell/smp.c    | 3 ---
 arch/powerpc/platforms/pseries/smp.c | 5 +----
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/cell/smp.c b/arch/powerpc/platforms/cell/smp.c
index c855a0aeb49c..d7ab868aab54 100644
--- a/arch/powerpc/platforms/cell/smp.c
+++ b/arch/powerpc/platforms/cell/smp.c
@@ -78,9 +78,6 @@ static inline int smp_startup_cpu(unsigned int lcpu)
 
 	pcpu = get_hard_smp_processor_id(lcpu);
 
-	/* Fixup atomic count: it exited inside IRQ handler. */
-	task_thread_info(paca_ptrs[lcpu]->__current)->preempt_count	= 0;
-
 	/*
 	 * If the RTAS start-cpu token does not exist then presume the
 	 * cpu is already spinning.
diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index 096629f54576..7ebf3382816a 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -105,10 +105,7 @@ static inline int smp_startup_cpu(unsigned int lcpu)
 		return 1;
 	}
 
-	/* Fixup atomic count: it exited inside IRQ handler. */
-	task_thread_info(paca_ptrs[lcpu]->__current)->preempt_count	= 0;
-
-	/* 
+	/*
 	 * If the RTAS start-cpu token does not exist then presume the
 	 * cpu is already spinning.
 	 */
-- 
2.25.1

