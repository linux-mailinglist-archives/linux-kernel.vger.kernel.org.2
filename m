Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5102438BC27
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 04:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238029AbhEUCB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 22:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237368AbhEUCBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 22:01:54 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5708DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 19:00:32 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x18so9483207pfi.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 19:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=g+YS7h4l6QuSOjaD3+CpMVe7LGzJXRPA6F3sn/LTdRM=;
        b=B6k4mT2xFCfUMNk3s6g5dC/uWSa+ptn3NXUHwqm5v5DUe4cGEC9jczDlqVEuK6rrEq
         /WATzP3lkdN6a1a4ZoUSgdeAarFV+USnIyLT/ee/FLe+SPwqM70rjGzkDO/sQewAGJsq
         Vw8ZEaFLlASikx4pKTX97c0MJRa0o1LEDtyjT+x0rIZRNwvUlOBSHLCXgNjbY76j1sBg
         JGJwDpf3COS6OhE7+jiZK4MCShBNuPq/CYFMM0Ou5+YsITa3gGDbKS1cAhNLbnGqZ/ho
         jYUNEduH1FEovZSZ9uXQO2LnPdiY80OwB59HDt91Wo0H9Xffga8ECKtnCkio+rpc5LVY
         HvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=g+YS7h4l6QuSOjaD3+CpMVe7LGzJXRPA6F3sn/LTdRM=;
        b=t0Nz/i2vBNMrpBX0b2TWEeMsK/0lHpvqN/6ks5Hmfxg+WvLrohc3cZhfUfXu4sV2PS
         Ef3S/BLm8owDTLNgd68rJqCpkSci2VBcXzqjog72G1f+h7N0+HrroZsZAqKxC6NRf6Uk
         VwVonabwniIvQLwaEbuiY44GbGnP0S6hpeOZtX7FPiJu0ZA5uipZpCB95B1GmFRHG72o
         TSPiUfimKNff9Z9ZfIHP9mqQ5j9jHgxgtti6+ttIq4FNXPk6UrP9mdx1YENm35VumOYC
         UWE6UBEYDuYiLU0iaiifKF4ZD8JVNpdn7bzWZttjR7ERDwZtUqg9shq5jYXEwhFYfY2A
         mqkg==
X-Gm-Message-State: AOAM532lw9hw0hzp/WrzDdRW4+c9BDhv7RDyUX9a759LkRgWMOIYiX4F
        vIn+qv7Epq6nSq2OxktoM1w=
X-Google-Smtp-Source: ABdhPJxxjNnv1ayjbijXuQ8TmCNBbxr9/IUwonar+7tw9bO5N6zC76zsO22mdHgFLgWjIIP0slZeBg==
X-Received: by 2002:aa7:8491:0:b029:2dc:b1cc:5532 with SMTP id u17-20020aa784910000b02902dcb1cc5532mr7666187pfn.3.1621562431808;
        Thu, 20 May 2021 19:00:31 -0700 (PDT)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id y14sm7375547pjr.51.2021.05.20.19.00.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 May 2021 19:00:30 -0700 (PDT)
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
Date:   Fri, 21 May 2021 09:59:03 +0800
Message-Id: <1621562343-8033-1-git-send-email-huangzhaoyang@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Race detected between psi_trigger_destroy/create as shown below, which
cause panic by accessing invalid psi_system->poll_wait->wait_queue_entry
and psi_system->poll_timer->entry->next. Under this modification, the
race window is removed by initialising poll_wait and poll_timer in
group_init which are executed only once at beginning.

psi_trigger_destroy                      psi_trigger_create
mutex_lock(trigger_lock);
rcu_assign_pointer(poll_task, NULL);
mutex_unlock(trigger_lock);
					mutex_lock(trigger_lock);
					if (!rcu_access_pointer(group->poll_task)) {

						timer_setup(poll_timer, poll_timer_fn, 0);

						rcu_assign_pointer(poll_task, task);
					}
					mutex_unlock(trigger_lock);

synchronize_rcu();
del_timer_sync(poll_timer); <-- poll_timer has been reinitialized by
psi_trigger_create

So, trigger_lock/RCU correctly protects destruction of group->poll_task but
misses this race affecting poll_timer and poll_wait.

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

