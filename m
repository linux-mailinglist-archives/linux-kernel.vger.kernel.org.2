Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D033D1315
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 17:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240158AbhGUPS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 11:18:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239935AbhGUPS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 11:18:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9CB061248
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 15:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626883174;
        bh=PTYTJUJrCpSiQ13Lt0nAMnVlyn4OaLJMQMzY4poiy7U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ctgd4JVMEU0sG/oGdB9J6dfrwkEcyfeJIhH3Uf0MpS8lMIWplRFBrTh8r26zKDoyB
         9Vhs2+KMuFq6rAel38RF2hVIeiW2ZLDv5HJbivzWkTd5y/+qaH02fQKgaEn/dyK8TM
         fSelEzdgM+AOQoxUGWmnTsYq7E3oRoUe2qy/gtRrFfQPHoUK2z0+8E42WRTlQ0p/KG
         NGGRNJM0lxCyXHbO/am+FcAm/8Qbgns+imlFFEdEQ5FdGo2hqUZZsW0USHZHNT4B/7
         1JK90SEvdUWTHrh3+jozj1gYoTR977iGHeJ4dzf5qi1Kih+xefHp/JbQbXehrFz0fN
         rIj3a1/CZRoMA==
Received: by mail-ej1-f45.google.com with SMTP id nd37so4015135ejc.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 08:59:34 -0700 (PDT)
X-Gm-Message-State: AOAM5325+nxdvmEzCiFEJG1757/8sZijBOBxuSBPQZcssKGxQEFTuB1s
        w8yXp8X7JeNXXIgB14w/RR4v0wJugXkHi07aQA==
X-Google-Smtp-Source: ABdhPJw8v9TIrA601fUlZPPi0To84gOM5S5f2chhwDiqevHwX4z0kNVhgBekIPXOfUBuCRN2PKXhUzfJvkJbkGXX22E=
X-Received: by 2002:a17:906:b18d:: with SMTP id w13mr39641126ejy.341.1626883173403;
 Wed, 21 Jul 2021 08:59:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210517195405.3079458-1-robh@kernel.org> <20210517195405.3079458-4-robh@kernel.org>
 <20210601135526.GA3326@C02TD0UTHF1T.local> <CAL_JsqKo2cQsWkG67HUDgyO=WXywzykM+UY4uOwdpA6FVZsc0A@mail.gmail.com>
 <20210601171159.GD3326@C02TD0UTHF1T.local>
In-Reply-To: <20210601171159.GD3326@C02TD0UTHF1T.local>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 21 Jul 2021 09:59:21 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJeCfF+bx=f_uF0i_RGBbeKvxd0Szrx=DpkWvgcgkTQQg@mail.gmail.com>
Message-ID: <CAL_JsqJeCfF+bx=f_uF0i_RGBbeKvxd0Szrx=DpkWvgcgkTQQg@mail.gmail.com>
Subject: Re: [PATCH v8 3/5] arm64: perf: Enable PMU counter userspace access
 for perf event
To:     Mark Rutland <mark.rutland@arm.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 1, 2021 at 11:12 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Jun 01, 2021 at 10:00:53AM -0500, Rob Herring wrote:
> > On Tue, Jun 1, 2021 at 8:55 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > > On Mon, May 17, 2021 at 02:54:03PM -0500, Rob Herring wrote:
> > > > +static void armv8pmu_enable_user_access(struct arm_pmu *cpu_pmu)
> > > > +{
> > > > +     struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
> > > > +
> > > > +     if (!bitmap_empty(cpuc->dirty_mask, ARMPMU_MAX_HWEVENTS)) {
> > > > +             int i;
> > > > +             /* Don't need to clear assigned counters. */
> > > > +             bitmap_xor(cpuc->dirty_mask, cpuc->dirty_mask, cpuc->used_mask, ARMPMU_MAX_HWEVENTS);
> > > > +
> > > > +             for_each_set_bit(i, cpuc->dirty_mask, ARMPMU_MAX_HWEVENTS) {
> > > > +                     if (i == ARMV8_IDX_CYCLE_COUNTER)
> > > > +                             write_sysreg(0, pmccntr_el0);
> > > > +                     else
> > > > +                             armv8pmu_write_evcntr(i, 0);
> > > > +             }
> > > > +             bitmap_zero(cpuc->dirty_mask, ARMPMU_MAX_HWEVENTS);
> > > > +     }
> > > > +
> > > > +     write_sysreg(ARMV8_PMU_USERENR_ER | ARMV8_PMU_USERENR_CR, pmuserenr_el0);
> > > > +}
> > >
> > > This still leaks the values of CPU-bound events, or task-bound events
> > > owned by others, right?
> >
> > For CPU-bound events, yes. There's not any way to prevent that without
> > per counter access controls.
> >
> > It is clearing other's task-bound events.
>
> Sorry, I misspoke. When I said "task-bound events owned by others", I
> had meant events bounds to this task, but owned by someone else (e.g.
> the system administrator).
>
> Thanks for confirming!
>
> > > > +static void armv8pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
> > > > +{
> > > > +     if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR) || (atomic_read(&event->mmap_count) != 1))
> > > > +             return;
> > > > +
> > > > +     if (atomic_inc_return(&event->ctx->nr_user) == 1) {
> > > > +             unsigned long flags;
> > > > +             atomic_inc(&event->pmu->sched_cb_usage);
> > > > +             local_irq_save(flags);
> > > > +             armv8pmu_enable_user_access(to_arm_pmu(event->pmu));
> > > > +             local_irq_restore(flags);
> > > > +     }
> > > > +}
> > > > +
> > > > +static void armv8pmu_event_unmapped(struct perf_event *event, struct mm_struct *mm)
> > > > +{
> > > > +     if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR) || (atomic_read(&event->mmap_count) != 1))
> > > > +             return;
> > > > +
> > > > +     if (atomic_dec_and_test(&event->ctx->nr_user)) {
> > > > +             atomic_dec(&event->pmu->sched_cb_usage);
> > > > +             armv8pmu_disable_user_access();
> > > > +     }
> > > >  }
> > >
> > > We can open an event for task A, but call mmap()/munmap() for that event
> > > from task B, which will do the enable/disable on task B rather than task
> > > A. The core doesn't enforce that the mmap is performed on the same core,
> > > so I don't think this is quite right, unfortunately.
> >
> > Why do we care and who wants to do that? It all seems like a
> > convoluted scenario that isn't really going to happen. I prefer to not
> > support that until someone asks for it. Maybe we should check for the
> > condition (event->ctx->task != current) though.
>
> My reason for caring is that it means our accounting structures aren't
> aligned with the actual CPU state, and it's going to be very easy for
> this to go wrong as things get reworked in future.
>
> If we're saying someone shouldn't do this, then we should enforce that
> they can't. If they can, then I'd prefer to have deterministic behaviour
> that isn't going to cause us issues in future.
>
> I think that we should treat this like changing other event properties
> (e.g. the period, or enabling/disabling the event), with an
> event_function_call, since that will do the right thing regardless. I
> also expect that people will want to do setup/teardown in a single
> thread, and this would make that work too.

The big difference here is we're dealing with task context state, not
just event state.

> I reckon we can get the core logic for that in kernel/events/core.c.

I assume you don't mean copy it out of there, but add it there. So
we'd need an event_function_call on mmap/munmap and a new PMU callback
as the PMU mmap callbacks are defined to be in context of the mmap,
not the task context. And then we'd need to not do that on x86.

Or we could change the definition of event_mapped/event_unmapped to be
called on every active context. After all, that is what x86 needs in
the end. Though I'm sure I don't know all the implications of such a
change.

> > > I reckon we need to do something with task_function_call() to make this
> > > happen in the context of the expected task.
> >
> > Following the x86 way using the mm_context and IPI handled that case,
> > but Will didn't like either part of that implementation. His
> > suggestion then was to enable access in an undef instr handler rather
> > than an IPI. I think that would still work with this version.
>
> IIUC the main objection there was that we'd have to signal all tasks
> associated with the mm or all CPUs, neither of which were attractive.

Yes, and the undef handler avoided that.

If we go back to utilizing the undef handler, I think we could make
things a bit more secure where the counter data is not exposed when
the user event is not scheduled.
This would enable or disable user access when a user event is
scheduled on the PMU or not. The undef handler will then return 0 on
counter reads if the context has any user event or abort otherwise.
The check of the context events will need to walk the event list which
I think? should be safe to do from the undef handler.

Rob
