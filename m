Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDDB434F2C8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 23:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbhC3VIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 17:08:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:33698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230125AbhC3VIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:08:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EDC08619C5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 21:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617138504;
        bh=EfaVkmECL99LjE1GBi1qyVo83qG2SVDQjHaRutFWP0o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f8RRuS+HnMl60xMQy17BAfl/cBhvSX4suSx+9ocyuftDHZ5xbVLfQtamsdRugRKv/
         NQTfuHlML26dRaMBXqqWsX88Iov7iQ8LeHfIt4rA9J86G1TQKe7IgEbo9BAJmmSgrX
         tR5lI4IZ52gfFTY07CtU8RpsppdbVqsmK2Ro+VjmkhD33ND4q3QZw9t12HgR0NanRw
         d9WZ2jZyEmhGztDCaULUpiMCVZVl/NHADdCLsZF0f7sId6r1euuSbgbeQy+wZqLZmA
         063Zo9FyIZjTNgei5Azb6/F9/hzvyGIG7aZ064yiQ6lbvKEdpUFsoPA43NWZBFHZES
         j+B7x4gATIrrQ==
Received: by mail-qk1-f175.google.com with SMTP id v70so17334452qkb.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 14:08:23 -0700 (PDT)
X-Gm-Message-State: AOAM5322odDF8NWeLzYKykKUiTdaWAvAmOD7RzsjBCrBzgfCi+aQpqgi
        H53W7cd6X9Rp1mtLLD4UqTo78JtM5l7IWW33xA==
X-Google-Smtp-Source: ABdhPJz9TD/pM9pa1pJ4sadIoVyzSuRapbFz7ZtiFKT/fFlgnL0VRp1K18TT+vem1ZxGi6UqeZflLtuOA1lLBkmhP6E=
X-Received: by 2002:a37:d82:: with SMTP id 124mr158857qkn.311.1617138502980;
 Tue, 30 Mar 2021 14:08:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210311000837.3630499-1-robh@kernel.org> <20210311000837.3630499-3-robh@kernel.org>
 <20210330153125.GC6567@willie-the-truck> <CAL_JsqKN4=T4tHofEoBoWVEZSQEj_m=561_kEdEEkz5szHszhQ@mail.gmail.com>
In-Reply-To: <CAL_JsqKN4=T4tHofEoBoWVEZSQEj_m=561_kEdEEkz5szHszhQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 30 Mar 2021 16:08:11 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKqKKb8uXSxQKT4ZMqMv8dt3ABpP+T8x+A1-zb2RKjCNA@mail.gmail.com>
Message-ID: <CAL_JsqKqKKb8uXSxQKT4ZMqMv8dt3ABpP+T8x+A1-zb2RKjCNA@mail.gmail.com>
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

On Tue, Mar 30, 2021 at 12:09 PM Rob Herring <robh@kernel.org> wrote:
>
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

[...]

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
>
> > The logic here feels like it
> > could with a bit of untangling.
>
> Yes, I don't love it, but couldn't come up with anything better. It is
> complicated by the fact that flags have to be set before we assign the
> counter and can't set/change them when we assign the counter. It would
> take a lot of refactoring with armpmu code to fix that.

How's this instead?:

if (armv8pmu_event_want_user_access(event) || !armv8pmu_event_is_64bit(event))
        event->hw.flags |= ARMPMU_EL0_RD_CNTR;

/*
* At this point, the counter is not assigned. If a 64-bit counter is
* requested, we must make sure the h/w has 64-bit counters if we set
* the event size to 64-bit because chaining is not supported with
* userspace access. This may still fail later on if the CPU cycle
* counter is in use.
*/
if (armv8pmu_event_is_64bit(event) &&
    (!armv8pmu_event_want_user_access(event) ||
     armv8pmu_has_long_event(cpu_pmu) || (hw_event_id ==
ARMV8_PMUV3_PERFCTR_CPU_CYCLES)))
        event->hw.flags |= ARMPMU_EVT_64BIT;

> > > +             /*
> > > +              * At this point, the counter is not assigned. If a 64-bit
> > > +              * counter is requested, we must make sure the h/w has 64-bit
> > > +              * counters if we set the event size to 64-bit because chaining
> > > +              * is not supported with userspace access. This may still fail
> > > +              * later on if the CPU cycle counter is in use.
> > > +              */
> > > +             if (armv8pmu_event_is_64bit(event) &&
> > > +                 (armv8pmu_has_long_event(armpmu) ||
> > > +                  hw_event_id == ARMV8_PMUV3_PERFCTR_CPU_CYCLES))
> > > +                     event->hw.flags |= ARMPMU_EVT_64BIT;
> > > +     } else if (armv8pmu_event_is_64bit(event))
> > >               event->hw.flags |= ARMPMU_EVT_64BIT;
