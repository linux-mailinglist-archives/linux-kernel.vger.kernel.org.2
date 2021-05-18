Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021F8387C76
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 17:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245024AbhERP3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 11:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240041AbhERP3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 11:29:43 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AD1C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 08:28:24 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id p20so12078558ljj.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 08:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lpRvF+xJ/4IcCek+cggWbs10JI8lkpvOBQ+cLldKIIU=;
        b=Q1Xn+dOVy2cUeeM8Q6YEGcIaBmPSenlSExzNe2VV+Ln/RroRbTMnsUCBvrEa/4S8Kp
         P3LjSGgIiWdAnedCndCWvTmNhyI87HcaxrqU8ZpeKW8TuQo1fM5Gnhh4pC34MYbg0TYb
         HbTEL+hzqTlFdDlvjpvcsnkjp5uzkmNDy5aFP8Cftwi4ZCywZK0gYCmfeGR0Kooi3v1R
         vnPb+61q6NDDFoPO7PIMziu5DMaTjRae5PR+l+pobPndB43tBo2pI6sVhAURhcvX/cgj
         HJNpSggF6E+TaIOPX2LPVNoTjGs0NJhQoY5VILW0Dma5Hye49UvG8I92oxc9Al28YWu4
         sSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lpRvF+xJ/4IcCek+cggWbs10JI8lkpvOBQ+cLldKIIU=;
        b=jaMppizaVhhDLfJyWYkc2egtV+Ha5Zn2D9fdoi9RH3RyeLpfFqq1UqdBuDmwoCYrjS
         cj/tED24UhVLnWJkRgh9Ci1lYITHp/Uk76P8jtKxqXnGi4128O+cwPpja6a89fubZhTM
         qUm2fHgJMII9RHcJdiAPttaMX6RvdLvNBsu8JIC/G6P1uTYx2xr9dV8Yg+XLk2ylwCVX
         kAi5psw4Jj9KITWwue4XZeab5AEUOh4sics5673paiLGSeq3dpJmLLnRHWL+rGnZOIZF
         vgpBpo0L4W4UpKKgsDajTZ+uUNJmmd0l+E0s8ob7Et+cHS5U6b+NK5FznDWE+VADZKEJ
         AGkg==
X-Gm-Message-State: AOAM533DjPhnbcLlI/Jrz/1eMQl7RBbo13E1/zm+Q/1FOt4ooKpicZbl
        aIR68TzSmjluX5vi22pQX3FkSiZbvJrO4u0wz5ROXg==
X-Google-Smtp-Source: ABdhPJymDaoBvxC1m+UFkPfPnTNc2aZzsYMub514jj8ualntwMLqVJIB2cXHIjK6mmXgmFBrDkEtHJNe3rGDCU93VC8=
X-Received: by 2002:a2e:9211:: with SMTP id k17mr4620637ljg.284.1621351702710;
 Tue, 18 May 2021 08:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <1621239831-5870-1-git-send-email-beata.michalska@arm.com>
 <1621239831-5870-2-git-send-email-beata.michalska@arm.com>
 <CAKfTPtAPcayjhedNWaL20rsaUQbxXFdEXAF8aqwd9YX5gLVbOQ@mail.gmail.com>
 <20210518142746.GA3993@e120325.cambridge.arm.com> <CAKfTPtAk8pQfpN7FrBqdOiSz2Ncby4ozXOgQvT_QZMX67-FRKA@mail.gmail.com>
 <20210518150947.GC3993@e120325.cambridge.arm.com>
In-Reply-To: <20210518150947.GC3993@e120325.cambridge.arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 18 May 2021 17:28:11 +0200
Message-ID: <CAKfTPtAYjzMfj3Uh=xjAeiOZtkb5iyPA72+ow+RXYtQq0mGNDA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] sched/core: Introduce SD_ASYM_CPUCAPACITY_FULL
 sched_domain flag
To:     Beata Michalska <beata.michalska@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 May 2021 at 17:09, Beata Michalska <beata.michalska@arm.com> wrote:
>
> On Tue, May 18, 2021 at 04:53:09PM +0200, Vincent Guittot wrote:
> > On Tue, 18 May 2021 at 16:27, Beata Michalska <beata.michalska@arm.com> wrote:
> > >
> > > On Tue, May 18, 2021 at 03:39:27PM +0200, Vincent Guittot wrote:
> > > > On Mon, 17 May 2021 at 10:24, Beata Michalska <beata.michalska@arm.com> wrote:
> > > > >
> > > > > Introducing new, complementary to SD_ASYM_CPUCAPACITY, sched_domain
> > > > > topology flag, to distinguish between shed_domains where any CPU
> > > > > capacity asymmetry is detected (SD_ASYM_CPUCAPACITY) and ones where
> > > > > a full range of CPU capacities is visible to all domain members
> > > > > (SD_ASYM_CPUCAPACITY_FULL).
> > > >
> > > > I'm not sure about what you want to detect:
> > > >
> > > > Is it a sched_domain level with a full range of cpu capacity, i.e.
> > > > with at least 1 min capacity and 1 max capacity ?
> > > > or do you want to get at least 1 cpu of each capacity ?
> > > That would be at least one CPU of each available capacity within given domain,
> > > so full -set- of available capacities within a domain.
> >
> > Would be good to add the precision.
> Will do.
> >
> > Although I'm not sure if that's the best policy compared to only
> > getting the range which would be far simpler to implement.
> > Do you have some topology example ?
>
> An example from second patch from the series:
>
> DIE      [                                ]
> MC       [                       ][       ]
>
> CPU       [0] [1] [2] [3] [4] [5]  [6] [7]
> Capacity  |.....| |.....| |.....|  |.....|
>              L       M       B        B

The one above , which is described in your patchset, works with the range policy

>
> Where:
>  arch_scale_cpu_capacity(L) = 512
>  arch_scale_cpu_capacity(M) = 871
>  arch_scale_cpu_capacity(B) = 1024
>
> which could also look like:
>
> DIE      [                                        ]
> MC       [                       ][               ]
>
> CPU       [0] [1] [2] [3] [4] [5]  [6] [7] [8] [9]
> Capacity  |.....| |.....| |.....|  |.....| |.....|
>              L       M       B        L       B

I know that that HW guys can come with crazy idea but they would
probably add M  instead of L with B in the 2nd cluster as a boost of
performance at the cost of powering up another "cluster" in which case
the range policy works as well

>
> Considering only range would mean loosing the 2 (M) CPUs out of sight
> for feec in some cases.

Is it realistic ? Considering all the code and complexity added by
patch 2, will we really use it at the end ?

Regards,
Vincent
>
> ---
> BR.
> B
> >
> >
> >
> >
> >
> >
> > >
> > > ---
> > > BR
> > > B.
> > > >
> > > >
> > > > >
> > > > > With the distinction between full and partial CPU capacity asymmetry,
> > > > > brought in by the newly introduced flag, the scope of the original
> > > > > SD_ASYM_CPUCAPACITY flag gets shifted, still maintaining the existing
> > > > > behaviour when one is detected on a given sched domain, allowing
> > > > > misfit migrations within sched domains that do not observe full range
> > > > > of CPU capacities but still do have members with different capacity
> > > > > values. It loses though it's meaning when it comes to the lowest CPU
> > > > > asymmetry sched_domain level per-cpu pointer, which is to be now
> > > > > denoted by SD_ASYM_CPUCAPACITY_FULL flag.
> > > > >
> > > > > Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> > > > > Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> > > > > ---
> > > > >  include/linux/sched/sd_flags.h | 10 ++++++++++
> > > > >  1 file changed, 10 insertions(+)
> > > > >
> > > > > diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
> > > > > index 34b21e9..57bde66 100644
> > > > > --- a/include/linux/sched/sd_flags.h
> > > > > +++ b/include/linux/sched/sd_flags.h
> > > > > @@ -91,6 +91,16 @@ SD_FLAG(SD_WAKE_AFFINE, SDF_SHARED_CHILD)
> > > > >  SD_FLAG(SD_ASYM_CPUCAPACITY, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
> > > > >
> > > > >  /*
> > > > > + * Domain members have different CPU capacities spanning all unique CPU
> > > > > + * capacity values.
> > > > > + *
> > > > > + * SHARED_PARENT: Set from the topmost domain down to the first domain where
> > > > > + *               all available CPU capacities are visible
> > > > > + * NEEDS_GROUPS: Per-CPU capacity is asymmetric between groups.
> > > > > + */
> > > > > +SD_FLAG(SD_ASYM_CPUCAPACITY_FULL, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
> > > > > +
> > > > > +/*
> > > > >   * Domain members share CPU capacity (i.e. SMT)
> > > > >   *
> > > > >   * SHARED_CHILD: Set from the base domain up until spanned CPUs no longer share
> > > > > --
> > > > > 2.7.4
> > > > >
