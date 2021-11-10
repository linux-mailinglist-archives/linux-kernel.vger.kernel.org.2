Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D948A44BD82
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 10:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhKJJDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 04:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbhKJJCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 04:02:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211E7C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 00:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NIRfoNK70/n/xcLNHSaZpQMkcUyWZSdLOTfwmxdRRUg=; b=menE5EXzucCH4xc+dbe6SSnuep
        Rkp+jKJZT0843OQYcmmxbxNwZuMUheVaEZZGhxXXN97GrdkBDH5Nzk4aO0hVPFgL6ZpftLDVRq6t4
        CdyRUMoUa1QLsPy5uzk4hyycCqFaXIQGeHrKybxLpTpSL6g9EFLP1uoVVMtJJ6epwwr0QgIeM138a
        l+IZWM6ySFuw8HLnWDYYHIq9D5+Kb8/QDuoMoGyTuxfLdU+9sUQncwiQh/m6mlBmKz2zYkL6Pk1Rx
        VEs9FZSvAdPdJhjaWZxFrD37zdlZyzky1x2d2jGHKcQ1CMqzz6kgqB6Cscd/siaYhMTmJ84RuialZ
        /ecsle4g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkjRn-001ij6-LT; Wed, 10 Nov 2021 08:59:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9B4003000DD;
        Wed, 10 Nov 2021 09:59:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5DD212B74C9C0; Wed, 10 Nov 2021 09:59:11 +0100 (CET)
Date:   Wed, 10 Nov 2021 09:59:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineethrp@gmail.com>,
        Hao Luo <haoluo@google.com>, Tao Zhou <tao.zhou@linux.dev>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/core: forced idle accounting
Message-ID: <YYuJ3yE0gottvExw@hirez.programming.kicks-ass.net>
References: <20211018203428.2025792-1-joshdon@google.com>
 <YYpYP919xlC0NX7/@hirez.programming.kicks-ass.net>
 <CABk29NucnFxyPQ==n8-v=_hti2THkybrEkxruqJ_v8rvW4yacg@mail.gmail.com>
 <YYuFHZCxtJe+BpWM@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYuFHZCxtJe+BpWM@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 09:38:53AM +0100, Peter Zijlstra wrote:
> On Tue, Nov 09, 2021 at 02:59:00PM -0800, Josh Don wrote:
> > On Tue, Nov 9, 2021 at 3:15 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Mon, Oct 18, 2021 at 01:34:28PM -0700, Josh Don wrote:
> > > > @@ -5804,6 +5830,12 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> > > >               }
> > > >       }
> > > >
> > > > +     if (rq->core->core_forceidle_count) {
> > >
> > > Does this want to be something like:
> > >
> > >         if (schedstat_enabled() && .. ) ?
> > >
> > > afaict without schedstat on this is dead code.
> > >
> > 
> > Makes sense to me, and similarly we can bail out of sched_core_tick()
> > early in the disabled case.
> 
> Ok, I already changed the patch to include the above, lemme also edit
> sched_core_tick().


Something like so then?

--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -235,7 +235,7 @@ int sched_core_share_pid(unsigned int cm
 #ifdef CONFIG_SCHEDSTATS
 
 /* REQUIRES: rq->core's clock recently updated. */
-void sched_core_account_forceidle(struct rq *rq)
+void __sched_core_account_forceidle(struct rq *rq)
 {
 	const struct cpumask *smt_mask = cpu_smt_mask(cpu_of(rq));
 	u64 delta, now = rq_clock(rq->core);
@@ -256,9 +256,6 @@ void sched_core_account_forceidle(struct
 
 	rq->core->core_forceidle_start = now;
 
-	if (!schedstat_enabled())
-		return;
-
 	if (WARN_ON_ONCE(!rq->core->core_forceidle_occupation)) {
 		/* can't be forced idle without a running task */
 	} else if (rq->core->core_forceidle_count > 1 ||
@@ -283,17 +280,15 @@ void sched_core_account_forceidle(struct
 	}
 }
 
-void sched_core_tick(struct rq *rq)
+void __sched_core_tick(struct rq *rq)
 {
-	if (!sched_core_enabled(rq))
-		return;
-
 	if (!rq->core->core_forceidle_count)
 		return;
 
 	if (rq != rq->core)
 		update_rq_clock(rq->core);
-	sched_core_account_forceidle(rq);
+
+	__sched_core_account_forceidle(rq);
 }
 
 #endif /* CONFIG_SCHEDSTATS */
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1304,20 +1304,6 @@ static inline bool sched_group_cookie_ma
 }
 #endif /* CONFIG_SCHED_CORE */
 
-#if defined(CONFIG_SCHED_CORE) && defined(CONFIG_SCHEDSTATS)
-
-extern void sched_core_account_forceidle(struct rq *rq);
-
-extern void sched_core_tick(struct rq *rq);
-
-#else
-
-static inline void sched_core_account_forceidle(struct rq *rq) {}
-
-static inline void sched_core_tick(struct rq *rq) {}
-
-#endif /* CONFIG_SCHED_CORE && CONFIG_SCHEDSTATS */
-
 static inline void lockdep_assert_rq_held(struct rq *rq)
 {
 	lockdep_assert_held(__rq_lockp(rq));
@@ -1870,6 +1856,32 @@ static inline void flush_smp_call_functi
 #include "stats.h"
 #include "autogroup.h"
 
+#if defined(CONFIG_SCHED_CORE) && defined(CONFIG_SCHEDSTATS)
+
+extern void __sched_core_account_forceidle(struct rq *rq);
+
+static inline void sched_core_account_forceidle(struct rq *rq)
+{
+	if (schedstat_enabled())
+		__sched_core_account_forceidle(rq);
+}
+
+extern void __sched_core_tick(struct rq *rq);
+
+static inline void sched_core_tick(struct rq *rq)
+{
+	if (sched_core_enabled(rq) && schedstat_enabled())
+		__sched_core_tick(rq);
+}
+
+#else
+
+static inline void sched_core_account_forceidle(struct rq *rq) {}
+
+static inline void sched_core_tick(struct rq *rq) {}
+
+#endif /* CONFIG_SCHED_CORE && CONFIG_SCHEDSTATS */
+
 #ifdef CONFIG_CGROUP_SCHED
 
 /*
