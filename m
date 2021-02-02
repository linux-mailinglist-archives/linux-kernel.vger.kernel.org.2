Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC3330BACC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 10:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbhBBJT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 04:19:58 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:3310 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbhBBJSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 04:18:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1612257529; x=1643793529;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=URXkxdXhgVTqMxYcWrdsreq+L2psQdcrvcPs2OISeNM=;
  b=DvWw8kkC/OB24XAg5Eu2ZqZ/IoP0j8+6NxULrdx4RPZFvag/4X0nd28P
   sRnlFcRSnpxLaK7mutJXiqfKfhSQrAgEuODVNxcCJYj/Jckdu0Uv0Ea0I
   WlhlOXqWP6XKNEPG+2nGrwRBBXg+nCP+n1J/l7YfpmuACMu/7MF+QUsaz
   c=;
X-IronPort-AV: E=Sophos;i="5.79,394,1602547200"; 
   d="scan'208";a="79232381"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-af6a10df.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 02 Feb 2021 09:17:50 +0000
Received: from EX13D31EUA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1a-af6a10df.us-east-1.amazon.com (Postfix) with ESMTPS id D9C89A2256;
        Tue,  2 Feb 2021 09:17:38 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.146) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 2 Feb 2021 09:17:21 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     SeongJae Park <sjpark@amazon.com>,
        SeongJae Park <sjpark@amazon.de>,
        <Jonathan.Cameron@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Qian Cai <cai@lca.pw>,
        Colin Ian King <colin.king@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "David Hildenbrand" <david@redhat.com>, <dwmw@amazon.com>,
        Marco Elver <elver@google.com>, "Du, Fan" <fan.du@intel.com>,
        <foersleo@amazon.de>, "Greg Thelen" <gthelen@google.com>,
        Ian Rogers <irogers@google.com>, <jolsa@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Mark Rutland <mark.rutland@arm.com>,
        Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, <namhyung@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@kernel.org>, <sblbir@amazon.com>,
        Shuah Khan <shuah@kernel.org>, <sj38.park@gmail.com>,
        <snu@amazon.de>, Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Huang Ying <ying.huang@intel.com>, <zgf574564920@gmail.com>,
        <linux-damon@amazon.com>, Linux MM <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v23 02/15] mm/damon/core: Implement region-based sampling
Date:   Tue, 2 Feb 2021 10:17:05 +0100
Message-ID: <20210202091705.812-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CALvZod72UxP4tmrZSrDgUJrDpWM67v=MyB8CEWhy0Osgm6O+Ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.146]
X-ClientProxiedBy: EX13D10UWA004.ant.amazon.com (10.43.160.64) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Feb 2021 09:37:29 -0800 Shakeel Butt <shakeelb@google.com> wrote:

> On Tue, Dec 15, 2020 at 3:56 AM SeongJae Park <sjpark@amazon.com> wrote:
> >
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > To avoid the unbounded increase of the overhead, DAMON groups adjacent
> > pages that assumed to have the same access frequencies into a region.
> 
> 'that are assumed'

Good eye!

> 
> > As long as the assumption (pages in a region have the same access
> > frequencies) is kept, only one page in the region is required to be
> > checked.  Thus, for each ``sampling interval``,
> >
> >  1. the 'prepare_access_checks' primitive picks one page in each region,
> >  2. waits for one ``sampling interval``,
> >  3. checks whether the page is accessed meanwhile, and
> >  4. increases the access frequency of the region if so.
> 
> I think you meant increasing the access 'count' or something.
> Increasing the access frequency somewhat conveys that the sampling
> interval is being decreased.

You're right, I will reword this in the next version.

> 
> >
> > Therefore, the monitoring overhead is controllable by adjusting the
> > number of regions.  DAMON allows both the underlying primitives and user
> > callbacks adjust regions for the trade-off.  In other words, this commit
> 
> 'callbacks to adjust'

Nice catch!

> 
> 
> > makes DAMON to use not only time-based sampling but also space-based
> > sampling.
> >
> > This scheme, however, cannot preserve the quality of the output if the
> > assumption is not guaranteed.  Next commit will address this problem.
> >
> > Another problem of this region abstraction is additional memory space
> > overhead for the regions metadata.  For example, suppose page
> > granularity monitoring that doesn't want to know fine-grained access
> > frequency but only if each page accessed or not.
> 
> You mean when the sampling interval is equal to the aggregation interval, right?

Right, that would be a straightforward way to get the information with region
abstraction.

> 
> > Then, we can do that
> > by directly resetting and reading the PG_Idle flags and/or the PTE
> > Accessed bits.  The metadata for the region abstraction is only burden
> > in the case.  For the reason, this commit makes DAMON to support the
> > user-defined arbitrary target, which could be stored in a void pointer
> > of the monitoring context with specific target type.
> 
> Sorry I didn't follow. How does sampling interval equal to aggregation
> interval require user-defined arbitrary targets?

So, setting sampling interval equal to aggregation interval is a
straightforward way to get the if-accessed-only information with the
region-based sampling.  However, this will waste memory with region metadata
(observed accesses counter).  The wastage becomes much worse if we do
page-granularity monitoring, because the region metadata for start address and
end address of the regions would not necessary.

Someone can implement and use monitoring primitives making no such waste by
using thir own abstraction rather than the regions abstraction (and therefore
no regions metadata).  To allow that, we make the regions abstraction to be
used only when the context is configured for special target type
(DAMON_REGION_SAMPLING_TARGET) and allow users to use their own arbitrary
abstraction with the arbitrary target type.

An RFC patchset for an example implementation of the arbitrary target type is
available:
https://lore.kernel.org/linux-mm/20201216094221.11898-1-sjpark@amazon.com/

> 
> >
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> > ---
> >  include/linux/damon.h | 109 ++++++++++++++++++++++++++++++--
> >  mm/damon/core.c       | 142 +++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 243 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index 387fa4399fc8..7d4685adc8a9 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -12,6 +12,48 @@
> >  #include <linux/time64.h>
> >  #include <linux/types.h>
> >
> > +/**
> > + * struct damon_addr_range - Represents an address region of [@start, @end).
> > + * @start:     Start address of the region (inclusive).
> > + * @end:       End address of the region (exclusive).
> > + */
> > +struct damon_addr_range {
> > +       unsigned long start;
> > +       unsigned long end;
> > +};
> > +
> > +/**
> > + * struct damon_region - Represents a monitoring target region.
> > + * @ar:                        The address range of the region.
> > + * @sampling_addr:     Address of the sample for the next access check.
> > + * @nr_accesses:       Access frequency of this region.
> > + * @list:              List head for siblings.
> > + */
> > +struct damon_region {
> > +       struct damon_addr_range ar;
> > +       unsigned long sampling_addr;
> > +       unsigned int nr_accesses;
> > +       struct list_head list;
> > +};
> > +
> > +/**
> > + * struct damon_target - Represents a monitoring target.
> > + * @id:                        Unique identifier for this target.
> > + * @regions_list:      Head of the monitoring target regions of this target.
> > + * @list:              List head for siblings.
> > + *
> > + * Each monitoring context could have multiple targets.  For example, a context
> > + * for virtual memory address spaces could have multiple target processes.  The
> > + * @id of each target should be unique among the targets of the context.  For
> > + * example, in the virtual address monitoring context, it could be a pidfd or
> > + * an address of an mm_struct.
> > + */
> > +struct damon_target {
> > +       unsigned long id;
> > +       struct list_head regions_list;
> > +       struct list_head list;
> > +};
> > +
> >  struct damon_ctx;
> >
> >  /**
> > @@ -36,7 +78,8 @@ struct damon_ctx;
> >   *
> >   * @init_target_regions should construct proper monitoring target regions and
> >   * link those to the DAMON context struct.  The regions should be defined by
> > - * user and saved in @damon_ctx.target.
> > + * user and saved in @damon_ctx.arbitrary_target if @damon_ctx.target_type is
> > + * &DAMON_ARBITRARY_TARGET.  Otherwise, &struct damon_region should be used.
> >   * @update_target_regions should update the monitoring target regions for
> >   * current status.
> >   * @prepare_access_checks should manipulate the monitoring regions to be
> > @@ -46,7 +89,8 @@ struct damon_ctx;
> >   * @reset_aggregated should reset the access monitoring results that aggregated
> >   * by @check_accesses.
> >   * @target_valid should check whether the target is still valid for the
> > - * monitoring.
> > + * monitoring.  It receives &damon_ctx.arbitrary_target or &struct damon_target
> > + * pointer depends on &damon_ctx.target_type.
> >   * @cleanup is called from @kdamond just before its termination.  After this
> >   * call, only @kdamond_lock and @kdamond will be touched.
> >   */
> > @@ -91,6 +135,17 @@ struct damon_callback {
> >         int (*before_terminate)(struct damon_ctx *context);
> >  };
> >
> > +/**
> > + * enum damon_target_type - Represents the type of the monitoring target.
> > + *
> > + * @DAMON_REGION_SAMPLING_TARGET:      Region based sampling target.
> > + * @DAMON_ARBITRARY_TARGET:            User-defined arbitrary type target.
> > + */
> > +enum damon_target_type {
> > +       DAMON_REGION_SAMPLING_TARGET,
> > +       DAMON_ARBITRARY_TARGET,
> 
> I would suggest removing the arbitrary target in this pathset. This
> patchset is only adding the region sampling target, so no need to add
> the arbitrary target here.

I think arbitrary targt type is necessary for above mentioned case.  Also, this
makes backward compatible for the previous patch.  However, as this patchset
doesn't introduce the real use of the arbitrary target type, I think it's also
ok to introduce this later.  So I will drop this as you suggested in the next
version.

[...]
> > +
> > +/*
> > + * Add a region between two other regions
> > + */
> > +inline void damon_insert_region(struct damon_region *r,
> > +               struct damon_region *prev, struct damon_region *next)
> > +{
> > +       __list_add(&r->list, &prev->list, &next->list);
> > +}
> > +
> > +void damon_add_region(struct damon_region *r, struct damon_target *t)
> > +{
> > +       list_add_tail(&r->list, &t->regions_list);
> > +}
> > +
> 
> I don't see the benefit of these one line functions at least the following two.

We might want to use different data structures such as rbtree for regions
later.  So I want to make the programming interface independent of the data
structure.  This wrappers would help that.

[...]

Thanks,
SeongJae Park
