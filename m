Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D8E37B02F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 22:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhEKUkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 16:40:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:37700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhEKUkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 16:40:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0731761626
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 20:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620765566;
        bh=H7zPe428dMDLvAoB1J+eA58qEWZhve5PDtDNRApAvUs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CpDsEm9TULe99bh1PErPdYGF3lOeX5qDgw+HwGEAFNXhMA6JhIEc1HSmTKVpO3eKT
         0k+bnkXKtvCYcV9mlMui3+deevlzdkOZpPTTGcOzgE9wXbkeMrkYkWYKDGTnEIATom
         yAWY4P4afTgzQre2Ciarh2nS3xYmP92XFzDwUgRVd9JilwN6NSKw1OcX/P8H0QV40i
         lZ6GMNSRhxKjyEnyhQtG2RwcNmBi9uFcItkUCfUqo1xpiKb47Y+h9FiD+HfuMrA7hz
         KS/vveDkglQXyiiffWKolKXLTfj9aM/dIF46aYny+szpyNdZxaQTpg+2nAIFjovU6W
         cDOU55KjRgspg==
Received: by mail-ed1-f50.google.com with SMTP id l7so24483957edb.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 13:39:25 -0700 (PDT)
X-Gm-Message-State: AOAM533PwzY07XmrQY084r+IWKSVED6CvPCqgn2C5Xb6xHDNDRBxsm3a
        3v24RtXL9KgZw8nYSFyjjLb22NgZ4cHONKM2Lg==
X-Google-Smtp-Source: ABdhPJwVHI2JH2pjuEaPD7fEYgbhmwQfxrKRxmNd022BltdEWNI6eUBjj2cZVxiwDU71WtLdQKlIsv7sLoV332/xLN8=
X-Received: by 2002:a05:6402:84b:: with SMTP id b11mr38809784edz.289.1620765564404;
 Tue, 11 May 2021 13:39:24 -0700 (PDT)
MIME-Version: 1.0
References: <1619115952-155809-1-git-send-email-kan.liang@linux.intel.com>
 <20210510191811.GA21560@worktop.programming.kicks-ass.net>
 <CAL_JsqKeVoBL6cn6CGUW17jnf8B+4aHKeyRdceaGCiKzsUsZwg@mail.gmail.com> <bbe76d64-f6ff-29eb-9f62-2d4f934463e3@linux.intel.com>
In-Reply-To: <bbe76d64-f6ff-29eb-9f62-2d4f934463e3@linux.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 11 May 2021 15:39:12 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJrrqbHbMXEpy++nGzZ5JD=mm4O2xPgL8g1MUXAQGk=Jw@mail.gmail.com>
Message-ID: <CAL_JsqJrrqbHbMXEpy++nGzZ5JD=mm4O2xPgL8g1MUXAQGk=Jw@mail.gmail.com>
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

On Tue, May 11, 2021 at 12:59 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>
>
>
> On 5/10/2021 4:29 PM, Rob Herring wrote:
> > On Mon, May 10, 2021 at 2:18 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >>
> >> On Thu, Apr 22, 2021 at 11:25:52AM -0700, kan.liang@linux.intel.com wrote:
> >>
> >>> - Add a new method check_leakage() to check and clear dirty counters
> >>>    to prevent potential leakage.
> >>
> >> I really dislike adding spurious callbacks, also because indirect calls
> >> are teh suck, but also because it pollutes the interface so.
> >>
> >> That said, I'm not sure I actually like the below any better :/
> >>
>
> Maybe we can add a atomic variable to track the number of
> event_mapped(). Only invoke sched_task() when the number > 0.

Except that it is only needed when mapped and user access is allowed/enabled.

>
> It looks like only X86 implements the event_mapped(). So it should not
> impact other ARCHs.

Arm will have one if we ever settle on the implementation.

>
> What do you think?
>
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index c6fedd2..ae5b0e7 100644
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
> @@ -2484,6 +2486,31 @@ static int x86_pmu_event_init(struct perf_event
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
> @@ -2507,7 +2534,6 @@ static void x86_pmu_event_mapped(struct perf_event
> *event, struct mm_struct *mm)
>
>   static void x86_pmu_event_unmapped(struct perf_event *event, struct
> mm_struct *mm)
>   {
> -
>         if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
>                 return;
>
> @@ -2616,6 +2642,14 @@ static const struct attribute_group
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
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 1574b70..ef8f6f4 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -384,6 +384,7 @@ DEFINE_STATIC_KEY_FALSE(perf_sched_events);
>   static DECLARE_DELAYED_WORK(perf_sched_work, perf_sched_delayed);
>   static DEFINE_MUTEX(perf_sched_mutex);
>   static atomic_t perf_sched_count;
> +static atomic_t perf_event_mmap_count;

A global count is not going to work. I think it needs to be per PMU at
least. In the case of Arm big.LITTLE, user access is constrained to
one subset of cores which is 1 PMU instance.

>
>   static DEFINE_PER_CPU(atomic_t, perf_cgroup_events);
>   static DEFINE_PER_CPU(int, perf_sched_cb_usages);
> @@ -3851,7 +3852,7 @@ static void perf_event_context_sched_in(struct
> perf_event_context *ctx,
>                 cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
>         perf_event_sched_in(cpuctx, ctx, task);
>
> -       if (cpuctx->sched_cb_usage && pmu->sched_task)
> +       if (pmu->sched_task && (cpuctx->sched_cb_usage ||
> atomic_read(&perf_event_mmap_count)))
>                 pmu->sched_task(cpuctx->task_ctx, true);
>
>         perf_pmu_enable(pmu);
> @@ -5988,8 +5989,10 @@ static void perf_mmap_open(struct vm_area_struct
> *vma)
>         if (vma->vm_pgoff)
>                 atomic_inc(&event->rb->aux_mmap_count);
>
> -       if (event->pmu->event_mapped)
> +       if (event->pmu->event_mapped) {
> +               atomic_inc(&perf_event_mmap_count);
>                 event->pmu->event_mapped(event, vma->vm_mm);
> +       }
>   }
>
>   static void perf_pmu_output_stop(struct perf_event *event);
> @@ -6011,8 +6014,10 @@ static void perf_mmap_close(struct vm_area_struct
> *vma)
>         unsigned long size = perf_data_size(rb);
>         bool detach_rest = false;
>
> -       if (event->pmu->event_unmapped)
> +       if (event->pmu->event_unmapped) {
> +               atomic_dec(&perf_event_mmap_count);
>                 event->pmu->event_unmapped(event, vma->vm_mm);
> +       }
>
>         /*
>          * rb->aux_mmap_count will always drop before rb->mmap_count and
> @@ -6329,8 +6334,10 @@ static int perf_mmap(struct file *file, struct
> vm_area_struct *vma)
>         vma->vm_flags |= VM_DONTCOPY | VM_DONTEXPAND | VM_DONTDUMP;
>         vma->vm_ops = &perf_mmap_vmops;
>
> -       if (event->pmu->event_mapped)
> +       if (event->pmu->event_mapped) {
> +               atomic_inc(&perf_event_mmap_count);
>                 event->pmu->event_mapped(event, vma->vm_mm);
> +       }
>
>         return ret;
>   }
>
>
> Thanks,
> Kan
