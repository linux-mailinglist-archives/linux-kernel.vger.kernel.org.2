Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEB8389B10
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 03:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhETB6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 21:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhETB6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 21:58:16 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C08C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 18:56:55 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id i6so3275385plt.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 18:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Lgl0cv/wVzwpPYK6a0cOoSV7HY60D3Mo0N3f4ZIIZEE=;
        b=nL2gmU5Fwjuh3Ak9YsU9AWkYQhCUvYWt8hROBHmEivHlrwcupEs6rqTgNF9oG5h0nU
         962DZE3ScQ8ri+2BkyF6oyfLaLawc6KvGMn//Zw2NhmEy7tgr622V1dfdNgedI1KmwVH
         CYrt94pi9BkluA7PfFW3HETi+j/nxn/AaRFaFbOKJeAsM3njHHULLVSxJY9HPA+SZgDK
         IlFimatxvVWwBhxb4VKmhxlOXtxYg/lG8Xdup8QNdLumElF8uHQK2op7Zsy+BO6g1pi0
         skVZ90ty+0sb7chYAqyNmTRhNAnbKFxh8Qyfj0G6dK+ExOXD0ojP2m3HsVgkZM2m0HNO
         LEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Lgl0cv/wVzwpPYK6a0cOoSV7HY60D3Mo0N3f4ZIIZEE=;
        b=Y0w2/LIDajf1COFll3bgjx8ixlrys3nBh8VcyMjhlxnGxZlKteI9cpb2Ox/b4aZvOd
         uOPS7dG1D/xqEGSZvsuzlLwcdB7xn00Bz2zF4XB9i4TfA32/Nz1ltu/TyfedsfZkWKBf
         AapUlVimWUXLLUWW123oIVW7tW7bDPQIro+mXebbZvZuYtiWQdOrGRz9J8lMkDBQd51Q
         Zlhr/oa8dadndBOUySlJHpi1V1TENaqYBhNiDbLkjuglbVVQQysju8q2VIsCG9uhcyMI
         jTYaUgSZB5M7p1koF7glc80ZLURRM/VawmBFmrnmsy7oz/3gQ1Gzmv/Zb9w4tsO6eyY8
         CA/w==
X-Gm-Message-State: AOAM531VqOZSBmw4nt1eIV1fxlK8gR/cK5LCzWVQU2ymo7ClOsdBYWY/
        6b2CTl1q/QdLJzav17eJaWo=
X-Google-Smtp-Source: ABdhPJygZ0bxJ3+pLdLbhHASvOsOqhKnBeuuX6zpKFpQGGgNBqSVYNd7hLm3odfA+ZSseMXv34DtPQ==
X-Received: by 2002:a17:902:d204:b029:f0:b65d:a14d with SMTP id t4-20020a170902d204b02900f0b65da14dmr2924938ply.25.1621475815040;
        Wed, 19 May 2021 18:56:55 -0700 (PDT)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id t24sm5035234pji.56.2021.05.19.18.56.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 May 2021 18:56:54 -0700 (PDT)
From:   Huangzhaoyang <huangzhaoyang@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Ziwei Dai <ziwei.dai@unisoc.com>, Ke Wang <ke.wang@unisoc.com>,
        linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH v5] psi: fix race between psi_trigger_create and psimon
Date:   Thu, 20 May 2021 09:55:29 +0800
Message-Id: <1621475729-22857-1-git-send-email-huangzhaoyang@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Race detected between psimon_new and psimon_old as shown below, which
cause panic by accessing invalid psi_system->poll_wait->wait_queue_entry
and psi_system->poll_timer->entry->next. Under this modification, the
race window is removed by initialising poll_wait and poll_timer in
group_init which are executed only once at beginning.

psi_trigger_create      psimon_new     psimon_old
 init_waitqueue_head                    finish_wait
                                          spin_lock(lock_old)
  spin_lock_init(lock_new)
 wake_up_process(psimon_new)

                        finish_wait
                          spin_lock(lock_new)
                            list_del       list_del

Fixes: 461daba06bdc ("psi: eliminate kthread_worker from psi trigger
scheduling mechanism")

Signed-off-by: ziwei.dai <ziwei.dai@unisoc.com>
Signed-off-by: ke.wang <ke.wang@unisoc.com>
Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
v2: change del_timer_sync to del_timer in psi_trigger_destroy
v3: remove timer_setup within psi_tirgger_create
    protect del_timer by extending the critical section of mutex_lock
v4: amend fix information on comment
v5: delete the poll_timer while assigning the task to NULL
---
---
 kernel/sched/psi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index cc25a3c..075501e 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -182,6 +182,8 @@ struct psi_group psi_system = {
 
 static void psi_avgs_work(struct work_struct *work);
 
+static void poll_timer_fn(struct timer_list *t);
+
 static void group_init(struct psi_group *group)
 {
 	int cpu;
@@ -201,6 +203,8 @@ static void group_init(struct psi_group *group)
 	memset(group->polling_total, 0, sizeof(group->polling_total));
 	group->polling_next_update = ULLONG_MAX;
 	group->polling_until = 0;
+	init_waitqueue_head(&group->poll_wait);
+	timer_setup(&group->poll_timer, poll_timer_fn, 0);
 	rcu_assign_pointer(group->poll_task, NULL);
 }
 
@@ -1157,9 +1161,7 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
 			return ERR_CAST(task);
 		}
 		atomic_set(&group->poll_wakeup, 0);
-		init_waitqueue_head(&group->poll_wait);
 		wake_up_process(task);
-		timer_setup(&group->poll_timer, poll_timer_fn, 0);
 		rcu_assign_pointer(group->poll_task, task);
 	}
 
@@ -1211,6 +1213,7 @@ static void psi_trigger_destroy(struct kref *ref)
 					group->poll_task,
 					lockdep_is_held(&group->trigger_lock));
 			rcu_assign_pointer(group->poll_task, NULL);
+			del_timer(&group->poll_timer);
 		}
 	}
 
@@ -1223,17 +1226,14 @@ static void psi_trigger_destroy(struct kref *ref)
 	 */
 	synchronize_rcu();
 	/*
-	 * Destroy the kworker after releasing trigger_lock to prevent a
+	 * Destroy psimon after releasing trigger_lock to prevent a
 	 * deadlock while waiting for psi_poll_work to acquire trigger_lock
 	 */
 	if (task_to_destroy) {
 		/*
 		 * After the RCU grace period has expired, the worker
 		 * can no longer be found through group->poll_task.
-		 * But it might have been already scheduled before
-		 * that - deschedule it cleanly before destroying it.
 		 */
-		del_timer_sync(&group->poll_timer);
 		kthread_stop(task_to_destroy);
 	}
 	kfree(t);
-- 
1.9.1

