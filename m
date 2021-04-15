Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07DAB35FF38
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 03:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbhDOBV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 21:21:59 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:53032 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229450AbhDOBV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 21:21:58 -0400
Received: from dread.disaster.area (pa49-181-239-12.pa.nsw.optusnet.com.au [49.181.239.12])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id F36B2839BE1;
        Thu, 15 Apr 2021 11:21:19 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lWqh2-008RJZ-A8; Thu, 15 Apr 2021 11:21:16 +1000
Date:   Thu, 15 Apr 2021 11:21:16 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     SeongJae Park <sj38.park@gmail.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org, Andi Kleen <ak@linux.intel.com>,
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
        linux-kernel@vger.kernel.org, lkp@lists.01.org,
        page-reclaim@google.com
Subject: Re: [PATCH v2 00/16] Multigenerational LRU Framework
Message-ID: <20210415012116.GT1990290@dread.disaster.area>
References: <20210413075155.32652-1-sjpark@amazon.de>
 <3ddd4f8a-8e51-662b-df11-a63a0e75b2bc@kernel.dk>
 <20210413231436.GF63242@dread.disaster.area>
 <91146ee7-3054-a81a-296e-e75c24f4e290@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91146ee7-3054-a81a-296e-e75c24f4e290@kernel.dk>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_f
        a=gO82wUwQTSpaJfP49aMSow==:117 a=gO82wUwQTSpaJfP49aMSow==:17
        a=IkcTkHD0fZMA:10 a=3YhXtTcJ-WEA:10 a=1XWaLZrsAAAA:8 a=7-415B0cAAAA:8
        a=Bz5T2BrlmXL63WySl4EA:9 a=QEXdDO2ut3YA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 08:43:36AM -0600, Jens Axboe wrote:
> On 4/13/21 5:14 PM, Dave Chinner wrote:
> > On Tue, Apr 13, 2021 at 10:13:24AM -0600, Jens Axboe wrote:
> >> On 4/13/21 1:51 AM, SeongJae Park wrote:
> >>> From: SeongJae Park <sjpark@amazon.de>
> >>>
> >>> Hello,
> >>>
> >>>
> >>> Very interesting work, thank you for sharing this :)
> >>>
> >>> On Tue, 13 Apr 2021 00:56:17 -0600 Yu Zhao <yuzhao@google.com> wrote:
> >>>
> >>>> What's new in v2
> >>>> ================
> >>>> Special thanks to Jens Axboe for reporting a regression in buffered
> >>>> I/O and helping test the fix.
> >>>
> >>> Is the discussion open?  If so, could you please give me a link?
> >>
> >> I wasn't on the initial post (or any of the lists it was posted to), but
> >> it's on the google page reclaim list. Not sure if that is public or not.
> >>
> >> tldr is that I was pretty excited about this work, as buffered IO tends
> >> to suck (a lot) for high throughput applications. My test case was
> >> pretty simple:
> >>
> >> Randomly read a fast device, using 4k buffered IO, and watch what
> >> happens when the page cache gets filled up. For this particular test,
> >> we'll initially be doing 2.1GB/sec of IO, and then drop to 1.5-1.6GB/sec
> >> with kswapd using a lot of CPU trying to keep up. That's mainline
> >> behavior.
> > 
> > I see this exact same behaviour here, too, but I RCA'd it to
> > contention between the inode and memory reclaim for the mapping
> > structure that indexes the page cache. Basically the mapping tree
> > lock is the contention point here - you can either be adding pages
> > to the mapping during IO, or memory reclaim can be removing pages
> > from the mapping, but we can't do both at once.
> > 
> > So we end up with kswapd spinning on the mapping tree lock like so
> > when doing 1.6GB/s in 4kB buffered IO:
> > 
> > -   20.06%     0.00%  [kernel]               [k] kswapd                                                                                                        ▒
> >    - 20.06% kswapd                                                                                                                                             ▒
> >       - 20.05% balance_pgdat                                                                                                                                   ▒
> >          - 20.03% shrink_node                                                                                                                                  ▒
> >             - 19.92% shrink_lruvec                                                                                                                             ▒
> >                - 19.91% shrink_inactive_list                                                                                                                   ▒
> >                   - 19.22% shrink_page_list                                                                                                                    ▒
> >                      - 17.51% __remove_mapping                                                                                                                 ▒
> >                         - 14.16% _raw_spin_lock_irqsave                                                                                                        ▒
> >                            - 14.14% do_raw_spin_lock                                                                                                           ▒
> >                                 __pv_queued_spin_lock_slowpath                                                                                                 ▒
> >                         - 1.56% __delete_from_page_cache                                                                                                       ▒
> >                              0.63% xas_store                                                                                                                   ▒
> >                         - 0.78% _raw_spin_unlock_irqrestore                                                                                                    ▒
> >                            - 0.69% do_raw_spin_unlock                                                                                                          ▒
> >                                 __raw_callee_save___pv_queued_spin_unlock                                                                                      ▒
> >                      - 0.82% free_unref_page_list                                                                                                              ▒
> >                         - 0.72% free_unref_page_commit                                                                                                         ▒
> >                              0.57% free_pcppages_bulk                                                                                                          ▒
> > 
> > And these are the processes consuming CPU:
> > 
> >    5171 root      20   0 1442496   5696   1284 R  99.7   0.0   1:07.78 fio
> >    1150 root      20   0       0      0      0 S  47.4   0.0   0:22.70 kswapd1
> >    1146 root      20   0       0      0      0 S  44.0   0.0   0:21.85 kswapd0
> >    1152 root      20   0       0      0      0 S  39.7   0.0   0:18.28 kswapd3
> >    1151 root      20   0       0      0      0 S  15.2   0.0   0:12.14 kswapd2
> 
> Here's my profile when memory reclaim is active for the above mentioned
> test case. This is a single node system, so just kswapd. It's using around
> 40-45% CPU:
> 
>     43.69%  kswapd0  [kernel.vmlinux]  [k] xas_create
>             |
>             ---ret_from_fork
>                kthread
>                kswapd
>                balance_pgdat
>                shrink_node
>                shrink_lruvec
>                shrink_inactive_list
>                shrink_page_list
>                __delete_from_page_cache
>                xas_store
>                xas_create
> 
>     16.88%  kswapd0  [kernel.vmlinux]  [k] queued_spin_lock_slowpath
>             |
>             ---ret_from_fork
>                kthread
>                kswapd
>                balance_pgdat
>                shrink_node
>                shrink_lruvec
>                |          
>                 --16.82%--shrink_inactive_list
>                           |          
>                            --16.55%--shrink_page_list
>                                      |          
>                                       --16.26%--_raw_spin_lock_irqsave
>                                                 queued_spin_lock_slowpath

Yeah, so it largely ends up in the same place, with the spinlock
contention dominating the CPU usage and efficiency of memory
reclaim.

> > i.e. when memory reclaim kicks in, the read process has 20% less
> > time with exclusive access to the mapping tree to insert new pages.
> > Hence buffered read performance goes down quite substantially when
> > memory reclaim kicks in, and this really has nothing to do with the
> > memory reclaim LRU scanning algorithm.
> > 
> > I can actually get this machine to pin those 5 processes to 100% CPU
> > under certain conditions. Each process is spinning all that extra
> > time on the mapping tree lock, and performance degrades further.
> > Changing the LRU reclaim algorithm won't fix this - the workload is
> > solidly bound by the exclusive nature of the mapping tree lock and
> > the number of tasks trying to obtain it exclusively...
> 
> I've seen way worse than the above as well, it's just my go-to easy test
> case for "man I wish buffered IO didn't suck so much".

*nod*

> >> The initial posting of this patchset did no better, in fact it did a bit
> >> worse. Performance dropped to the same levels and kswapd was using as
> >> much CPU as before, but on top of that we also got excessive swapping.
> >> Not at a high rate, but 5-10MB/sec continually.
> >>
> >> I had some back and forths with Yu Zhao and tested a few new revisions,
> >> and the current series does much better in this regard. Performance
> >> still dips a bit when page cache fills, but not nearly as much, and
> >> kswapd is using less CPU than before.
> > 
> > Profiles would be interesting, because it sounds to me like reclaim
> > *might* be batching page cache removal better (e.g. fewer, larger
> > batches) and so spending less time contending on the mapping tree
> > lock...
> > 
> > IOWs, I suspect this result might actually be a result of less lock
> > contention due to a change in batch processing characteristics of
> > the new algorithm rather than it being a "better" algorithm...
> 
> See above - let me know if you want to see more specific profiling as
> well.

I don't think that profiles are going to give us the level of detail
required to determine how this algorithm is improving performance.
That would require careful instrumentation of the memory reclaim
algorithms to demonstrate any significant change in behaviour, and
then to prove that it's a predictable, consistent improvement across
all types of machines rather than just being a freak of interactions
with a specific workload on specific hardware would need to be done.

When it comes to lock contention like this, you can't infer anything
about external algorithm changes because better algorithms often
make contention worse because the locks are hit harder and so
performance goes the wrong way. Similarly, if the external algorithm
change takes more time to do something because it is less efficient,
then locks are hit less hard, so they contend less, and performance
goes up.

I often see an external change cause a small reduction in lock
contention and increase in throughput through a heavily contended
path is often a sign something is slower or behaving worse, not
better. THe only way to determine if the external change is any good
is to first fix the lock contention problem, then do back to back
testing of the change.

Hence I'd be very hesitant to use this test in any way as a measure
of whether the multi-gen LRU is any better for this workload or
not...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
