Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0856035EEF0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349827AbhDNH7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 03:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348323AbhDNH7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 03:59:31 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8ECC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 00:59:09 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id c15so9952581wro.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 00:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7t14JeboerRf4l9SkYSczgfymH4hyD8T2kvod+yLpyM=;
        b=UeG9U9PmWhM6XD8oiyeGOKEjjV1WoXocsCtyz1r695zgn00akYxGA1m4MzWWuny1Zu
         JLKvLD9EVMnU2YdX7aS/HuGViz9dY0ip0vY0ul/h3SoQElDJ9fNa8oFjQ7sKbHBFNYey
         qMnmJ8nH7nTfC5oq3yG7MpWRb06OlNFCa/wbqbltQOULCnekYzNqjGblotiEdvhNUB8R
         jGRjngybxMNZAcr0fSOrZ21Fzg2nNpG8VidA53I7XzM76PkmgpVrbIvFEPlAX023WwDs
         R209NXUtrkV75Q/g087Li+VdvboYLtlG+5XG1AwmjB6ycEcH54V9hntAf47QyJ+i1JO5
         a98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7t14JeboerRf4l9SkYSczgfymH4hyD8T2kvod+yLpyM=;
        b=c6qLvIEcBdT9tohn+ue5IUIp9mFj7UMDo3NU4qmKXUd+5wCbNBRZt1WOHd9ZW8/bLI
         hxf3qkOMH7+iskxQpySwUNxQHbCq5bvP8eiFKZKQ+2j3G7uzWLtPNKOSdH09gmDR+6sh
         gn1a7s49pB19jR7U981GYIQOXI+SbN3DVGFf9jJyvIvlYj6DRSLSEtIcK1x1hAf3Flhs
         82kwqL/mLmkx6wbKlctlhV8bM5bJSC6zyMr0wGz/2dBgDLYLC4EsqTiWeSOGW0wRUqbe
         ZdkJjZlV0sL6mUldQr45I4DzFF5o77I/cunPXfz5uSVo8J3/8eVfVOW/uGAwhxscrHiT
         csWg==
X-Gm-Message-State: AOAM530W0dJ/JJW4GGBjxlxXlhr4agvAPTqJ9QSXtsC/bhBhJvjoy/f4
        fZFQmeEOhQLY6OyRWvIS4g6uAqpGWG/tKRC2sij0Hw==
X-Google-Smtp-Source: ABdhPJzi5B2MpVcd8lm1G+hFusiaY0iKd6Ba78fTpG89T2mYBvQOPxKg8QfKRGg/8Td5Hl0flZAWsFU6xNqZKmqO96g=
X-Received: by 2002:adf:e381:: with SMTP id e1mr21366832wrm.323.1618387147886;
 Wed, 14 Apr 2021 00:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210413075155.32652-1-sjpark@amazon.de> <3ddd4f8a-8e51-662b-df11-a63a0e75b2bc@kernel.dk>
 <20210413231436.GF63242@dread.disaster.area> <f4750f9431bd12b7338a47925de8b17015da51a7.camel@surriel.com>
 <CAOUHufafMcaG8sOS=1YMy2P_6p0R1FzP16bCwpUau7g1-PybBQ@mail.gmail.com> <87tuo9qtmd.fsf@yhuang6-desk1.ccr.corp.intel.com>
In-Reply-To: <87tuo9qtmd.fsf@yhuang6-desk1.ccr.corp.intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 14 Apr 2021 01:58:56 -0600
Message-ID: <CAOUHufbk=TVOpEOvTNRBe0uoOWNZ=wf3umQ628ZFZ=QYhNqsHA@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] Multigenerational LRU Framework
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Rik van Riel <riel@surriel.com>,
        Dave Chinner <david@fromorbit.com>,
        Jens Axboe <axboe@kernel.dk>,
        SeongJae Park <sj38.park@gmail.com>,
        Linux-MM <linux-mm@kvack.org>, Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Manes <ben.manes@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Michael Larabel <michael@michaellarabel.com>,
        Michal Hocko <mhocko@suse.com>,
        Michel Lespinasse <michel@lespinasse.org>,
        Roman Gushchin <guro@fb.com>,
        Rong Chen <rong.a.chen@intel.com>,
        SeongJae Park <sjpark@amazon.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Kernel Page Reclaim v2 <page-reclaim@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 12:15 AM Huang, Ying <ying.huang@intel.com> wrote:
>
> Yu Zhao <yuzhao@google.com> writes:
>
> > On Tue, Apr 13, 2021 at 8:30 PM Rik van Riel <riel@surriel.com> wrote:
> >>
> >> On Wed, 2021-04-14 at 09:14 +1000, Dave Chinner wrote:
> >> > On Tue, Apr 13, 2021 at 10:13:24AM -0600, Jens Axboe wrote:
> >> >
> >> > > The initial posting of this patchset did no better, in fact it did
> >> > > a bit
> >> > > worse. Performance dropped to the same levels and kswapd was using
> >> > > as
> >> > > much CPU as before, but on top of that we also got excessive
> >> > > swapping.
> >> > > Not at a high rate, but 5-10MB/sec continually.
> >> > >
> >> > > I had some back and forths with Yu Zhao and tested a few new
> >> > > revisions,
> >> > > and the current series does much better in this regard. Performance
> >> > > still dips a bit when page cache fills, but not nearly as much, and
> >> > > kswapd is using less CPU than before.
> >> >
> >> > Profiles would be interesting, because it sounds to me like reclaim
> >> > *might* be batching page cache removal better (e.g. fewer, larger
> >> > batches) and so spending less time contending on the mapping tree
> >> > lock...
> >> >
> >> > IOWs, I suspect this result might actually be a result of less lock
> >> > contention due to a change in batch processing characteristics of
> >> > the new algorithm rather than it being a "better" algorithm...
> >>
> >> That seems quite likely to me, given the issues we have
> >> had with virtual scan reclaim algorithms in the past.
> >
> > Hi Rik,
> >
> > Let paste the code so we can move beyond the "batching" hypothesis:
> >
> > static int __remove_mapping(struct address_space *mapping, struct page
> > *page,
> >                             bool reclaimed, struct mem_cgroup *target_memcg)
> > {
> >         unsigned long flags;
> >         int refcount;
> >         void *shadow = NULL;
> >
> >         BUG_ON(!PageLocked(page));
> >         BUG_ON(mapping != page_mapping(page));
> >
> >         xa_lock_irqsave(&mapping->i_pages, flags);
> >
> >> SeongJae, what is this algorithm supposed to do when faced
> >> with situations like this:
> >
> > I'll assume the questions were directed at me, not SeongJae.
> >
> >> 1) Running on a system with 8 NUMA nodes, and
> >> memory
> >>    pressure in one of those nodes.
> >> 2) Running PostgresQL or Oracle, with hundreds of
> >>    processes mapping the same (very large) shared
> >>    memory segment.
> >>
> >> How do you keep your algorithm from falling into the worst
> >> case virtual scanning scenarios that were crippling the
> >> 2.4 kernel 15+ years ago on systems with just a few GB of
> >> memory?
> >
> > There is a fundamental shift: that time we were scanning for cold pages,
> > and nowadays we are scanning for hot pages.
> >
> > I'd be surprised if scanning for cold pages didn't fall apart, because it'd
> > find most of the entries accessed, if they are present at all.
> >
> > Scanning for hot pages, on the other hand, is way better. Let me just
> > reiterate:
> > 1) It will not scan page tables from processes that have been sleeping
> >    since the last scan.
> > 2) It will not scan PTE tables under non-leaf PMD entries that do not
> >    have the accessed bit set, when
> >    CONFIG_HAVE_ARCH_PARENT_PMD_YOUNG=y.
> > 3) It will not zigzag between the PGD table and the same PMD or PTE
> >    table spanning multiple VMAs. In other words, it finishes all the
> >    VMAs with the range of the same PMD or PTE table before it returns
> >    to the PGD table. This optimizes workloads that have large numbers
> >    of tiny VMAs, especially when CONFIG_PGTABLE_LEVELS=5.
> >
> > So the cost is roughly proportional to the number of referenced pages it
> > discovers. If there is no memory pressure, no scanning at all. For a system
> > under heavy memory pressure, most of the pages are referenced (otherwise
> > why would it be under memory pressure?), and if we use the rmap, we need to
> > scan a lot of pages anyway. Why not just scan them all?
>
> This may be not the case.  For rmap scanning, it's possible to scan only
> a small portion of memory.  But with the page table scanning, you need
> to scan almost all (I understand you have some optimization as above).

Hi Ying,

Let's take a step back.

For the sake of discussion, when does the scanning have to happen? Can
we agree that the simplest answer is when we have evicted all inactive
pages?

If so, my next question is who's filled in the memory space previously
occupied by those inactive pages? Newly faulted in pages, right? They
have the accessed bit set, and we can't evict them without scanning
them first, would you agree?

And there are also existing active pages, and they were protected from
eviction. But now we need to deactivate some of them. Do you think
whether they'd have been used or not since the last scan? (Remember
they were active.)

You mentioned "a small portion" and "almost all". How do you interpret
them in terms of these steps?

Intuitively, "a small portion" and "almost all" seem right. But our
observations from *millions* of machines say the ratio of
pgscan_kswapd to pgsteal_kswapd is well over 7 when anon percentage is
>90%. Unlikely streaming files, it doesn't make sense to "stream" anon
memory.

> As Rik shown in the test case above, there may be memory pressure on
> only one of 8 NUMA nodes (because of NUMA binding?).  Then ramp scanning
> only needs to scan pages in this node, while the page table scanning may
> need to scan pages in other nodes too.

Yes, and this is on my to-do list in the patchset:

To-do List
==========
KVM Optimization
----------------
Support shadow page table scanning.

NUMA Optimization
-----------------
Support NUMA policies and per-node RSS counters.

We only can move forward one step at a time. Fair?
