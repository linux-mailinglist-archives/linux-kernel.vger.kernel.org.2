Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152FB30AE1B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 18:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbhBARjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 12:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbhBARi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 12:38:27 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A816C061788
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 09:37:47 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id h7so23946525lfc.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 09:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pr9yEX6+41tcOKzs8ka4T7m79nyh27Sasjlj0AbUWcU=;
        b=TKohvRVZleF35I5DcEDK0LOTqLhCfqAVuUiS++Ik4a8JGO55/98z7ixblJOpdyVVPG
         h0k0t9FBfwi7YSH1BJ2D6K5U56doPuJxNzAF7GgXNLZPwNZS2TfCyrQYoaCSX1qr6Vqw
         ILXc9aAEcgLO/TmqpgKO6/WfKZ5tP0LdPCrYSf4ownexG9HeUOcbgkBfy34AdkQMMIQd
         L+RoUeKfPfA1kAFoI4M66YVkQwlxHQw/lNvABAMUGe59jJAzhoKy8If1Rrm5llhmn6YT
         FkYxroRfaNJm3SJMXnJ5Czbvh1WT9wWCxQVbz2jQyJ/yLlshupe8hh/M23gBgZNIfoKl
         63hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pr9yEX6+41tcOKzs8ka4T7m79nyh27Sasjlj0AbUWcU=;
        b=uQa32FXMkgSdROk16hfecCz76jx9UFS7tPi/RSEnaXZ5PjpU3asGnRLHulL5GJBnI2
         fxPVhqNk+3T/S0FwE8GMKBp5HxSk3sF6w7c98vEyIaZQBSgKvznYbJQCxXvGMI/URNz8
         XEGt9WnNBwpGzzDk7/fk+IKEEVsU/8An+klUAA0ZZ/wd5dEkTotLZuGTdjogd2VFeXlM
         fbStRoy2zrW3jI8SPi/33+A1SVx0EkMu5h0l6iD4LWPLi/cZt1Y497H0pV0kOKKC/qM1
         WvAc5ejY9ZFCovYwBPhwwPjEFVtdDbBJJ6kvlwp+NTWaGB+MOecTIzaVzsxY96LoL3Qn
         oXRg==
X-Gm-Message-State: AOAM532SWiZrAY+Xwe17PYnMxA7lWMoi5tBQ0Q83Syu3Mylyk9wxAf8F
        6uOS3Abnq19CXbDZgowygQbgBOhduFKJqw57tmg2dw==
X-Google-Smtp-Source: ABdhPJwML90OM8vuySeHDsDbKeT+hk7UJshxD68ogGwpF3UoFm0cXQWomUTCs4pViTlpz7nWLDTagMpQ3oc/w5EFDKY=
X-Received: by 2002:a05:6512:39c9:: with SMTP id k9mr8528926lfu.432.1612201065357;
 Mon, 01 Feb 2021 09:37:45 -0800 (PST)
MIME-Version: 1.0
References: <20201215115448.25633-1-sjpark@amazon.com> <20201215115448.25633-4-sjpark@amazon.com>
In-Reply-To: <20201215115448.25633-4-sjpark@amazon.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 1 Feb 2021 09:37:33 -0800
Message-ID: <CALvZod4xsjCjokKeEfoBQt0A2sbs2z58ChArDsaMeAjfu10+Qg@mail.gmail.com>
Subject: Re: [PATCH v23 03/15] mm/damon: Adaptively adjust regions
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

On Tue, Dec 15, 2020 at 3:57 AM SeongJae Park <sjpark@amazon.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> Even somehow the initial monitoring target regions are well constructed
> to fulfill the assumption (pages in same region have similar access
> frequencies), the data access pattern can be dynamically changed.  This
> will result in low monitoring quality.  To keep the assumption as much
> as possible, DAMON adaptively merges and splits each region based on
> their access frequency.
>
> For each ``aggregation interval``, it compares the access frequencies of
> adjacent regions and merges those if the frequency difference is small.
> Then, after it reports and clears the aggregated access frequency of
> each region, it splits each region into two or three regions if the
> total number of regions will not exceed the user-specified maximum
> number of regions after the split.

Should there be any concerns regarding the number of regions
oscillating even when the access pattern of the application is not
changing? Does the system converge to equilibrium state or does it not
matter?

>
> In this way, DAMON provides its best-effort quality and minimal overhead
> while keeping the upper-bound overhead that users set.
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> ---
>  include/linux/damon.h |  41 +++++---
>  mm/damon/core.c       | 220 ++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 240 insertions(+), 21 deletions(-)
>
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 7d4685adc8a9..f446f8433599 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -12,6 +12,9 @@
>  #include <linux/time64.h>
>  #include <linux/types.h>
>
> +/* Minimal region size.  Every damon_region is aligned by this. */
> +#define DAMON_MIN_REGION       PAGE_SIZE
> +
>  /**
>   * struct damon_addr_range - Represents an address region of [@start, @end).
>   * @start:     Start address of the region (inclusive).
> @@ -86,6 +89,8 @@ struct damon_ctx;
>   * prepared for the next access check.
>   * @check_accesses should check the accesses to each region that made after the
>   * last preparation and update the number of observed accesses of each region.
> + * It should also return max number of observed accesses that made as a result
> + * of its update.

Why?

>   * @reset_aggregated should reset the access monitoring results that aggregated
>   * by @check_accesses.
>   * @target_valid should check whether the target is still valid for the
> @@ -98,7 +103,7 @@ struct damon_primitive {
>         void (*init_target_regions)(struct damon_ctx *context);
>         void (*update_target_regions)(struct damon_ctx *context);
>         void (*prepare_access_checks)(struct damon_ctx *context);
> -       void (*check_accesses)(struct damon_ctx *context);
> +       unsigned int (*check_accesses)(struct damon_ctx *context);
>         void (*reset_aggregated)(struct damon_ctx *context);
>         bool (*target_valid)(void *target);
>         void (*cleanup)(struct damon_ctx *context);
> @@ -138,11 +143,11 @@ struct damon_callback {
>  /**
>   * enum damon_target_type - Represents the type of the monitoring target.
>   *
> - * @DAMON_REGION_SAMPLING_TARGET:      Region based sampling target.
> - * @DAMON_ARBITRARY_TARGET:            User-defined arbitrary type target.
> + * @DAMON_ADAPTIVE_TARGET:     Adaptive regions adjustment applied target.
> + * @DAMON_ARBITRARY_TARGET:    User-defined arbitrary type target.
>   */
>  enum damon_target_type {
> -       DAMON_REGION_SAMPLING_TARGET,
> +       DAMON_ADAPTIVE_TARGET,
>         DAMON_ARBITRARY_TARGET,
>  };
>
> @@ -187,13 +192,15 @@ enum damon_target_type {
>   *
>   * @target_type:       Type of the monitoring target.
>   *
> - * @region_targets:    Head of monitoring targets (&damon_target) list.
> + * @min_nr_regions:    The minimum number of adaptive monitoring regions.
> + * @max_nr_regions:    The maximum number of adaptive monitoring regions.
> + * @adaptive_targets:  Head of monitoring targets (&damon_target) list.
>   *
>   * @arbitrary_target:  Pointer to arbitrary type target.
>   *
> - * @region_targets are valid only if @target_type is
> - * DAMON_REGION_SAMPLING_TARGET.  @arbitrary_target is valid only if
> - * @target_type is DAMON_ARBITRARY_TARGET.
> + * @min_nr_regions, @max_nr_regions and @adaptive_targets are valid only if
> + * @target_type is &DAMON_ADAPTIVE_TARGET.  @arbitrary_target is valid only if
> + * @target_type is &DAMON_ARBITRARY_TARGET.
>   */
>  struct damon_ctx {
>         unsigned long sample_interval;
> @@ -214,11 +221,13 @@ struct damon_ctx {
>
>         enum damon_target_type target_type;
>         union {
> -               /* DAMON_REGION_SAMPLING_TARGET */
> -               struct list_head region_targets;
> +               struct {                /* DAMON_ADAPTIVE_TARGET */
> +                       unsigned long min_nr_regions;
> +                       unsigned long max_nr_regions;
> +                       struct list_head adaptive_targets;
> +               };
>
> -               /* DAMON_ARBITRARY_TARGET */
> -               void *arbitrary_target;
> +               void *arbitrary_target; /* DAMON_ARBITRARY_TARGET */
>         };
>  };
>
> @@ -235,10 +244,10 @@ struct damon_ctx {
>         list_for_each_entry_safe(r, next, &t->regions_list, list)
>
>  #define damon_for_each_target(t, ctx) \
> -       list_for_each_entry(t, &(ctx)->region_targets, list)
> +       list_for_each_entry(t, &(ctx)->adaptive_targets, list)
>
>  #define damon_for_each_target_safe(t, next, ctx)       \
> -       list_for_each_entry_safe(t, next, &(ctx)->region_targets, list)
> +       list_for_each_entry_safe(t, next, &(ctx)->adaptive_targets, list)
>
>  #ifdef CONFIG_DAMON
>
> @@ -252,11 +261,13 @@ struct damon_target *damon_new_target(unsigned long id);
>  void damon_add_target(struct damon_ctx *ctx, struct damon_target *t);
>  void damon_free_target(struct damon_target *t);
>  void damon_destroy_target(struct damon_target *t);
> +unsigned int damon_nr_regions(struct damon_target *t);
>
>  struct damon_ctx *damon_new_ctx(enum damon_target_type type);
>  void damon_destroy_ctx(struct damon_ctx *ctx);
>  int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
> -               unsigned long aggr_int, unsigned long regions_update_int);
> +               unsigned long aggr_int, unsigned long regions_update_int,
> +               unsigned long min_nr_reg, unsigned long max_nr_reg);
>
>  int damon_start(struct damon_ctx **ctxs, int nr_ctxs);
>  int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 167487e75737..0f9beb60d9dd 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -10,8 +10,12 @@
>  #include <linux/damon.h>
>  #include <linux/delay.h>
>  #include <linux/kthread.h>
> +#include <linux/random.h>
>  #include <linux/slab.h>
>
> +/* Get a random number in [l, r) */
> +#define damon_rand(l, r) (l + prandom_u32_max(r - l))
> +
>  static DEFINE_MUTEX(damon_lock);
>  static int nr_running_ctxs;
>
> @@ -87,7 +91,7 @@ struct damon_target *damon_new_target(unsigned long id)
>
>  void damon_add_target(struct damon_ctx *ctx, struct damon_target *t)
>  {
> -       list_add_tail(&t->list, &ctx->region_targets);
> +       list_add_tail(&t->list, &ctx->adaptive_targets);
>  }
>
>  static void damon_del_target(struct damon_target *t)
> @@ -110,6 +114,17 @@ void damon_destroy_target(struct damon_target *t)
>         damon_free_target(t);
>  }
>
> +unsigned int damon_nr_regions(struct damon_target *t)
> +{
> +       struct damon_region *r;
> +       unsigned int nr_regions = 0;
> +
> +       damon_for_each_region(r, t)
> +               nr_regions++;

Why not just add the region_count filed in damon_target?

> +
> +       return nr_regions;
> +}
> +
>  struct damon_ctx *damon_new_ctx(enum damon_target_type type)
>  {
>         struct damon_ctx *ctx;
> @@ -128,8 +143,12 @@ struct damon_ctx *damon_new_ctx(enum damon_target_type type)
>         mutex_init(&ctx->kdamond_lock);
>
>         ctx->target_type = type;
> -       if (type != DAMON_ARBITRARY_TARGET)
> -               INIT_LIST_HEAD(&ctx->region_targets);
> +       if (type != DAMON_ARBITRARY_TARGET) {
> +               ctx->min_nr_regions = 10;
> +               ctx->max_nr_regions = 1000;

IMO these settings/heuristics should be part of the virtual address
space monitor primitives and not be in the core monitor.

> +
> +               INIT_LIST_HEAD(&ctx->adaptive_targets);
> +       }
>
>         return ctx;
>  }
> @@ -150,6 +169,8 @@ void damon_destroy_ctx(struct damon_ctx *ctx)
>   * @sample_int:                time interval between samplings
>   * @aggr_int:          time interval between aggregations
>   * @regions_update_int:        time interval between target regions update
> + * @min_nr_reg:                minimal number of regions
> + * @max_nr_reg:                maximum number of regions
>   *
>   * This function should not be called while the kdamond is running.
>   * Every time interval is in micro-seconds.
> @@ -157,15 +178,51 @@ void damon_destroy_ctx(struct damon_ctx *ctx)
>   * Return: 0 on success, negative error code otherwise.
>   */
>  int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
> -                   unsigned long aggr_int, unsigned long regions_update_int)
> +                   unsigned long aggr_int, unsigned long regions_update_int,
> +                   unsigned long min_nr_reg, unsigned long max_nr_reg)
>  {
> +       if (min_nr_reg < 3) {
> +               pr_err("min_nr_regions (%lu) must be at least 3\n",
> +                               min_nr_reg);
> +               return -EINVAL;
> +       }
> +       if (min_nr_reg > max_nr_reg) {
> +               pr_err("invalid nr_regions.  min (%lu) > max (%lu)\n",
> +                               min_nr_reg, max_nr_reg);
> +               return -EINVAL;
> +       }
> +
>         ctx->sample_interval = sample_int;
>         ctx->aggr_interval = aggr_int;
>         ctx->regions_update_interval = regions_update_int;
> +       if (ctx->target_type != DAMON_ARBITRARY_TARGET) {
> +               ctx->min_nr_regions = min_nr_reg;
> +               ctx->max_nr_regions = max_nr_reg;
> +       }
>
>         return 0;
>  }
>
> +/* Returns the size upper limit for each monitoring region */
> +static unsigned long damon_region_sz_limit(struct damon_ctx *ctx)
> +{
> +       struct damon_target *t;
> +       struct damon_region *r;
> +       unsigned long sz = 0;
> +
> +       damon_for_each_target(t, ctx) {
> +               damon_for_each_region(r, t)
> +                       sz += r->ar.end - r->ar.start;
> +       }
> +
> +       if (ctx->min_nr_regions)
> +               sz /= ctx->min_nr_regions;
> +       if (sz < DAMON_MIN_REGION)
> +               sz = DAMON_MIN_REGION;
> +
> +       return sz;
> +}
> +
>  static bool damon_kdamond_running(struct damon_ctx *ctx)
>  {
>         bool running;
> @@ -332,6 +389,146 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
>         }
>  }
>
> +#define sz_damon_region(r) (r->ar.end - r->ar.start)
> +
> +/*
> + * Merge two adjacent regions into one region
> + */
> +static void damon_merge_two_regions(struct damon_region *l,
> +                               struct damon_region *r)
> +{
> +       unsigned long sz_l = sz_damon_region(l), sz_r = sz_damon_region(r);
> +
> +       l->nr_accesses = (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
> +                       (sz_l + sz_r);
> +       l->ar.end = r->ar.end;
> +       damon_destroy_region(r);
> +}
> +
> +#define diff_of(a, b) (a > b ? a - b : b - a)
> +
> +/*
> + * Merge adjacent regions having similar access frequencies
> + *
> + * t           target affected by this merge operation
> + * thres       '->nr_accesses' diff threshold for the merge
> + * sz_limit    size upper limit of each region
> + */
> +static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
> +                                  unsigned long sz_limit)
> +{
> +       struct damon_region *r, *prev = NULL, *next;
> +
> +       damon_for_each_region_safe(r, next, t) {
> +               if (prev && prev->ar.end == r->ar.start &&
> +                   diff_of(prev->nr_accesses, r->nr_accesses) <= thres &&
> +                   sz_damon_region(prev) + sz_damon_region(r) <= sz_limit)
> +                       damon_merge_two_regions(prev, r);
> +               else
> +                       prev = r;
> +       }
> +}
> +
> +/*
> + * Merge adjacent regions having similar access frequencies
> + *
> + * threshold   '->nr_accesses' diff threshold for the merge
> + * sz_limit    size upper limit of each region
> + *
> + * This function merges monitoring target regions which are adjacent and their
> + * access frequencies are similar.  This is for minimizing the monitoring
> + * overhead under the dynamically changeable access pattern.  If a merge was
> + * unnecessarily made, later 'kdamond_split_regions()' will revert it.
> + */
> +static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
> +                                 unsigned long sz_limit)
> +{
> +       struct damon_target *t;
> +
> +       damon_for_each_target(t, c)
> +               damon_merge_regions_of(t, threshold, sz_limit);
> +}
> +
> +/*
> + * Split a region in two
> + *
> + * r           the region to be split
> + * sz_r                size of the first sub-region that will be made
> + */
> +static void damon_split_region_at(struct damon_ctx *ctx,
> +                                 struct damon_region *r, unsigned long sz_r)
> +{
> +       struct damon_region *new;
> +
> +       new = damon_new_region(r->ar.start + sz_r, r->ar.end);
> +       r->ar.end = new->ar.start;
> +
> +       damon_insert_region(new, r, damon_next_region(r));
> +}
> +
> +/* Split every region in the given target into 'nr_subs' regions */
> +static void damon_split_regions_of(struct damon_ctx *ctx,
> +                                    struct damon_target *t, int nr_subs)
> +{
> +       struct damon_region *r, *next;
> +       unsigned long sz_region, sz_sub = 0;
> +       int i;
> +
> +       damon_for_each_region_safe(r, next, t) {
> +               sz_region = r->ar.end - r->ar.start;
> +
> +               for (i = 0; i < nr_subs - 1 &&
> +                               sz_region > 2 * DAMON_MIN_REGION; i++) {
> +                       /*
> +                        * Randomly select size of left sub-region to be at
> +                        * least 10 percent and at most 90% of original region
> +                        */
> +                       sz_sub = ALIGN_DOWN(damon_rand(1, 10) *
> +                                       sz_region / 10, DAMON_MIN_REGION);
> +                       /* Do not allow blank region */
> +                       if (sz_sub == 0 || sz_sub >= sz_region)
> +                               continue;
> +
> +                       damon_split_region_at(ctx, r, sz_sub);
> +                       sz_region = sz_sub;
> +               }
> +       }
> +}
> +
> +/*
> + * Split every target region into randomly-sized small regions
> + *
> + * This function splits every target region into random-sized small regions if
> + * current total number of the regions is equal or smaller than half of the
> + * user-specified maximum number of regions.  This is for maximizing the
> + * monitoring accuracy under the dynamically changeable access patterns.  If a
> + * split was unnecessarily made, later 'kdamond_merge_regions()' will revert
> + * it.
> + */
> +static void kdamond_split_regions(struct damon_ctx *ctx)
> +{
> +       struct damon_target *t;
> +       unsigned int nr_regions = 0;
> +       static unsigned int last_nr_regions;
> +       int nr_subregions = 2;
> +
> +       damon_for_each_target(t, ctx)
> +               nr_regions += damon_nr_regions(t);
> +
> +       if (nr_regions > ctx->max_nr_regions / 2)
> +               return;

Shouldn't the limits on region be per-target instead of for the whole context?

> +
> +       /* Maybe the middle of the region has different access frequency */
> +       if (last_nr_regions == nr_regions &&
> +                       nr_regions < ctx->max_nr_regions / 3)
> +               nr_subregions = 3;
> +
> +       damon_for_each_target(t, ctx)
> +               damon_split_regions_of(ctx, t, nr_subregions);
> +
> +       last_nr_regions = nr_regions;
> +}
> +
>  /*
>   * Check whether it is time to check and apply the target monitoring regions
>   *
> @@ -391,6 +588,8 @@ static int kdamond_fn(void *data)
>         struct damon_ctx *ctx = (struct damon_ctx *)data;
>         struct damon_target *t;
>         struct damon_region *r, *next;
> +       unsigned int max_nr_accesses = 0;
> +       unsigned long sz_limit = 0;
>
>         pr_info("kdamond (%d) starts\n", ctx->kdamond->pid);
>
> @@ -399,6 +598,8 @@ static int kdamond_fn(void *data)
>         if (ctx->callback.before_start && ctx->callback.before_start(ctx))
>                 set_kdamond_stop(ctx);
>
> +       sz_limit = damon_region_sz_limit(ctx);
> +
>         while (!kdamond_need_stop(ctx)) {
>                 if (ctx->primitive.prepare_access_checks)
>                         ctx->primitive.prepare_access_checks(ctx);
> @@ -409,14 +610,20 @@ static int kdamond_fn(void *data)
>                 usleep_range(ctx->sample_interval, ctx->sample_interval + 1);
>
>                 if (ctx->primitive.check_accesses)
> -                       ctx->primitive.check_accesses(ctx);
> +                       max_nr_accesses = ctx->primitive.check_accesses(ctx);
>
>                 if (kdamond_aggregate_interval_passed(ctx)) {
> +                       if (ctx->target_type != DAMON_ARBITRARY_TARGET)
> +                               kdamond_merge_regions(ctx,
> +                                               max_nr_accesses / 10,

What's the reason behind this 10?


> +                                               sz_limit);
>                         if (ctx->callback.after_aggregation &&
>                                         ctx->callback.after_aggregation(ctx))
>                                 set_kdamond_stop(ctx);
> -                       if (ctx->target_type != DAMON_ARBITRARY_TARGET)
> +                       if (ctx->target_type != DAMON_ARBITRARY_TARGET) {
>                                 kdamond_reset_aggregated(ctx);
> +                               kdamond_split_regions(ctx);
> +                       }
>                         if (ctx->primitive.reset_aggregated)
>                                 ctx->primitive.reset_aggregated(ctx);
>                 }
> @@ -424,6 +631,7 @@ static int kdamond_fn(void *data)
>                 if (kdamond_need_update_regions(ctx)) {
>                         if (ctx->primitive.update_target_regions)
>                                 ctx->primitive.update_target_regions(ctx);
> +                       sz_limit = damon_region_sz_limit(ctx);
>                 }
>         }
>         if (ctx->target_type != DAMON_ARBITRARY_TARGET) {
> --
> 2.17.1
>
