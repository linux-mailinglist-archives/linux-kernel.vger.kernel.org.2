Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E499386FD6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 04:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240963AbhERCND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 22:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238402AbhERCNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 22:13:02 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30355C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 19:11:45 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id e19so6290013pfv.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 19:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=+D9nlyTkLc+T399c2HhuSn2qdLoNSxsrRHFSovm03rw=;
        b=M7/R1LebKnVsrIxGAmoDr2NaFo7LancdIryd7lA1WF5EDclYcbogzbbNcF717AjuPC
         Z7jV3QxziJFUjeXQkhZGoIIFBFx/+ospAsQjpzE2iTL2H1ekWbYLz36eCJjZxiX+Qd19
         6aXC71Gvzc9OVSBP90Uwe406RwazzvRksQ/XwRa9ZmZsqDMT4LgLXrEod5ibR3IwZQ++
         iUAUxT4uM8MrIXMu/Nn4FniARNez3pG0mtUb3R8TGQ+Fjsa4cdygqcpnN1ciazP3CpmC
         6dQUDPbh7WY5lX66kwNM3jur0htnbYFQrsDwvfmPoXIjrn3Xhf4rCITO4V0ggZujE5c4
         GMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=+D9nlyTkLc+T399c2HhuSn2qdLoNSxsrRHFSovm03rw=;
        b=Xhc0R3qvsfcJ/svSZGIqChxfjSpfRP914CkWwFtB/e6FTHavKcceHbIg+s8th0MvQi
         g+myM7FDdMYVnR94CgiIrob0HIze2aP7PxoZatnD6qbg9DmIPaxYOiO5uy/TJJZgQqtB
         ZvepfhIK2EC5/p2SBDyZkEVW6e7uxHMi+iDcqYtVV2F1H3KvIb+iSm7HGpY/PpTkL7DA
         R7Yhe7wPgHepJKHH1kDjCCcAGjVwrkH+29oXpeZsHoY36nETjnFHK76BcmFUJKDrWd7o
         FMNJj0LEUVQOAOsarPbc2MUm5xQDfGhEpCHzVE7XqzQgH9+7cfLANhuAs3oT1P+B5kT3
         z+ZA==
X-Gm-Message-State: AOAM5317LUQWWaEAXyUx3H3Ag+RFgcO90rvJI4bgQoaTyv/eD8ldbnlL
        Iv1xsFzqT/mmsj3xW8kz35s=
X-Google-Smtp-Source: ABdhPJwPjncoSTo36XsJFUpYCKAcEKLjREbIEaZNy5EZTXTEv4TgsSt2KsHpJdYen6aru6Zv6oyUjg==
X-Received: by 2002:a63:f40d:: with SMTP id g13mr2623448pgi.290.1621303904704;
        Mon, 17 May 2021 19:11:44 -0700 (PDT)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id b12sm7929518pgs.52.2021.05.17.19.11.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 May 2021 19:11:44 -0700 (PDT)
From:   Huangzhaoyang <huangzhaoyang@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Ziwei Dai <ziwei.dai@unisoc.com>, Ke Wang <ke.wang@unisoc.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] psi: fix race between psi_trigger_create and psimon
Date:   Tue, 18 May 2021 10:10:11 +0800
Message-Id: <1621303811-5716-1-git-send-email-huangzhaoyang@gmail.com>
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
+++
v2: change del_timer_sync to del_timer in psi_trigger_destroy
+++
---
 kernel/sched/psi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index cc25a3c..fe29022 100644
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
@@ -1233,7 +1236,7 @@ static void psi_trigger_destroy(struct kref *ref)
 		 * But it might have been already scheduled before
 		 * that - deschedule it cleanly before destroying it.
 		 */
-		del_timer_sync(&group->poll_timer);
+		del_timer(&group->poll_timer);
 		kthread_stop(task_to_destroy);
 	}
 	kfree(t);
-- 
1.9.1

