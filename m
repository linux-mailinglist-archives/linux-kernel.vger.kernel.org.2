Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C1736AFC5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 10:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbhDZIcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 04:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbhDZIcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 04:32:23 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AA1C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 01:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eL8XVt5BRAXJfIlJlROfambfX03idOf5Kja4deVFnSI=; b=KjSgFVgs4vdlEnsuZCVr+vw1oq
        FdDpL42tXKuWdu/0Zw+rSK28+u3Nw5vk2+ZnmfYZfCMJDHf/VSl6FgWkOc3Z8Vnlp8eb8MqnJEn+E
        3bU277HeR5d9gmy7N3m60IUmMjkDyQw5wFOxBVIzdrc+ErWfT/sXo+58R3bjuxGFuUP/YvqIii8Q2
        FPezBobBWJeRlDKxPz9ksqDbFcADEpqIvd11xqDIgZYVb01zC20D0gX6M52me5pzaOocDyna1meNG
        BvfLgxRTeTqgnK4Ga0mEr0uJvw5V0SiIBtVX3F53rDGDzb2HGUjR6ZzVD0PfUIdgsneHymPKgjQ3X
        W9y5fIeg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1laweW-007DVe-1f; Mon, 26 Apr 2021 08:31:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 23D21300212;
        Mon, 26 Apr 2021 10:31:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D3DB3234E7138; Mon, 26 Apr 2021 10:31:34 +0200 (CEST)
Date:   Mon, 26 Apr 2021 10:31:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 04/19] sched: Prepare for Core-wide rq->lock
Message-ID: <YIZ6ZpkrMGQ9A9x2@hirez.programming.kicks-ass.net>
References: <20210422120459.447350175@infradead.org>
 <20210422123308.196692074@infradead.org>
 <CABk29Ntop2nX+z1bV7giG8ToR_w3f_+GYGAw+hFQ6g9rCZunmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29Ntop2nX+z1bV7giG8ToR_w3f_+GYGAw+hFQ6g9rCZunmw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 06:22:52PM -0700, Josh Don wrote:
> Hi Peter,
> 
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -186,12 +186,37 @@ int sysctl_sched_rt_runtime = 950000;
> >
> >  void raw_spin_rq_lock_nested(struct rq *rq, int subclass)
> >  {
> > -       raw_spin_lock_nested(rq_lockp(rq), subclass);
> > +       raw_spinlock_t *lock;
> > +
> > +       if (sched_core_disabled()) {
> 
> Nothing to stop sched_core from being enabled right here? Leading to
> us potentially taking the wrong lock.
> 
> > +               raw_spin_lock_nested(&rq->__lock, subclass);
> > +               return;
> > +       }
> > +
> > +       for (;;) {
> > +               lock = rq_lockp(rq);
> > +               raw_spin_lock_nested(lock, subclass);
> > +               if (likely(lock == rq_lockp(rq)))
> > +                       return;
> > +               raw_spin_unlock(lock);
> > +       }
> >  }

Very good; something like the below seems to be the best I can make of
it..

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f732642e3e09..1a81e9cc9e5d 100644
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
@@ -449,16 +453,22 @@ void raw_spin_rq_lock_nested(struct rq *rq, int subclass)
 {
 	raw_spinlock_t *lock;
 
+	preempt_disable();
 	if (sched_core_disabled()) {
 		raw_spin_lock_nested(&rq->__lock, subclass);
+		/* preempt *MUST* still be disabled here */
+		preempt_enable_no_resched();
 		return;
 	}
 
 	for (;;) {
 		lock = __rq_lockp(rq);
 		raw_spin_lock_nested(lock, subclass);
-		if (likely(lock == __rq_lockp(rq)))
+		if (likely(lock == __rq_lockp(rq))) {
+			/* preempt *MUST* still be disabled here */
+			preempt_enable_no_resched();
 			return;
+		}
 		raw_spin_unlock(lock);
 	}
 }
@@ -468,14 +478,20 @@ bool raw_spin_rq_trylock(struct rq *rq)
 	raw_spinlock_t *lock;
 	bool ret;
 
-	if (sched_core_disabled())
-		return raw_spin_trylock(&rq->__lock);
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
