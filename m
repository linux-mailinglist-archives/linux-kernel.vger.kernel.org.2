Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A8F307763
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 14:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhA1NqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 08:46:16 -0500
Received: from outbound-smtp35.blacknight.com ([46.22.139.218]:42381 "EHLO
        outbound-smtp35.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229652AbhA1NqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 08:46:10 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp35.blacknight.com (Postfix) with ESMTPS id 98554232B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 13:45:14 +0000 (GMT)
Received: (qmail 21334 invoked from network); 28 Jan 2021 13:45:14 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 28 Jan 2021 13:45:14 -0000
Date:   Thu, 28 Jan 2021 13:45:12 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, guro@fb.com,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        aneesh.kumar@linux.ibm.com, Jann Horn <jannh@google.com>
Subject: Re: [RFC PATCH v0] mm/slub: Let number of online CPUs determine the
 slub page order
Message-ID: <20210128134512.GF3592@techsingularity.net>
References: <20201118082759.1413056-1-bharata@linux.ibm.com>
 <CAKfTPtA_JgMf_+zdFbcb_V9rM7JBWNPjAz9irgwFj7Rou=xzZg@mail.gmail.com>
 <20210121053003.GB2587010@in.ibm.com>
 <alpine.DEB.2.22.394.2101210959060.100764@www.lameter.com>
 <d7fb9425-9a62-c7b8-604d-5828d7e6b1da@suse.cz>
 <20210126085243.GE827@dhcp22.suse.cz>
 <CAKfTPtAhqiHtPMUTZv8Bs3Cg5=HXLmrda=j4_HFrF=7ztYZLGA@mail.gmail.com>
 <20210126135918.GQ827@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210126135918.GQ827@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 02:59:18PM +0100, Michal Hocko wrote:
> > > This thread shows that this is still somehow related to performance but
> > > the real reason is not clear. I believe we should be focusing on the
> > > actual reasons for the performance impact than playing with some fancy
> > > math and tuning for a benchmark on a particular machine which doesn't
> > > work for others due to subtle initialization timing issues.
> > >
> > > Fundamentally why should higher number of CPUs imply the size of slab in
> > > the first place?
> > 
> > A 1st answer is that the activity and the number of threads involved
> > scales with the number of CPUs. Regarding the hackbench benchmark as
> > an example, the number of group/threads raise to a higher level on the
> > server than on the small system which doesn't seem unreasonable.
> > 
> > On 8 CPUs, I run hackbench with up to 16 groups which means 16*40
> > threads. But I raise up to 256 groups, which means 256*40 threads, on
> > the 224 CPUs system. In fact, hackbench -g 1 (with 1 group) doesn't
> > regress on the 224 CPUs  system.  The next test with 4 groups starts
> > to regress by -7%. But the next one: hackbench -g 16 regresses by 187%
> > (duration is almost 3 times longer). It seems reasonable to assume
> > that the number of running threads and resources scale with the number
> > of CPUs because we want to run more stuff.
> 
> OK, I do understand that more jobs scale with the number of CPUs but I
> would also expect that higher order pages are generally more expensive
> to get so this is not really a clear cut especially under some more
> demand on the memory where allocations are smooth. So the question
> really is whether this is not just optimizing for artificial conditions.

The flip side is that smaller orders increase zone lock contention and
contention can csale with the number of CPUs so it's partially related.
hackbench-sockets is an extreme case (pipetest is not affected) but it's
the messenger in this case.

On a x86-64 2-socket 40 core (80 threads) machine then comparing a revert
of the patch with vanilla 5.11-rc5 is

hackbench-process-sockets
                            5.11-rc5               5.11-rc5
                     revert-lockstat       vanilla-lockstat
Amean     1        1.1560 (   0.00%)      1.0633 *   8.02%*
Amean     4        2.0797 (   0.00%)      2.5470 * -22.47%*
Amean     7        3.2693 (   0.00%)      4.3433 * -32.85%*
Amean     12       5.2043 (   0.00%)      6.5600 * -26.05%*
Amean     21      10.5817 (   0.00%)     11.3320 *  -7.09%*
Amean     30      13.3923 (   0.00%)     15.5817 * -16.35%*
Amean     48      20.3893 (   0.00%)     23.6733 * -16.11%*
Amean     79      31.4210 (   0.00%)     38.2787 * -21.83%*
Amean     110     43.6177 (   0.00%)     53.8847 * -23.54%*
Amean     141     56.3840 (   0.00%)     68.4257 * -21.36%*
Amean     172     70.0577 (   0.00%)     85.0077 * -21.34%*
Amean     203     81.9717 (   0.00%)    100.7137 * -22.86%*
Amean     234     95.1900 (   0.00%)    116.0280 * -21.89%*
Amean     265    108.9097 (   0.00%)    130.4307 * -19.76%*
Amean     296    119.7470 (   0.00%)    142.3637 * -18.89%*

i.e. the patch incurs a 7% to 32% performance penalty. This bisected
cleanly yesterday when I was looking for the regression and then found
the thread.

Numerous caches change size. For example, kmalloc-512 goes from order-0
(vanilla) to order-2 with the revert.

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                              class name    con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

VANILLA
                             &zone->lock:       1202731        1203433           0.07         120.55     1555485.48           1.29        8920825       12537091           0.06          84.10     9855085.12           0.79
                             -----------
                             &zone->lock          61903          [<00000000b47dc96a>] free_one_page+0x3f/0x530
                             &zone->lock           7655          [<00000000099f6e05>] get_page_from_freelist+0x475/0x1370
                             &zone->lock          36529          [<0000000075b9b918>] free_pcppages_bulk+0x1ac/0x7d0
                             &zone->lock        1097346          [<00000000b8e4950a>] get_page_from_freelist+0xaf0/0x1370
                             -----------
                             &zone->lock          44716          [<00000000099f6e05>] get_page_from_freelist+0x475/0x1370
                             &zone->lock          69813          [<0000000075b9b918>] free_pcppages_bulk+0x1ac/0x7d0
                             &zone->lock          31596          [<00000000b47dc96a>] free_one_page+0x3f/0x530
                             &zone->lock        1057308          [<00000000b8e4950a>] get_page_from_freelist+0xaf0/0x1370

REVERT
                             &zone->lock:        735827         739037           0.06          66.12      699661.56           0.95        4095299        7757942           0.05          54.35     5670083.68           0.73
                             -----------
                             &zone->lock         101927          [<00000000a60d5f86>] free_one_page+0x3f/0x530
                             &zone->lock         626426          [<00000000122cecf3>] get_page_from_freelist+0xaf0/0x1370
                             &zone->lock           9207          [<0000000068b9c9a1>] free_pcppages_bulk+0x1ac/0x7d0
                             &zone->lock           1477          [<00000000f856e720>] get_page_from_freelist+0x475/0x1370
                             -----------
                             &zone->lock           6249          [<00000000f856e720>] get_page_from_freelist+0x475/0x1370
                             &zone->lock          92224          [<00000000a60d5f86>] free_one_page+0x3f/0x530
                             &zone->lock          19690          [<0000000068b9c9a1>] free_pcppages_bulk+0x1ac/0x7d0
                             &zone->lock         620874          [<00000000122cecf3>] get_page_from_freelist+0xaf0/0x1370

Each individual wait time is small but the maximum waittime-max is roughly
double (120us vanilla vs 66us reverting the patch). Total wait time is
roughly doubled also due to the patch. Acquisitions are almost doubled.

So mostly this is down to the number of times SLUB calls into the page
allocator which only caches order-0 pages on a per-cpu basis. I do have
a prototype for a high-order per-cpu allocator but it is very rough --
high watermarks stop making sense, code is rough, memory needed for the
pcpu structures quadruples etc.


-- 
Mel Gorman
SUSE Labs
