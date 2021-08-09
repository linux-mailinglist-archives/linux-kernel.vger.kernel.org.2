Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3003E4736
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 16:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbhHIOHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 10:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbhHIOHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 10:07:43 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B21EC0613D3;
        Mon,  9 Aug 2021 07:07:23 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id e14so18453159qkg.3;
        Mon, 09 Aug 2021 07:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=OeTxvDSpYLryUUXyXT70HiwvEM0eV1Nzgw2hBrYmXLg=;
        b=i/8BpGPmODQMs9IAahyZdMsUtBQOeXdQXJXUTH9VbQ43EfvNCOQfecHhxfToSCS1ic
         Vsl0EpJ5Vt7IhPv9qjYushtogNj9wc/Hm0EYNG4sSEtZBGaA+KZSF12na5C6Uc3MwTII
         /672//RYj6+AOtDwxYbF5UpRWRyjYzj+i+/P60NdnVN+Dd3zFeTb1nYa/L8USH8DhnhJ
         FLZyK0hSu5r2gzWn48UT7hiFlQ3fNBWEi76xCEAG2K17sHDUKZBXB9G90dfWe1Oe55pe
         ljp3R/8S6zajXDFA8ttugOZ5gRQWbom0BnMvGXSvkcL/bpsqL4VamNT7VCQIDwNj2eMt
         PSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=OeTxvDSpYLryUUXyXT70HiwvEM0eV1Nzgw2hBrYmXLg=;
        b=kjkX/Aq/8eHV0+T8qs1z2Qab7nz5C5x3W9awI1BMSqGf8k/9gs3HpeQh8wr18Mhxuv
         pyBcJiM1DDu2N8AUrZ8GeT11FJsb4r6ABASFcFmtATjkBjbjDrQ0h4/xDvIb+Yrgj0HE
         /OPyYS0bjDSnT+HGJ+j3ssE5zpi9xwmQtpEDrvjhkbvGydqP/69LZFd94fPjoq7N0wxU
         8qM2NtyoamFbQ5EEigsVmUXFAJd43jHHtj6K63x2Bv4KSG2fx3kV72GT/Sy/wPKi2uzi
         wXYrIlejP2omkmyljAyIstJLaV1RljYlgEVswy3I+Qx4xX2CTgsFrpXhutJNJ8fZp8Oo
         k5gQ==
X-Gm-Message-State: AOAM530kpyVhE3+6Z+FxeiOl3GNFLwdBgK3rruXWMS3tVXChElRBPdLF
        a+1GJZq7MzFcGcYAEwLTB7Y=
X-Google-Smtp-Source: ABdhPJxHn1O9mucTtsCaovSfeiiXos/gm/IT6g4eQ18ApxT96WNp2vWc50klGz9Lk4Hwfi52uf/NuQ==
X-Received: by 2002:a37:9e11:: with SMTP id h17mr21937799qke.193.1628518042128;
        Mon, 09 Aug 2021 07:07:22 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id j2sm6747485qtn.46.2021.08.09.07.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 07:07:21 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sj38.park@gmail.com>,
        SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@huawei.com,
        amit@kernel.org, Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>, dwmw@amazon.com,
        foersleo@amazon.de, Greg Thelen <gthelen@google.com>,
        jgowans@amazon.com, mheyne@amazon.de,
        David Rientjes <rientjes@google.com>, sieberf@amazon.com,
        Vlastimil Babka <vbabka@suse.cz>, linux-damon@amazon.com,
        Linux MM <linux-mm@kvack.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, Wei Xu <weixugc@google.com>,
        Paul Turner <pjt@google.com>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v34 00/13] Introduce Data Access MONitor (DAMON)
Date:   Mon,  9 Aug 2021 14:07:14 +0000
Message-Id: <20210809140714.34394-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210806114801.6958-1-sjpark@amazon.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

On Fri,  6 Aug 2021 11:48:01 +0000 SeongJae Park <sj38.park@gmail.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> On Thu, 5 Aug 2021 17:03:44 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> 
[...]
> > 
> > I would like to see more thought/design go into how DAMON could be
> > modified to address Shakeel's other three requirements.  At least to
> > the point where we can confidently say "yes, we will be able to do
> > this".  Are you able to drive this discussion along please?
> 
> Sure.  I will describe my plan for convincing Shakeel's usages in detail as a
> reply to this mail.

Shakeel, I am explaining how DAMON will be extended and how it can be used for
your usages below.  If there is any doubt or question, please feel free to let
me know.

What information DAMON (will) provides: contiguity, frequency, and recency
--------------------------------------------------------------------------

DAMON of this patchset informs users which memory region is how frequently
accessed.  The memory region is a set of contiguous pages which having similar
access frequency.  In addition to this, a following patch[1] will make DAMON to
track how long time the region maintained its size and access frequency.  We
call this as 'age' of each region.  That is, DAMON will be extended to provide
three attributes of data access patterns: contiguity (size of each region),
frequency, and recency.

Physical Address Space support
------------------------------

This version of DAMON is supporting only virtual address spaces of processes,
but will be extended to the physical address space[2].  The extension will be
quite simple because DAMON's monitoring primitives layer is separated from its
core logic.

How DAMON can be used for Shakeel's usages
------------------------------------------

The usages described in Shakeel's prior mail[1] are:

    1) Working set estimation: This is used for cluster level scheduling
    and controlling the knobs of memory overcommit.

    2) Proactive reclaim

    3) Balancing between memory tiers: Moving hot pages to fast tiers and
    cold pages to slow tiers

    4) Hugepage optimization: Hot memory backed by hugepages

    In addition, these uses are not happening in isolation. We want a
    combination of these running concurrently on a system. So, it is clear
    that the first version or step of DAMON which only targets virtual
    address space monitoring is not sufficient for these use-cases.

DAMON can satisfy all the usages as below.

- working set estimation: This can be done by iterating each region and
  checking if the access frequency of it is higher than a threshold.  Our user
  space tool provides an implementation[3] for this.  Below is a pseudo-code
  for this:

    workingsets = []
    working_set_size = 0
    for region in regions:
        if region.access_frequncy > threshold:
            workingsets.append(region)
            working_set_size += region.end_address - region.start_address
    return workingsets, working_set_size

- proactive reclaim: This can be done by iterating each region while checking
  if it has zero access frequency and if its age is higher than a time
  threshold, and reclaim those.  We implemented this as a kernel module with
  only 354 lines of code[4].  Below is a pseudo-code for this:

    for region in regions:
        if region.access_frquency == 0 and region.age > threshold:
            reclaim(region)

- Balancing between memory tiers: Because DAMON provides access frequency, we
  can know not only idle memory region but cold/cool/warm/hot memory region.
  Once the functions for migrating pages from a tier to different tier is
  matured, applying DAMON for this usage will be quite straightforward.  That
  is, for each region, if its access frequency and age is higher than
  thresholds, migrate pages in the region to faster tier.  If its access
  frequency is lower than a threshold and its age is higher than a threshold,
  migrate pages in the region to slower tier.  Below is a pseudo-code for this:

    for region in regions:
        if region.age > age_threshod:
            if region.access_frequency > hot_threshold:
                migrate_to_fast_tier(region)
            if region.access_frequency < cold_threshold:
                migrate_to_slow_tier(region)

- Hugepage optimization: This will be quite similar to tiers balancing, but we
  can use the size of regions.  That is, we do monitoring of virtual address
  spaces first.  Then, for each region, if its access frequency, age, and size
  are higher than thresholds (size threshold would be 2MB), makes the region to
  be backed by huge pages.  If the age and size are higher than thresholds but
  the access frequency is lower than a threshold, makes the huge pages of the
  region to be backed by regular pages.  We evaluated this idea with a
  prototype[5].  It removed 76.15% of THP memory overheads while preserving
  51.25% of THP speedup.  Below is a pseudo-code for this:

    for region in regions:
        if region.age > age_threshod and region.size >= 2 * MB:
            if region.access_frequency > hot_threshold:
                use_thps_for(region)
            if region.access_frequency < cold_threshold:
                use_regular_pages_for(region)

- Combination of these running concurrently: DAMON will be extended to be able
  to monitor both the physical address space and virtual address spaces
  simultaneously, like below.

    struct damon_ctx *ctx_for_virt = damon_new_ctx();
    struct damon_ctx *ctx_for_phys = damon_new_ctx();
    struct damon_context *ctxs[] = {ctx_for_virt, ctx_for_phys};
    [...]
    /* first context for physical address space monitoring */
    damon_pa_set_primitives(ctx_for_virt);
    /* second context for virtual address spaces monitoring */
    damon_va_set_primitives(ctx_for_phys);
    damon_start(ctxs, 2);

Extending for page-granularity monitoring
-----------------------------------------

To my understanding, Shakeel wants to do above with page-granularity
monitoring.  It will incur inevitable high overhead, but for someone who can
afford the cost, I will make DAMON to support it, as below.

Even with DAMON of this patchset, users can do the page-granularity monitoring
by simply setting the 'min_nr_regions' and 'max_nr_regions' of DAMON to the
number of pages in the target address space (nr_pages).  Nevertheless, it will
result in creation of 'nr_pages' region structs.  Assuming 4K pages, this will
result in about 1% memory waste, as each region struct consumes about 44 bytes
of memory.  Our plan for removal of such overhead is as below.

In a future, the regions abstraction will be able to be entirely opted out[6].
In the case, no region structs will be allocated, so the memory overhead will
be zero.  Nonetheless, the user will be required to configure DAMON to use a
special monitoring primitive which saves the monitoring results such as access
frequency and age in somewhere such as their own data structure or page flags,
like multi-gen LRU patchset does.  If such data structure is commonly usable,
we can extend DAMON core to support it.  To show how this will work, we
implemented a page-granularity idleness monitoring primitive with only 69 lines
of code[6].

Also, if someone has ideas for reducing the page granularity monitoring
overhead, we can put the optimization in the monitoring primitives layer, which
is separated from the core logic.

[1] https://lore.kernel.org/linux-mm/20201216084404.23183-2-sjpark@amazon.com/
[2] https://lore.kernel.org/linux-mm/20201216094221.11898-1-sjpark@amazon.com/
[3] https://github.com/awslabs/damo/blob/master/wss.py
[4] https://lore.kernel.org/linux-mm/20210720131309.22073-15-sj38.park@gmail.com/
[5] https://damonitor.github.io/doc/html/latest/vm/damon/eval.html#efficient-thp
[6] https://github.com/sjp38/linux/commit/9e0cb168d30e
[7] https://lore.kernel.org/linux-mm/20201216094221.11898-14-sjpark@amazon.com/


Thanks,
SeongJae Park
