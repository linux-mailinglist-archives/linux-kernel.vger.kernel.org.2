Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E15535AC64
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 11:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbhDJJWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 05:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhDJJWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 05:22:12 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532F1C061762
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 02:21:58 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id b17so6738299ilh.6
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 02:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OzwPX1/o3Ram2QFMCf5yecQn12h0wNq/11GYoURCNcw=;
        b=vwsamSYqIny/dimiP4I5CO3KaA2nMPJyl0NbbTaFXJny5lfegXDoOY67EdwW9aRbzH
         aIPn5vOmqXHFXMXqr+b+XYk2k6a/FKhCVkbHj6xXj8Wcpvn+JE798efBwosE6S8BQxmk
         fO1qX0RaolhOQ7c26JuDElwP4Tg8EYtTLYHZeZS55cyuDFfijRv8kU4g9/CvRwEH9qyi
         BezdC3hcnGXMtqf1LTrVv874aHth3jtIIbAJQCvZ3llSh6IyPib3VY/4Y0B0aK2kRtLR
         QsnAaUcqbTTfYAuDVr5CO9FVt4DccjWn737n5fUX30aUD2iiPZO7BU4rHU1H8BW6K6eR
         lssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OzwPX1/o3Ram2QFMCf5yecQn12h0wNq/11GYoURCNcw=;
        b=ONjtIQ2MqLoi7xzG+NbB4yn+nkFfBNRbQgYMqzgNVHjI7XbiCqFr1919Rx8TjQiwsd
         o4shrHjL6GjywH0Ragwp6nE81COqj+W+lV+zDQC/Q93ys3iG1oks6gJp7XT5xibGVtFX
         UfLmc2GH9133hdVR90oaZxEK6mA/tBHoeFbGezhdJ7E6gKjp0q7+d2hAWMe9yLMJEN7c
         mlM3XQ6cCUeTR97v2y3FzTawKIRFHzyLhWX7tqhoZjkOgthq51PYyskghtLCuDu2vs69
         4eFeaQlOGxk+fr/XYXlrbiRhXf7+GUGqs1arH2l0ke7JZvdSc4FITjeCkV/e2siosvIJ
         /IPw==
X-Gm-Message-State: AOAM532Hbu1mKOeAvm26iMvg2UTpJ+fCyTbUDKa0TvwEBZKdtCiwM9KV
        qPe4TEelxJHUMkqvnQrRn1Y0an6jB0g3rg==
X-Google-Smtp-Source: ABdhPJxtIwnOR9rKoUct/uc3grSgVSKl6javTQ0O+mM58drYnycz4OMhbWGm//qCs1k75khZdRRmiw==
X-Received: by 2002:a92:c7c5:: with SMTP id g5mr15116340ilk.122.1618046517344;
        Sat, 10 Apr 2021 02:21:57 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:3b3e:937c:c587:fc5d])
        by smtp.gmail.com with ESMTPSA id w9sm2469414iox.20.2021.04.10.02.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 02:21:55 -0700 (PDT)
Date:   Sat, 10 Apr 2021 03:21:51 -0600
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
Message-ID: <YHFuL/Ddtiml4biw@google.com>
References: <20210313075747.3781593-1-yuzhao@google.com>
 <5f621dd6-4bbd-dbf7-8fa1-d63d9a5bfc16@intel.com>
 <YFAW+PtJS7DEngFZ@google.com>
 <7378f56e-4bc0-51d0-4a61-26aa6969c0de@intel.com>
 <YFEVaZvsVt7nfhdM@google.com>
 <4e76078c-846f-a0f0-2349-12d9d806d1a8@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="l8xXx3urR6en4XlX"
Content-Disposition: inline
In-Reply-To: <4e76078c-846f-a0f0-2349-12d9d806d1a8@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l8xXx3urR6en4XlX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 16, 2021 at 02:14:43PM -0700, Dave Hansen wrote:
> On 3/16/21 1:30 PM, Yu Zhao wrote:
> > On Tue, Mar 16, 2021 at 07:50:23AM -0700, Dave Hansen wrote:
> >> I think it would also be very worthwhile to include some research in
> >> this series about why the kernel moved away from page table scanning.
> >> What has changed?  Are the workloads we were concerned about way back
> >> then not around any more?  Has faster I/O or larger memory sizes with a
> >> stagnating page size changed something?
> > 
> > Sure. Hugh also suggested this too but I personally found that ancient
> > pre-2.4 history too irrelevant (and uninteresting) to the modern age
> > and decided to spare audience of the boredom.
> 
> IIRC, rmap chains showed up in the 2.5 era and the VM was quite bumpy
> until anon_vmas came around, which was early-ish in the 2.6 era.
> 
> But, either way, I think there is a sufficient population of nostalgic
> crusty old folks around to warrant a bit of a history lesson.  We'll
> enjoy the trip down memory lane, fondly remembering the old days in
> Ottawa...
> 
> >>> nr_vmscan_write 24900719
> >>> nr_vmscan_immediate_reclaim 115535
> >>> pgscan_kswapd 320831544
> >>> pgscan_direct 23396383
> >>> pgscan_direct_throttle 0
> >>> pgscan_anon 127491077
> >>> pgscan_file 216736850
> >>> slabs_scanned 400469680
> >>> compact_migrate_scanned 1092813949
> >>> compact_free_scanned 4919523035
> >>> compact_daemon_migrate_scanned 2372223
> >>> compact_daemon_free_scanned 20989310
> >>> unevictable_pgs_scanned 307388545
> > 
> > 10G swap + 8G anon rss + 6G file rss, hmm... an interesting workload.
> > The file rss does seem a bit high to me, my wild speculation is there
> > have been git/make activities in addition to a VM?
> 
> I wish I was doing more git/make activities.  It's been an annoying
> amount of email and web browsers for 12 days.  If anything, I'd suspect
> that Thunderbird is at fault for keeping a bunch of mail in the page
> cache.  There are a couple of VM's running though.

Hi Dave,

Sorry for the late reply. Here is the benchmark result from the worst
case scenario.

As you suggested, we create a lot of processes sharing one large
sparse shmem, and they access the shmem at random 2MB-aligned offsets.
So there will be at most one valid PTE entry per PTE table, hence the
worst case scenario for the multigenerational LRU, since it is based
on page table scanning.

TL;DR: the multigenerational LRU did not perform worse than the rmap.

My test configurations:

  The size of the shmem: 256GB
  The number of processes: 450
  Total memory size: 200GB
  The number of CPUs: 64
  The number of nodes: 2

There is no clear winner in the background reclaim path (kswapd).

  kswapd (5.12.0-rc6):
    43.99%  kswapd1  page_vma_mapped_walk
    34.86%  kswapd0  page_vma_mapped_walk
     2.43%  kswapd0  count_shadow_nodes
     1.17%  kswapd1  page_referenced_one
     1.15%  kswapd0  _find_next_bit.constprop.0
     0.95%  kswapd0  page_referenced_one
     0.87%  kswapd1  try_to_unmap_one
     0.75%  kswapd0  cpumask_next
     0.67%  kswapd0  shrink_slab
     0.66%  kswapd0  down_read_trylock

  kswapd (the multigenerational LRU):
    33.39%  kswapd0  walk_pud_range
    10.93%  kswapd1  walk_pud_range
     9.36%  kswapd0  page_vma_mapped_walk
     7.15%  kswapd1  page_vma_mapped_walk
     3.83%  kswapd0  count_shadow_nodes
     2.60%  kswapd1  shrink_slab
     2.47%  kswapd1  down_read_trylock
     2.03%  kswapd0  _raw_spin_lock
     1.87%  kswapd0  shrink_slab
     1.67%  kswapd1  count_shadow_nodes

The multigenerational LRU is somewhat winning in the direct reclaim
path (sparse is the test binary name):

  The test process context (5.12.0-rc6):
    65.02%  sparse   page_vma_mapped_walk
     5.49%  sparse   page_counter_try_charge
     3.60%  sparse   propagate_protected_usage
     2.31%  sparse   page_counter_uncharge
     2.06%  sparse   count_shadow_nodes
     1.81%  sparse   native_queued_spin_lock_slowpath
     1.79%  sparse   down_read_trylock
     1.67%  sparse   page_referenced_one
     1.42%  sparse   shrink_slab
     0.87%  sparse   try_to_unmap_one

  CPU % (direct reclaim vs the rest): 71% vs 29%
  # grep oom_kill /proc/vmstat
  oom_kill 81

  The test process context (the multigenerational LRU):
    33.12%  sparse   page_vma_mapped_walk
    10.70%  sparse   walk_pud_range
     9.64%  sparse   page_counter_try_charge
     6.63%  sparse   propagate_protected_usage
     4.43%  sparse   native_queued_spin_lock_slowpath
     3.85%  sparse   page_counter_uncharge
     3.71%  sparse   irqentry_exit_to_user_mode
     2.16%  sparse   _raw_spin_lock
     1.83%  sparse   unmap_page_range
     1.82%  sparse   shrink_slab

  CPU % (direct reclaim vs the rest): 47% vs 53%
  # grep oom_kill /proc/vmstat
  oom_kill 80

I also compared other numbers from /proc/vmstat. They do not provide
any additional insight than the profiles, so I will just omit them
here.

The following optimizations and the stats measuring their efficacies
explain why the multigenerational LRU did not perform worse:

  Optimization 1: take advantage of the scheduling information.
    # of active processes           270
    # of inactive processes         105

  Optimization 2: take the advantage of the accessed bit on non-leaf
  PMD entries.
    # of old non-leaf PMD entries   30523335
    # of young non-leaf PMD entries 1358400

These stats are not currently included. But I will add them to the
debugfs interface in the next version coming soon. And I will also add
another optimization for Android. It reduces zigzags when there are
many single-page VMAs, i.e., not returning to the PGD table for each
of such VMAs. Just a heads-up.

The rmap, on the other hand, had to
  1) lock each (shmem) page it scans
  2) go through five levels of page tables for each page, even though
  some of them have the same LCAs
during the test. The second part is worse given that I have 5 levels
of page tables configured.

Any additional benchmarks you would suggest? Thanks.

--l8xXx3urR6en4XlX
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="sparse.c"

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/types.h>

#define NR_TASKS	450UL
#define MMAP_SIZE	(256UL << 30)

#define PMD_SIZE	(1UL << 21)
#define NR_PMDS		(MMAP_SIZE / PMD_SIZE)
#define NR_LOOPS	(NR_PMDS * 200)

int main(void)
{
	unsigned long i;
	void *start;
	pid_t pid;

	start = mmap(NULL, MMAP_SIZE, PROT_READ | PROT_WRITE,
		     MAP_ANONYMOUS | MAP_SHARED | MAP_NORESERVE, -1, 0);
	if (start == MAP_FAILED) {
		perror("mmap");
		return -1;
	}

	if (madvise(start, MMAP_SIZE, MADV_NOHUGEPAGE)) {
		perror("madvise");
		return -1;
	}

	for (i = 0; i < NR_TASKS; i++) {
		pid = fork();
		if (pid < 0) {
			perror("fork");
			return -1;
		}

		if (!pid)
			break;
	}

	pid = getpid();
	srand48(pid);

	for (i = 0; i < NR_LOOPS; i++) {
		unsigned long offset = (lrand48() % NR_PMDS) * PMD_SIZE;
		unsigned long *addr = start + offset;

		*addr = i;
	}

	return 0;
}

--l8xXx3urR6en4XlX--
