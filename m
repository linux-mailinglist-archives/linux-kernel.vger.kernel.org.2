Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6073978D6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 19:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbhFARNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 13:13:51 -0400
Received: from foss.arm.com ([217.140.110.172]:54672 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231918AbhFARNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 13:13:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8AEF6D;
        Tue,  1 Jun 2021 10:12:06 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.0.106])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEA963F719;
        Tue,  1 Jun 2021 10:12:02 -0700 (PDT)
Date:   Tue, 1 Jun 2021 18:11:59 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
        Zachary.Leaf@arm.com, Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 3/5] arm64: perf: Enable PMU counter userspace access
 for perf event
Message-ID: <20210601171159.GD3326@C02TD0UTHF1T.local>
References: <20210517195405.3079458-1-robh@kernel.org>
 <20210517195405.3079458-4-robh@kernel.org>
 <20210601135526.GA3326@C02TD0UTHF1T.local>
 <CAL_JsqKo2cQsWkG67HUDgyO=WXywzykM+UY4uOwdpA6FVZsc0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKo2cQsWkG67HUDgyO=WXywzykM+UY4uOwdpA6FVZsc0A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 10:00:53AM -0500, Rob Herring wrote:
> On Tue, Jun 1, 2021 at 8:55 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > On Mon, May 17, 2021 at 02:54:03PM -0500, Rob Herring wrote:
> > > +static void armv8pmu_enable_user_access(struct arm_pmu *cpu_pmu)
> > > +{
> > > +     struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
> > > +
> > > +     if (!bitmap_empty(cpuc->dirty_mask, ARMPMU_MAX_HWEVENTS)) {
> > > +             int i;
> > > +             /* Don't need to clear assigned counters. */
> > > +             bitmap_xor(cpuc->dirty_mask, cpuc->dirty_mask, cpuc->used_mask, ARMPMU_MAX_HWEVENTS);
> > > +
> > > +             for_each_set_bit(i, cpuc->dirty_mask, ARMPMU_MAX_HWEVENTS) {
> > > +                     if (i == ARMV8_IDX_CYCLE_COUNTER)
> > > +                             write_sysreg(0, pmccntr_el0);
> > > +                     else
> > > +                             armv8pmu_write_evcntr(i, 0);
> > > +             }
> > > +             bitmap_zero(cpuc->dirty_mask, ARMPMU_MAX_HWEVENTS);
> > > +     }
> > > +
> > > +     write_sysreg(ARMV8_PMU_USERENR_ER | ARMV8_PMU_USERENR_CR, pmuserenr_el0);
> > > +}
> >
> > This still leaks the values of CPU-bound events, or task-bound events
> > owned by others, right?
> 
> For CPU-bound events, yes. There's not any way to prevent that without
> per counter access controls.
> 
> It is clearing other's task-bound events.

Sorry, I misspoke. When I said "task-bound events owned by others", I
had meant events bounds to this task, but owned by someone else (e.g.
the system administrator).

Thanks for confirming!

> > > +static void armv8pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
> > > +{
> > > +     if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR) || (atomic_read(&event->mmap_count) != 1))
> > > +             return;
> > > +
> > > +     if (atomic_inc_return(&event->ctx->nr_user) == 1) {
> > > +             unsigned long flags;
> > > +             atomic_inc(&event->pmu->sched_cb_usage);
> > > +             local_irq_save(flags);
> > > +             armv8pmu_enable_user_access(to_arm_pmu(event->pmu));
> > > +             local_irq_restore(flags);
> > > +     }
> > > +}
> > > +
> > > +static void armv8pmu_event_unmapped(struct perf_event *event, struct mm_struct *mm)
> > > +{
> > > +     if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR) || (atomic_read(&event->mmap_count) != 1))
> > > +             return;
> > > +
> > > +     if (atomic_dec_and_test(&event->ctx->nr_user)) {
> > > +             atomic_dec(&event->pmu->sched_cb_usage);
> > > +             armv8pmu_disable_user_access();
> > > +     }
> > >  }
> >
> > We can open an event for task A, but call mmap()/munmap() for that event
> > from task B, which will do the enable/disable on task B rather than task
> > A. The core doesn't enforce that the mmap is performed on the same core,
> > so I don't think this is quite right, unfortunately.
> 
> Why do we care and who wants to do that? It all seems like a
> convoluted scenario that isn't really going to happen. I prefer to not
> support that until someone asks for it. Maybe we should check for the
> condition (event->ctx->task != current) though.

My reason for caring is that it means our accounting structures aren't
aligned with the actual CPU state, and it's going to be very easy for
this to go wrong as things get reworked in future.

If we're saying someone shouldn't do this, then we should enforce that
they can't. If they can, then I'd prefer to have deterministic behaviour
that isn't going to cause us issues in future.

I think that we should treat this like changing other event properties
(e.g. the period, or enabling/disabling the event), with an
event_function_call, since that will do the right thing regardless. I
also expect that people will want to do setup/teardown in a single
thread, and this would make that work too.

I reckon we can get the core logic for that in kernel/events/core.c.

> > I reckon we need to do something with task_function_call() to make this
> > happen in the context of the expected task.
> 
> Following the x86 way using the mm_context and IPI handled that case,
> but Will didn't like either part of that implementation. His
> suggestion then was to enable access in an undef instr handler rather
> than an IPI. I think that would still work with this version.

IIUC the main objection there was that we'd have to signal all tasks
associated with the mm or all CPUs, neither of which were attractive.

Now that we're saying this is strictly task-bound, I think this is
similar to enabling/disabling an event or changing its period, for which
we already do a (single) event_function_call() to ensure the CPU state
change happens on the correct CPU.

Thanks,
Mark.
