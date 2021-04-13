Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5306035D885
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 09:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhDMHLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 03:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhDMHLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 03:11:04 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B904AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 00:10:44 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id r8so25556623lfp.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 00:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v9FRv+BSyLXBPF4PpQQH/o+ADSo7dCk0iAUv3EspJDU=;
        b=c1l8+6FEclvJWP67sekGDY0rEeEbcWi8oSJaEhTsC+KGoNmwQGHFmVTUcm90Z7uVx+
         6wErS/35D0yDPJrH8sXsvtrKkuUKQwklo3zIpmlaBUN0DmH2UusXfQkDiZoZmoRtQeEX
         9vqBKViYKGupGnblthu+5O8RDWGDQO+C2SP7l93y6dZnccov7siOtI599iYhscrDjDwu
         7N/2H0R5kZIpisFhHH1zwDnyJewRcSd3NfnQETzI98EKuHdeibjMuQO36Zh1WklSnG3N
         bRFS+bXQjXab+DkFgHZFevIDKNy/p7k/HKF2Ty3ssnWpH6ifZPoRGuqSGzrnBdhD6Z6V
         SyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v9FRv+BSyLXBPF4PpQQH/o+ADSo7dCk0iAUv3EspJDU=;
        b=aVpZ5x3mrhMj1RecYyRTYezHJykGsXIx0NKDkbEOn5twPYD0wjtf1T9PIhAnZDDu9B
         qQQ7a6WhkhBBznPlE+90KiDF7RQ+prFFVkiBf4MQKxw3oB3aFXRoIrUVce+QsOYwB7Yl
         6kuKGLqr7jmd5WQqtcglB8QJJgDecW21FD1ThH2iz6KU70shF+j3QNjJFqSn/1fDlOPj
         7JNxNnU86GCNQ0pF24h8NUsl3f6YjOy66U4z0LwhckaPAZgRkdcBanRiekpEPAzxSLaR
         1OmagFa3s50yP+O+pfNw97/Eo2E4BgpNkMYi55fakzhpxemxqdEXNdlNBS/zMFT7Bz3E
         Xzqw==
X-Gm-Message-State: AOAM531DVovLg2oAQ6TawpSmcpGdUCvXnhSYw4nh/fUpNhNWlt4mnyHs
        FNp8vFAu85TX/jm7I/wKTs6BJNugQHNssEnJG1Bxuw==
X-Google-Smtp-Source: ABdhPJwb5xuCcOasc2Mz2bGUZr1Qtm/1SPcB5Y+duFeKCwYx+TagcRsU8lMSRelzE1z7969v2v8KGKtE2QW8oKxKSWA=
X-Received: by 2002:ac2:5986:: with SMTP id w6mr6945656lfn.470.1618297842711;
 Tue, 13 Apr 2021 00:10:42 -0700 (PDT)
MIME-Version: 1.0
References: <1617341874-1205-1-git-send-email-ego@linux.vnet.ibm.com>
 <20210412062436.GB2633526@linux.vnet.ibm.com> <20210412093722.GS3697@techsingularity.net>
 <CAKfTPtDX-p=gWAVgYzLNCNuQ2e=QP2pTeMs=BmNBo31fpGKxrg@mail.gmail.com> <20210412152444.GA3697@techsingularity.net>
In-Reply-To: <20210412152444.GA3697@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 13 Apr 2021 09:10:31 +0200
Message-ID: <CAKfTPtDTyyrqBymQx16P+uhQKZkCyCNvDtEebG7FX5Emh=kkCg@mail.gmail.com>
Subject: Re: [RFC/PATCH] powerpc/smp: Add SD_SHARE_PKG_RESOURCES flag to MC sched-domain
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Rik van Riel <riel@surriel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Parth Shah <parth@linux.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Apr 2021 at 17:24, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Mon, Apr 12, 2021 at 02:21:47PM +0200, Vincent Guittot wrote:
> > > > Peter, Valentin, Vincent, Mel, etal
> > > >
> > > > On architectures where we have multiple levels of cache access latencies
> > > > within a DIE, (For example: one within the current LLC or SMT core and the
> > > > other at MC or Hemisphere, and finally across hemispheres), do you have any
> > > > suggestions on how we could handle the same in the core scheduler?
> >
> > I would say that SD_SHARE_PKG_RESOURCES is there for that and doesn't
> > only rely on cache
> >
>
> From topology.c
>
>         SD_SHARE_PKG_RESOURCES - describes shared caches
>
> I'm guessing here because I am not familiar with power10 but the central
> problem appears to be when to prefer selecting a CPU sharing L2 or L3
> cache and the core assumes the last-level-cache is the only relevant one.
>
> For this patch, I wondered if setting SD_SHARE_PKG_RESOURCES would have
> unintended consequences for load balancing because load within a die may
> not be spread between SMT4 domains if SD_SHARE_PKG_RESOURCES was set at
> the MC level.

But the SMT4 level is still present  here with select_idle_core taking
of the spreading

>
> > >
> > > Minimally I think it would be worth detecting when there are multiple
> > > LLCs per node and detecting that in generic code as a static branch. In
> > > select_idle_cpu, consider taking two passes -- first on the LLC domain
> > > and if no idle CPU is found then taking a second pass if the search depth
> >
> > We have done a lot of changes to reduce and optimize the fast path and
> > I don't think re adding another layer  in the fast path makes sense as
> > you will end up unrolling the for_each_domain behind some
> > static_banches.
> >
>
> Searching the node would only happen if a) there was enough search depth
> left and b) there were no idle CPUs at the LLC level. As no new domain
> is added, it's not clear to me why for_each_domain would change.

What I mean is that you should directly do for_each_sched_domain in
the fast path because that what you are proposing at the end. It's no
more looks like a fast path but a traditional LB

>
> But still, your comment reminded me that different architectures have
> different requirements
>
> Power 10 appears to prefer CPU selection sharing L2 cache but desires
>         spillover to L3 when selecting and idle CPU.
>
> X86 varies, it might want the Power10 approach for some families and prefer
>         L3 spilling over to a CPU on the same node in others.
>
> S390 cares about something called books and drawers although I've no
>         what it means as such and whether it has any preferences on
>         search order.
>
> ARM has similar requirements again according to "scheduler: expose the
>         topology of clusters and add cluster scheduler" and that one *does*
>         add another domain.
>
> I had forgotten about the ARM patches but remembered that they were
> interesting because they potentially help the Zen situation but I didn't
> get the chance to review them before they fell off my radar again. About
> all I recall is that I thought the "cluster" terminology was vague.
>
> The only commonality I thought might exist is that architectures may
> like to define what the first domain to search for an idle CPU and a
> second domain. Alternatively, architectures could specify a domain to
> search primarily but also search the next domain in the hierarchy if
> search depth permits. The default would be the existing behaviour --
> search CPUs sharing a last-level-cache.
>
> > SD_SHARE_PKG_RESOURCES should be set to the last level where we can
> > efficiently move task between CPUs at wakeup
> >
>
> The definition of "efficiently" varies. Moving tasks between CPUs sharing
> a cache is most efficient but moving the task to a CPU that at least has
> local memory channels is a reasonable option if there are no idle CPUs
> sharing cache and preferable to stacking.

That's why setting SD_SHARE_PKG_RESOURCES for P10 looks fine to me.
This last level of SD_SHARE_PKG_RESOURCES should define the cpumask to
be considered  in fast path

>
> > > allows within the node with the LLC CPUs masked out. While there would be
> > > a latency hit because cache is not shared, it would still be a CPU local
> > > to memory that is idle. That would potentially be beneficial on Zen*
> > > as well without having to introduce new domains in the topology hierarchy.
> >
> > What is the current sched_domain topology description for zen ?
> >
>
> The cache and NUMA topologies differ slightly between each generation
> of Zen. The common pattern is that a single NUMA node can have multiple
> L3 caches and at one point I thought it might be reasonable to allow
> spillover to select a local idle CPU instead of stacking multiple tasks
> on a CPU sharing cache. I never got as far as thinking how it could be
> done in a way that multiple architectures would be happy with.
>
> --
> Mel Gorman
> SUSE Labs
