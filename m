Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8841F3B2C67
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 12:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbhFXK3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 06:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbhFXK3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 06:29:03 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F34C06175F;
        Thu, 24 Jun 2021 03:26:43 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id c22so4403343qtn.1;
        Thu, 24 Jun 2021 03:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to;
        bh=q6R9vTX7vPZJVLyiIJS5kBAuP5PUjG62babXhd3tTnY=;
        b=nxzgiH2YombTTQPcBbJ0qc+zRM4VXl9coFnkynIlPiF2xg75H7AwlMGyGhuUeshJeZ
         oDiQqAuZoV/8wsitb1s1HDydEJGJjhlp6CwXcB9nfXCAsy5TvD149vYvmLLGXKM2/ocQ
         rU1icnR4Wqkd97FrCSt9agng470xY/WTdVwfMPyn1teGMfTa7iZB2L4F4t/YS+6TGs8/
         Zk3b5BnZymJxFwzZmEw1ey6MIqgiKoEHFvBeOCo8DeDP67ARZzLP6lnK5UO5+gUa6EJB
         2D2EQwLfLYyezjcgrwBPO2xRhJFe/68GlDjqtackkrvCSy9QKBebaTr6+K9oXe3/636R
         kV7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to;
        bh=q6R9vTX7vPZJVLyiIJS5kBAuP5PUjG62babXhd3tTnY=;
        b=HjkOZHkmO5YXkYR0YEjsDgt1HPhgL8UGKkmH3CQCMzW2dTZcJNnBrffYBkspcmI8KH
         JIU1k4p6YaYHZ60uHgrbZ6OGUlzoe8RBSFzmj89o7xbceSj47P8t1Sinx0/cTSivcVH4
         vrSiwuP3lnNVX+6En7Vby4/rvlbYNZyRigalIq/ioNL6tY3NheUUmGn0YCO455ZOvz5k
         +N0xmKAIgDxIzIaZIWMONP1QT3BD++5m+Y+GLPLebpkuNYmTlIQXGQKdY+ONay13NPXP
         QEafvtmFdBxAdcI7EeAo5FWFytro8CirK4UH19sAhYFlaR/XnuTXCBHhyjpcBJkjQwbX
         BHMg==
X-Gm-Message-State: AOAM533e0kbDs0U9yD8mhdi+w9G7aIjE6kRU+tS7eCTS4ylPPa3Z4VO4
        45yGfbddKJoxsd4dbKt31fE=
X-Google-Smtp-Source: ABdhPJyuMMH9zvrjHPfG/kNt6fcgimdWA4t3vITUYnSFKvCWxPuZAg+JPXIVOD4UW7AWGa3vSa7pgw==
X-Received: by 2002:ac8:6b59:: with SMTP id x25mr4240942qts.132.1624530402617;
        Thu, 24 Jun 2021 03:26:42 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id w195sm2132842qkb.127.2021.06.24.03.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 03:26:42 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     SeongJae Park <sj38.park@gmail.com>,
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
Subject: Re: [PATCH v31 05/13] mm/damon: Implement primitives for the virtual memory address spaces
Date:   Thu, 24 Jun 2021 10:26:21 +0000
Message-Id: <20210624102623.24563-3-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210624102623.24563-1-sjpark@amazon.de>
References: <20210624102623.24563-1-sjpark@amazon.de>
In-Reply-To: <CALvZod4C9KJPnzOUYhnrkvW_fq+WAKODH5czCLMxLvwpRm2Bxg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

On Tue, 22 Jun 2021 08:00:58 -0700 Shakeel Butt <shakeelb@google.com> wrote:

> On Mon, Jun 21, 2021 at 1:31 AM SeongJae Park <sj38.park@gmail.com> wrote:
> >
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > This commit introduces a reference implementation of the address space
> > specific low level primitives for the virtual address space, so that
> > users of DAMON can easily monitor the data accesses on virtual address
> > spaces of specific processes by simply configuring the implementation to
> > be used by DAMON.
> >
> > The low level primitives for the fundamental access monitoring are
> > defined in two parts:
> >
> > 1. Identification of the monitoring target address range for the address
> >    space.
> > 2. Access check of specific address range in the target space.
> >
> > The reference implementation for the virtual address space does the
> > works as below.
> >
> > PTE Accessed-bit Based Access Check
> > -----------------------------------
> >
> > The implementation uses PTE Accessed-bit for basic access checks.  That
> > is, it clears the bit for the next sampling target page and checks
> > whether it is set again after one sampling period.  This could disturb
> > the reclaim logic.  DAMON uses ``PG_idle`` and ``PG_young`` page flags
> > to solve the conflict, as Idle page tracking does.
> >
> > VMA-based Target Address Range Construction
> > -------------------------------------------
> >
> > Only small parts in the super-huge virtual address space of the
> > processes are mapped to physical memory and accessed.  Thus, tracking
> > the unmapped address regions is just wasteful.  However, because DAMON
> > can deal with some level of noise using the adaptive regions adjustment
> > mechanism, tracking every mapping is not strictly required but could
> > even incur a high overhead in some cases.  That said, too huge unmapped
> > areas inside the monitoring target should be removed to not take the
> > time for the adaptive mechanism.
> >
> > For the reason, this implementation converts the complex mappings to
> > three distinct regions that cover every mapped area of the address
> > space.  Also, the two gaps between the three regions are the two biggest
> > unmapped areas in the given address space.  The two biggest unmapped
> > areas would be the gap between the heap and the uppermost mmap()-ed
> > region, and the gap between the lowermost mmap()-ed region and the stack
> > in most of the cases.  Because these gaps are exceptionally huge in
> > usual address spaces, excluding these will be sufficient to make a
> > reasonable trade-off.  Below shows this in detail::
> >
> >     <heap>
> >     <BIG UNMAPPED REGION 1>
> >     <uppermost mmap()-ed region>
> >     (small mmap()-ed regions and munmap()-ed regions)
> >     <lowermost mmap()-ed region>
> >     <BIG UNMAPPED REGION 2>
> >     <stack>
> >
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> > Reviewed-by: Fernand Sieber <sieberf@amazon.com>
> 
> Couple of nits below and one concern on the default value of
> primitive_update_interval of virtual address space primitive.
> Otherwise looks good to me.

Thank you!

> 
> [...]
> 
> > +
> > +/*
> > + * Size-evenly split a region into 'nr_pieces' small regions
> > + *
> > + * Returns 0 on success, or negative error code otherwise.
> > + */
> > +static int damon_va_evenly_split_region(struct damon_ctx *ctx,
> 
> I don't see ctx being used in this function.

Good point, will remove that from the next spin.

> 
> > +               struct damon_region *r, unsigned int nr_pieces)
> > +{
> > +       unsigned long sz_orig, sz_piece, orig_end;
> > +       struct damon_region *n = NULL, *next;
> > +       unsigned long start;
> > +
> > +       if (!r || !nr_pieces)
> > +               return -EINVAL;
> > +
> > +       orig_end = r->ar.end;
> > +       sz_orig = r->ar.end - r->ar.start;
> > +       sz_piece = ALIGN_DOWN(sz_orig / nr_pieces, DAMON_MIN_REGION);
> > +
> > +       if (!sz_piece)
> > +               return -EINVAL;
> > +
> > +       r->ar.end = r->ar.start + sz_piece;
> > +       next = damon_next_region(r);
> > +       for (start = r->ar.end; start + sz_piece <= orig_end;
> > +                       start += sz_piece) {
> > +               n = damon_new_region(start, start + sz_piece);
> > +               if (!n)
> > +                       return -ENOMEM;
> > +               damon_insert_region(n, r, next);
> > +               r = n;
> > +       }
> > +       /* complement last region for possible rounding error */
> > +       if (n)
> > +               n->ar.end = orig_end;
> > +
> > +       return 0;
> > +}
> 
> [...]
> 
> > +/*
> > + * Get the three regions in the given target (task)
> > + *
> > + * Returns 0 on success, negative error code otherwise.
> > + */
> > +static int damon_va_three_regions(struct damon_target *t,
> > +                               struct damon_addr_range regions[3])
> > +{
> > +       struct mm_struct *mm;
> > +       int rc;
> > +
> > +       mm = damon_get_mm(t);
> > +       if (!mm)
> > +               return -EINVAL;
> > +
> > +       mmap_read_lock(mm);
> > +       rc = __damon_va_three_regions(mm->mmap, regions);
> > +       mmap_read_unlock(mm);
> 
> This is being called for each target every second by default. Seems
> too aggressive. Applications don't change their address space every
> second. I would recommend to default ctx->primitive_update_interval to
> a higher default value.

Good point.  If there are many targets and each target has a huge number of
VMAs, the overhead could be high.  Nevertheless, I couldn't find the overhead
in my test setup.  Also, it seems someone are already started exploring DAMON
patchset with the default value. and usages from others.  Silently changing the
default value could distract such people.  So, if you think it's ok, I'd like
to change the default value only after someone finds the overhead from their
usages and asks a change.

If you disagree or you found the overhead from your usage, please feel free to
let me know.

> 
> > +
> > +       mmput(mm);
> > +       return rc;
> > +}
> > +
> 
> [...]
> 
> > +static void __damon_va_init_regions(struct damon_ctx *c,
> 
> Keep the convention of naming damon_ctx ctx.

Ok, I will do so from the next spin.

> 
> > +                                    struct damon_target *t)
> > +{
> > +       struct damon_region *r;
> > +       struct damon_addr_range regions[3];
> > +       unsigned long sz = 0, nr_pieces;
> > +       int i;
> > +
> > +       if (damon_va_three_regions(t, regions)) {
> > +               pr_err("Failed to get three regions of target %lu\n", t->id);
> > +               return;
> > +       }
> > +
> > +       for (i = 0; i < 3; i++)
> > +               sz += regions[i].end - regions[i].start;
> > +       if (c->min_nr_regions)
> > +               sz /= c->min_nr_regions;
> > +       if (sz < DAMON_MIN_REGION)
> > +               sz = DAMON_MIN_REGION;
> > +
> > +       /* Set the initial three regions of the target */
> > +       for (i = 0; i < 3; i++) {
> > +               r = damon_new_region(regions[i].start, regions[i].end);
> > +               if (!r) {
> > +                       pr_err("%d'th init region creation failed\n", i);
> > +                       return;
> > +               }
> > +               damon_add_region(r, t);
> > +
> > +               nr_pieces = (regions[i].end - regions[i].start) / sz;
> > +               damon_va_evenly_split_region(c, r, nr_pieces);
> > +       }
> > +}
> 
> [...]
> 
> > +/*
> > + * Update damon regions for the three big regions of the given target
> > + *
> > + * t           the given target
> > + * bregions    the three big regions of the target
> > + */
> > +static void damon_va_apply_three_regions(struct damon_ctx *ctx,
> 
> ctx not used in this function.

Good eye, will remove that from the next version.

> 
> 
> > +               struct damon_target *t, struct damon_addr_range bregions[3])
> > +{
> > +       struct damon_region *r, *next;
> > +       unsigned int i = 0;
> > +
> > +       /* Remove regions which are not in the three big regions now */
> > +       damon_for_each_region_safe(r, next, t) {
> > +               for (i = 0; i < 3; i++) {
> > +                       if (damon_intersect(r, &bregions[i]))
> > +                               break;
> > +               }
> > +               if (i == 3)
> > +                       damon_destroy_region(r);
> > +       }
> > +
> > +       /* Adjust intersecting regions to fit with the three big regions */
> > +       for (i = 0; i < 3; i++) {
> > +               struct damon_region *first = NULL, *last;
> > +               struct damon_region *newr;
> > +               struct damon_addr_range *br;
> > +
> > +               br = &bregions[i];
> > +               /* Get the first and last regions which intersects with br */
> > +               damon_for_each_region(r, t) {
> > +                       if (damon_intersect(r, br)) {
> > +                               if (!first)
> > +                                       first = r;
> > +                               last = r;
> > +                       }
> > +                       if (r->ar.start >= br->end)
> > +                               break;
> > +               }
> > +               if (!first) {
> > +                       /* no damon_region intersects with this big region */
> > +                       newr = damon_new_region(
> > +                                       ALIGN_DOWN(br->start,
> > +                                               DAMON_MIN_REGION),
> > +                                       ALIGN(br->end, DAMON_MIN_REGION));
> > +                       if (!newr)
> > +                               continue;
> > +                       damon_insert_region(newr, damon_prev_region(r), r);
> > +               } else {
> > +                       first->ar.start = ALIGN_DOWN(br->start,
> > +                                       DAMON_MIN_REGION);
> > +                       last->ar.end = ALIGN(br->end, DAMON_MIN_REGION);
> > +               }
> > +       }
> > +}


Thanks,
SeongJae Park
