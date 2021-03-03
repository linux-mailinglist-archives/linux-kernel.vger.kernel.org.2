Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025F232BA9F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 21:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358122AbhCCLie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 06:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352580AbhCCD4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 22:56:13 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9CEC06178A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 19:47:24 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id a4so15309966pgc.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 19:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RKnAOeO+sj3C6CN9bevf7fREE4w26B3tSTWZsim0dTI=;
        b=LC3DrrzJ7MfcJ5LI1sHDpXw7HLKt+eLccsm/QHso016UkZBnB447pXqnMSqCZmX1cj
         lH0xiIBw92Y+Bu7VsoX67CxcZAfUPNWph0qeTGaXDQQy4d+p378K3L09yxn2SBJof7he
         loo/G4f4yHFreeWw/Lpr77VNJL4D5f/+ypj6mpD8bKCUGHqAIRtrnkB7ayLSI4bhB8q2
         GqoLUV9sJe7MhwSJQV3MFmXgoSOuZ+wByyxw7Rmw4NlXYMZQoA7W+H1ZFAD9aSuHOpYp
         Dh5yydDb0HvhUvlFMi828F56W/nvhmNIBTRvzeWW5eooyt+vz/bdeyNawVq8bAy63e2R
         tGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RKnAOeO+sj3C6CN9bevf7fREE4w26B3tSTWZsim0dTI=;
        b=nximl6THKXXL6PTIkzRLw0ryopiR/wBLROu1cJG5xfEe/0W/Jy8/Pay5uVvFUJ6okn
         JniE897zdrRW/sXaQXnQfKKE27JdmeQ6vwgn7v4n/1rPOJDHk9VVILRkn3VFsGj3cTko
         ML5vyLj/0SvBv0wZbEjhRa49eUDrd+OUYFdN0s3OOiM7+pULkyFLjVBbm36gNOHsrzMB
         rFemWAl5c0msiinYUEuK/uyDMks9eoyiuWowM9x1wSAG9fpU1Hjm0pO07KgyDH951+g5
         moKB1xwq/ayMHEaQJRStNofOxXJhLgDkF0nV6ewyoWDJrFwN/tNhzaB0NG6XqTQqJKPV
         9u+g==
X-Gm-Message-State: AOAM531xgBXLhlGs2NYmfe9tLKNQQ43E0VuPYH8LUudHamYh/eYCkRbU
        5WX55nL0fH0+2J3ihj40wa0l8EiRcvuKT0IC0s4=
X-Google-Smtp-Source: ABdhPJyTXKy5xWa+kT3bbwd0L2zFjWVqzH5pr69UYNyo17lIb919R1Vr6y4M8/QDETyJeWm7bU5DIQ==
X-Received: by 2002:a05:6a00:22ca:b029:1ed:f915:ca98 with SMTP id f10-20020a056a0022cab02901edf915ca98mr1150324pfj.68.1614743244159;
        Tue, 02 Mar 2021 19:47:24 -0800 (PST)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id p26sm23029703pfn.127.2021.03.02.19.47.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Mar 2021 19:47:23 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     hannes@cmpxchg.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com
Subject: [PATCH v2 4/4] psi: Optimize task switch inside shared cgroups
Date:   Wed,  3 Mar 2021 11:46:59 +0800
Message-Id: <20210303034659.91735-5-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210303034659.91735-1-zhouchengming@bytedance.com>
References: <20210303034659.91735-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 36b238d57172 ("psi: Optimize switching tasks inside shared
cgroups") only update cgroups whose state actually changes during a
task switch only in task preempt case, not in task sleep case.

We actually don't need to clear and set TSK_ONCPU state for common cgroups
of next and prev task in sleep case, that can save many psi_group_change
especially when most activity comes from one leaf cgroup.

sleep before:
psi_dequeue()
  while ((group = iterate_groups(prev)))  # all ancestors
    psi_group_change(prev, .clear=TSK_RUNNING|TSK_ONCPU)
psi_task_switch()
  while ((group = iterate_groups(next)))  # all ancestors
    psi_group_change(next, .set=TSK_ONCPU)

sleep after:
psi_dequeue()
  nop
psi_task_switch()
  while ((group = iterate_groups(next)))  # until (prev & next)
    psi_group_change(next, .set=TSK_ONCPU)
  while ((group = iterate_groups(prev)))  # all ancestors
    psi_group_change(prev, .clear=common?TSK_RUNNING:TSK_RUNNING|TSK_ONCPU)

When a voluntary sleep switches to another task, we remove one call of
psi_group_change() for every common cgroup ancestor of the two tasks.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
Updates since v1:
- Many improvements in the comments and code from Johannes Weiner.

 kernel/sched/psi.c   | 35 +++++++++++++++++++++++++----------
 kernel/sched/stats.h | 28 ++++++++++++----------------
 2 files changed, 37 insertions(+), 26 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 3907a6b847aa..ee3c5b48622f 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -840,20 +840,35 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		}
 	}
 
-	/*
-	 * If this is a voluntary sleep, dequeue will have taken care
-	 * of the outgoing TSK_ONCPU alongside TSK_RUNNING already. We
-	 * only need to deal with it during preemption.
-	 */
-	if (sleep)
-		return;
-
 	if (prev->pid) {
-		psi_flags_change(prev, TSK_ONCPU, 0);
+		int clear = TSK_ONCPU, set = 0;
+
+		/*
+		 * When we're going to sleep, psi_dequeue() lets us handle
+		 * TSK_RUNNING and TSK_IOWAIT here, where we can combine it
+		 * with TSK_ONCPU and save walking common ancestors twice.
+		 */
+		if (sleep) {
+			clear |= TSK_RUNNING;
+			if (prev->in_iowait)
+				set |= TSK_IOWAIT;
+		}
+
+		psi_flags_change(prev, clear, set);
 
 		iter = NULL;
 		while ((group = iterate_groups(prev, &iter)) && group != common)
-			psi_group_change(group, cpu, TSK_ONCPU, 0, true);
+			psi_group_change(group, cpu, clear, set, true);
+
+		/*
+		 * TSK_ONCPU is handled up to the common ancestor. If we're tasked
+		 * with dequeuing too, finish that for the rest of the hierarchy.
+		 */
+		if (sleep) {
+			clear &= ~TSK_ONCPU;
+			for (; group; group = iterate_groups(prev, &iter))
+				psi_group_change(group, cpu, clear, set, true);
+		}
 	}
 }
 
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 9e4e67a94731..dc218e9f4558 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -84,28 +84,24 @@ static inline void psi_enqueue(struct task_struct *p, bool wakeup)
 
 static inline void psi_dequeue(struct task_struct *p, bool sleep)
 {
-	int clear = TSK_RUNNING, set = 0;
+	int clear = TSK_RUNNING;
 
 	if (static_branch_likely(&psi_disabled))
 		return;
 
-	if (!sleep) {
-		if (p->in_memstall)
-			clear |= TSK_MEMSTALL;
-	} else {
-		/*
-		 * When a task sleeps, schedule() dequeues it before
-		 * switching to the next one. Merge the clearing of
-		 * TSK_RUNNING and TSK_ONCPU to save an unnecessary
-		 * psi_task_change() call in psi_sched_switch().
-		 */
-		clear |= TSK_ONCPU;
+	/*
+	 * A voluntary sleep is a dequeue followed by a task switch. To
+	 * avoid walking all ancestors twice, psi_task_switch() handles
+	 * TSK_RUNNING and TSK_IOWAIT for us when it moves TSK_ONCPU.
+	 * Do nothing here.
+	 */
+	if (sleep)
+		return;
 
-		if (p->in_iowait)
-			set |= TSK_IOWAIT;
-	}
+	if (p->in_memstall)
+		clear |= TSK_MEMSTALL;
 
-	psi_task_change(p, clear, set);
+	psi_task_change(p, clear, 0);
 }
 
 static inline void psi_ttwu_dequeue(struct task_struct *p)
-- 
2.11.0

