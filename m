Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7551F3D59E4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 14:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbhGZMO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 08:14:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234072AbhGZMO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 08:14:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C8B660560;
        Mon, 26 Jul 2021 12:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627304127;
        bh=SvHETjbCjm62MjuEzBsd3mDcLj9X307g2brRkgRpJsQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bNRpq/gqLaNo7koqE0E6QboXlSycaO31X9MHHXUM1mr8BR2RXLP212lH0L44CX4Tg
         g65yzwPMTeAwtufZnW3SnOEs2RNQfSjirQ6ZwFsIOEY2Z2dYBxxIKzT5Ap+rY+HW3L
         X6BJtFniLQ2yOYRIneZqHE4RM9fZACLUzMt7jFtDiAN1hMg17A8zgcK9qzY3uP1l/+
         SSTlRCj+dsxZd3fqli3QUfyvaoHYPJ1kdilfY41P/eWcdkJTef95BOaoMd3aCm+iVy
         Jhr/fKz+DB5Zhn2uzvfpR6POTHEu16aH9a5kdK8vf1zGt/1D/X4g0RfmVXjykiUUGk
         l3DHMUtRhtSyg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH 1/6] posix-cpu-timers: Assert task sighand is locked while starting cputime counter
Date:   Mon, 26 Jul 2021 14:55:08 +0200
Message-Id: <20210726125513.271824-2-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210726125513.271824-1-frederic@kernel.org>
References: <20210726125513.271824-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting the process wide cputime counter needs to be done in the same
sighand locking sequence than actually arming the related timer
otherwise we risk races against concurrent timers setting/expiring
in the same threadgroup.

Detecting that we start the cputime counter without holding the sighand
lock is a first step toward debugging such situations.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Eric W. Biederman <ebiederm@xmission.com>
---
 include/linux/sched/signal.h   |  6 ++++++
 kernel/signal.c                | 15 +++++++++++++++
 kernel/time/posix-cpu-timers.c |  2 ++
 3 files changed, 23 insertions(+)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index b9126fe06c3f..0310a5add9ab 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -714,6 +714,12 @@ static inline void unlock_task_sighand(struct task_struct *task,
 	spin_unlock_irqrestore(&task->sighand->siglock, *flags);
 }
 
+#ifdef CONFIG_LOCKDEP
+extern void lockdep_assert_task_sighand_held(struct task_struct *task);
+#else
+static inline void lockdep_assert_task_sighand_held(struct task_struct *task) { }
+#endif
+
 static inline unsigned long task_rlimit(const struct task_struct *task,
 		unsigned int limit)
 {
diff --git a/kernel/signal.c b/kernel/signal.c
index a3229add4455..52b6abec0ff8 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1413,6 +1413,21 @@ struct sighand_struct *__lock_task_sighand(struct task_struct *tsk,
 	return sighand;
 }
 
+#ifdef CONFIG_LOCKDEP
+void lockdep_assert_task_sighand_held(struct task_struct *task)
+{
+	struct sighand_struct *sighand;
+
+	rcu_read_lock();
+	sighand = rcu_dereference(task->sighand);
+	if (sighand)
+		lockdep_assert_held(&sighand->siglock);
+	else
+		WARN_ON_ONCE(1);
+	rcu_read_unlock();
+}
+#endif
+
 /*
  * send signal info to all the members of a group
  */
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 517be7fd175e..4693d3c71e7e 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -291,6 +291,8 @@ static void thread_group_start_cputime(struct task_struct *tsk, u64 *samples)
 	struct thread_group_cputimer *cputimer = &tsk->signal->cputimer;
 	struct posix_cputimers *pct = &tsk->signal->posix_cputimers;
 
+	lockdep_assert_task_sighand_held(tsk);
+
 	/* Check if cputimer isn't running. This is accessed without locking. */
 	if (!READ_ONCE(pct->timers_active)) {
 		struct task_cputime sum;
-- 
2.25.1

