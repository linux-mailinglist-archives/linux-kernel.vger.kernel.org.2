Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B21D13076D1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 14:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbhA1NLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 08:11:53 -0500
Received: from foss.arm.com ([217.140.110.172]:58696 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232046AbhA1NLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 08:11:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D7BB11B3;
        Thu, 28 Jan 2021 05:10:54 -0800 (PST)
Received: from e125579.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B24E93F719;
        Thu, 28 Jan 2021 05:10:51 -0800 (PST)
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
Subject: [PATCH 1/3] sched: Remove MAX_USER_RT_PRIO
Date:   Thu, 28 Jan 2021 14:10:38 +0100
Message-Id: <20210128131040.296856-2-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210128131040.296856-1-dietmar.eggemann@arm.com>
References: <20210128131040.296856-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d46523ea32a7 ("[PATCH] fix MAX_USER_RT_PRIO and MAX_RT_PRIO")
was introduced due to a a small time period in which the realtime patch
set was using different values for MAX_USER_RT_PRIO and MAX_RT_PRIO.

This is no longer true, i.e. now MAX_RT_PRIO == MAX_USER_RT_PRIO.

Get rid of MAX_USER_RT_PRIO and make everything use MAX_RT_PRIO
instead.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 include/linux/sched/prio.h | 9 +--------
 kernel/sched/core.c        | 7 +++----
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched/prio.h b/include/linux/sched/prio.h
index 7d64feafc408..d111f2fd77ea 100644
--- a/include/linux/sched/prio.h
+++ b/include/linux/sched/prio.h
@@ -11,16 +11,9 @@
  * priority is 0..MAX_RT_PRIO-1, and SCHED_NORMAL/SCHED_BATCH
  * tasks are in the range MAX_RT_PRIO..MAX_PRIO-1. Priority
  * values are inverted: lower p->prio value means higher priority.
- *
- * The MAX_USER_RT_PRIO value allows the actual maximum
- * RT priority to be separate from the value exported to
- * user-space.  This allows kernel threads to set their
- * priority to a value higher than any user task. Note:
- * MAX_RT_PRIO must not be smaller than MAX_USER_RT_PRIO.
  */
 
-#define MAX_USER_RT_PRIO	100
-#define MAX_RT_PRIO		MAX_USER_RT_PRIO
+#define MAX_RT_PRIO		100
 
 #define MAX_PRIO		(MAX_RT_PRIO + NICE_WIDTH)
 #define DEFAULT_PRIO		(MAX_RT_PRIO + NICE_WIDTH / 2)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 06b449942adf..625ec1e12064 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5897,11 +5897,10 @@ static int __sched_setscheduler(struct task_struct *p,
 
 	/*
 	 * Valid priorities for SCHED_FIFO and SCHED_RR are
-	 * 1..MAX_USER_RT_PRIO-1, valid priority for SCHED_NORMAL,
+	 * 1..MAX_RT_PRIO-1, valid priority for SCHED_NORMAL,
 	 * SCHED_BATCH and SCHED_IDLE is 0.
 	 */
-	if ((p->mm && attr->sched_priority > MAX_USER_RT_PRIO-1) ||
-	    (!p->mm && attr->sched_priority > MAX_RT_PRIO-1))
+	if (attr->sched_priority > MAX_RT_PRIO-1)
 		return -EINVAL;
 	if ((dl_policy(policy) && !__checkparam_dl(attr)) ||
 	    (rt_policy(policy) != (attr->sched_priority != 0)))
@@ -6969,7 +6968,7 @@ SYSCALL_DEFINE1(sched_get_priority_max, int, policy)
 	switch (policy) {
 	case SCHED_FIFO:
 	case SCHED_RR:
-		ret = MAX_USER_RT_PRIO-1;
+		ret = MAX_RT_PRIO-1;
 		break;
 	case SCHED_DEADLINE:
 	case SCHED_NORMAL:
-- 
2.25.1

