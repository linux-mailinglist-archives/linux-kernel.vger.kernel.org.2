Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3CCF431980
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 14:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhJRMng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 08:43:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43824 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbhJRMnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 08:43:35 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C48E4218E0;
        Mon, 18 Oct 2021 12:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634560883; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qqVyTJszOpR5oxY7f2Bd82OpVm8eX8E8zKmQpxWFVyg=;
        b=U64AWQJ3eycEDWMPrFzhGZsS3z3WA2raDYyAP3jdLSxqjBxvqpSrj2OnQKTfmzfmb0UwEj
        CXgQpvmRjbcsZlX4V91GcmWj+YXgbkuJYAXt1ucpzpMgpjiH4c65n04Ctvc8yDTBxdDpXi
        X/dg1o2Y8YVzvurGmfmfCnpegKvZ7pU=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 55B47A3B81;
        Mon, 18 Oct 2021 12:41:23 +0000 (UTC)
Date:   Mon, 18 Oct 2021 14:41:22 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: skip current when memcg reclaim
Message-ID: <YW1rcv4bN1WWhzLD@dhcp22.suse.cz>
References: <1634278529-16983-1-git-send-email-huangzhaoyang@gmail.com>
 <YW0u67o8wl3CGikP@dhcp22.suse.cz>
 <CAGWkznEO9SyNFEBqL8=JxewVTvaUhwFLPow69mi=R1MJ=XCpow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznEO9SyNFEBqL8=JxewVTvaUhwFLPow69mi=R1MJ=XCpow@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 18-10-21 17:25:23, Zhaoyang Huang wrote:
> On Mon, Oct 18, 2021 at 4:23 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Fri 15-10-21 14:15:29, Huangzhaoyang wrote:
> > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > >
> > > Sibling thread of the same process could refault the reclaimed pages
> > > in the same time, which would be typical in None global reclaim and
> > > introduce thrashing.
> >
> > It is hard to understand what kind of problem you see (ideally along
> > with some numbers) and how the proposed patch addresses that problem
> >
> > Also you are missing Signed-off-by tag (please have a look at
> > Documentation/process/submitting-patches.rst which is much more
> > comprehensive about the process).
> sorry for that, I will fix it.
> >
> > > ---
> > >  mm/vmscan.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index 5199b96..ebbdc37 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -2841,6 +2841,11 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
> > >                               sc->memcg_low_skipped = 1;
> > >                               continue;
> > >                       }
> > > +                     /*
> > > +                      * Don't bother current when its memcg is below low
> > > +                      */
> > > +                     if (get_mem_cgroup_from_mm(current->mm) == memcg)
> > > +                             continue;
> >
> > This code is executed when none of memcg in the reclaimed hierarchy
> > could be reclaimed. Low limit is then ignored and this change is
> > tweaking that behavior without any description of the effect. A very
> > vague note about trashing would indicate that you have something like
> > the following
> >
> >         A (hiting hard limit)
> >        / \
> >       B   C
> >
> > Both B and C low limit protected and current task associated with B. As
> > none of the two could be reclaimed due to soft protection yuu prefer to
> > reclaim from C as you do not want to reclaim from the current process as
> > that could reclaim current's working set. Correct?
> >
> > I would be really curious about more specifics of the used hierarchy.
> What I am facing is a typical scenario on Android, that is a big
> memory consuming APP(camera etc) launched while background filled by
> other processes. The hierarchy is like what you describe above where B
> represents the APP and memory.low is set to help warm restart. Both of
> kswapd and direct reclaim work together to reclaim pages under this
> scenario, which can cause 20MB file page delete from LRU in several
> second. This change could help to have current process's page escape
> from being reclaimed and cause page thrashing. We observed the result
> via systrace which shows that the Uninterruptible sleep(block on page
> bit) and iowait get smaller than usual.

I still have hard time to understand the exact setup and why the patch
helps you. If you want to protect B more than the low limit would allow
for by stealiong from C then the same thing can happen from anybody
reclaiming from C so in the end there is no protection. The same would
apply for any global direct memory reclaim done by a 3rd party. So I
suspect that your patch just happens to work by a luck.

Why both B and C have low limit setup and they both cannot be reclaimed?
Isn't that a weird setup where A hard limit is too close to sum of low
limits of B and C?

In other words could you share a more detailed configuration you are
using and some more details why both B and C have been skipped during
the first pass of the reclaim?

-- 
Michal Hocko
SUSE Labs
