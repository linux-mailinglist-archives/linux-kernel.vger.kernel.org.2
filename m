Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0423076D6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 14:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhA1NMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 08:12:48 -0500
Received: from foss.arm.com ([217.140.110.172]:58724 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229684AbhA1NLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 08:11:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C99B811FB;
        Thu, 28 Jan 2021 05:10:56 -0800 (PST)
Received: from e125579.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6E7013F719;
        Thu, 28 Jan 2021 05:10:54 -0800 (PST)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Hillf Danton <hdanton@sina.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] sched: Remove USER_PRIO, TASK_USER_PRIO and MAX_USER_PRIO
Date:   Thu, 28 Jan 2021 14:10:39 +0100
Message-Id: <20210128131040.296856-3-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210128131040.296856-1-dietmar.eggemann@arm.com>
References: <20210128131040.296856-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only remaining use of MAX_USER_PRIO (and USER_PRIO) is the
SCALE_PRIO() definition in the PowerPC Cell architecture's Synergistic
Processor Unit (SPU) scheduler. TASK_USER_PRIO isn't used anymore.

Commit fe443ef2ac42 ("[POWERPC] spusched: Dynamic timeslicing for
SCHED_OTHER") copied SCALE_PRIO() from the task scheduler in v2.6.23.

Commit a4ec24b48dde ("sched: tidy up SCHED_RR") removed it from the task
scheduler in v2.6.24.

Commit 3ee237dddcd8 ("sched/prio: Add 3 macros of MAX_NICE, MIN_NICE and
NICE_WIDTH in prio.h") introduced NICE_WIDTH much later.

With:

  MAX_USER_PRIO = USER_PRIO(MAX_PRIO)

                = MAX_PRIO - MAX_RT_PRIO

       MAX_PRIO = MAX_RT_PRIO + NICE_WIDTH

  MAX_USER_PRIO = MAX_RT_PRIO + NICE_WIDTH - MAX_RT_PRIO

  MAX_USER_PRIO = NICE_WIDTH

MAX_USER_PRIO can be replaced by NICE_WIDTH to be able to remove all the
{*_}USER_PRIO defines.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 arch/powerpc/platforms/cell/spufs/sched.c | 2 +-
 include/linux/sched/prio.h                | 9 ---------
 kernel/sched/sched.h                      | 2 +-
 3 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/sched.c b/arch/powerpc/platforms/cell/spufs/sched.c
index f18d5067cd0f..aeb7f3922106 100644
--- a/arch/powerpc/platforms/cell/spufs/sched.c
+++ b/arch/powerpc/platforms/cell/spufs/sched.c
@@ -72,7 +72,7 @@ static struct timer_list spuloadavg_timer;
 #define DEF_SPU_TIMESLICE	(100 * HZ / (1000 * SPUSCHED_TICK))
 
 #define SCALE_PRIO(x, prio) \
-	max(x * (MAX_PRIO - prio) / (MAX_USER_PRIO / 2), MIN_SPU_TIMESLICE)
+	max(x * (MAX_PRIO - prio) / (NICE_WIDTH / 2), MIN_SPU_TIMESLICE)
 
 /*
  * scale user-nice values [ -20 ... 0 ... 19 ] to time slice values:
diff --git a/include/linux/sched/prio.h b/include/linux/sched/prio.h
index d111f2fd77ea..ab83d85e1183 100644
--- a/include/linux/sched/prio.h
+++ b/include/linux/sched/prio.h
@@ -26,15 +26,6 @@
 #define NICE_TO_PRIO(nice)	((nice) + DEFAULT_PRIO)
 #define PRIO_TO_NICE(prio)	((prio) - DEFAULT_PRIO)
 
-/*
- * 'User priority' is the nice value converted to something we
- * can work with better when scaling various scheduler parameters,
- * it's a [ 0 ... 39 ] range.
- */
-#define USER_PRIO(p)		((p)-MAX_RT_PRIO)
-#define TASK_USER_PRIO(p)	USER_PRIO((p)->static_prio)
-#define MAX_USER_PRIO		(USER_PRIO(MAX_PRIO))
-
 /*
  * Convert nice value [19,-20] to rlimit style value [1,40].
  */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 045b01064c1e..6edc67df3554 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -140,7 +140,7 @@ extern void call_trace_sched_update_nr_running(struct rq *rq, int count);
  * scale_load() and scale_load_down(w) to convert between them. The
  * following must be true:
  *
- *  scale_load(sched_prio_to_weight[USER_PRIO(NICE_TO_PRIO(0))]) == NICE_0_LOAD
+ *  scale_load(sched_prio_to_weight[NICE_TO_PRIO(0)-MAX_RT_PRIO]) == NICE_0_LOAD
  *
  */
 #define NICE_0_LOAD		(1L << NICE_0_LOAD_SHIFT)
-- 
2.25.1

