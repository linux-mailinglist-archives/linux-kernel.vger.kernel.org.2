Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7240A4508F0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 16:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbhKOPzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 10:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236544AbhKOPyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 10:54:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CB1C061570
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 07:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KCHZcCUhtOeR0rpMLf7bvztX/TX9jQWYkmpLIqM8pJY=; b=NBEw5y1hgQ4lqT6u06ePXBQ4lM
        rF/mP22Q9ApC8sxUrLdOccIRvypcvssiw/4/UXN/U5fvmU9RSOCnzIs8rbVMx1pH4JYwMbb96NMkb
        7tzpszrm0T7pja/k/30x69mZExM3ZrpzvCy5vZ1f6HrcyP8vme9X15eYmgCBdFq4i7TyPDKoy7DIO
        uPHDAZYE3uM+EoIu7rLkmetv3PNXsplvZIXlJWUE/jOHLl+53L1bo/9x8J2czc2FXKkKc5sW30tbk
        SnwxAEWh3deXRvZASSuAboTFtf9cJ5UheLXoDfoCslzM8pRfQF0p/1hzHxOURNC4X0TYV8eSNxZ/W
        2myHpsRA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmeGc-005oZ7-RA; Mon, 15 Nov 2021 15:51:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 41878300347;
        Mon, 15 Nov 2021 16:51:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2CF2B2CB0A9D3; Mon, 15 Nov 2021 16:51:34 +0100 (CET)
Date:   Mon, 15 Nov 2021 16:51:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] timers/urgent for v5.16-rc1
Message-ID: <YZKCBqmb1gfKvFcR@hirez.programming.kicks-ass.net>
References: <163689642456.3249160.13397023971040961440.tglx@xen13>
 <163689642744.3249160.6971106813056927807.tglx@xen13>
 <CAHk-=wjQxHwdC61ore062Hc5PAF2o6CJnDG_NsQe+e599RovJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjQxHwdC61ore062Hc5PAF2o6CJnDG_NsQe+e599RovJw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2021 at 11:02:31AM -0800, Linus Torvalds wrote:
> On Sun, Nov 14, 2021 at 5:31 AM Thomas Gleixner <tglx@linutronix.de> wrote:

> But apparently it matters for posix_cputimers_work and for numa_work,
> and so I think it's very illogical that init_task_work() will not
> actually initialize it properly.

The problem with the posix timers thing seems to be that it can race
against fork() but afaict it can't actually mis-behave if it has garbage
in ->next, so the clearing here is pure paranoia.

> And that task_tick_numa() special case is truly horrendous, and really
> should go after the init_task_work() regardless, exactly because you'd
> expect that init_task_work() to initialize the work even if it doesn't
> happen to right now.

Yeah, it's a wee bit 'special' allright :-)

> Or is somebody doing init_task_work() to only change the work-function
> on an already initialized work entry? Becuase that sounds both racy
> and broken to me, and none of the things I looked at from a quick grep
> looked like that at all.

The worst I found is someone sharing an rcu_head between task_work and
call_rcu (supposedly at different stages in the life-time).

I couldn't find any other weird cases.

---
 include/linux/task_work.h      | 1 +
 kernel/sched/fair.c            | 4 ++--
 kernel/time/posix-cpu-timers.c | 2 --
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/task_work.h b/include/linux/task_work.h
index 5b8a93f288bb..fbbc9aa8e4ae 100644
--- a/include/linux/task_work.h
+++ b/include/linux/task_work.h
@@ -10,6 +10,7 @@ typedef void (*task_work_func_t)(struct callback_head *);
 static inline void
 init_task_work(struct callback_head *twork, task_work_func_t func)
 {
+	twork->next = NULL;
 	twork->func = func;
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6e476f6d9435..d03dacdecf73 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2823,14 +2823,14 @@ void init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 	p->node_stamp			= 0;
 	p->numa_scan_seq		= mm ? mm->numa_scan_seq : 0;
 	p->numa_scan_period		= sysctl_numa_balancing_scan_delay;
-	/* Protect against double add, see task_tick_numa and task_numa_work */
-	p->numa_work.next		= &p->numa_work;
 	p->numa_faults			= NULL;
 	RCU_INIT_POINTER(p->numa_group, NULL);
 	p->last_task_numa_placement	= 0;
 	p->last_sum_exec_runtime	= 0;
 
 	init_task_work(&p->numa_work, task_numa_work);
+	/* Protect against double add, see task_tick_numa and task_numa_work */
+	p->numa_work.next		= &p->numa_work;
 
 	/* New address space, reset the preferred nid */
 	if (!(clone_flags & CLONE_VM)) {
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 96b4e7810426..3352759e6916 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1167,8 +1167,6 @@ void clear_posix_cputimers_work(struct task_struct *p)
 	 * A copied work entry from the old task is not meaningful, clear it.
 	 * N.B. init_task_work will not do this.
 	 */
-	memset(&p->posix_cputimers_work.work, 0,
-	       sizeof(p->posix_cputimers_work.work));
 	init_task_work(&p->posix_cputimers_work.work,
 		       posix_cpu_timers_work);
 	p->posix_cputimers_work.scheduled = false;
