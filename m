Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014B53B18B0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 13:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhFWLSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 07:18:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230031AbhFWLSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 07:18:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E1BEC61076;
        Wed, 23 Jun 2021 11:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624446944;
        bh=tJXiecHNIp5JJoqI8vztpTVhBituQdkahMZ6qTwHF/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JV59d7xZcINaEA4Rx7dlF+qXLQ6/rumz27oT/FoGH/Onm4gGYGoxDAMYDZ8Hzavvy
         uF4fJ9EBDWPl8UllKWuejl9hTXAawFhqKr6M/+1MQ3iz1KqyKGmirOa2Obl+S8VRzN
         z0amPAteVhFGYBJCj3u8M0W8fBagH287DBZz9g2ZO0Ws4NVtR8KP8sBVGwlkCLsbKa
         x+davE+GnnsD+l8qBSatbjSLs3fnm8S2Nel1O0j8cTiHZXoiRc1q9k/OaebR0QbLwT
         wLe/dCfHE9fVMyIk+ojtYpRil9pd+R6c2VRVM+U/0rYS/ojV4INCMJHbU4Nxl+ZemZ
         635ITl1fTXc1Q==
Date:   Wed, 23 Jun 2021 13:15:42 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 2/7] posix-cpu-timers: Assert task sighand is locked
 while starting cputime counter
Message-ID: <20210623111542.GA124388@lothringen>
References: <20210622234155.119685-1-frederic@kernel.org>
 <20210622234155.119685-3-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622234155.119685-3-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 01:41:50AM +0200, Frederic Weisbecker wrote:
> diff --git a/kernel/signal.c b/kernel/signal.c
> index f7c6ffcbd044..82cbb8ecff5a 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1440,6 +1440,19 @@ struct sighand_struct *__lock_task_sighand(struct task_struct *tsk,
>  	return sighand;
>  }
>  
> +void lockdep_assert_task_sighand_held(struct task_struct *task)
> +{
> +	struct sighand_struct *sighand;
> +
> +	rcu_read_lock();
> +	sighand = rcu_dereference(task->sighand);
> +	if (sighand)
> +		lockdep_assert_held(&sighand->siglock);
> +	else
> +		WARN_ON_ONCE(1);
> +	rcu_read_unlock();
> +}

This wants #ifdef CONFIG_LOCKDEP

Please consider the updated patch:

---
From: Frederic Weisbecker <frederic@kernel.org>
Date: Sat, 19 Jun 2021 15:21:14 +0200
Subject: [PATCH] posix-cpu-timers: Assert task sighand is locked while
 starting cputime counter

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
 kernel/signal.c                | 15 +++++++++++++++
 kernel/time/posix-cpu-timers.c |  2 ++
 3 files changed, 23 insertions(+)

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
index f7c6ffcbd044..02963de1c2da 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1440,6 +1440,21 @@ struct sighand_struct *__lock_task_sighand(struct task_struct *tsk,
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

