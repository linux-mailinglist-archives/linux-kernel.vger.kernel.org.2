Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA932373213
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 23:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbhEDVyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 17:54:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:36052 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231478AbhEDVyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 17:54:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 63A1AAFD0;
        Tue,  4 May 2021 21:53:43 +0000 (UTC)
MIME-Version: 1.0
Date:   Tue, 04 May 2021 14:53:33 -0700
From:   Davidlohr Bueso <dbueso@suse.de>
To:     Varad Gautam <varad.gautam@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Matthias von Faber <matthias.vonfaber@aox-tech.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ipc/mqueue: Avoid relying on a stack reference past its
 expiry
In-Reply-To: <20210504155534.17270-1-varad.gautam@suse.com>
References: <20210504155534.17270-1-varad.gautam@suse.com>
User-Agent: Roundcube Webmail
Message-ID: <4959eb8d8c14b00113370ae86dc7c9f5@suse.de>
X-Sender: dbueso@suse.de
Organization: SUSE Labs
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-05-04 08:55, Varad Gautam wrote:
> do_mq_timedreceive calls wq_sleep with a stack local address. The
> sender (do_mq_timedsend) uses this address to later call
> pipelined_send.
> 
> This leads to a very hard to trigger race where a do_mq_timedreceive 
> call
> might return and leave do_mq_timedsend to rely on an invalid address,
> causing the following crash:
> 
> [  240.739977] RIP: 0010:wake_q_add_safe+0x13/0x60
> [  240.739991] Call Trace:
> [  240.739999]  __x64_sys_mq_timedsend+0x2a9/0x490
> [  240.740003]  ? auditd_test_task+0x38/0x40
> [  240.740007]  ? auditd_test_task+0x38/0x40
> [  240.740011]  do_syscall_64+0x80/0x680
> [  240.740017]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  240.740019] RIP: 0033:0x7f5928e40343
> 
> The race occurs as:
> 
> 1. do_mq_timedreceive calls wq_sleep with the address of
> `struct ext_wait_queue` on function stack (aliased as `ewq_addr` here)
> - it holds a valid `struct ext_wait_queue *` as long as the stack has
> not been overwritten.
> 
> 2. `ewq_addr` gets added to info->e_wait_q[RECV].list in wq_add, and
> do_mq_timedsend receives it via wq_get_first_waiter(info, RECV) to call
> __pipelined_op.
> 
> 3. Sender calls __pipelined_op::smp_store_release(&this->state, 
> STATE_READY).
> Here is where the race window begins. (`this` is `ewq_addr`.)
> 
> 4. If the receiver wakes up now in do_mq_timedreceive::wq_sleep, it
> will see `state == STATE_READY` and break. `ewq_addr` gets removed from
> info->e_wait_q[RECV].list.
> 
> 5. do_mq_timedreceive returns, and `ewq_addr` is no longer guaranteed
> to be a `struct ext_wait_queue *` since it was on do_mq_timedreceive's
> stack. (Although the address may not get overwritten until another
> function happens to touch it, which means it can persist around for an
> indefinite time.)
> 
> 6. do_mq_timedsend::__pipelined_op() still believes `ewq_addr` is a
> `struct ext_wait_queue *`, and uses it to find a task_struct to pass
> to the wake_q_add_safe call. In the lucky case where nothing has
> overwritten `ewq_addr` yet, `ewq_addr->task` is the right task_struct.
> In the unlucky case, __pipelined_op::wake_q_add_safe gets handed a
> bogus address as the receiver's task_struct causing the crash.
> 
> do_mq_timedsend::__pipelined_op() should not dereference `this` after
> setting STATE_READY, as the receiver counterpart is now free to return.
> Change __pipelined_op to call wake_q_add_safe on the receiver's
> task_struct returned by get_task_struct, instead of dereferencing
> `this` which sits on the receiver's stack.
> 
> Fixes: c5b2cbdbdac563 ("ipc/mqueue.c: update/document memory barriers")

Right, historically we've always ensured that the waker does the state 
ready
write as the last operation, with or without lockless wake_qs. And this 
commit
broke this:

@@ -923,16 +988,11 @@ static inline void __pipelined_op(struct 
wake_q_head *wake_q,
                                   struct ext_wait_queue *this)
  {
         list_del(&this->list);
-       wake_q_add(wake_q, this->task);
-       /*
-        * Rely on the implicit cmpxchg barrier from wake_q_add such
-        * that we can ensure that updating receiver->state is the last
-        * write operation: As once set, the receiver can continue,
-        * and if we don't have the reference count from the wake_q,
-        * yet, at that point we can later have a use-after-free
-        * condition and bogus wakeup.
-        */
-       this->state = STATE_READY;
+       get_task_struct(this->task);
+
+       /* see MQ_BARRIER for purpose/pairing */
+       smp_store_release(&this->state, STATE_READY);
+       wake_q_add_safe(wake_q, this->task);
  }

.. so while addressing the race against get_task_struct() vs wakee exit 
we ended
up breaking the case where the task returns before the task is added to 
the wake_q
(which actually we explicitly re-orded :). So at this point we know that 
the
->state = STATE_READY must be done after the whole of the wake_q 
addition operation.

Instead, how about the following which closes the race altogether and 
simplifies the
code. This basically goes back to a correct version of fa6004ad4528
(ipc/mqueue: Implement lockless pipelined wakeups). And by correct I 
mean keeping the
smp_store_release() which ensures the proper wakeup semantics.

Thanks,
Davidlohr

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 8031464ed4ae..43f0ae61c40b 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -76,14 +76,15 @@ struct posix_msg_tree_node {
   *   acquiring info->lock.
   *
   * MQ_BARRIER:
- * To achieve proper release/acquire memory barrier pairing, the state 
is set to
- * STATE_READY with smp_store_release(), and it is read with READ_ONCE 
followed
- * by smp_acquire__after_ctrl_dep(). In addition, wake_q_add_safe() is 
used.
+ * To achieve proper release/acquire memory barrier pairing, the state 
is
+ * set to STATE_READY with smp_store_release() such that it is the last 
write
+ * operation, in which afterwards the blocked task can immediately 
return and
+ * exit. It is read with READ_ONCE followed by 
smp_acquire__after_ctrl_dep().
   *
   * This prevents the following races:
   *
- * 1) With the simple wake_q_add(), the task could be gone already 
before
- *    the increase of the reference happens
+ * 1) With the wake_q_add(), the task could be gone already before
+ *    the increase of the reference happens:
   * Thread A
   *				Thread B
   * WRITE_ONCE(wait.state, STATE_NONE);
@@ -97,10 +98,27 @@ struct posix_msg_tree_node {
   * sys_exit()
   *				get_task_struct() // UaF
   *
- * Solution: Use wake_q_add_safe() and perform the get_task_struct() 
before
+ *
+ * 2) With the wake_q_add(), the waiter task could have returned from 
the
+ *    syscall and overwritten it's task-allocated waiter before the 
sender
+ *    can be added to the wake_q:
+ * Thread A
+ *				Thread B
+ * WRITE_ONCE(wait.state, STATE_NONE);
+ * schedule_hrtimeout()
+ *                              ->state = STATE_READY
+ * <timeout returns>
+ * if (wait.state == STATE_READY) return;
+ * sysret to user space
+ * overwrite receiver's stack
+ *				wake_q_add(A)
+ *				if (cmpxchg()) // corrupted waiter
+ *
+ * Solution: Use wake_q_add() and queue the task for wakeup before
   * the smp_store_release() that does ->state = STATE_READY.
   *
- * 2) Without proper _release/_acquire barriers, the woken up task
+ *
+ * 3) Without proper _release/_acquire barriers, the woken up task
   *    could read stale data
   *
   * Thread A
@@ -116,7 +134,7 @@ struct posix_msg_tree_node {
   *
   * Solution: use _release and _acquire barriers.
   *
- * 3) There is intentionally no barrier when setting current->state
+ * 4) There is intentionally no barrier when setting current->state
   *    to TASK_INTERRUPTIBLE: spin_unlock(&info->lock) provides the
   *    release memory barrier, and the wakeup is triggered when holding
   *    info->lock, i.e. spin_lock(&info->lock) provided a pairing
@@ -1005,11 +1023,9 @@ static inline void __pipelined_op(struct 
wake_q_head *wake_q,
  				  struct ext_wait_queue *this)
  {
  	list_del(&this->list);
-	get_task_struct(this->task);
-
+	wake_q_add(wake_q, this->task);
  	/* see MQ_BARRIER for purpose/pairing */
  	smp_store_release(&this->state, STATE_READY);
-	wake_q_add_safe(wake_q, this->task);
  }

  /* pipelined_send() - send a message directly to the task waiting in
