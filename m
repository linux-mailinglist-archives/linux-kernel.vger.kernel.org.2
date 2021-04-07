Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3A9356C72
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352309AbhDGMo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:44:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347386AbhDGMo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:44:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ECD8F6135D;
        Wed,  7 Apr 2021 12:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617799483;
        bh=HirBxDsAOnDqrZ/wXdwt0FSJOu/e4Ct3VMBIUL1uf+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KFR71w7+TDwY39dtJIyz166vbOy9ZWlIEM7i8oNTy5LCsBrUffuphvjqhz2sBGjiL
         wtt9ncT3p83JCZbCNLTjLZLIk+RFIn5NSEq/QuFrCOSV3/YvSqMEAQS+F3ag8BK6Go
         37ogK917sVaoCVgMtEcWGbjmLgFzUH5Fm1ftUQPxXKDmXumNFftn1M0tbQU7AauIZu
         +tx/QuzC/N4ZjDNg5xmJtaLsh2TXQ09i7pvWlMk7xnV09eG+X9vX4EDDZoUQOBhFSA
         G5YkC06pnookgJ7RZQcLvA+jc2zA3SSp9u+zMVJU/n2sc2xBemfSeBvk7IKbYGYQ59
         50YP42y4NmhRw==
Date:   Wed, 7 Apr 2021 13:44:37 +0100
From:   Will Deacon <will@kernel.org>
To:     Rob Herring <robh@kernel.org>, mark.rutland@arm.com
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
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
Message-ID: <20210407124437.GA15622@willie-the-truck>
References: <20210311000837.3630499-1-robh@kernel.org>
 <20210311000837.3630499-3-robh@kernel.org>
 <20210330153125.GC6567@willie-the-truck>
 <CAL_JsqKN4=T4tHofEoBoWVEZSQEj_m=561_kEdEEkz5szHszhQ@mail.gmail.com>
 <20210331160059.GD7815@willie-the-truck>
 <CAL_Jsq+ga_-5=UBTAn4eGhpL6j2aWFVh9CdxR4XSG7WpYfxNsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+ga_-5=UBTAn4eGhpL6j2aWFVh9CdxR4XSG7WpYfxNsA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Moving Mark to To: since I'd like his view on this]

On Thu, Apr 01, 2021 at 02:45:21PM -0500, Rob Herring wrote:
> On Wed, Mar 31, 2021 at 11:01 AM Will Deacon <will@kernel.org> wrote:
> >
> > On Tue, Mar 30, 2021 at 12:09:38PM -0500, Rob Herring wrote:
> > > On Tue, Mar 30, 2021 at 10:31 AM Will Deacon <will@kernel.org> wrote:
> > > >
> > > > On Wed, Mar 10, 2021 at 05:08:29PM -0700, Rob Herring wrote:
> > > > > From: Raphael Gault <raphael.gault@arm.com>
> > > > >
> > > > > Keep track of event opened with direct access to the hardware counters
> > > > > and modify permissions while they are open.
> > > > >
> > > > > The strategy used here is the same which x86 uses: every time an event
> > > > > is mapped, the permissions are set if required. The atomic field added
> > > > > in the mm_context helps keep track of the different event opened and
> > > > > de-activate the permissions when all are unmapped.
> > > > > We also need to update the permissions in the context switch code so
> > > > > that tasks keep the right permissions.
> > > > >
> > > > > In order to enable 64-bit counters for userspace when available, a new
> > > > > config1 bit is added for userspace to indicate it wants userspace counter
> > > > > access. This bit allows the kernel to decide if chaining should be
> > > > > disabled and chaining and userspace access are incompatible.
> > > > > The modes for config1 are as follows:
> > > > >
> > > > > config1 = 0 or 2 : user access enabled and always 32-bit
> > > > > config1 = 1 : user access disabled and always 64-bit (using chaining if needed)
> > > > > config1 = 3 : user access enabled and counter size matches underlying counter.
> > > >
> > > > In this last case, how does userspace know whether it got a 32-bit or a
> > > > 64-bit counter?
> > >
> > > pmc_width in the user page. If the read loop is correct, then it
> > > doesn't matter to the user.
> >
> > Gotcha; please mention that in this comment,
> >
> > > > > +static void refresh_pmuserenr(void *mm)
> > > > > +{
> > > > > +     if (mm == current->active_mm)
> > > > > +             perf_switch_user_access(mm);
> > > > > +}
> > > > > +
> > > > > +static void armv8pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
> > > > > +{
> > > > > +     struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
> > > > > +
> > > > > +     if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR))
> > > > > +             return;
> > > > > +
> > > > > +     /*
> > > > > +      * This function relies on not being called concurrently in two
> > > > > +      * tasks in the same mm.  Otherwise one task could observe
> > > > > +      * pmu_direct_access > 1 and return all the way back to
> > > > > +      * userspace with user access disabled while another task is still
> > > > > +      * doing on_each_cpu_mask() to enable user access.
> > > > > +      *
> > > > > +      * For now, this can't happen because all callers hold mmap_lock
> > > > > +      * for write.  If this changes, we'll need a different solution.
> > > > > +      */
> > > > > +     lockdep_assert_held_write(&mm->mmap_lock);
> > > > > +
> > > > > +     if (atomic_inc_return(&mm->context.pmu_direct_access) == 1)
> > > > > +             on_each_cpu_mask(&armpmu->supported_cpus, refresh_pmuserenr, mm, 1);
> > > > > +}
> > > >
> > > > Why do we need to cross-call here? Seems like it would be a tonne simpler to
> > > > handle the trap. Is there a reason not to do that?
> > >
> > > Alignment with x86? You didn't like the trap handler either:
> > >
> > > > Hmm... this feels pretty fragile since, although we may expect userspace only
> > > > to trigger this in the context of the specific perf use-case, we don't have
> > > > a way to detect that, so the ABI we're exposing is that EL0 accesses to
> > > > non-existent counters will return 0. I don't really think that's something
> > > > we want to commit to.
> > >
> > > Full mail: https://lore.kernel.org/r/20200928182601.GA11974@willie-the-truck
> > >
> > > The handler would be different, but we'd still have the problem of not
> > > being able to detect the use case, right?
> >
> > Well hang on, the thing you link to was about _emulating_ the access. I'm
> > not saying we should do that, but rather just enable EL0 PMU access lazily
> > instead of using the IPI. We're going to enable it when we context-switch
> > anyway.
> >
> > The alternative is enabling EL0 access unconditionally and leaving it
> > enabled.
> 
> That BTW is what x86 originally did. This pmu_direct_access stuff came
> about as part of locking down access a bit.
> 
> In any case, I've modified this to trap. It avoids the mmap lock
> dependency too, so that's nice.
> 
> > > > > +
> > > > > +static void armv8pmu_event_unmapped(struct perf_event *event, struct mm_struct *mm)
> > > > > +{
> > > > > +     struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
> > > > > +
> > > > > +     if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR))
> > > > > +             return;
> > > > > +
> > > > > +     if (atomic_dec_and_test(&mm->context.pmu_direct_access))
> > > > > +             on_each_cpu_mask(&armpmu->supported_cpus, refresh_pmuserenr, mm, 1);
> > > >
> > > > Given that the pmu_direct_access field is global per-mm, won't this go
> > > > wrong if multiple PMUs are opened by the same process but only a subset
> > > > are exposed to EL0? Perhaps pmu_direct_access should be treated as a mask
> > > > rather than a counter, so that we can 'and' it with the supported_cpus for
> > > > the PMU we're dealing with.
> > >
> > > It needs to be a count to support multiple events on the same PMU. If
> > > the event is not enabled for EL0, then we'd exit out on the
> > > ARMPMU_EL0_RD_CNTR check. So I think we're fine.
> >
> > I'm still not convinced; pmu_direct_access is shared between PMUs, so
> > testing the result of atomic_dec_and_test() just doesn't make sense to
> > me, as another PMU could be playing with the count.
> 
> How is that a problem? Let's make a concrete example:
> 
> map PMU1:event2 -> pmu_direct_access = 1 -> enable access
> map PMU2:event3 -> pmu_direct_access = 2
> map PMU1:event4 -> pmu_direct_access = 3
> unmap PMU2:event3 -> pmu_direct_access = 2
> unmap PMU1:event2 -> pmu_direct_access = 1
> unmap PMU1:event4 -> pmu_direct_access = 0 -> disable access
> 
> The only issue I can see is PMU2 remains enabled for user access until
> the last unmap. But we're sharing the mm, so who cares? Also, in this
> scenario it is the user's problem to pin themselves to cores sharing a
> PMU. If the user doesn't do that, they get to keep the pieces.

I guess I'm just worried about exposing the counters to userspace after
the PMU driver (or perf core?) thinks that they're no longer exposed in
case we leak other events. However, I'm not sure how this is supposed to
work normally: what happens if e.g. a privileged user has a per-cpu counter
for a kernel event while a task has a counter with direct access -- can that
task read the kernel event out of the PMU registers from userspace?

Will
