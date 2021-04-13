Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59DC935E963
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 01:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347923AbhDMXA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 19:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbhDMXA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 19:00:58 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30DEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 16:00:37 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id p6so11280434wrn.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 16:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uc/qI649+Aw4V2RHjzy5KUoifzi0z1zolGGaWbVMo/E=;
        b=qkX1qShgeczbDikLazLU5S7HzT9K7qM5yIR2z6K4M0jey2XfYf94ywhDXDLCUPs/1Q
         kvnavrdHjBPAi2OVUsBWShQlWhgMECbvLeB7KjpbDn8ct0Bm3GgWEERc4B4t+yTnrfbA
         wgdXzviCiPCQfW8YCwyqKPBnVUXgTGA0ylbu2ZsGCeNwhoUBeDS/Nd7DP/9ZLwydR2kz
         F5AyrqSJfRYJk768XfhkVPWIPZ2eJJUD5n2RNH4rBGfgt56po42OSw0/IfccKmwD4A1v
         lTgkX2YpLTgWx1es/qEYgtB+0Tv+EccbGVJVQrjEk8J2F/wSltGLfJn/mb63mJjrNwqL
         QTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uc/qI649+Aw4V2RHjzy5KUoifzi0z1zolGGaWbVMo/E=;
        b=g4JPLC3zFDPRh4MwijqJ7fJM6xek/4CFq40VrSMr3kvA1o9eABxcFqz02wzAPRNIvR
         maFHE5X5ie86pKS5fuBBeIIGuTWxTpQR601GfiE9HpjZLaheqwJEZRmr7bH1/op7sk5/
         P8leC6+dTca921Rc/JSHpLfbBuYvsp1/8sy5P3lfQPrh6ICcJBTFb+8CFnh3p/Kq8MAY
         Zyj/LKAQo1NQsaQfY9nXrKJI/ojMtLTDgtqvnBGmlX7lvVWliq2PRGvXIg5VvKvx3IZx
         c1Ie07+tmQKn6hVo7lqBe3BGL9P2dH4O4vLvq2noJDuicsfXfIFI5jluxjDCpzbRLXY2
         kY3g==
X-Gm-Message-State: AOAM531Fa+/FQBKgTJq2gxkOTgcZVfTi2dHSpm2g9DmeD3WQGs61p1QZ
        w+52rM5/QrTvJFQZOt3esQ+V9OcQDW6ztfdl5x4CJA==
X-Google-Smtp-Source: ABdhPJzrUmC9QGQegQ4X7p1ZBnqKLClRcSMckt7HytHe4+p+FRHtL/cq2VAZ/LjPtUBeJ2Ym1CLWReKii3rCfCj704o=
X-Received: by 2002:a5d:6a84:: with SMTP id s4mr31138244wru.92.1618354836244;
 Tue, 13 Apr 2021 16:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210313075747.3781593-1-yuzhao@google.com> <5f621dd6-4bbd-dbf7-8fa1-d63d9a5bfc16@intel.com>
 <YFAW+PtJS7DEngFZ@google.com> <7378f56e-4bc0-51d0-4a61-26aa6969c0de@intel.com>
 <YFEVaZvsVt7nfhdM@google.com> <4e76078c-846f-a0f0-2349-12d9d806d1a8@intel.com>
 <YHFuL/Ddtiml4biw@google.com> <87zgy2ubtd.fsf@yhuang6-desk1.ccr.corp.intel.com>
In-Reply-To: <87zgy2ubtd.fsf@yhuang6-desk1.ccr.corp.intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 13 Apr 2021 17:00:24 -0600
Message-ID: <CAOUHufbTCwPP5KtOMmrYPJ-4RpHWJHJQx7k4S95_vQCHm+zXtg@mail.gmail.com>
Subject: Re: [PATCH v1 00/14] Multigenerational LRU
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, Linux-MM <linux-mm@kvack.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Yang Shi <shy828301@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 9:02 PM Huang, Ying <ying.huang@intel.com> wrote:
>
> Yu Zhao <yuzhao@google.com> writes:
>
> > On Tue, Mar 16, 2021 at 02:14:43PM -0700, Dave Hansen wrote:
> >> On 3/16/21 1:30 PM, Yu Zhao wrote:
> >> > On Tue, Mar 16, 2021 at 07:50:23AM -0700, Dave Hansen wrote:
> >> >> I think it would also be very worthwhile to include some research in
> >> >> this series about why the kernel moved away from page table scanning.
> >> >> What has changed?  Are the workloads we were concerned about way back
> >> >> then not around any more?  Has faster I/O or larger memory sizes with a
> >> >> stagnating page size changed something?
> >> >
> >> > Sure. Hugh also suggested this too but I personally found that ancient
> >> > pre-2.4 history too irrelevant (and uninteresting) to the modern age
> >> > and decided to spare audience of the boredom.
> >>
> >> IIRC, rmap chains showed up in the 2.5 era and the VM was quite bumpy
> >> until anon_vmas came around, which was early-ish in the 2.6 era.
> >>
> >> But, either way, I think there is a sufficient population of nostalgic
> >> crusty old folks around to warrant a bit of a history lesson.  We'll
> >> enjoy the trip down memory lane, fondly remembering the old days in
> >> Ottawa...
> >>
> >> >>> nr_vmscan_write 24900719
> >> >>> nr_vmscan_immediate_reclaim 115535
> >> >>> pgscan_kswapd 320831544
> >> >>> pgscan_direct 23396383
> >> >>> pgscan_direct_throttle 0
> >> >>> pgscan_anon 127491077
> >> >>> pgscan_file 216736850
> >> >>> slabs_scanned 400469680
> >> >>> compact_migrate_scanned 1092813949
> >> >>> compact_free_scanned 4919523035
> >> >>> compact_daemon_migrate_scanned 2372223
> >> >>> compact_daemon_free_scanned 20989310
> >> >>> unevictable_pgs_scanned 307388545
> >> >
> >> > 10G swap + 8G anon rss + 6G file rss, hmm... an interesting workload.
> >> > The file rss does seem a bit high to me, my wild speculation is there
> >> > have been git/make activities in addition to a VM?
> >>
> >> I wish I was doing more git/make activities.  It's been an annoying
> >> amount of email and web browsers for 12 days.  If anything, I'd suspect
> >> that Thunderbird is at fault for keeping a bunch of mail in the page
> >> cache.  There are a couple of VM's running though.
> >
> > Hi Dave,
> >
> > Sorry for the late reply. Here is the benchmark result from the worst
> > case scenario.
> >
> > As you suggested, we create a lot of processes sharing one large
> > sparse shmem, and they access the shmem at random 2MB-aligned offsets.
> > So there will be at most one valid PTE entry per PTE table, hence the
> > worst case scenario for the multigenerational LRU, since it is based
> > on page table scanning.
> >
> > TL;DR: the multigenerational LRU did not perform worse than the rmap.
> >
> > My test configurations:
> >
> >   The size of the shmem: 256GB
> >   The number of processes: 450
> >   Total memory size: 200GB
> >   The number of CPUs: 64
> >   The number of nodes: 2
> >
> > There is no clear winner in the background reclaim path (kswapd).
> >
> >   kswapd (5.12.0-rc6):
> >     43.99%  kswapd1  page_vma_mapped_walk
> >     34.86%  kswapd0  page_vma_mapped_walk
> >      2.43%  kswapd0  count_shadow_nodes
> >      1.17%  kswapd1  page_referenced_one
> >      1.15%  kswapd0  _find_next_bit.constprop.0
> >      0.95%  kswapd0  page_referenced_one
> >      0.87%  kswapd1  try_to_unmap_one
> >      0.75%  kswapd0  cpumask_next
> >      0.67%  kswapd0  shrink_slab
> >      0.66%  kswapd0  down_read_trylock
> >
> >   kswapd (the multigenerational LRU):
> >     33.39%  kswapd0  walk_pud_range
> >     10.93%  kswapd1  walk_pud_range
> >      9.36%  kswapd0  page_vma_mapped_walk
> >      7.15%  kswapd1  page_vma_mapped_walk
> >      3.83%  kswapd0  count_shadow_nodes
> >      2.60%  kswapd1  shrink_slab
> >      2.47%  kswapd1  down_read_trylock
> >      2.03%  kswapd0  _raw_spin_lock
> >      1.87%  kswapd0  shrink_slab
> >      1.67%  kswapd1  count_shadow_nodes
> >
> > The multigenerational LRU is somewhat winning in the direct reclaim
> > path (sparse is the test binary name):
> >
> >   The test process context (5.12.0-rc6):
> >     65.02%  sparse   page_vma_mapped_walk
> >      5.49%  sparse   page_counter_try_charge
> >      3.60%  sparse   propagate_protected_usage
> >      2.31%  sparse   page_counter_uncharge
> >      2.06%  sparse   count_shadow_nodes
> >      1.81%  sparse   native_queued_spin_lock_slowpath
> >      1.79%  sparse   down_read_trylock
> >      1.67%  sparse   page_referenced_one
> >      1.42%  sparse   shrink_slab
> >      0.87%  sparse   try_to_unmap_one
> >
> >   CPU % (direct reclaim vs the rest): 71% vs 29%
> >   # grep oom_kill /proc/vmstat
> >   oom_kill 81
> >
> >   The test process context (the multigenerational LRU):
> >     33.12%  sparse   page_vma_mapped_walk
> >     10.70%  sparse   walk_pud_range
> >      9.64%  sparse   page_counter_try_charge
> >      6.63%  sparse   propagate_protected_usage
> >      4.43%  sparse   native_queued_spin_lock_slowpath
> >      3.85%  sparse   page_counter_uncharge
> >      3.71%  sparse   irqentry_exit_to_user_mode
> >      2.16%  sparse   _raw_spin_lock
> >      1.83%  sparse   unmap_page_range
> >      1.82%  sparse   shrink_slab
> >
> >   CPU % (direct reclaim vs the rest): 47% vs 53%
> >   # grep oom_kill /proc/vmstat
> >   oom_kill 80
> >
> > I also compared other numbers from /proc/vmstat. They do not provide
> > any additional insight than the profiles, so I will just omit them
> > here.
> >
> > The following optimizations and the stats measuring their efficacies
> > explain why the multigenerational LRU did not perform worse:
> >
> >   Optimization 1: take advantage of the scheduling information.
> >     # of active processes           270
> >     # of inactive processes         105
> >
> >   Optimization 2: take the advantage of the accessed bit on non-leaf
> >   PMD entries.
> >     # of old non-leaf PMD entries   30523335
> >     # of young non-leaf PMD entries 1358400
> >
> > These stats are not currently included. But I will add them to the
> > debugfs interface in the next version coming soon. And I will also add
> > another optimization for Android. It reduces zigzags when there are
> > many single-page VMAs, i.e., not returning to the PGD table for each
> > of such VMAs. Just a heads-up.
> >
> > The rmap, on the other hand, had to
> >   1) lock each (shmem) page it scans
> >   2) go through five levels of page tables for each page, even though
> >   some of them have the same LCAs
> > during the test. The second part is worse given that I have 5 levels
> > of page tables configured.
> >
> > Any additional benchmarks you would suggest? Thanks.
>
> Hi, Yu,
>
> Thanks for your data.
>
> In addition to the data your measured above, is it possible for you to
> measure some raw data?  For example, how many CPU cycles does it take to
> scan all pages in the system?  For the page table scanning, the page
> tables of all processes will be scanned.  For the rmap scanning, all
> pages in LRU will be scanned.  And we can do that with difference
> parameters, for example, shared vs. non-shared, sparse vs. dense.  Then
> we can get an idea about how fast the page table scanning can be.

SGTM. I'll get back to you later.
