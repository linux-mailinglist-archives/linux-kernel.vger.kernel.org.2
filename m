Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285B830AE0E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 18:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhBARii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 12:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbhBARiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 12:38:22 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7907C0613ED
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 09:37:42 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id r14so20691395ljc.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 09:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y6U2QNvH8fRxa2/PkHh5AxDO4IcF2D4+c8V1o0MSwxs=;
        b=g7xy9IBidRBG+EQEzXyKYmoAnqC7GJZM0vmRib0NdvlSy9UpVk0r0NvJyKxFZ84wqs
         R7BHKzFxRZuFkcMxsupsWzXs+XeWhIaPTG1qdxRFVWqXcQaQPQhb1BaZcNbmyf2HYmKf
         iqTp6MGhIE9lKfF7dinPYtFStzNBdHv7AbTK5embhDV+0tp27W3apeLqjycLJ+eV9xOJ
         VBe09a2Pu1H25OKD5uictz7bSYCXlSRKp7JXo8OSWIGmDQVDhs4MyhdzExzye5D1aSoi
         IOXRG25k60U87hgnyu7Vr+ajx/yMG+yBD+LMFcccSY6P9y/eCHlU2/YI9yuTL9D4uPK5
         Dw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y6U2QNvH8fRxa2/PkHh5AxDO4IcF2D4+c8V1o0MSwxs=;
        b=UFv2D53BM9XwsVRP34QVTq8G8Zod3H5YfCB4meOBxeYwDsMboKfQmBYwG78ZvyCbin
         XMWzCSlMXQS98MDtVExzZhCKZnVPqmIEse3ZV4KbUPsWd/HUyJ9FnyyHTtsZV/MpNPnA
         L24u44+F6rRvWbMeM6CgzhO+hu7XOdESY3qxCb4fxPUKQh5T9xsHWuw0QRIAw8R78y9d
         13NezzbL90gx4ikWP7rIoqIVp57Jv7s17woj8DysDFUxlu26HhL0xPnEyI3yprtVATMp
         c5Ir2wWiVwRHAwX22k71yZAwiiYWLGejsvldGVLCi9Mn7NBbsUtVF33ZVQki8kY0h3iP
         w8KA==
X-Gm-Message-State: AOAM531FViZwOml45O65ylI0f0lR4Yx8LiRp+o4bu2VUNcWDA4/4r3RT
        u6MCE08Sx9enO/or0jsN7mgnlI74B8Q46Zt5tkTpPQ==
X-Google-Smtp-Source: ABdhPJyeBoqYPGRFeyd4JPfJVqMm7/6SRMNozpgUXVdbyjYEkhJHuZvsbgaLvoPp4IbIeO7JFHHpWNM+zar5l1NEq60=
X-Received: by 2002:a05:651c:39c:: with SMTP id e28mr10893727ljp.81.1612201060638;
 Mon, 01 Feb 2021 09:37:40 -0800 (PST)
MIME-Version: 1.0
References: <20201215115448.25633-1-sjpark@amazon.com> <20201215115448.25633-3-sjpark@amazon.com>
In-Reply-To: <20201215115448.25633-3-sjpark@amazon.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 1 Feb 2021 09:37:29 -0800
Message-ID: <CALvZod72UxP4tmrZSrDgUJrDpWM67v=MyB8CEWhy0Osgm6O+Ww@mail.gmail.com>
Subject: Re: [PATCH v23 02/15] mm/damon/core: Implement region-based sampling
To:     SeongJae Park <sjpark@amazon.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@huawei.com,
        Andrea Arcangeli <aarcange@redhat.com>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        benh@kernel.crashing.org, brendan.d.gregg@gmail.com,
        Brendan Higgins <brendanhiggins@google.com>,
        Qian Cai <cai@lca.pw>,
        Colin Ian King <colin.king@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>, dwmw@amazon.com,
        Marco Elver <elver@google.com>, "Du, Fan" <fan.du@intel.com>,
        foersleo@amazon.de, Greg Thelen <gthelen@google.com>,
        Ian Rogers <irogers@google.com>, jolsa@redhat.com,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Mark Rutland <mark.rutland@arm.com>,
        Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, namhyung@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@kernel.org>, sblbir@amazon.com,
        Shuah Khan <shuah@kernel.org>, sj38.park@gmail.com,
        snu@amazon.de, Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Huang Ying <ying.huang@intel.com>, zgf574564920@gmail.com,
        linux-damon@amazon.com, Linux MM <linux-mm@kvack.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 3:56 AM SeongJae Park <sjpark@amazon.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> To avoid the unbounded increase of the overhead, DAMON groups adjacent
> pages that assumed to have the same access frequencies into a region.

'that are assumed'

> As long as the assumption (pages in a region have the same access
> frequencies) is kept, only one page in the region is required to be
> checked.  Thus, for each ``sampling interval``,
>
>  1. the 'prepare_access_checks' primitive picks one page in each region,
>  2. waits for one ``sampling interval``,
>  3. checks whether the page is accessed meanwhile, and
>  4. increases the access frequency of the region if so.

I think you meant increasing the access 'count' or something.
Increasing the access frequency somewhat conveys that the sampling
interval is being decreased.

>
> Therefore, the monitoring overhead is controllable by adjusting the
> number of regions.  DAMON allows both the underlying primitives and user
> callbacks adjust regions for the trade-off.  In other words, this commit

'callbacks to adjust'


> makes DAMON to use not only time-based sampling but also space-based
> sampling.
>
> This scheme, however, cannot preserve the quality of the output if the
> assumption is not guaranteed.  Next commit will address this problem.
>
> Another problem of this region abstraction is additional memory space
> overhead for the regions metadata.  For example, suppose page
> granularity monitoring that doesn't want to know fine-grained access
> frequency but only if each page accessed or not.

You mean when the sampling interval is equal to the aggregation interval, right?

> Then, we can do that
> by directly resetting and reading the PG_Idle flags and/or the PTE
> Accessed bits.  The metadata for the region abstraction is only burden
> in the case.  For the reason, this commit makes DAMON to support the
> user-defined arbitrary target, which could be stored in a void pointer
> of the monitoring context with specific target type.

Sorry I didn't follow. How does sampling interval equal to aggregation
interval require user-defined arbitrary targets?

>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> ---
>  include/linux/damon.h | 109 ++++++++++++++++++++++++++++++--
>  mm/damon/core.c       | 142 +++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 243 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 387fa4399fc8..7d4685adc8a9 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -12,6 +12,48 @@
>  #include <linux/time64.h>
>  #include <linux/types.h>
>
> +/**
> + * struct damon_addr_range - Represents an address region of [@start, @end).
> + * @start:     Start address of the region (inclusive).
> + * @end:       End address of the region (exclusive).
> + */
> +struct damon_addr_range {
> +       unsigned long start;
> +       unsigned long end;
> +};
> +
> +/**
> + * struct damon_region - Represents a monitoring target region.
> + * @ar:                        The address range of the region.
> + * @sampling_addr:     Address of the sample for the next access check.
> + * @nr_accesses:       Access frequency of this region.
> + * @list:              List head for siblings.
> + */
> +struct damon_region {
> +       struct damon_addr_range ar;
> +       unsigned long sampling_addr;
> +       unsigned int nr_accesses;
> +       struct list_head list;
> +};
> +
> +/**
> + * struct damon_target - Represents a monitoring target.
> + * @id:                        Unique identifier for this target.
> + * @regions_list:      Head of the monitoring target regions of this target.
> + * @list:              List head for siblings.
> + *
> + * Each monitoring context could have multiple targets.  For example, a context
> + * for virtual memory address spaces could have multiple target processes.  The
> + * @id of each target should be unique among the targets of the context.  For
> + * example, in the virtual address monitoring context, it could be a pidfd or
> + * an address of an mm_struct.
> + */
> +struct damon_target {
> +       unsigned long id;
> +       struct list_head regions_list;
> +       struct list_head list;
> +};
> +
>  struct damon_ctx;
>
>  /**
> @@ -36,7 +78,8 @@ struct damon_ctx;
>   *
>   * @init_target_regions should construct proper monitoring target regions and
>   * link those to the DAMON context struct.  The regions should be defined by
> - * user and saved in @damon_ctx.target.
> + * user and saved in @damon_ctx.arbitrary_target if @damon_ctx.target_type is
> + * &DAMON_ARBITRARY_TARGET.  Otherwise, &struct damon_region should be used.
>   * @update_target_regions should update the monitoring target regions for
>   * current status.
>   * @prepare_access_checks should manipulate the monitoring regions to be
> @@ -46,7 +89,8 @@ struct damon_ctx;
>   * @reset_aggregated should reset the access monitoring results that aggregated
>   * by @check_accesses.
>   * @target_valid should check whether the target is still valid for the
> - * monitoring.
> + * monitoring.  It receives &damon_ctx.arbitrary_target or &struct damon_target
> + * pointer depends on &damon_ctx.target_type.
>   * @cleanup is called from @kdamond just before its termination.  After this
>   * call, only @kdamond_lock and @kdamond will be touched.
>   */
> @@ -91,6 +135,17 @@ struct damon_callback {
>         int (*before_terminate)(struct damon_ctx *context);
>  };
>
> +/**
> + * enum damon_target_type - Represents the type of the monitoring target.
> + *
> + * @DAMON_REGION_SAMPLING_TARGET:      Region based sampling target.
> + * @DAMON_ARBITRARY_TARGET:            User-defined arbitrary type target.
> + */
> +enum damon_target_type {
> +       DAMON_REGION_SAMPLING_TARGET,
> +       DAMON_ARBITRARY_TARGET,

I would suggest removing the arbitrary target in this pathset. This
patchset is only adding the region sampling target, so no need to add
the arbitrary target here.

> +};
> +
>  /**
>   * struct damon_ctx - Represents a context for each monitoring.  This is the
>   * main interface that allows users to set the attributes and get the results
> @@ -130,7 +185,15 @@ struct damon_callback {
>   * @primitive: Set of monitoring primitives for given use cases.
>   * @callback:  Set of callbacks for monitoring events notifications.
>   *
> - * @target:    Pointer to the user-defined monitoring target.
> + * @target_type:       Type of the monitoring target.
> + *
> + * @region_targets:    Head of monitoring targets (&damon_target) list.
> + *
> + * @arbitrary_target:  Pointer to arbitrary type target.
> + *
> + * @region_targets are valid only if @target_type is
> + * DAMON_REGION_SAMPLING_TARGET.  @arbitrary_target is valid only if
> + * @target_type is DAMON_ARBITRARY_TARGET.
>   */
>  struct damon_ctx {
>         unsigned long sample_interval;
> @@ -149,12 +212,48 @@ struct damon_ctx {
>         struct damon_primitive primitive;
>         struct damon_callback callback;
>
> -       void *target;
> +       enum damon_target_type target_type;
> +       union {
> +               /* DAMON_REGION_SAMPLING_TARGET */
> +               struct list_head region_targets;
> +
> +               /* DAMON_ARBITRARY_TARGET */
> +               void *arbitrary_target;
> +       };
>  };
>
> +#define damon_next_region(r) \
> +       (container_of(r->list.next, struct damon_region, list))
> +
> +#define damon_prev_region(r) \
> +       (container_of(r->list.prev, struct damon_region, list))
> +
> +#define damon_for_each_region(r, t) \
> +       list_for_each_entry(r, &t->regions_list, list)
> +
> +#define damon_for_each_region_safe(r, next, t) \
> +       list_for_each_entry_safe(r, next, &t->regions_list, list)
> +
> +#define damon_for_each_target(t, ctx) \
> +       list_for_each_entry(t, &(ctx)->region_targets, list)
> +
> +#define damon_for_each_target_safe(t, next, ctx)       \
> +       list_for_each_entry_safe(t, next, &(ctx)->region_targets, list)
> +
>  #ifdef CONFIG_DAMON
>
> -struct damon_ctx *damon_new_ctx(void);
> +struct damon_region *damon_new_region(unsigned long start, unsigned long end);
> +inline void damon_insert_region(struct damon_region *r,
> +               struct damon_region *prev, struct damon_region *next);
> +void damon_add_region(struct damon_region *r, struct damon_target *t);
> +void damon_destroy_region(struct damon_region *r);
> +
> +struct damon_target *damon_new_target(unsigned long id);
> +void damon_add_target(struct damon_ctx *ctx, struct damon_target *t);
> +void damon_free_target(struct damon_target *t);
> +void damon_destroy_target(struct damon_target *t);
> +
> +struct damon_ctx *damon_new_ctx(enum damon_target_type type);
>  void damon_destroy_ctx(struct damon_ctx *ctx);
>  int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
>                 unsigned long aggr_int, unsigned long regions_update_int);
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 8963804efdf9..167487e75737 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -15,7 +15,102 @@
>  static DEFINE_MUTEX(damon_lock);
>  static int nr_running_ctxs;
>
> -struct damon_ctx *damon_new_ctx(void)
> +/*
> + * Construct a damon_region struct
> + *
> + * Returns the pointer to the new struct if success, or NULL otherwise
> + */
> +struct damon_region *damon_new_region(unsigned long start, unsigned long end)
> +{
> +       struct damon_region *region;
> +
> +       region = kmalloc(sizeof(*region), GFP_KERNEL);
> +       if (!region)
> +               return NULL;
> +
> +       region->ar.start = start;
> +       region->ar.end = end;
> +       region->nr_accesses = 0;
> +       INIT_LIST_HEAD(&region->list);
> +
> +       return region;
> +}
> +
> +/*
> + * Add a region between two other regions
> + */
> +inline void damon_insert_region(struct damon_region *r,
> +               struct damon_region *prev, struct damon_region *next)
> +{
> +       __list_add(&r->list, &prev->list, &next->list);
> +}
> +
> +void damon_add_region(struct damon_region *r, struct damon_target *t)
> +{
> +       list_add_tail(&r->list, &t->regions_list);
> +}
> +

I don't see the benefit of these one line functions at least the following two.


> +static void damon_del_region(struct damon_region *r)
> +{
> +       list_del(&r->list);
> +}
> +
> +static void damon_free_region(struct damon_region *r)
> +{
> +       kfree(r);
> +}
> +
> +void damon_destroy_region(struct damon_region *r)
> +{
> +       damon_del_region(r);
> +       damon_free_region(r);
> +}
> +
> +/*
> + * Construct a damon_target struct
> + *
> + * Returns the pointer to the new struct if success, or NULL otherwise
> + */
> +struct damon_target *damon_new_target(unsigned long id)
> +{
> +       struct damon_target *t;
> +
> +       t = kmalloc(sizeof(*t), GFP_KERNEL);
> +       if (!t)
> +               return NULL;
> +
> +       t->id = id;
> +       INIT_LIST_HEAD(&t->regions_list);
> +
> +       return t;
> +}
> +
> +void damon_add_target(struct damon_ctx *ctx, struct damon_target *t)
> +{
> +       list_add_tail(&t->list, &ctx->region_targets);
> +}
> +
> +static void damon_del_target(struct damon_target *t)
> +{
> +       list_del(&t->list);
> +}
> +
> +void damon_free_target(struct damon_target *t)
> +{
> +       struct damon_region *r, *next;
> +
> +       damon_for_each_region_safe(r, next, t)
> +               damon_free_region(r);
> +       kfree(t);
> +}
> +
> +void damon_destroy_target(struct damon_target *t)
> +{
> +       damon_del_target(t);
> +       damon_free_target(t);
> +}
> +
> +struct damon_ctx *damon_new_ctx(enum damon_target_type type)
>  {
>         struct damon_ctx *ctx;
>
> @@ -32,13 +127,20 @@ struct damon_ctx *damon_new_ctx(void)
>
>         mutex_init(&ctx->kdamond_lock);
>
> -       ctx->target = NULL;
> +       ctx->target_type = type;
> +       if (type != DAMON_ARBITRARY_TARGET)
> +               INIT_LIST_HEAD(&ctx->region_targets);
>
>         return ctx;
>  }
>
>  void damon_destroy_ctx(struct damon_ctx *ctx)
>  {
> +       struct damon_target *t, *next_t;
> +
> +       damon_for_each_target_safe(t, next_t, ctx)
> +               damon_destroy_target(t);
> +
>         kfree(ctx);
>  }
>
> @@ -215,6 +317,21 @@ static bool kdamond_aggregate_interval_passed(struct damon_ctx *ctx)
>                         ctx->aggr_interval);
>  }
>
> +/*
> + * Reset the aggregated monitoring results ('nr_accesses' of each region).
> + */
> +static void kdamond_reset_aggregated(struct damon_ctx *c)
> +{
> +       struct damon_target *t;
> +
> +       damon_for_each_target(t, c) {
> +               struct damon_region *r;
> +
> +               damon_for_each_region(r, t)
> +                       r->nr_accesses = 0;
> +       }
> +}
> +
>  /*
>   * Check whether it is time to check and apply the target monitoring regions
>   *
> @@ -236,6 +353,7 @@ static bool kdamond_need_update_regions(struct damon_ctx *ctx)
>   */
>  static bool kdamond_need_stop(struct damon_ctx *ctx)
>  {
> +       struct damon_target *t;
>         bool stop;
>
>         mutex_lock(&ctx->kdamond_lock);
> @@ -247,7 +365,15 @@ static bool kdamond_need_stop(struct damon_ctx *ctx)
>         if (!ctx->primitive.target_valid)
>                 return false;
>
> -       return !ctx->primitive.target_valid(ctx->target);
> +       if (ctx->target_type == DAMON_ARBITRARY_TARGET)
> +               return !ctx->primitive.target_valid(ctx->arbitrary_target);
> +
> +       damon_for_each_target(t, ctx) {
> +               if (ctx->primitive.target_valid(t))
> +                       return false;
> +       }
> +
> +       return true;
>  }
>
>  static void set_kdamond_stop(struct damon_ctx *ctx)
> @@ -263,6 +389,8 @@ static void set_kdamond_stop(struct damon_ctx *ctx)
>  static int kdamond_fn(void *data)
>  {
>         struct damon_ctx *ctx = (struct damon_ctx *)data;
> +       struct damon_target *t;
> +       struct damon_region *r, *next;
>
>         pr_info("kdamond (%d) starts\n", ctx->kdamond->pid);
>
> @@ -287,6 +415,8 @@ static int kdamond_fn(void *data)
>                         if (ctx->callback.after_aggregation &&
>                                         ctx->callback.after_aggregation(ctx))
>                                 set_kdamond_stop(ctx);
> +                       if (ctx->target_type != DAMON_ARBITRARY_TARGET)
> +                               kdamond_reset_aggregated(ctx);
>                         if (ctx->primitive.reset_aggregated)
>                                 ctx->primitive.reset_aggregated(ctx);
>                 }
> @@ -296,6 +426,12 @@ static int kdamond_fn(void *data)
>                                 ctx->primitive.update_target_regions(ctx);
>                 }
>         }
> +       if (ctx->target_type != DAMON_ARBITRARY_TARGET) {
> +               damon_for_each_target(t, ctx) {
> +                       damon_for_each_region_safe(r, next, t)
> +                               damon_destroy_region(r);
> +               }
> +       }
>
>         if (ctx->callback.before_terminate &&
>                         ctx->callback.before_terminate(ctx))
> --
> 2.17.1
>
