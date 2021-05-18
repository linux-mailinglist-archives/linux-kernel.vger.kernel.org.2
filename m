Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F76387BB4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 16:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244053AbhEROyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 10:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235888AbhEROyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 10:54:40 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AB5C061756
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 07:53:21 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id p20so11925576ljj.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 07:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fjg3qZs5k6I/97/2j2zryLOYba1okHDNwQ2ngYD7gmk=;
        b=LwA0jhocjIDkDCwgZ0OZcCFjqpnw2V0xSzfMAlQdZAOQGIrV9GBnO70USBBEv9zO2k
         p1YwV1+5v/q5SkZCI7X0f7Qct9ZwFynXefhV7wgMQuGN8uPVmMcaKpj1ogQXCnEZSX2p
         umL8I2s1e72TiY9IHZhKiTpEqqmQ8sxRi9sp2qe05EiVa83+bYm7iYP26wYlPG3LT30H
         gPGcyAjAlD1WbZHZCMH7be0HJ1XvnFbh2+Y2INQgyy4h1Ur4FZWqqNhJ5aMBH6Sf4aaw
         OFyLgxcZNOia6IxyxagPfQ5pETOqRZXv0u16+7bssu4KpYF0GvOX5GQRYAqwICq3TZx7
         IYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fjg3qZs5k6I/97/2j2zryLOYba1okHDNwQ2ngYD7gmk=;
        b=BZpLDYcWXgp2J1nMZ+U3Z7Xh2SgpwawCXqSrn2g6aJbXjmzpkfJJ/k8F1qEVRs38PC
         8W5v3ft/BkUdEoVQ6/+1lMk5Mx+NN+Zh0BcugdgeLC36KGgAboITI1mrEa7mzCLPkkOK
         xlRzzkCXXXyytzy29jbkTz677V3Ip+AHYDClmwRu4e1uDfF/pKphONSL/Fn69o43XTpu
         Y1hcbT7zJ9yoGK72vP8ayMZ84XBLksc0fqVPUT9CCs05gnnSg9Ta5DbzL58jIpRBwUJP
         IXMNaLQAttATs7M8xb0BtlKAP4MOADmGUcErmFnipSQOgQbURlQWCpFjZ+Q8wRdvGeOS
         Q+AQ==
X-Gm-Message-State: AOAM532qGeYyOd5u5/fQfus4VjUPUFl+L7xMv9WJr4EvxWq1iGNDWXal
        c5YGbslacy3Cs82YR2HPowZ7nG8LfDl4Gqp8Z2vJxg==
X-Google-Smtp-Source: ABdhPJzhydDaPkWDHaSpy2SL65NK6UM4/v57GFX517EaIpLAtdVeYSjHYQ1qhXwE039MUtgV59sTM9MdqCr3KqMiCyQ=
X-Received: by 2002:a2e:8557:: with SMTP id u23mr4357444ljj.221.1621349600234;
 Tue, 18 May 2021 07:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <1621239831-5870-1-git-send-email-beata.michalska@arm.com>
 <1621239831-5870-2-git-send-email-beata.michalska@arm.com>
 <CAKfTPtAPcayjhedNWaL20rsaUQbxXFdEXAF8aqwd9YX5gLVbOQ@mail.gmail.com> <20210518142746.GA3993@e120325.cambridge.arm.com>
In-Reply-To: <20210518142746.GA3993@e120325.cambridge.arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 18 May 2021 16:53:09 +0200
Message-ID: <CAKfTPtAk8pQfpN7FrBqdOiSz2Ncby4ozXOgQvT_QZMX67-FRKA@mail.gmail.com>
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

On Tue, 18 May 2021 at 16:27, Beata Michalska <beata.michalska@arm.com> wrote:
>
> On Tue, May 18, 2021 at 03:39:27PM +0200, Vincent Guittot wrote:
> > On Mon, 17 May 2021 at 10:24, Beata Michalska <beata.michalska@arm.com> wrote:
> > >
> > > Introducing new, complementary to SD_ASYM_CPUCAPACITY, sched_domain
> > > topology flag, to distinguish between shed_domains where any CPU
> > > capacity asymmetry is detected (SD_ASYM_CPUCAPACITY) and ones where
> > > a full range of CPU capacities is visible to all domain members
> > > (SD_ASYM_CPUCAPACITY_FULL).
> >
> > I'm not sure about what you want to detect:
> >
> > Is it a sched_domain level with a full range of cpu capacity, i.e.
> > with at least 1 min capacity and 1 max capacity ?
> > or do you want to get at least 1 cpu of each capacity ?
> That would be at least one CPU of each available capacity within given domain,
> so full -set- of available capacities within a domain.

Would be good to add the precision.

Although I'm not sure if that's the best policy compared to only
getting the range which would be far simpler to implement.
Do you have some topology example ?






>
> ---
> BR
> B.
> >
> >
> > >
> > > With the distinction between full and partial CPU capacity asymmetry,
> > > brought in by the newly introduced flag, the scope of the original
> > > SD_ASYM_CPUCAPACITY flag gets shifted, still maintaining the existing
> > > behaviour when one is detected on a given sched domain, allowing
> > > misfit migrations within sched domains that do not observe full range
> > > of CPU capacities but still do have members with different capacity
> > > values. It loses though it's meaning when it comes to the lowest CPU
> > > asymmetry sched_domain level per-cpu pointer, which is to be now
> > > denoted by SD_ASYM_CPUCAPACITY_FULL flag.
> > >
> > > Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> > > Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> > > ---
> > >  include/linux/sched/sd_flags.h | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
> > > index 34b21e9..57bde66 100644
> > > --- a/include/linux/sched/sd_flags.h
> > > +++ b/include/linux/sched/sd_flags.h
> > > @@ -91,6 +91,16 @@ SD_FLAG(SD_WAKE_AFFINE, SDF_SHARED_CHILD)
> > >  SD_FLAG(SD_ASYM_CPUCAPACITY, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
> > >
> > >  /*
> > > + * Domain members have different CPU capacities spanning all unique CPU
> > > + * capacity values.
> > > + *
> > > + * SHARED_PARENT: Set from the topmost domain down to the first domain where
> > > + *               all available CPU capacities are visible
> > > + * NEEDS_GROUPS: Per-CPU capacity is asymmetric between groups.
> > > + */
> > > +SD_FLAG(SD_ASYM_CPUCAPACITY_FULL, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
> > > +
> > > +/*
> > >   * Domain members share CPU capacity (i.e. SMT)
> > >   *
> > >   * SHARED_CHILD: Set from the base domain up until spanned CPUs no longer share
> > > --
> > > 2.7.4
> > >
