Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31FFD331B9D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 01:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhCIAZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 19:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhCIAYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 19:24:35 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1670C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 16:24:34 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id h10so17452578edl.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 16:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ldMzFuy7XtYOaxXkLzzP1hP70OgEV2wYJ6wrQAzlas=;
        b=jeNcCOlvTrbIsMXCB9B6QVX6lMNpuitbEDi0X04q8hWbGrev263PWPr2QoiA8k71ch
         5OVBnlQs+aS6S8p0MgmX1o6RLLvefrRBoBXH7kLWLyG6lckBVa2BWQmRRArDVA59KPgf
         ZOodP4NxXnzzcJ1rNtplBARmQR4SNumGLYolR9f4g0GS2cgh9KjaLEmcQWtfRd+djJzY
         2A/O8g01KBqgXEhuAu08W1AoLP3WHXYIvQZJ8sfuBJR7IF31upKtwwH4LKrygW+k9x9J
         GPYky+eN+oR1Qb/zJJITFPZzAHljYbye+E4oe1NrBWfG4XkEyJZx53UZrY3T6wV0u6S/
         WtcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ldMzFuy7XtYOaxXkLzzP1hP70OgEV2wYJ6wrQAzlas=;
        b=NCDGj2HXx+KDfbIzMb5iFz0lp9t1kn1ouu3TxrqWCEHSUBU0Yl/Ys5umQTOI20hPIv
         qd4eOpPA0SjFJUO7KAs70ShK8DNczmWFYOTdAjHeBk+FuIgZiwx5vbiA2GA9ADajhWI5
         PWzg/UQq+zUEsXEWft0d8KUfA7fofxZ2fH4D0ZdcChNsfYns4WwX4P99FQ/SZte4Ebi3
         AO7cgDUTLFXWImY/P9Xk7JS1FZOp2vuUOJu4glpCC9AiYjKuLn5dSaRlMmsf+xnWdOwm
         v6k1wpexNv5Wdim591mD+Rr1NEbGuv3rSBA9qUGsUM+95kRYX3sZdLjc2S91dHnyXdVd
         bn5g==
X-Gm-Message-State: AOAM531GPmMzbi+z41eed9vlg9qdDoS5PvdV75ox+NCtxsNCPjEsl24N
        7mb4gOzUR+mwt7l7VWD/BAUzMu/yfmmALjFIUfc=
X-Google-Smtp-Source: ABdhPJzTakjeKB/IgMQxtQOYJmjIbV2PD/fVBzO5TYn31aBfrrNkPMYL7VAcd3y013xmNVz9cxedOndjyHhXS8ZPq0M=
X-Received: by 2002:aa7:cc03:: with SMTP id q3mr1139714edt.366.1615249473522;
 Mon, 08 Mar 2021 16:24:33 -0800 (PST)
MIME-Version: 1.0
References: <20210304235949.7922C1C3@viggo.jf.intel.com> <20210305000009.EDF902E9@viggo.jf.intel.com>
In-Reply-To: <20210305000009.EDF902E9@viggo.jf.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 8 Mar 2021 16:24:22 -0800
Message-ID: <CAHbLzkqKSOSnyXfqkeW2HDdYk6m+zSZuk5AX1waFVfK-1Vg1=Q@mail.gmail.com>
Subject: Re: [PATCH 10/10] mm/migrate: new zone_reclaim_mode to enable reclaim migration
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

On Thu, Mar 4, 2021 at 4:01 PM Dave Hansen <dave.hansen@linux.intel.com> wrote:
>
>
> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> Some method is obviously needed to enable reclaim-based migration.
>
> Just like traditional autonuma, there will be some workloads that
> will benefit like workloads with more "static" configurations where
> hot pages stay hot and cold pages stay cold.  If pages come and go
> from the hot and cold sets, the benefits of this approach will be
> more limited.
>
> The benefits are truly workload-based and *not* hardware-based.
> We do not believe that there is a viable threshold where certain
> hardware configurations should have this mechanism enabled while
> others do not.
>
> To be conservative, earlier work defaulted to disable reclaim-
> based migration and did not include a mechanism to enable it.
> This proposes extending the existing "zone_reclaim_mode" (now
> now really node_reclaim_mode) as a method to enable it.
>
> We are open to any alternative that allows end users to enable
> this mechanism or disable it it workload harm is detected (just
> like traditional autonuma).
>
> Once this is enabled page demotion may move data to a NUMA node
> that does not fall into the cpuset of the allocating process.
> This could be construed to violate the guarantees of cpusets.
> However, since this is an opt-in mechanism, the assumption is
> that anyone enabling it is content to relax the guarantees.

I think we'd better have the cpuset violation paragraph along with new
zone reclaim mode text so that the users are aware of the potential
violation. I don't think commit log is the to-go place for any plain
users.

>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: osalvador <osalvador@suse.de>
>
> changes since 20200122:
>  * Changelog material about relaxing cpuset constraints
> ---
>
>  b/Documentation/admin-guide/sysctl/vm.rst |    9 +++++++++
>  b/include/linux/swap.h                    |    3 ++-
>  b/include/uapi/linux/mempolicy.h          |    1 +
>  b/mm/vmscan.c                             |    6 ++++--
>  4 files changed, 16 insertions(+), 3 deletions(-)
>
> diff -puN Documentation/admin-guide/sysctl/vm.rst~RECLAIM_MIGRATE Documentation/admin-guide/sysctl/vm.rst
> --- a/Documentation/admin-guide/sysctl/vm.rst~RECLAIM_MIGRATE   2021-03-04 15:36:26.078806355 -0800
> +++ b/Documentation/admin-guide/sysctl/vm.rst   2021-03-04 15:36:26.093806355 -0800
> @@ -976,6 +976,7 @@ This is value OR'ed together of
>  1      Zone reclaim on
>  2      Zone reclaim writes dirty pages out
>  4      Zone reclaim swaps pages
> +8      Zone reclaim migrates pages
>  =      ===================================
>
>  zone_reclaim_mode is disabled by default.  For file servers or workloads
> @@ -1000,3 +1001,11 @@ of other processes running on other node
>  Allowing regular swap effectively restricts allocations to the local
>  node unless explicitly overridden by memory policies or cpuset
>  configurations.
> +
> +Page migration during reclaim is intended for systems with tiered memory
> +configurations.  These systems have multiple types of memory with varied
> +performance characteristics instead of plain NUMA systems where the same
> +kind of memory is found at varied distances.  Allowing page migration
> +during reclaim enables these systems to migrate pages from fast tiers to
> +slow tiers when the fast tier is under pressure.  This migration is
> +performed before swap.
> diff -puN include/linux/swap.h~RECLAIM_MIGRATE include/linux/swap.h
> --- a/include/linux/swap.h~RECLAIM_MIGRATE      2021-03-04 15:36:26.082806355 -0800
> +++ b/include/linux/swap.h      2021-03-04 15:36:26.093806355 -0800
> @@ -382,7 +382,8 @@ extern int sysctl_min_slab_ratio;
>  static inline bool node_reclaim_enabled(void)
>  {
>         /* Is any node_reclaim_mode bit set? */
> -       return node_reclaim_mode & (RECLAIM_ZONE|RECLAIM_WRITE|RECLAIM_UNMAP);
> +       return node_reclaim_mode & (RECLAIM_ZONE |RECLAIM_WRITE|
> +                                   RECLAIM_UNMAP|RECLAIM_MIGRATE);
>  }
>
>  extern void check_move_unevictable_pages(struct pagevec *pvec);
> diff -puN include/uapi/linux/mempolicy.h~RECLAIM_MIGRATE include/uapi/linux/mempolicy.h
> --- a/include/uapi/linux/mempolicy.h~RECLAIM_MIGRATE    2021-03-04 15:36:26.084806355 -0800
> +++ b/include/uapi/linux/mempolicy.h    2021-03-04 15:36:26.094806355 -0800
> @@ -69,5 +69,6 @@ enum {
>  #define RECLAIM_ZONE   (1<<0)  /* Run shrink_inactive_list on the zone */
>  #define RECLAIM_WRITE  (1<<1)  /* Writeout pages during reclaim */
>  #define RECLAIM_UNMAP  (1<<2)  /* Unmap pages during reclaim */
> +#define RECLAIM_MIGRATE        (1<<3)  /* Migrate to other nodes during reclaim */
>
>  #endif /* _UAPI_LINUX_MEMPOLICY_H */
> diff -puN mm/vmscan.c~RECLAIM_MIGRATE mm/vmscan.c
> --- a/mm/vmscan.c~RECLAIM_MIGRATE       2021-03-04 15:36:26.087806355 -0800
> +++ b/mm/vmscan.c       2021-03-04 15:36:26.096806355 -0800
> @@ -1073,6 +1073,9 @@ static bool migrate_demote_page_ok(struc
>         VM_BUG_ON_PAGE(PageHuge(page), page);
>         VM_BUG_ON_PAGE(PageLRU(page), page);
>
> +       if (!(node_reclaim_mode & RECLAIM_MIGRATE))
> +               return false;
> +
>         /* It is pointless to do demotion in memcg reclaim */
>         if (cgroup_reclaim(sc))
>                 return false;
> @@ -1082,8 +1085,7 @@ static bool migrate_demote_page_ok(struc
>         if (PageTransHuge(page) && !thp_migration_supported())
>                 return false;
>
> -       // FIXME: actually enable this later in the series
> -       return false;
> +       return true;
>  }
>
>  /* Check if a page is dirty or under writeback */
> _
>
