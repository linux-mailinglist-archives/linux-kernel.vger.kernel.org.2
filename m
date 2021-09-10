Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB88406D43
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 16:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbhIJOFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 10:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbhIJOFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 10:05:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62BDC061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 07:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wOqrrvDZiOq5cww66uejzparN3JwZPm6+E/WejBRpDQ=; b=H13Bubyutnr2EXQUUbC5DxLhRv
        fWrgsTuFg9+FtSCekMRuJdXAwrAzq5fn+rfGYXt0KiJVcxmIGUiyz28NDBGHL4rfIyPN9eQFqN4p1
        D2Wkb2oYlqnYTTRRNuwl4YcLilqB1CTHtRLFPYDAZLWOVXeHE3opqzn3BiSDGuYeZLThAvjvfA8i4
        bKbQ6Xy5E1VzmE5EwmGhfL9r5YZ8jP/6BlkzZxabNAtvjopb8gTOnEXSKeMnf/wQ5NJ85FMQQg7Qb
        9FmMhlDPD+e7Vv5JvUExV9zkmGJAA3w6Hg88cfkn3GX14Ihk3WeKXfIDAi4X597LWOkVSLXhfAKs6
        rjlsRoQA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOh5u-00B3r6-4P; Fri, 10 Sep 2021 14:01:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2CA7B300047;
        Fri, 10 Sep 2021 16:01:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 167EE23CBCBF6; Fri, 10 Sep 2021 16:01:29 +0200 (CEST)
Date:   Fri, 10 Sep 2021 16:01:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     tglx@linutronix.de, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 1/4] sched/wakeup: Strengthen
 current_save_and_set_rtlock_wait_state()
Message-ID: <YTtlOQfAl/cT5Na9@hirez.programming.kicks-ass.net>
References: <20210909105915.757320973@infradead.org>
 <20210909110203.767330253@infradead.org>
 <20210909134524.GB9722@willie-the-truck>
 <YToZ4h/nfsrD3JfY@hirez.programming.kicks-ass.net>
 <20210910125658.GA1454@willie-the-truck>
 <YTta0Kkz4OeFzUvJ@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTta0Kkz4OeFzUvJ@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 03:17:04PM +0200, Peter Zijlstra wrote:
> On Fri, Sep 10, 2021 at 01:57:26PM +0100, Will Deacon wrote:
> > On Thu, Sep 09, 2021 at 04:27:46PM +0200, Peter Zijlstra wrote:
> > > Moo yes, so the earlier changelog I wrote was something like:
> > > 
> > > 	current_save_and_set_rtlock_wait_state();
> > > 	for (;;) {
> > > 		if (try_lock())
> > > 			break;
> > > 
> > > 		raw_spin_unlock_irq(&lock->wait_lock);
> > > 		if (!cond)
> > > 			schedule();
> > > 		raw_spin_lock_irq(&lock->wait_lock);
> > > 
> > > 		set_current_state(TASK_RTLOCK_WAIT);
> > > 	}
> > > 	current_restore_rtlock_saved_state();
> > > 
> > > which is more what the code looks like before these patches, and in that
> > > case the @cond load can be lifted before __state.
> > 
> > Ah, so that makes more sense, thanks. I can't see how the try_lock() could
> > be reordered though, as it's going to have to do an atomic rmw.
> 
> OK, lemme go update the Changelog and make it __flags for bigeasy :-)

The patch now reads:

---
Subject: sched/wakeup: Strengthen current_save_and_set_rtlock_wait_state()
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 09 Sep 2021 12:59:16 +0200

While looking at current_save_and_set_rtlock_wait_state() I'm thinking
it really ought to use smp_store_mb(), because using it for a more
traditional wait loop like:

	current_save_and_set_rtlock_wait_state();
	for (;;) {
		if (cond)
			schedule();

		set_current_state(TASK_RTLOCK_WAIT);
	}
	current_restore_rtlock_saved_state();

is actually broken, since the cond load could be re-ordered against
the state store, which could lead to a missed wakeup -> BAD (tm).

While there, make them consistent with the IRQ usage in
set_special_state().

Fixes: 5f220be21418 ("sched/wakeup: Prepare for RT sleeping spin/rwlocks")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210909110203.767330253@infradead.org
---
 include/linux/sched.h |   21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -218,7 +218,7 @@ struct task_group;
  */
 #define set_special_state(state_value)					\
 	do {								\
-		unsigned long flags; /* may shadow */			\
+		unsigned long __flags; /* may shadow */			\
 									\
 		raw_spin_lock_irqsave(&current->pi_lock, flags);	\
 		debug_special_state_change((state_value));		\
@@ -245,7 +245,8 @@ struct task_group;
  *		if (try_lock())
  *			break;
  *		raw_spin_unlock_irq(&lock->wait_lock);
- *		schedule_rtlock();
+ *		if (!cond)
+ *			schedule_rtlock();
  *		raw_spin_lock_irq(&lock->wait_lock);
  *		set_current_state(TASK_RTLOCK_WAIT);
  *	}
@@ -253,22 +254,24 @@ struct task_group;
  */
 #define current_save_and_set_rtlock_wait_state()			\
 	do {								\
-		lockdep_assert_irqs_disabled();				\
-		raw_spin_lock(&current->pi_lock);			\
+		unsigned long __flags; /* may shadow */			\
+									\
+		raw_spin_lock_irqsave(&current->pi_lock, flags);	\
 		current->saved_state = current->__state;		\
 		debug_rtlock_wait_set_state();				\
-		WRITE_ONCE(current->__state, TASK_RTLOCK_WAIT);		\
-		raw_spin_unlock(&current->pi_lock);			\
+		smp_store_mb(current->__state, TASK_RTLOCK_WAIT);	\
+		raw_spin_unlock_irqrestore(&current->pi_lock, flags);	\
 	} while (0);
 
 #define current_restore_rtlock_saved_state()				\
 	do {								\
-		lockdep_assert_irqs_disabled();				\
-		raw_spin_lock(&current->pi_lock);			\
+		unsigned long __flags; /* may shadow */			\
+									\
+		raw_spin_lock_irqsave(&current->pi_lock, flags);	\
 		debug_rtlock_wait_restore_state();			\
 		WRITE_ONCE(current->__state, current->saved_state);	\
 		current->saved_state = TASK_RUNNING;			\
-		raw_spin_unlock(&current->pi_lock);			\
+		raw_spin_unlock_irqrestore(&current->pi_lock, flags);	\
 	} while (0);
 
 #define get_current_state()	READ_ONCE(current->__state)
