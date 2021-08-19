Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C86253F1F66
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 19:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbhHSRvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 13:51:42 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57856 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbhHSRvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 13:51:19 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D425122148;
        Thu, 19 Aug 2021 17:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629395441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qVI72MmhFZvIRWbMKiZkSMNfCWkJTo9zD2YlJdQgd7s=;
        b=Fv66jqXf+XpUn2cWz5mxhVnE4w8uB1Egn79UNvOotxDBeNpDDi0Fk2xzuZd/pclBm28LOe
        RgxXjdp9/HHWB200PFMu4gbz/kfFuSPJHVgphvSSTsdk8kiBLf8LWCDz0vRTE2ApbY7mzr
        FWUTADb6ITK+bE8tO7qzB/Qo5oZuY0o=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id ACE5013AB1;
        Thu, 19 Aug 2021 17:50:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id eLSzKfGZHmHnOQAAGKfGzw
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
Subject: [RFC PATCH v2 5/5] sched/fair: Simplify ancestor enqueue loops
Date:   Thu, 19 Aug 2021 19:50:34 +0200
Message-Id: <20210819175034.4577-6-mkoutny@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210819175034.4577-1-mkoutny@suse.com>
References: <20210819175034.4577-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a task is enqueued or cfs_rq is unthrottled we have work to do from
the cfs_rq in question possibly up to root. The important nodes on the
path are throttled cfs_rqs or cfs_rqs already enqueud to their parent.

Instead of multiple (interrupted) loops make all work in a single loop
and decide what all needs to be done inside it. This undoes parts of
commit 39f23ce07b93 ("sched/fair: Fix unthrottle_cfs_rq() for
leaf_cfs_rq list") but it should not bring any functional changes.

Note some PELT stats update code is duplicated both in enqueue_entity
and the ancestor loop (update_load_avg, se_update_runnable,
update_cfs_group). It'd be nice to factor these out, however, the later
parts of enqueue_entity rely on the updates, so stick with the current
repetition.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/sched/fair.c | 57 +++++++++++++++++----------------------------
 1 file changed, 21 insertions(+), 36 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9978485334ec..79f183336fa8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4883,6 +4883,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
 	long task_delta, idle_task_delta;
+	int enqueue = 1;
 
 	cfs_rq->throttled = 0;
 
@@ -4911,29 +4912,21 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	task_delta = cfs_rq->h_nr_running;
 	idle_task_delta = cfs_rq->idle_h_nr_running;
 	for_each_sched_entity(se) {
-		if (se->on_rq)
-			break;
 		cfs_rq = cfs_rq_of(se);
-		enqueue_entity(cfs_rq, se, ENQUEUE_WAKEUP);
-
-		cfs_rq->h_nr_running += task_delta;
-		cfs_rq->idle_h_nr_running += idle_task_delta;
 
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(cfs_rq))
-			goto unthrottle_throttle;
-	}
-
-	for_each_sched_entity(se) {
-		cfs_rq = cfs_rq_of(se);
-
-		update_load_avg(cfs_rq, se, UPDATE_TG);
-		se_update_runnable(se);
+		if (se->on_rq)
+			enqueue = 0;
+		if (enqueue)
+			enqueue_entity(cfs_rq, se, ENQUEUE_WAKEUP);
+		else {
+			update_load_avg(cfs_rq, se, UPDATE_TG);
+			se_update_runnable(se);
+			/* XXX: no update_cfs_group(se); */
+		}
 
 		cfs_rq->h_nr_running += task_delta;
 		cfs_rq->idle_h_nr_running += idle_task_delta;
 
-
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
 			goto unthrottle_throttle;
@@ -5537,6 +5530,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	struct sched_entity *se = &p->se;
 	int idle_h_nr_running = task_has_idle_policy(p);
 	int task_new = !(flags & ENQUEUE_WAKEUP);
+	int enqueue = 1;
 
 	/*
 	 * The code below (indirectly) updates schedutil which looks at
@@ -5555,27 +5549,18 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
 
 	for_each_sched_entity(se) {
-		if (se->on_rq)
-			break;
 		cfs_rq = cfs_rq_of(se);
-		enqueue_entity(cfs_rq, se, flags);
 
-		cfs_rq->h_nr_running++;
-		cfs_rq->idle_h_nr_running += idle_h_nr_running;
-
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(cfs_rq))
-			goto enqueue_throttle;
-
-		flags = ENQUEUE_WAKEUP;
-	}
-
-	for_each_sched_entity(se) {
-		cfs_rq = cfs_rq_of(se);
-
-		update_load_avg(cfs_rq, se, UPDATE_TG);
-		se_update_runnable(se);
-		update_cfs_group(se);
+		if (se->on_rq)
+			enqueue = 0;
+		if (enqueue) {
+			enqueue_entity(cfs_rq, se, flags);
+			flags = ENQUEUE_WAKEUP;
+		} else {
+			update_load_avg(cfs_rq, se, UPDATE_TG);
+			se_update_runnable(se);
+			update_cfs_group(se);
+		}
 
 		cfs_rq->h_nr_running++;
 		cfs_rq->idle_h_nr_running += idle_h_nr_running;
-- 
2.32.0

