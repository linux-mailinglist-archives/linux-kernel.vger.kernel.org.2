Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D83C3975FE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 17:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbhFAPCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 11:02:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234066AbhFAPCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 11:02:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3C50613BC
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 15:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622559666;
        bh=wwoYcm8ejWItGS2gh8SDndzwybjoRzxu9N5XCFScv7w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FNhj/MTz1vdgDW6J/bTuhd5a2fA8h05K+JHrN+0c1bDKMqX7hukpmztTcLPGdPKuD
         i0SHDgYasLM2i+6OrjPqde4EbhqnhAoY+YAgVYo5phpzgqdlsoBO46O7D+c+A9r04f
         gqot9AzEHdMrvd/8gpyyltxAqRm1sYGQed1i9d6gvyNqKg8eUS9z2d/VAQJV2VDjnv
         dPvh1CszII+tBCYfqPnv1EOM+ILft7yOxn6jgAZPbN7ze/86YLeJNlGISVX/Yv1lzG
         vfsdAtcy4uS4u/zNAASGjYfb6JPLtzUItlPwUkk2n5JmtqDIjX8VIsF+jNuE8J+TH7
         v/kADHl+p1OGw==
Received: by mail-ed1-f43.google.com with SMTP id s6so17715168edu.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 08:01:06 -0700 (PDT)
X-Gm-Message-State: AOAM532QFquulswQle4CMzYwJPvT3VYiOjdMxzfa83Qk2ui9v+4GfReq
        6uxhbF2f7ZubDFl1A5G6sCWWFx6vSldQcqyppQ==
X-Google-Smtp-Source: ABdhPJyTiF+76ZL/HSGI2SvEOhrhPEJYEwJq3kZYKO5+6VMbjLm/KR66owO7LGabcxAsmH1HSd++55Iqq/vQS8pNf/0=
X-Received: by 2002:a05:6402:1d85:: with SMTP id dk5mr15044740edb.289.1622559665326;
 Tue, 01 Jun 2021 08:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210517195405.3079458-1-robh@kernel.org> <20210517195405.3079458-4-robh@kernel.org>
 <20210601135526.GA3326@C02TD0UTHF1T.local>
In-Reply-To: <20210601135526.GA3326@C02TD0UTHF1T.local>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 1 Jun 2021 10:00:53 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKo2cQsWkG67HUDgyO=WXywzykM+UY4uOwdpA6FVZsc0A@mail.gmail.com>
Message-ID: <CAL_JsqKo2cQsWkG67HUDgyO=WXywzykM+UY4uOwdpA6FVZsc0A@mail.gmail.com>
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

On Tue, Jun 1, 2021 at 8:55 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Mon, May 17, 2021 at 02:54:03PM -0500, Rob Herring wrote:
> > Arm PMUs can support direct userspace access of counters which allows for
> > low overhead (i.e. no syscall) self-monitoring of tasks. The same feature
> > exists on x86 called 'rdpmc'. Unlike x86, userspace access will only be
> > enabled for thread bound events. This could be extended if needed, but
> > simplifies the implementation and reduces the chances for any
> > information leaks (which the x86 implementation suffers from).
> >
> > When an event is capable of userspace access and has been mmapped, userspace
> > access is enabled when the event is scheduled on a CPU's PMU. There's some
> > additional overhead clearing counters when disabled in order to prevent
> > leaking disabled counter data from other tasks.
> >
> > Unlike x86, enabling of userspace access must be requested with a new
> > attr bit: config1:1. If the user requests userspace access and 64-bit
> > counters, then chaining will be disabled and the user will get the
> > maximum size counter the underlying h/w can support. The modes for
> > config1 are as follows:
> >
> > config1 = 0 : user access disabled and always 32-bit
> > config1 = 1 : user access disabled and always 64-bit (using chaining if needed)
> > config1 = 2 : user access enabled and always 32-bit
> > config1 = 3 : user access enabled and counter size matches underlying counter.
> >
> > Based on work by Raphael Gault <raphael.gault@arm.com>, but has been
> > completely re-written.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> [...]
>
> > +static void armv8pmu_enable_user_access(struct arm_pmu *cpu_pmu)
> > +{
> > +     struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
> > +
> > +     if (!bitmap_empty(cpuc->dirty_mask, ARMPMU_MAX_HWEVENTS)) {
> > +             int i;
> > +             /* Don't need to clear assigned counters. */
> > +             bitmap_xor(cpuc->dirty_mask, cpuc->dirty_mask, cpuc->used_mask, ARMPMU_MAX_HWEVENTS);
> > +
> > +             for_each_set_bit(i, cpuc->dirty_mask, ARMPMU_MAX_HWEVENTS) {
> > +                     if (i == ARMV8_IDX_CYCLE_COUNTER)
> > +                             write_sysreg(0, pmccntr_el0);
> > +                     else
> > +                             armv8pmu_write_evcntr(i, 0);
> > +             }
> > +             bitmap_zero(cpuc->dirty_mask, ARMPMU_MAX_HWEVENTS);
> > +     }
> > +
> > +     write_sysreg(ARMV8_PMU_USERENR_ER | ARMV8_PMU_USERENR_CR, pmuserenr_el0);
> > +}
>
> This still leaks the values of CPU-bound events, or task-bound events
> owned by others, right?

For CPU-bound events, yes. There's not any way to prevent that without
per counter access controls.

It is clearing other's task-bound events.

> [...]
>
> > +static void armv8pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
> > +{
> > +     if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR) || (atomic_read(&event->mmap_count) != 1))
> > +             return;
> > +
> > +     if (atomic_inc_return(&event->ctx->nr_user) == 1) {
> > +             unsigned long flags;
> > +             atomic_inc(&event->pmu->sched_cb_usage);
> > +             local_irq_save(flags);
> > +             armv8pmu_enable_user_access(to_arm_pmu(event->pmu));
> > +             local_irq_restore(flags);
> > +     }
> > +}
> > +
> > +static void armv8pmu_event_unmapped(struct perf_event *event, struct mm_struct *mm)
> > +{
> > +     if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR) || (atomic_read(&event->mmap_count) != 1))
> > +             return;
> > +
> > +     if (atomic_dec_and_test(&event->ctx->nr_user)) {
> > +             atomic_dec(&event->pmu->sched_cb_usage);
> > +             armv8pmu_disable_user_access();
> > +     }
> >  }
>
> We can open an event for task A, but call mmap()/munmap() for that event
> from task B, which will do the enable/disable on task B rather than task
> A. The core doesn't enforce that the mmap is performed on the same core,
> so I don't think this is quite right, unfortunately.

Why do we care and who wants to do that? It all seems like a
convoluted scenario that isn't really going to happen. I prefer to not
support that until someone asks for it. Maybe we should check for the
condition (event->ctx->task != current) though.

> I reckon we need to do something with task_function_call() to make this
> happen in the context of the expected task.

Following the x86 way using the mm_context and IPI handled that case,
but Will didn't like either part of that implementation. His
suggestion then was to enable access in an undef instr handler rather
than an IPI. I think that would still work with this version.

Rob
