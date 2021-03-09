Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A71331BB5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 01:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbhCIAet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 19:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbhCIAek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 19:34:40 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC796C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 16:34:39 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id dm26so17396595edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 16:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cp7qMCjc2xgkX6aRExzrosLgD3gOn5u4crCHK1UDNrM=;
        b=HkT+rNSmwlnN6EBCNnHW0TXuGi/VyIJX1hm3AatXBDqjv2sri17StykdMQyf6MfV2K
         n26PBQgkn+GO/5D9SQC5XobHKmtI2FcAOr0gtCidKHRuGcTmYIi0o6wDkbr4e5HyekBv
         mfVaAecLB/hxLiyIUIbYWtzJ6sbWfbJDM9QEeAUcVo+dHa3x+Fut8ah4fEkYFUxz6fHH
         9JXNv53Cn0C+DGXXRis6n+cPtellaRyELHwkm04pY68wXUDbwFerVuTVxuP6rpv66nCP
         I/Z+e/LKj/xWUtOrf1nkdMRHmezSiSTRFViawJZsw94UnBsfX25M38ICmZGKFic4RMYf
         JBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cp7qMCjc2xgkX6aRExzrosLgD3gOn5u4crCHK1UDNrM=;
        b=g02SkY2r4Lgnx88r+kZXUzHudzNEXVrI2LcP9fnEIWds4IZ2nVDcdWQqd9TT/xsisg
         rKV3MGyTmUUk/UAlGhTf965lImpe9LKbzKwuvyylOdWGgqkfCFXpmbOSPOO0AnleOSxV
         3O7sCyPCTrdFzWBqWagD0Da1Uh8XztJALNEnXv+ig+SdnT/viuE3wRgAO6VNpMbfSTmW
         RrUxJ3Bn1/8+T8UoHQBusYbatB9mztHfyOWxOv3t+vBXw5dgp+oMfDq5jh1TQMzudEJf
         1tz8/0uhQS/7AqGoEhqPi542+rZIRLG0vcxDZszXOn8Jqt2lCBQRLczjjqMXrSfsVdj8
         2oIQ==
X-Gm-Message-State: AOAM5315T7Jyh0hqsk9oKfX01aiMu0HRchH9pdDc9A1dfucc3mxT7G3X
        yXIvvHuvl7LqcqiBCNtJf+HZx0VKze3twqfJ458=
X-Google-Smtp-Source: ABdhPJz7MWWAXyREtaIYL3wVVH+Wd37oGVcxQIif1MGcrBySgecDkTruQjRfazf82RzUjX7IJyHRZOzsfzF7wk6Yqk8=
X-Received: by 2002:aa7:cc03:: with SMTP id q3mr1168103edt.366.1615250078442;
 Mon, 08 Mar 2021 16:34:38 -0800 (PST)
MIME-Version: 1.0
References: <20210304235949.7922C1C3@viggo.jf.intel.com>
In-Reply-To: <20210304235949.7922C1C3@viggo.jf.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 8 Mar 2021 16:34:26 -0800
Message-ID: <CAHbLzkofXg0CnCBYdtWf3cE8Do=B35ZsupV01EmR1SX5=7BHjw@mail.gmail.com>
Subject: Re: [PATCH 00/10] [v6] Migrate Pages in lieu of discard
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 4, 2021 at 4:00 PM Dave Hansen <dave.hansen@linux.intel.com> wrote:
>
>
> The full series is also available here:
>
>         https://github.com/hansendc/linux/tree/automigrate-20210304
>
> which also inclues some vm.zone_reclaim_mode sysctl ABI fixup
> prerequisites.
>
> The meat of this patch is in:
>
>         [PATCH 05/10] mm/migrate: demote pages during reclaim
>
> Which also has the most changes since the last post.  This version is
> mostly to address review comments from Yang Shi and Oscar Salvador.
> Review comments are documented in the individual patch changelogs.
>
> This also contains a few prerequisite patches that fix up an issue
> with the vm.zone_reclaim_mode sysctl ABI.
>
> Changes since (automigrate-20210122):
>  * move from GFP_HIGHUSER -> GFP_HIGHUSER_MOVABLE since pages *are*
>    movable.
>  * Separate out helpers that check for being able to relaim anonymous
>    pages versus being able to meaningfully scan the anon LRU.
>
> --
>
> We're starting to see systems with more and more kinds of memory such
> as Intel's implementation of persistent memory.
>
> Let's say you have a system with some DRAM and some persistent memory.
> Today, once DRAM fills up, reclaim will start and some of the DRAM
> contents will be thrown out.  Allocations will, at some point, start
> falling over to the slower persistent memory.
>
> That has two nasty properties.  First, the newer allocations can end
> up in the slower persistent memory.  Second, reclaimed data in DRAM
> are just discarded even if there are gobs of space in persistent
> memory that could be used.
>
> This set implements a solution to these problems.  At the end of the
> reclaim process in shrink_page_list() just before the last page
> refcount is dropped, the page is migrated to persistent memory instead
> of being dropped.
>
> While I've talked about a DRAM/PMEM pairing, this approach would
> function in any environment where memory tiers exist.
>
> This is not perfect.  It "strands" pages in slower memory and never
> brings them back to fast DRAM.  Other things need to be built to
> promote hot pages back to DRAM.
>
> This is also all based on an upstream mechanism that allows
> persistent memory to be onlined and used as if it were volatile:
>
>         http://lkml.kernel.org/r/20190124231441.37A4A305@viggo.jf.intel.com
>
> == Open Issues ==
>
>  * For cpusets and memory policies that restrict allocations
>    to PMEM, is it OK to demote to PMEM?  Do we need a cgroup-
>    level API to opt-in or opt-out of these migrations?

I'm wondering if such usecases, which don't want to have memory
allocate on pmem, will allow memory swapped out or reclaimed? If swap
is allowed then I failed to see why migrating to pmem should be
disallowed. If swap is not allowed, they should call mlock, then the
memory won't be migrated to pmem as well.

>  * Could be more aggressive about where anon LRU scanning occurs
>    since it no longer necessarily involves I/O.  get_scan_count()
>    for instance says: "If we have no swap space, do not bother
>    scanning anon pages"

Yes, I agree. Johannes's patchset
(https://lore.kernel.org/linux-mm/20200520232525.798933-1-hannes@cmpxchg.org/#r)
has lifted the swappiness to 200 so anonymous lru could be scanned
more aggressively. We definitely could tweak this if needed.

>
> --
>
>  Documentation/admin-guide/sysctl/vm.rst |    9
>  include/linux/migrate.h                 |   20 +
>  include/linux/swap.h                    |    3
>  include/linux/vm_event_item.h           |    2
>  include/trace/events/migrate.h          |    3
>  include/uapi/linux/mempolicy.h          |    1
>  mm/compaction.c                         |    3
>  mm/gup.c                                |    4
>  mm/internal.h                           |    5
>  mm/memory-failure.c                     |    4
>  mm/memory_hotplug.c                     |    4
>  mm/mempolicy.c                          |    8
>  mm/migrate.c                            |  369 +++++++++++++++++++++++++++++---
>  mm/page_alloc.c                         |   13 -
>  mm/vmscan.c                             |  173 +++++++++++++--
>  mm/vmstat.c                             |    2
>  16 files changed, 560 insertions(+), 63 deletions(-)
>
> --
>
> Changes since (automigrate-20200818):
>  * Fall back to normal reclaim when demotion fails
>  * Fix some compile issues, when page migration and NUMA are off
>
> Changes since (automigrate-20201007):
>  * separate out checks for "can scan anon LRU" from "can actually
>    swap anon pages right now".  Previous series conflated them
>    and may have been overly aggressive scanning LRU
>  * add MR_DEMOTION to tracepoint header
>  * remove unnecessary hugetlb page check
>
> Changes since (https://lwn.net/Articles/824830/):
>  * Use higher-level migrate_pages() API approach from Yang Shi's
>    earlier patches.
>  * made sure to actually check node_reclaim_mode's new bit
>  * disabled migration entirely before introducing RECLAIM_MIGRATE
>  * Replace GFP_NOWAIT with explicit __GFP_KSWAPD_RECLAIM and
>    comment why we want that.
>  * Comment on effects of that keep multiple source nodes from
>    sharing target nodes
>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: osalvador <osalvador@suse.de>
> Cc: Huang Ying <ying.huang@intel.com>
>
>
