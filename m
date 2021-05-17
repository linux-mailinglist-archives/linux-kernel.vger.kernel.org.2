Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1063B3827C6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbhEQJGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhEQJGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:06:50 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9B0C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:05:34 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id t193so4214223pgb.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=Gr47BrhR/b4EoJ2bOQxF4uUWqli/T+JeQ1G4Rm+7l7w=;
        b=aPWF+ekSQfm3KMWRaX1DnCXiFW0Lu//59V6JcPjpIG08+eGQhF+griH5nDYfXFqCsx
         iTQzv+LRTnahpLKEWmGH/tmKJ57+buFVLsScB6v5zk79qy6mxPRyWyQHVPUFnSUnMI67
         4PUFheLa0ThG2/MDJVjBdlnFwvz4x3EeDdBakHvomPkPWz3B6JNA2+rSteiexUcO9p5v
         UadDGNDfSngp5vTI+7fuefaBYO+s17PSAw5OUQR42sRyWzF99U5JGbnDesuoU8yGunOC
         PH/oEpGO8NpA0q8KU/NBbLqk29L1/KuWPyQg5YryUHSl4MQ81zBYa/+NhKncI9lae/ye
         RHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=Gr47BrhR/b4EoJ2bOQxF4uUWqli/T+JeQ1G4Rm+7l7w=;
        b=t0Z/fJMClEKKYxnN0uMCwyZQwdgeA+PxwwNiZPanWw82zQNrDAJfl9bzBVLAt4Il2k
         xA9+HMRnng1/zT4OzEJKOXUsCLCBe9cIzKjdmCGnwVF0XGRM3sSM9RVPldrla28dTtW0
         6RqS8RYBplkyEOnXPTuQUtuZ2WkmfmkSZLHRSWC7k5GmZAnlK3bwZtegZegrqVfKbWDS
         CeH7shVi1P/zSmKprIWKaj1MPA+era2LBucyfsFuKzyzhKnL2KVoRXsctHaM6IBXQP1e
         L7J2PCp8CK7Di+705BYy+NuJV4uXi1Bx/m9GcJE6InR8qQSKcaiCFbBtJAnR4B3OFDjt
         CrqQ==
X-Gm-Message-State: AOAM530nTVdbG7Y2CK7tR0BraZOg1uWtt+TVTwO+XzfGJ8xauNv5X91/
        WrMu3tUboFfHaVx98VbxOkkUiasqPMfqqQ==
X-Google-Smtp-Source: ABdhPJwDvRFe5PKaO3t1qF6WA8O0o6jda4eR+gY/exNFVUKBCcqai2NHXp+o/D/S1caVyhqkIWXZcw==
X-Received: by 2002:aa7:9f8f:0:b029:2dc:76bc:edce with SMTP id z15-20020aa79f8f0000b02902dc76bcedcemr2890828pfr.29.1621242333670;
        Mon, 17 May 2021 02:05:33 -0700 (PDT)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id n21sm1981133pfu.99.2021.05.17.02.05.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 May 2021 02:05:33 -0700 (PDT)
From:   Huangzhaoyang <huangzhaoyang@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Ziwei Dai <ziwei.dai@unisoc.com>, Ke Wang <ke.wang@unisoc.com>,
        linux-kernel@vger.kernel.org
Subject: [[RFC]PATCH] psi: fix race between psi_trigger_create and psimon
Date:   Mon, 17 May 2021 17:04:09 +0800
Message-Id: <1621242249-8314-1-git-send-email-huangzhaoyang@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Race detected between psimon_new and psimon_old as shown below, which
cause panic by accessing invalid psi_system->poll_wait->wait_queue_entry
and psi_system->poll_timer->entry->next. It is not necessary to reinit
resource of psi_system when psi_trigger_create.

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
 kernel/sched/psi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index cc25a3c..d00e585 100644
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
 
@@ -1157,7 +1161,6 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
 			return ERR_CAST(task);
 		}
 		atomic_set(&group->poll_wakeup, 0);
-		init_waitqueue_head(&group->poll_wait);
 		wake_up_process(task);
 		timer_setup(&group->poll_timer, poll_timer_fn, 0);
 		rcu_assign_pointer(group->poll_task, task);
@@ -1233,7 +1236,6 @@ static void psi_trigger_destroy(struct kref *ref)
 		 * But it might have been already scheduled before
 		 * that - deschedule it cleanly before destroying it.
 		 */
-		del_timer_sync(&group->poll_timer);
 		kthread_stop(task_to_destroy);
 	}
 	kfree(t);
-- 
1.9.1

