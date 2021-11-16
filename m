Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CA3452CCA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 09:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbhKPIdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 03:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbhKPIck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 03:32:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CDBC061204
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 00:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b2bjYgZeY8/q1s/F+VXSE6NMEBV9D8POrw1QyztsEgE=; b=PGvFsq1uo12fVWEutQ8Zjz7Bpq
        AUwpRAt8m+0+qgOGktnZW/Anb9FuhkqUdu/g6Qp0bnssCsHK415tl01HD4vRrrcC0QgeWXKZGgLu9
        DtDGBGK0Ov/HMKsjTM6UY6OrDmUyzzg8bNl1RoBYug1icaZJ8HZZuwJiKommU8pTu14C04BU/GFCB
        FF8ynn3lmjQWkswSj/07TVynZXGg5e1JZTqzZSZRWg7JLJK7ijglBAKTaCaxZ0IJEY4HuGyi2BgAU
        C7FWrvLq7fzaIO3nPHl1zwCxU/rSb2qqV8uo1eOFD8uHl28r6YC+aNIgpB2fi9A9IyceuMHUO3/Mx
        XOTWltJg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmtqF-006aMv-G0; Tue, 16 Nov 2021 08:29:24 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id CCAA998651D; Tue, 16 Nov 2021 09:29:23 +0100 (CET)
Date:   Tue, 16 Nov 2021 09:29:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, kim.phillips@amd.com,
        acme@redhat.com, jolsa@redhat.com, songliubraving@fb.com,
        mpe@ellerman.id.au, maddy@linux.ibm.com
Subject: Re: [PATCH v2 03/13] perf/x86/amd: add AMD Fam19h Branch Sampling
 support
Message-ID: <20211116082923.GX174703@worktop.programming.kicks-ass.net>
References: <20211111084415.663951-1-eranian@google.com>
 <20211111084415.663951-4-eranian@google.com>
 <YY6QBXs0sM16DdbV@hirez.programming.kicks-ass.net>
 <CABPqkBShSBaJH+PR6rMkRRzjZAKN5zPhcdnLWx=4a-yQWxcA2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBShSBaJH+PR6rMkRRzjZAKN5zPhcdnLWx=4a-yQWxcA2A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 11:48:01PM -0800, Stephane Eranian wrote:
> On Fri, Nov 12, 2021 at 8:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Nov 11, 2021 at 12:44:05AM -0800, Stephane Eranian wrote:
> > > diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> > > index 38b2c779146f..28559557f966 100644
> > > --- a/arch/x86/events/core.c
> > > +++ b/arch/x86/events/core.c
> > > @@ -683,11 +683,16 @@ void x86_pmu_disable_all(void)
> > >
> > >               if (!test_bit(idx, cpuc->active_mask))
> > >                       continue;
> > > +
> > > +             if (is_amd_brs(hwc))
> > > +                     amd_brs_disable();
> > > +
> > >               rdmsrl(x86_pmu_config_addr(idx), val);
> > >               if (!(val & ARCH_PERFMON_EVENTSEL_ENABLE))
> > >                       continue;
> > >               val &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
> > >               wrmsrl(x86_pmu_config_addr(idx), val);
> > > +
> > >               if (is_counter_pair(hwc))
> > >                       wrmsrl(x86_pmu_config_addr(idx + 1), 0);
> > >       }
> >
> > Please, stick that in amd_pmu_disable_all().
> 
> 
> If I do that, I need to add a for_each_counter() loop to
> amd_pmu_disable_all() but it does not have one call systematically.
> If you are okay with it, then I am fine as well.

Why ? There is only one BRS you can disable it first, and then do the
loop. Same on the enable_all side, enable it once, not per event.
->add/->del can keep a per-event count for sharing purposes, but you
don't need that for {en,dis}able_all, right?
