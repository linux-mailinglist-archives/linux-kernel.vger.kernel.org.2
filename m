Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3450B4541BF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 08:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbhKQH0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 02:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbhKQH0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 02:26:49 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499F1C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 23:23:51 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id h2so1737874ili.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 23:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IX7FMxwBPCEh1I3CPe+XsGtuuahc0pfSDK1TOforLz0=;
        b=G3jh2csdgSsMp1wcQQ5SZHlgfSujSXXiZdUt6XCI53aCqIBwLoOxgNiVTQUi8IOsBj
         wNegNvkCbLPWLs7rBH4FlzOIgCegx7y3x3gPQi+1a2/P8Gdjq3t8L+WEeWgDiiyQwtcS
         WN9YTCQnujJJ1poIDC+332ZcY2q/9EtEkuK372Eccp9/G9GQG9CFNFVrikrouWbzneUU
         L9GozB1hQs5napzoivszzOQwnOC4x0LINpGqtOOwEbYUEAn239a/uV3+dQpe10xennpp
         jdbOKFo9ak2F8bRm2mHuTVwELTi8rRzPstPaeGy0dTXx5oSPHuIXJkxPd999BLlOFyly
         J20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IX7FMxwBPCEh1I3CPe+XsGtuuahc0pfSDK1TOforLz0=;
        b=Q7+kA1HbTOvQYsMCm41ZyxwhTSTYryiE7bF1gqXocN52+49G63FJlb7mePw9BnK7w7
         k2blJFCvTIBBmGwh8IpSPff50bEq5IJVtgmAyOVMdIDnEojPtX6Xc0KPz4FKT6yH3c1o
         NofC7C1mX0ucbF7azqNL5bPRsFcPVKJDgGD4HfKCKcK+o7bVaS4vEON91YxTPL8EniVa
         H80JotP8pVb5oex4RqhoghtDw9f5K/5w/B9fbsdM/wTfqLOtW/b9qtqOzOdGCwouzuZk
         1s3H/OxEtiuqnGEGuiPW3RhmRMjASyH6hbfLAW5D3EVvPnXJm8MJFpp6AR17H8Xo16KM
         W8bg==
X-Gm-Message-State: AOAM531BSRQFZoTr+dWZUtMEQg07chP0ezOqiC7MHw8z6WjaBlYeVumg
        M8GUjulbiEAg8qbHk3BUvMS/STD3sWoXROWLmjvN/g==
X-Google-Smtp-Source: ABdhPJwPHhabW7sXHl4DE8n6aAdaZOq+YqsDP2LT+EW2Iyf/TKX2zceCxsknwrcgJj4wf0N1GDqy12y09AhWfkN62PQ=
X-Received: by 2002:a05:6e02:1aac:: with SMTP id l12mr9256469ilv.295.1637133830532;
 Tue, 16 Nov 2021 23:23:50 -0800 (PST)
MIME-Version: 1.0
References: <20211111084415.663951-1-eranian@google.com> <20211111084415.663951-4-eranian@google.com>
 <YY6QBXs0sM16DdbV@hirez.programming.kicks-ass.net> <CABPqkBShSBaJH+PR6rMkRRzjZAKN5zPhcdnLWx=4a-yQWxcA2A@mail.gmail.com>
 <20211116082923.GX174703@worktop.programming.kicks-ass.net>
In-Reply-To: <20211116082923.GX174703@worktop.programming.kicks-ass.net>
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 16 Nov 2021 23:23:39 -0800
Message-ID: <CABPqkBQ4BCswvNPpkO79dBamhudikz1cGCXFpwAp9xsTb3F8xQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/13] perf/x86/amd: add AMD Fam19h Branch Sampling support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kim.phillips@amd.com,
        acme@redhat.com, jolsa@redhat.com, songliubraving@fb.com,
        mpe@ellerman.id.au, maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 12:29 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Nov 15, 2021 at 11:48:01PM -0800, Stephane Eranian wrote:
> > On Fri, Nov 12, 2021 at 8:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Thu, Nov 11, 2021 at 12:44:05AM -0800, Stephane Eranian wrote:
> > > > diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> > > > index 38b2c779146f..28559557f966 100644
> > > > --- a/arch/x86/events/core.c
> > > > +++ b/arch/x86/events/core.c
> > > > @@ -683,11 +683,16 @@ void x86_pmu_disable_all(void)
> > > >
> > > >               if (!test_bit(idx, cpuc->active_mask))
> > > >                       continue;
> > > > +
> > > > +             if (is_amd_brs(hwc))
> > > > +                     amd_brs_disable();
> > > > +
> > > >               rdmsrl(x86_pmu_config_addr(idx), val);
> > > >               if (!(val & ARCH_PERFMON_EVENTSEL_ENABLE))
> > > >                       continue;
> > > >               val &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
> > > >               wrmsrl(x86_pmu_config_addr(idx), val);
> > > > +
> > > >               if (is_counter_pair(hwc))
> > > >                       wrmsrl(x86_pmu_config_addr(idx + 1), 0);
> > > >       }
> > >
> > > Please, stick that in amd_pmu_disable_all().
> >
> >
> > If I do that, I need to add a for_each_counter() loop to
> > amd_pmu_disable_all() but it does not have one call systematically.
> > If you are okay with it, then I am fine as well.
>
> Why ? There is only one BRS you can disable it first, and then do the
> loop. Same on the enable_all side, enable it once, not per event.
> ->add/->del can keep a per-event count for sharing purposes, but you
> don't need that for {en,dis}able_all, right?

Ok, I made the changes you suggested. It looks closer to the way LBR is handled.
However, this means that there is no path by which you can get to
amd_pmu_disable_event()
without having gone through amd_pmu_disable_all(). Is that always the
case? And same thing
on the enable side.
