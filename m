Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2373F6F56
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 08:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238513AbhHYGUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 02:20:32 -0400
Received: from mx439.baidu.com ([119.249.100.103]:26052 "EHLO mx419.baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237993AbhHYGUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 02:20:31 -0400
Received: from bjhw-sys-rpm015653cc5.bjhw.baidu.com (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
        by mx419.baidu.com (Postfix) with ESMTP id 5620118183D37;
        Wed, 25 Aug 2021 14:19:43 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by bjhw-sys-rpm015653cc5.bjhw.baidu.com (Postfix) with ESMTP id 4A87AD9932;
        Wed, 25 Aug 2021 14:19:43 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        lirongqing@baidu.com
Subject: 
Date:   Wed, 25 Aug 2021 14:19:43 +0800
Message-Id: <1629872383-2505-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only check the skip buddy when next buddy and last buddy
are not picked up, this can save the cycles of checking
the skip buddy and computation of the second buddy, when
next and last buddy will be picked up
for example, yield_to_task_fair() set both next and skip
buddy

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 kernel/sched/fair.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 44c452072a1b..9c6569ddf3eb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4503,11 +4503,22 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 
 	se = left; /* ideally we run the leftmost entity */
 
-	/*
-	 * Avoid running the skip buddy, if running something else can
-	 * be done without getting too unfair.
-	 */
-	if (cfs_rq->skip && cfs_rq->skip == se) {
+
+	if (cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, left) < 1) {
+		/*
+		 * Someone really wants this to run. If it's not unfair, run it.
+		 */
+		se = cfs_rq->next;
+	} else if (cfs_rq->last && wakeup_preempt_entity(cfs_rq->last, left) < 1) {
+		/*
+		 * Prefer last buddy, try to return the CPU to a preempted task.
+		 */
+		se = cfs_rq->last;
+	} else if (cfs_rq->skip && cfs_rq->skip == se) {
+		/*
+		 * Avoid running the skip buddy, if running something else can
+		 * be done without getting too unfair.
+		 */
 		struct sched_entity *second;
 
 		if (se == curr) {
@@ -4522,18 +4533,6 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 			se = second;
 	}
 
-	if (cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, left) < 1) {
-		/*
-		 * Someone really wants this to run. If it's not unfair, run it.
-		 */
-		se = cfs_rq->next;
-	} else if (cfs_rq->last && wakeup_preempt_entity(cfs_rq->last, left) < 1) {
-		/*
-		 * Prefer last buddy, try to return the CPU to a preempted task.
-		 */
-		se = cfs_rq->last;
-	}
-
 	return se;
 }
 
-- 
2.33.0.69.gc420321.dirty

