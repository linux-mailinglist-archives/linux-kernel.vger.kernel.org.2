Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE283B4B6D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 02:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhFZAE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 20:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbhFZAE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 20:04:58 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1EDC061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 17:02:36 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id b5so11217432ilc.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 17:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jrvTfUcAePeGVobBi7vfx79f3CxK6+aYL8bEbt4l0GA=;
        b=sJUcMBMUS826vrxyt4uvbaYSo5AEPcfPuvUqne0EbWjGLsTEIi++TSxCKY+ucoEmhx
         UJLnLBjGBdrWyg+scRonymuhfk2sbLZaRU7X7f0rHwi8f+6IkZg7OlXEsW92ctOF/29P
         Z6ZgUezaIXtmNyXOhsoaAr5i4Y4CeCaHyd0QGOzLoDW1aHjWC2rSWenumCwT35lgo/Ez
         NIoxZJ2dE7uibvXMXVnb5THktVNNnYDLvn+D92htvcLKFsfw1P5eNyh+w3OMRmeBQBzZ
         /F6kfCvPx/2/SCMvfgp+ZaZHPhTznPTbseMEZJ8i5WVPUT7Q+rbhmGfohrGenwUgUXI7
         c4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jrvTfUcAePeGVobBi7vfx79f3CxK6+aYL8bEbt4l0GA=;
        b=CQH7Bh4km7DbOKFcsOz2pe0yt+0E1IdkJasD/4pcs0gX/z5JF3GSY4MZ7HcPgdQken
         IIGr9BaURDRw79BZLasnMPtB5LGOW+8S4fogKn+K5sRbnbGq0/B3w03ut/1HOhLCtmWK
         k9cJok969I5geULb3pDg1fKQnq1OFD1GOtlG/UfkLaLTpXlmz18aJKUyV1HvYib94rZ3
         ny9V8/ypMQGB7s0+zBqreHA0fwZzIPCgqsw6lfLvvdlATMLbAKwFqT4lpbh2Mx3mHE8i
         rTpzk/cg8BMLUEiQhUv9cC6jwkAJkTHfVoO75I4OoLT/CHPhyNf7lbpEEmU1TX18CJeF
         /NbA==
X-Gm-Message-State: AOAM533v4WS/kxEJfL6YOlbBogdoWmCfcMY9MMcqOV65YH1cKCJPAtFV
        tj9Ai6EsoCPaGK6kPDpJMOjLCBcrie9QOGfDYktxPw==
X-Google-Smtp-Source: ABdhPJzMvbegLP5Ie4MhYzekaU2lN5Wg02rSZ4M47WU85xBy+0bte6jHqwlKKwzu4klVF4FSamC1I7A7HJEwxYxGteM=
X-Received: by 2002:a92:d3d1:: with SMTP id c17mr682742ilh.292.1624665755857;
 Fri, 25 Jun 2021 17:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210625073204.1005986-1-ying.huang@intel.com> <20210625073204.1005986-8-ying.huang@intel.com>
In-Reply-To: <20210625073204.1005986-8-ying.huang@intel.com>
From:   Wei Xu <weixugc@google.com>
Date:   Fri, 25 Jun 2021 17:02:25 -0700
Message-ID: <CAAPL-u8J8A2G=QO24hhn-Em+PXE7Q82OObpPJxNUWznfO-0XRQ@mail.gmail.com>
Subject: Re: [PATCH -V9 7/9] mm/vmscan: Consider anonymous pages without swap
To:     Huang Ying <ying.huang@intel.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>, David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 12:33 AM Huang Ying <ying.huang@intel.com> wrote:
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
> anon_should_be_aged() is a much simpler and more preliminary check
> which just says whether there is a possibility of future reclaim.
>
> Cc: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
>
> --
>
> Changes since 20210618:
>  * Consider whether demotion is disabled
>
> Changes from Dave 202010:
>  * remove 'total_swap_pages' modification
>
> Changes from Dave 202006:
>  * rename reclaim_anon_pages()->can_reclaim_anon_pages()
>
> Note: Keith's Intel SoB is commented out because he is no
> longer at Intel and his @intel.com mail will bounce.
> ---
>  mm/vmscan.c | 37 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 34 insertions(+), 3 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 55f6192b2a51..fce43c7970d7 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -519,6 +519,36 @@ static long add_nr_deferred(long nr, struct shrinker *shrinker,
>         return atomic_long_add_return(nr, &shrinker->nr_deferred[nid]);
>  }
>
> +static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
> +                                         int node_id,
> +                                         struct scan_control *sc)
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
> +       if ((!sc || !sc->no_demotion) &&
> +           next_demotion_node(node_id) != NUMA_NO_NODE)
> +               return true;

It is better to abstract these checks into a function, e.g.
can_demote_anon_pages(), to share with anon_can_be_aged().

> +       /* No way to reclaim anon pages */
> +       return false;
> +}
> +
>  /*
>   * This misses isolated pages which are not accounted for to save counters.
>   * As the data only determines if reclaim or compaction continues, it is
> @@ -530,7 +560,7 @@ unsigned long zone_reclaimable_pages(struct zone *zone)
>
>         nr = zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_FILE) +
>                 zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_FILE);
> -       if (get_nr_swap_pages() > 0)
> +       if (can_reclaim_anon_pages(NULL, zone_to_nid(zone), NULL))
>                 nr += zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_ANON) +
>                         zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_ANON);
>
> @@ -2531,6 +2561,7 @@ enum scan_balance {
>  static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
>                            unsigned long *nr)
>  {
> +       struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>         struct mem_cgroup *memcg = lruvec_memcg(lruvec);
>         unsigned long anon_cost, file_cost, total_cost;
>         int swappiness = mem_cgroup_swappiness(memcg);
> @@ -2541,7 +2572,7 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
>         enum lru_list lru;
>
>         /* If we have no swap space, do not bother scanning anon pages. */
> -       if (!sc->may_swap || mem_cgroup_get_nr_swap_pages(memcg) <= 0) {
> +       if (!sc->may_swap || !can_reclaim_anon_pages(memcg, pgdat->node_id, sc)) {
>                 scan_balance = SCAN_FILE;
>                 goto out;
>         }
> @@ -2916,7 +2947,7 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
>          */
>         pages_for_compaction = compact_gap(sc->order);
>         inactive_lru_pages = node_page_state(pgdat, NR_INACTIVE_FILE);
> -       if (get_nr_swap_pages() > 0)
> +       if (can_reclaim_anon_pages(NULL, pgdat->node_id, sc))
>                 inactive_lru_pages += node_page_state(pgdat, NR_INACTIVE_ANON);
>
>         return inactive_lru_pages > pages_for_compaction;
> --
> 2.30.2
>
