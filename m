Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C2733D377
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 13:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237564AbhCPMAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 08:00:07 -0400
Received: from mail-m118208.qiye.163.com ([115.236.118.208]:55294 "EHLO
        mail-m118208.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbhCPL7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 07:59:38 -0400
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by mail-m118208.qiye.163.com (Hmail) with ESMTPA id 5E8F1E02C2;
        Tue, 16 Mar 2021 19:59:35 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] sched: rename __prepare_to_swait() to add_swait_queue_locked()
Date:   Tue, 16 Mar 2021 19:59:29 +0800
Message-Id: <1615895969-3376-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQ08aTRoZQxoeQkoZVkpNSk5DQk5CTE5DT09VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hNSlVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pio6GCo4MT8UMUorHT45KB8R
        EzxPCQxVSlVKTUpOQ0JOQkxNSU9OVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFITE5KNwY+
X-HM-Tid: 0a783ae7d74b2c17kusn5e8f1e02c2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function just puts wait into queue, and does not do an operation similar 
to prepare_to_wait() in wait.c. 
And during the operation, the caller needs to hold the lock to protect.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 kernel/sched/completion.c | 2 +-
 kernel/sched/sched.h      | 2 +-
 kernel/sched/swait.c      | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index a778554..3d28a5a
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -79,7 +79,7 @@ do_wait_for_common(struct completion *x,
 				timeout = -ERESTARTSYS;
 				break;
 			}
-			__prepare_to_swait(&x->wait, &wait);
+			add_swait_queue_locked(&x->wait, &wait);
 			__set_current_state(state);
 			raw_spin_unlock_irq(&x->wait.lock);
 			timeout = action(timeout);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 10a1522..0516f50
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2719,4 +2719,4 @@ static inline bool is_per_cpu_kthread(struct task_struct *p)
 #endif
 
 void swake_up_all_locked(struct swait_queue_head *q);
-void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
+void add_swait_queue_locked(struct swait_queue_head *q, struct swait_queue *wait);
diff --git a/kernel/sched/swait.c b/kernel/sched/swait.c
index 7a24925..f48a544
--- a/kernel/sched/swait.c
+++ b/kernel/sched/swait.c
@@ -82,7 +82,7 @@ void swake_up_all(struct swait_queue_head *q)
 }
 EXPORT_SYMBOL(swake_up_all);
 
-void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait)
+void add_swait_queue_locked(struct swait_queue_head *q, struct swait_queue *wait)
 {
 	wait->task = current;
 	if (list_empty(&wait->task_list))
@@ -94,7 +94,7 @@ void prepare_to_swait_exclusive(struct swait_queue_head *q, struct swait_queue *
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&q->lock, flags);
-	__prepare_to_swait(q, wait);
+	add_swait_queue_locked(q, wait);
 	set_current_state(state);
 	raw_spin_unlock_irqrestore(&q->lock, flags);
 }
@@ -114,7 +114,7 @@ long prepare_to_swait_event(struct swait_queue_head *q, struct swait_queue *wait
 		list_del_init(&wait->task_list);
 		ret = -ERESTARTSYS;
 	} else {
-		__prepare_to_swait(q, wait);
+		add_swait_queue_locked(q, wait);
 		set_current_state(state);
 	}
 	raw_spin_unlock_irqrestore(&q->lock, flags);
-- 
2.7.4

