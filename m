Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A39345065F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 15:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbhKOONl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 09:13:41 -0500
Received: from foss.arm.com ([217.140.110.172]:55770 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232060AbhKOOM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 09:12:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AE136D;
        Mon, 15 Nov 2021 06:09:31 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.26.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD2813F766;
        Mon, 15 Nov 2021 06:09:29 -0800 (PST)
Date:   Mon, 15 Nov 2021 14:09:27 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, dvyukov@google.com, peterz@infradead.org,
        quic_qiancai@quicinc.com, will@kernel.org, woodylin@google.com
Subject: Re: [PATCH] Reset task stack state in bringup_cpu()
Message-ID: <YZJqF83s8LrV7Zei@FVFF77S0Q05N.cambridge.arm.com>
References: <20211115113310.35693-1-mark.rutland@arm.com>
 <87pmr1r4vl.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmr1r4vl.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 12:16:14PM +0000, Valentin Schneider wrote:
> 
> Hi Mark,
> 
> Thanks for tackling this and glueing the pieces back together. LGTM, though
> I couldn't stop myself from playing changelog police - I also have a
> question/comment wrt the BP.

I'll go fix the various typos for v2; replies to the more substantial comments
below.

> On 15/11/21 11:33, Mark Rutland wrote:
> > To hot unplug a CPU, the idle task on that CPU calls a few layers of C
> > code before finally leaving the kernel. When KASAN is in use, poisoned
> > shadow is left around for each of the active stack frames, and when
> > shadow call stacks are in use. When shadow call stacks are in use the
> > task's SCS SP is left pointing at an arbitrary point within the task's
> > shadow call stack.

> > Fix both of these consistently and more robustly by resetting the SCS SP
> > and KASAN shadow immediately before we online a CPU.

> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

Thanks!

> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 3c9b0fda64ac..76f9deeaa942 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -8619,9 +8619,6 @@ void __init init_idle(struct task_struct *idle, int cpu)
> >       idle->flags |= PF_IDLE | PF_KTHREAD | PF_NO_SETAFFINITY;
> >       kthread_set_per_cpu(idle, cpu);
> >
> > -	scs_task_reset(idle);
> > -	kasan_unpoison_task_stack(idle);
> > -
> 
> So those are no longer invoked for the BP during bootup (via sched_init());
> that looks OK for KASAN per:
> 
>   e1b77c92981a ("sched/kasan: remove stale KASAN poison after hotplug")
> 
> I didn't find any explicit commit for SCS but from the looks of
> arm64/include/asm/thread_info.h we seem to be initializing things
> correctly, so IIUC the removed hunk wasn't actually necessary for the BP's
> first boot.

Correct. For the init task:

* The KASAN shadow starts out empty, and there's no poison to remove.

* The saved SCS SP is initialized statically as part of INIT_THREAD_INFO(), via
  INIT_SCS().

... so that requires no special care.

For every task created thereafter (including idle threads):

* dup_task_struct() allocates the new task's stack via
  alloc_thread_stack_node(), which either explicitly removes KASAN poison from
  the shadow of a cached stack, or acquires a stack via __vmalloc_node_range(),
  whose shadow starts out empty.

* dup_task_struct() calls scs_prepare() which allocates the task's shadow stack
  and initializes the SCS SP for the task.

The idle threads get created via fork_idle(), which calls copy_process() (and
therefore dup_task_struct) to allocate the idle thread, then calls init_idle()
on the result.

Thanks
Mark.

