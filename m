Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF81350407
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 18:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbhCaQBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 12:01:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233575AbhCaQBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 12:01:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3CA461005;
        Wed, 31 Mar 2021 16:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617206465;
        bh=Y1PUtUxut+HYX61qxUjxGSXvzIr9fUeC4mcU3NsBWCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TCfaUUXK0H6YgPaK6M+5fKyAmizSCwfNg1EelzPQt5aUGgzWHl2/WxgWnIveCgO38
         mzTA63h/J65cnaJEq608tDWC3VR8AI5zHNRTHGnNI2PGdYmx0EvnfAkNsjn2EBS3j0
         IRqdRzsJpZarTK/zr88rj77r1ig7S/3NyPTf6WUnC16E8xdAkuEfOZbl0DjPZZV/Cp
         33oTQlGRcwq3g99m/Gzgt4TgEtnjoajUjHjRo6Ghg5wFfdn488sIS/wQftFY+SqCCj
         31CjnwCGZ1300JxdyB/sIIzJA+Q3m0ppGvnXf51+zXlbg8d9fsH8M5mOqxRKd0zsYl
         9KdQybDoxeQaQ==
Date:   Wed, 31 Mar 2021 17:00:59 +0100
From:   Will Deacon <will@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
        Zachary.Leaf@arm.com, Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 02/10] arm64: perf: Enable PMU counter direct access
 for perf event
Message-ID: <20210331160059.GD7815@willie-the-truck>
References: <20210311000837.3630499-1-robh@kernel.org>
 <20210311000837.3630499-3-robh@kernel.org>
 <20210330153125.GC6567@willie-the-truck>
 <CAL_JsqKN4=T4tHofEoBoWVEZSQEj_m=561_kEdEEkz5szHszhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKN4=T4tHofEoBoWVEZSQEj_m=561_kEdEEkz5szHszhQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 12:09:38PM -0500, Rob Herring wrote:
> On Tue, Mar 30, 2021 at 10:31 AM Will Deacon <will@kernel.org> wrote:
> >
> > On Wed, Mar 10, 2021 at 05:08:29PM -0700, Rob Herring wrote:
> > > From: Raphael Gault <raphael.gault@arm.com>
> > >
> > > Keep track of event opened with direct access to the hardware counters
> > > and modify permissions while they are open.
> > >
> > > The strategy used here is the same which x86 uses: every time an event
> > > is mapped, the permissions are set if required. The atomic field added
> > > in the mm_context helps keep track of the different event opened and
> > > de-activate the permissions when all are unmapped.
> > > We also need to update the permissions in the context switch code so
> > > that tasks keep the right permissions.
> > >
> > > In order to enable 64-bit counters for userspace when available, a new
> > > config1 bit is added for userspace to indicate it wants userspace counter
> > > access. This bit allows the kernel to decide if chaining should be
> > > disabled and chaining and userspace access are incompatible.
> > > The modes for config1 are as follows:
> > >
> > > config1 = 0 or 2 : user access enabled and always 32-bit
> > > config1 = 1 : user access disabled and always 64-bit (using chaining if needed)
> > > config1 = 3 : user access enabled and counter size matches underlying counter.
> >
> > In this last case, how does userspace know whether it got a 32-bit or a
> > 64-bit counter?
> 
> pmc_width in the user page. If the read loop is correct, then it
> doesn't matter to the user.

Gotcha; please mention that in this comment,

> > > +static void refresh_pmuserenr(void *mm)
> > > +{
> > > +     if (mm == current->active_mm)
> > > +             perf_switch_user_access(mm);
> > > +}
> > > +
> > > +static void armv8pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
> > > +{
> > > +     struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
> > > +
> > > +     if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR))
> > > +             return;
> > > +
> > > +     /*
> > > +      * This function relies on not being called concurrently in two
> > > +      * tasks in the same mm.  Otherwise one task could observe
> > > +      * pmu_direct_access > 1 and return all the way back to
> > > +      * userspace with user access disabled while another task is still
> > > +      * doing on_each_cpu_mask() to enable user access.
> > > +      *
> > > +      * For now, this can't happen because all callers hold mmap_lock
> > > +      * for write.  If this changes, we'll need a different solution.
> > > +      */
> > > +     lockdep_assert_held_write(&mm->mmap_lock);
> > > +
> > > +     if (atomic_inc_return(&mm->context.pmu_direct_access) == 1)
> > > +             on_each_cpu_mask(&armpmu->supported_cpus, refresh_pmuserenr, mm, 1);
> > > +}
> >
> > Why do we need to cross-call here? Seems like it would be a tonne simpler to
> > handle the trap. Is there a reason not to do that?
> 
> Alignment with x86? You didn't like the trap handler either:
> 
> > Hmm... this feels pretty fragile since, although we may expect userspace only
> > to trigger this in the context of the specific perf use-case, we don't have
> > a way to detect that, so the ABI we're exposing is that EL0 accesses to
> > non-existent counters will return 0. I don't really think that's something
> > we want to commit to.
> 
> Full mail: https://lore.kernel.org/r/20200928182601.GA11974@willie-the-truck
> 
> The handler would be different, but we'd still have the problem of not
> being able to detect the use case, right?

Well hang on, the thing you link to was about _emulating_ the access. I'm
not saying we should do that, but rather just enable EL0 PMU access lazily
instead of using the IPI. We're going to enable it when we context-switch
anyway.

The alternative is enabling EL0 access unconditionally and leaving it
enabled.

> > > +
> > > +static void armv8pmu_event_unmapped(struct perf_event *event, struct mm_struct *mm)
> > > +{
> > > +     struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
> > > +
> > > +     if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR))
> > > +             return;
> > > +
> > > +     if (atomic_dec_and_test(&mm->context.pmu_direct_access))
> > > +             on_each_cpu_mask(&armpmu->supported_cpus, refresh_pmuserenr, mm, 1);
> >
> > Given that the pmu_direct_access field is global per-mm, won't this go
> > wrong if multiple PMUs are opened by the same process but only a subset
> > are exposed to EL0? Perhaps pmu_direct_access should be treated as a mask
> > rather than a counter, so that we can 'and' it with the supported_cpus for
> > the PMU we're dealing with.
> 
> It needs to be a count to support multiple events on the same PMU. If
> the event is not enabled for EL0, then we'd exit out on the
> ARMPMU_EL0_RD_CNTR check. So I think we're fine.

I'm still not convinced; pmu_direct_access is shared between PMUs, so
testing the result of atomic_dec_and_test() just doesn't make sense to
me, as another PMU could be playing with the count.

> > > @@ -980,9 +1032,23 @@ static int __armv8_pmuv3_map_event(struct perf_event *event,
> > >                                      &armv8_pmuv3_perf_cache_map,
> > >                                      ARMV8_PMU_EVTYPE_EVENT);
> > >
> > > -     if (armv8pmu_event_is_64bit(event))
> > > +     if (armv8pmu_event_want_user_access(event) || !armv8pmu_event_is_64bit(event)) {
> > > +             event->hw.flags |= ARMPMU_EL0_RD_CNTR;
> >
> > Why do you set this for all 32-bit events?
> 
> It goes back to the config1 bits as explained in the commit msg. We
> can always support user access for 32-bit counters, but for 64-bit
> counters the user has to request both user access and 64-bit counters.
> We could require explicit user access request for 32-bit access, but I
> thought it was better to not require userspace to do something Arm
> specific on open.

Got it, thanks.

Will
