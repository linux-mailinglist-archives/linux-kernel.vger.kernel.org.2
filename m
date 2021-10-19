Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0B1432F09
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 09:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbhJSHOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 03:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234421AbhJSHOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 03:14:05 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801DBC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 00:11:53 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id w2so17517630qtn.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 00:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P9RlSrpD0k5acoy5HGcKIkiOu7wRmSS2c551P7XRDbc=;
        b=kiZizcAMG4gRSTKk/t2DfuAaY6XX/nDU8h3k7j5TSPh9FPd477fMoX3jy2z1VslDkg
         ayOI4u+bmaMM6EVzGBB+d65nXJxQV9kKr60mxrM3NtaN48ZvmaesbLb2Vvd/L2ipjYHn
         MxIlCP+MkGKz5LMioLdnY1eFkNWH/VTTNV2kpVk0kkikh+b/31p+p2m5kiJtnOGkEZ1N
         GFhKPl0glKscAkB5cuTluG2xrlB4hY7HJC9RMI8oQ9Y0zde5PMYdRWwzBDP07ndHnh0x
         I2zbVj1x+cfI7ltC9obYgZVCx3C+2Wm8W9T532226u+ZP1uMddlwvvEbo+Bw9gzxNSa5
         GlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P9RlSrpD0k5acoy5HGcKIkiOu7wRmSS2c551P7XRDbc=;
        b=zWFM7Z7x17gNzQJVuCi35ZNPIXInfltUjhuHa3WhKlAi5dcO8oYCdGM3FfPboekcmZ
         b32GFlBEZ+ojDdkTzefP4olD/nbDSt0pyHBztcDTDdjuqhLlr9A8faXom/cIMfgaX9pg
         HZZDsS2hfhDyoC5YwAKhIT+1Y7sOfir2/9z37cSDdIIeiShE3Y0iFKrzgYOzuc6D1y6L
         jG0G8fO+gmbDuP83UEjTue9ck2S401VtfHbRDmNq6Pk7T/eFg8+JQJ+nZSqzkx0PP4+M
         /Dgnk5ecAusO0AlV2AaV9H1pI+6PmHptq2pkZbzEkkqaJmlJ+vSc1Ce3l6CKM4nr7O+1
         neoA==
X-Gm-Message-State: AOAM532/wQFUkUwCtiFq4bN/a50PZk2SKfa7lmimbikFMsFa8iZC6W0P
        Cm8PuzLG86PryoqT6wIITkomIz7OihdROcxL0lY=
X-Google-Smtp-Source: ABdhPJzvr8KVDzDd0NGKuLQYSEOd53sxI2EOeSHJ5WtYJ4i92PH5ks8i1sy4Po3lKr3pr+JiNd/Et8S9ZORAxrrZ3CY=
X-Received: by 2002:ac8:580b:: with SMTP id g11mr34036446qtg.272.1634627512666;
 Tue, 19 Oct 2021 00:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <1634278529-16983-1-git-send-email-huangzhaoyang@gmail.com>
 <YW0u67o8wl3CGikP@dhcp22.suse.cz> <CAGWkznEO9SyNFEBqL8=JxewVTvaUhwFLPow69mi=R1MJ=XCpow@mail.gmail.com>
 <YW1rcv4bN1WWhzLD@dhcp22.suse.cz>
In-Reply-To: <YW1rcv4bN1WWhzLD@dhcp22.suse.cz>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Tue, 19 Oct 2021 15:11:30 +0800
Message-ID: <CAGWkznG65_FGx9jU7rjj5biEdyHZ=kcPwmXj6cGxxVmPy2rdKQ@mail.gmail.com>
Subject: Re: [PATCH] mm: skip current when memcg reclaim
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 8:41 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 18-10-21 17:25:23, Zhaoyang Huang wrote:
> > On Mon, Oct 18, 2021 at 4:23 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Fri 15-10-21 14:15:29, Huangzhaoyang wrote:
> > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > >
> > > > Sibling thread of the same process could refault the reclaimed pages
> > > > in the same time, which would be typical in None global reclaim and
> > > > introduce thrashing.
> > >
> > > It is hard to understand what kind of problem you see (ideally along
> > > with some numbers) and how the proposed patch addresses that problem
> > >
> > > Also you are missing Signed-off-by tag (please have a look at
> > > Documentation/process/submitting-patches.rst which is much more
> > > comprehensive about the process).
> > sorry for that, I will fix it.
> > >
> > > > ---
> > > >  mm/vmscan.c | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > > index 5199b96..ebbdc37 100644
> > > > --- a/mm/vmscan.c
> > > > +++ b/mm/vmscan.c
> > > > @@ -2841,6 +2841,11 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
> > > >                               sc->memcg_low_skipped = 1;
> > > >                               continue;
> > > >                       }
> > > > +                     /*
> > > > +                      * Don't bother current when its memcg is below low
> > > > +                      */
> > > > +                     if (get_mem_cgroup_from_mm(current->mm) == memcg)
> > > > +                             continue;
> > >
> > > This code is executed when none of memcg in the reclaimed hierarchy
> > > could be reclaimed. Low limit is then ignored and this change is
> > > tweaking that behavior without any description of the effect. A very
> > > vague note about trashing would indicate that you have something like
> > > the following
> > >
> > >         A (hiting hard limit)
> > >        / \
> > >       B   C
> > >
> > > Both B and C low limit protected and current task associated with B. As
> > > none of the two could be reclaimed due to soft protection yuu prefer to
> > > reclaim from C as you do not want to reclaim from the current process as
> > > that could reclaim current's working set. Correct?
> > >
> > > I would be really curious about more specifics of the used hierarchy.
> > What I am facing is a typical scenario on Android, that is a big
> > memory consuming APP(camera etc) launched while background filled by
> > other processes. The hierarchy is like what you describe above where B
> > represents the APP and memory.low is set to help warm restart. Both of
> > kswapd and direct reclaim work together to reclaim pages under this
> > scenario, which can cause 20MB file page delete from LRU in several
> > second. This change could help to have current process's page escape
> > from being reclaimed and cause page thrashing. We observed the result
> > via systrace which shows that the Uninterruptible sleep(block on page
> > bit) and iowait get smaller than usual.
>
> I still have hard time to understand the exact setup and why the patch
> helps you. If you want to protect B more than the low limit would allow
> for by stealiong from C then the same thing can happen from anybody
> reclaiming from C so in the end there is no protection. The same would
> apply for any global direct memory reclaim done by a 3rd party. So I
> suspect that your patch just happens to work by a luck.
B and C compete fairly and superior than others. The idea based on
assuming NOT all groups will trap into direct reclaim concurrently, so
we want to have the groups steal pages from the processes under
root(Non-memory sensitive) or other groups with lower thresholds(high
memory tolerance) or the one totally sleeping(not busy for the time
being, borrow some pages).
>
> Why both B and C have low limit setup and they both cannot be reclaimed?
> Isn't that a weird setup where A hard limit is too close to sum of low
> limits of B and C?
>
> In other words could you share a more detailed configuration you are
> using and some more details why both B and C have been skipped during
> the first pass of the reclaim?
My practical scenario is that important processes(vip APP etc) are
placed into protected memcg and keep other processes just under root.
Current introduces direct reclaim because of alloc_pages(DMA_ALLOC
etc), in which the number of allocation would be much larger than low
but would NOT be charged to LRU. Whereas, current also wants to keep
the pages(.so files to exec) on LRU.
>
> --
> Michal Hocko
> SUSE Labs
