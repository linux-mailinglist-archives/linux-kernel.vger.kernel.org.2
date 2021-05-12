Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025BD37C133
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 16:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbhELO5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 10:57:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232208AbhELOzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 10:55:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B0F3761441
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 14:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620831278;
        bh=NShRd3NYyDVh4LIHshZ8IGbLG1j5IJdKRDr2JGvdPu4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OHXqr+vLINsBqZrBEmJgf/5gQX0JIVGbKjxv/qXO+BLW2OXxiNyRHc839qcKwHeii
         QjqZKW5/paDM4NXuHYbPwGtjedcH4ULZeu8rtthS6XTZ8vgWsVuSwrHmvH0Iv7S9Kj
         tLiJ4lbr3pnqcGiant4kjB7YDYeyFT1MMAXchOPC0WeFoNJKKG6cRbAW+jXBeJ43u/
         atwkS0NvOex3Ua8nd5+xoVe6bCCtT6rVqORqUFzvyQd4LWTMk6TG5Md3GZO8Fx6Z0a
         uqv1l0rB1rHxyV0mPT1JGeA0LKa6Fk7zAaUEF5qwgDRyNlrwu3VoxFAEDBF3m+MSGp
         7YGWH9VkY04ug==
Received: by mail-ed1-f41.google.com with SMTP id df21so195398edb.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 07:54:38 -0700 (PDT)
X-Gm-Message-State: AOAM5302QTxNdV0RMBnQSkR6vDSzhp//y1j+Z/5I0ZvKP4lnqA/h8rw3
        AaCdb6Pdf9D3yrjsPtFTuGaM5qwRSfRjRt53nw==
X-Google-Smtp-Source: ABdhPJwjgSrH8tsisU4ev5aUk3eNR6T1tRgRAjfsC57o6teeRczK+1DWU7FX0OKKptjhkHtY1NU8jHR0nUXcLz9v0HI=
X-Received: by 2002:a05:6402:100c:: with SMTP id c12mr26461197edu.165.1620831277080;
 Wed, 12 May 2021 07:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <1619115952-155809-1-git-send-email-kan.liang@linux.intel.com>
 <20210510191811.GA21560@worktop.programming.kicks-ass.net>
 <CAL_JsqKeVoBL6cn6CGUW17jnf8B+4aHKeyRdceaGCiKzsUsZwg@mail.gmail.com>
 <bbe76d64-f6ff-29eb-9f62-2d4f934463e3@linux.intel.com> <CAL_JsqJrrqbHbMXEpy++nGzZ5JD=mm4O2xPgL8g1MUXAQGk=Jw@mail.gmail.com>
 <f390aa11-e475-9d9d-9384-959a7ed32fd6@linux.intel.com>
In-Reply-To: <f390aa11-e475-9d9d-9384-959a7ed32fd6@linux.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 12 May 2021 09:54:22 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKN4YcCpL9uiOqea4CcqRWgU7Af=V8JNMjypivaVHq4sQ@mail.gmail.com>
Message-ID: <CAL_JsqKN4YcCpL9uiOqea4CcqRWgU7Af=V8JNMjypivaVHq4sQ@mail.gmail.com>
Subject: Re: [PATCH V6] perf: Reset the dirty counter to prevent the leak for
 an RDPMC task
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Stephane Eranian <eranian@google.com>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 4:43 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>
>
>
> On 5/11/2021 4:39 PM, Rob Herring wrote:
> > On Tue, May 11, 2021 at 12:59 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
> >>
> >>
> >>
> >> On 5/10/2021 4:29 PM, Rob Herring wrote:
> >>> On Mon, May 10, 2021 at 2:18 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >>>>
> >>>> On Thu, Apr 22, 2021 at 11:25:52AM -0700, kan.liang@linux.intel.com wrote:
> >>>>
> >>>>> - Add a new method check_leakage() to check and clear dirty counters
> >>>>>     to prevent potential leakage.
> >>>>
> >>>> I really dislike adding spurious callbacks, also because indirect calls
> >>>> are teh suck, but also because it pollutes the interface so.
> >>>>
> >>>> That said, I'm not sure I actually like the below any better :/
> >>>>
> >>
> >> Maybe we can add a atomic variable to track the number of
> >> event_mapped(). Only invoke sched_task() when the number > 0.
> >
> > Except that it is only needed when mapped and user access is allowed/enabled.
> >
> >>
> >> It looks like only X86 implements the event_mapped(). So it should not
> >> impact other ARCHs.
> >
> > Arm will have one if we ever settle on the implementation.
> >
> >>
> >> What do you think?
> >>
> >> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> >> index c6fedd2..ae5b0e7 100644
> >> --- a/arch/x86/events/core.c
> >> +++ b/arch/x86/events/core.c
> >> @@ -1636,6 +1636,8 @@ static void x86_pmu_del(struct perf_event *event,
> >> int flags)
> >>          if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
> >>                  goto do_del;
> >>
> >> +       __set_bit(event->hw.idx, cpuc->dirty);
> >> +
> >>          /*
> >>           * Not a TXN, therefore cleanup properly.
> >>           */
> >> @@ -2484,6 +2486,31 @@ static int x86_pmu_event_init(struct perf_event
> >> *event)
> >>          return err;
> >>    }
> >>
> >> +static void x86_pmu_clear_dirty_counters(void)
> >> +{
> >> +       struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> >> +       int i;
> >> +
> >> +        /* Don't need to clear the assigned counter. */
> >> +       for (i = 0; i < cpuc->n_events; i++)
> >> +               __clear_bit(cpuc->assign[i], cpuc->dirty);
> >> +
> >> +       if (bitmap_empty(cpuc->dirty, X86_PMC_IDX_MAX))
> >> +               return;
> >> +
> >> +       for_each_set_bit(i, cpuc->dirty, X86_PMC_IDX_MAX) {
> >> +               /* Metrics and fake events don't have corresponding HW counters. */
> >> +               if (is_metric_idx(i) || (i == INTEL_PMC_IDX_FIXED_VLBR))
> >> +                       continue;
> >> +               else if (i >= INTEL_PMC_IDX_FIXED)
> >> +                       wrmsrl(MSR_ARCH_PERFMON_FIXED_CTR0 + (i - INTEL_PMC_IDX_FIXED), 0);
> >> +               else
> >> +                       wrmsrl(x86_pmu_event_addr(i), 0);
> >> +       }
> >> +
> >> +       bitmap_zero(cpuc->dirty, X86_PMC_IDX_MAX);
> >> +}
> >> +
> >>    static void x86_pmu_event_mapped(struct perf_event *event, struct
> >> mm_struct *mm)
> >>    {
> >>          if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
> >> @@ -2507,7 +2534,6 @@ static void x86_pmu_event_mapped(struct perf_event
> >> *event, struct mm_struct *mm)
> >>
> >>    static void x86_pmu_event_unmapped(struct perf_event *event, struct
> >> mm_struct *mm)
> >>    {
> >> -
> >>          if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
> >>                  return;
> >>
> >> @@ -2616,6 +2642,14 @@ static const struct attribute_group
> >> *x86_pmu_attr_groups[] = {
> >>    static void x86_pmu_sched_task(struct perf_event_context *ctx, bool
> >> sched_in)
> >>    {
> >>          static_call_cond(x86_pmu_sched_task)(ctx, sched_in);
> >> +
> >> +       /*
> >> +        * If a new task has the RDPMC enabled, clear the dirty counters
> >> +        * to prevent the potential leak.
> >> +        */
> >> +       if (sched_in && ctx && READ_ONCE(x86_pmu.attr_rdpmc) &&
> >> +           current->mm && atomic_read(&current->mm->context.perf_rdpmc_allowed))
> >> +               x86_pmu_clear_dirty_counters();
> >>    }
> >>
> >>    static void x86_pmu_swap_task_ctx(struct perf_event_context *prev,
> >> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> >> index 10c8171..55bd891 100644
> >> --- a/arch/x86/events/perf_event.h
> >> +++ b/arch/x86/events/perf_event.h
> >> @@ -229,6 +229,7 @@ struct cpu_hw_events {
> >>           */
> >>          struct perf_event       *events[X86_PMC_IDX_MAX]; /* in counter order */
> >>          unsigned long           active_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
> >> +       unsigned long           dirty[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
> >>          int                     enabled;
> >>
> >>          int                     n_events; /* the # of events in the below arrays */
> >> diff --git a/kernel/events/core.c b/kernel/events/core.c
> >> index 1574b70..ef8f6f4 100644
> >> --- a/kernel/events/core.c
> >> +++ b/kernel/events/core.c
> >> @@ -384,6 +384,7 @@ DEFINE_STATIC_KEY_FALSE(perf_sched_events);
> >>    static DECLARE_DELAYED_WORK(perf_sched_work, perf_sched_delayed);
> >>    static DEFINE_MUTEX(perf_sched_mutex);
> >>    static atomic_t perf_sched_count;
> >> +static atomic_t perf_event_mmap_count;
> >
> > A global count is not going to work. I think it needs to be per PMU at
> > least. In the case of Arm big.LITTLE, user access is constrained to
> > one subset of cores which is 1 PMU instance.
> >
>
> How about this one?

Would you mind splitting this to core and x86 parts.

>
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index c6fedd2..9052578 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1636,6 +1636,8 @@ static void x86_pmu_del(struct perf_event *event,
> int flags)
>         if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
>                 goto do_del;
>
> +       __set_bit(event->hw.idx, cpuc->dirty);
> +
>         /*
>          * Not a TXN, therefore cleanup properly.
>          */
> @@ -2484,12 +2486,43 @@ static int x86_pmu_event_init(struct perf_event
> *event)
>         return err;
>   }
>
> +static void x86_pmu_clear_dirty_counters(void)
> +{
> +       struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +       int i;
> +
> +        /* Don't need to clear the assigned counter. */
> +       for (i = 0; i < cpuc->n_events; i++)
> +               __clear_bit(cpuc->assign[i], cpuc->dirty);
> +
> +       if (bitmap_empty(cpuc->dirty, X86_PMC_IDX_MAX))
> +               return;
> +
> +       for_each_set_bit(i, cpuc->dirty, X86_PMC_IDX_MAX) {
> +               /* Metrics and fake events don't have corresponding HW counters. */
> +               if (is_metric_idx(i) || (i == INTEL_PMC_IDX_FIXED_VLBR))
> +                       continue;
> +               else if (i >= INTEL_PMC_IDX_FIXED)
> +                       wrmsrl(MSR_ARCH_PERFMON_FIXED_CTR0 + (i - INTEL_PMC_IDX_FIXED), 0);
> +               else
> +                       wrmsrl(x86_pmu_event_addr(i), 0);
> +       }
> +
> +       bitmap_zero(cpuc->dirty, X86_PMC_IDX_MAX);
> +}
> +
>   static void x86_pmu_event_mapped(struct perf_event *event, struct
> mm_struct *mm)
>   {
>         if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
>                 return;
>
>         /*
> +        * Enable sched_task() for the RDPMC task.
> +        */
> +       if (x86_pmu.sched_task && event->hw.target)
> +               atomic_inc(&event->pmu->sched_cb_usages);
> +
> +       /*
>          * This function relies on not being called concurrently in two
>          * tasks in the same mm.  Otherwise one task could observe
>          * perf_rdpmc_allowed > 1 and return all the way back to
> @@ -2507,10 +2540,12 @@ static void x86_pmu_event_mapped(struct
> perf_event *event, struct mm_struct *mm)
>
>   static void x86_pmu_event_unmapped(struct perf_event *event, struct
> mm_struct *mm)
>   {
> -
>         if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
>                 return;
>
> +       if (x86_pmu.sched_task && event->hw.target)
> +               atomic_dec(&event->pmu->sched_cb_usages);
> +
>         if (atomic_dec_and_test(&mm->context.perf_rdpmc_allowed))
>                 on_each_cpu_mask(mm_cpumask(mm), cr4_update_pce, NULL, 1);
>   }
> @@ -2616,6 +2651,14 @@ static const struct attribute_group
> *x86_pmu_attr_groups[] = {
>   static void x86_pmu_sched_task(struct perf_event_context *ctx, bool
> sched_in)
>   {
>         static_call_cond(x86_pmu_sched_task)(ctx, sched_in);
> +
> +       /*
> +        * If a new task has the RDPMC enabled, clear the dirty counters
> +        * to prevent the potential leak.
> +        */
> +       if (sched_in && ctx && READ_ONCE(x86_pmu.attr_rdpmc) &&
> +           current->mm && atomic_read(&current->mm->context.perf_rdpmc_allowed))
> +               x86_pmu_clear_dirty_counters();
>   }
>
>   static void x86_pmu_swap_task_ctx(struct perf_event_context *prev,
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index 10c8171..55bd891 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -229,6 +229,7 @@ struct cpu_hw_events {
>          */
>         struct perf_event       *events[X86_PMC_IDX_MAX]; /* in counter order */
>         unsigned long           active_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
> +       unsigned long           dirty[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
>         int                     enabled;
>
>         int                     n_events; /* the # of events in the below arrays */
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index c8a3388..3a85dbe 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -301,6 +301,9 @@ struct pmu {
>         /* number of address filters this PMU can do */
>         unsigned int                    nr_addr_filters;
>
> +       /* Track the per PMU sched_task() callback users */
> +       atomic_t                        sched_cb_usages;

To align with the per cpu one: s/usages/usage/

I think we should be able to use refcount_t here instead?

> +
>         /*
>          * Fully disable/enable this PMU, can be used to protect from the PMI
>          * as well as for lazy/batch writing of the MSRs.
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 1574b70..8216acc 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -3851,7 +3851,7 @@ static void perf_event_context_sched_in(struct
> perf_event_context *ctx,
>                 cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
>         perf_event_sched_in(cpuctx, ctx, task);
>
> -       if (cpuctx->sched_cb_usage && pmu->sched_task)
> +       if (pmu->sched_task && (cpuctx->sched_cb_usage ||
> atomic_read(&pmu->sched_cb_usages)))

For completeness, shouldn't this condition be added everywhere
->sched_task() can be called perhaps with the exception of
__perf_pmu_sched_task() which is only called when the task context
doesn't change.

>                 pmu->sched_task(cpuctx->task_ctx, true);
>
>         perf_pmu_enable(pmu);
>
> Thanks,
> Kan
