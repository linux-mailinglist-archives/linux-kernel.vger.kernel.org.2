Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB80A366D7B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 16:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241019AbhDUOC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 10:02:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236913AbhDUOCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 10:02:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F0906144B;
        Wed, 21 Apr 2021 14:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619013711;
        bh=r0keDoHz23TfpGCWMHlZYtsVksz7HUzT5k/LgVyNnFI=;
        h=From:To:Cc:Subject:Date:From;
        b=OQ2xMp5cE7L0B1upvZUlKhrpj/ci69VumdOxMyx+tW+AQMeqPqToIKB2fCpOrjHca
         LmWYytxos6qzfaGnUgb/dVUuh9CvgmqZdwswAizE7XeKv3sByZ6Q36gC1duCwicTED
         Vc+jXlPcYTVXzJrZFWGTh/CSeScV/wqimrLKi3HRE1XG+r3OUvGWzZ6WW/VLqOEsQD
         Xk3FAedTvnm1Le5LdtTefsIXZnylXBeDZauEKh0Qt3OrgwN4IWsSIuCi96ZsUNquup
         FyiIDJtMOadkmroQVMB3MfcCCaiA2Pt/EluPtvSJbZeXC3vx0UnICFrkHVwK8+blab
         2zTKyqR1qXbVQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Paul Turner <pjt@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: Fix an unused function warning
Date:   Wed, 21 Apr 2021 16:01:39 +0200
Message-Id: <20210421140145.3767949-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Without CONFIG_NO_HZ_COMMON, there is now a warning about update_nohz_stats
after the last caller outside the #ifdef was removed

kernel/sched/fair.c:8433:13: error: 'update_nohz_stats' defined but not used [-Werror=unused-function]
 8433 | static bool update_nohz_stats(struct rq *rq)

Simplify the function by removing the #ifdef inside it and move it into
the block in which it gets called.

Fixes: 0826530de3cb ("sched/fair: Remove update of blocked load from newidle_balance")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/sched/fair.c | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index df2083d2dd0c..7c3edbb5ec70 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8430,28 +8430,6 @@ group_type group_classify(unsigned int imbalance_pct,
 	return group_has_spare;
 }
 
-static bool update_nohz_stats(struct rq *rq)
-{
-#ifdef CONFIG_NO_HZ_COMMON
-	unsigned int cpu = rq->cpu;
-
-	if (!rq->has_blocked_load)
-		return false;
-
-	if (!cpumask_test_cpu(cpu, nohz.idle_cpus_mask))
-		return false;
-
-	if (!time_after(jiffies, READ_ONCE(rq->last_blocked_load_update_tick)))
-		return true;
-
-	update_blocked_averages(cpu);
-
-	return rq->has_blocked_load;
-#else
-	return false;
-#endif
-}
-
 /**
  * update_sg_lb_stats - Update sched_group's statistics for load balancing.
  * @env: The load balancing environment.
@@ -10123,6 +10101,24 @@ static inline int on_null_domain(struct rq *rq)
 }
 
 #ifdef CONFIG_NO_HZ_COMMON
+static bool update_nohz_stats(struct rq *rq)
+{
+	unsigned int cpu = rq->cpu;
+
+	if (!rq->has_blocked_load)
+		return false;
+
+	if (!cpumask_test_cpu(cpu, nohz.idle_cpus_mask))
+		return false;
+
+	if (!time_after(jiffies, READ_ONCE(rq->last_blocked_load_update_tick)))
+		return true;
+
+	update_blocked_averages(cpu);
+
+	return rq->has_blocked_load;
+}
+
 /*
  * idle load balancing details
  * - When one of the busy CPUs notice that there may be an idle rebalancing
-- 
2.29.2

