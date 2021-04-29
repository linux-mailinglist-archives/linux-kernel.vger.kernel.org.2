Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB9536EF7C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 20:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241189AbhD2SfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 14:35:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:58866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233338AbhD2Se7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 14:34:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A3A661408;
        Thu, 29 Apr 2021 18:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619721252;
        bh=lDWMiExeI+ct5vP0/tZlI7LjbVVbBB3hGK6uCPTpoFM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IUgdEcAPOXUPpSw3NNhM5xzMxaNW6f5Eb1qAMhYTkZ9ViXie85bN4QAHnUlTlGPPg
         I4cu7A/G1ttw7rLZlJKCgrhWtDFkYbCXQOdSj1iDv6U4V1j2M5+lbCPNx0Y65MykRo
         XfcbPWoBxYT/RxYzBjsYTPqYltWEyAeqmRLUjiKUZj0cHT664hnxkW+lZ/GKkBWlNB
         k8bAVOB+/QtpwAOqxTU5CVX2ON2HM19ensWmVNOfXYD+LgzJsy0TMndInK08uaTUck
         FecgciwEp6mf1RibThnEYNHJoy12iyqkYKFA28WSCUszStJ1cjwkgu9lp+pnGkpYY2
         JkJPG3yVZMkJQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 14B175C00E9; Thu, 29 Apr 2021 11:34:12 -0700 (PDT)
Date:   Thu, 29 Apr 2021 11:34:12 -0700
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
Message-ID: <20210429183412.GA278623@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210407014502.24091-1-michel@lespinasse.org>
 <20210407014502.24091-14-michel@lespinasse.org>
 <eee7431c-3dc8-ca3c-02fb-9e059d30e951@kernel.org>
 <20210428145823.GA856@lespinasse.org>
 <CALCETrVRGtVqv9cMSryfg5q3iZ9s3jBey20cY4K23YLRhQRzbQ@mail.gmail.com>
 <20210428161108.GP975577@paulmck-ThinkPad-P17-Gen-1>
 <20210429000225.GC10973@lespinasse.org>
 <20210429155250.GV975577@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429155250.GV975577@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 08:52:50AM -0700, Paul E. McKenney wrote:
> On Wed, Apr 28, 2021 at 05:02:25PM -0700, Michel Lespinasse wrote:
> > On Wed, Apr 28, 2021 at 09:11:08AM -0700, Paul E. McKenney wrote:
> > > On Wed, Apr 28, 2021 at 08:13:53AM -0700, Andy Lutomirski wrote:
> > > > On Wed, Apr 28, 2021 at 8:05 AM Michel Lespinasse <michel@lespinasse.org> wrote:
> > > > >
> > > > > On Wed, Apr 07, 2021 at 08:36:01AM -0700, Andy Lutomirski wrote:
> > > > > > On 4/6/21 6:44 PM, Michel Lespinasse wrote:
> > > > > > > The page table tree is walked with local irqs disabled, which prevents
> > > > > > > page table reclamation (similarly to what fast GUP does). The logic is
> > > > > > > otherwise similar to the non-speculative path, but with additional
> > > > > > > restrictions: in the speculative path, we do not handle huge pages or
> > > > > > > wiring new pages tables.
> > > > > >
> > > > > > Not on most architectures.  Quoting the actual comment in mm/gup.c:
> > > > > >
> > > > > > >  * Before activating this code, please be aware that the following assumptions
> > > > > > >  * are currently made:
> > > > > > >  *
> > > > > > >  *  *) Either MMU_GATHER_RCU_TABLE_FREE is enabled, and tlb_remove_table() is used to
> > > > > > >  *  free pages containing page tables or TLB flushing requires IPI broadcast.
> > > > > >
> > > > > > On MMU_GATHER_RCU_TABLE_FREE architectures, you cannot make the
> > > > > > assumption that it is safe to dereference a pointer in a page table just
> > > > > > because irqs are off.  You need RCU protection, too.
> > > > > >
> > > > > > You have the same error in the cover letter.
> > > > >
> > > > > Hi Andy,
> > > > >
> > > > > Thanks for your comment. At first I thought did not matter, because we
> > > > > only enable ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT on selected
> > > > > architectures, and I thought MMU_GATHER_RCU_TABLE_FREE is not set on
> > > > > these. But I was wrong - MMU_GATHER_RCU_TABLE_FREE is enabled on X86
> > > > > with paravirt. So I took another look at fast GUP to make sure I
> > > > > actually understand it.
> > > > >
> > > > > This brings a question about lockless_pages_from_mm() - I see it
> > > > > disabling interrupts, which it explains is necessary for disabling THP
> > > > > splitting IPIs, but I do not see it taking an RCU read lock as would
> > > > > be necessary for preventing paga table freeing on
> > > > > MMU_GATHER_RCU_TABLE_FREE configs. I figure local_irq_save()
> > > > > indirectly takes an rcu read lock somehow ? I think this is something
> > > > > I should also mention in my explanation, and I have not seen a good
> > > > > description of this on the fast GUP side...
> > > > 
> > > > Sounds like a bug!  That being said, based on my extremely limited
> > > > understanding of how the common RCU modes work, local_irq_save()
> > > > probably implies an RCU lock in at least some cases.  Hi Paul!
> > > 
> > > In modern kernels, local_irq_save() does have RCU reader semantics,
> > > meaning that synchronize_rcu() will wait for pre-exiting irq-disabled
> > > regions.  It will also wait for pre-existing bh-disable, preempt-disable,
> > > and of course rcu_read_lock() sections of code.
> > 
> > Thanks Paul for confirming / clarifying this. BTW, it would be good to
> > add this to the rcu header files, just so people have something to
> > reference to when they depend on such behavior (like fast GUP
> > currently does).
> 
> There is this in the synchronize_rcu() header block comment:
> 
>  * synchronize_rcu() was waiting.  RCU read-side critical sections are
>  * delimited by rcu_read_lock() and rcu_read_unlock(), and may be nested.
>  * In addition, regions of code across which interrupts, preemption, or
>  * softirqs have been disabled also serve as RCU read-side critical
>  * sections.  This includes hardware interrupt handlers, softirq handlers,
>  * and NMI handlers.
> 
> I have pulled this into a separate paragraph to increase its visibility,
> and will check out other locations in comments and documentation.

Ditto for call_rcu() and the separate paragraph.

The rcu_read_lock_bh() and rcu_read_lock_sched() header comments noted
that these act as RCU read-side critical sections, but I added similar
verbiage to rcu_dereference_bh_check() and rcu_dereference_sched_check().

Please see below for the resulting commit.

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

commit 97262c64c2cf807bf06825e454c4bedd228fadfb
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
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index a10480f2b4ef..c01b04ad64c4 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -532,7 +532,10 @@ do {									      \
  * @p: The pointer to read, prior to dereferencing
  * @c: The conditions under which the dereference will take place
  *
- * This is the RCU-bh counterpart to rcu_dereference_check().
+ * This is the RCU-bh counterpart to rcu_dereference_check().  However,
+ * please note that in recent kernels, synchronize_rcu() waits for
+ * local_bh_disable() regions of code in addition to regions of code
+ * demarked by rcu_read_lock() and rcu_read_unlock().
  */
 #define rcu_dereference_bh_check(p, c) \
 	__rcu_dereference_check((p), (c) || rcu_read_lock_bh_held(), __rcu)
@@ -543,6 +546,9 @@ do {									      \
  * @c: The conditions under which the dereference will take place
  *
  * This is the RCU-sched counterpart to rcu_dereference_check().
+ * However, please note that in recent kernels, synchronize_rcu() waits
+ * for preemption-disabled regions of code in addition to regions of code
+ * demarked by rcu_read_lock() and rcu_read_unlock().
  */
 #define rcu_dereference_sched_check(p, c) \
 	__rcu_dereference_check((p), (c) || rcu_read_lock_sched_held(), \
@@ -634,6 +640,12 @@ do {									      \
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
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9ea1d4eef1ad..0e76bf47d92b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3071,12 +3071,13 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
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
+ * RCU read-side critical sections are delimited by rcu_read_lock() and
+ * rcu_read_unlock(), and may be nested.  In addition, regions of code
+ * across which interrupts, preemption, or softirqs have been disabled
+ * also serve as RCU read-side critical sections.  This includes hardware
+ * interrupt handlers, softirq handlers, and NMI handlers.
  *
  * Note that all CPUs must agree that the grace period extended beyond
  * all pre-existing RCU read-side critical section.  On systems with more
@@ -3771,12 +3772,13 @@ static int rcu_blocking_is_gp(void)
  * read-side critical sections have completed.  Note, however, that
  * upon return from synchronize_rcu(), the caller might well be executing
  * concurrently with new RCU read-side critical sections that began while
- * synchronize_rcu() was waiting.  RCU read-side critical sections are
- * delimited by rcu_read_lock() and rcu_read_unlock(), and may be nested.
- * In addition, regions of code across which interrupts, preemption, or
- * softirqs have been disabled also serve as RCU read-side critical
- * sections.  This includes hardware interrupt handlers, softirq handlers,
- * and NMI handlers.
+ * synchronize_rcu() was waiting.
+ *
+ * RCU read-side critical sections are delimited by rcu_read_lock() and
+ * rcu_read_unlock(), and may be nested.  In addition, regions of code
+ * across which interrupts, preemption, or softirqs have been disabled
+ * also serve as RCU read-side critical sections.  This includes hardware
+ * interrupt handlers, softirq handlers, and NMI handlers.
  *
  * Note that this guarantee implies further memory-ordering guarantees.
  * On systems with more than one CPU, when synchronize_rcu() returns,
