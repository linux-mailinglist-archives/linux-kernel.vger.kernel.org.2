Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85CEF36C443
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 12:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237122AbhD0KiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 06:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238179AbhD0KhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 06:37:23 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED61C06138D
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 03:36:03 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id m9so46184895wrx.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 03:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0fYknBL96ENkxzahSK1LHOZCOT6c+BavjiBRU+2tJms=;
        b=lk/9aRPKijBbiT1uPMwAv+4HphTMESd4sJ/ZucXT91vO8SNydF1G2aTiOmZma79FsM
         JazjPJ5M+A1K4qgbeWfYpPYok8gnpmknDi54aBlTsV3LG94TBb5fn0YYEV9AZa9mKKBT
         7MCYrVbVOZT6ShS+BLTQa3zAcLK6UuLanizBLdHU/3GjUJARHtlfKAEDeJ1bLCCXwe4x
         lU6W0Nwj3aYRy3DuVt1Cr39E3M9/GvxGmhB3wL5IFupxYT+ocaRDS0x8QWw8Re0BlRkk
         b151Oei35yAW+Cojk4TycUyebVJvGCeaeVR2NBPOHOJlAX9Mv7x4Jlt6upyuXb2w00rZ
         leQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0fYknBL96ENkxzahSK1LHOZCOT6c+BavjiBRU+2tJms=;
        b=Ij0LkEY6Ca1LlST+WQ6rXtgWL4/QILPsMDzXzAwCUiUo7G92Hpf1CBsCrvxQC068it
         UCaPlPnk4j21BnJxSwixvihwGor4EXuKN7qnriyQnPJ0SevtIHh5PytqPk58b3YWUzUF
         MXNIU9bw2YioAEooKGhG5OcPK+9Ktt+pSkaAxlMAOFBQsMjJuyGFa1FswePKHN+PD+kJ
         Qj1dL+yoG9YVUotA0Z8as6pUI7Rtmt88VEM4YmSQt63YSxA/JE+jWjSN3ps749CicSMx
         dO3stXeiJWDpZVU9ioRJ/fAQh0GxGnVS2ftvcYUhhkcULwur7Ctd0OvvQ2Jdf0VGxhAR
         Uljw==
X-Gm-Message-State: AOAM532cwzmLJ519Qe8zzeKzzcUSR20Mh2f++Z/nRm/phBd5ZRD/QPPi
        5grFn49+TpaHO9bhPHEIObu7Tdltj9aZCkGx822tYVrIWp2sCg==
X-Google-Smtp-Source: ABdhPJz0dcOEfnAQYdvunQUjgy/LEhtj9sigMNQjcYeRD57QXve8cOrSXxLf0iXHWnW/hOm43hWTUcPRVlvSS0NfKt4=
X-Received: by 2002:adf:e381:: with SMTP id e1mr27810050wrm.323.1619519762036;
 Tue, 27 Apr 2021 03:36:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210413065633.2782273-1-yuzhao@google.com> <YHcpzZYD2fQyWvEQ@cmpxchg.org>
In-Reply-To: <YHcpzZYD2fQyWvEQ@cmpxchg.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 27 Apr 2021 04:35:50 -0600
Message-ID: <CAOUHufbz_f4EjtDsMkmEBbQphXj3ET+X6SM8JUPQ4b2jJmUzvA@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] Multigenerational LRU Framework
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Linux-MM <linux-mm@kvack.org>, Alex Shi <alexs@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Manes <ben.manes@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
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

On Wed, Apr 14, 2021 at 11:43 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> Hello Yu,

Hi Johannes,

I appreciate the detailed review. Hopefully I have addressed all your
comments below.

> On Tue, Apr 13, 2021 at 12:56:17AM -0600, Yu Zhao wrote:
> > What's new in v2
> > ================
> > Special thanks to Jens Axboe for reporting a regression in buffered
> > I/O and helping test the fix.
> >
> > This version includes the support of tiers, which represent levels of
> > usage from file descriptors only. Pages accessed N times via file
> > descriptors belong to tier order_base_2(N). Each generation contains
> > at most MAX_NR_TIERS tiers, and they require additional MAX_NR_TIERS-2
> > bits in page->flags. In contrast to moving across generations which
> > requires the lru lock, moving across tiers only involves an atomic
> > operation on page->flags and therefore has a negligible cost. A
> > feedback loop modeled after the well-known PID controller monitors the
> > refault rates across all tiers and decides when to activate pages from
> > which tiers, on the reclaim path.
>
> Could you elaborate a bit more on the difference between generations
> and tiers?
>
> A refault, a page table reference, or a buffered read through a file
> descriptor ultimately all boil down to a memory access. The value of
> having that memory resident and the cost of bringing it in from
> backing storage should be the same regardless of how it's accessed by
> userspace; and whether it's an in-memory reference or a non-resident
> reference should have the same relative impact on the page's age.
>
> With that context, I don't understand why file descriptor refs and
> refaults get such special treatment. Could you shed some light here?
>
> > This feedback model has a few advantages over the current feedforward
> > model:
> > 1) It has a negligible overhead in the buffered I/O access path
> >    because activations are done in the reclaim path.
>
> This is useful if the workload isn't reclaim bound, but it can be
> hazardous to defer work to reclaim, too.
>
> If you go through the git history, there have been several patches to
> soften access recognition inside reclaim because it can come with
> large latencies when page reclaim kicks in after a longer period with
> no memory pressure and doesn't have uptodate reference information -
> to the point where eating a few extra IOs tend to add less latency to
> the workload than waiting for reclaim to refresh its aging data.
>
> Could you elaborate a bit more on the tradeoff here?

=== Tiers ===

I agree with all you said. Let me summarize.

Remark 1: a refault, *a page fault* or a buffered read is exactly one
memory reference. A page table reference as how we count it, i.e., the
accessed bit is set, could be one or a thousand memory references. So
the accessed bit for a mapped page and PageReferenced() for an
unmapped page may carry different weights.

Remark 2: the cost of bringing a page back, regardless of how it is
referenced, is the same.

Remark 3: not using extra aging information may be preferable, if
obtaining or maintaining such information would cost more.

Starting with remark 3.

For pages referenced multiple times via file descriptors, we currently
activate them in mark_page_accessed(), regardless of memory pressure.
If we defer their activations, we may be penalized for it. But, based
on remark 3, it is still a win if activating them on the spot has a
higher overall cost.

The proposal here is we do not move them to the active lru list upon
the second reference. Instead, we simply increment a counter in
page->flags, just like SetPageReferenced() without activate_page() in
mark_page_accessed(). For the sake of discussion, let us assume each
possible value of the counter is a tier. Pages read ahead are in tier
0; pages referenced once are in tier 1; pages referenced twice are in
tier 2, etc. Note that we are talking about references via file
descriptors.

Then we record the refaults for each tier, and we compare the refault
rates, i.e, refaulted/evicted across all tiers, in the reclaim path.
For example, if we see tier 2 has a higher refault rate, we activate
pages from this tier. Otherwise, we keep evicting pages from this
tier. This allows us to shift the cost of activations from the
buffered read path to the reclaim path. This is likely to be a win,
and I will explain why at the end of this section.

Next let us look at remark 1, and how tiers can help us with the
different weight from the accessed bit.

For pages referenced via page tables only, we can assign them a tier,
say tier 0. Then we are able to compare their refault rate with those
referenced multiple times via file descriptors. Even though the
accessed bit carries a different weight, a refault has exactly the
same weight, because of remark 2.

For example, if pages referenced via page tables have a higher refault
rate than pages referenced twice via file descriptors, we will not
activate the latter and therefore would provide better protection to
the former by not flooding the active list. The current implementation
will activate the latter on the spot, which is suboptimal for this
example.

Another example: if we find pages referenced four times via file
descriptors have a higher refault rate than the rest, we only activate
them. The current implementation activates pages accessed twice and
three times too, and if they have a large number, they will flood the
active lru list and weaken the protection to pages accessed four
times.

Now, an additional remark.

Remark 4: tracking references of mapped pages by clearing the accessed
bit is more expensive than tracking references of unmapped pages by
mark_page_accessed().

The creation of a generation begins with scanning page tables (if they
are not too sparse) of each active process to find all referenced
pages since the last scan. So it is expensive.

If we moved a page to the next generation upon the second reference
via file descriptor, old generations would run out of pages sooner and
we would have to create new generations at a faster pace to keep up,
which increases the cost. In addition, moving pages across generations
is also expensive, because, on the data struct level, it is the same
as moving pages between the active and the inactive lists, which
requires the lru lock. On the other hand, tiers are lightweight.
Changing tiers within a generation is only an atomic operation on
page->flags.

With the current implementation, randomly reading (buffered io) a
large file, e.g., twice as large as memory size, from a fast storage
long enough will demonstrate both problems. In kswapd,
shrink_active_list() costs >6% of CPU. In the buffered read path,
mark_page_accessed() costs >2%. Statistically speaking, pages accessed
multiple times are not more active than pages accessed once, in this
case. Therefore, both functions are in vain.

Finally, the tradeoff part.

Fundamentally, the idea of tiers is based on a feedback loop, which is
essentially trial and error. So it will perform worse than the current
open loop control, i.e., activating upon the second referenced, if we
know for sure that pages referenced twice need to be protected. IOW,
knowing what is going to happen can avoid the error part from the
feedback loop. But in the realm of page reclaim, I bet we cannot
predict the future, for any workloads. Does it make sense?

> > Highlights from the discussions on v1
> > =====================================
> > Thanks to Ying Huang and Dave Hansen for the comments and suggestions
> > on page table scanning.
> >
> > A simple worst-case scenario test did not find page table scanning
> > underperforms the rmap because of the following optimizations:
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
> > TLDR
> > ====
> > The current page reclaim is too expensive in terms of CPU usage and
> > often making poor choices about what to evict. We would like to offer
> > an alternative framework that is performant, versatile and
> > straightforward.
> >
> > Repo
> > ====
> > git fetch https://linux-mm.googlesource.com/page-reclaim refs/changes/73/1173/1
> >
> > Gerrit https://linux-mm-review.googlesource.com/c/page-reclaim/+/1173
> >
> > Background
> > ==========
> > DRAM is a major factor in total cost of ownership, and improving
> > memory overcommit brings a high return on investment.
>
> RAM cost on one hand.
>
> On the other, paging backends have seen a revolutionary explosion in
> iop/s capacity from solid state devices and CPUs that allow in-memory
> compression at scale, so a higher rate of paging (semi-random IO) and
> thus larger levels of overcommit are possible than ever before.
>
> There is a lot of new opportunity here.
>
> > Over the past decade of research and experimentation in memory
> > overcommit, we observed a distinct trend across millions of servers
> > and clients: the size of page cache has been decreasing because of
> > the growing popularity of cloud storage. Nowadays anon pages account
> > for more than 90% of our memory consumption and page cache contains
> > mostly executable pages.
>
> This gives the impression that because the number of setups heavily
> using the page cache has reduced somewhat, its significance is waning
> as well. I don't think that's true. I think we'll continue to have
> mainstream workloads for which the page cache is significant.
>
> Yes, the importance of paging anon memory more efficiently (or paging
> it at all again, for that matter), has increased dramatically. But IMO
> not because it's more prevalent, but rather because of the increase in
> paging capacity from the hardware side. It's not like we've been
> heavily paging filesystem data beyond cold starts either when it was
> more prevalent - workloads quickly fall apart when you do that on
> rotating drives.
>
> So that increase in paging capacity also applies to filesystem data,
> and makes local filesystems an option again where they might have been
> replaced by anonymous blobs managed by a userspace network filesystem.
>
> Take disaggregated storage for example. It's an attractive measure for
> reducing per-host CAPEX when the alternative is a local spindle, whose
> seekiness doesn't make the network distance look so bad, and prevents
> significant memory overcommit anyway. You have to spec the same RAM in
> either case.
>
> The equation is different for flash. You can *significantly* reduce
> RAM needs of even latency-sensitive, interactive workloads with cheap,
> consumer-grade local SSD drives. Disaggregating those drives and
> adding the network to the paging path would directly eat into the much
> higher RAM savings. It's a much less attractive proposition now. And
> that's bringing larger data sets back to local filesystems.
>
> And of course, even in cloud and disaggregated environments, there ARE
> those systems that deal with things like source code trees -
> development machines, build hosts etc. For those, filesystem data
> continues to be the primary workload.
>
> So while I agree with what you say about anon pages, I don't expect
> non-trivial (local) filesystem loads to go away anytime soon. The
> kernel needs to continue treating it as a first-class citizen.
>
> > Problems
> > ========
> > Notion of active/inactive
> > -------------------------
> > For servers equipped with hundreds of gigabytes of memory, the
> > granularity of the active/inactive is too coarse to be useful for job
> > scheduling. False active/inactive rates are relatively high, and thus
> > the assumed savings may not materialize.
>
> The inactive/active naming is certainly confusing for users of the
> system. The kernel uses it to preselect reclaim candidates, it's not
> meant to indicate how much memory capacity is idle and available.
>
> But a confusion around naming doesn't necessarily indicate it's bad at
> what it is actually designed to do.
>
> Fundamentally, LRU ordering is susceptible to a flood of recent pages
> with no reuse pushing out the established frequent pages. The split
> into inactive and active is simply there to address this shortcoming,
> and protect frequent pages from recent ones - where pages that are
> only accessed once get reclaimed before pages used twice or more.
>
> Obviously, 'twice or more' is a coarse category, and it's not hard to
> imagine that it might go wrong. But please, don't leave it up to the
> imagination ;-) It's been in use for two decades or so, it needs a bit
> more in-depth analysis of its limitations to justify replacing it.
>
> > For phones and laptops, executable pages are frequently evicted
> > despite the fact that there are many less recently used anon pages.
> > Major faults on executable pages cause "janks" (slow UI renderings)
> > and negatively impact user experience.
>
> This is not because of the inactive/active scheme but rather because
> of the anon/file split, which has evolved over the years to just not
> swap onto iop-anemic rotational drives.
>
> We ran into the same issue at FB too, where even with painfully
> obvious anon candidates and a fast paging backend the kernel would
> happily thrash on the page cache instead.
>
> There has been significant work in this area recently to address this
> (see commit 5df741963d52506a985b14c4bcd9a25beb9d1981). We've added
> extensive testing and production time onto these patches since and
> have not found the kernel to be thrashing executables or be reluctant
> to go after anonymous pages anymore.
>
> I wonder if your observation takes these recent changes into account?

Again, I agree with all you said above. And I can confirm your series
has generally fixed the problem for the following test case.

When our most common 4GB Chromebook model is zram-ing under memory
pressure, the size of the file lru is
  ~80MB without that series
  ~120MB with that series
  ~140MB with this series

User experience is acceptable as long as the size is above 100MB. For
optimal user experience, the size is 200MB. But we do not expect the
optimal user experience under memory pressure.

> > For lruvecs from different memcgs or nodes, comparisons are impossible
> > due to the lack of a common frame of reference.
>
> My first thought is that this is expected. Workloads running under
> different memory constraints, IO priority levels etc. will not have
> comparable workingsets: an access frequency that is considered high in
> one domain could be considered quite cold in another.
>
> Could you elaborate a bit on the situations where you would want to
> compare, and how this is possible by having more generations?

Will cover this in the discussion of generations.

> > Solutions
> > =========
> > Notion of generation numbers
> > ----------------------------
> > The notion of generation numbers introduces a quantitative approach to
> > memory overcommit. A larger number of pages can be spread out across
> > a configurable number of generations, and each generation includes all
> > pages that have been referenced since the last generation. This
> > improved granularity yields relatively low false active/inactive
> > rates.
> >
> > Given an lruvec, scans of anon and file types and selections between
> > them are all based on direct comparisons of generation numbers, which
> > are simple and yet effective. For different lruvecs, comparisons are
> > still possible based on birth times of generations.
>
> This describes *what* it's doing, but could you elaborate more on how
> to think about generations in relation to workload behavior and what
> you can predict based on how your workload gets bucketed into these?
>
> If we accept that the current two generations are not enough, how many
> should there be instead? Four? Ten?
>
> What determines this? Is it the workload's access pattern? Or the
> memory size?
>
> How do I know whether the number of generations I have chosen is right
> for my setup? How do I detect when the underlying factors changed and
> it no longer is?
>
> How does it manifest if I have too few generations? What about too
> many?
>
> What about systems that host a variety of workloads that come and go?
> Is there a generation number that will be good for any combination of
> workloads on the system as jobs come and go?
>
> For a general purpose OS like Linux, it's nice to be *able* to tune to
> your specific requirements, but it's always bad to *have* to. Whatever
> we end up doing, there needs to be some reasonable default behavior
> that works acceptably for a broad range of workloads out of the box.

=== generations ===

All good questions. Let me start abstractly and give concrete examples
afterward.

Remark 1: the number of generations only naturally grows to three,
unless users artificially create more for the purpose of working set
estimation.

Why three? We add pages mapped upon page faults to the youngest
generation, since we need to age them before we can evict them. After
we scan them once and clear the accessed bit set during the initial
faults, they become the second youngest generation. And we still
cannot evict them because we have not ascertained whether they are
inactive. We can only be sure after the second scan. Thereafter they
become the third youngest generation, if the accessed bit is not set.
The third youngest generation is also the oldest, in this case.

I suppose this is not surprising, as it simply follows the current
implementation. This is also why only the youngest and second youngest
generation are considered active, in order to be compatible with the
active/inactive notion. As long as we have something to evict, we do
not need to create more generations. IOW, we only create a new
generation when we are down to the minimum number of generations,
i.e., two, which is equivalent to being out of inactive pages, when
compared with the current implementation.

And why do we need generations in this case? It is because they help
answer the question of when we need to scan active pages. We could
reuse inactive_is_low(). But the number of generations seems to be
more deterministic than the magic numbers in inactive_is_low().

But do users need to configure the number of generations? The answer
is no. Everything works out of box, unless they are interested in the
following.

Remark 2: generations provide a temporal dimension; each generation is
a dot on the timeline.

This is designed for large scale deployments, i.e., data centers that
want to monitor their memory utilization for resource planning;
fleetwide working set estimation for optimal job scheduling, basically
for users who need a set of stats that they can aggregate.

Aggregating the active/inactive across a fleet of machines yields
nothing interesting. But generations are associated with timestamps,
and if they are artificially created at a steady pace, say every two
minutes, then their aggregation tells a lot. I will cover this more in
the use case section.

This principle also applies to memcgs or nodes, from the same machine
or different ones.

The same type of job can run concurrently on different machines and
each machine has a memcg for this job. To gain some insight into this
type of job, users collect a set of stats from those memcgs, and based
on this set, they want to predict how much memory this type of job
typically requires. In our case, it is called Autopilot. Users would
not be able to achieve this if there is not a metric system or a
common frame of reference for the stats in this set.

Similarly, if users want to select an optimal node for a job, they
need to compare all nodes, in order to determine which one has the
least amount of active pages.

Remark 3: architecturally, generations glue everything together.

When we scan page tables, we only update the generation number counter
in page->flags, without isolating the page. This is different from
what we have been doing, e.g., activate_page() or activate_page().
Tiers also rely on generations, because they need a temporal dimension
to sort out refaults from different generations. Needless to day,
refaults from younger generations are worse than those from older
generations, i.e., the former have shorter refault distances than the
latter. (Refault distance is a metric we use internally to measure
page selection quality.)

So generally it would only be more difficult, if we split things up
while trying to retain the same amount of benefits.

> > Differential scans via page tables
> > ----------------------------------
> > Each differential scan discovers all pages that have been referenced
> > since the last scan. Specifically, it walks the mm_struct list
> > associated with an lruvec to scan page tables of processes that have
> > been scheduled since the last scan. The cost of each differential scan
> > is roughly proportional to the number of referenced pages it
> > discovers. Unless address spaces are extremely sparse, page tables
> > usually have better memory locality than the rmap. The end result is
> > generally a significant reduction in CPU usage, for workloads using a
> > large amount of anon memory.
> >
> > Our real-world benchmark that browses popular websites in multiple
> > Chrome tabs demonstrates 51% less CPU usage from kswapd and 52% (full)
> > less PSI on v5.11. With this patchset, kswapd profile looks like:
> >   49.36%  lzo1x_1_do_compress
> >    4.54%  page_vma_mapped_walk
> >    4.45%  memset_erms
> >    3.47%  walk_pte_range
> >    2.88%  zram_bvec_rw
> >
> > In addition, direct reclaim latency is reduced by 22% at 99th
> > percentile and the number of refaults is reduced by 7%. Both metrics
> > are important to phones and laptops as they are correlated to user
> > experience.
>
> This looks very exciting!
>
> However, this seems to be an improvement completely in its own right:
> getting the mapped page access information in a more efficient way.
>
> Is there anything that ties it to the multi-generation LRU that I may
> be missing here? Or could it simply be a drop-in replacement for rmap
> that gives us the CPU savings right away?

Covered in the discussion of generations.

> > Framework
> > =========
> > For each lruvec, evictable pages are divided into multiple
> > generations. The youngest generation number is stored in
> > lruvec->evictable.max_seq for both anon and file types as they are
> > aged on an equal footing. The oldest generation numbers are stored in
> > lruvec->evictable.min_seq[2] separately for anon and file types as
> > clean file pages can be evicted regardless of may_swap or
> > may_writepage. Generation numbers are truncated into
> > order_base_2(MAX_NR_GENS+1) bits in order to fit into page->flags. The
> > sliding window technique is used to prevent truncated generation
> > numbers from overlapping. Each truncated generation number is an inde
> > to lruvec->evictable.lists[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES].
> > Evictable pages are added to the per-zone lists indexed by max_seq or
> > min_seq[2] (modulo MAX_NR_GENS), depending on whether they are being
> > faulted in.
> >
> > Each generation is then divided into multiple tiers. Tiers represent
> > levels of usage from file descriptors only. Pages accessed N times via
> > file descriptors belong to tier order_base_2(N). In contrast to moving
> > across generations which requires the lru lock, moving across tiers
> > only involves an atomic operation on page->flags and therefore has a
> > lower cost. A feedback loop modeled after the well-known PID
> > controller monitors the refault rates across all tiers and decides
> > when to activate pages from which tiers on the reclaim path.
> >
> > The framework comprises two conceptually independent components: the
> > aging and the eviction, which can be invoked separately from user
> > space.
>
> Why from userspace?

Will cover this in the discussion of use cases.

> > Aging
> > -----
> > The aging produces young generations. Given an lruvec, the aging scans
> > page tables for referenced pages of this lruvec. Upon finding one, the
> > aging updates its generation number to max_seq. After each round of
> > scan, the aging increments max_seq.
> >
> > The aging maintains either a system-wide mm_struct list or per-memcg
> > mm_struct lists and tracks whether an mm_struct is being used or has
> > been used since the last scan. Multiple threads can concurrently work
> > on the same mm_struct list, and each of them will be given a different
> > mm_struct belonging to a process that has been scheduled since the
> > last scan.
> >
> > The aging is due when both of min_seq[2] reaches max_seq-1, assuming
> > both anon and file types are reclaimable.
>
> As per above, this is centered around mapped pages, but it really
> needs to include a detailed answer for unmapped pages, such as page
> cache and shmem/tmpfs data, as well as how sampled page table
> references behave wrt realtime syscall references.

Covered in the discussion of tiers.

> > Eviction
> > --------
> > The eviction consumes old generations. Given an lruvec, the eviction
> > scans the pages on the per-zone lists indexed by either of min_seq[2].
> > It first tries to select a type based on the values of min_seq[2].
> > When anon and file types are both available from the same generation,
> > it selects the one that has a lower refault rate.
> >
> > During a scan, the eviction sorts pages according to their generation
> > numbers, if the aging has found them referenced. It also moves pages
> > from the tiers that have higher refault rates than tier 0 to the next
> > generation.
> >
> > When it finds all the per-zone lists of a selected type are empty, the
> > eviction increments min_seq[2] indexed by this selected type.
> >
> > Use cases
> > =========
> > On Android, our most advanced simulation that generates memory
> > pressure from realistic user behavior shows 18% fewer low-memory
> > kills, which in turn reduces cold starts by 16%.
>
> I assume you refer to pressure-induced lmkd kills rather than
> conventional kernel OOM kills?
>
> I.e. multi-gen LRU does a better job of identifying the workingset,
> rather than giving up too early.
>
> Again, I would be interested if the baseline here includes the recent
> anon/file balancing rework or not.

Yes, lmkd, which is based on PSI.

No, the baseline did not include the rework. I will rerun the
simulation once we have enough devices running 5.10.

BTW, does the rework also improve PSI? If so, the Android team might
be interested in backpacking it.

> > On Borg, a similar approach enables us to identify jobs that
> > underutilize their memory and downsize them considerably without
> > compromising any of our service level indicators.
>
> This is doable with the current reclaim implementation as well. At FB
> we drive proactive reclaim through cgroup control, in a feedback loop
> with psi metrics.
>
> Obviously, this would benefit from better workingset identification in
> the kernel, as more memory could be offloaded under the same pressure
> tolerances from the workload, but it's more of an optimization than
> enabling a uniquely new usecase.

=== use case ===

Thanks for sharing this information. Fleetwide efficiency is my
favorite topic! And I like your model -- it is very straightforward.

However, there are a few constraints that prohibit us from adopting it.

Remark 1: for systems with almost all of the pages mapped, proactive
reclaim using the current interface is unaffordable because of the
overhead from the rmap.

For systems with a fair number of unmapped pages, proactive reclaim
can drop some of them at a low cost. But for systems with almost all
of the pages mapped, proactive reclaim needs to walk the rmap to clear
the accessed bit. The following profile demonstrates such a overhead
when we proactively zram pages that have not been used for more than
two minutes from a system that has 99% of the pages mapped (~500GB,
moderate pressure):

 41.23%  page_vma_mapped_walk
  6.12%  do_raw_spin_lock
  5.23%  vma_interval_tree_iter_next
  4.23%  vma_interval_tree_subtree_search
  2.97%  page_referenced_one
  2.29%  lzo1x_1_do_compress

For what we profile, page_vma_mapped_walk() consumes the highest
amount of CPU among all kernel functions.

Remark 2: for optimal job scheduling, users need to predict whether a
job can land on a machine successfully without actually impacting the
existing jobs.

For example, given a pool of candidates, a job scheduler periodically
calls an aging interface provided by the kernel, in order to estimate
the working set of each candidate. And it ranks the candidates based
on their working sets. Candidates can be individual machines or nodes,
in case this job scheduler is NUMA aware. (Ours is.)

This means that working set estimation and proactive reclaim have to
be separate functions. If we bundle them, this job scheduler would
have to sacrifice the performance of the existing jobs for something
that may or may not come true.

Remark 3: for optimal fleet efficiency, users need to avoid proactive
reclaim unless they plan to use the savings for additional workloads.

Why would users want to proactively reclaim memory if they have no
plan to run additional workloads? The only reason might be that they
are not confident with the ability of the page reclaim, i.e., they do
not know whether it will give them what they need quickly enough when
they really need it. I cannot think of any other reason at the moment
:)

> > On Chrome OS, our field telemetry reports 96% fewer low-memory tab
> > discards and 59% fewer OOM kills from fully-utilized devices and no
> > regressions in monitored user experience from underutilized devices.
>
> Again, lkmd rather than kernel oom kills, right? And with or without
> the anon/file rework?

Yes, lmkd.

No, the baseline does not include the rework. But in this case it
should not matter. We have been carrying the following patch, which
protects the file lru from going below a certain threshold. Let me run
an a/b experiment on 5.10, i.e., with/without the patch, to make sure.

https://lore.kernel.org/linux-mm/20101028191523.GA14972@google.com/

> > Working set estimation
> > ----------------------
> > User space can invoke the aging by writing "+ memcg_id node_id gen
> > [swappiness]" to /sys/kernel/debug/lru_gen. This debugfs interface
> > also provides the birth time and the size of each generation.
> >
> > Proactive reclaim
> > -----------------
> > User space can invoke the eviction by writing "- memcg_id node_id gen
> > [swappiness] [nr_to_reclaim]" to /sys/kernel/debug/lru_gen. Multiple
> > command lines are supported, so does concatenation with delimiters.
>
> Can you explain a bit more how these two are supposed to be used?
>
> The memcg id is self-explanatory: Age or evict pages from this
> particular workload.
>
> The node is a bit less intuitive. In most setups, the distance to a
> remote NUMA node is much smaller than the distance to the storage
> backend, and users would prefer finding and evicting the coldest
> memory between multiple nodes, not within individual node.

But storage backends could be something fast, e.g., zram or zswap in
our case. And we prefer to save cold pages in zram or zswap, so when
they become hot, they will be brought back to the same node. If we
migrate them to a different node, we have no way to migrate them back
instantaneously when they become hot.

> Swappiness raises a similar question. Why would the user prefer one
> type of data to be reclaimed over the other? Shouldn't it want to
> reclaim the pages that are least likely to be used again soon?

We also need to consider how applications perceive the delays from an
anonymous page fault and a buffered io read differently. Even though
these two have the same cost, the delay from an anonymous page fault
may hurt applications more. For example, Chrome is aware that buffered
io reads can be blocking, and it delegates the work to io threads,
e.g., non-UI threads, so the delay will not affect user experience.
Does it make sense?

> > FAQ
> > ===
> > Why not try to improve the existing code?
> > -----------------------------------------
> > We have tried but concluded the aforementioned problems are
> > fundamental, and therefore changes made on top of them will not result
> > in substantial gains.
>
> Realistically, I think incremental changes are unavoidable to get this
> merged upstream.
>
> Not just in the sense that they need to be smaller changes, but also
> in the sense that they need to replace old code. It would be
> impossible to maintain both, focus development and testing resources,
> and provide a reasonably stable experience with both systems tugging
> at a complicated shared code base.
>
> On the other hand, the existing code also has billions of hours of
> production testing and tuning. We can't throw this all out overnight -
> it needs to be surgical and the broader consequences of each step need
> to be well understood.
>
> We also have millions of servers relying on being able to do upgrades
> for drivers and fixes in other subsystems that we can't put on hold
> until we stabilized a new reclaim implementation from scratch.
>
> The good thing is that swap really hasn't been used much
> recently. There definitely is room to maneuver without being too
> disruptive. There *are* swap configurations today, but for the most
> part, users don't expect the kernel to swap until the machine is under
> heavy pressure. Few have expectations of it doing a nuanced and
> efficient memory offloading job under nominal loads. So the anon side
> could well be a testbed for the multigen LRU that has a more
> reasonable blast radius than doing everything at once.
>
> And if the rmap replacement for mapped pages could be split out as a
> CPU optimzation for getting MMU info, without changing how those are
> interpreted in the same step, I think we'd get into a more manageable
> territory with this proposal.

Yeah, I hear you loud and clear. We are not really writing off any
options here, just weighing them in terms of opportunity cost. The
engineering effort is one of the major factors, but the performance
gain and the lead time are also very important to us.

IMO, it would be hard to make substantial progress if we just float
ideas around. We could use something concrete to keep the discussion
going. I am not saying this patchset should be the storyline. But at
least it can serve as the springboard, hopefully launching us to a
middle ground. Does it sound reasonable?

Again, thanks for the detailed review. You have made some excellent
points. I think I also have made some good ones too. Hopefully you
would agree. In any case, feel free to let me know.
