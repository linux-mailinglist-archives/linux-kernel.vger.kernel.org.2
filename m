Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D6D396F0C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 10:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbhFAIiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 04:38:15 -0400
Received: from foss.arm.com ([217.140.110.172]:43318 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233127AbhFAIiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 04:38:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2930C1FB;
        Tue,  1 Jun 2021 01:36:32 -0700 (PDT)
Received: from e125579.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4C5193F73D;
        Tue,  1 Jun 2021 01:36:30 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: Return early from update_tg_cfs_load() if delta == 0
Date:   Tue,  1 Jun 2021 10:36:16 +0200
Message-Id: <20210601083616.804229-1-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case the _avg delta is 0 there is no need to update se's _avg
(level n) nor cfs_rq's _avg (level n-1). These values stay the same.

Since cfs_rq's _avg isn't changed, i.e. no load is propagated down,
cfs_rq's _sum should stay the same as well.

So bail out after se's _sum has been updated.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---

This patch is against current tip/sched/urgent, commit f268c3737eca
("tick/nohz: Only check for RCU deferred wakeup on user/guest entry
when needed").
It needs commit 7c7ad626d9a0 ("sched/fair: Keep load_avg and load_sum
synced"). 

 kernel/sched/fair.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e7c8277e3d54..ce8e0e10e5d4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3548,9 +3548,12 @@ update_tg_cfs_load(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
 	load_sum = (s64)se_weight(se) * runnable_sum;
 	load_avg = div_s64(load_sum, divider);
 
+	se->avg.load_sum = runnable_sum;
+
 	delta = load_avg - se->avg.load_avg;
+	if (!delta)
+		return;
 
-	se->avg.load_sum = runnable_sum;
 	se->avg.load_avg = load_avg;
 
 	add_positive(&cfs_rq->avg.load_avg, delta);
-- 
2.25.1

