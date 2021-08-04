Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C263E00AA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 13:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237019AbhHDL7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 07:59:35 -0400
Received: from outbound-smtp29.blacknight.com ([81.17.249.32]:46992 "EHLO
        outbound-smtp29.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237926AbhHDL7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 07:59:32 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp29.blacknight.com (Postfix) with ESMTPS id 3E5E8BEC4C
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 12:59:19 +0100 (IST)
Received: (qmail 29784 invoked from network); 4 Aug 2021 11:59:19 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPA; 4 Aug 2021 11:59:18 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Song Bao Hua <song.bao.hua@hisilicon.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/2] sched/fair: Use prev instead of new target as recent_used_cpu
Date:   Wed,  4 Aug 2021 12:58:56 +0100
Message-Id: <20210804115857.6253-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210804115857.6253-1-mgorman@techsingularity.net>
References: <20210804115857.6253-1-mgorman@techsingularity.net>
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
index 44c452072a1b..8ad7666f387c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6376,6 +6376,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 
 	/* Check a recently used CPU as a potential idle candidate: */
 	recent_used_cpu = p->recent_used_cpu;
+	p->recent_used_cpu = prev;
 	if (recent_used_cpu != prev &&
 	    recent_used_cpu != target &&
 	    cpus_share_cache(recent_used_cpu, target) &&
@@ -6902,9 +6903,6 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 	} else if (wake_flags & WF_TTWU) { /* XXX always ? */
 		/* Fast path */
 		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
-
-		if (want_affine)
-			current->recent_used_cpu = cpu;
 	}
 	rcu_read_unlock();
 
-- 
2.31.1

