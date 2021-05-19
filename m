Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 801693884BC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 04:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbhESCX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 22:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhESCX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 22:23:58 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A495BC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 19:22:39 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id k5so6548843pjj.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 19:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4Zpngmydwic9UicmgMclapi20CDhN5rKcwlXsgm25ec=;
        b=B+s1SJ/TtS7Z/mLELrPZ6YBtqTRxCPzeyadoxdyDh9ViP/9hEQoMy0CllH5oMG0pNo
         VyC5KSIKzwMU/ZR98AyhtEqejYEE/IjsuF/7k0kzshQ4g3C09cW2GG2Pk3aL2VbGuNHp
         Nv8gWuSODpLzd7pabDUZ1eEBJinpTGBMDmO+nLSC9enVbigo1jzRgyC+pMFx3pK9rQsy
         VcrQ04cK3dxZWjRVbN2ehQ0LQpivD128FgrElcvG0xJw9KLKu3WFUVTyXrHnevBxP13h
         pSryBv3/V3/+nAEsek5MA6up/2OkGWMqV4/cXL52znpp+wqpotxOj4G62SnH9ocD2Jnl
         HKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4Zpngmydwic9UicmgMclapi20CDhN5rKcwlXsgm25ec=;
        b=ijVtOOS7wyMhSynw26SNx8E0IqqosTaN1klpKVFE79sRoCT/suDKddz8nC8m5FYsC7
         JYhsQ5+hGwwkYHCsKcklttiYInTBpWP714QsdDkrtxYK8VmVqqGqnxf4tRYsASXu5rPf
         kuYKJsRajQh5QI6xO/CbNc74fDQAkvP6OWpcs6mvSlQdoE7X394s6NwLZ6Ry/CzD4OVN
         VPUqQiO931/kLiqFPzkb8g8zkbDrp4N4MR+XEcZFl+Z2LlX326CzcT6UOKZNq/OU8DLj
         jBtnoBsSP0QPtuzawL5HFEBnAq1/J1iU5OQKZ4S0Y1Yz3MjjWB8kQv3HQVvapbs9Cb3Q
         hC6g==
X-Gm-Message-State: AOAM530hPGbZJtPLBvDetsTf4+zjJZ+Rg3BL97jiLV2JDgEsCjAsD5y5
        12Kk133kYUBk9RsizRe6GRq1Z0IQHyIuCA==
X-Google-Smtp-Source: ABdhPJyvggJgxcWyK8fm80OT2EzvhsyQT3kJ/ILPTlJFuu8CFSDT8qVWMrxhqFlvTiw35eu7dSAsaw==
X-Received: by 2002:a17:90a:ca05:: with SMTP id x5mr8694616pjt.16.1621390959189;
        Tue, 18 May 2021 19:22:39 -0700 (PDT)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id a10sm4698897pfg.173.2021.05.18.19.22.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 May 2021 19:22:38 -0700 (PDT)
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
Subject: [PATCH v4] psi: fix race between psi_trigger_create and psimon
Date:   Wed, 19 May 2021 10:21:00 +0800
Message-Id: <1621390860-6350-1-git-send-email-huangzhaoyang@gmail.com>
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

