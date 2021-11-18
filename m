Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A54455910
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 11:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245445AbhKRKcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 05:32:50 -0500
Received: from foss.arm.com ([217.140.110.172]:39198 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243723AbhKRKcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 05:32:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B84241FB;
        Thu, 18 Nov 2021 02:29:33 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7E6CE3F5A1;
        Thu, 18 Nov 2021 02:29:32 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, dvyukov@google.com, mark.rutland@arm.com,
        peterz@infradead.org, quic_qiancai@quicinc.com,
        valentin.schneider@arm.com, will@kernel.org, woodylin@google.com
Subject: [PATCH v2] Reset task stack state in bringup_cpu()
Date:   Thu, 18 Nov 2021 10:29:27 +0000
Message-Id: <20211118102927.4854-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To hot unplug a CPU, the idle task on that CPU calls a few layers of C
code before finally leaving the kernel. When KASAN is in use, poisoned
shadow is left around for each of the active stack frames, and when
shadow call stacks are in use. When shadow call stacks are in use the
task's saved SCS SP is left pointing at an arbitrary point within the
task's shadow call stack.

When a CPU is offlined than onlined back into the kernel, this stale
state can adversely affect execution. Stale KASAN shadow can alias new
stackframes and result in bogus KASAN warnings. A stale SCS SP is
effectively a memory leak, and prevents a portion of the shadow call
stack being used. Across a number of hotplug cycles the idle task's
entire shadow call stack can become unusable.

We previously fixed the KASAN issue in commit:

  e1b77c92981a5222 ("sched/kasan: remove stale KASAN poison after hotplug")

... by removing any stale KASAN stack poison immediately prior to
onlining a CPU.

Subsequently in commit:

  f1a0a376ca0c4ef1 ("sched/core: Initialize the idle task with preemption disabled")

... the refactoring left the KASAN and SCS cleanup in one-time idle
thread initialization code rather than something invoked prior to each
CPU being onlined, breaking both as above.

We fixed SCS (but not KASAN) in commit:

  63acd42c0d4942f7 ("sched/scs: Reset the shadow stack when idle_task_exit")

... but as this runs in the context of the idle task being offlined it's
potentially fragile.

To fix these consistently and more robustly, reset the SCS SP and KASAN
shadow of a CPU's idle task immediately before we online that CPU in
bringup_cpu(). This ensures the idle task always has a consistent state
when it is running, and removes the need to so so when exiting an idle
task.

Whenever any thread is created, dup_task_struct() will give the task a
stack which is free of KASAN shadow, and initialize the task's SCS SP,
so there's no need to specially initialize either for idle thread within
init_idle(), as this was only necessary to handle hotplug cycles.

I've tested this with both GCC and clang, with relevant options enabled,
offlining and onlining CPUs with:

| while true; do
|   for C in /sys/devices/system/cpu/cpu*/online; do
|     echo 0 > $C;
|     echo 1 > $C;
|   done
| done

Link: https://lore.kernel.org/lkml/20211012083521.973587-1-woodylin@google.com/
Link: https://lore.kernel.org/linux-arm-kernel/YY9ECKyPtDbD9q8q@qian-HP-Z2-SFF-G5-Workstation/
Link: https://lore.kernel.org/lkml/20211115113310.35693-1-mark.rutland@arm.com/
Fixes: 1a0a376ca0c4ef1 ("sched/core: Initialize the idle task with preemption disabled")
Reported-by: Qian Cai <quic_qiancai@quicinc.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Qian Cai <quic_qiancai@quicinc.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: Woody Lin <woodylin@google.com>
---
 kernel/cpu.c        | 7 +++++++
 kernel/sched/core.c | 4 ----
 2 files changed, 7 insertions(+), 4 deletions(-)

Since v1 [1]:
* Clarify commit message
* Fix typos
* Accumulate tags

[1] https://lore.kernel.org/lkml/20211115113310.35693-1-mark.rutland@arm.com/

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 192e43a87407..407a2568f35e 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -31,6 +31,7 @@
 #include <linux/smpboot.h>
 #include <linux/relay.h>
 #include <linux/slab.h>
+#include <linux/scs.h>
 #include <linux/percpu-rwsem.h>
 #include <linux/cpuset.h>
 
@@ -588,6 +589,12 @@ static int bringup_cpu(unsigned int cpu)
 	int ret;
 
 	/*
+	 * Reset stale stack state from the last time this CPU was online.
+	 */
+	scs_task_reset(idle);
+	kasan_unpoison_task_stack(idle);
+
+	/*
 	 * Some architectures have to walk the irq descriptors to
 	 * setup the vector space for the cpu which comes online.
 	 * Prevent irq alloc/free across the bringup.
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3c9b0fda64ac..76f9deeaa942 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8619,9 +8619,6 @@ void __init init_idle(struct task_struct *idle, int cpu)
 	idle->flags |= PF_IDLE | PF_KTHREAD | PF_NO_SETAFFINITY;
 	kthread_set_per_cpu(idle, cpu);
 
-	scs_task_reset(idle);
-	kasan_unpoison_task_stack(idle);
-
 #ifdef CONFIG_SMP
 	/*
 	 * It's possible that init_idle() gets called multiple times on a task,
@@ -8777,7 +8774,6 @@ void idle_task_exit(void)
 		finish_arch_post_lock_switch();
 	}
 
-	scs_task_reset(current);
 	/* finish_cpu(), as ran on the BP, will clean up the active_mm state */
 }
 
-- 
2.11.0

