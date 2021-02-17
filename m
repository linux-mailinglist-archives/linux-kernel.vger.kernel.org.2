Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3BE31D528
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 06:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhBQFsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 00:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhBQFsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 00:48:51 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46BEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 21:48:11 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id gx20so982864pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 21:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kC7FB84HuJWwG5tVJoY1zO9qUYFIRLjueg1bLxKBI2I=;
        b=YCng1pPS942DfxHLPAotAgXTm1nzESHgrA5K44OELy7mkwyvQkjk8XlsycPqV7c+ZM
         mRGq5Qdi9ijg8JkEVPuKkzSmYNTO+o/Rvg36qTQwnKNi1/h+qSDMhBXFD4oLGlIkqz9D
         DCE3Z5NIyRrR1kCMwOstHi0fNgapzRSFeN19Evnr8DrJlyrEtBjTnE4OwLPP2NJ9d8wd
         odLaRrtUzNeZD+AjYc5AcpdadlS2vbnEVlg3rDQRi3zdMj5zzUa6KQSq35zPE3wKi8nB
         SbfYju807ApL76s+iQGYx+Kh9Uve7DgoVH71SrURTIcrExwva/pI0jccbZxw1hLwzAJ5
         c6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kC7FB84HuJWwG5tVJoY1zO9qUYFIRLjueg1bLxKBI2I=;
        b=r+FtqulOJVzx/8lezcIhV8f3Tow5GiokKKj45NnYSFeMnPaOGHHwH0ovFAM+DJz7bl
         DLxckZiyKgqkm2WkR8g4QpHe5CCtXkL7W233GGR88/bNTA/fxBKvGzku5JkB5WY8LJAF
         NWBGDM+vIHwp6yYYGnOEhLcqnGnOY9nHsP/egxQaWGA55inukSSNhckC+xbIvIJibu2B
         8q8sgMV0+LXbmR7hULJrtl9FRHhCMzpw8vnb4v+kgpB59tpmRz3x6jZap1S+QbNA2AuW
         /uOGL+RXWD/GH/S2073pOPvTsdkdjaxboSnt/eytLLXruJ1ZTdV9escDnBEtb45UWWte
         wv2w==
X-Gm-Message-State: AOAM5311sRRgy025TEDQvOr+62usg5QjIkjwimmspn2bz8qLlRfKbjtH
        PTa0mKE3TaU3eeCYA4fvreaxeA==
X-Google-Smtp-Source: ABdhPJzMR139L7M+PXqZWGtFHB4viwOIPgzZgjst2aH6XqmmTW2UDP7q7jvYJqFhPFVMcpTKSb4K9w==
X-Received: by 2002:a17:902:bccc:b029:de:8483:506d with SMTP id o12-20020a170902bcccb02900de8483506dmr1039523pls.53.1613540891035;
        Tue, 16 Feb 2021 21:48:11 -0800 (PST)
Received: from localhost.localdomain ([2409:8a28:e6d:6480:41c9:75c:168:49f5])
        by smtp.gmail.com with ESMTPSA id r13sm867262pfc.198.2021.02.16.21.48.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2021 21:48:10 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     hannes@cmpxchg.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com
Subject: [PATCH v2] psi: Optimize task switch inside shared cgroups
Date:   Wed, 17 Feb 2021 13:48:03 +0800
Message-Id: <20210217054803.77890-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
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
    psi_group_change(prev, .clear = common ? TSK_RUNNING : TSK_RUNNING|TSK_ONCPU)

When a voluntary sleep switches to another task, we remove one call of
psi_group_change() for every common cgroup ancestor of the two tasks.

Updates since v1:
- Many improvements in the comments and code from Johannes.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/psi.c   | 35 +++++++++++++++++++++++++----------
 kernel/sched/stats.h | 28 ++++++++++++----------------
 2 files changed, 37 insertions(+), 26 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 0fe6ff6a6a15..548d405bae3e 100644
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

