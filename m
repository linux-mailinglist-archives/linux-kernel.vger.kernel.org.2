Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E3C3800B9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 01:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhEMXMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 19:12:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229544AbhEMXMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 19:12:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3063061263;
        Thu, 13 May 2021 23:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620947490;
        bh=shkz49Q/KRzo+03G48Nq9Ll4xVIQp0LbIA9DLkkqVz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EaDx7N7ckbHe7vOGU5txF/GKUOLGjdJGdk68flGReecUuSrns+XvpRAz5fipqZRZo
         P7niJImBhH0NBV6t1xNyozlOXo2Ql05JuhgZMWtemWTZBIeZ+vHpPRVX7WSMOOxyI7
         fnJCDAPgwcU0J+js83sOnlLWScbcr+19caIkbsdVBFB2y/zAPRJr9JapsxSPrVL2On
         pJOQl0kvIG7d70vE8HTW0r4aY7eH1NzZUfkc7/crgo7Mb+2yf3jU11MyfhSqMV93dJ
         KJRCh+47NUfmlRj2Eeqc9J14QD8nTNdAD5x2qWmYnnSgFdbiGNze5pi+3WapOdVSEf
         FdbNpiqvnPMyA==
Date:   Fri, 14 May 2021 01:11:27 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <oliver.sang@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
Subject: Re: [entry]  47b8ff194c:  will-it-scale.per_process_ops -3.0%
 regression
Message-ID: <20210513231127.GA165500@lothringen>
References: <20210428071653.GC13086@xsang-OptiPlex-9020>
 <YJzhCX/CqrMQDB+y@hirez.programming.kicks-ass.net>
 <20210513174636.GB975577@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513174636.GB975577@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 10:46:36AM -0700, Paul E. McKenney wrote:
> On Thu, May 13, 2021 at 10:19:21AM +0200, Peter Zijlstra wrote:
> > On Wed, Apr 28, 2021 at 03:16:53PM +0800, kernel test robot wrote:
> > > 
> > > 
> > > Greeting,
> > > 
> > > FYI, we noticed a -3.0% regression of will-it-scale.per_process_ops due to commit:
> > > 
> > > 
> > > commit: 47b8ff194c1fd73d58dc339b597d466fe48c8958 ("entry: Explicitly flush pending rcuog wakeup before last rescheduling point")
> > 
> > So the RCU bits are in rcu_user_enter(), which is called from
> > __context_tracking_enter() aka user_enter(), which is under
> > context_tracking_enabled().
> > 
> > But the new code in entry is not; we now unconditionally call
> > rcu_nocb_flush_deferred_wakeup(). Did that want to be under
> > context_tracking_enabled() as well?
> > 
> > Frederic, Paul?
> 
> My argument in favor of the change below is that if there is no context
> tracking, then scheduling-clock interrupts will happen on all non-idle
> CPUs.  The next scheduling-clock interrupt will check this deferred-wakeup
> state, and if set, cause rcu_core() to be invoked (for example, within the
> RCU_SOFTIRQ handler).  And rcu_core() invokes do_nocb_deferred_wakeup(),
> which takes care of this.
> 
> For idle CPUs, do_idle() invokes rcu_nocb_flush_deferred_wakeup().
> 
> Frederic, any cases that I am missing?

That sounds good, but two things:

1) Even if context tracking is not running, we still need to handle
   deferred wakeups on idle. But all user/guest/idle currently use the
   same function.

2) Context tracking may be running even when full nohz is not. But here only
   full nohz is concerned.

So the change should rather be as follows (completely untested!).
I rather put the static key check in tick.h in order not to involve
deep dependencies inside rcupdate.h (especially rcupdate.h -> tick.h -> sched.h)

diff --git a/include/linux/entry-kvm.h b/include/linux/entry-kvm.h
index 8b2b1d68b954..136b8d97d8c0 100644
--- a/include/linux/entry-kvm.h
+++ b/include/linux/entry-kvm.h
@@ -3,6 +3,7 @@
 #define __LINUX_ENTRYKVM_H
 
 #include <linux/entry-common.h>
+#include <linux/tick.h>
 
 /* Transfer to guest mode work */
 #ifdef CONFIG_KVM_XFER_TO_GUEST_WORK
@@ -57,7 +58,7 @@ int xfer_to_guest_mode_handle_work(struct kvm_vcpu *vcpu);
 static inline void xfer_to_guest_mode_prepare(void)
 {
 	lockdep_assert_irqs_disabled();
-	rcu_nocb_flush_deferred_wakeup();
+	tick_nohz_user_enter_prepare();
 }
 
 /**
diff --git a/include/linux/tick.h b/include/linux/tick.h
index 0bb80a7f05b9..bfd571f18cfd 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -11,6 +11,7 @@
 #include <linux/context_tracking_state.h>
 #include <linux/cpumask.h>
 #include <linux/sched.h>
+#include <linux/rcupdate.h>
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 extern void __init tick_init(void);
@@ -304,4 +305,10 @@ static inline void tick_nohz_task_switch(void)
 		__tick_nohz_task_switch();
 }
 
+static inline void tick_nohz_user_enter_prepare(void)
+{
+	if (tick_nohz_full_cpu(smp_processor_id()))
+		rcu_nocb_flush_deferred_wakeup();
+}
+
 #endif
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index a0b3b04fb596..bf16395b9e13 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -5,6 +5,7 @@
 #include <linux/highmem.h>
 #include <linux/livepatch.h>
 #include <linux/audit.h>
+#include <linux/tick.h>
 
 #include "common.h"
 
@@ -186,7 +187,7 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 		local_irq_disable_exit_to_user();
 
 		/* Check if any of the above work has queued a deferred wakeup */
-		rcu_nocb_flush_deferred_wakeup();
+		tick_nohz_user_enter_prepare();
 
 		ti_work = READ_ONCE(current_thread_info()->flags);
 	}
@@ -202,7 +203,7 @@ static void exit_to_user_mode_prepare(struct pt_regs *regs)
 	lockdep_assert_irqs_disabled();
 
 	/* Flush pending rcuog wakeup before the last need_resched() check */
-	rcu_nocb_flush_deferred_wakeup();
+	tick_nohz_user_enter_prepare();
 
 	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
 		ti_work = exit_to_user_mode_loop(regs, ti_work);
