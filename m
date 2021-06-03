Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7884039A5EE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 18:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhFCQmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 12:42:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229719AbhFCQmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 12:42:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E41B0613F9
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 16:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622738457;
        bh=DZ7wEU9QOU96tbC6StRBlgGMxmr8AzLKxGBZpB0fIe0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AXBK3pdGsVLPmwbwo32dY/Dyfr1XI9QaQYgb65BltbRFRJcT9n9bXsya6dlVjsuYl
         EITaBSSlmDSR1nF93cvYS4Hb97+rJSQPsKXZU8bi0Gsv/aPC/jgoXVXhVetT6kstiR
         J3IPWjiyJw+jrVNouBJVPeec6fvbJeRAnJSVgc+VSAmhqxYPk6Srf/jB1H8p/4bxe/
         VcVE0vawMKBFdznpOamji3Qqcq/UA8ehD0BlXBzZ+NTk/31DrB3esgt046wEDRQQDu
         fE00RA7/Iw/sDqcFuGziFGYPWqE1j14uhHqFHG0qrTO096HBA3qy1oR6jrOdfn1Eq0
         5LqWHycZ3uA+Q==
Received: by mail-ej1-f53.google.com with SMTP id k25so4699510eja.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 09:40:57 -0700 (PDT)
X-Gm-Message-State: AOAM533GbMrA8H2S6tuwBsjbR6PNNOUaJvYQr0ei2kccgz8vhiny9Uag
        ODwfXp11qkeEYMFGawjegJzAW/808DWK0xvnGQ==
X-Google-Smtp-Source: ABdhPJzUxtg2E0qG2ooQeqqXPB4wNwvJpq85StCbQD5ND/sKCbPX2iWtOgoTxOLgxfrzW64wPGdr2zYVVXdmMeXF5us=
X-Received: by 2002:a17:906:a110:: with SMTP id t16mr267460ejy.360.1622738456363;
 Thu, 03 Jun 2021 09:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210517195405.3079458-1-robh@kernel.org> <20210517195405.3079458-4-robh@kernel.org>
 <20210601135526.GA3326@C02TD0UTHF1T.local> <CAL_JsqKo2cQsWkG67HUDgyO=WXywzykM+UY4uOwdpA6FVZsc0A@mail.gmail.com>
 <20210601171159.GD3326@C02TD0UTHF1T.local>
In-Reply-To: <20210601171159.GD3326@C02TD0UTHF1T.local>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 3 Jun 2021 11:40:44 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJpFriF9UWJz-i1F8SiSn2kYXWEHVe8O9MSHtQR70xUbg@mail.gmail.com>
Message-ID: <CAL_JsqJpFriF9UWJz-i1F8SiSn2kYXWEHVe8O9MSHtQR70xUbg@mail.gmail.com>
Subject: Re: [PATCH v8 3/5] arm64: perf: Enable PMU counter userspace access
 for perf event
To:     Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
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

On Tue, Jun 1, 2021 at 12:12 PM Mark Rutland <mark.rutland@arm.com> wrote:
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

Ah yeah, those would still be exposed, but that would only tell the
task someone is watching them. Though I guess the task could write
those counters and corrupt the data.

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

Looks like that will take some work in the core to get
event_function_call to be called in this case.

A much more simple solution is simply not enabling/disabling user
access on mmap/unmap. That was added along the way for x86, but I
don't think that buys us much given the departure from x86
implementation. We already have to enable the feature via sysctl (as
Will wants it default off) and the open has to request user access. If
a task succeeded in opening the event, is there any scenario where it
can't mmap its event? If so, could that condition not also be checked
in open?

Rob
