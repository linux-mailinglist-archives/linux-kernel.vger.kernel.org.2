Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E90390D1C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 01:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbhEZAA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 20:00:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:43714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232171AbhEZAA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 20:00:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1273B613CD;
        Tue, 25 May 2021 23:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621987136;
        bh=Z62AZ6dPeOWcKfVmlINa/gucXFM8K/vuNtPp7AKyiNc=;
        h=From:To:Cc:Subject:Date:From;
        b=XEKwL8DPxi9bL2QIRcJQlYVU6RCI8LIOAFiL7FBN18B/XdBiWmDeLtJ7nef92kLET
         U81ct/r5hByJbTWYNBGtNQkeskryMifMaNXJBy8Cq3O6U5FXstX/7EPa37n0jxmEfl
         I1OOWPG63oCAVxJFbyxE24LxW+i3VlWa/quHOrKFt2FUH0PMcYzpqexNX6APTAOxE8
         AOWxeqX1F+hQpL6WgFysH11fMt5jqfwEOUxLIeTn627rXutG8Fr0FMnllWRK78SLA8
         IKYSRVFWdZboGCU76tstLMiuTrBkRS6EL0uqRTF7rglvgRKWroJBJiA3saJ+AcVanP
         Uvvodsip7obEA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Yejune Deng <yejune.deng@gmail.com>
Subject: [PATCH] sched: Fix PF_NO_SETAFFINITY blind inheritance
Date:   Wed, 26 May 2021 01:58:49 +0200
Message-Id: <20210525235849.441842-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch 00b89fe0197f
	("sched: Make the idle task quack like a per-CPU kthread")
added PF_KTHREAD | PF_NO_SETAFFINITY to the idle kernel threads.

Unfortunately these properties are inherited to the init/0 children
through kernel_thread() calls: init/1 and kthreadd. There are several
side effects to that:

1) kthreadd affinity can not be reset anymore from userspace. Also
   PF_NO_SETAFFINITY propagates to all kthreadd children, including
   the unbound kthreads Therefore it's not possible anymore to overwrite
   the affinity of any of them. Here is an example of warning reported
   by rcutorture:

		WARNING: CPU: 0 PID: 116 at kernel/rcu/tree_nocb.h:1306 rcu_bind_current_to_nocb+0x31/0x40
		Modules linked in:
		CPU: 0 PID: 116 Comm: rcu_torture_fwd Not tainted 5.13.0-rc3-next-20210524 #478
		Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
		RIP: 0010:rcu_bind_current_to_nocb+0x31/0x40
		Code: e8 d4 0c 35 00 85 c0 75 01 c3 65 48 8b 04 25 00 6d 01 00 8b b8 58 05 00 00 48 c7 c6 68 76 ce a6 e8 e4 2e fc ff 48 85 c0 74 df <0f> 0b c3 66 66 2e 0f 1f 84 00 00 00 00 00 90 41 55 48
		+63 c7 48 c7
		RSP: 0000:ffff9bb78036fe48 EFLAGS: 00010282
		RAX: ffffffffffffffea RBX: ffff8a2d01b1b800 RCX: 0000000000000000
		RDX: ffff8a2d01b1b800 RSI: 0000000000000074 RDI: ffffffffa644eec0
		RBP: ffff9bb78036ff00 R08: ffff8a2d01b06400 R09: ffff8a2d014346d8
		R10: ffff8a2d014348a0 R11: 0000000000000000 R12: ffff8a2d01af8420
		R13: ffff8a2d01895000 R14: ffff8a2d01895000 R15: ffff8a2d01b1b800
		FS:  0000000000000000(0000) GS:ffff8a2d1f400000(0000) knlGS:0000000000000000
		CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
		CR2: 0000000000000000 CR3: 000000000660c000 CR4: 00000000000006f0
		Call Trace:
		 rcu_torture_fwd_prog+0x62/0x730
		 ? ttwu_do_wakeup.isra.0+0xd/0xd0
		 ? rcu_torture_read_lock_trivial+0x10/0x10
		 ? kthread+0x122/0x140
		 kthread+0x122/0x140
		 ? set_kthread_struct+0x40/0x40
		 ret_from_fork+0x22/0x30
		---[ end trace 135cca867023305b ]---

2) init/1 does an exec() in the end which clears both
   PF_KTHREAD and PF_NO_SETAFFINITY so we are fine once kernel_init()
   escapes to userspace. But until then, no initcall or init code can
   successfully call sched_setaffinity() to init/1.

   Also PF_KTHREAD looks legit on init/1 before it calls exec() but
   we better be careful with unknown introduced side effects.

One way to solve the PF_NO_SETAFFINITY issue is to not inherit this flag
on copy_process() at all. The cases where it matters are:

* fork_idle(): explicitly set the flag already.
* fork() syscalls: userspace tasks that shouldn't be concerned by that.
* create_io_thread(): the callers explicitly attribute the flag to the
                      newly created tasks.
* kernel_thread():
	_ Fix the issues on init/1 and kthreadd
	_ Fix the issues on kthreadd children.
	_ Usermode helper created by an unbound workqueue. This shouldn't
	  matter. In the worst case it gives more control to userspace
	  on setting affinity to these short living tasks although this can
	  be tuned with inherited unbound workqueues affinity already.

Reported-and-tested-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Yejune Deng <yejune.deng@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index ace4631b5b54..e595e77913eb 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2000,7 +2000,7 @@ static __latent_entropy struct task_struct *copy_process(
 		goto bad_fork_cleanup_count;
 
 	delayacct_tsk_init(p);	/* Must remain after dup_task_struct() */
-	p->flags &= ~(PF_SUPERPRIV | PF_WQ_WORKER | PF_IDLE);
+	p->flags &= ~(PF_SUPERPRIV | PF_WQ_WORKER | PF_IDLE | PF_NO_SETAFFINITY);
 	p->flags |= PF_FORKNOEXEC;
 	INIT_LIST_HEAD(&p->children);
 	INIT_LIST_HEAD(&p->sibling);
-- 
2.25.1

