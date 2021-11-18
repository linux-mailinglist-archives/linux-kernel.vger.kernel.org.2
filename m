Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0BA455B70
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 13:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344622AbhKRMYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 07:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344601AbhKRMX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 07:23:29 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2431C061570
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 04:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7Mc1mIWeVIb520Yf93FSRQoiFKTag2SI2WNlovSiJRo=; b=gn0VcZLVsi5yJB2CaDBIgetpwm
        I82ELxpb8BI13q/V+hbU3E9HMsAvuZ8tcrQVhouLIRdjnwfHpfqMRQudmdRSRLBGuvTGwBg5kdd4k
        B/qKiRi7uOy5W+Wyh+QkVj9uQ9XC7QURC9MWgzskbPjgByu8FP3ZY+t/fkW11cMAlEBC5KVykeVFK
        gn0Jcb+UWBooWCqFHk/KjzSF2nGjPgAKoGFswxbbSzHBYwLMk5TUtaZdJBjyNi6mux4vObforiMj8
        fx3EnvigbJr1Hgz0zE4xT+KrNE65BtjgGO0lC44YgGY1Cs8cM8bVmnnIg+WTOTySpnz6yK96OmTY2
        H2wT1fTw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mngOg-00GgiQ-Kw; Thu, 18 Nov 2021 12:20:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 45B1D300243;
        Thu, 18 Nov 2021 13:20:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 246092D3CA545; Thu, 18 Nov 2021 13:20:09 +0100 (CET)
Date:   Thu, 18 Nov 2021 13:20:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, kim.phillips@amd.com,
        acme@redhat.com, jolsa@redhat.com, songliubraving@fb.com,
        mpe@ellerman.id.au, maddy@linux.ibm.com
Subject: Re: [PATCH v2 03/13] perf/x86/amd: add AMD Fam19h Branch Sampling
 support
Message-ID: <YZZE+bPCokVrTARM@hirez.programming.kicks-ass.net>
References: <20211111084415.663951-1-eranian@google.com>
 <20211111084415.663951-4-eranian@google.com>
 <YY6QBXs0sM16DdbV@hirez.programming.kicks-ass.net>
 <CABPqkBShSBaJH+PR6rMkRRzjZAKN5zPhcdnLWx=4a-yQWxcA2A@mail.gmail.com>
 <20211116082923.GX174703@worktop.programming.kicks-ass.net>
 <CABPqkBQ4BCswvNPpkO79dBamhudikz1cGCXFpwAp9xsTb3F8xQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBQ4BCswvNPpkO79dBamhudikz1cGCXFpwAp9xsTb3F8xQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 11:23:39PM -0800, Stephane Eranian wrote:
> On Tue, Nov 16, 2021 at 12:29 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Nov 15, 2021 at 11:48:01PM -0800, Stephane Eranian wrote:
> > > On Fri, Nov 12, 2021 at 8:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Thu, Nov 11, 2021 at 12:44:05AM -0800, Stephane Eranian wrote:
> > > > > diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> > > > > index 38b2c779146f..28559557f966 100644
> > > > > --- a/arch/x86/events/core.c
> > > > > +++ b/arch/x86/events/core.c
> > > > > @@ -683,11 +683,16 @@ void x86_pmu_disable_all(void)
> > > > >
> > > > >               if (!test_bit(idx, cpuc->active_mask))
> > > > >                       continue;
> > > > > +
> > > > > +             if (is_amd_brs(hwc))
> > > > > +                     amd_brs_disable();
> > > > > +
> > > > >               rdmsrl(x86_pmu_config_addr(idx), val);
> > > > >               if (!(val & ARCH_PERFMON_EVENTSEL_ENABLE))
> > > > >                       continue;
> > > > >               val &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
> > > > >               wrmsrl(x86_pmu_config_addr(idx), val);
> > > > > +
> > > > >               if (is_counter_pair(hwc))
> > > > >                       wrmsrl(x86_pmu_config_addr(idx + 1), 0);
> > > > >       }
> > > >
> > > > Please, stick that in amd_pmu_disable_all().
> > >
> > >
> > > If I do that, I need to add a for_each_counter() loop to
> > > amd_pmu_disable_all() but it does not have one call systematically.
> > > If you are okay with it, then I am fine as well.
> >
> > Why ? There is only one BRS you can disable it first, and then do the
> > loop. Same on the enable_all side, enable it once, not per event.
> > ->add/->del can keep a per-event count for sharing purposes, but you
> > don't need that for {en,dis}able_all, right?
> 
> Ok, I made the changes you suggested. It looks closer to the way LBR is handled.
> However, this means that there is no path by which you can get to
> amd_pmu_disable_event()
> without having gone through amd_pmu_disable_all(). Is that always the
> case? And same thing
> on the enable side.

So that's true for ->add() and ->del(), those cannot be called without
being wrapped in ->pmu_disable(), ->pmu_enable().

There is however the ->stop() and ->start() usage for throttling, which
can stop an individual event (while leaving the event scheduled on the
PMU). Now, I think the ->stop() gets called with the PMU enabled, but
the ->start() is with it disabled again.

The ramification would be that we'd stop the event, but leave BRS
enabled for a throttled event. Which should be harmless, no?
