Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECEF358CC5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 20:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbhDHSiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 14:38:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:44230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231676AbhDHSin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 14:38:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 050CA6113A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 18:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617907112;
        bh=eFzHf51U5luHJHHIT+EzCxofnc4C9Q/qr5YD8mH+tzY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fUsuCezIVkzXoG1q+ZJJu4tDezH+CxpEFLjbyNib4Ui5VwMBLpxWeAfoE/v4VlW5e
         FGd+Sz6TtKJphj7XD8tPK8wnZhS2NeTdkPcq+NW++5pc01XzrjmiQm9jh9rjf9AnU4
         lDR+mzSIgzx6Wlwb6VrWY54IGene5wPHFlop6W08uopaFCJ9bE+vuGWD3caXkoDaps
         8mAJNuXXk/9DVbHMem7g9NE/h3KbokSZD4ZHSR4Ffz221Ccijv7tiBEi8elcvK09Wt
         yeBQXOu2h/Yd33iltrDITLJLG2lfpI4VVf7+iE5pQOzN4dSBhIoq97CTRo8FL48VXs
         YkQBgIU7Ccflg==
Received: by mail-ed1-f51.google.com with SMTP id m3so3624399edv.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 11:38:31 -0700 (PDT)
X-Gm-Message-State: AOAM531r5bfxCUQ6xGj9rPFUzX7YJ7z4We9KYmWUtIgLyKw64v+AvH2I
        ToqDUqz5h35M2j9S007REG+42S+DPIS5JHqfKw==
X-Google-Smtp-Source: ABdhPJwQVvZUqQi3NeevrsgJYQi6WLV6Puz9Ne7f37tq3Sbjx6Eg1zWhV0JxTnYmzfs+ZNNx5mMqYWFmY3YymbBRjKU=
X-Received: by 2002:a50:fd12:: with SMTP id i18mr7719021eds.137.1617907110474;
 Thu, 08 Apr 2021 11:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210311000837.3630499-1-robh@kernel.org> <20210311000837.3630499-3-robh@kernel.org>
 <20210330153125.GC6567@willie-the-truck> <CAL_JsqKN4=T4tHofEoBoWVEZSQEj_m=561_kEdEEkz5szHszhQ@mail.gmail.com>
 <20210331160059.GD7815@willie-the-truck> <CAL_Jsq+ga_-5=UBTAn4eGhpL6j2aWFVh9CdxR4XSG7WpYfxNsA@mail.gmail.com>
 <20210407124437.GA15622@willie-the-truck> <20210408110800.GA32792@C02TD0UTHF1T.local>
In-Reply-To: <20210408110800.GA32792@C02TD0UTHF1T.local>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 8 Apr 2021 13:38:17 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+H_asWWrHiCk-PBS8xDEGpBL1__dRyrPXdBYgRBBw2vA@mail.gmail.com>
Message-ID: <CAL_Jsq+H_asWWrHiCk-PBS8xDEGpBL1__dRyrPXdBYgRBBw2vA@mail.gmail.com>
Subject: Re: [PATCH v6 02/10] arm64: perf: Enable PMU counter direct access
 for perf event
To:     Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 8, 2021 at 6:08 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Wed, Apr 07, 2021 at 01:44:37PM +0100, Will Deacon wrote:
> > [Moving Mark to To: since I'd like his view on this]
> >
> > On Thu, Apr 01, 2021 at 02:45:21PM -0500, Rob Herring wrote:
> > > On Wed, Mar 31, 2021 at 11:01 AM Will Deacon <will@kernel.org> wrote:
> > > >
> > > > On Tue, Mar 30, 2021 at 12:09:38PM -0500, Rob Herring wrote:
> > > > > On Tue, Mar 30, 2021 at 10:31 AM Will Deacon <will@kernel.org> wrote:
> > > > > >
> > > > > > On Wed, Mar 10, 2021 at 05:08:29PM -0700, Rob Herring wrote:
> > > > > > > From: Raphael Gault <raphael.gault@arm.com>
>
> > > > > > > +static void armv8pmu_event_unmapped(struct perf_event *event, struct mm_struct *mm)
> > > > > > > +{
> > > > > > > +     struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
> > > > > > > +
> > > > > > > +     if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR))
> > > > > > > +             return;
> > > > > > > +
> > > > > > > +     if (atomic_dec_and_test(&mm->context.pmu_direct_access))
> > > > > > > +             on_each_cpu_mask(&armpmu->supported_cpus, refresh_pmuserenr, mm, 1);
> > > > > >
> > > > > > Given that the pmu_direct_access field is global per-mm, won't this go
> > > > > > wrong if multiple PMUs are opened by the same process but only a subset
> > > > > > are exposed to EL0? Perhaps pmu_direct_access should be treated as a mask
> > > > > > rather than a counter, so that we can 'and' it with the supported_cpus for
> > > > > > the PMU we're dealing with.
> > > > >
> > > > > It needs to be a count to support multiple events on the same PMU. If
> > > > > the event is not enabled for EL0, then we'd exit out on the
> > > > > ARMPMU_EL0_RD_CNTR check. So I think we're fine.
> > > >
> > > > I'm still not convinced; pmu_direct_access is shared between PMUs, so
> > > > testing the result of atomic_dec_and_test() just doesn't make sense to
> > > > me, as another PMU could be playing with the count.
> > >
> > > How is that a problem? Let's make a concrete example:
> > >
> > > map PMU1:event2 -> pmu_direct_access = 1 -> enable access
> > > map PMU2:event3 -> pmu_direct_access = 2
> > > map PMU1:event4 -> pmu_direct_access = 3
> > > unmap PMU2:event3 -> pmu_direct_access = 2
> > > unmap PMU1:event2 -> pmu_direct_access = 1
> > > unmap PMU1:event4 -> pmu_direct_access = 0 -> disable access
> > >
> > > The only issue I can see is PMU2 remains enabled for user access until
> > > the last unmap. But we're sharing the mm, so who cares? Also, in this
> > > scenario it is the user's problem to pin themselves to cores sharing a
> > > PMU. If the user doesn't do that, they get to keep the pieces.
> >
> > I guess I'm just worried about exposing the counters to userspace after
> > the PMU driver (or perf core?) thinks that they're no longer exposed in
> > case we leak other events.
>
> IMO that's not practically different from the single-PMU case (i.e.
> multi-PMU isn't material, either we have a concern with leaking or we
> don't); more on that below.
>
> While it looks odd to place this on the mm, I don't think it's the end
> of the world.
>
> > However, I'm not sure how this is supposed to work normally: what
> > happens if e.g. a privileged user has a per-cpu counter for a kernel
> > event while a task has a counter with direct access -- can that task
> > read the kernel event out of the PMU registers from userspace?
>
> Yes -- userspace could go read any counters even though it isn't
> supposed to, and could potentially infer information from those. It
> won't have access to the config registers or kernel data structures, so
> it isn't guaranteed to know what the even is or when it is
> context-switched/reprogrammed/etc.
>
> If we believe that's a problem, then it's difficult to do anything
> robust other than denying userspace access entirely, since disabling
> userspace access while in use would surprise applications, and denying
> privileged events would need some global state that we consult at event
> creation time (in addition to being an inversion of privilege).
>
> IIRC there was some fuss about this a while back on x86; I'll go dig and
> see what I can find, unless Peter has a memory...

Maybe this one[1].

Rob

[1] https://lore.kernel.org/lkml/20200730123815.18518-1-kan.liang@linux.intel.com/
