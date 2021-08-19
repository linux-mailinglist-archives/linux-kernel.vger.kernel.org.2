Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDD33F1F65
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 19:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbhHSRvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 13:51:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57808 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbhHSRvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 13:51:19 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8A26E22146;
        Thu, 19 Aug 2021 17:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629395441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RsMCAyQqRjc82/UGdHyad3tJqOBFuNVmX0pxr/x7C7c=;
        b=AUZieZPD38lACbv9wyn23cw7k+dPufOi+rXWiww0IfjxFC4PIsqONXLRJ8IP3rgAmxqOF/
        ERuS7yONh/HXp48kGcJxRGLsvfUd38uPlgiwRPYsSD05zFd9K53zYs5jFzcFIu+d7BBQL+
        pnIE+4+2uEbxKWTF0A2efQVh6uYN5Tk=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 6474413AB1;
        Thu, 19 Aug 2021 17:50:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id SP//F/GZHmHnOQAAGKfGzw
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
Subject: [RFC PATCH v2 3/5] sched/fair: Rename leaf_list to more fitting load_list
Date:   Thu, 19 Aug 2021 19:50:32 +0200
Message-Id: <20210819175034.4577-4-mkoutny@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210819175034.4577-1-mkoutny@suse.com>
References: <20210819175034.4577-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The leaf_list name is obsolete and misleading. The list is nowadays used
to hold cfs_rqs with non-zero PELT that has to be decayed to properly
account for blocked tasks. Those can be inner nodes of the task_group
tree as well.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/sched/core.c  |   4 +-
 kernel/sched/fair.c  | 114 +++++++++++++++++++++----------------------
 kernel/sched/sched.h |  17 +++----
 3 files changed, 65 insertions(+), 70 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 20ffcc044134..e55a7c898cd9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8961,8 +8961,8 @@ void __init sched_init(void)
 		init_rt_rq(&rq->rt);
 		init_dl_rq(&rq->dl);
 #ifdef CONFIG_FAIR_GROUP_SCHED
-		INIT_LIST_HEAD(&rq->leaf_cfs_rq_list);
-		rq->tmp_alone_branch = &rq->leaf_cfs_rq_list;
+		INIT_LIST_HEAD(&rq->load_cfs_rq_list);
+		rq->tmp_alone_branch = &rq->load_cfs_rq_list;
 		/*
 		 * How much CPU bandwidth does root_task_group get?
 		 *
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 905f95b91a7a..6f4d5d4dcdd9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -286,13 +286,13 @@ static inline void cfs_rq_tg_path(struct cfs_rq *cfs_rq, char *path, int len)
 		strlcpy(path, "(null)", len);
 }
 
-static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
+static inline bool list_add_load_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	struct rq *rq = rq_of(cfs_rq);
 	int cpu = cpu_of(rq);
 
 	if (cfs_rq->on_list)
-		return rq->tmp_alone_branch == &rq->leaf_cfs_rq_list;
+		return rq->tmp_alone_branch == &rq->load_cfs_rq_list;
 
 	cfs_rq->on_list = 1;
 
@@ -313,14 +313,14 @@ static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 		 * the list, this means to put the child at the tail
 		 * of the list that starts by parent.
 		 */
-		list_add_tail_rcu(&cfs_rq->leaf_cfs_rq_list,
-			&(cfs_rq->tg->parent->cfs_rq[cpu]->leaf_cfs_rq_list));
+		list_add_tail_rcu(&cfs_rq->load_cfs_rq_list,
+			&(cfs_rq->tg->parent->cfs_rq[cpu]->load_cfs_rq_list));
 		/*
 		 * The branch is now connected to its tree so we can
 		 * reset tmp_alone_branch to the beginning of the
 		 * list.
 		 */
-		rq->tmp_alone_branch = &rq->leaf_cfs_rq_list;
+		rq->tmp_alone_branch = &rq->load_cfs_rq_list;
 		return true;
 	}
 
@@ -329,13 +329,13 @@ static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 		 * cfs rq without parent should be put
 		 * at the tail of the list.
 		 */
-		list_add_tail_rcu(&cfs_rq->leaf_cfs_rq_list,
-			&rq->leaf_cfs_rq_list);
+		list_add_tail_rcu(&cfs_rq->load_cfs_rq_list,
+			&rq->load_cfs_rq_list);
 		/*
 		 * We have reach the top of a tree so we can reset
 		 * tmp_alone_branch to the beginning of the list.
 		 */
-		rq->tmp_alone_branch = &rq->leaf_cfs_rq_list;
+		rq->tmp_alone_branch = &rq->load_cfs_rq_list;
 		return true;
 	}
 
@@ -345,44 +345,44 @@ static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 	 * tmp_alone_branch points to the begin of the branch
 	 * where we will add parent.
 	 */
-	list_add_rcu(&cfs_rq->leaf_cfs_rq_list, rq->tmp_alone_branch);
+	list_add_rcu(&cfs_rq->load_cfs_rq_list, rq->tmp_alone_branch);
 	/*
 	 * update tmp_alone_branch to points to the new begin
 	 * of the branch
 	 */
-	rq->tmp_alone_branch = &cfs_rq->leaf_cfs_rq_list;
+	rq->tmp_alone_branch = &cfs_rq->load_cfs_rq_list;
 	return false;
 }
 
-static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
+static inline void list_del_load_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	if (cfs_rq->on_list) {
 		struct rq *rq = rq_of(cfs_rq);
 
 		/*
 		 * With cfs_rq being unthrottled/throttled during an enqueue,
-		 * it can happen the tmp_alone_branch points the a leaf that
+		 * it can happen the tmp_alone_branch points the cfs_rq that
 		 * we finally want to del. In this case, tmp_alone_branch moves
-		 * to the prev element but it will point to rq->leaf_cfs_rq_list
+		 * to the prev element but it will point to rq->load_cfs_rq_list
 		 * at the end of the enqueue.
 		 */
-		if (rq->tmp_alone_branch == &cfs_rq->leaf_cfs_rq_list)
-			rq->tmp_alone_branch = cfs_rq->leaf_cfs_rq_list.prev;
+		if (rq->tmp_alone_branch == &cfs_rq->load_cfs_rq_list)
+			rq->tmp_alone_branch = cfs_rq->load_cfs_rq_list.prev;
 
-		list_del_rcu(&cfs_rq->leaf_cfs_rq_list);
+		list_del_rcu(&cfs_rq->load_cfs_rq_list);
 		cfs_rq->on_list = 0;
 	}
 }
 
-static inline void assert_list_leaf_cfs_rq(struct rq *rq)
+static inline void assert_list_load_cfs_rq(struct rq *rq)
 {
-	SCHED_WARN_ON(rq->tmp_alone_branch != &rq->leaf_cfs_rq_list);
+	SCHED_WARN_ON(rq->tmp_alone_branch != &rq->load_cfs_rq_list);
 }
 
-/* Iterate thr' all leaf cfs_rq's on a runqueue */
-#define for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos)			\
-	list_for_each_entry_safe(cfs_rq, pos, &rq->leaf_cfs_rq_list,	\
-				 leaf_cfs_rq_list)
+/* Iterate thr' all loaded cfs_rq's on a runqueue */
+#define for_each_load_cfs_rq_safe(rq, cfs_rq, pos)			\
+	list_for_each_entry_safe(cfs_rq, pos, &rq->load_cfs_rq_list,	\
+				 load_cfs_rq_list)
 
 /* Do the two (enqueued) entities belong to the same group ? */
 static inline struct cfs_rq *
@@ -442,20 +442,20 @@ static inline void cfs_rq_tg_path(struct cfs_rq *cfs_rq, char *path, int len)
 		strlcpy(path, "(null)", len);
 }
 
-static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
+static inline bool list_add_load_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	return true;
 }
 
-static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
+static inline void list_del_load_cfs_rq(struct cfs_rq *cfs_rq)
 {
 }
 
-static inline void assert_list_leaf_cfs_rq(struct rq *rq)
+static inline void assert_list_load_cfs_rq(struct rq *rq)
 {
 }
 
-#define for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos)	\
+#define for_each_load_cfs_rq_safe(rq, cfs_rq, pos)	\
 		for (cfs_rq = &rq->cfs, pos = NULL; cfs_rq; cfs_rq = pos)
 
 static inline struct sched_entity *parent_entity(struct sched_entity *se)
@@ -3257,12 +3257,12 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
 #ifdef CONFIG_SMP
 #ifdef CONFIG_FAIR_GROUP_SCHED
 /*
- * Because list_add_leaf_cfs_rq always places a child cfs_rq on the list
+ * Because list_add_load_cfs_rq always places a child cfs_rq on the list
  * immediately before a parent cfs_rq, and cfs_rqs are removed from the list
  * bottom-up, we only have to test whether the cfs_rq before us on the list
  * is our child.
  * If cfs_rq is not on the list, test whether a child needs its to be added to
- * connect a branch to the tree  * (see list_add_leaf_cfs_rq() for details).
+ * connect a branch to the tree (see list_add_load_cfs_rq() for details).
  */
 static inline bool child_cfs_rq_on_list(struct cfs_rq *cfs_rq)
 {
@@ -3270,14 +3270,14 @@ static inline bool child_cfs_rq_on_list(struct cfs_rq *cfs_rq)
 	struct list_head *prev;
 
 	if (cfs_rq->on_list) {
-		prev = cfs_rq->leaf_cfs_rq_list.prev;
+		prev = cfs_rq->load_cfs_rq_list.prev;
 	} else {
 		struct rq *rq = rq_of(cfs_rq);
 
 		prev = rq->tmp_alone_branch;
 	}
 
-	prev_cfs_rq = container_of(prev, struct cfs_rq, leaf_cfs_rq_list);
+	prev_cfs_rq = container_of(prev, struct cfs_rq, load_cfs_rq_list);
 
 	return (prev_cfs_rq->tg->parent == cfs_rq->tg);
 }
@@ -4298,7 +4298,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * add it unconditionally.
 	 */
 	if (cfs_rq->nr_running == 1 || cfs_bandwidth_used())
-		list_add_leaf_cfs_rq(cfs_rq);
+		list_add_load_cfs_rq(cfs_rq);
 
 	if (cfs_rq->nr_running == 1)
 		check_enqueue_throttle(cfs_rq);
@@ -4775,7 +4775,7 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
 
 		/* Add cfs_rq with load or one or more already running entities to the list */
 		if (!cfs_rq_is_decayed(cfs_rq) || cfs_rq->nr_running)
-			list_add_leaf_cfs_rq(cfs_rq);
+			list_add_load_cfs_rq(cfs_rq);
 	}
 
 	return 0;
@@ -4789,7 +4789,7 @@ static int tg_throttle_down(struct task_group *tg, void *data)
 	/* group is entering throttled state, stop time */
 	if (!cfs_rq->throttle_count) {
 		cfs_rq->throttled_clock_task = rq_clock_task(rq);
-		list_del_leaf_cfs_rq(cfs_rq);
+		list_del_load_cfs_rq(cfs_rq);
 	}
 	cfs_rq->throttle_count++;
 
@@ -4900,10 +4900,10 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		/* Nothing to run but something to decay? Complete the branch */
 		if (cfs_rq->on_list)
 			for_each_sched_entity(se) {
-				if (list_add_leaf_cfs_rq(group_cfs_rq(se)))
+				if (list_add_load_cfs_rq(group_cfs_rq(se)))
 					break;
 			}
-		assert_list_leaf_cfs_rq(rq);
+		assert_list_load_cfs_rq(rq);
 		return;
 	}
 
@@ -4939,10 +4939,10 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 
 		/*
 		 * One parent has been throttled and cfs_rq removed from the
-		 * list. Add it back to not break the leaf list.
+		 * list. Add it back to not break the load list.
 		 */
 		if (throttled_hierarchy(cfs_rq))
-			list_add_leaf_cfs_rq(cfs_rq);
+			list_add_load_cfs_rq(cfs_rq);
 	}
 
 	/* At this point se is NULL and we are at root level*/
@@ -4951,17 +4951,17 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 unthrottle_throttle:
 	/*
 	 * The cfs_rq_throttled() breaks in the above iteration can result in
-	 * incomplete leaf list maintenance, resulting in triggering the
+	 * incomplete load list maintenance, resulting in triggering the
 	 * assertion below.
 	 */
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
 
-		if (list_add_leaf_cfs_rq(cfs_rq))
+		if (list_add_load_cfs_rq(cfs_rq))
 			break;
 	}
 
-	assert_list_leaf_cfs_rq(rq);
+	assert_list_load_cfs_rq(rq);
 
 	/* Determine whether we need to wake up potentially idle CPU: */
 	if (rq->curr == rq->idle && rq->cfs.nr_running)
@@ -5601,12 +5601,12 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		if (cfs_rq_throttled(cfs_rq))
 			goto enqueue_throttle;
 
-               /*
-                * One parent has been throttled and cfs_rq removed from the
-                * list. Add it back to not break the leaf list.
-                */
-               if (throttled_hierarchy(cfs_rq))
-                       list_add_leaf_cfs_rq(cfs_rq);
+		/*
+		 * One parent has been throttled and cfs_rq removed from the
+		 * list. Add it back to not break the load list.
+		 */
+		if (throttled_hierarchy(cfs_rq))
+			list_add_load_cfs_rq(cfs_rq);
 	}
 
 	/* At this point se is NULL and we are at root level*/
@@ -5634,18 +5634,18 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		/*
 		 * When bandwidth control is enabled; the cfs_rq_throttled()
 		 * breaks in the above iteration can result in incomplete
-		 * leaf list maintenance, resulting in triggering the assertion
+		 * load list maintenance, resulting in triggering the assertion
 		 * below.
 		 */
 		for_each_sched_entity(se) {
 			cfs_rq = cfs_rq_of(se);
 
-			if (list_add_leaf_cfs_rq(cfs_rq))
+			if (list_add_load_cfs_rq(cfs_rq))
 				break;
 		}
 	}
 
-	assert_list_leaf_cfs_rq(rq);
+	assert_list_load_cfs_rq(rq);
 
 	hrtick_update(rq);
 }
@@ -8122,9 +8122,9 @@ static bool __update_blocked_fair(struct rq *rq, bool *done)
 
 	/*
 	 * Iterates the task_group tree in a bottom up fashion, see
-	 * list_add_leaf_cfs_rq() for details.
+	 * list_add_load_cfs_rq() for details.
 	 */
-	for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos) {
+	for_each_load_cfs_rq_safe(rq, cfs_rq, pos) {
 		struct sched_entity *se;
 
 		if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq)) {
@@ -8144,7 +8144,7 @@ static bool __update_blocked_fair(struct rq *rq, bool *done)
 		 * decayed cfs_rqs linger on the list.
 		 */
 		if (cfs_rq_is_decayed(cfs_rq))
-			list_del_leaf_cfs_rq(cfs_rq);
+			list_del_load_cfs_rq(cfs_rq);
 
 		/* Don't need periodic decay once load/util_avg are null */
 		if (cfs_rq_has_blocked(cfs_rq))
@@ -11111,7 +11111,7 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
 {
 	struct cfs_rq *cfs_rq;
 
-	list_add_leaf_cfs_rq(cfs_rq_of(se));
+	list_add_load_cfs_rq(cfs_rq_of(se));
 
 	/* Start to propagate at parent */
 	se = se->parent;
@@ -11121,11 +11121,11 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
 
 		if (!cfs_rq_throttled(cfs_rq)){
 			update_load_avg(cfs_rq, se, UPDATE_TG);
-			list_add_leaf_cfs_rq(cfs_rq);
+			list_add_load_cfs_rq(cfs_rq);
 			continue;
 		}
 
-		if (list_add_leaf_cfs_rq(cfs_rq))
+		if (list_add_load_cfs_rq(cfs_rq))
 			break;
 	}
 }
@@ -11383,7 +11383,7 @@ void unregister_fair_sched_group(struct task_group *tg)
 		rq = cpu_rq(cpu);
 
 		raw_spin_rq_lock_irqsave(rq, flags);
-		list_del_leaf_cfs_rq(tg->cfs_rq[cpu]);
+		list_del_load_cfs_rq(tg->cfs_rq[cpu]);
 		raw_spin_rq_unlock_irqrestore(rq, flags);
 	}
 }
@@ -11543,7 +11543,7 @@ void print_cfs_stats(struct seq_file *m, int cpu)
 	struct cfs_rq *cfs_rq, *pos;
 
 	rcu_read_lock();
-	for_each_leaf_cfs_rq_safe(cpu_rq(cpu), cfs_rq, pos)
+	for_each_load_cfs_rq_safe(cpu_rq(cpu), cfs_rq, pos)
 		print_cfs_rq(m, cpu, cfs_rq);
 	rcu_read_unlock();
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 219ee463fe64..dc9382295ec9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -587,16 +587,8 @@ struct cfs_rq {
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	struct rq		*rq;	/* CPU runqueue to which this cfs_rq is attached */
 
-	/*
-	 * leaf cfs_rqs are those that hold tasks (lowest schedulable entity in
-	 * a hierarchy). Non-leaf lrqs hold other higher schedulable entities
-	 * (like users, containers etc.)
-	 *
-	 * leaf_cfs_rq_list ties together list of leaf cfs_rq's in a CPU.
-	 * This list is used during load balance.
-	 */
 	int			on_list;
-	struct list_head	leaf_cfs_rq_list;
+	struct list_head	load_cfs_rq_list;
 	struct task_group	*tg;	/* group that "owns" this runqueue */
 
 #ifdef CONFIG_CFS_BANDWIDTH
@@ -950,8 +942,11 @@ struct rq {
 	struct dl_rq		dl;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-	/* list of leaf cfs_rq on this CPU: */
-	struct list_head	leaf_cfs_rq_list;
+	/* Bottom up ordered list of cfs_rqs with load (see
+	 * cfs_rq_is_decayed()) on this CPU.
+	 * This list is used during load balance.
+	 */
+	struct list_head	load_cfs_rq_list;
 	struct list_head	*tmp_alone_branch;
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
-- 
2.32.0

