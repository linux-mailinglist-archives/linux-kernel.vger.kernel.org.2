Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12FCE371EE1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 19:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhECRuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 13:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhECRuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 13:50:14 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2BDC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 10:49:20 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id i67so2793387qkc.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 10:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=px9JwR74/bTPwn0UoWBvquYLMAYEbFs8/lK92VClKzo=;
        b=dWdCr/MLTjCiUzt2xEIBacRzgkQbmQFG8s2VKZ6dfClQjeqaiwKd9BmmnfQxlwMaZF
         Gh5/+IT1kb+lec6jYWZsMacsc/0r3uPb2+F5H5VGdBNVxjsA9SY7MR3zZa/vH+gUzycY
         9w1bVqt1AUKgIrri6H9rlvaRyWpMO7jlJVAHfOVtLurOnc8x8fUQXSaR9AcAKSBurTWo
         y+RsYuxlna1wMn1exVQ4FhuKWAW2RCOK94XU/nq7WvSU5jfK8Z+EP4ITTLm+EeM1htPb
         e2uWCQn/TDY0aAah5DWjWUcnG1hQUZ8G9CZjGab4Jf7XuoOUq6e6QZHF+V6S0vsGSq5O
         jNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=px9JwR74/bTPwn0UoWBvquYLMAYEbFs8/lK92VClKzo=;
        b=V1mu2tsSabVuZKVblXYcr3IOeijTgRAyF6bzc46713PLSX/X76trLUOPzah3Sf8rdT
         V3Wab9Wrn5T6YHm3VB/lmCGOQ8yzpg4Cp4tK1m9rXGG1rR/pSsC1QRDNFQUKg0+P2I8C
         3+zSiztNuel2Ue+7/eei36G5IY8zb0VX+Ulf4cAmGUhf0Nmlf0mZDCqgJTjPJY1tLv0/
         XQKMErv7zBSLLZFTrAwAbAcVGWNgIXPTTi2uzwCbfWR+0gdNB+ZV6WkSxemb3tjznQx3
         014cJp1A5KRksVUp1169iVwXaOx7lVHYzTScYHuueyf2msUXfaUKSgdFphzmApiHP8Wj
         uy+Q==
X-Gm-Message-State: AOAM532IU+I/A4xRJAn4vOgFBYTraegfMdCSjWoBXUeCvxooh+JsE0Ws
        q5wRtKPnvdtwSNfLNslgYu8w0EqnQCGVrA==
X-Google-Smtp-Source: ABdhPJxZtUYtu1Fnh8n4HEeda1pXYleiv9B79aqQgijBUUCwG2r/ZMz9k5Ouxyll2oi8qNYMUBC60A==
X-Received: by 2002:a37:992:: with SMTP id 140mr2876078qkj.194.1620064159506;
        Mon, 03 May 2021 10:49:19 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id c187sm8931704qkd.8.2021.05.03.10.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 10:49:18 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Rik van Riel <riel@surriel.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] psi: fix psi state corruption when schedule() races with cgroup move
Date:   Mon,  3 May 2021 13:49:17 -0400
Message-Id: <20210503174917.38579-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4117cebf1a9f ("psi: Optimize task switch inside shared cgroups")
introduced a race condition that corrupts internal psi state. This
manifests as kernel warnings, sometimes followed by bogusly high IO
pressure:

  psi: task underflow! cpu=1 t=2 tasks=[0 0 0 0] clear=c set=0
  (schedule() decreasing RUNNING and ONCPU, both of which are 0)

  psi: incosistent task state! task=2412744:systemd cpu=17 psi_flags=e clear=3 set=0
  (cgroup_move_task() clearing MEMSTALL and IOWAIT, but task is MEMSTALL | RUNNING | ONCPU)

What the offending commit does is batch the two psi callbacks in
schedule() to reduce the number of cgroup tree updates. When prev is
deactivated and removed from the runqueue, nothing is done in psi at
first; when the task switch completes, TSK_RUNNING and TSK_IOWAIT are
updated along with TSK_ONCPU.

However, the deactivation and the task switch inside schedule() aren't
atomic: pick_next_task() may drop the rq lock for load balancing. When
this happens, cgroup_move_task() can run after the task has been
physically dequeued, but the psi updates are still pending. Since it
looks at the task's scheduler state, it doesn't move everything to the
new cgroup that the task switch that follows is about to clear from
it. cgroup_move_task() will leak the TSK_RUNNING count in the old
cgroup, and psi_sched_switch() will underflow it in the new cgroup.

A similar thing can happen for iowait. TSK_IOWAIT is usually set when
a p->in_iowait task is dequeued, but again this update is deferred to
the switch. cgroup_move_task() can see an unqueued p->in_iowait task
and move a non-existent TSK_IOWAIT. This results in the inconsistent
task state warning, as well as a counter underflow that will result in
permanent IO ghost pressure being reported.

Fix this bug by making cgroup_move_task() use task->psi_flags instead
of looking at the potentially mismatching scheduler state.

[ We used the scheduler state historically in order to not rely on
  task->psi_flags for anything but debugging. But that ship has sailed
  anyway, and this is simpler and more robust.

  We previously already batched TSK_ONCPU clearing with the
  TSK_RUNNING update inside the deactivation call from schedule(). But
  that ordering was safe and didn't result in TSK_ONCPU corruption:
  unlike most places in the scheduler, cgroup_move_task() only checked
  task_current() and handled TSK_ONCPU if the task was still queued. ]

Fixes: 4117cebf1a9f ("psi: Optimize task switch inside shared cgroups")
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 kernel/sched/psi.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index db27b69fa92a..cc25a3cff41f 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -972,7 +972,7 @@ void psi_cgroup_free(struct cgroup *cgroup)
  */
 void cgroup_move_task(struct task_struct *task, struct css_set *to)
 {
-	unsigned int task_flags = 0;
+	unsigned int task_flags;
 	struct rq_flags rf;
 	struct rq *rq;
 
@@ -987,15 +987,31 @@ void cgroup_move_task(struct task_struct *task, struct css_set *to)
 
 	rq = task_rq_lock(task, &rf);
 
-	if (task_on_rq_queued(task)) {
-		task_flags = TSK_RUNNING;
-		if (task_current(rq, task))
-			task_flags |= TSK_ONCPU;
-	} else if (task->in_iowait)
-		task_flags = TSK_IOWAIT;
-
-	if (task->in_memstall)
-		task_flags |= TSK_MEMSTALL;
+	/*
+	 * We may race with schedule() dropping the rq lock between
+	 * deactivating prev and switching to next. Because the psi
+	 * updates from the deactivation are deferred to the switch
+	 * callback to save cgroup tree updates, the task's scheduling
+	 * state here is not coherent with its psi state:
+	 *
+	 * schedule()                   cgroup_move_task()
+	 *   rq_lock()
+	 *   deactivate_task()
+	 *     p->on_rq = 0
+	 *     psi_dequeue() // defers TSK_RUNNING & TSK_IOWAIT updates
+	 *   pick_next_task()
+	 *     rq_unlock()
+	 *                                rq_lock()
+	 *                                psi_task_change() // old cgroup
+	 *                                task->cgroups = to
+	 *                                psi_task_change() // new cgroup
+	 *                                rq_unlock()
+	 *     rq_lock()
+	 *   psi_sched_switch() // does deferred updates in new cgroup
+	 *
+	 * Don't rely on the scheduling state. Use psi_flags instead.
+	 */
+	task_flags = task->psi_flags;
 
 	if (task_flags)
 		psi_task_change(task, task_flags, 0);
-- 
2.31.0

