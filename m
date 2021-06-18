Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCA03ACC43
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 15:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbhFRNew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 09:34:52 -0400
Received: from foss.arm.com ([217.140.110.172]:41192 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232258AbhFRNet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 09:34:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 538271476;
        Fri, 18 Jun 2021 06:32:40 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (e120877-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1CAD23F719;
        Fri, 18 Jun 2021 06:32:39 -0700 (PDT)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com
Cc:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        valentin.schneider@arm.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH 2/2] sched/rt: Fix Deadline utilization tracking during policy change
Date:   Fri, 18 Jun 2021 14:32:19 +0100
Message-Id: <1624023139-66147-2-git-send-email-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1624023139-66147-1-git-send-email-vincent.donnefort@arm.com>
References: <1624023139-66147-1-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DL keeps track of the utilization on a per-rq basis with the structure
avg_dl. This utilization is updated during task_tick_dl(),
put_prev_task_dl() and set_next_task_dl(). However, when the current
running task changes its policy, set_next_task_dl() which would usually
take care of updating the utilization when the rq starts running DL
tasks, will not see a such change, leaving the avg_dl structure outdated.
When that very same task will be dequeued later, put_prev_task_dl() will
then update the utilization, based on a wrong last_update_time, leading a
huge spike in the DL utilization signal.

The signal would eventually recover from this issue after few ms. Even
if no DL tasks are run, avg_dl is also updated in
__update_blocked_others(). But as the CPU capacity depends partly on the
avg_dl, this issue has nonetheless a significant impact on the scheduler.

Fix this issue by ensuring a load update when a running task changes
its policy to DL.

Fixes: 3727e0e ("sched/dl: Add dl_rq utilization tracking")
Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 3829c5a..915227a 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2497,6 +2497,8 @@ static void switched_to_dl(struct rq *rq, struct task_struct *p)
 			check_preempt_curr_dl(rq, p, 0);
 		else
 			resched_curr(rq);
+	} else {
+		update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 0);
 	}
 }
 
-- 
2.7.4

