Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6897D30BB4B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 10:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhBBJpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 04:45:03 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:40603 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhBBJnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 04:43:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1612259018; x=1643795018;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=5iWY4HJnwN3LSwYQfeTHsayARu02XJfx0fqQlr0TWJk=;
  b=mMvsRIcAfqU9Np/VzHvuV0ngjhiRW3X6IsEcWJF3+wRAvclDH7dzUxqZ
   UqDnlaJZPekLn5NKnf2MIq0ZbNMi903/tAPKa5VlMrWeWvGhblASRfl2T
   mJtz9eLU36Y1X75ykcZjLCbdl3fRKvPCCsTTvUmzm94pQO+wjj1IIAML3
   M=;
X-IronPort-AV: E=Sophos;i="5.79,394,1602547200"; 
   d="scan'208";a="108048878"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-baacba05.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 02 Feb 2021 09:40:21 +0000
Received: from EX13D31EUA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-baacba05.us-west-2.amazon.com (Postfix) with ESMTPS id 82434A06B0;
        Tue,  2 Feb 2021 09:40:10 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.162.32) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 2 Feb 2021 09:39:52 +0000
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
Subject: Re: [PATCH v23 03/15] mm/damon: Adaptively adjust regions
Date:   Tue, 2 Feb 2021 10:39:37 +0100
Message-ID: <20210202093937.5411-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CALvZod4xsjCjokKeEfoBQt0A2sbs2z58ChArDsaMeAjfu10+Qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.32]
X-ClientProxiedBy: EX13D18UWC001.ant.amazon.com (10.43.162.105) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Feb 2021 09:37:33 -0800 Shakeel Butt <shakeelb@google.com> wrote:

> On Tue, Dec 15, 2020 at 3:57 AM SeongJae Park <sjpark@amazon.com> wrote:
> >
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > Even somehow the initial monitoring target regions are well constructed
> > to fulfill the assumption (pages in same region have similar access
> > frequencies), the data access pattern can be dynamically changed.  This
> > will result in low monitoring quality.  To keep the assumption as much
> > as possible, DAMON adaptively merges and splits each region based on
> > their access frequency.
> >
> > For each ``aggregation interval``, it compares the access frequencies of
> > adjacent regions and merges those if the frequency difference is small.
> > Then, after it reports and clears the aggregated access frequency of
> > each region, it splits each region into two or three regions if the
> > total number of regions will not exceed the user-specified maximum
> > number of regions after the split.
> 
> Should there be any concerns regarding the number of regions
> oscillating even when the access pattern of the application is not
> changing? Does the system converge to equilibrium state or does it not
> matter?

DAMON will continue splitting regions, but all the changes will be reverted by
merging.  Because callbacks are called after merging finished, this would not
matter.

> 
> >
> > In this way, DAMON provides its best-effort quality and minimal overhead
> > while keeping the upper-bound overhead that users set.
> >
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> > ---
> >  include/linux/damon.h |  41 +++++---
> >  mm/damon/core.c       | 220 ++++++++++++++++++++++++++++++++++++++++--
> >  2 files changed, 240 insertions(+), 21 deletions(-)
> >
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index 7d4685adc8a9..f446f8433599 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -12,6 +12,9 @@
> >  #include <linux/time64.h>
> >  #include <linux/types.h>
> >
> > +/* Minimal region size.  Every damon_region is aligned by this. */
> > +#define DAMON_MIN_REGION       PAGE_SIZE
> > +
> >  /**
> >   * struct damon_addr_range - Represents an address region of [@start, @end).
> >   * @start:     Start address of the region (inclusive).
> > @@ -86,6 +89,8 @@ struct damon_ctx;
> >   * prepared for the next access check.
> >   * @check_accesses should check the accesses to each region that made after the
> >   * last preparation and update the number of observed accesses of each region.
> > + * It should also return max number of observed accesses that made as a result
> > + * of its update.
> 
> Why?

To get the max access count without additional iteration of regions.  The count
will be used to calculate merge/split threshold.  I will add this explanation
in the next version.

The additional iteration would not be a real performance bottleneck for usual
case, so I we could make this optimization later.  However, because making such
optimization with callback interface would cause some backward compatibility
issue, I'd like to do this now.

> 
> >   * @reset_aggregated should reset the access monitoring results that aggregated
> >   * by @check_accesses.
> >   * @target_valid should check whether the target is still valid for the
[...]
> >
> > +unsigned int damon_nr_regions(struct damon_target *t)
> > +{
> > +       struct damon_region *r;
> > +       unsigned int nr_regions = 0;
> > +
> > +       damon_for_each_region(r, t)
> > +               nr_regions++;
> 
> Why not just add the region_count filed in damon_target?

Just to make the code simpler.  We can easily optimize in the way if this turns
out to be a real performance bottleneck.

> 
> > +
> > +       return nr_regions;
> > +}
> > +
> >  struct damon_ctx *damon_new_ctx(enum damon_target_type type)
> >  {
> >         struct damon_ctx *ctx;
> > @@ -128,8 +143,12 @@ struct damon_ctx *damon_new_ctx(enum damon_target_type type)
> >         mutex_init(&ctx->kdamond_lock);
> >
> >         ctx->target_type = type;
> > -       if (type != DAMON_ARBITRARY_TARGET)
> > -               INIT_LIST_HEAD(&ctx->region_targets);
> > +       if (type != DAMON_ARBITRARY_TARGET) {
> > +               ctx->min_nr_regions = 10;
> > +               ctx->max_nr_regions = 1000;
> 
> IMO these settings/heuristics should be part of the virtual address
> space monitor primitives and not be in the core monitor.

These are just default values.  For the adpative regions adjustment, I think we
agreed on adding it in the core for now.

> 
> > +
> > +               INIT_LIST_HEAD(&ctx->adaptive_targets);
> > +       }
> >
> >         return ctx;
> >  }
[...]
> > +
> > +/*
> > + * Split every target region into randomly-sized small regions
> > + *
> > + * This function splits every target region into random-sized small regions if
> > + * current total number of the regions is equal or smaller than half of the
> > + * user-specified maximum number of regions.  This is for maximizing the
> > + * monitoring accuracy under the dynamically changeable access patterns.  If a
> > + * split was unnecessarily made, later 'kdamond_merge_regions()' will revert
> > + * it.
> > + */
> > +static void kdamond_split_regions(struct damon_ctx *ctx)
> > +{
> > +       struct damon_target *t;
> > +       unsigned int nr_regions = 0;
> > +       static unsigned int last_nr_regions;
> > +       int nr_subregions = 2;
> > +
> > +       damon_for_each_target(t, ctx)
> > +               nr_regions += damon_nr_regions(t);
> > +
> > +       if (nr_regions > ctx->max_nr_regions / 2)
> > +               return;
> 
> Shouldn't the limits on region be per-target instead of for the whole context?

I think this makes the monitoring overhead upperbound setting simpler.  If we
need to set per-target monitoring upperbound, we can use multiple contexts for
each target.

> 
> > +
> > +       /* Maybe the middle of the region has different access frequency */
> > +       if (last_nr_regions == nr_regions &&
> > +                       nr_regions < ctx->max_nr_regions / 3)
> > +               nr_subregions = 3;
> > +
> > +       damon_for_each_target(t, ctx)
> > +               damon_split_regions_of(ctx, t, nr_subregions);
> > +
> > +       last_nr_regions = nr_regions;
> > +}
> > +
> >  /*
> >   * Check whether it is time to check and apply the target monitoring regions
> >   *
> > @@ -391,6 +588,8 @@ static int kdamond_fn(void *data)
> >         struct damon_ctx *ctx = (struct damon_ctx *)data;
> >         struct damon_target *t;
> >         struct damon_region *r, *next;
> > +       unsigned int max_nr_accesses = 0;
> > +       unsigned long sz_limit = 0;
> >
> >         pr_info("kdamond (%d) starts\n", ctx->kdamond->pid);
> >
> > @@ -399,6 +598,8 @@ static int kdamond_fn(void *data)
> >         if (ctx->callback.before_start && ctx->callback.before_start(ctx))
> >                 set_kdamond_stop(ctx);
> >
> > +       sz_limit = damon_region_sz_limit(ctx);
> > +
> >         while (!kdamond_need_stop(ctx)) {
> >                 if (ctx->primitive.prepare_access_checks)
> >                         ctx->primitive.prepare_access_checks(ctx);
> > @@ -409,14 +610,20 @@ static int kdamond_fn(void *data)
> >                 usleep_range(ctx->sample_interval, ctx->sample_interval + 1);
> >
> >                 if (ctx->primitive.check_accesses)
> > -                       ctx->primitive.check_accesses(ctx);
> > +                       max_nr_accesses = ctx->primitive.check_accesses(ctx);
> >
> >                 if (kdamond_aggregate_interval_passed(ctx)) {
> > +                       if (ctx->target_type != DAMON_ARBITRARY_TARGET)
> > +                               kdamond_merge_regions(ctx,
> > +                                               max_nr_accesses / 10,
> 
> What's the reason behind this 10?

It came from my gut feeling and it is still there because it worked well with
my test workloads.  I think we could change that or allow users adjustable if
problematic case is found later.


Thanks,
SeongJae Park
[...]
