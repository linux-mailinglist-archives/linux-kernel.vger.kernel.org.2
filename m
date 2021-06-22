Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D7C3B0821
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbhFVPDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbhFVPDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:03:30 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5F7C061756
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:01:13 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id h15so17911123lfv.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nEwImwWldIXngX1pjIBqU4Tl3WOeTYgLOlCTBwi3IqU=;
        b=HEjhMAeBs+MAQd6E8TnhVsY/O/PyOJNcnZQNULFRSP10GdFphviscm3qggUNbwVs19
         AdqG1EcVBetP3T3XP9YstMycx8fXQq9lw95ZzE9VLsd7lhSFDmgOakSdxIli1OxxOG1r
         yGiEKRZSNou+ZMsNFHIMBxKPepa+Lav4FIp4YiM4ixRk6Gzaovv9VcNVv+JswEzfgsOh
         X0J4ePA3JBiOjKVx1RR6RrYO1ttO8dFauwd0hBGiSmrX9GHAut76VBEcu3XOrHM41gU5
         y47YT49wcNl++sadOpTOx853ZdYLE4PD3zj7gnxlb/Kr+epCPrDmuID42T/b/WpQ9A8P
         k3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nEwImwWldIXngX1pjIBqU4Tl3WOeTYgLOlCTBwi3IqU=;
        b=rLvNh1RLubEXss2HF42IVJHErhk5ozMDFNgHm6VKg6Evh8ipENYDPT++eLTKt6vFix
         Rng3yTgVoKvnvSKKUGwh0vPZPtsbSiKsVHl17JN713a1DlzTg+2IaBj8z8ScXi/+DpLN
         V3tKFna/9Uk/pvT2ZSudbz8fz7/6IwyYIq24TAgXT01bY/ixIHSpuRgoMlp24AN7KeOX
         y8NMEh/fZqbHfp8i9St3NV7fJ5unYR4A3xqNZuEWFakVLe5x2sXu8xTQzJnup9iKVUpE
         dpyQkB7H3xhrf9hUoaPOjUNAV6SU9UA0N8m3Wg0PpIw4w4LLQKzZAYPSESlPc90yeBT5
         P3gQ==
X-Gm-Message-State: AOAM533ZANaqC6/X3WPXeLo8OdixXeGXKTbbX1XSbYIwO/AbvbU+V7XZ
        MDMRaSOHV+u/y08Orf/Vx/d6DL4xaMV4zTsW/VZ+Dg==
X-Google-Smtp-Source: ABdhPJwvEy1psDZZzLwZVlbjlTvaa3k658Rbf62iXeTvlrgssVJa1T+BjkPSqdQiaqPGTD1ArWx1aVAPT1Ga9+wY3Qc=
X-Received: by 2002:a05:6512:531:: with SMTP id o17mr3138034lfc.358.1624374069788;
 Tue, 22 Jun 2021 08:01:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210621083108.17589-1-sj38.park@gmail.com> <20210621083108.17589-6-sj38.park@gmail.com>
In-Reply-To: <20210621083108.17589-6-sj38.park@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 22 Jun 2021 08:00:58 -0700
Message-ID: <CALvZod4C9KJPnzOUYhnrkvW_fq+WAKODH5czCLMxLvwpRm2Bxg@mail.gmail.com>
Subject: Re: [PATCH v31 05/13] mm/damon: Implement primitives for the virtual
 memory address spaces
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>, dwmw@amazon.com,
        Marco Elver <elver@google.com>, "Du, Fan" <fan.du@intel.com>,
        foersleo@amazon.de, greg@kroah.com,
        Greg Thelen <gthelen@google.com>, guoju.fgj@alibaba-inc.com,
        jgowans@amazon.com, Mel Gorman <mgorman@suse.de>, mheyne@amazon.de,
        Minchan Kim <minchan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, namhyung@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@kernel.org>, Shuah Khan <shuah@kernel.org>,
        sieberf@amazon.com, snu@zelle79.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        zgf574564920@gmail.com, linux-damon@amazon.com,
        Linux MM <linux-mm@kvack.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 1:31 AM SeongJae Park <sj38.park@gmail.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> This commit introduces a reference implementation of the address space
> specific low level primitives for the virtual address space, so that
> users of DAMON can easily monitor the data accesses on virtual address
> spaces of specific processes by simply configuring the implementation to
> be used by DAMON.
>
> The low level primitives for the fundamental access monitoring are
> defined in two parts:
>
> 1. Identification of the monitoring target address range for the address
>    space.
> 2. Access check of specific address range in the target space.
>
> The reference implementation for the virtual address space does the
> works as below.
>
> PTE Accessed-bit Based Access Check
> -----------------------------------
>
> The implementation uses PTE Accessed-bit for basic access checks.  That
> is, it clears the bit for the next sampling target page and checks
> whether it is set again after one sampling period.  This could disturb
> the reclaim logic.  DAMON uses ``PG_idle`` and ``PG_young`` page flags
> to solve the conflict, as Idle page tracking does.
>
> VMA-based Target Address Range Construction
> -------------------------------------------
>
> Only small parts in the super-huge virtual address space of the
> processes are mapped to physical memory and accessed.  Thus, tracking
> the unmapped address regions is just wasteful.  However, because DAMON
> can deal with some level of noise using the adaptive regions adjustment
> mechanism, tracking every mapping is not strictly required but could
> even incur a high overhead in some cases.  That said, too huge unmapped
> areas inside the monitoring target should be removed to not take the
> time for the adaptive mechanism.
>
> For the reason, this implementation converts the complex mappings to
> three distinct regions that cover every mapped area of the address
> space.  Also, the two gaps between the three regions are the two biggest
> unmapped areas in the given address space.  The two biggest unmapped
> areas would be the gap between the heap and the uppermost mmap()-ed
> region, and the gap between the lowermost mmap()-ed region and the stack
> in most of the cases.  Because these gaps are exceptionally huge in
> usual address spaces, excluding these will be sufficient to make a
> reasonable trade-off.  Below shows this in detail::
>
>     <heap>
>     <BIG UNMAPPED REGION 1>
>     <uppermost mmap()-ed region>
>     (small mmap()-ed regions and munmap()-ed regions)
>     <lowermost mmap()-ed region>
>     <BIG UNMAPPED REGION 2>
>     <stack>
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> Reviewed-by: Fernand Sieber <sieberf@amazon.com>

Couple of nits below and one concern on the default value of
primitive_update_interval of virtual address space primitive.
Otherwise looks good to me.

[...]

> +
> +/*
> + * Size-evenly split a region into 'nr_pieces' small regions
> + *
> + * Returns 0 on success, or negative error code otherwise.
> + */
> +static int damon_va_evenly_split_region(struct damon_ctx *ctx,

I don't see ctx being used in this function.

> +               struct damon_region *r, unsigned int nr_pieces)
> +{
> +       unsigned long sz_orig, sz_piece, orig_end;
> +       struct damon_region *n = NULL, *next;
> +       unsigned long start;
> +
> +       if (!r || !nr_pieces)
> +               return -EINVAL;
> +
> +       orig_end = r->ar.end;
> +       sz_orig = r->ar.end - r->ar.start;
> +       sz_piece = ALIGN_DOWN(sz_orig / nr_pieces, DAMON_MIN_REGION);
> +
> +       if (!sz_piece)
> +               return -EINVAL;
> +
> +       r->ar.end = r->ar.start + sz_piece;
> +       next = damon_next_region(r);
> +       for (start = r->ar.end; start + sz_piece <= orig_end;
> +                       start += sz_piece) {
> +               n = damon_new_region(start, start + sz_piece);
> +               if (!n)
> +                       return -ENOMEM;
> +               damon_insert_region(n, r, next);
> +               r = n;
> +       }
> +       /* complement last region for possible rounding error */
> +       if (n)
> +               n->ar.end = orig_end;
> +
> +       return 0;
> +}

[...]

> +/*
> + * Get the three regions in the given target (task)
> + *
> + * Returns 0 on success, negative error code otherwise.
> + */
> +static int damon_va_three_regions(struct damon_target *t,
> +                               struct damon_addr_range regions[3])
> +{
> +       struct mm_struct *mm;
> +       int rc;
> +
> +       mm = damon_get_mm(t);
> +       if (!mm)
> +               return -EINVAL;
> +
> +       mmap_read_lock(mm);
> +       rc = __damon_va_three_regions(mm->mmap, regions);
> +       mmap_read_unlock(mm);

This is being called for each target every second by default. Seems
too aggressive. Applications don't change their address space every
second. I would recommend to default ctx->primitive_update_interval to
a higher default value.

> +
> +       mmput(mm);
> +       return rc;
> +}
> +

[...]

> +static void __damon_va_init_regions(struct damon_ctx *c,

Keep the convention of naming damon_ctx ctx.

> +                                    struct damon_target *t)
> +{
> +       struct damon_region *r;
> +       struct damon_addr_range regions[3];
> +       unsigned long sz = 0, nr_pieces;
> +       int i;
> +
> +       if (damon_va_three_regions(t, regions)) {
> +               pr_err("Failed to get three regions of target %lu\n", t->id);
> +               return;
> +       }
> +
> +       for (i = 0; i < 3; i++)
> +               sz += regions[i].end - regions[i].start;
> +       if (c->min_nr_regions)
> +               sz /= c->min_nr_regions;
> +       if (sz < DAMON_MIN_REGION)
> +               sz = DAMON_MIN_REGION;
> +
> +       /* Set the initial three regions of the target */
> +       for (i = 0; i < 3; i++) {
> +               r = damon_new_region(regions[i].start, regions[i].end);
> +               if (!r) {
> +                       pr_err("%d'th init region creation failed\n", i);
> +                       return;
> +               }
> +               damon_add_region(r, t);
> +
> +               nr_pieces = (regions[i].end - regions[i].start) / sz;
> +               damon_va_evenly_split_region(c, r, nr_pieces);
> +       }
> +}

[...]

> +/*
> + * Update damon regions for the three big regions of the given target
> + *
> + * t           the given target
> + * bregions    the three big regions of the target
> + */
> +static void damon_va_apply_three_regions(struct damon_ctx *ctx,

ctx not used in this function.


> +               struct damon_target *t, struct damon_addr_range bregions[3])
> +{
> +       struct damon_region *r, *next;
> +       unsigned int i = 0;
> +
> +       /* Remove regions which are not in the three big regions now */
> +       damon_for_each_region_safe(r, next, t) {
> +               for (i = 0; i < 3; i++) {
> +                       if (damon_intersect(r, &bregions[i]))
> +                               break;
> +               }
> +               if (i == 3)
> +                       damon_destroy_region(r);
> +       }
> +
> +       /* Adjust intersecting regions to fit with the three big regions */
> +       for (i = 0; i < 3; i++) {
> +               struct damon_region *first = NULL, *last;
> +               struct damon_region *newr;
> +               struct damon_addr_range *br;
> +
> +               br = &bregions[i];
> +               /* Get the first and last regions which intersects with br */
> +               damon_for_each_region(r, t) {
> +                       if (damon_intersect(r, br)) {
> +                               if (!first)
> +                                       first = r;
> +                               last = r;
> +                       }
> +                       if (r->ar.start >= br->end)
> +                               break;
> +               }
> +               if (!first) {
> +                       /* no damon_region intersects with this big region */
> +                       newr = damon_new_region(
> +                                       ALIGN_DOWN(br->start,
> +                                               DAMON_MIN_REGION),
> +                                       ALIGN(br->end, DAMON_MIN_REGION));
> +                       if (!newr)
> +                               continue;
> +                       damon_insert_region(newr, damon_prev_region(r), r);
> +               } else {
> +                       first->ar.start = ALIGN_DOWN(br->start,
> +                                       DAMON_MIN_REGION);
> +                       last->ar.end = ALIGN(br->end, DAMON_MIN_REGION);
> +               }
> +       }
> +}
