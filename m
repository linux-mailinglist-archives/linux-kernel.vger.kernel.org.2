Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B9E321520
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 12:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhBVL3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 06:29:41 -0500
Received: from m12-11.163.com ([220.181.12.11]:40156 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230171AbhBVL3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 06:29:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=JiOYtJmooOVrKt/xm8
        YoFY/kPhSoNifZugw/nKFpdM0=; b=i++OAUJ8lCHQcRuaBnHvBouOcJJWPF7GE/
        +74nFwIc6R+PrGQCXqabCtYQVlTxacjE9zaS4ul4q0J2ANxYaTQ/YLdeD0x4O4c1
        c16Zn0yMeFYhAWE6wlyzYttn6579HIqob19G1PJM6/LALMYnbDseGap2ic+he83y
        1qOGizEi8=
Received: from localhost.localdomain (unknown [14.17.22.36])
        by smtp7 (Coremail) with SMTP id C8CowABnM61LXjNgEPhgOw--.34251S3;
        Mon, 22 Feb 2021 15:33:32 +0800 (CST)
From:   ultrachin@163.com
To:     vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, heddchen@tencent.com,
        xiaoggchen@tencent.com
Subject: [PATCH V2] sched: pull tasks when CPU is about to run SCHED_IDLE tasks
Date:   Mon, 22 Feb 2021 15:33:20 +0800
Message-Id: <1613979200-9707-1-git-send-email-ultrachin@163.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: C8CowABnM61LXjNgEPhgOw--.34251S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr4DurykWw17AF48CF1xZrb_yoW8ZrW7pF
        Z2ga1Iyw1qqws0qrnrCrWFkry3tan3Za43uF42yFW5AF1DGw1Fyr10gFy3ZF40y395AF9F
        kF4jvrWfCay5Cr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jIyIUUUUUU=
X-Originating-IP: [14.17.22.36]
X-CM-SenderInfo: xxow2thfkl0qqrwthudrp/1tbi8Q1BWF-PKLjUogAAsT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Xiaoguang <xiaoggchen@tencent.com>

In order to use the computer efficiently we usually deploy online
tasks and offline tasks in the same computer.

The online tasks are more important than the offline tasks and are
latency sensitive we should make sure the online tasks preempt the
offline tasks as soon as possible while there are online tasks
waiting to run.

Online tasks using the SCHED_NORMAL policy and offline tasks using
the SCHED_ILDE policy. This patch decrease the latency of online
tasks by doing a load balance before a offline tasks to run.

Signed-off-by: Chen Xiaoguang <xiaoggchen@tencent.com>
Signed-off-by: Chen He <heddchen@tencent.com>
---
v1 -> v2:
 - Add checking in balance_fair
 - Remove task state checking in pick_next_task_fair
 - Add comment about the change
---
 kernel/sched/fair.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8a8bd7b..80b69a2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6833,7 +6833,13 @@ static void task_dead_fair(struct task_struct *p)
 static int
 balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
-	if (rq->nr_running)
+	/*
+	 * Return if SCHED_NORMAL tasks exist.
+	 * Else if only SCHED_IDLE tasks in rq then do a load balance trying
+	 * to pull SCHED_NORMAL tasks to run so as to reduce the latency of
+	 * SCHED_NORMAL task.
+	 */
+	if (rq->nr_running && !sched_idle_rq(rq))
 		return 1;
 
 	return newidle_balance(rq, rf) != 0;
@@ -7013,6 +7019,14 @@ struct task_struct *
 	struct task_struct *p;
 	int new_tasks;
 
+	/*
+	 * Before a CPU switches from running SCHED_NORMAL task to SCHED_IDLE
+	 * task, do a load balance trying to pull SCHED_NORMAL tasks to run
+	 * so as to reduce the latency of SCHED_NORMAL task.
+	 */
+	if (sched_idle_rq(rq) && prev && prev->policy != SCHED_IDLE)
+		goto idle;
+
 again:
 	if (!sched_fair_runnable(rq))
 		goto idle;
-- 
1.8.3.1

