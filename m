Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A213505D0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 19:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbhCaRw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 13:52:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234488AbhCaRwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 13:52:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68C5860FE7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 17:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617213149;
        bh=ayKG6mUBriU17I0iDGqWv7Oi2o4ULqZPjn2xMzzGFnk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QWoP0EkZJhTDfTGypiUAL2nr0WT9ng2wy1XNzmBkSCsSJkQbJnDv2Iya1nS9uTrtF
         e2gLNYzdFFM2m29z5SoeLa7YiriQ86zYWVQqSETHz2UqOIODaqx4MNpqJG02yaTDYM
         Twjp3NTxrqCgS9KYM325lu81sCGwaKeqyM/jYPxOi4iLNOwpoJmRmMjb8vXC+SPKnp
         YNT3KwMRflg9mEE2iqeDbPBHi3kLlsWy164Qu3TxPKtzch1ad5QMUlC2fnINfdMuO1
         8ud2JQp39yhNvZCRl9GEc0GuU3oMwuWzvDVfrsc9BwexN5zR015j5/fOhBYKuIT9IB
         TenCmRz5U46eg==
Received: by mail-ej1-f41.google.com with SMTP id kt15so31316926ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 10:52:29 -0700 (PDT)
X-Gm-Message-State: AOAM531LJbo1xJMWJE107MDx1BI3Dj33ZoRY1lENJHneFiqXsWSmvGyR
        OPw8oiQ32ahNm51nPse79ASC0OBJT5us2DJZwg==
X-Google-Smtp-Source: ABdhPJw8h1ci3XZ2ZtDIwtciO417SjPRvKp9Qzjn3Jm22to61Y/pyviT/KngGC0X5C395xNo+8CbBZX5HYI2xShd4zo=
X-Received: by 2002:a17:906:7806:: with SMTP id u6mr4568705ejm.130.1617213147968;
 Wed, 31 Mar 2021 10:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210311000837.3630499-1-robh@kernel.org> <20210311000837.3630499-3-robh@kernel.org>
 <20210330153125.GC6567@willie-the-truck> <CAL_JsqKN4=T4tHofEoBoWVEZSQEj_m=561_kEdEEkz5szHszhQ@mail.gmail.com>
 <CAL_JsqKqKKb8uXSxQKT4ZMqMv8dt3ABpP+T8x+A1-zb2RKjCNA@mail.gmail.com> <20210331153845.GB7815@willie-the-truck>
In-Reply-To: <20210331153845.GB7815@willie-the-truck>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 31 Mar 2021 12:52:11 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJMpZWTsFNaobURocdTWoWa37U1bHYZKxQOZZnYZvBrdA@mail.gmail.com>
Message-ID: <CAL_JsqJMpZWTsFNaobURocdTWoWa37U1bHYZKxQOZZnYZvBrdA@mail.gmail.com>
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

On Wed, Mar 31, 2021 at 10:38 AM Will Deacon <will@kernel.org> wrote:
>
> On Tue, Mar 30, 2021 at 04:08:11PM -0500, Rob Herring wrote:
> > On Tue, Mar 30, 2021 at 12:09 PM Rob Herring <robh@kernel.org> wrote:
> > > On Tue, Mar 30, 2021 at 10:31 AM Will Deacon <will@kernel.org> wrote:
> > > > The logic here feels like it
> > > > could with a bit of untangling.
> > >
> > > Yes, I don't love it, but couldn't come up with anything better. It is
> > > complicated by the fact that flags have to be set before we assign the
> > > counter and can't set/change them when we assign the counter. It would
> > > take a lot of refactoring with armpmu code to fix that.
> >
> > How's this instead?:
> >
> > if (armv8pmu_event_want_user_access(event) || !armv8pmu_event_is_64bit(event))
> >         event->hw.flags |= ARMPMU_EL0_RD_CNTR;
> >
> > /*
> > * At this point, the counter is not assigned. If a 64-bit counter is
> > * requested, we must make sure the h/w has 64-bit counters if we set
> > * the event size to 64-bit because chaining is not supported with
> > * userspace access. This may still fail later on if the CPU cycle
> > * counter is in use.
> > */
> > if (armv8pmu_event_is_64bit(event) &&
> >     (!armv8pmu_event_want_user_access(event) ||
> >      armv8pmu_has_long_event(cpu_pmu) || (hw_event_id ==
> > ARMV8_PMUV3_PERFCTR_CPU_CYCLES)))
> >         event->hw.flags |= ARMPMU_EVT_64BIT;
>
> I thought there were some cases where we could assign cycles event to an
> event counter; does that not happen anymore?

Yes, but if we hit that scenario when the user has asked for 64-bit
user access, then we return an error later when assigning the counter.
I think we can assume if users have gone to the trouble of requesting
64-bit counters, then they can deal with ensuring they don't have
multiple users.

Otherwise, the only way I see to simplify this is we only support
64-bit counters in userspace when we have v8.5 PMU.

Rob
