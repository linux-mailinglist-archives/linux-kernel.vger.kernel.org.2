Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF15230CB54
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 20:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239084AbhBBTVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 14:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239172AbhBBS5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 13:57:12 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95771C061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 10:56:31 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id jj19so3916637ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 10:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b8dqV4ylKlnWwc03tOmEAN2Blw3jDnjpV5EJfPDOmKU=;
        b=Y+fuyGQHiDe6MNsBQ0O0e7XLnR2NsPUPd8rl6IPZuXKRsS5x8ON2kvQHxHINmXzlaE
         m/U7FvnFEq4HpDCf6UtKLibRyVrylq92YHuZdHq/LoQ7RwTIqxcUIy7coMKKKReOZGV4
         cOHsTVf+omWnJkTpxPWXYtgIgrGuPUiWGxDH0vCD/WP58mXVwoW6IfxuT3EBdDq59Wrr
         E5VmD4LZGhhUDSWPhznuGLOjJmIWPmdHynxUztSxZ5s7QL7dV0kTPqjClUs1YDSDUa6f
         l2FQAqf7Kk/kK7GUI9FnQH8IeMuE9K5NuiPgfAyiaF/Z8IXmghbVkdpQAMrSFxzVCr2E
         fgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b8dqV4ylKlnWwc03tOmEAN2Blw3jDnjpV5EJfPDOmKU=;
        b=d71lAxEvqRDKmBtlsPR3XqgRUBKPUVQv4hU7SrAyj/Kb9cYuyx15xnZ908dRC1O4KQ
         2jbt5lpTuG4RNnae3pY2blSY+jV5UI3N9V0ikWCL4ISe4In2HnWM24KA+zYOimfTVDxc
         GBu6KJ6dykRFrM43OR/yAVS+ZgjJvWhJOS54KmhsCsdrthdQRW0hR+KQnMtxMOcNbSqn
         kpkrmi1E5irsxc2mI4cyaGKHEYIadFMOR0Knbdc7CLRSWyRO37yx1XubN1LYPMyoTn4F
         72/Jn4rXEXRoQ2nV0NEou0LpstVnBXq0uH9qFf6a61wXS3kvu0o3+yMrKZolHogSIalN
         DlSw==
X-Gm-Message-State: AOAM533sqQq3eD81dp1LTFUFhg4n10CTwuXMKkOnqD/0xoiYvcB9MVgj
        dEfeETKwqNsEfYqijoiO09CJ6uphJ8ICO7oD0gk=
X-Google-Smtp-Source: ABdhPJyS6nG61rjCK0u3XCj4CP0EfQc8rTngvcudG7aNnqqUuZId6yF4qo/HQ5cBAKuxD6OeX4dsS6AC0cy2dvpBT1g=
X-Received: by 2002:a17:906:f841:: with SMTP id ks1mr23626709ejb.507.1612292190379;
 Tue, 02 Feb 2021 10:56:30 -0800 (PST)
MIME-Version: 1.0
References: <20210126003411.2AC51464@viggo.jf.intel.com> <20210126003432.6E88B570@viggo.jf.intel.com>
In-Reply-To: <20210126003432.6E88B570@viggo.jf.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 2 Feb 2021 10:56:18 -0800
Message-ID: <CAHbLzkp+PXOUBmKg-4z3-6kUePnwcO65L3W51UvYiT1g8uYh5Q@mail.gmail.com>
Subject: Re: [RFC][PATCH 11/13] mm/vmscan: Consider anonymous pages without swap
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, kbusch@kernel.org,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
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

On Mon, Jan 25, 2021 at 4:42 PM Dave Hansen <dave.hansen@linux.intel.com> wrote:
>
>
> From: Keith Busch <kbusch@kernel.org>
>
> Reclaim anonymous pages if a migration path is available now that
> demotion provides a non-swap recourse for reclaiming anon pages.
>
> Note that this check is subtly different from the
> anon_should_be_aged() checks.  This mechanism checks whether a
> specific page in a specific context *can* actually be reclaimed, given
> current swap space and cgroup limits
>
> anon_should_be_aged() is a much simpler and more prelimiary check
> which just says whether there is a possibility of future reclaim.
>
> #Signed-off-by: Keith Busch <keith.busch@intel.com>
> Cc: Keith Busch <kbusch@kernel.org>
> [vishal: fixup the migration->demotion rename]
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: osalvador <osalvador@suse.de>
>
> --
>
> Changes from Dave 10/2020:
>  * remove 'total_swap_pages' modification
>
> Changes from Dave 06/2020:
>  * rename reclaim_anon_pages()->can_reclaim_anon_pages()
>
> Note: Keith's Intel SoB is commented out because he is no
> longer at Intel and his @intel.com mail will bouncee
> ---
>
>  b/mm/vmscan.c |   35 ++++++++++++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 3 deletions(-)
>
> diff -puN mm/vmscan.c~0009-mm-vmscan-Consider-anonymous-pages-without-swap mm/vmscan.c
> --- a/mm/vmscan.c~0009-mm-vmscan-Consider-anonymous-pages-without-swap  2021-01-25 16:23:18.106866688 -0800
> +++ b/mm/vmscan.c       2021-01-25 16:23:18.111866688 -0800
> @@ -289,6 +289,34 @@ static bool writeback_throttling_sane(st
>  }
>  #endif
>
> +static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
> +                                         int node_id)
> +{
> +       if (memcg == NULL) {
> +               /*
> +                * For non-memcg reclaim, is there
> +                * space in any swap device?
> +                */
> +               if (get_nr_swap_pages() > 0)
> +                       return true;
> +       } else {
> +               /* Is the memcg below its swap limit? */
> +               if (mem_cgroup_get_nr_swap_pages(memcg) > 0)
> +                       return true;
> +       }
> +
> +       /*
> +        * The page can not be swapped.
> +        *
> +        * Can it be reclaimed from this node via demotion?
> +        */
> +       if (next_demotion_node(node_id) >= 0)
> +               return true;
> +
> +       /* No way to reclaim anon pages */
> +       return false;
> +}
> +
>  /*
>   * This misses isolated pages which are not accounted for to save counters.
>   * As the data only determines if reclaim or compaction continues, it is
> @@ -300,7 +328,7 @@ unsigned long zone_reclaimable_pages(str
>
>         nr = zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_FILE) +
>                 zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_FILE);
> -       if (get_nr_swap_pages() > 0)
> +       if (can_reclaim_anon_pages(NULL, zone_to_nid(zone)))
>                 nr += zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_ANON) +
>                         zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_ANON);
>
> @@ -2323,6 +2351,7 @@ enum scan_balance {
>  static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
>                            unsigned long *nr)
>  {
> +       struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>         struct mem_cgroup *memcg = lruvec_memcg(lruvec);
>         unsigned long anon_cost, file_cost, total_cost;
>         int swappiness = mem_cgroup_swappiness(memcg);
> @@ -2333,7 +2362,7 @@ static void get_scan_count(struct lruvec
>         enum lru_list lru;
>
>         /* If we have no swap space, do not bother scanning anon pages. */
> -       if (!sc->may_swap || mem_cgroup_get_nr_swap_pages(memcg) <= 0) {
> +       if (!sc->may_swap || !can_reclaim_anon_pages(memcg, pgdat->node_id)) {

Just one minor thing about may_swap. It may be cleared by
nr_boost_reclaim. But demotion should be fine for boost_reclaim.

>                 scan_balance = SCAN_FILE;
>                 goto out;
>         }
> @@ -2708,7 +2737,7 @@ static inline bool should_continue_recla
>          */
>         pages_for_compaction = compact_gap(sc->order);
>         inactive_lru_pages = node_page_state(pgdat, NR_INACTIVE_FILE);
> -       if (get_nr_swap_pages() > 0)
> +       if (can_reclaim_anon_pages(NULL, pgdat->node_id))
>                 inactive_lru_pages += node_page_state(pgdat, NR_INACTIVE_ANON);
>
>         return inactive_lru_pages > pages_for_compaction;
> _
>
