Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC83033DECE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 21:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhCPUa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 16:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhCPUaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 16:30:39 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19738C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 13:30:39 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id f10so13953825ilq.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 13:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/c3T5C9/0/6gu9M2ypjdfLKBZClamiOtsmCTUreEKsA=;
        b=OmDimc8N673Wag+Yx1Wf9NQMO42Jz4Pr3b8j3CSUeW/Pu7A0fVMRLofNpib26uq5y5
         3ooarYhRfIIrj2dZx/UCNFX6HVp1wEq6AJdClkjnHdh77GTEV9zSDyjZ2zwBG1E/295N
         jiJlqMeea96paZwIntvd1fjIC3uKQoMfhDQqH6+PCrZ79eVA9nAeAl9GU3q7gYTgPVH5
         bl54JgS9mvVkhB+2YPfwvomujUChvx08ESL1K41gz4+Z4B0bLMSo3bjvlBrzWnK1nqjo
         2Bo4opPofuB79lfl2TqCPiDeQPFR0UL1N8CKEUS/2zNJrE0Bg8ramlB5YHtKGMM8oTYc
         RZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/c3T5C9/0/6gu9M2ypjdfLKBZClamiOtsmCTUreEKsA=;
        b=ThLVftKEeTojxHmFWDmP8N6YaJL/QctCv+E0cMUbdMvcGbRRbkWYtNyjTob13Hz6vB
         ECcGuVR1V2yt/JM0eyjTiF/x+A07Xh0NZGhHEnWWzq5pYbvV8QWCRxfYKv4HaMqTevkG
         xjVb+SQjXMckFcrwhEBs4BT4P+M5Go21dlG7sJIQqBaXkiLIN6ZBARzYB6OgYxdyPSsf
         LBw8V/uCPqj0u1zhb7lY82CjbK7H1gHYBgB2HM8DQSK7u9au/EULgVA8FdzwUoRIh2Oa
         YQVDmB2B+5tKzvnppcmiHr8/ziTBoDr27hNwccyZtQZViqA8+TKTEXoMCGSh65TpcQm/
         QC/A==
X-Gm-Message-State: AOAM530EMi/UuZtgn+V/B3Qv/NMHFJC5viICkiDeB5VtZTQyCT/HgoMa
        svdUYSDxS5kdF4lop/k90Yvgqg==
X-Google-Smtp-Source: ABdhPJyYkTC4Mb8WYn+CFmJApuiYLuvsFUiv5pC+AS2yBXMSsCD2JgLZY6FdwHCKayGJuZFBmPhjWQ==
X-Received: by 2002:a05:6e02:1be2:: with SMTP id y2mr5049431ilv.20.1615926638332;
        Tue, 16 Mar 2021 13:30:38 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:85db:6a0d:7a4d:5606])
        by smtp.gmail.com with ESMTPSA id r3sm9889684ilq.42.2021.03.16.13.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 13:30:37 -0700 (PDT)
Date:   Tue, 16 Mar 2021 14:30:33 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-mm@kvack.org, Alex Shi <alex.shi@linux.alibaba.com>,
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
        Ying Huang <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, page-reclaim@google.com
Subject: Re: [PATCH v1 00/14] Multigenerational LRU
Message-ID: <YFEVaZvsVt7nfhdM@google.com>
References: <20210313075747.3781593-1-yuzhao@google.com>
 <5f621dd6-4bbd-dbf7-8fa1-d63d9a5bfc16@intel.com>
 <YFAW+PtJS7DEngFZ@google.com>
 <7378f56e-4bc0-51d0-4a61-26aa6969c0de@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7378f56e-4bc0-51d0-4a61-26aa6969c0de@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 07:50:23AM -0700, Dave Hansen wrote:
> On 3/15/21 7:24 PM, Yu Zhao wrote:
> > On Mon, Mar 15, 2021 at 11:00:06AM -0700, Dave Hansen wrote:
> >> How bad does this scanning get in the worst case if there's a lot of
> >> sharing?
> > 
> > Actually the improvement is larger when there is more sharing, i.e.,
> > higher map_count larger improvement. Let's assume we have a shmem
> > page mapped by two processes. To reclaim this page, we need to make
> > sure neither PTE from the two sets of page tables has the accessed
> > bit. The current page reclaim uses the rmap, i.e., rmap_walk_file().
> > It first looks up the two VMAs (from the two processes mapping this
> > shmem file) in the interval tree of this shmem file, then from each
> > VMA, it goes through PGD/PUD/PMD to reach the PTE. The page can't be
> > reclaimed if either of the PTEs has the accessed bit, therefore cost
> > of the scanning is more than proportional to the number of accesses,
> > when there is a lot sharing.
> > 
> > Why this series makes it better? We track the usage of page tables.
> > Specifically, we work alongside switch_mm(): if one of the processes
> > above hasn't be scheduled since the last scan, we don't need to scan
> > its page tables. So the cost is roughly proportional to the number of
> > accesses, regardless of how many processes. And instead of scanning
> > pages one by one, we do it in large batches. However, page tables can
> > be very sparse -- this is not a problem for the rmap because it knows
> > exactly where the PTEs are (by vma_address()). We only know ranges (by
> > vma->vm_start/vm_end). This is where the accessed bit on non-leaf
> > PMDs can be of help.
> 
> That's an interesting argument.  *But*, this pivoted into describing an
> optimization.  My takeaway from this is that large amounts of sharing
> are probably only handled well if the processes doing the sharing are
> not running constantly.
> 
> > But I guess you are wondering what downsides are. Well, we haven't
> > seen any (yet). We do have page cache (non-shmem) heavy workloads,
> > but not at a scale large enough to make any statistically meaningful
> > observations. We are very interested in working with anybody who has
> > page cache (non-shmem) heavy workloads and is willing to try out this
> > series.
> 
> I would also be very interested to see some synthetic, worst-case
> micros.  Maybe take a few thousand processes with very sparse page
> tables that all map some shared memory.  They wake up long enough to
> touch a few pages, then go back to sleep.
> 
> What happens if we do that?  I'm not saying this is a good workload or
> that things must behave well, but I do find it interesting to watch the
> worst case.

It is a reasonable request, thank you. I've just opened a bug to cover
this case (a large sparse shared shmem) and we'll have something soon.

> I think it would also be very worthwhile to include some research in
> this series about why the kernel moved away from page table scanning.
> What has changed?  Are the workloads we were concerned about way back
> then not around any more?  Has faster I/O or larger memory sizes with a
> stagnating page size changed something?

Sure. Hugh also suggested this too but I personally found that ancient
pre-2.4 history too irrelevant (and uninteresting) to the modern age
and decided to spare audience of the boredom.

> >> I'm kinda surprised by this, but my 16GB laptop has a lot more page
> >> cache than I would have guessed:
> >>
> >>> Active(anon):    4065088 kB
> >>> Inactive(anon):  3981928 kB
> >>> Active(file):    2260580 kB
> >>> Inactive(file):  3738096 kB
> >>> AnonPages:       6624776 kB
> >>> Mapped:           692036 kB
> >>> Shmem:            776276 kB
> >>
> >> Most of it isn't mapped, but it's far from all being used for text.
> > 
> > We have categorized two groups:
> >   1) average users that haven't experienced memory pressure since
> >   their systems have booted. The booting process fills up page cache
> >   with one-off file pages, and they remain until users experience
> >   memory pressure. This can be confirmed by looking at those counters
> >   of a freshly rebooted and idle system. My guess this is the case for
> >   your laptop.
> 
> It's been up ~12 days.  There is ~10GB of data in swap, and there's been
> a lot of scanning activity which I would associate with memory pressure:
> 
> > SwapCached:      1187596 kB
> > SwapTotal:      51199996 kB
> > SwapFree:       40419428 kB
> ...
> > nr_vmscan_write 24900719
> > nr_vmscan_immediate_reclaim 115535
> > pgscan_kswapd 320831544
> > pgscan_direct 23396383
> > pgscan_direct_throttle 0
> > pgscan_anon 127491077
> > pgscan_file 216736850
> > slabs_scanned 400469680
> > compact_migrate_scanned 1092813949
> > compact_free_scanned 4919523035
> > compact_daemon_migrate_scanned 2372223
> > compact_daemon_free_scanned 20989310
> > unevictable_pgs_scanned 307388545

10G swap + 8G anon rss + 6G file rss, hmm... an interesting workload.
The file rss does seem a bit high to me, my wild speculation is there
have been git/make activities in addition to a VM?
