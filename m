Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF80331B89
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 01:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbhCIASB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 19:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbhCIARd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 19:17:33 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C77C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 16:17:32 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id r17so23969961ejy.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 16:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k7EiN3DgkaHZ8scB2/qM/k5IdjZOxSdMnEZ5/Sc78dw=;
        b=YbU0RBEXMLfpVpcZUY6xISifozTY6p+sHGHwsPU47KJoXSwcFEfCiTqYHlGr8fEtDe
         qxQbVfavAaNAK6VcGEryAevXOZ+8QwYTEertv1L7jlnVx3KVJGiY1fZk62G6/zFg1xWR
         nQqeD7yH4h5MwJ44e21vLT1uZbjH7S50Yd4L72gZY54HWH1EbXfGO0ariimxzlPkF5zK
         33WHFzniwdhylFHImcOOmtLqVH1A1lc/UJWf6+soogYyB9d+OmbGR/IG/H3y5aYyXUNd
         HjmcJaSAzKNiMwKTk1LWgkr2dubvtMfK5M6Z8UX6eXeInF/ukJ/8q+JYQ0CK18WVakNe
         9fBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k7EiN3DgkaHZ8scB2/qM/k5IdjZOxSdMnEZ5/Sc78dw=;
        b=i/v/ShubLq90qJZEPLv5ou+k9x2TdEa712T73MfzBsIk88lyCHSAaos142GDyazZrd
         4KQzeXMZZXXZoX1alG/h8BLuJ4w5ILUlvvLWp7vPJU6f7saqD7UypgK4GfUdVWYe8vZX
         9z8+rEWJinS9onz7pYJHDRO72jWHn5j09o6OJWxO9QsMEhlcvUWJHQpaJLF7KJhDcrX2
         Z01mL1IN5Dd1uKcL7F40j5NBg2vjZ6OsFrImomTAam46I/HL51l9EwD1fE7eweV38RTK
         GlF9yjAioHqJjsHPVBAlenKvcbpXjz6lLDHE1P2D8RxDsjZ7drJKmVPjEEHAmxZGJzbR
         fAlQ==
X-Gm-Message-State: AOAM533ZkHmtX7JBPMJtlJ0/Rjbk264v3hMUzZdVwNzRQQXhTkCs8hxz
        5Ea/fV83rwkOXPrqP6BHReKhiE90QYhU0lqEQ0s=
X-Google-Smtp-Source: ABdhPJwN2myOdpLfbf4qxciTvRKt6ddcGGZKYJVMBmLecE1FSjT5L5w3cghE+C3qCe6auORmyA+2q+fbNLfW58j81Pw=
X-Received: by 2002:a17:906:bcfc:: with SMTP id op28mr17041587ejb.238.1615249051778;
 Mon, 08 Mar 2021 16:17:31 -0800 (PST)
MIME-Version: 1.0
References: <20210304235949.7922C1C3@viggo.jf.intel.com> <20210305000004.20A8D23F@viggo.jf.intel.com>
In-Reply-To: <20210305000004.20A8D23F@viggo.jf.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 8 Mar 2021 16:17:20 -0800
Message-ID: <CAHbLzkpL8=x2kPq=B19xSf+8qEKt8LKek2vw3yjseXUP+VoTPw@mail.gmail.com>
Subject: Re: [PATCH 08/10] mm/vmscan: Consider anonymous pages without swap
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, kbusch@kernel.org,
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

Just a typo, s/prelimiary/preliminary

> which just says whether there is a possibility of future reclaim.

Reviewed-by: Yang Shi <shy828301@gmail.com>

>
> #Signed-off-by: Keith Busch <keith.busch@intel.com>
> Cc: Keith Busch <kbusch@kernel.org>
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
> longer at Intel and his @intel.com mail will bounce.
> ---
>
>  b/mm/vmscan.c |   35 ++++++++++++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 3 deletions(-)
>
> diff -puN mm/vmscan.c~0009-mm-vmscan-Consider-anonymous-pages-without-swap mm/vmscan.c
> --- a/mm/vmscan.c~0009-mm-vmscan-Consider-anonymous-pages-without-swap  2021-03-04 15:35:59.994806420 -0800
> +++ b/mm/vmscan.c       2021-03-04 15:36:00.001806420 -0800
> @@ -287,6 +287,34 @@ static bool writeback_throttling_sane(st
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
> @@ -298,7 +326,7 @@ unsigned long zone_reclaimable_pages(str
>
>         nr = zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_FILE) +
>                 zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_FILE);
> -       if (get_nr_swap_pages() > 0)
> +       if (can_reclaim_anon_pages(NULL, zone_to_nid(zone)))
>                 nr += zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_ANON) +
>                         zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_ANON);
>
> @@ -2332,6 +2360,7 @@ enum scan_balance {
>  static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
>                            unsigned long *nr)
>  {
> +       struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>         struct mem_cgroup *memcg = lruvec_memcg(lruvec);
>         unsigned long anon_cost, file_cost, total_cost;
>         int swappiness = mem_cgroup_swappiness(memcg);
> @@ -2342,7 +2371,7 @@ static void get_scan_count(struct lruvec
>         enum lru_list lru;
>
>         /* If we have no swap space, do not bother scanning anon pages. */
> -       if (!sc->may_swap || mem_cgroup_get_nr_swap_pages(memcg) <= 0) {
> +       if (!sc->may_swap || !can_reclaim_anon_pages(memcg, pgdat->node_id)) {
>                 scan_balance = SCAN_FILE;
>                 goto out;
>         }
> @@ -2717,7 +2746,7 @@ static inline bool should_continue_recla
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
