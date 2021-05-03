Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182613710B3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 05:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbhECDlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 23:41:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:43882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232190AbhECDlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 23:41:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7665561376;
        Mon,  3 May 2021 03:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620013249;
        bh=ktnGO7ezzdPQaEmNwxHsQPY+wNHcM5TVhz/MVE7KCrg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=d6ECKchhJ1kIVrfegeWGTNX+yjQdy3C9KyeCU5NrLmIZQFTTuKxd/1EVo2tP5Mrab
         uiF5Vneeo2rRvTvu06TQyl2VS/KN7Za5o5K/XpcOznS47M5DOfY/Q1MnyYAzVSeICQ
         3/6t/3VHquI7q215WWx24mjgfmCJcDBVA//B9x2loosPAB8Xt/6fRJB/K12yhq27XG
         3exPsXbMgtoPyUha5Kh6Nq5ka5MiuGqCF1hqLhKIoOdeljGdOIPgnYkAT3gfgmzJb7
         JXUm6aam+qKYMoaa8mMIhon6YsbzLpgv1abW+OvsznfSe7ZtSOEZcMUYcx4qN1bIaM
         HQw0U4FZ5N53g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3F7C55C01C9; Sun,  2 May 2021 20:40:49 -0700 (PDT)
Date:   Sun, 2 May 2021 20:40:49 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Michel Lespinasse <michel@lespinasse.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 13/37] mm: implement speculative handling in
 __handle_mm_fault().
Message-ID: <20210503034049.GQ975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210407014502.24091-1-michel@lespinasse.org>
 <20210407014502.24091-14-michel@lespinasse.org>
 <eee7431c-3dc8-ca3c-02fb-9e059d30e951@kernel.org>
 <20210428145823.GA856@lespinasse.org>
 <CALCETrVRGtVqv9cMSryfg5q3iZ9s3jBey20cY4K23YLRhQRzbQ@mail.gmail.com>
 <20210428161108.GP975577@paulmck-ThinkPad-P17-Gen-1>
 <20210429000225.GC10973@lespinasse.org>
 <20210429155250.GV975577@paulmck-ThinkPad-P17-Gen-1>
 <20210429183412.GA278623@paulmck-ThinkPad-P17-Gen-1>
 <20210429211758.GE10973@lespinasse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429211758.GE10973@lespinasse.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 02:17:58PM -0700, Michel Lespinasse wrote:
> On Thu, Apr 29, 2021 at 11:34:12AM -0700, Paul E. McKenney wrote:
> > ------------------------------------------------------------------------
> > 
> > commit 97262c64c2cf807bf06825e454c4bedd228fadfb
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Thu Apr 29 11:18:01 2021 -0700
> > 
> >     rcu: Improve comments describing RCU read-side critical sections
> >     
> >     There are a number of places that call out the fact that preempt-disable
> >     regions of code now act as RCU read-side critical sections, where
> >     preempt-disable regions of code include irq-disable regions of code,
> >     bh-disable regions of code, hardirq handlers, and NMI handlers.  However,
> >     someone relying solely on (for example) the call_rcu() header comment
> >     might well have no idea that preempt-disable regions of code have RCU
> >     semantics.
> >     
> >     This commit therefore updates the header comments for
> >     call_rcu(), synchronize_rcu(), rcu_dereference_bh_check(), and
> >     rcu_dereference_sched_check() to call out these new(ish) forms of RCU
> >     readers.
> >     
> >     Reported-by: Michel Lespinasse <michel@lespinasse.org>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > index a10480f2b4ef..c01b04ad64c4 100644
> > --- a/include/linux/rcupdate.h
> > +++ b/include/linux/rcupdate.h
> > @@ -532,7 +532,10 @@ do {									      \
> >   * @p: The pointer to read, prior to dereferencing
> >   * @c: The conditions under which the dereference will take place
> >   *
> > - * This is the RCU-bh counterpart to rcu_dereference_check().
> > + * This is the RCU-bh counterpart to rcu_dereference_check().  However,
> > + * please note that in recent kernels, synchronize_rcu() waits for
> > + * local_bh_disable() regions of code in addition to regions of code
> > + * demarked by rcu_read_lock() and rcu_read_unlock().
> 
> Two things:
> - "recent kernels" could be clarified, as Matthew pointed out
> - The above is not 100% clear if call_rcu() also waits for
>   local_bh_disable() regions of code ? (you did clarify this in tree.c
>   but I think it's better to have that here as well)

Good points, I updated both.

> >   */
> >  #define rcu_dereference_bh_check(p, c) \
> >  	__rcu_dereference_check((p), (c) || rcu_read_lock_bh_held(), __rcu)
> > @@ -543,6 +546,9 @@ do {									      \
> >   * @c: The conditions under which the dereference will take place
> >   *
> >   * This is the RCU-sched counterpart to rcu_dereference_check().
> > + * However, please note that in recent kernels, synchronize_rcu() waits
> > + * for preemption-disabled regions of code in addition to regions of code
> > + * demarked by rcu_read_lock() and rcu_read_unlock().
> 
> Same comments regarding "recent kernels" and call_rcu() here.

And here as well.

> >   */
> >  #define rcu_dereference_sched_check(p, c) \
> >  	__rcu_dereference_check((p), (c) || rcu_read_lock_sched_held(), \
> > @@ -634,6 +640,12 @@ do {									      \
> >   * sections, invocation of the corresponding RCU callback is deferred
> >   * until after the all the other CPUs exit their critical sections.
> >   *
> > + * In recent kernels, synchronize_rcu() and call_rcu() also wait for
> > + * regions of code with preemption disabled, including regions of code
> > + * with interrupts or softirqs disabled.  If your kernel is old enough
> > + * for synchronize_sched() to be defined, only code enclosed within
> > + * rcu_read_lock() and rcu_read_unlock() are guaranteed to be waited for.
> > + *
> 
> Thanks, this is the quote I was looking for, and also I think it's
> important for it to be in rcupdate.h rather than any .c implementation
> (I think it's more natural to look at headers for this kind of stuff).
> 
> Same comment regarding "old enough" / "recent kernels" though.
> 
> >   * Note, however, that RCU callbacks are permitted to run concurrently
> >   * with new RCU read-side critical sections.  One way that this can happen
> >   * is via the following sequence of events: (1) CPU 0 enters an RCU
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> 
> The tree.c changes look fine to me.

I added the version here also.

> Thanks a lot for looking into this !

And here is the updated commit.  Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

commit cc5a0ad5aa52d26379d5cd04d0a8f0917caf7365
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Thu Apr 29 11:18:01 2021 -0700

    rcu: Improve comments describing RCU read-side critical sections
    
    There are a number of places that call out the fact that preempt-disable
    regions of code now act as RCU read-side critical sections, where
    preempt-disable regions of code include irq-disable regions of code,
    bh-disable regions of code, hardirq handlers, and NMI handlers.  However,
    someone relying solely on (for example) the call_rcu() header comment
    might well have no idea that preempt-disable regions of code have RCU
    semantics.
    
    This commit therefore updates the header comments for
    call_rcu(), synchronize_rcu(), rcu_dereference_bh_check(), and
    rcu_dereference_sched_check() to call out these new(ish) forms of RCU
    readers.
    
    Reported-by: Michel Lespinasse <michel@lespinasse.org>
    [ paulmck: Apply Matthew Wilcox and Michel Lespinasse feedback. ]
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index a10480f2b4ef..adc2043e92db 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -532,7 +532,12 @@ do {									      \
  * @p: The pointer to read, prior to dereferencing
  * @c: The conditions under which the dereference will take place
  *
- * This is the RCU-bh counterpart to rcu_dereference_check().
+ * This is the RCU-bh counterpart to rcu_dereference_check().  However,
+ * please note that starting in v5.0 kernels, vanilla RCU grace periods
+ * wait for local_bh_disable() regions of code in addition to regions of
+ * code demarked by rcu_read_lock() and rcu_read_unlock().  This means
+ * that synchronize_rcu(), call_rcu, and friends all take not only
+ * rcu_read_lock() but also rcu_read_lock_bh() into account.
  */
 #define rcu_dereference_bh_check(p, c) \
 	__rcu_dereference_check((p), (c) || rcu_read_lock_bh_held(), __rcu)
@@ -543,6 +548,11 @@ do {									      \
  * @c: The conditions under which the dereference will take place
  *
  * This is the RCU-sched counterpart to rcu_dereference_check().
+ * However, please note that starting in v5.0 kernels, vanilla RCU grace
+ * periods wait for preempt_disable() regions of code in addition to
+ * regions of code demarked by rcu_read_lock() and rcu_read_unlock().
+ * This means that synchronize_rcu(), call_rcu, and friends all take not
+ * only rcu_read_lock() but also rcu_read_lock_sched() into account.
  */
 #define rcu_dereference_sched_check(p, c) \
 	__rcu_dereference_check((p), (c) || rcu_read_lock_sched_held(), \
@@ -634,6 +644,12 @@ do {									      \
  * sections, invocation of the corresponding RCU callback is deferred
  * until after the all the other CPUs exit their critical sections.
  *
+ * In recent kernels, synchronize_rcu() and call_rcu() also wait for
+ * regions of code with preemption disabled, including regions of code
+ * with interrupts or softirqs disabled.  If your kernel is old enough
+ * for synchronize_sched() to be defined, only code enclosed within
+ * rcu_read_lock() and rcu_read_unlock() are guaranteed to be waited for.
+ *
  * Note, however, that RCU callbacks are permitted to run concurrently
  * with new RCU read-side critical sections.  One way that this can happen
  * is via the following sequence of events: (1) CPU 0 enters an RCU
@@ -728,9 +744,11 @@ static inline void rcu_read_unlock(void)
 /**
  * rcu_read_lock_bh() - mark the beginning of an RCU-bh critical section
  *
- * This is equivalent of rcu_read_lock(), but also disables softirqs.
- * Note that anything else that disables softirqs can also serve as
- * an RCU read-side critical section.
+ * This is equivalent to rcu_read_lock(), but also disables softirqs.
+ * Note that anything else that disables softirqs can also serve as an RCU
+ * read-side critical section.  However, please note that this equivalence
+ * applies only to v5.0 and later.  Before v5.0, rcu_read_lock() and
+ * rcu_read_lock_bh() were unrelated.
  *
  * Note that rcu_read_lock_bh() and the matching rcu_read_unlock_bh()
  * must occur in the same context, for example, it is illegal to invoke
@@ -763,9 +781,12 @@ static inline void rcu_read_unlock_bh(void)
 /**
  * rcu_read_lock_sched() - mark the beginning of a RCU-sched critical section
  *
- * This is equivalent of rcu_read_lock(), but disables preemption.
- * Read-side critical sections can also be introduced by anything else
- * that disables preemption, including local_irq_disable() and friends.
+ * This is equivalent to rcu_read_lock(), but also disables preemption.
+ * Read-side critical sections can also be introduced by anything else that
+ * disables preemption, including local_irq_disable() and friends.  However,
+ * please note that the equivalence to rcu_read_lock() applies only to
+ * v5.0 and later.  Before v5.0, rcu_read_lock() and rcu_read_lock_sched()
+ * were unrelated.
  *
  * Note that rcu_read_lock_sched() and the matching rcu_read_unlock_sched()
  * must occur in the same context, for example, it is illegal to invoke
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9ea1d4eef1ad..9089c23e80dc 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3071,12 +3071,14 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
  * period elapses, in other words after all pre-existing RCU read-side
  * critical sections have completed.  However, the callback function
  * might well execute concurrently with RCU read-side critical sections
- * that started after call_rcu() was invoked.  RCU read-side critical
- * sections are delimited by rcu_read_lock() and rcu_read_unlock(), and
- * may be nested.  In addition, regions of code across which interrupts,
- * preemption, or softirqs have been disabled also serve as RCU read-side
- * critical sections.  This includes hardware interrupt handlers, softirq
- * handlers, and NMI handlers.
+ * that started after call_rcu() was invoked.
+ *
+ * RCU read-side critical sections are delimited by rcu_read_lock()
+ * and rcu_read_unlock(), and may be nested.  In addition, but only in
+ * v5.0 and later, regions of code across which interrupts, preemption,
+ * or softirqs have been disabled also serve as RCU read-side critical
+ * sections.  This includes hardware interrupt handlers, softirq handlers,
+ * and NMI handlers.
  *
  * Note that all CPUs must agree that the grace period extended beyond
  * all pre-existing RCU read-side critical section.  On systems with more
@@ -3771,10 +3773,12 @@ static int rcu_blocking_is_gp(void)
  * read-side critical sections have completed.  Note, however, that
  * upon return from synchronize_rcu(), the caller might well be executing
  * concurrently with new RCU read-side critical sections that began while
- * synchronize_rcu() was waiting.  RCU read-side critical sections are
- * delimited by rcu_read_lock() and rcu_read_unlock(), and may be nested.
- * In addition, regions of code across which interrupts, preemption, or
- * softirqs have been disabled also serve as RCU read-side critical
+ * synchronize_rcu() was waiting.
+ *
+ * RCU read-side critical sections are delimited by rcu_read_lock()
+ * and rcu_read_unlock(), and may be nested.  In addition, but only in
+ * v5.0 and later, regions of code across which interrupts, preemption,
+ * or softirqs have been disabled also serve as RCU read-side critical
  * sections.  This includes hardware interrupt handlers, softirq handlers,
  * and NMI handlers.
  *
