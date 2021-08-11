Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C018A3E8FD3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 13:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbhHKLuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 07:50:18 -0400
Received: from mx313.baidu.com ([180.101.52.140]:21300 "EHLO
        njjs-sys-mailin07.njjs.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236777AbhHKLuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 07:50:14 -0400
Received: from unknown.domain.tld (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
        by njjs-sys-mailin07.njjs.baidu.com (Postfix) with ESMTP id 3F9E019480056;
        Wed, 11 Aug 2021 19:49:47 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: micro-optimize pick_next_entity()
Date:   Wed, 11 Aug 2021 19:48:02 +0800
Message-Id: <20210811114802.7408-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.9.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

only check the skip buddy when next buddy and last buddy
are not picked up, this can save the cycles of checking
the skip buddy and compute the second buddy when next and
last buddy will be picked up

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 kernel/sched/fair.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 44c4520..9c6569dd 100644
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
2.9.4

