Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F0735FFAA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 03:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhDOBgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 21:36:52 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:58556 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229449AbhDOBgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 21:36:44 -0400
Received: from dread.disaster.area (pa49-181-239-12.pa.nsw.optusnet.com.au [49.181.239.12])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 8A91D1044304;
        Thu, 15 Apr 2021 11:36:18 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lWqvZ-008SPM-J8; Thu, 15 Apr 2021 11:36:17 +1000
Date:   Thu, 15 Apr 2021 11:36:17 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, SeongJae Park <sj38.park@gmail.com>,
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
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Rong Chen <rong.a.chen@intel.com>,
        SeongJae Park <sjpark@amazon.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        Ying Huang <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Kernel Page Reclaim v2 <page-reclaim@google.com>
Subject: Re: [PATCH v2 00/16] Multigenerational LRU Framework
Message-ID: <20210415013617.GU1990290@dread.disaster.area>
References: <20210413075155.32652-1-sjpark@amazon.de>
 <3ddd4f8a-8e51-662b-df11-a63a0e75b2bc@kernel.dk>
 <20210413231436.GF63242@dread.disaster.area>
 <CAOUHufa7RCK6gcYSeLv98w3_NY-TUpUNkDS0p_W4u5_ZfSXTsg@mail.gmail.com>
 <20210414045006.GR1990290@dread.disaster.area>
 <CAOUHufa5id9mmjud-UQd4agLCtmDypdNDStkxgoQxsUoh8Qcsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOUHufa5id9mmjud-UQd4agLCtmDypdNDStkxgoQxsUoh8Qcsg@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_f
        a=gO82wUwQTSpaJfP49aMSow==:117 a=gO82wUwQTSpaJfP49aMSow==:17
        a=kj9zAlcOel0A:10 a=3YhXtTcJ-WEA:10 a=7-415B0cAAAA:8
        a=-ifDvvrug44cuN_tyPgA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 01:16:52AM -0600, Yu Zhao wrote:
> On Tue, Apr 13, 2021 at 10:50 PM Dave Chinner <david@fromorbit.com> wrote:
> > On Tue, Apr 13, 2021 at 09:40:12PM -0600, Yu Zhao wrote:
> > > On Tue, Apr 13, 2021 at 5:14 PM Dave Chinner <david@fromorbit.com> wrote:
> > > > Profiles would be interesting, because it sounds to me like reclaim
> > > > *might* be batching page cache removal better (e.g. fewer, larger
> > > > batches) and so spending less time contending on the mapping tree
> > > > lock...
> > > >
> > > > IOWs, I suspect this result might actually be a result of less lock
> > > > contention due to a change in batch processing characteristics of
> > > > the new algorithm rather than it being a "better" algorithm...
> > >
> > > I appreciate the profile. But there is no batching in
> > > __remove_mapping() -- it locks the mapping for each page, and
> > > therefore the lock contention penalizes the mainline and this patchset
> > > equally. It looks worse on your system because the four kswapd threads
> > > from different nodes were working on the same file.
> >
> > I think you misunderstand exactly what I mean by "batching" here.
> > I'm not talking about doing multiple pieces of work under a single
> > lock. What I mean is that the overall amount of work done in a
> > single reclaim scan (i.e a "reclaim batch") is packaged differently.
> >
> > We already batch up page reclaim via building a page list and then
> > passing it to shrink_page_list() to process the batch of pages in a
> > single pass. Each page in this page list batch then calls
> > remove_mapping() to pull the page form the LRU, we have a run of
> > contention between the foreground read() thread and the background
> > kswapd.
> >
> > If the size or nature of the pages in the batch passed to
> > shrink_page_list() changes, then the amount of time a reclaim batch
> > is going to put pressure on the mapping tree lock will also change.
> > That's the "change in batching behaviour" I'm referring to here. I
> > haven't read through the patchset to determine if you change the
> > shrink_page_list() algorithm, but it likely changes what is passed
> > to be reclaimed and that in turn changes the locking patterns that
> > fall out of shrink_page_list...
> 
> Ok, if we are talking about the size of the batch passed to
> shrink_page_list(), both the mainline and this patchset cap it at
> SWAP_CLUSTER_MAX, which is 32. There are corner cases, but when
> running fio/io_uring, it's safe to say both use 32.

You're still looking at micro-scale behaviour, not the larger-scale
batching effects. Are we passing SWAP_CLUSTER_MAX groups of pages to
shrinker_page_list() at a different rate?

When I say "batch of work" when talking about the page cache cycling
*500 thousand pages a second* through the cache, I'm not talking
about batches of 32 pages. I'm talking about the entire batch of
work kswapd does in an invocation cycle.

Is it scanning 100k pages 10 times a second? or 10k pages a hundred
times a second? How long does a batch take to run? how long does is
sleep between processing batches? Is there any change in these
metrics as a result of the multi-gen LRU patches?

Basically, we're looking at how access to the mapping lock is
changing the contention profile, and whether that is signficant or
not. I suspect it is, because when you have highly contended locks
and you do something external that reduces unrelated lock
contention, it's because that external thing is taking more time to
do and so there's less time to spend hitting locks hard...

As such, I don't think this test is a good measure of the multi-gen
LRU patches at all - performance is dominated by the severity of
lock contention external to the LRU scanning algorithm, and it's
hard to infer anything through suck lock contention....

> I don't want to paste everything here -- they'd clutter. Please see
> all the detailed profiles in the attachment. Let me know if their
> formats are no to your liking. I still have the raw perf.data.

Which makes the discussion thread just about impossible to follow or
comment on. Please just post the relevant excerpt of the stack
profile that you are commenting on.

> > > And I plan to reach out to other communities, e.g., PostgreSQL, to
> > > benchmark the patchset. I heard they have been complaining about the
> > > buffered io performance under memory pressure. Any other benchmarks
> > > you'd suggest?
> > >
> > > BTW, you might find another surprise in how less frequently slab
> > > shrinkers are called under memory pressure, because this patchset is a
> > > lot better at finding pages to reclaim and therefore doesn't overkill
> > > slabs.
> >
> > That's actually very likely to be a Bad Thing and cause unexpected
> > perofrmance and OOM based regressions. When the machine finally runs
> > out of page cache it can easily reclaim, it's going to get stuck
> > with long tail latencies reclaiming huge slab caches as they've had
> > no substantial ongoing pressure put on them to keep them in balance
> > with the overall memory pressure the system is under...
> 
> Well. It does use the existing equation. That is if it scans X% of
> pages, then it scans X% of slab objects. But 1) it often finds pages
> to reclaim at a lower X% 2) the pages it reclaims are less likely to
> refault. So the side effect is the overall slab objects it scans also
> reduce. I do see your point but don't see any options, at the moment.

You'll have to rebalance the memory reclaim algorithms to either:

a) make the shrinkers more aggressive so they do more reclaim when
called less often, or

b) lower the threshold at which shrinkers are called.

Keeping the slab caches in balance with page cache memory pressure
is fairly important for the performance of workloads that generate
inode and dentry cache load, especially those that don't actually
generate page cache pressure. This is the hardest part about making
fundamental changes to memory reclaim behaviour: ensuring that the
system remains balanced over a wide range of differing workloads and
reacts sanely to sudden step changes in workload behaviour...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
