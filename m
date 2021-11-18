Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00ADE45537C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 04:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbhKRDkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 22:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242759AbhKRDke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 22:40:34 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436D1C061766
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 19:37:35 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id r26so11202492oiw.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 19:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hhREUrClrSZH2dV69k4dP6KEPon/EeosTqyONwAMhE8=;
        b=h/yswSEAHXoaF3XDllZ4EdSdNP33Ep69dECFNQYXbaRditDnzLEo4TqssOXwXaj32t
         AQbthw/p59KIuAXL4ARg13SKPvyhy9L3f0xOD5gOCeUgH2yhW5Sld7DZO/l1vZJvYeuX
         HyZKWIlMVm3NHv2MzlGheO9/AfcspzqI4FZKmksdlHWttWg0bGRVHaeSBK6pxvhVMNXz
         aZGNnsDzqCFs9fqr8r7Bhi4w260aA2dLIo7sQIkIWAWBnBB3ZhqW+vF+SETeXiz3Zl+6
         joWHQZDSV6OE/Zy5IaoUSvoVXbH1K6NdRUwO9CgmBpyv1cR5B5V9pqD2M5CnhYFkM9Xo
         HBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hhREUrClrSZH2dV69k4dP6KEPon/EeosTqyONwAMhE8=;
        b=T6zvIbPM6WICPb4ZqMtZ8Da5bVg3H5WMIHbanVRE7sZxQn9tvRlUOvUFHjikTiUY8z
         Bx8oEhEqOc0Epqs79lZgmg2Vzsm4Fdgh5zPhJpszWZU/1Azm5WLma5BlGMo0iULyhRhF
         mokXYaD7epQHUnULtpNH+x9RcDdLzdMCf8gt69s2yBDrq10fkUIPbNmlIGU+fZDQNxiS
         71d4UkxRz6+rn6OxCb+HzmUK2XEqO1hhnGGsRi8QBOWCbEZ/2qFtZECNGrR9tO5+HJW5
         MpyfDR3JyZKWn0h5igioTAW4xomgQCs86ADV9l5mNOaIm2JCVgcZ2rFhxUV4h1vR8AYt
         sfiA==
X-Gm-Message-State: AOAM533TdreBy2VG+36ZV20Z85GKO9nPpaRYo4LtIPttVt2ex+HVEbay
        cNBiIU9R6Q33sStkoHOFtILK089hE4tsz0xL2w58GQ==
X-Google-Smtp-Source: ABdhPJw6R6EijKAAU+9v2Nbg4ShYSOpnsofIgXJ09MpaMRaqAeT1b23OwC/u1/kbpmjWdUSdyH+SvqaRgHaRjcNrlFQ=
X-Received: by 2002:aca:3055:: with SMTP id w82mr4614339oiw.2.1637206653715;
 Wed, 17 Nov 2021 19:37:33 -0800 (PST)
MIME-Version: 1.0
References: <20211112235235.1125060-1-jmattson@google.com> <20211112235235.1125060-2-jmattson@google.com>
 <fcb9aea5-2cf5-897f-5a3d-054ead555da4@gmail.com> <CALMp9eR5oi=ZrrEsZpcAJ7AP-Jo2cLGz9GA=SoTjX--TiG4=sw@mail.gmail.com>
 <afb108ed-a2f3-cb49-d0b4-b1bd6739cdb6@gmail.com> <CALMp9eSYvGW=EfuDCyc+fu7gVNnKHmEvFMackYcuZ-sGT8H5uA@mail.gmail.com>
In-Reply-To: <CALMp9eSYvGW=EfuDCyc+fu7gVNnKHmEvFMackYcuZ-sGT8H5uA@mail.gmail.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 17 Nov 2021 19:37:22 -0800
Message-ID: <CALMp9eTq2NwhB5cq_LknUjJncKHK2xPuQ5vpTaDN_zCDPT_JWw@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: x86: Update vPMCs when retiring instructions
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     "Paolo Bonzini - Distinguished Engineer (kernel-recipes.org)" 
        <pbonzini@redhat.com>, Eric Hankland <ehankland@google.com>,
        kvm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Peter Zijlstra (Intel OTC, Netherlander)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 12:01 PM Jim Mattson <jmattson@google.com> wrote:
>
> On Tue, Nov 16, 2021 at 7:22 PM Like Xu <like.xu.linux@gmail.com> wrote:
> >
> > On 17/11/2021 6:15 am, Jim Mattson wrote:
> > > On Tue, Nov 16, 2021 at 4:44 AM Like Xu <like.xu.linux@gmail.com> wrote:
> > >>
> > >> Hi Jim,
> > >>
> > >> On 13/11/2021 7:52 am, Jim Mattson wrote:
> > >>> When KVM retires a guest instruction through emulation, increment any
> > >>> vPMCs that are configured to monitor "instructions retired," and
> > >>> update the sample period of those counters so that they will overflow
> > >>> at the right time.
> > >>>
> > >>> Signed-off-by: Eric Hankland <ehankland@google.com>
> > >>> [jmattson:
> > >>>     - Split the code to increment "branch instructions retired" into a
> > >>>       separate commit.
> > >>>     - Added 'static' to kvm_pmu_incr_counter() definition.
> > >>>     - Modified kvm_pmu_incr_counter() to check pmc->perf_event->state ==
> > >>>       PERF_EVENT_STATE_ACTIVE.
> > >>> ]
> > >>> Signed-off-by: Jim Mattson <jmattson@google.com>
> > >>> Fixes: f5132b01386b ("KVM: Expose a version 2 architectural PMU to a guests")
> > >>> ---
> > >>>    arch/x86/kvm/pmu.c | 31 +++++++++++++++++++++++++++++++
> > >>>    arch/x86/kvm/pmu.h |  1 +
> > >>>    arch/x86/kvm/x86.c |  3 +++
> > >>>    3 files changed, 35 insertions(+)
> > >>>
> > >>> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> > >>> index 09873f6488f7..153c488032a5 100644
> > >>> --- a/arch/x86/kvm/pmu.c
> > >>> +++ b/arch/x86/kvm/pmu.c
> > >>> @@ -490,6 +490,37 @@ void kvm_pmu_destroy(struct kvm_vcpu *vcpu)
> > >>>        kvm_pmu_reset(vcpu);
> > >>>    }
> > >>>
> > >>> +static void kvm_pmu_incr_counter(struct kvm_pmc *pmc, u64 evt)
> > >>> +{
> > >>> +     u64 counter_value, sample_period;
> > >>> +
> > >>> +     if (pmc->perf_event &&
> > >>
> > >> We need to incr pmc->counter whether it has a perf_event or not.
> > >>
> > >>> +         pmc->perf_event->attr.type == PERF_TYPE_HARDWARE &&
> > >>
> > >> We need to cover PERF_TYPE_RAW as well, for example,
> > >> it has the basic bits for "{ 0xc0, 0x00, PERF_COUNT_HW_INSTRUCTIONS },"
> > >> plus HSW_IN_TX or ARCH_PERFMON_EVENTSEL_EDGE stuff.
> > >>
> > >> We just need to focus on checking the select and umask bits:
> > >
> > > [What follows applies only to Intel CPUs. I haven't looked at AMD's
> > > PMU implementation yet.]
> >
> > x86 has the same bit definition and semantics on at least the select and umask bits.
>
> Yes, but AMD supports 12 bits of event selector. AMD also has the
> HG_ONLY bits, which affect whether or not to count the event based on
> context.

It looks like we already have an issue with event selector truncation
on the AMD side. It's not clear from the APM if AMD has always had a
12-bit event selector field, but it's 12 bits now. Milan, for example,
has at least 6 different events with selectors > 255. I don't see how
a guest could monitor those events with the existing KVM
implementation.
