Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21CE325383
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 17:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhBYQ3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 11:29:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:40616 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233158AbhBYQ2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 11:28:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614270488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vxneo372S9t8nnxxBJftXS5hW6amgHXFT8XmT+FBdNw=;
        b=d16yxZ9Zd0YcS6BQLEgLbel9gO4iyMphIJTCHj28u/g/LkHzVn2tiStGRKgiG8PR2ECg5B
        SiuYYbYnXfgQB2ibCmEOSkmH2gHhSLloYfeVfHbeYsHAD/VoFPgu+3XaxubCBEC74pto2u
        ZOWy1y0ayRlDSnmD/maqMhKk7RqdXPA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 71800ACE5;
        Thu, 25 Feb 2021 16:28:08 +0000 (UTC)
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Phil Auld <pauld@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] sched: Simplify leaf_cfs_rq_list maintenance
Date:   Thu, 25 Feb 2021 17:27:57 +0100
Message-Id: <20210225162757.48858-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

leaf_cfs_rq_list should contain cfs_rqs that have runnable entities in
them.  When we're operating under a throttled hierarchy we always update
the leaf_cfs_rq_list in order no to break list_add_leaf_cfs_rq invariant
of adding complete branches.

This caused troubles when an entity became runnable (enqueue_entity)
under a throttled hierarchy (see commit b34cb07dde7c ("sched/fair: Fix
enqueue_task_fair() warning some more")). While it proved well, this
new change ignores updating leaf_cfs_rq_list when we're operating under
the throttled hierarchy and defers the leaf_cfs_rq_list update to the
point when whole hiearchy is unthrottled (tg_unthrottle_up).

The code is now simpler and leaf_cfs_rq_list contains only cfs_rqs that
are truly runnable.

Why is this RFC?
- Primarily, I'm not sure I interpreted the purpose of leaf_cfs_rq_list
  right. The removal of throttled cfs_rqs from it would exclude them
  from __update_blocked_fair() calculation and I can't see past it now.
  If it's wrong assumption, I'd like this to help clarify what the
  proper definition of leaf_cfs_rq_list would be.
- Additionally, I didn't check thoroughly for corner cases when
  se->on_rq => cfs_rq_of(se)->on_list wouldn't hold, so the patch
  certainly isn't finished.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/sched/fair.c  | 41 ++++++-----------------------------------
 kernel/sched/sched.h |  4 +---
 2 files changed, 7 insertions(+), 38 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 04a3ce20da67..634ba6637824 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4250,10 +4250,11 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 	/*
 	 * When bandwidth control is enabled, cfs might have been removed
-	 * because of a parent been throttled but cfs->nr_running > 1. Try to
-	 * add it unconditionnally.
+	 * because of a parent been throttled. We'll add it later (with
+	 * complete branch up to se->on_rq/cfs_eq->on_list) in
+	 * tg_unthrottle_up() and unthrottle_cfs_rq().
 	 */
-	if (cfs_rq->nr_running == 1 || cfs_bandwidth_used())
+	if (cfs_rq->nr_running == 1 && !throttled_hierarchy(cfs_rq))
 		list_add_leaf_cfs_rq(cfs_rq);
 
 	if (cfs_rq->nr_running == 1)
@@ -4859,6 +4860,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	for_each_sched_entity(se) {
 		if (se->on_rq)
 			break;
+		// XXX: se->on_rq implies cfs_rq_of(se)->on_list (unless throttled_hierarchy)
 		cfs_rq = cfs_rq_of(se);
 		enqueue_entity(cfs_rq, se, ENQUEUE_WAKEUP);
 
@@ -4896,17 +4898,6 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	add_nr_running(rq, task_delta);
 
 unthrottle_throttle:
-	/*
-	 * The cfs_rq_throttled() breaks in the above iteration can result in
-	 * incomplete leaf list maintenance, resulting in triggering the
-	 * assertion below.
-	 */
-	for_each_sched_entity(se) {
-		cfs_rq = cfs_rq_of(se);
-
-		if (list_add_leaf_cfs_rq(cfs_rq))
-			break;
-	}
 
 	assert_list_leaf_cfs_rq(rq);
 
@@ -5518,6 +5509,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	for_each_sched_entity(se) {
 		if (se->on_rq)
 			break;
+		// XXX: se->on_rq implies cfs_rq_of(se)->on_list (unless throttled_hierarchy)
 		cfs_rq = cfs_rq_of(se);
 		enqueue_entity(cfs_rq, se, flags);
 
@@ -5544,13 +5536,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
 			goto enqueue_throttle;
-
-               /*
-                * One parent has been throttled and cfs_rq removed from the
-                * list. Add it back to not break the leaf list.
-                */
-               if (throttled_hierarchy(cfs_rq))
-                       list_add_leaf_cfs_rq(cfs_rq);
 	}
 
 	/* At this point se is NULL and we are at root level*/
@@ -5574,20 +5559,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		update_overutilized_status(rq);
 
 enqueue_throttle:
-	if (cfs_bandwidth_used()) {
-		/*
-		 * When bandwidth control is enabled; the cfs_rq_throttled()
-		 * breaks in the above iteration can result in incomplete
-		 * leaf list maintenance, resulting in triggering the assertion
-		 * below.
-		 */
-		for_each_sched_entity(se) {
-			cfs_rq = cfs_rq_of(se);
-
-			if (list_add_leaf_cfs_rq(cfs_rq))
-				break;
-		}
-	}
 
 	assert_list_leaf_cfs_rq(rq);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index bb09988451a0..f674d88920da 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -573,9 +573,7 @@ struct cfs_rq {
 	struct rq		*rq;	/* CPU runqueue to which this cfs_rq is attached */
 
 	/*
-	 * leaf cfs_rqs are those that hold tasks (lowest schedulable entity in
-	 * a hierarchy). Non-leaf lrqs hold other higher schedulable entities
-	 * (like users, containers etc.)
+	 * leaf cfs_rqs are those that hold runnable entities.
 	 *
 	 * leaf_cfs_rq_list ties together list of leaf cfs_rq's in a CPU.
 	 * This list is used during load balance.
-- 
2.30.1

