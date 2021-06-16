Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 239FF3A8F50
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 05:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhFPDXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 23:23:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:42832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230175AbhFPDXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 23:23:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBB8B613B9;
        Wed, 16 Jun 2021 03:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623813678;
        bh=q8HZKPxpOM/5sR9eo6stVaodXdedvsUQjQBqGomYFTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PVgslUPvnm4dag5figXFo7ByhJdeLViFstuVBA+2bOh0q+jJHFNjAdQ7OpvTwfLO/
         e3N/qUhm7guRAWmGpjwLX9hfG3lnJpHOriP8yMB7h7o+8XSPrdeWGBjmnx4GETkErX
         jGk2ZjznvfntfeJKtdGpxUnGlbz+4wNCAmbFxySDGlhuJPuIteVF1+Nkxr1WP6Wjwv
         wVxUjteZpKgHgRynJAVOte0dGblqJ8Ae3qokLj6BiRa9XkfLj2r5FtpB74jgw8ZY5+
         ZVrFcz4GKe0g0AhBux8EONMOlllRPzI1zDXWURMqMn27BBLuiAM7SOqCIN1oYlj2LX
         vUkKcug1HeGlw==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 5/8] membarrier, kthread: Use _ONCE accessors for task->mm
Date:   Tue, 15 Jun 2021 20:21:10 -0700
Message-Id: <74ace142f48db7d0e71b05b5ace72bfe8e0a2652.1623813516.git.luto@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623813516.git.luto@kernel.org>
References: <cover.1623813516.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

membarrier reads cpu_rq(remote cpu)->curr->mm without locking.  Use
READ_ONCE() and WRITE_ONCE() to remove the data races.

Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 fs/exec.c                 | 2 +-
 kernel/kthread.c          | 4 ++--
 kernel/sched/membarrier.c | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 18594f11c31f..2e63dea83411 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1007,7 +1007,7 @@ static int exec_mmap(struct mm_struct *mm)
 	local_irq_disable();
 	active_mm = tsk->active_mm;
 	tsk->active_mm = mm;
-	tsk->mm = mm;
+	WRITE_ONCE(tsk->mm, mm);  /* membarrier reads this without locks */
 	/*
 	 * This prevents preemption while active_mm is being loaded and
 	 * it and mm are being updated, which could cause problems for
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 8275b415acec..4962794e02d5 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1322,7 +1322,7 @@ void kthread_use_mm(struct mm_struct *mm)
 		mmgrab(mm);
 		tsk->active_mm = mm;
 	}
-	tsk->mm = mm;
+	WRITE_ONCE(tsk->mm, mm);  /* membarrier reads this without locks */
 	membarrier_update_current_mm(mm);
 	switch_mm_irqs_off(active_mm, mm, tsk);
 	membarrier_finish_switch_mm(atomic_read(&mm->membarrier_state));
@@ -1363,7 +1363,7 @@ void kthread_unuse_mm(struct mm_struct *mm)
 	smp_mb__after_spinlock();
 	sync_mm_rss(mm);
 	local_irq_disable();
-	tsk->mm = NULL;
+	WRITE_ONCE(tsk->mm, NULL);  /* membarrier reads this without locks */
 	membarrier_update_current_mm(NULL);
 	/* active_mm is still 'mm' */
 	enter_lazy_tlb(mm, tsk);
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 3173b063d358..c32c32a2441e 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -410,7 +410,7 @@ static int membarrier_private_expedited(int flags, int cpu_id)
 			goto out;
 		rcu_read_lock();
 		p = rcu_dereference(cpu_rq(cpu_id)->curr);
-		if (!p || p->mm != mm) {
+		if (!p || READ_ONCE(p->mm) != mm) {
 			rcu_read_unlock();
 			goto out;
 		}
@@ -423,7 +423,7 @@ static int membarrier_private_expedited(int flags, int cpu_id)
 			struct task_struct *p;
 
 			p = rcu_dereference(cpu_rq(cpu)->curr);
-			if (p && p->mm == mm)
+			if (p && READ_ONCE(p->mm) == mm)
 				__cpumask_set_cpu(cpu, tmpmask);
 		}
 		rcu_read_unlock();
@@ -521,7 +521,7 @@ static int sync_runqueues_membarrier_state(struct mm_struct *mm)
 		struct task_struct *p;
 
 		p = rcu_dereference(rq->curr);
-		if (p && p->mm == mm)
+		if (p && READ_ONCE(p->mm) == mm)
 			__cpumask_set_cpu(cpu, tmpmask);
 	}
 	rcu_read_unlock();
-- 
2.31.1

