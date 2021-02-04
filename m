Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF44B30F2E8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 13:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbhBDMKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 07:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235780AbhBDMKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 07:10:06 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81307C061573
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 04:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=W9UK59mZN1fK3WQEc0n2GOEp3h1uTPcH11g13YUlKTg=; b=yuaixOdeicIkfv4VTYvNoNKDqO
        6tQUyNe3noO8abw0gzvh+HhF0pLW8QJPudWj+BPqHHfnrqM003jkHKVJAfHz4Y5733crIeFg4gTsq
        BovWUqMB8H/yDt/Bf/9tydyNdkYz0MdINeUed3N2ogp0NbNz9C3zwzOU+WqsLAG0D9H8ewZkLEHZZ
        WkljePFrrRS/nBlUnUIwsvEzVqrzrxaWbMuEYdd9Uq4MOvINlD3xQBg+LhLsmfKdOuws711ynAuLB
        7tZj5Tehm1ykQEgXS/jQlF/STlIlllORpyUR82CBASfMPZyaG0HyfBeoi0mTclTHlYm3gK3pcn5bG
        VwInuLbQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7dRm-0007Nm-HO; Thu, 04 Feb 2021 12:09:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BB04A3003D8;
        Thu,  4 Feb 2021 13:09:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 86078213D2E27; Thu,  4 Feb 2021 13:09:13 +0100 (CET)
Date:   Thu, 4 Feb 2021 13:09:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matt Morehouse <mascasa@google.com>
Subject: Re: Process-wide watchpoints
Message-ID: <YBvj6eJR/DY2TsEB@hirez.programming.kicks-ass.net>
References: <CACT4Y+ayRHua-6UyRwSM3=_oi+NkXbaO3-zZ1mpDmWonbybkeA@mail.gmail.com>
 <CACT4Y+bW1gpv8bz0vswaVUt-OB07oJ3NBeTi+vchAe8TTWK+mg@mail.gmail.com>
 <CACT4Y+ZsKXfAxrzJGQc5mJ+QiP5sAw7zKWtciS+07qZzSf33mw@mail.gmail.com>
 <CACT4Y+YeRtOTsMQ8xxZg-=nbv+yuJvYYhBErT46M8jtSHmiw6g@mail.gmail.com>
 <YBqXPmbpXf4hnlj3@hirez.programming.kicks-ass.net>
 <CACT4Y+a-9kqX0ZkNz-ygib+ERn41HVo_8Wx6oYMQmPjTC06j7g@mail.gmail.com>
 <YBqnAYVdNM4uyGny@hirez.programming.kicks-ass.net>
 <CACT4Y+btOt5QFKH9Q=81EnpDHoidJUHE2s0oZ8v65t-b__awuw@mail.gmail.com>
 <YBvAsku9OWM7KUno@hirez.programming.kicks-ass.net>
 <CACT4Y+ZLSyVMkPfh3PftEWKC1kC+o1XLxo_o6i4BiyRuPig27g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZLSyVMkPfh3PftEWKC1kC+o1XLxo_o6i4BiyRuPig27g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 10:54:42AM +0100, Dmitry Vyukov wrote:
> On Thu, Feb 4, 2021 at 10:39 AM Peter Zijlstra <peterz@infradead.org> wrote:

> > OTOH, we're using ptrace permission checks, and ptrace() can inject
> > signals just fine. But it's a fairly big departure from what perf set
> > out to be.
> 
> Oh, I see, I did not think about this.
> 
> FWIW it's doable today by attaching a BPF program.

Sorta. For one, I can't operate BPF to save my life. Secondly, BPF has
some very dodgy recursion rules and it's trivial to loose BPF
invocations because another BPF is already running.

> Will it help if this mode is restricted to monitoring the current
> process? Sending signals indeed usually requires cooperation, so doing
> it for the current process looks like a reasonable restriction.
> This may be not a fundamental restriction, but rather "we don't have
> any use cases and are not sure about implications, so this is a
> precaution measure, may be relaxed in future".

Yeah, limiting it might help. I can trivially add attr::thread_only,
that requires attr::inherit and will limit it to CLONE_THREAD (find
below).

What do we do then? The advantage of IOC_REFRESH is that it disables the
event until it gets explicitly re-armed, avoiding recursion issues etc.
Do you want those semantics? If so, we'd need to have IOC_REFRESH find
the actual event for the current task, which should be doable I suppose.

And I need to dig into that fcntl() crud again, see if that's capable of
doing a SIGTRAP and if it's possible to target that to the task raising
it, instead of doing a process wide signal delivery.

Lemme rummage about a bit.

---
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -955,7 +955,7 @@ extern void __perf_event_task_sched_in(s
 				       struct task_struct *task);
 extern void __perf_event_task_sched_out(struct task_struct *prev,
 					struct task_struct *next);
-extern int perf_event_init_task(struct task_struct *child);
+extern int perf_event_init_task(struct task_struct *child, unsigned long clone_flags);
 extern void perf_event_exit_task(struct task_struct *child);
 extern void perf_event_free_task(struct task_struct *task);
 extern void perf_event_delayed_put(struct task_struct *task);
@@ -1446,7 +1446,8 @@ perf_event_task_sched_in(struct task_str
 static inline void
 perf_event_task_sched_out(struct task_struct *prev,
 			  struct task_struct *next)			{ }
-static inline int perf_event_init_task(struct task_struct *child)	{ return 0; }
+static inline int perf_event_init_task(struct task_struct *child,
+				       unsigned long clone_flags)	{ return 0; }
 static inline void perf_event_exit_task(struct task_struct *child)	{ }
 static inline void perf_event_free_task(struct task_struct *task)	{ }
 static inline void perf_event_delayed_put(struct task_struct *task)	{ }
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -388,7 +388,8 @@ struct perf_event_attr {
 				aux_output     :  1, /* generate AUX records instead of events */
 				cgroup         :  1, /* include cgroup events */
 				text_poke      :  1, /* include text poke events */
-				__reserved_1   : 30;
+				thread_only    :  1, /* only inherit on threads */
+				__reserved_1   : 29;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12776,12 +12776,13 @@ static int
 inherit_task_group(struct perf_event *event, struct task_struct *parent,
 		   struct perf_event_context *parent_ctx,
 		   struct task_struct *child, int ctxn,
-		   int *inherited_all)
+		   unsigned long clone_flags, int *inherited_all)
 {
 	int ret;
 	struct perf_event_context *child_ctx;
 
-	if (!event->attr.inherit) {
+	if (!event->attr.inherit ||
+	    (event->attr.thread_only && !(clone_flags & CLONE_THREAD))) {
 		*inherited_all = 0;
 		return 0;
 	}
@@ -12813,7 +12814,7 @@ inherit_task_group(struct perf_event *ev
 /*
  * Initialize the perf_event context in task_struct
  */
-static int perf_event_init_context(struct task_struct *child, int ctxn)
+static int perf_event_init_context(struct task_struct *child, int ctxn, unsigned long clone_flags)
 {
 	struct perf_event_context *child_ctx, *parent_ctx;
 	struct perf_event_context *cloned_ctx;
@@ -12853,7 +12854,8 @@ static int perf_event_init_context(struc
 	 */
 	perf_event_groups_for_each(event, &parent_ctx->pinned_groups) {
 		ret = inherit_task_group(event, parent, parent_ctx,
-					 child, ctxn, &inherited_all);
+					 child, ctxn, clone_flags,
+					 &inherited_all);
 		if (ret)
 			goto out_unlock;
 	}
@@ -12869,7 +12871,8 @@ static int perf_event_init_context(struc
 
 	perf_event_groups_for_each(event, &parent_ctx->flexible_groups) {
 		ret = inherit_task_group(event, parent, parent_ctx,
-					 child, ctxn, &inherited_all);
+					 child, ctxn, clone_flags,
+					 &inherited_all);
 		if (ret)
 			goto out_unlock;
 	}
@@ -12911,7 +12914,7 @@ static int perf_event_init_context(struc
 /*
  * Initialize the perf_event context in task_struct
  */
-int perf_event_init_task(struct task_struct *child)
+int perf_event_init_task(struct task_struct *child, unsigned long clone_flags)
 {
 	int ctxn, ret;
 
@@ -12920,7 +12923,7 @@ int perf_event_init_task(struct task_str
 	INIT_LIST_HEAD(&child->perf_event_list);
 
 	for_each_task_context_nr(ctxn) {
-		ret = perf_event_init_context(child, ctxn);
+		ret = perf_event_init_context(child, ctxn, clone_flags);
 		if (ret) {
 			perf_event_free_task(child);
 			return ret;
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2068,7 +2068,7 @@ static __latent_entropy struct task_stru
 	if (retval)
 		goto bad_fork_cleanup_policy;
 
-	retval = perf_event_init_task(p);
+	retval = perf_event_init_task(p, clone_flags);
 	if (retval)
 		goto bad_fork_cleanup_policy;
 	retval = audit_alloc(p);
