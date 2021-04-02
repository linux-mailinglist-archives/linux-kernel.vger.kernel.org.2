Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A4B3524B6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 02:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbhDBAz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 20:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhDBAz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 20:55:26 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255A5C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 17:55:26 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id t14so3589828ilu.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 17:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ggar240r8l1y1SR7kz5vR/iom4bN+ntyDx1BWqiKLWA=;
        b=HfUsqhL+okD5Z6DtZAvlDomFb/eZX+9XmkHddnlgl6gSKyk8ihNeBFMl/o5/uKgLJT
         kZJaw4s2Z++IPVOripdmiWATHKUmJLl4uP/dlVCoI595caniLn4znAZjDJf15XYwMCc+
         CpgdD/nET0RYazA1I/7W712anpZmjGGROh+hqzUAQc9/AmPa/ZJTwuD0Hg/IHwagOE2H
         hws/CVnk+C75Z0MceafmrdCVsUUz/rCzGJomdoI7qY6vzIfJ/nkrH7m8zBX3D67ma+dB
         8xKxneQyjbNzgHX3LzohQC9Bu5zpuLktXOXGUhPSa9/no+mcL9inlPqvAmOvvpiiscGC
         2f6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ggar240r8l1y1SR7kz5vR/iom4bN+ntyDx1BWqiKLWA=;
        b=i/YXrhMy70WI7eMKCazUMzN799rfxSE7gZPX83IDdPaW1004iFD8T8DYkLoXYA4Lk+
         dp4PMCFsK3pKCuIa11rgpllffFofuUTkwJyuW2iniqwYbAAZzpxjHLPEKzUHSqcsJAQL
         iIcGIW5Lr/POj5GPe31Dac2JjU04FUnuuhrjPEJw5DXKgHaOJC6fbPx3P8I0H6jMaZBr
         pEBgiBE6zp8zg2Js2kcfm2gq8Zn5atUEG2mr3AshIMy8MT2xa0/UTVUfFJrX7pHk9Txy
         3ouno5S6iQb0ZoVmkvqo4KaV4w3BJAtpKtZZYq1QAccjFGHqCTHZGU2kCULEX7i17BFF
         jolA==
X-Gm-Message-State: AOAM532yIPz0BgAbpe5mfUAsfMlR+T7bpGmE94I8fN1cLxwa7aG0WfyY
        zkVrGJXUlkOU3sc1BZ+PM3nnR+XPZB600NNgotEP0A==
X-Google-Smtp-Source: ABdhPJz52Elpa8MCYcBQKr2vnBLDMM40OFRVlMe3SRA4T3HZnstJIwIud5WK6sp99a2jtfaldbUB2+UTIh7apFf1O5A=
X-Received: by 2002:a05:6e02:154d:: with SMTP id j13mr6792790ilu.128.1617324925442;
 Thu, 01 Apr 2021 17:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210401183216.443C4443@viggo.jf.intel.com> <20210401183231.8485C83D@viggo.jf.intel.com>
In-Reply-To: <20210401183231.8485C83D@viggo.jf.intel.com>
From:   Wei Xu <weixugc@google.com>
Date:   Thu, 1 Apr 2021 17:55:13 -0700
Message-ID: <CAAPL-u-zQFRD=m3+vygesijsQT01H9BYtpDw9Q+80CUB=mdW1g@mail.gmail.com>
Subject: Re: [PATCH 08/10] mm/vmscan: Consider anonymous pages without swap
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kbusch@kernel.org, shy828301@gmail.com,
        David Rientjes <rientjes@google.com>, ying.huang@intel.com,
        Dan Williams <dan.j.williams@intel.com>, david@redhat.com,
        osalvador@suse.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 1, 2021 at 11:35 AM Dave Hansen <dave.hansen@linux.intel.com> wrote:
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
> anon_should_be_aged() is a much simpler and more preliminary check
> which just says whether there is a possibility of future reclaim.
>
> #Signed-off-by: Keith Busch <keith.busch@intel.com>
> Cc: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> Cc: Wei Xu <weixugc@google.com>
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
> --- a/mm/vmscan.c~0009-mm-vmscan-Consider-anonymous-pages-without-swap  2021-03-31 15:17:19.388000242 -0700
> +++ b/mm/vmscan.c       2021-03-31 15:17:19.407000242 -0700
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

When neither swap space nor RECLAIM_MIGRATE is enabled, but
next_demotion_node() is configured, inactive pages cannot be swapped out
nor demoted.  However, this check can still cause these pages to be sent
to shrink_page_list() (e.g., when can_reclaim_anon_pages() is called by
get_scan_count()) and make the THP pages being unnecessarily split there.

One fix would be to guard this next_demotion_node() check with the
RECLAIM_MIGRATE node_reclaim_mode check.  This RECLAIM_MIGRATE
check needs to be applied to other calls to next_demotion_node() in
vmscan.c as well.

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

Demotion of anon pages still depends on sc->may_swap.  Any thoughts on
decoupling
demotion from swapping more completely?

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
