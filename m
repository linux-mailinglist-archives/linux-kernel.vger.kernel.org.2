Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A6838BC46
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 04:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238379AbhEUCIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 22:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbhEUCIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 22:08:47 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A11BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 19:07:24 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id lx17-20020a17090b4b11b029015f3b32b8dbso4728810pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 19:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XQC3eHTZZ2Kq4lpuBmx7B6rPqlssJUOcU0MyknfHKdM=;
        b=CowNc6SaX8w7shKBJtCWz0yby6+fx0kHgH2xxqs2NT6uzhiPBi+xJhtHFOJ8EbFb5W
         g2VH9VaG1fWl9gFGvqf5poGOgQ5SY7ZM37PCMZk8UiViQs/andX4LzYtsQLPJxHXkyuZ
         O8VKv19PBqbdnYvv1T8HdBsVU/uBveyivy1bNr5d2fnLVPgHSNCSzLsPRo/6AHLstYEG
         E8YRaU/sDNOeKwf67ljcrCmTLs1Qq3/7t6o6RQ3zziyeP4PeWrnG3Eb1IGPgl0/ZpikT
         FBFUnL64P2+B305nGT6U9TnfV/tM3GtwUqX4OaQry2vJIBgRH6CutFHhmCtrsLUeQDVg
         FpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XQC3eHTZZ2Kq4lpuBmx7B6rPqlssJUOcU0MyknfHKdM=;
        b=rChWafSp2DTye8EWHkWy9WO/JvOyaKqcEQqvYR1kIkj2+6r5sNaNxCX8EWp4R237w3
         a21JRRzQrwFLbfgPV9JRYzGyXU8FQ6ue5ejDngznF2ueMozpbcjfMOY/RQV8Q1cKoyiZ
         XkmSvPaFRmN4ciKgD9+j29QqVhLNA9eQajFMyzWGpHFvBhySt6WZHNu+owR2iNLDFsn7
         MAazGAuwhvcS2vvkqdp9okQZWODt8rTALW6s6qG3dEE1rcOQ0TTPFYjjEmqM98t1iaZG
         EJ2V6fn1Wld28suRp/0xgmKyG3j5u7PZZrzVWDAMQJGzPnF68hluBLPZ8otZ7s/WsJQ2
         FiBg==
X-Gm-Message-State: AOAM532w//KSSMe2KZkispLVlEq4zb3Cy88bWJ5XsMawwc7kwGeMas3y
        46EI3u0E7KU+17UkHJHix5Y=
X-Google-Smtp-Source: ABdhPJxQZ0rHtYTza1uhQ/LjwYtFsrjh8lL0C72Mepiyu3qf1tZRYVSa8LWmzuVDvVSCK/yCRBGm+g==
X-Received: by 2002:a17:903:2289:b029:f6:a853:c4f5 with SMTP id b9-20020a1709032289b02900f6a853c4f5mr3499399plh.51.1621562843606;
        Thu, 20 May 2021 19:07:23 -0700 (PDT)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id a15sm2791224pff.128.2021.05.20.19.07.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 May 2021 19:07:23 -0700 (PDT)
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
Subject: [PATCH v6] psi: fix race between psi_trigger_create/destroy
Date:   Fri, 21 May 2021 10:05:54 +0800
Message-Id: <1621562754-8158-1-git-send-email-huangzhaoyang@gmail.com>
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
v6: update subject and comments as Suren's suggestion
---
---
 kernel/sched/psi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index cc25a3c..58b36d1 100644
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
+	 * Stop kthread 'psimon' after releasing trigger_lock to prevent a
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

