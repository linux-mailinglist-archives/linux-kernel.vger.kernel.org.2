Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9AE336D49C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 11:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237920AbhD1JO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 05:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhD1JO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 05:14:28 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6F6C061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 02:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BIoHFDWt30IDnc3GXkviCGSahwifPN4YHWVVjZg5LMc=; b=IgyUlM2tj8IrHLzT9Gz3aAaaq6
        2ph2+7UhJv0MXo1b8Mrd0NfdxO3cDk2dHQk3utlQrNElRWmxKkKjy/ePj8AbPc0ZDUowZVXQKzCee
        DiP9m8r+ttrU40dHUe3CURhpf3wTIo7DhkxhFQRP5l+314mr4iqREig1QasQahUp9+DIPVSlG79ti
        9GXwHZmDaZB0E0cJA5I4J4DSdK6xeNxfQw0NE+935ZuDdmaHsisnyko9UICbNJael14WyO9Ut36m1
        EnuU+QJN0yGlExlke8hH4L7XEa1exSnC6Zgn3qaOWWnQ0F10KVI15XnN279+V2/BGMY1YcpJT93bT
        DQng1fvA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lbgGE-003Bsj-Rf; Wed, 28 Apr 2021 09:13:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 94B80300091;
        Wed, 28 Apr 2021 11:13:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 48A982BF7B839; Wed, 28 Apr 2021 11:13:33 +0200 (CEST)
Date:   Wed, 28 Apr 2021 11:13:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, dhiatt@digitalocean.com
Subject: Re: [PATCH 04/19] sched: Prepare for Core-wide rq->lock
Message-ID: <YIknPXxwZvq0qmId@hirez.programming.kicks-ass.net>
References: <20210422120459.447350175@infradead.org>
 <20210422123308.196692074@infradead.org>
 <CABk29Ntop2nX+z1bV7giG8ToR_w3f_+GYGAw+hFQ6g9rCZunmw@mail.gmail.com>
 <YIZ6ZpkrMGQ9A9x2@hirez.programming.kicks-ass.net>
 <CABk29NvicqM_c2ssYnDrEy_FPsfD5GH38rB_XHooErALOabe5g@mail.gmail.com>
 <CABk29NvaH687GfOm_b5_hJF6HBQ6fu+1hzc0GFNEMv5mj3DrUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29NvaH687GfOm_b5_hJF6HBQ6fu+1hzc0GFNEMv5mj3DrUw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 04:30:02PM -0700, Josh Don wrote:

> Also, did you mean to have a preempt_enable_no_resched() rather than
> prempt_enable() in raw_spin_rq_trylock?

No, trylock really needs to be preempt_enable(), because it can have
failed, at which point it will not have incremented the preemption count
and our decrement can hit 0, at which point we really should reschedule.

> I went over the rq_lockp stuff again after Don's reported lockup. Most
> uses are safe due to already holding an rq lock. However,
> double_rq_unlock() is prone to race:
> 
> double_rq_unlock(rq1, rq2):
> /* Initial state: core sched enabled, and rq1 and rq2 are smt
> siblings. So, double_rq_lock(rq1, rq2) only took a single rq lock */
> raw_spin_rq_unlock(rq1);
> /* now not holding any rq lock */
> /* sched core disabled. Now __rq_lockp(rq1) != __rq_lockp(rq2), so we
> falsely unlock rq2 */
> if (__rq_lockp(rq1) != __rq_lockp(rq2))
>         raw_spin_rq_unlock(rq2);
> else
>         __release(rq2->lock);
> 
> Instead we can cache __rq_lockp(rq1) and __rq_lockp(rq2) before
> releasing the lock, in order to prevent this. FWIW I think it is
> likely that Don is seeing a different issue.

Ah, indeed so.. rq_lockp() could do with an assertion, not sure how to
sanely do that. Anyway, double_rq_unlock() is simple enough to fix, we
can simply flip the unlock()s.

( I'm suffering a cold and am really quite slow atm )

How's this then?

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f732642e3e09..3a534c0c1c46 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -290,6 +290,10 @@ static void sched_core_assert_empty(void)
 static void __sched_core_enable(void)
 {
 	static_branch_enable(&__sched_core_enabled);
+	/*
+	 * Ensure raw_spin_rq_*lock*() have completed before flipping.
+	 */
+	synchronize_sched();
 	__sched_core_flip(true);
 	sched_core_assert_empty();
 }
@@ -449,16 +453,23 @@ void raw_spin_rq_lock_nested(struct rq *rq, int subclass)
 {
 	raw_spinlock_t *lock;
 
+	/* Matches synchronize_sched() in __sched_core_enabled() */
+	preempt_disable();
 	if (sched_core_disabled()) {
 		raw_spin_lock_nested(&rq->__lock, subclass);
+		/* preempt-count *MUST* be > 1 */
+		preempt_enable_no_resched();
 		return;
 	}
 
 	for (;;) {
 		lock = __rq_lockp(rq);
 		raw_spin_lock_nested(lock, subclass);
-		if (likely(lock == __rq_lockp(rq)))
+		if (likely(lock == __rq_lockp(rq))) {
+			/* preempt-count *MUST* be > 1 */
+			preempt_enable_no_resched();
 			return;
+		}
 		raw_spin_unlock(lock);
 	}
 }
@@ -468,14 +479,21 @@ bool raw_spin_rq_trylock(struct rq *rq)
 	raw_spinlock_t *lock;
 	bool ret;
 
-	if (sched_core_disabled())
-		return raw_spin_trylock(&rq->__lock);
+	/* Matches synchronize_sched() in __sched_core_enabled() */
+	preempt_disable();
+	if (sched_core_disabled()) {
+		ret = raw_spin_trylock(&rq->__lock);
+		preempt_enable();
+		return ret;
+	}
 
 	for (;;) {
 		lock = __rq_lockp(rq);
 		ret = raw_spin_trylock(lock);
-		if (!ret || (likely(lock == __rq_lockp(rq))))
+		if (!ret || (likely(lock == __rq_lockp(rq)))) {
+			preempt_enable();
 			return ret;
+		}
 		raw_spin_unlock(lock);
 	}
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6a905fe19eef..c9a52231d58a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2568,11 +2568,12 @@ static inline void double_rq_unlock(struct rq *rq1, struct rq *rq2)
 	__releases(rq1->lock)
 	__releases(rq2->lock)
 {
-	raw_spin_rq_unlock(rq1);
 	if (__rq_lockp(rq1) != __rq_lockp(rq2))
 		raw_spin_rq_unlock(rq2);
 	else
 		__release(rq2->lock);
+
+	raw_spin_rq_unlock(rq1);
 }
 
 extern void set_rq_online (struct rq *rq);
