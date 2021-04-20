Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2253655AB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 11:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhDTJrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 05:47:14 -0400
Received: from foss.arm.com ([217.140.110.172]:59782 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229937AbhDTJrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 05:47:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 698B31474;
        Tue, 20 Apr 2021 02:46:40 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 863CA3F85F;
        Tue, 20 Apr 2021 02:46:38 -0700 (PDT)
Date:   Tue, 20 Apr 2021 10:46:33 +0100
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        mingo@kernel.org, bigeasy@linutronix.de, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, qais.yousef@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] sched: Use cpu_dying() to fix balance_push vs
 hotplug-rollback
Message-ID: <20210420094632.GA165360@e120877-lin.cambridge.arm.com>
References: <20210310145258.899619710@infradead.org>
 <20210310150109.259726371@infradead.org>
 <871rclu3jz.mognet@e113632-lin.i-did-not-set--mail-host-address--so-tickle-me>
 <YHQ3Iy7QfL+0UoM0@hirez.programming.kicks-ass.net>
 <87r1jfmn8d.mognet@arm.com>
 <YHU/a9HvGLYpOLKZ@hirez.programming.kicks-ass.net>
 <YHgAYef83VQhKdC2@hirez.programming.kicks-ass.net>
 <87a6pzmxec.mognet@arm.com>
 <20210419105541.GA40111@e120877-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419105541.GA40111@e120877-lin.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 11:56:30AM +0100, Vincent Donnefort wrote:
> On Thu, Apr 15, 2021 at 03:32:11PM +0100, Valentin Schneider wrote:
> > On 15/04/21 10:59, Peter Zijlstra wrote:
> > > Can't make sense of what I did.. I've removed that hunk. Patch now looks
> > > like this.
> > >
> > 
> > Small nit below, but regardless feel free to apply to the whole lot:
> > Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> > 
> > @VincentD, ISTR you had tested the initial version of this with your fancy
> > shmancy hotplug rollback stresser. Feel like doing this
> 
> I indeed wrote a test to verify all the rollback cases, up and down.
> 
> It seems I encounter an intermitent issue while running several iterations of
> that test ... but I need more time to debug and figure-out where it is blocking.

Found the issue:

$ cat hotplug/states:
219: sched:active
220: online

CPU0: 

$ echo 219 > hotplug/fail
$ echo 0 > online

=> cpu_active = 1 cpu_dying = 1

which means that later on, for another CPU hotunplug, in
__balance_push_cpu_stop(), the fallback rq for a kthread can select that
CPU0, but __migrate_task() would fail and we end-up in an infinite loop,
trying to migrate that task to CPU0.

The problem is that for a failure in sched:active, as "online" has no callback,
there will be no call to cpuhp_invoke_callback(). Hence, the cpu_dying bit would
not be reset.

Maybe cpuhp_reset_state() and cpuhp_set_state() would then be a better place to
switch the dying bit?

> 
> > 
> > > So instead, make sure balance_push is enabled between
> > > sched_cpu_deactivate() and sched_cpu_activate() (eg. when
> > > !cpu_active()), and gate it's utility with cpu_dying().
> > 
> > I'd word that "is enabled below sched_cpu_activate()", since
> > sched_cpu_deactivate() is now out of the picture.
> > 
> > [...]
> > > @@ -7639,6 +7639,9 @@ static DEFINE_PER_CPU(struct cpu_stop_wo
> > >
> > >  /*
> > >   * Ensure we only run per-cpu kthreads once the CPU goes !active.
> > > + *
> > > + * This is active/set between sched_cpu_deactivate() / sched_cpu_activate().
> > 
> > Ditto
> > 
> > > + * But only effective when the hotplug motion is down.
> > >   */
> > >  static void balance_push(struct rq *rq)
> > >  {
