Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB42834EF0B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 19:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbhC3RKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 13:10:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232313AbhC3RJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 13:09:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9426619D4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 17:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617124192;
        bh=ifbTSlOZ6tENkxnEu4pcmrUwPxLMOBkubdkplamO3mY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hQ959o+f7RZkAVl/vE/KCjbWGRnsviK5L4BE7mOjZPngrJgVrzvC7CLm2ci+27Z83
         Yp7dqMJv0XyY7iPEMhyEoeVOP2HSHpdsXZONwzARq0wctWtgqmEJ2+kwyTq/odSAdj
         3v2ti17YIZYY60Gql/SsjCpr7Vh4ceeE4ixscVDXa6PeIcaxe5rrDyMFJ7LQhh6Ic7
         zYq1KkMcaNejMOePwJrRu/TyDifYiP8YagWPkB0zgfaOdDhxlHOd3xYKaaec4ipmqC
         h97yPkyrvfVP+NBXayYjyKhBcV655RWSaGDzIN6nj5iOMx7UGW34T2fLkXMhJN9dCe
         hRgauYKtt/qUA==
Received: by mail-ej1-f53.google.com with SMTP id a7so25929756ejs.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 10:09:51 -0700 (PDT)
X-Gm-Message-State: AOAM530Gj43HbOaMqd6wfwQw+oWSXRJjqNKHyypXZ/Bs6SKSks/czYEL
        wobgGHARskH+SpWAB7s2nDSULqvJxVhynMGr2A==
X-Google-Smtp-Source: ABdhPJw8i7u2VDBxDLJASTemaaCCnkfJaLKRql3KGeezWAsEqK6M4yehZnU/k5USpF0BuPcll41ScXYlWtidYiph62U=
X-Received: by 2002:a17:906:c405:: with SMTP id u5mr34569419ejz.341.1617124190291;
 Tue, 30 Mar 2021 10:09:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210311000837.3630499-1-robh@kernel.org> <20210311000837.3630499-3-robh@kernel.org>
 <20210330153125.GC6567@willie-the-truck>
In-Reply-To: <20210330153125.GC6567@willie-the-truck>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 30 Mar 2021 12:09:38 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKN4=T4tHofEoBoWVEZSQEj_m=561_kEdEEkz5szHszhQ@mail.gmail.com>
Message-ID: <CAL_JsqKN4=T4tHofEoBoWVEZSQEj_m=561_kEdEEkz5szHszhQ@mail.gmail.com>
Subject: Re: [PATCH v6 02/10] arm64: perf: Enable PMU counter direct access
 for perf event
To:     Will Deacon <will@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 10:31 AM Will Deacon <will@kernel.org> wrote:
>
> On Wed, Mar 10, 2021 at 05:08:29PM -0700, Rob Herring wrote:
> > From: Raphael Gault <raphael.gault@arm.com>
> >
> > Keep track of event opened with direct access to the hardware counters
> > and modify permissions while they are open.
> >
> > The strategy used here is the same which x86 uses: every time an event
> > is mapped, the permissions are set if required. The atomic field added
> > in the mm_context helps keep track of the different event opened and
> > de-activate the permissions when all are unmapped.
> > We also need to update the permissions in the context switch code so
> > that tasks keep the right permissions.
> >
> > In order to enable 64-bit counters for userspace when available, a new
> > config1 bit is added for userspace to indicate it wants userspace counter
> > access. This bit allows the kernel to decide if chaining should be
> > disabled and chaining and userspace access are incompatible.
> > The modes for config1 are as follows:
> >
> > config1 = 0 or 2 : user access enabled and always 32-bit
> > config1 = 1 : user access disabled and always 64-bit (using chaining if needed)
> > config1 = 3 : user access enabled and counter size matches underlying counter.
>
> In this last case, how does userspace know whether it got a 32-bit or a
> 64-bit counter?

pmc_width in the user page. If the read loop is correct, then it
doesn't matter to the user.

>
> > User access is enabled with config1 == 0 so that we match x86 behavior
> > and don't need Arm specific code (outside the counter read).
> >
> > Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > I'm not completely sure if using current->active_mm in an IPI is okay?
> > It seems to work in my testing.
> >
> > Peter Z says (event->oncpu == smp_processor_id()) in the user page
> > update is always true, but my testing says otherwise[1].
>
> Peter? Sounds like there's either a misunderstanding here or we have some
> fundamental issue elsewhere.
>
> > v6:
> >  - Add new attr.config1 rdpmc bit for userspace to hint it wants
> >    userspace access when also requesting 64-bit counters.
> >
> > v5:
> >  - Only set cap_user_rdpmc if event is on current cpu
> >  - Limit enabling/disabling access to CPUs associated with the PMU
> >    (supported_cpus) and with the mm_struct matching current->active_mm.
> >
> > v2:
> >  - Move mapped/unmapped into arm64 code. Fixes arm32.
> >  - Rebase on cap_user_time_short changes
> >
> > Changes from Raphael's v4:
> >   - Drop homogeneous check
> >   - Disable access for chained counters
> >   - Set pmc_width in user page
> >
> > [1] https://lore.kernel.org/lkml/CAL_JsqK+eKef5NaVnBfARCjRE3MYhfBfe54F9YHKbsTnWqLmLw@mail.gmail.com/
> >
> > user fix
> > ---
> >  arch/arm64/include/asm/mmu.h         |  5 ++
> >  arch/arm64/include/asm/mmu_context.h |  2 +
> >  arch/arm64/include/asm/perf_event.h  | 14 +++++
> >  arch/arm64/kernel/perf_event.c       | 86 +++++++++++++++++++++++++++-
> >  4 files changed, 104 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> > index 75beffe2ee8a..ee08447455da 100644
> > --- a/arch/arm64/include/asm/mmu.h
> > +++ b/arch/arm64/include/asm/mmu.h
> > @@ -18,6 +18,11 @@
> >
> >  typedef struct {
> >       atomic64_t      id;
> > +     /*
> > +      * non-zero if userspace have access to hardware
> > +      * counters directly.
> > +      */
> > +     atomic_t        pmu_direct_access;
> >  #ifdef CONFIG_COMPAT
> >       void            *sigpage;
> >  #endif
> > diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> > index 70ce8c1d2b07..ccb5ff417b42 100644
> > --- a/arch/arm64/include/asm/mmu_context.h
> > +++ b/arch/arm64/include/asm/mmu_context.h
> > @@ -21,6 +21,7 @@
> >  #include <asm/proc-fns.h>
> >  #include <asm-generic/mm_hooks.h>
> >  #include <asm/cputype.h>
> > +#include <asm/perf_event.h>
> >  #include <asm/sysreg.h>
> >  #include <asm/tlbflush.h>
> >
> > @@ -230,6 +231,7 @@ static inline void __switch_mm(struct mm_struct *next)
> >       }
> >
> >       check_and_switch_context(next);
> > +     perf_switch_user_access(next);
> >  }
> >
> >  static inline void
> > diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
> > index 60731f602d3e..112f3f63b79e 100644
> > --- a/arch/arm64/include/asm/perf_event.h
> > +++ b/arch/arm64/include/asm/perf_event.h
> > @@ -8,6 +8,7 @@
> >
> >  #include <asm/stack_pointer.h>
> >  #include <asm/ptrace.h>
> > +#include <linux/mm_types.h>
> >
> >  #define      ARMV8_PMU_MAX_COUNTERS  32
> >  #define      ARMV8_PMU_COUNTER_MASK  (ARMV8_PMU_MAX_COUNTERS - 1)
> > @@ -254,4 +255,17 @@ extern unsigned long perf_misc_flags(struct pt_regs *regs);
> >       (regs)->pstate = PSR_MODE_EL1h; \
> >  }
> >
> > +static inline void perf_switch_user_access(struct mm_struct *mm)
> > +{
> > +     if (!IS_ENABLED(CONFIG_PERF_EVENTS))
> > +             return;
>
> CONFIG_HW_PERF_EVENTS might be a better fit here.
>
> > +
> > +     if (atomic_read(&mm->context.pmu_direct_access)) {
> > +             write_sysreg(ARMV8_PMU_USERENR_ER|ARMV8_PMU_USERENR_CR,
> > +                          pmuserenr_el0);
> > +     } else {
> > +             write_sysreg(0, pmuserenr_el0);
> > +     }
> > +}
> > +
> >  #endif
> > diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> > index 387838496955..9ad3cc523ef4 100644
> > --- a/arch/arm64/kernel/perf_event.c
> > +++ b/arch/arm64/kernel/perf_event.c
> > @@ -288,15 +288,22 @@ static const struct attribute_group armv8_pmuv3_events_attr_group = {
> >
> >  PMU_FORMAT_ATTR(event, "config:0-15");
> >  PMU_FORMAT_ATTR(long, "config1:0");
> > +PMU_FORMAT_ATTR(rdpmc, "config1:1");
> >
> >  static inline bool armv8pmu_event_is_64bit(struct perf_event *event)
> >  {
> >       return event->attr.config1 & 0x1;
> >  }
> >
> > +static inline bool armv8pmu_event_want_user_access(struct perf_event *event)
> > +{
> > +     return event->attr.config1 & 0x2;
> > +}
> > +
> >  static struct attribute *armv8_pmuv3_format_attrs[] = {
> >       &format_attr_event.attr,
> >       &format_attr_long.attr,
> > +     &format_attr_rdpmc.attr,
> >       NULL,
> >  };
> >
> > @@ -356,6 +363,7 @@ static inline bool armv8pmu_event_is_chained(struct perf_event *event)
> >       struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
> >
> >       return !WARN_ON(idx < 0) &&
> > +            !armv8pmu_event_want_user_access(event) &&
> >              armv8pmu_event_is_64bit(event) &&
> >              !armv8pmu_has_long_event(cpu_pmu) &&
> >              (idx != ARMV8_IDX_CYCLE_COUNTER);
> > @@ -849,13 +857,17 @@ static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
> >       if (evtype == ARMV8_PMUV3_PERFCTR_CPU_CYCLES) {
> >               if (!test_and_set_bit(ARMV8_IDX_CYCLE_COUNTER, cpuc->used_mask))
> >                       return ARMV8_IDX_CYCLE_COUNTER;
> > +             else if (armv8pmu_event_is_64bit(event) &&
> > +                        armv8pmu_event_want_user_access(event) &&
> > +                        !armv8pmu_has_long_event(cpu_pmu))
> > +                             return -EAGAIN;
> >       }
> >
> >       /*
> >        * Otherwise use events counters
> >        */
> > -     if (armv8pmu_event_is_64bit(event) &&
> > -         !armv8pmu_has_long_event(cpu_pmu))
> > +     if (armv8pmu_event_is_64bit(event) && !armv8pmu_has_long_event(cpu_pmu) &&
> > +         !armv8pmu_event_want_user_access(event))
>
> This logic is duplicated in armv8pmu_event_is_chained(); can you split it
> into a helper, please?
>
> >               return  armv8pmu_get_chain_idx(cpuc, cpu_pmu);
> >       else
> >               return armv8pmu_get_single_idx(cpuc, cpu_pmu);
> > @@ -887,6 +899,46 @@ static int armv8pmu_access_event_idx(struct perf_event *event)
> >       return event->hw.idx;
> >  }
> >
> > +static void refresh_pmuserenr(void *mm)
> > +{
> > +     if (mm == current->active_mm)
> > +             perf_switch_user_access(mm);
> > +}
> > +
> > +static void armv8pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
> > +{
> > +     struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
> > +
> > +     if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR))
> > +             return;
> > +
> > +     /*
> > +      * This function relies on not being called concurrently in two
> > +      * tasks in the same mm.  Otherwise one task could observe
> > +      * pmu_direct_access > 1 and return all the way back to
> > +      * userspace with user access disabled while another task is still
> > +      * doing on_each_cpu_mask() to enable user access.
> > +      *
> > +      * For now, this can't happen because all callers hold mmap_lock
> > +      * for write.  If this changes, we'll need a different solution.
> > +      */
> > +     lockdep_assert_held_write(&mm->mmap_lock);
> > +
> > +     if (atomic_inc_return(&mm->context.pmu_direct_access) == 1)
> > +             on_each_cpu_mask(&armpmu->supported_cpus, refresh_pmuserenr, mm, 1);
> > +}
>
> Why do we need to cross-call here? Seems like it would be a tonne simpler to
> handle the trap. Is there a reason not to do that?

Alignment with x86? You didn't like the trap handler either:

> Hmm... this feels pretty fragile since, although we may expect userspace only
> to trigger this in the context of the specific perf use-case, we don't have
> a way to detect that, so the ABI we're exposing is that EL0 accesses to
> non-existent counters will return 0. I don't really think that's something
> we want to commit to.

Full mail: https://lore.kernel.org/r/20200928182601.GA11974@willie-the-truck

The handler would be different, but we'd still have the problem of not
being able to detect the use case, right?

> > +
> > +static void armv8pmu_event_unmapped(struct perf_event *event, struct mm_struct *mm)
> > +{
> > +     struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
> > +
> > +     if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR))
> > +             return;
> > +
> > +     if (atomic_dec_and_test(&mm->context.pmu_direct_access))
> > +             on_each_cpu_mask(&armpmu->supported_cpus, refresh_pmuserenr, mm, 1);
>
> Given that the pmu_direct_access field is global per-mm, won't this go
> wrong if multiple PMUs are opened by the same process but only a subset
> are exposed to EL0? Perhaps pmu_direct_access should be treated as a mask
> rather than a counter, so that we can 'and' it with the supported_cpus for
> the PMU we're dealing with.

It needs to be a count to support multiple events on the same PMU. If
the event is not enabled for EL0, then we'd exit out on the
ARMPMU_EL0_RD_CNTR check. So I think we're fine.

> > @@ -980,9 +1032,23 @@ static int __armv8_pmuv3_map_event(struct perf_event *event,
> >                                      &armv8_pmuv3_perf_cache_map,
> >                                      ARMV8_PMU_EVTYPE_EVENT);
> >
> > -     if (armv8pmu_event_is_64bit(event))
> > +     if (armv8pmu_event_want_user_access(event) || !armv8pmu_event_is_64bit(event)) {
> > +             event->hw.flags |= ARMPMU_EL0_RD_CNTR;
>
> Why do you set this for all 32-bit events?

It goes back to the config1 bits as explained in the commit msg. We
can always support user access for 32-bit counters, but for 64-bit
counters the user has to request both user access and 64-bit counters.
We could require explicit user access request for 32-bit access, but I
thought it was better to not require userspace to do something Arm
specific on open.

> The logic here feels like it
> could with a bit of untangling.

Yes, I don't love it, but couldn't come up with anything better. It is
complicated by the fact that flags have to be set before we assign the
counter and can't set/change them when we assign the counter. It would
take a lot of refactoring with armpmu code to fix that.

>
> > +             /*
> > +              * At this point, the counter is not assigned. If a 64-bit
> > +              * counter is requested, we must make sure the h/w has 64-bit
> > +              * counters if we set the event size to 64-bit because chaining
> > +              * is not supported with userspace access. This may still fail
> > +              * later on if the CPU cycle counter is in use.
> > +              */
> > +             if (armv8pmu_event_is_64bit(event) &&
> > +                 (armv8pmu_has_long_event(armpmu) ||
> > +                  hw_event_id == ARMV8_PMUV3_PERFCTR_CPU_CYCLES))
> > +                     event->hw.flags |= ARMPMU_EVT_64BIT;
> > +     } else if (armv8pmu_event_is_64bit(event))
> >               event->hw.flags |= ARMPMU_EVT_64BIT;
