Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134533F1F64
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 19:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbhHSRvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 13:51:37 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57838 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbhHSRvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 13:51:19 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AC22A22147;
        Thu, 19 Aug 2021 17:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629395441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B+ls4DGYx5pr42EX0nG9QyXccWrQfFEz6zfKheo/3Yo=;
        b=RZJOeeKYjEHei9J9/eXviKkmLuTYxr6HqJgF7nY182GVtP32meZyA8LRj53xk/EcVN18TS
        VJswgnLQPF0qyy8D+Vh91IwBdKKQYsBEPQuZtudZ3dz43H0tEfHt8gq9EjbdJn6OsKZckI
        y9Av6BGYA9tZO9iO3Mx+stinIO4e8UM=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 8A0E313AAE;
        Thu, 19 Aug 2021 17:50:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 2HcvIfGZHmHnOQAAGKfGzw
        (envelope-from <mkoutny@suse.com>); Thu, 19 Aug 2021 17:50:41 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     linux-kernel@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Phil Auld <pauld@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Odin Ugedal <odin@uged.al>, Rik van Riel <riel@surriel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [RFC PATCH v2 4/5] sched/fair: Simplify load_cfs_rq_list maintenance
Date:   Thu, 19 Aug 2021 19:50:33 +0200
Message-Id: <20210819175034.4577-5-mkoutny@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210819175034.4577-1-mkoutny@suse.com>
References: <20210819175034.4577-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

load_cfs_rq_list should contain cfs_rqs that have runnable entities in
them.  When we're operating under a throttled hierarchy we always
update the load_cfs_rq_list in order not to break list_add_load_cfs_rq
invariant of adding complete branches.

This caused troubles when an entity became runnable (enqueue_entity)
under a throttled hierarchy (see commit b34cb07dde7c ("sched/fair: Fix
enqueue_task_fair() warning some more")). (Basically when we add to the
load list, we have to ensure all the ancestors are added and when
deleting we have to delete whole subtree.)

This patch simplifies the code by no updates of load_cfs_rq_list when
we're operating under the throttled hierarchy and defers the
load_cfs_rq_list update to the point when whole hierarchy is unthrottled
(tg_unthrottle_up). Specifically, subtrees of a throttled cfs_rq are not
decaying their PELT when they're being throttled (but the parent of the
throttled cfs_rq is decayed).

The code is now simpler and load_cfs_rq_list contains only cfs_rqs that
have load to decay.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/sched/fair.c | 58 ++++++++++-----------------------------------
 1 file changed, 12 insertions(+), 46 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6f4d5d4dcdd9..9978485334ec 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3086,6 +3086,8 @@ void reweight_task(struct task_struct *p, int prio)
 	load->inv_weight = sched_prio_to_wmult[prio];
 }
 
+static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 #ifdef CONFIG_SMP
 /*
@@ -3196,8 +3198,6 @@ static long calc_group_shares(struct cfs_rq *cfs_rq)
 }
 #endif /* CONFIG_SMP */
 
-static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
-
 /*
  * Recomputes the group entity based on the current state of its group
  * runqueue.
@@ -4294,10 +4294,11 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 	/*
 	 * When bandwidth control is enabled, cfs might have been removed
-	 * because of a parent been throttled but cfs->nr_running > 1. Try to
-	 * add it unconditionally.
+	 * because of a parent been throttled. We'll add it later (with
+	 * complete branch up to se->on_rq/cfs_eq->on_list) in
+	 * tg_unthrottle_up() and unthrottle_cfs_rq().
 	 */
-	if (cfs_rq->nr_running == 1 || cfs_bandwidth_used())
+	if (cfs_rq->nr_running == 1 && !throttled_hierarchy(cfs_rq))
 		list_add_load_cfs_rq(cfs_rq);
 
 	if (cfs_rq->nr_running == 1)
@@ -4936,31 +4937,13 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
 			goto unthrottle_throttle;
-
-		/*
-		 * One parent has been throttled and cfs_rq removed from the
-		 * list. Add it back to not break the load list.
-		 */
-		if (throttled_hierarchy(cfs_rq))
-			list_add_load_cfs_rq(cfs_rq);
 	}
 
 	/* At this point se is NULL and we are at root level*/
 	add_nr_running(rq, task_delta);
 
 unthrottle_throttle:
-	/*
-	 * The cfs_rq_throttled() breaks in the above iteration can result in
-	 * incomplete load list maintenance, resulting in triggering the
-	 * assertion below.
-	 */
-	for_each_sched_entity(se) {
-		cfs_rq = cfs_rq_of(se);
-
-		if (list_add_load_cfs_rq(cfs_rq))
-			break;
-	}
-
+	/* See enqueue_task_fair:enqueue_throttle */
 	assert_list_load_cfs_rq(rq);
 
 	/* Determine whether we need to wake up potentially idle CPU: */
@@ -5600,13 +5583,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
 			goto enqueue_throttle;
-
-		/*
-		 * One parent has been throttled and cfs_rq removed from the
-		 * list. Add it back to not break the load list.
-		 */
-		if (throttled_hierarchy(cfs_rq))
-			list_add_load_cfs_rq(cfs_rq);
 	}
 
 	/* At this point se is NULL and we are at root level*/
@@ -5630,21 +5606,11 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		update_overutilized_status(rq);
 
 enqueue_throttle:
-	if (cfs_bandwidth_used()) {
-		/*
-		 * When bandwidth control is enabled; the cfs_rq_throttled()
-		 * breaks in the above iteration can result in incomplete
-		 * load list maintenance, resulting in triggering the assertion
-		 * below.
-		 */
-		for_each_sched_entity(se) {
-			cfs_rq = cfs_rq_of(se);
-
-			if (list_add_load_cfs_rq(cfs_rq))
-				break;
-		}
-	}
-
+	/*
+	 * If we got here, subtree of a cfs_rq must have been throttled and
+	 * therefore we did not modify load list or we climbed up to root (or
+	 * joined to an ancestor cfs_rq with on_rq == 1 => on_list).
+	 */
 	assert_list_load_cfs_rq(rq);
 
 	hrtick_update(rq);
-- 
2.32.0

