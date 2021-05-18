Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1CA3874CD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242915AbhERJKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242352AbhERJKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:10:50 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9F8C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 02:09:33 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id t193so6574384pgb.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 02:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IKuoT5nKuLm4nCvjaFH9akFazgyohMpWaEbqiBhEoS8=;
        b=er8IQOKHN3ADm6FUvQrnuF0uTcji/JQG63CRZhpm09pdo9hEOIVphFQrABWMgbyaH/
         Z/nsZUZzavwAmMSCEwjj6afj2LRYW/8G4T0SX9EIBJ/P/MkEj0mBhJNyxjcSq5wE4VMB
         cKzxavQbcDOU8WeCJa4XmZ0kSHA4lkuKFfDc5gQFSp7BCRRArxgiN9Z26R5vEBTaxXy3
         PWQ9v5llXxICqICNbM0GnaMzENgK5Q9tYEcBRdEagjE7XKee6P5fkIanyHseK1DXSrJF
         Tg4LB1jzUDpDltSqNl+ZymF1R0EgveTJNGVZjEpt5xfjkVd+1UjgQEnXm1wCbEc+ZXR5
         iFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IKuoT5nKuLm4nCvjaFH9akFazgyohMpWaEbqiBhEoS8=;
        b=A9TFL5sLH/6+Ysczj/C05VqSdewrRrPsO1jDGhecO3ZrY8EQeEXOLf9oQ4BX8NEbcK
         V+/QAYqDLSB/BQu7YcNqq+NBXvOT2XoZRAgUIzUh3bfMMU4CvBc/MqY8TUqsjK5OJW3S
         BuLXvQs6k3yNDDKCdbp9DhKj0Bg5qGHPU+TDkVklmDpGCMexiqlBfjiR6MuBvQbG1/8p
         xM0hCcpvKT4a3e+QssKPzLDKBjMhgw3uMAjBRRs7mfznwPdOtA8nvE56BTfqRlkTC8Oc
         X7U5DLMH4Q1bFHZLd6OrMh7oA9sPepvMkY0uvF3GjJEZB3idm/Hj0IuPuPEOvdMCVcxk
         jWsw==
X-Gm-Message-State: AOAM530TiXafkBYEb6a1dZj2Ju/G26t17NnKm1aqQoBYENmqJMvyiNtB
        3+CKfcGlfcfVGMq5dLETsaU=
X-Google-Smtp-Source: ABdhPJw3gHUSXUH2tED4CevcMBuairBkOmmTvQtvD4u07VHuGXOvyXVQPI3/gsINT+V3wQX59tUttQ==
X-Received: by 2002:aa7:8686:0:b029:2db:7eea:8fb4 with SMTP id d6-20020aa786860000b02902db7eea8fb4mr4052806pfo.34.1621328972799;
        Tue, 18 May 2021 02:09:32 -0700 (PDT)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id t19sm11895723pfg.70.2021.05.18.02.08.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 May 2021 02:09:32 -0700 (PDT)
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
Subject: [PATCH v3] psi: fix race between psi_trigger_create and psimon
Date:   Tue, 18 May 2021 17:06:56 +0800
Message-Id: <1621328816-21332-1-git-send-email-huangzhaoyang@gmail.com>
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

Signed-off-by: ziwei.dai <ziwei.dai@unisoc.com>
Signed-off-by: ke.wang <ke.wang@unisoc.com>
Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
v2: change del_timer_sync to del_timer in psi_trigger_destroy
v3: remove timer_setup within psi_tirgger_create
    protect del_timer by extending the critical section of mutex_lock
---
---
 kernel/sched/psi.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index cc25a3c..7b53217 100644
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
 
@@ -1214,16 +1216,8 @@ static void psi_trigger_destroy(struct kref *ref)
 		}
 	}
 
-	mutex_unlock(&group->trigger_lock);
-
-	/*
-	 * Wait for both *trigger_ptr from psi_trigger_replace and
-	 * poll_task RCUs to complete their read-side critical sections
-	 * before destroying the trigger and optionally the poll_task
-	 */
-	synchronize_rcu();
 	/*
-	 * Destroy the kworker after releasing trigger_lock to prevent a
+	 * Destroy psimon after releasing trigger_lock to prevent a
 	 * deadlock while waiting for psi_poll_work to acquire trigger_lock
 	 */
 	if (task_to_destroy) {
@@ -1233,9 +1227,20 @@ static void psi_trigger_destroy(struct kref *ref)
 		 * But it might have been already scheduled before
 		 * that - deschedule it cleanly before destroying it.
 		 */
-		del_timer_sync(&group->poll_timer);
+		del_timer(&group->poll_timer);
+		mutex_unlock(&group->trigger_lock);
 		kthread_stop(task_to_destroy);
+	} else {
+		mutex_unlock(&group->trigger_lock);
 	}
+
+	/*
+	 * Wait for both *trigger_ptr from psi_trigger_replace and
+	 * poll_task RCUs to complete their read-side critical sections
+	 * before destroying the trigger and optionally the poll_task
+	 */
+	synchronize_rcu();
+
 	kfree(t);
 }
 
-- 
1.9.1

