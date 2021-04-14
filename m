Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63B635F124
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 12:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348103AbhDNKAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 06:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346491AbhDNKAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 06:00:34 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D60C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 03:00:12 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id s16so14813917iog.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 03:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=swi+6kI5Lk3F77BNju/FBA7qsCHeXk+GPezJxX+2Hcc=;
        b=wFKtJfxIABTmiQDEfm7rWPGz6rXnuPaF+sLVoHM51LkYyZt7UcAdGppARYFDIxSXPQ
         P/LhbFST1y/mX7ytG2MhDtQ3JlDxsk0JWjJmolHQf/vFxoz/PeP4PcBfThg/fw1n8FqE
         Y3771lL9inQwqzxXDY0ASzzlwb/IyrW2U7Db1Lp18/c5S9RDLV54wfyogZyGdSYI/eZI
         4yjYk+iYJLwYRWIRbA7h2erF/yoxGczTNSFXeDBFV8q689IEZ6KYu3UFmlncNzSEu3DV
         VbHQ5mTMfZT39dLR2dKqUEffE9CpVrOdvUrCTWgMp1MSox4sNjcf+UNQD+nbSe4AXR69
         pZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=swi+6kI5Lk3F77BNju/FBA7qsCHeXk+GPezJxX+2Hcc=;
        b=U/c6I+dQJgzdvPJr8ONvT6XKbKDu/LSe6Xmzga08rt0yY2DgtAgvml2n8TS/1ELacU
         XbERx0g1X66KpjQClOe68zwj51EnZGX6gx+xmh8bfQK5d2PN03tAKUYqYIs+k3tJH2hS
         wRa4V61EcMkPVinaLuai4OsXw4PdzKcedXScUDbi9gvERrUmF7RSOIAZlFU0KwcmA0/D
         LEFrc4CkNOGXV/K3qRhv2EOiqZ4mIdkYIATNAofKJjNi9pkTYfAuTJjQ486xFUALAhJq
         zLkMIb3n8ckeVz6XBmYh244rRIlO1bsDfUws58dAdtArtE+dOGkMCfcAtfXPZS09/i5C
         /yqg==
X-Gm-Message-State: AOAM533g3oGT3IYyr6qqHAHSjYY6TT0FpVh1rwsLT3UdPmAMmHIy0VTG
        FHe2wjQqNolelzACmQ0D22K41g==
X-Google-Smtp-Source: ABdhPJzOHyPBiGGCOh9t+y3JEbx8ndRwoe05bs+4vJk+Fuyl9XhnH56JSk+rkVz/BGhNNc4ZI5UPFw==
X-Received: by 2002:a05:6638:20a:: with SMTP id e10mr10703880jaq.48.1618394411106;
        Wed, 14 Apr 2021 03:00:11 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:2822:c2d3:ef00:fa3c])
        by smtp.gmail.com with ESMTPSA id l1sm8050426ioj.52.2021.04.14.03.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 03:00:10 -0700 (PDT)
Date:   Wed, 14 Apr 2021 04:00:05 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Dave Chinner <david@fromorbit.com>
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
Message-ID: <YHa9Ja6e17f2LeKA@google.com>
References: <20210413075155.32652-1-sjpark@amazon.de>
 <3ddd4f8a-8e51-662b-df11-a63a0e75b2bc@kernel.dk>
 <20210413231436.GF63242@dread.disaster.area>
 <CAOUHufa7RCK6gcYSeLv98w3_NY-TUpUNkDS0p_W4u5_ZfSXTsg@mail.gmail.com>
 <20210414045006.GR1990290@dread.disaster.area>
 <CAOUHufa5id9mmjud-UQd4agLCtmDypdNDStkxgoQxsUoh8Qcsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOUHufa5id9mmjud-UQd4agLCtmDypdNDStkxgoQxsUoh8Qcsg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 01:16:52AM -0600, Yu Zhao wrote:
> On Tue, Apr 13, 2021 at 10:50 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Tue, Apr 13, 2021 at 09:40:12PM -0600, Yu Zhao wrote:
> > > On Tue, Apr 13, 2021 at 5:14 PM Dave Chinner <david@fromorbit.com> wrote:
> > > > On Tue, Apr 13, 2021 at 10:13:24AM -0600, Jens Axboe wrote:
> > > > > On 4/13/21 1:51 AM, SeongJae Park wrote:
> > > > > > From: SeongJae Park <sjpark@amazon.de>
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > >
> > > > > > Very interesting work, thank you for sharing this :)
> > > > > >
> > > > > > On Tue, 13 Apr 2021 00:56:17 -0600 Yu Zhao <yuzhao@google.com> wrote:
> > > > > >
> > > > > >> What's new in v2
> > > > > >> ================
> > > > > >> Special thanks to Jens Axboe for reporting a regression in buffered
> > > > > >> I/O and helping test the fix.
> > > > > >
> > > > > > Is the discussion open?  If so, could you please give me a link?
> > > > >
> > > > > I wasn't on the initial post (or any of the lists it was posted to), but
> > > > > it's on the google page reclaim list. Not sure if that is public or not.
> > > > >
> > > > > tldr is that I was pretty excited about this work, as buffered IO tends
> > > > > to suck (a lot) for high throughput applications. My test case was
> > > > > pretty simple:
> > > > >
> > > > > Randomly read a fast device, using 4k buffered IO, and watch what
> > > > > happens when the page cache gets filled up. For this particular test,
> > > > > we'll initially be doing 2.1GB/sec of IO, and then drop to 1.5-1.6GB/sec
> > > > > with kswapd using a lot of CPU trying to keep up. That's mainline
> > > > > behavior.
> > > >
> > > > I see this exact same behaviour here, too, but I RCA'd it to
> > > > contention between the inode and memory reclaim for the mapping
> > > > structure that indexes the page cache. Basically the mapping tree
> > > > lock is the contention point here - you can either be adding pages
> > > > to the mapping during IO, or memory reclaim can be removing pages
> > > > from the mapping, but we can't do both at once.
> > > >
> > > > So we end up with kswapd spinning on the mapping tree lock like so
> > > > when doing 1.6GB/s in 4kB buffered IO:
> > > >
> > > > -   20.06%     0.00%  [kernel]               [k] kswapd                                                                                                        ▒
> > > >    - 20.06% kswapd                                                                                                                                             ▒
> > > >       - 20.05% balance_pgdat                                                                                                                                   ▒
> > > >          - 20.03% shrink_node                                                                                                                                  ▒
> > > >             - 19.92% shrink_lruvec                                                                                                                             ▒
> > > >                - 19.91% shrink_inactive_list                                                                                                                   ▒
> > > >                   - 19.22% shrink_page_list                                                                                                                    ▒
> > > >                      - 17.51% __remove_mapping                                                                                                                 ▒
> > > >                         - 14.16% _raw_spin_lock_irqsave                                                                                                        ▒
> > > >                            - 14.14% do_raw_spin_lock                                                                                                           ▒
> > > >                                 __pv_queued_spin_lock_slowpath                                                                                                 ▒
> > > >                         - 1.56% __delete_from_page_cache                                                                                                       ▒
> > > >                              0.63% xas_store                                                                                                                   ▒
> > > >                         - 0.78% _raw_spin_unlock_irqrestore                                                                                                    ▒
> > > >                            - 0.69% do_raw_spin_unlock                                                                                                          ▒
> > > >                                 __raw_callee_save___pv_queued_spin_unlock                                                                                      ▒
> > > >                      - 0.82% free_unref_page_list                                                                                                              ▒
> > > >                         - 0.72% free_unref_page_commit                                                                                                         ▒
> > > >                              0.57% free_pcppages_bulk                                                                                                          ▒
> > > >
> > > > And these are the processes consuming CPU:
> > > >
> > > >    5171 root      20   0 1442496   5696   1284 R  99.7   0.0   1:07.78 fio
> > > >    1150 root      20   0       0      0      0 S  47.4   0.0   0:22.70 kswapd1
> > > >    1146 root      20   0       0      0      0 S  44.0   0.0   0:21.85 kswapd0
> > > >    1152 root      20   0       0      0      0 S  39.7   0.0   0:18.28 kswapd3
> > > >    1151 root      20   0       0      0      0 S  15.2   0.0   0:12.14 kswapd2
> > > >
> > > > i.e. when memory reclaim kicks in, the read process has 20% less
> > > > time with exclusive access to the mapping tree to insert new pages.
> > > > Hence buffered read performance goes down quite substantially when
> > > > memory reclaim kicks in, and this really has nothing to do with the
> > > > memory reclaim LRU scanning algorithm.
> > > >
> > > > I can actually get this machine to pin those 5 processes to 100% CPU
> > > > under certain conditions. Each process is spinning all that extra
> > > > time on the mapping tree lock, and performance degrades further.
> > > > Changing the LRU reclaim algorithm won't fix this - the workload is
> > > > solidly bound by the exclusive nature of the mapping tree lock and
> > > > the number of tasks trying to obtain it exclusively...
> > > >
> > > > > The initial posting of this patchset did no better, in fact it did a bit
> > > > > worse. Performance dropped to the same levels and kswapd was using as
> > > > > much CPU as before, but on top of that we also got excessive swapping.
> > > > > Not at a high rate, but 5-10MB/sec continually.
> > > > >
> > > > > I had some back and forths with Yu Zhao and tested a few new revisions,
> > > > > and the current series does much better in this regard. Performance
> > > > > still dips a bit when page cache fills, but not nearly as much, and
> > > > > kswapd is using less CPU than before.
> > > >
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
> 
> > > And kswapd is only one of two paths that could affect the performance.
> > > The kernel context of the test process is where the improvement mainly
> > > comes from.
> > >
> > > I also suspect you were testing a file much larger than your memory
> > > size. If so, sorry to tell you that a file only a few times larger,
> > > e.g. twice, would be worse.
> > >
> > > Here is my take:
> > >
> > > Claim
> > > -----
> > > This patchset is a "better" algorithm. (Technically it's not an
> > > algorithm, it's a feedback loop.)
> > >
> > > Theoretical basis
> > > -----------------
> > > An open-loop control (the mainline) can only be better if the margin
> > > of error in its prediction of the future events is less than that from
> > > the trial-and-error of a closed-loop control (this patchset). For
> > > simple machines, it surely can. For page reclaim, AFAIK, it can't.
> > >
> > > A typical example: when randomly accessing a (not infinitely) large
> > > file via buffered io long enough, we're bound to hit the same blocks
> > > multiple times. Should we activate the pages containing those blocks,
> > > i.e., to move them to the active lru list?  No.
> > >
> > > RCA
> > > ---
> > > For the fio/io_uring benchmark, the "No" is the key.
> > >
> > > The mainline activates pages accessed multiple times. This is done in
> > > the buffered io access path by mark_page_accessed(), and it takes the
> > > lru lock, which is contended under memory pressure. This contention
> > > slows down both the access path and kswapd. But kswapd is not the
> > > problem here because we are measuring the io_uring process, not kswap.
> > >
> > > For this patchset, there are no activations since the refault rates of
> > > pages accessed multiple times are similar to those accessed only once
> > > -- activations will only be done to pages from tiers with higher
> > > refault rates.
> > >
> > > If you wish to debunk
> > > ---------------------
> >
> > Nope, it's your job to convince us that it works, not the other way
> > around. It's up to you to prove that your assertions are correct,
> > not for us to prove they are false.
> 
> Just trying to keep people motivated, my homework is my own.
> 
> > > git fetch https://linux-mm.googlesource.com/page-reclaim refs/changes/73/1173/1
> > >
> > > CONFIG_LRU_GEN=y
> > > CONFIG_LRU_GEN_ENABLED=y
> > >
> > > Run your benchmarks
> > >
> > > Profiles (200G mem + 400G file)
> > > -------------------------------
> > > A quick test from Jens' fio/io_uring:
> > >
> > > -rc7
> > >     13.30%  io_uring  xas_load
> > >     13.22%  io_uring  _copy_to_iter
> > >     12.30%  io_uring  __add_to_page_cache_locked
> > >      7.43%  io_uring  clear_page_erms
> > >      4.18%  io_uring  filemap_get_read_batch
> > >      3.54%  io_uring  get_page_from_freelist
> > >      2.98%  io_uring  ***native_queued_spin_lock_slowpath***
> > >      1.61%  io_uring  page_cache_ra_unbounded
> > >      1.16%  io_uring  xas_start
> > >      1.08%  io_uring  filemap_read
> > >      1.07%  io_uring  ***__activate_page***
> > >
> > > lru lock: 2.98% (lru addition + activation)
> > > activation: 1.07%
> > >
> > > -rc7 + this patchset
> > >     14.44%  io_uring  xas_load
> > >     14.14%  io_uring  _copy_to_iter
> > >     11.15%  io_uring  __add_to_page_cache_locked
> > >      6.56%  io_uring  clear_page_erms
> > >      4.44%  io_uring  filemap_get_read_batch
> > >      2.14%  io_uring  get_page_from_freelist
> > >      1.32%  io_uring  page_cache_ra_unbounded
> > >      1.20%  io_uring  psi_group_change
> > >      1.18%  io_uring  filemap_read
> > >      1.09%  io_uring  ****native_queued_spin_lock_slowpath****
> > >      1.08%  io_uring  do_mpage_readpage
> > >
> > > lru lock: 1.09% (lru addition only)
> >
> > All this tells us is that there was *less contention on the mapping
> > tree lock*. It does not tell us why there was less contention.
> >
> > You've handily omitted the kswapd profile, which is really the one
> > of interest to the discussion here - how did the memory reclaim CPU
> > usage profile also change at the same time?
> 
> Well, let me attach them. Suffix -1 is the mainline, -2 is the patchset.
> 
>   mainline
>      57.65%  kswapd0  __remove_mapping
>   this patchset
>      61.61%  kswapd0  __remove_mapping
> 
> As I said, the mapping lock contention penalizes both heavily. Its
> percentage is even higher with the patchset, because it has less
> overhead. I'm trying to explain "the less overhead" part: it's the
> activations that make the mainline worse.
> 
>   mainline
>     6.53%  kswapd0  shrink_active_list
>   this patchset
>     0
> 
> From the io_uring context:
>   mainline
>      2.53%  io_uring  mark_page_accessed
>   this patchset
>      0.52%  io_uring  mark_page_accessed
> 
> mark_page_accessed() moves pages accessed multiple times to the active
> lru list. Then shrink_active_list() moves them back to the inactive
> list. All for nothing.
> 
> I don't want to paste everything here -- they'd clutter. Please see
> all the detailed profiles in the attachment. Let me know if their
> formats are no to your liking. I still have the raw perf.data.
> 
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

I apologize for the spam. Apparent the attachment in my previous email
didn't reach everybody. I hope this would work:

git clone https://linux-mm.googlesource.com/benchmarks

Repo contains profiles collected when running fio/io_uring,
  mainline:
    kswapd-1.txt
    kswapd-1.svg
    io_uring-1.txt
    io_uring-1.svg
  
  patched:
    kswapd-2.txt
    kswapd-2.svg
    io_uring-2.txt
    io_uring-2.svg

Thanks.
