Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C493D5760
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 12:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbhGZJnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 05:43:19 -0400
Received: from outbound-smtp37.blacknight.com ([46.22.139.220]:60921 "EHLO
        outbound-smtp37.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232862AbhGZJnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 05:43:12 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp37.blacknight.com (Postfix) with ESMTPS id 435481A1B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 11:23:39 +0100 (IST)
Received: (qmail 22922 invoked from network); 26 Jul 2021 10:23:38 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPA; 26 Jul 2021 10:23:38 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 4/9] sched/fair: Use prev instead of new target as recent_used_cpu
Date:   Mon, 26 Jul 2021 11:22:42 +0100
Message-Id: <20210726102247.21437-5-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210726102247.21437-1-mgorman@techsingularity.net>
References: <20210726102247.21437-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After select_idle_sibling, p->recent_used_cpu is set to the
new target. However on the next wakeup, prev will be the same as
recent_used_cpu unless the load balancer has moved the task since the
last wakeup. It still works, but is less efficient than it could be.
This patch preserves recent_used_cpu for longer.

The impact on SIS efficiency is tiny so the SIS statistic patches were
used to track the hit rate for using recent_used_cpu. With perf bench
pipe on a 2-socket Cascadelake machine, the hit rate went from 57.14%
to 85.32%. For more intensive wakeup loads like hackbench, the hit rate
is almost negligible but rose from 0.21% to 6.64%. For scaling loads
like tbench, the hit rate goes from almost 0% to 25.42% overall. Broadly
speaking, on tbench, the success rate is much higher for lower thread
counts and drops to almost 0 as the workload scales to towards saturation.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4e2979b73cec..75ff991a460a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6390,6 +6390,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 
 	/* Check a recently used CPU as a potential idle candidate: */
 	recent_used_cpu = p->recent_used_cpu;
+	p->recent_used_cpu = prev;
 	if (recent_used_cpu != prev && recent_used_cpu != target) {
 
 		if (cpus_share_cache(recent_used_cpu, target) &&
@@ -6922,9 +6923,6 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 	} else if (wake_flags & WF_TTWU) { /* XXX always ? */
 		/* Fast path */
 		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
-
-		if (want_affine)
-			current->recent_used_cpu = cpu;
 	}
 	rcu_read_unlock();
 
-- 
2.26.2

