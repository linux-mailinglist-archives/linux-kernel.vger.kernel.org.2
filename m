Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FA836A327
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 23:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237285AbhDXVW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 17:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbhDXVW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 17:22:27 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE3EC06174A
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 14:21:48 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id a4so51913804wrr.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 14:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N6ZF2+OsT/FqHeoV9YnViHXivGI5rukShRjJcrtS760=;
        b=bnINCtI2F2iWzqs/emb8RIU4sMUxZM1Fh+kgZwnXFLp4GuZlf67GYyFMJdsDe/KGHg
         ETBgpWs0ykzQtJKCZks9gKpeOxodYQmoLeWKlvJMw8uAnlejDy/95liwWajDpUBQQjq1
         6X5wfyzM1A/O8scI2rBXp6S3gtAvjoPCci9lU2KZPbX46JKLH3fA5fn0ZeGLDYeiVc9w
         93Rbj5KwyS94Bk2cOdFXM7BSJuR5/+59DwFdpV7zZ30POJWkrmKUseanLKnM+CmXucXV
         LwhRQRnxD4bigvBNJKkPi+YbMkvE1ZKvo6XTQx7g+nulyi9M2YDM/78sxTC/Z6xn1l/L
         6Ykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N6ZF2+OsT/FqHeoV9YnViHXivGI5rukShRjJcrtS760=;
        b=rBDN53ol7LJl9X6kpl9BPNsD6d2TAMr5bm5gAPgL1cAr0EAnAlEMT/G0Y8ICCCh9m3
         1+a6itd+LEMKMdh7WGwKFLy2AvWGv0kaMbknq9ENXMOQ00YzI0aLYMflazovbWNyt2P7
         MkmNj45wpEEFjDjkLRvboZPdqYe90lnvCIjf3zf7a+5miN8oC1ycmyaY+Tquoxfy2PQJ
         83mOXAfZfJnjRqx/r9rrTmcFktnn49+NFqP0xL8X98iIUdix3UUYpN1Wpq3uFgbG6Xum
         MV+3F1paZcqfFaAIAGHoLIf3KZtap+lFb5qbPbOnB2ZvpWKz3nvFV2hQgKwH8euNwmJU
         oibA==
X-Gm-Message-State: AOAM531y8/AKTWmVcekqKLmPaY+GSbGs8glxIhY/awPcaKotDPlstKu0
        8qeJ1McELHfkq045tUw8eHa7Mp1WPtgxMYugINfZYA==
X-Google-Smtp-Source: ABdhPJzDhsp4DP8Uqn+SAbO/jy9kVdEWuP/sHTQZK4Dsa89c7DhKpD9m9+Vrd+URmfrDXKTJfp0RGIIbRBb2KovdYU8=
X-Received: by 2002:adf:fa4c:: with SMTP id y12mr12700511wrr.358.1619299306999;
 Sat, 24 Apr 2021 14:21:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210413075155.32652-1-sjpark@amazon.de> <3ddd4f8a-8e51-662b-df11-a63a0e75b2bc@kernel.dk>
 <20210413231436.GF63242@dread.disaster.area> <CAOUHufa7RCK6gcYSeLv98w3_NY-TUpUNkDS0p_W4u5_ZfSXTsg@mail.gmail.com>
 <20210414045006.GR1990290@dread.disaster.area> <CAOUHufa5id9mmjud-UQd4agLCtmDypdNDStkxgoQxsUoh8Qcsg@mail.gmail.com>
 <20210415013617.GU1990290@dread.disaster.area>
In-Reply-To: <20210415013617.GU1990290@dread.disaster.area>
From:   Yu Zhao <yuzhao@google.com>
Date:   Sat, 24 Apr 2021 15:21:35 -0600
Message-ID: <CAOUHufZCYGpWhrFepG=2EdXg_-inzFtFH8+pTbvbtpx2K=Lepg@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] Multigenerational LRU Framework
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 7:36 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Wed, Apr 14, 2021 at 01:16:52AM -0600, Yu Zhao wrote:
> > On Tue, Apr 13, 2021 at 10:50 PM Dave Chinner <david@fromorbit.com> wrote:
> > > On Tue, Apr 13, 2021 at 09:40:12PM -0600, Yu Zhao wrote:
> > > > On Tue, Apr 13, 2021 at 5:14 PM Dave Chinner <david@fromorbit.com> wrote:
> > > > > Profiles would be interesting, because it sounds to me like reclaim
> > > > > *might* be batching page cache removal better (e.g. fewer, larger
> > > > > batches) and so spending less time contending on the mapping tree
> > > > > lock...
> > > > >
> > > > > IOWs, I suspect this result might actually be a result of less lock
> > > > > contention due to a change in batch processing characteristics of
> > > > > the new algorithm rather than it being a "better" algorithm...
> > > >
> > > > I appreciate the profile. But there is no batching in
> > > > __remove_mapping() -- it locks the mapping for each page, and
> > > > therefore the lock contention penalizes the mainline and this patchset
> > > > equally. It looks worse on your system because the four kswapd threads
> > > > from different nodes were working on the same file.
> > >
> > > I think you misunderstand exactly what I mean by "batching" here.
> > > I'm not talking about doing multiple pieces of work under a single
> > > lock. What I mean is that the overall amount of work done in a
> > > single reclaim scan (i.e a "reclaim batch") is packaged differently.
> > >
> > > We already batch up page reclaim via building a page list and then
> > > passing it to shrink_page_list() to process the batch of pages in a
> > > single pass. Each page in this page list batch then calls
> > > remove_mapping() to pull the page form the LRU, we have a run of
> > > contention between the foreground read() thread and the background
> > > kswapd.
> > >
> > > If the size or nature of the pages in the batch passed to
> > > shrink_page_list() changes, then the amount of time a reclaim batch
> > > is going to put pressure on the mapping tree lock will also change.
> > > That's the "change in batching behaviour" I'm referring to here. I
> > > haven't read through the patchset to determine if you change the
> > > shrink_page_list() algorithm, but it likely changes what is passed
> > > to be reclaimed and that in turn changes the locking patterns that
> > > fall out of shrink_page_list...
> >
> > Ok, if we are talking about the size of the batch passed to
> > shrink_page_list(), both the mainline and this patchset cap it at
> > SWAP_CLUSTER_MAX, which is 32. There are corner cases, but when
> > running fio/io_uring, it's safe to say both use 32.
>
> You're still looking at micro-scale behaviour, not the larger-scale
> batching effects. Are we passing SWAP_CLUSTER_MAX groups of pages to
> shrinker_page_list() at a different rate?
>
> When I say "batch of work" when talking about the page cache cycling
> *500 thousand pages a second* through the cache, I'm not talking
> about batches of 32 pages. I'm talking about the entire batch of
> work kswapd does in an invocation cycle.
>
> Is it scanning 100k pages 10 times a second? or 10k pages a hundred
> times a second? How long does a batch take to run? how long does is
> sleep between processing batches? Is there any change in these
> metrics as a result of the multi-gen LRU patches?

Hi Dave,

Sorry for the late reply. Still catching up on emails.

Well, it doesn't really work that way. Yes, I agree that batching
theoretically can have effects on the performance but the patchset
doesn't change anything in this respect. The number of pages to
reclaim is determined by a common code path shared between the
existing implementation and this patchset. Specifically, ksawpd sets
"sc->nr_to_reclaim" based on the high watermark, and passes "sc" down
to both code path:

 static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 {
<snipped>
+ if (lru_gen_enabled()) {
+ shrink_lru_gens(lruvec, sc);
+ return;
+ }
<snipped>

And there isn't really any new algorithm. It's just the old plain LRU.
The improvement is purely from a feedback loop that helps avoid
unnecessary activations and deactivations. By activations, I mean the
following work done in the buffered io read path:
  generic_file_read_iter()
    filemap_read()
      mark_page_accessed()
        activate_page()
Simply put, on the second accessed, the current implementation
unconditionally moves a page from the inactive lru to the active lru,
if it's not already there.

And by deactivations, I mean the following work done in kswapd:
  kswapd_shrink_node()
    shrink_node()
      shrink_node_memcgs()
        shrink_lruvec()
          shrink_active_list()
i.e., kswapd moves activated pages back to the inactive list before it
can evict them.

For random accesses, every page is equal and none is active. But how
can we tell? The refault rates, i.e., evicted and then accessed again,
for all pages are the same, no matter how many times they have been
accessed. This is exactly how the feedback loop works.

> Basically, we're looking at how access to the mapping lock is
> changing the contention profile, and whether that is signficant or
> not. I suspect it is, because when you have highly contended locks
> and you do something external that reduces unrelated lock
> contention, it's because that external thing is taking more time to
> do and so there's less time to spend hitting locks hard...
>
> As such, I don't think this test is a good measure of the multi-gen
> LRU patches at all - performance is dominated by the severity of
> lock contention external to the LRU scanning algorithm, and it's
> hard to infer anything through suck lock contention....

The lock contention you saw earlier is because of the four nodes
system you used -- each node has a kswapd thread but there is only one
file. The four kswapd threads keep banging on the same mapping lock.
This can be easily fixed if we just run the same test with a single
node *or* with multiple files.

Here is what I got (it's basically what I've attached in the previous email).

Before the patchset:

kswapd
# Children      Self  Symbol
# ........  ........  .......................................
   100.00%     0.00%  kswapd
    99.90%     0.01%  balance_pgdat
    99.86%     0.05%  shrink_node
    98.00%     0.19%  shrink_lruvec
    91.13%     0.10%  shrink_inactive_list
    75.67%     5.97%  shrink_page_list
    57.65%     2.59%  __remove_mapping
    45.99%     0.27%  __delete_from_page_cache
    42.88%     0.88%  page_cache_delete
    39.05%     1.04%  xas_store
    37.71%    37.67%  xas_create
    12.62%    11.79%  isolate_lru_pages
     8.52%     0.98%  free_unref_page_list
     7.38%     0.61%  free_unref_page_commit
     6.68%     1.78%  free_pcppages_bulk
     6.53%     0.83%  ***shrink_active_list***
     6.45%     3.21%  _raw_spin_lock_irqsave
     4.82%     4.60%  __free_one_page
     4.58%     4.21%  unlock_page
     3.62%     3.55%  native_queued_spin_lock_slowpath
     2.49%     0.71%  unaccount_page_cache_page
     2.46%     0.81%  workingset_eviction
     2.14%     0.33%  __mod_lruvec_state
     1.97%     1.88%  xas_clear_mark
     1.73%     0.26%  __mod_lruvec_page_state
     1.71%     1.06%  move_pages_to_lru
     1.66%     1.62%  workingset_age_nonresident
     1.60%     0.85%  __mod_memcg_lruvec_state
     1.58%     0.02%  shrink_slab
     1.49%     0.13%  mem_cgroup_uncharge_list
     1.45%     0.06%  do_shrink_slab
     1.37%     1.32%  page_mapping
     1.06%     0.76%  count_shadow_nodes

io_uring
# Children      Self  Symbol
# ........  ........  ........................................
    99.22%     0.00%  do_syscall_64
    94.48%     0.22%  __io_queue_sqe
    94.09%     0.31%  io_issue_sqe
    93.33%     0.62%  io_read
    88.57%     0.93%  blkdev_read_iter
    87.80%     0.15%  io_iter_do_read
    87.57%     0.16%  generic_file_read_iter
    87.35%     1.08%  filemap_read
    82.44%     0.01%  __x64_sys_io_uring_enter
    82.34%     0.01%  __do_sys_io_uring_enter
    82.09%     0.47%  io_submit_sqes
    79.50%     0.08%  io_queue_sqe
    71.47%     1.08%  filemap_get_pages
    53.08%     0.35%  ondemand_readahead
    51.74%     1.49%  page_cache_ra_unbounded
    49.92%     0.13%  page_cache_sync_ra
    21.26%     0.63%  add_to_page_cache_lru
    17.08%     0.02%  task_work_run
    16.98%     0.03%  exit_to_user_mode_prepare
    16.94%    10.52%  __add_to_page_cache_locked
    16.94%     0.06%  tctx_task_work
    16.79%     0.19%  syscall_exit_to_user_mode
    16.41%     2.61%  filemap_get_read_batch
    16.08%    15.72%  xas_load
    15.99%     0.15%  read_pages
    15.87%     0.13%  blkdev_readahead
    15.72%     0.56%  mpage_readahead
    15.58%     0.09%  io_req_task_submit
    15.37%     0.07%  __io_req_task_submit
    12.14%     0.15%  copy_page_to_iter
    12.03%     0.03%  ***__page_cache_alloc***
    11.98%     0.14%  alloc_pages_current
    11.66%     0.30%  __alloc_pages_nodemask
    11.28%    11.05%  _copy_to_iter
    11.06%     3.16%  get_page_from_freelist
    10.53%     0.10%  submit_bio
    10.27%     0.21%  submit_bio_noacct
     8.30%     0.51%  blk_mq_submit_bio
     7.73%     7.62%  clear_page_erms
     3.68%     1.02%  do_mpage_readpage
     3.33%     0.01%  page_cache_async_ra
     3.25%     0.01%  blk_flush_plug_list
     3.24%     0.06%  blk_mq_flush_plug_list
     3.18%     0.01%  blk_mq_sched_insert_requests
     3.15%     0.13%  blk_mq_try_issue_list_directly
     2.84%     0.15%  __blk_mq_try_issue_directly
     2.69%     0.58%  nvme_queue_rq
     2.54%     1.05%  blk_attempt_plug_merge
     2.53%     0.44%  ***mark_page_accessed***
     2.36%     0.12%  rw_verify_area
     2.16%     0.09%  mpage_alloc
     2.10%     0.27%  lru_cache_add
     1.81%     0.27%  security_file_permission
     1.75%     0.87%  __pagevec_lru_add
     1.70%     0.63%  _raw_spin_lock_irq
     1.53%     0.40%  xa_get_order
     1.52%     0.15%  __blk_mq_alloc_request
     1.50%     0.65%  workingset_refault
     1.50%     0.07%  activate_page
     1.48%     0.29%  io_submit_flush_completions
     1.46%     0.32%  bio_alloc_bioset
     1.42%     0.15%  xa_load
     1.40%     0.16%  pagevec_lru_move_fn
     1.39%     0.06%  blk_finish_plug
     1.35%     0.28%  submit_bio_checks
     1.26%     0.02%  asm_common_interrupt
     1.25%     0.01%  common_interrupt
     1.21%     1.21%  native_queued_spin_lock_slowpath
     1.18%     0.10%  mempool_alloc
     1.17%     0.00%  __common_interrupt
     1.14%     0.03%  handle_edge_irq
     1.08%     0.87%  apparmor_file_permission
     1.03%     0.19%  __mod_lruvec_state
     1.02%     0.65%  blk_rq_merge_ok
     1.01%     0.94%  xas_start

After the patchset:

kswapd
# Children      Self  Symbol
# ........  ........  ........................................
   100.00%     0.00%  kswapd
    99.92%     0.11%  balance_pgdat
    99.32%     0.03%  shrink_node
    97.25%     0.32%  shrink_lruvec
    96.80%     0.09%  evict_lru_gen_pages
    77.82%     6.28%  shrink_page_list
    61.61%     2.76%  __remove_mapping
    50.28%     0.33%  __delete_from_page_cache
    46.63%     1.08%  page_cache_delete
    42.20%     1.16%  xas_store
    40.71%    40.67%  xas_create
    12.54%     7.76%  isolate_lru_gen_pages
     6.42%     3.19%  _raw_spin_lock_irqsave
     6.15%     0.91%  free_unref_page_list
     5.62%     5.45%  unlock_page
     5.05%     0.59%  free_unref_page_commit
     4.35%     2.04%  lru_gen_update_size
     4.31%     1.41%  free_pcppages_bulk
     3.43%     3.36%  native_queued_spin_lock_slowpath
     3.38%     0.59%  __mod_lruvec_state
     2.97%     0.78%  unaccount_page_cache_page
     2.82%     2.52%  __free_one_page
     2.33%     1.18%  __mod_memcg_lruvec_state
     2.28%     2.17%  xas_clear_mark
     2.13%     0.30%  __mod_lruvec_page_state
     1.88%     0.04%  shrink_slab
     1.82%     1.78%  workingset_eviction
     1.74%     0.06%  do_shrink_slab
     1.70%     0.15%  mem_cgroup_uncharge_list
     1.39%     1.01%  count_shadow_nodes
     1.22%     1.18%  __mod_memcg_state.part.0
     1.16%     1.11%  page_mapping
     1.02%     0.98%  xas_init_marks

io_uring
# Children      Self  Symbol
# ........  ........  ........................................
    99.19%     0.01%  entry_SYSCALL_64_after_hwframe
    99.16%     0.00%  do_syscall_64
    94.78%     0.18%  __io_queue_sqe
    94.41%     0.25%  io_issue_sqe
    93.60%     0.48%  io_read
    89.35%     0.96%  blkdev_read_iter
    88.44%     0.12%  io_iter_do_read
    88.25%     0.16%  generic_file_read_iter
    88.00%     1.20%  filemap_read
    84.01%     0.01%  __x64_sys_io_uring_enter
    83.91%     0.01%  __do_sys_io_uring_enter
    83.74%     0.37%  io_submit_sqes
    81.28%     0.07%  io_queue_sqe
    74.65%     0.96%  filemap_get_pages
    55.92%     0.35%  ondemand_readahead
    54.57%     1.34%  page_cache_ra_unbounded
    51.57%     0.12%  page_cache_sync_ra
    24.14%     0.51%  add_to_page_cache_lru
    19.04%    11.51%  __add_to_page_cache_locked
    18.48%     0.13%  read_pages
    18.42%     0.18%  blkdev_readahead
    18.20%     0.55%  mpage_readahead
    16.81%     2.31%  filemap_get_read_batch
    16.37%    14.83%  xas_load
    15.40%     0.02%  task_work_run
    15.38%     0.03%  exit_to_user_mode_prepare
    15.31%     0.05%  tctx_task_work
    15.14%     0.15%  syscall_exit_to_user_mode
    14.05%     0.04%  io_req_task_submit
    13.86%     0.05%  __io_req_task_submit
    12.92%     0.12%  submit_bio
    11.40%     0.13%  copy_page_to_iter
    10.65%     9.61%  _copy_to_iter
     9.45%     0.03%  ***__page_cache_alloc***
     9.42%     0.16%  submit_bio_noacct
     9.40%     0.11%  alloc_pages_current
     9.11%     0.30%  __alloc_pages_nodemask
     8.53%     1.81%  get_page_from_freelist
     8.38%     0.10%  asm_common_interrupt
     8.26%     0.06%  common_interrupt
     7.75%     0.05%  __common_interrupt
     7.62%     0.44%  blk_mq_submit_bio
     7.56%     0.20%  handle_edge_irq
     6.45%     5.90%  clear_page_erms
     5.25%     0.10%  handle_irq_event
     4.88%     0.19%  nvme_irq
     4.83%     0.07%  __handle_irq_event_percpu
     4.73%     0.52%  nvme_process_cq
     4.52%     0.01%  page_cache_async_ra
     4.00%     0.04%  nvme_pci_complete_rq
     3.82%     0.04%  nvme_complete_rq
     3.76%     1.11%  do_mpage_readpage
     3.74%     0.06%  blk_mq_end_request
     3.03%     0.01%  blk_flush_plug_list
     3.02%     0.06%  blk_mq_flush_plug_list
     2.96%     0.01%  blk_mq_sched_insert_requests
     2.94%     0.10%  blk_mq_try_issue_list_directly
     2.89%     0.00%  __irqentry_text_start
     2.71%     0.41%  psi_task_change
     2.67%     0.21%  lru_cache_add
     2.65%     0.14%  __blk_mq_try_issue_directly
     2.53%     0.54%  nvme_queue_rq
     2.43%     0.17%  blk_update_request
     2.42%     0.58%  __pagevec_lru_add
     2.29%     1.42%  psi_group_change
     2.22%     0.85%  blk_attempt_plug_merge
     2.14%     0.04%  bio_endio
     2.13%     0.11%  rw_verify_area
     2.08%     0.18%  mpage_end_io
     2.01%     0.08%  mpage_alloc
     1.71%     0.56%  _raw_spin_lock_irq
     1.65%     0.98%  workingset_refault
     1.65%     0.09%  psi_memstall_leave
     1.64%     0.20%  security_file_permission
     1.61%     1.59%  _raw_spin_lock
     1.58%     0.08%  psi_memstall_enter
     1.44%     0.37%  xa_get_order
     1.43%     0.13%  __blk_mq_alloc_request
     1.37%     0.26%  io_submit_flush_completions
     1.36%     0.14%  xa_load
     1.34%     0.31%  bio_alloc_bioset
     1.31%     0.26%  submit_bio_checks
     1.29%     0.04%  blk_finish_plug
     1.28%     1.27%  native_queued_spin_lock_slowpath
     1.24%     0.19%  page_endio
     1.13%     0.10%  unlock_page
     1.09%     0.99%  read_tsc
     1.07%     0.74%  lru_gen_addition
     1.03%     0.09%  mempool_alloc
     1.02%     0.13%  wake_up_page_bit
     1.02%     0.92%  xas_start
     1.01%     0.78%  apparmor_file_permission

By comparing the two sets, we can clearly see what's changed:

Before the patchset:
     6.53%     0.83%  ***shrink_active_list***
    12.03%     0.03%  ***__page_cache_alloc***
     2.53%     0.44%  ***mark_page_accessed***

After the patchset:
     9.45%     0.03%  ***__page_cache_alloc***
(There are shrink_active_list() or mark_page_accessed() since we don't
activate and deactivate pages anymore, for this test case.)

Hopefully this is clear enough. But I do see where your skepticism
comes from and I don't want to dismiss it out of hand. So if you have
any other benchmarks, I'd be happy to try them. What do you think?

Thanks.
