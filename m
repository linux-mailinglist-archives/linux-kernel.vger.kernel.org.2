Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB943B10B5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 01:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhFVXoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 19:44:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229833AbhFVXoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 19:44:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7644460FF2;
        Tue, 22 Jun 2021 23:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624405326;
        bh=WakAHe+yP6lJG1nkLPwskdF6fN4xC3X4ng9N7y0HxIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lHFVx5UscQihTFqU1WbwKoQINv2Mhm3/kDcechmE5SLS9w8cZd/hFEWCXLsdpm1sU
         Uh8F0w6itkCb10NI1KZUEdfPKRmeZykTbwm3lSk2lJKO0YdLU6+GY4iG06wurKoLVc
         FAVzYRq8WWJD5Ho0csDmFfvXPDPJBQHQHu/dL/LXynpqO6GJUmKCgAQGuzJZKgkAeD
         J8aUircASt3+TDrmhIrtr/lT8Rz7R0CuCbskCIQz7Cvtq9XtSWQRN8SAsmkTiCySw1
         iqvwl9EcSBWwhEapSbRnQEsaSZnWa4Dj9mmZUrAXB0gnYB7yOZT3Scw0PazWl0QBjT
         zalGcIbTtM68A==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 2/7] posix-cpu-timers: Assert task sighand is locked while starting cputime counter
Date:   Wed, 23 Jun 2021 01:41:50 +0200
Message-Id: <20210622234155.119685-3-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210622234155.119685-1-frederic@kernel.org>
References: <20210622234155.119685-1-frederic@kernel.org>
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
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Eric W. Biederman <ebiederm@xmission.com>
---
 include/linux/sched/signal.h   |  6 ++++++
 kernel/signal.c                | 13 +++++++++++++
 kernel/time/posix-cpu-timers.c |  2 ++
 3 files changed, 21 insertions(+)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 7f4278fa21fe..65914e9be683 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -709,6 +709,12 @@ static inline void unlock_task_sighand(struct task_struct *task,
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
index f7c6ffcbd044..82cbb8ecff5a 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1440,6 +1440,19 @@ struct sighand_struct *__lock_task_sighand(struct task_struct *tsk,
 	return sighand;
 }
 
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
+
 /*
  * send signal info to all the members of a group
  */
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index aa52fc85dbcb..f78ccab58aa4 100644
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

