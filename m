Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A0B3434EB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 21:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhCUUw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 16:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbhCUUwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 16:52:35 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0D0C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 13:52:34 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id o16so19469162pjy.9
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 13:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CHaqurT5G769jVauoVaK8zRqAA7BkO3CHuHD5hiYiHg=;
        b=sRQWNjLgLFTiTJOb/yNDBVpInLiOBDsysOzOhWBBxMggVD21NikcoWDDhCcx+2Aaw+
         /gL3EH+D11MO8MtTNXIdhaNdEKCsFK6/yaEWCnnSf5uLb6WpY/PCY66AwI2h8ZmB2DBl
         HauaCu6w/y+5YeHlQOIAGmXN/rGNrRKP4nHnjfVkJrb01j8J0b7+tQHH3n52r1GYvbhY
         S895XC+JGMSLw2Q4iHQmn5pY6EuJEzfC/R2Phr2AWHfyC+2UdtusIDPB04+nWbHKzBzl
         Rc+DIqEC6+yPXCsPBVNHRmYIyWg/WnZzIALJwoZ9RoXJofBdOpk/S4yx/YZ+5tlZZsC3
         z4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CHaqurT5G769jVauoVaK8zRqAA7BkO3CHuHD5hiYiHg=;
        b=UvL7PQBTlVHZhz+rm0ysECKpWvEMjB4sQbFZRs4Oxy9VNl1XT0wbi0wYjrwtTn9Itv
         EDWKteW/IKJ8n2xbXf+ODj/nlEnWxnBDJiMzYLArZGzwuDBtRkf6otEvjC2wtgtc+sA0
         hz77h0HAOg0GuoDiRkel1SmV1ViI8NQo9VhBdns6EQGqE4fJr+Wg9UcdNA+ynel7zX5r
         /6SJTK8/Ud3//kPFhx1PyhjTUEDYSZuFnQGK974AwjPUBvBkZA3cm9l0XzDv/CeG9sTh
         2pDt6xWxtY2H2AbQ7Ipx4Nn3OxBcN9oHq73H/T+/QfcV5sTM52/9s1qADEmfHV67xLra
         TIhg==
X-Gm-Message-State: AOAM5309CI15ueOwQ0lm6mvsfhnUw+nveKxDAfitmcHycixnlIX/RglS
        +fAZ64PfRKU8nlnfxZzIGEMl6mhXjTmeAQ==
X-Google-Smtp-Source: ABdhPJwHd/rDZoIm0GaB6b7WFq8CzH3pmGWaAq6Zn6xiDTZ2r+NO9VFcYNNEiVQeTznFNUXw9en53mHUkXpkVg==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:242c:a31:3a8b:9265])
 (user=shakeelb job=sendgmr) by 2002:a63:c601:: with SMTP id
 w1mr19370729pgg.11.1616359948316; Sun, 21 Mar 2021 13:52:28 -0700 (PDT)
Date:   Sun, 21 Mar 2021 13:51:56 -0700
Message-Id: <20210321205156.4186483-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH] psi: reduce calls to sched_clock() in psi
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We noticed that the cost of psi increases with the increase in the
levels of the cgroups. Particularly the cost of cpu_clock() sticks out
as the kernel calls it multiple times as it traverses up the cgroup
tree. This patch reduces the calls to cpu_clock().

Performed perf bench on Intel Broadwell with 3 levels of cgroup.

Before the patch:

$ perf bench sched all
 # Running sched/messaging benchmark...
 # 20 sender and receiver processes per group
 # 10 groups == 400 processes run

     Total time: 0.747 [sec]

 # Running sched/pipe benchmark...
 # Executed 1000000 pipe operations between two processes

     Total time: 3.516 [sec]

       3.516689 usecs/op
         284358 ops/sec

After the patch:

$ perf bench sched all
 # Running sched/messaging benchmark...
 # 20 sender and receiver processes per group
 # 10 groups == 400 processes run

     Total time: 0.640 [sec]

 # Running sched/pipe benchmark...
 # Executed 1000000 pipe operations between two processes

     Total time: 3.329 [sec]

       3.329820 usecs/op
         300316 ops/sec

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 kernel/sched/psi.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index ee3c5b48622f..16348b269713 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -644,12 +644,10 @@ static void poll_timer_fn(struct timer_list *t)
 	wake_up_interruptible(&group->poll_wait);
 }
 
-static void record_times(struct psi_group_cpu *groupc, int cpu)
+static void record_times(struct psi_group_cpu *groupc, u64 now)
 {
 	u32 delta;
-	u64 now;
 
-	now = cpu_clock(cpu);
 	delta = now - groupc->state_start;
 	groupc->state_start = now;
 
@@ -676,7 +674,7 @@ static void record_times(struct psi_group_cpu *groupc, int cpu)
 }
 
 static void psi_group_change(struct psi_group *group, int cpu,
-			     unsigned int clear, unsigned int set,
+			     unsigned int clear, unsigned int set, u64 now,
 			     bool wake_clock)
 {
 	struct psi_group_cpu *groupc;
@@ -696,7 +694,7 @@ static void psi_group_change(struct psi_group *group, int cpu,
 	 */
 	write_seqcount_begin(&groupc->seq);
 
-	record_times(groupc, cpu);
+	record_times(groupc, now);
 
 	for (t = 0, m = clear; m; m &= ~(1 << t), t++) {
 		if (!(m & (1 << t)))
@@ -788,12 +786,14 @@ void psi_task_change(struct task_struct *task, int clear, int set)
 	struct psi_group *group;
 	bool wake_clock = true;
 	void *iter = NULL;
+	u64 now;
 
 	if (!task->pid)
 		return;
 
 	psi_flags_change(task, clear, set);
 
+	now = cpu_clock(cpu);
 	/*
 	 * Periodic aggregation shuts off if there is a period of no
 	 * task changes, so we wake it back up if necessary. However,
@@ -806,7 +806,7 @@ void psi_task_change(struct task_struct *task, int clear, int set)
 		wake_clock = false;
 
 	while ((group = iterate_groups(task, &iter)))
-		psi_group_change(group, cpu, clear, set, wake_clock);
+		psi_group_change(group, cpu, clear, set, now, wake_clock);
 }
 
 void psi_task_switch(struct task_struct *prev, struct task_struct *next,
@@ -815,6 +815,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 	struct psi_group *group, *common = NULL;
 	int cpu = task_cpu(prev);
 	void *iter;
+	u64 now = cpu_clock(cpu);
 
 	if (next->pid) {
 		bool identical_state;
@@ -836,7 +837,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 				break;
 			}
 
-			psi_group_change(group, cpu, 0, TSK_ONCPU, true);
+			psi_group_change(group, cpu, 0, TSK_ONCPU, now, true);
 		}
 	}
 
@@ -858,7 +859,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 
 		iter = NULL;
 		while ((group = iterate_groups(prev, &iter)) && group != common)
-			psi_group_change(group, cpu, clear, set, true);
+			psi_group_change(group, cpu, clear, set, now, true);
 
 		/*
 		 * TSK_ONCPU is handled up to the common ancestor. If we're tasked
@@ -867,7 +868,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		if (sleep) {
 			clear &= ~TSK_ONCPU;
 			for (; group; group = iterate_groups(prev, &iter))
-				psi_group_change(group, cpu, clear, set, true);
+				psi_group_change(group, cpu, clear, set, now, true);
 		}
 	}
 }
-- 
2.31.0.291.g576ba9dcdaf-goog

