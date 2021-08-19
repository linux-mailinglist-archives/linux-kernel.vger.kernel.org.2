Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB473F1F63
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 19:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbhHSRve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 13:51:34 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57786 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbhHSRvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 13:51:18 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 64ABD22145;
        Thu, 19 Aug 2021 17:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629395441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZXu5X0lro47sECG/7ctTMKIsIb2WSK/2oU0QLZiG4pE=;
        b=BcQ+Xa/48N5LNymNq0NWfPz00A1UPHwWZe2MJzkYM7CL/Brg0+qOAJfQTGsSFxpdqxnIZe
        jLEoWG8gwI1ibQtOhdYO4rutuMUnDNnML1N4YpNpxZiKm5cXYnVLdtpfT63t+Js5hBrys1
        BNkyb0pL7O2/kFQdJACeyVHcqd0Xfq4=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 3BAE013AAE;
        Thu, 19 Aug 2021 17:50:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id IDnuDfGZHmHnOQAAGKfGzw
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
Subject: [RFC PATCH v2 2/5] sched: Add group_se() helper
Date:   Thu, 19 Aug 2021 19:50:31 +0200
Message-Id: <20210819175034.4577-3-mkoutny@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210819175034.4577-1-mkoutny@suse.com>
References: <20210819175034.4577-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change, unify cfs_rq to sched_entity conversion (and move
closer to use where possible). The helper is used only by
CONFIG_FAIR_GROUP_SCHED code, i.e. no dummy variant is defined.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/sched/fair.c  | 9 +++------
 kernel/sched/sched.h | 8 ++++++++
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2c41a9007928..905f95b91a7a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4824,8 +4824,6 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	if (!dequeue)
 		return false;  /* Throttle no longer required. */
 
-	se = cfs_rq->tg->se[cpu_of(rq_of(cfs_rq))];
-
 	/* freeze hierarchy runnable averages while throttled */
 	rcu_read_lock();
 	walk_tg_tree_from(cfs_rq->tg, tg_throttle_down, tg_nop, (void *)rq);
@@ -4833,6 +4831,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 
 	task_delta = cfs_rq->h_nr_running;
 	idle_task_delta = cfs_rq->idle_h_nr_running;
+	se = group_se(cfs_rq);
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 		/* throttled entity or throttle-on-deactivate */
@@ -4884,8 +4883,6 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct sched_entity *se;
 	long task_delta, idle_task_delta;
 
-	se = cfs_rq->tg->se[cpu_of(rq)];
-
 	cfs_rq->throttled = 0;
 
 	update_rq_clock(rq);
@@ -4898,6 +4895,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	/* update hierarchical throttle state */
 	walk_tg_tree_from(cfs_rq->tg, tg_nop, tg_unthrottle_up, (void *)rq);
 
+	se = group_se(cfs_rq);
 	if (!cfs_rq->load.weight) {
 		/* Nothing to run but something to decay? Complete the branch */
 		if (cfs_rq->on_list)
@@ -8163,8 +8161,7 @@ static bool __update_blocked_fair(struct rq *rq, bool *done)
  */
 static void update_cfs_rq_h_load(struct cfs_rq *cfs_rq)
 {
-	struct rq *rq = rq_of(cfs_rq);
-	struct sched_entity *se = cfs_rq->tg->se[cpu_of(rq)];
+	struct sched_entity *se = group_se(cfs_rq);
 	unsigned long now = jiffies;
 	unsigned long load;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 14a41a243f7b..219ee463fe64 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1383,6 +1383,14 @@ static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
 	return grp->my_q;
 }
 
+/* sched entity representing the cfs_rq, NULL for root */
+static inline struct sched_entity *group_se(struct cfs_rq *cfs_rq)
+{
+	int cpu = cpu_of(rq_of(cfs_rq));
+
+	return cfs_rq->tg->se[cpu];
+}
+
 #else
 
 static inline struct task_struct *task_of(struct sched_entity *se)
-- 
2.32.0

