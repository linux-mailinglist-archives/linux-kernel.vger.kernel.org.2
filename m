Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082433A38E6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 02:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhFKAka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 20:40:30 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]:39875 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhFKAk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 20:40:27 -0400
Received: by mail-qk1-f174.google.com with SMTP id j184so29342380qkd.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 17:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v7cRkz1o3mWW8E3oqxoOjtTQhIsf6T1PaqKVL1yXczY=;
        b=mLszUOE8xaPAV+5Ptb6jACxLUjlUicANhQYIncZ68/2C5oyUXlRH76TMyZk4ywVfhg
         6rU87wdRb3FrBBMfMQgi6AxowsDT5gZvnuSTw/Ee6zcdzUs+dGbN2NuCrw5M/8gfNKC0
         8z5V4baNDnK0v1IHx2oExlAxRWBQDic++wouQxBvFS0sFVuFEYMyAbHsrT9uLq6a3BLu
         IdwWfQCfN2z6ASicv7xP4IpthwVTzBtG+fNVOAxmIZCQsAqokigY6bZ/ibjn1JAuep32
         4372X5mIaWrpWyHSrVZBIlkzMFsHKyj+KyzHGqfaBgacogABTST8ATWl3lUpjb4iHV8W
         3PRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v7cRkz1o3mWW8E3oqxoOjtTQhIsf6T1PaqKVL1yXczY=;
        b=ISMbRq0zfKLZy9BptCzs8I9H9VFcfyF29iu0CfUwS8pBi6RbxVX+RCuRcGjD7wM5Ww
         3m5TsFJd7nHq1pnJEo9JC99VqRjdYKe223R9ybBJEk5KCrrLDc0BDRayZJdDyXcpe+HE
         2MeyBJctWNcUoFR7yeW40GIzDuQZsRlc3Eg1IsRJobE5ZqTt/ZL3csDq3+fhcQZBqn29
         nKzMtBDCJmIN8Xv1blyODyhh21kakIiBaqJfUI/X2woHk6mCOm8N55BjBlzb7rbjMDtr
         iEr8F9OBUKLJOs/Mkk63LDaGLdc1CTmN4r92g6mF9h/aEtQYBJGp7FQZRMIyT8RfAE8m
         2NGw==
X-Gm-Message-State: AOAM530C38GExQsy8Pvv4/yG2rBlwf1NhXOxqFTUEu5wAf7zcrGBV56O
        Wfy+/+eW6A2yBf8EsU1BlZn31GPHVDrncQJwZMI=
X-Google-Smtp-Source: ABdhPJxEhZgS3754SsvVRags7nboyrbcvBAUII5yTKHYlR8/iXPUqt+Lwa4emhssGt0cS19FO3W6iitVsyGTc3XLW9Y=
X-Received: by 2002:a37:8ac2:: with SMTP id m185mr1374639qkd.105.1623371836829;
 Thu, 10 Jun 2021 17:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <1623371374-15664-1-git-send-email-huangzhaoyang@gmail.com>
In-Reply-To: <1623371374-15664-1-git-send-email-huangzhaoyang@gmail.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Fri, 11 Jun 2021 08:37:05 +0800
Message-ID: <CAGWkznH34=fTybuJyd0H6ceB48EKLT77m4C2QkRNS5LhCc6h3w@mail.gmail.com>
Subject: [Resend PATCH v6] psi: fix race between psi_trigger_create/destroy
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Ziwei Dai <ziwei.dai@unisoc.com>, Ke Wang <ke.wang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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
                                        if
(!rcu_access_pointer(group->poll_task)) {


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

Co-developed-by: ziwei.dai <ziwei.dai@unisoc.com>
Signed-off-by: ziwei.dai <ziwei.dai@unisoc.com>
Co-developed-by: ke.wang <ke.wang@unisoc.com>
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
+       init_waitqueue_head(&group->poll_wait);
+       timer_setup(&group->poll_timer, poll_timer_fn, 0);
        rcu_assign_pointer(group->poll_task, NULL);
 }

@@ -1157,9 +1161,7 @@ struct psi_trigger *psi_trigger_create(struct
psi_group *group,
                        return ERR_CAST(task);
                }
                atomic_set(&group->poll_wakeup, 0);
-               init_waitqueue_head(&group->poll_wait);
                wake_up_process(task);
-               timer_setup(&group->poll_timer, poll_timer_fn, 0);
                rcu_assign_pointer(group->poll_task, task);
        }

@@ -1211,6 +1213,7 @@ static void psi_trigger_destroy(struct kref *ref)
                                        group->poll_task,
                                        lockdep_is_held(&group->trigger_lock));
                        rcu_assign_pointer(group->poll_task, NULL);
+                       del_timer(&group->poll_timer);
                }
        }

@@ -1223,17 +1226,14 @@ static void psi_trigger_destroy(struct kref *ref)
         */
        synchronize_rcu();
        /*
-        * Destroy the kworker after releasing trigger_lock to prevent a
+        * Stop kthread 'psimon' after releasing trigger_lock to prevent a
         * deadlock while waiting for psi_poll_work to acquire trigger_lock
         */
        if (task_to_destroy) {
                /*
                 * After the RCU grace period has expired, the worker
                 * can no longer be found through group->poll_task.
-                * But it might have been already scheduled before
-                * that - deschedule it cleanly before destroying it.
                 */
-               del_timer_sync(&group->poll_timer);
                kthread_stop(task_to_destroy);
        }
        kfree(t);
--
1.9.1
