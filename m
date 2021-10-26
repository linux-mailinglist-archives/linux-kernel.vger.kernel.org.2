Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA21343B3AF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236419AbhJZONa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:13:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236431AbhJZON2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:13:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 13ACB61090;
        Tue, 26 Oct 2021 14:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635257464;
        bh=FyBqhCDkTOSwhGAqCQeLfGAKiuUaKIxcmf4jS04tKSI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A/PwOGg3nRhm1yKxCbKqfBxpBUrnyTP5T3xurHrkaOKjrWCKgHS7PeV2420qdJ3hi
         JotzzX91yArW4aA8i0mtDS/zIvYfoKOE8l++N/k+rl4CHs8YVC6RQu/OABrC92jL3P
         jf2834D3vtBN/DLqagV0n5lBMapCkXbRLuJyadhyd0LgSAXT0uYG8eanuI+xAzwcnn
         tePhOFpdCMpjBRsDC6Hua/FaB6a5+2g/dvgyaCIMlXlh0LLgLupQhIFmIYj+zSx0bM
         NjU2NT/keiXH6OAeWpXo+aENGg9PeUNFyEqT7VGG8BJAw8ufEs+pGac3hkKfEgAKIS
         K4l+3OUcu5bKw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hasegawa Hitomi <hasegawa-hitomi@fujitsu.com>,
        Mel Gorman <mgorman@suse.de>
Subject: [PATCH 2/2] sched/cputime: Fix getrusage(RUSAGE_THREAD) with nohz_full
Date:   Tue, 26 Oct 2021 16:10:55 +0200
Message-Id: <20211026141055.57358-3-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211026141055.57358-1-frederic@kernel.org>
References: <20211026141055.57358-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

getrusage(RUSAGE_THREAD) with nohz_full may return shorter utime/stime
than the actual time.

task_cputime_adjusted() snapshots utime and stime and then adjust their
sum to match the scheduler maintained cputime.sum_exec_runtime.
Unfortunately in nohz_full, sum_exec_runtime is only updated once per
second in the worst case, causing a discrepancy against utime and stime
that can be updated anytime by the reader using vtime.

To fix this situation, perform an update of cputime.sum_exec_runtime
when the cputime snapshot reports the task as actually running while
the tick is disabled. The related overhead is then contained within the
relevant situations.

Reported-by: Hasegawa Hitomi <hasegawa-hitomi@fujitsu.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Hasegawa Hitomi <hasegawa-hitomi@fujitsu.com>
---
 include/linux/sched/cputime.h |  5 +++--
 kernel/sched/cputime.c        | 12 +++++++++---
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched/cputime.h b/include/linux/sched/cputime.h
index 6c9f19a33865..ce3c58286062 100644
--- a/include/linux/sched/cputime.h
+++ b/include/linux/sched/cputime.h
@@ -18,15 +18,16 @@
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
-extern void task_cputime(struct task_struct *t,
+extern bool task_cputime(struct task_struct *t,
 			 u64 *utime, u64 *stime);
 extern u64 task_gtime(struct task_struct *t);
 #else
-static inline void task_cputime(struct task_struct *t,
+static inline bool task_cputime(struct task_struct *t,
 				u64 *utime, u64 *stime)
 {
 	*utime = t->utime;
 	*stime = t->stime;
+	return false;
 }
 
 static inline u64 task_gtime(struct task_struct *t)
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 872e481d5098..9392aea1804e 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -615,7 +615,8 @@ void task_cputime_adjusted(struct task_struct *p, u64 *ut, u64 *st)
 		.sum_exec_runtime = p->se.sum_exec_runtime,
 	};
 
-	task_cputime(p, &cputime.utime, &cputime.stime);
+	if (task_cputime(p, &cputime.utime, &cputime.stime))
+		cputime.sum_exec_runtime = task_sched_runtime(p);
 	cputime_adjust(&cputime, &p->prev_cputime, ut, st);
 }
 EXPORT_SYMBOL_GPL(task_cputime_adjusted);
@@ -828,19 +829,21 @@ u64 task_gtime(struct task_struct *t)
  * add up the pending nohz execution time since the last
  * cputime snapshot.
  */
-void task_cputime(struct task_struct *t, u64 *utime, u64 *stime)
+bool task_cputime(struct task_struct *t, u64 *utime, u64 *stime)
 {
 	struct vtime *vtime = &t->vtime;
 	unsigned int seq;
 	u64 delta;
+	int ret;
 
 	if (!vtime_accounting_enabled()) {
 		*utime = t->utime;
 		*stime = t->stime;
-		return;
+		return false;
 	}
 
 	do {
+		ret = false;
 		seq = read_seqcount_begin(&vtime->seqcount);
 
 		*utime = t->utime;
@@ -850,6 +853,7 @@ void task_cputime(struct task_struct *t, u64 *utime, u64 *stime)
 		if (vtime->state < VTIME_SYS)
 			continue;
 
+		ret = true;
 		delta = vtime_delta(vtime);
 
 		/*
@@ -861,6 +865,8 @@ void task_cputime(struct task_struct *t, u64 *utime, u64 *stime)
 		else
 			*utime += vtime->utime + delta;
 	} while (read_seqcount_retry(&vtime->seqcount, seq));
+
+	return ret;
 }
 
 static int vtime_state_fetch(struct vtime *vtime, int cpu)
-- 
2.25.1

