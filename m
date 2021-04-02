Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41DD2352465
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 02:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236767AbhDBASc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 20:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236642AbhDBASV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 20:18:21 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4098BC061797
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 17:18:17 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id f19so3928047ion.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 17:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7k6TmguUsUmCTAXHQ4UdteGe/Bb76fZ4Cj6VWmBAXaE=;
        b=p4Y0+JcIoi0RggWAp3uZZzVwjdDesIRWg7dxK4mTnYHlS2DxUC/Xx94UIOUpB1LwY2
         QPTKOZ08hy7lWgPSQIf1juTP5GveibLpWEucX7IuoLniPeiHeMjNUwLjodd3aULiYSiw
         exZTFcjxwTA5jflcePSZxzdWtp1qf/pWClG1MJc4m8MrXVVxhv2YnLuL6Vj7jGj5nIJc
         GS+vTSM5W8JLSFootcD9qIAGAx97jGrC6Ul6Q9tkJ49LJ0eBLKlJTJl84EkfoelQgOg+
         9onHpvHe7j+WaXTTcWXcAZHXWGWaBvRTSUBeeJO7RfBKr+/X3sz9jCUv/bIJ8xOypZYA
         iLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7k6TmguUsUmCTAXHQ4UdteGe/Bb76fZ4Cj6VWmBAXaE=;
        b=W1hz02Y8u10ekqEXNBpJ8pzSrUcwoyywoZQIDWcgIMKHdMZJwpRlwp6/m99Okc/T9/
         j+pkMcd2BoRnjsagCm2qTWik0+ocGOqJPoQSWshkxUFn0bsHF018Q1z8x1Tt5kEUJLKv
         SgeCEvKxyoKtQck7TBMCWfTyjCy3YoGe/3VoqCSokMI3+AACnaAxklU8a8FdhWwfk3iW
         zLcAWCgo526BRIj/6K2G7IGi0Pl2FZcJ7JTWsbZGSk1viVVoE/xWr6YIdyWxFbqnia1U
         mjra2xJeAM5Ig16tAP+YbriKpDpGyKSPC1c4Ly5o4ffsb8XTVeGP9ryfZ9+BJyoluDjM
         yxVQ==
X-Gm-Message-State: AOAM531tBcAFQdbzDgwPLAI9WyH9QgJ5JJJ7IG4W6sUoC3iCHFbrLAa+
        jcZPQMOC1eFugZYfUUTe5xDwbUkxiZemKIhhpPNFpw==
X-Google-Smtp-Source: ABdhPJyxImQI4bY3SJ9N8eb20WUK5oZvs7v4iYN33lZSZ8t7H7RrriNem8/FXZXzy5sfwoOQes2pbfyfxEp0DdM5qzE=
X-Received: by 2002:a05:6638:210d:: with SMTP id n13mr10275763jaj.100.1617322696489;
 Thu, 01 Apr 2021 17:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210401183216.443C4443@viggo.jf.intel.com> <20210401183233.64A91C97@viggo.jf.intel.com>
In-Reply-To: <20210401183233.64A91C97@viggo.jf.intel.com>
From:   Wei Xu <weixugc@google.com>
Date:   Thu, 1 Apr 2021 17:18:04 -0700
Message-ID: <CAAPL-u-YqwdFg865d5uQQ8uGPJk-Now0esF1-r2OXVeSWK3_zw@mail.gmail.com>
Subject: Re: [PATCH 09/10] mm/vmscan: never demote for memcg reclaim
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yang.shi@linux.alibaba.com, shy828301@gmail.com,
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
> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> Global reclaim aims to reduce the amount of memory used on
> a given node or set of nodes.  Migrating pages to another
> node serves this purpose.
>
> memcg reclaim is different.  Its goal is to reduce the
> total memory consumption of the entire memcg, across all
> nodes.  Migration does not assist memcg reclaim because
> it just moves page contents between nodes rather than
> actually reducing memory consumption.
>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Suggested-by: Yang Shi <yang.shi@linux.alibaba.com>
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: osalvador <osalvador@suse.de>
> ---
>
>  b/mm/vmscan.c |   18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff -puN mm/vmscan.c~never-demote-for-memcg-reclaim mm/vmscan.c
> --- a/mm/vmscan.c~never-demote-for-memcg-reclaim        2021-03-31 15:17:20.476000239 -0700
> +++ b/mm/vmscan.c       2021-03-31 15:17:20.487000239 -0700
> @@ -288,7 +288,8 @@ static bool writeback_throttling_sane(st
>  #endif
>
>  static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
> -                                         int node_id)
> +                                         int node_id,
> +                                         struct scan_control *sc)

I don't see "sc" gets used in can_reclaim_anon_pages().  Remove it?

>  {
>         if (memcg == NULL) {
>                 /*
> @@ -326,7 +327,7 @@ unsigned long zone_reclaimable_pages(str
>
>         nr = zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_FILE) +
>                 zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_FILE);
> -       if (can_reclaim_anon_pages(NULL, zone_to_nid(zone)))
> +       if (can_reclaim_anon_pages(NULL, zone_to_nid(zone), NULL))
>                 nr += zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_ANON) +
>                         zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_ANON);
>
> @@ -1064,7 +1065,8 @@ static enum page_references page_check_r
>         return PAGEREF_RECLAIM;
>  }
>
> -static bool migrate_demote_page_ok(struct page *page)
> +static bool migrate_demote_page_ok(struct page *page,
> +                                  struct scan_control *sc)
>  {
>         int next_nid = next_demotion_node(page_to_nid(page));
>
> @@ -1072,6 +1074,10 @@ static bool migrate_demote_page_ok(struc
>         VM_BUG_ON_PAGE(PageHuge(page), page);
>         VM_BUG_ON_PAGE(PageLRU(page), page);
>
> +       /* It is pointless to do demotion in memcg reclaim */
> +       if (cgroup_reclaim(sc))
> +               return false;
> +
>         if (next_nid == NUMA_NO_NODE)
>                 return false;
>         if (PageTransHuge(page) && !thp_migration_supported())
> @@ -1328,7 +1334,7 @@ retry:
>                  * Before reclaiming the page, try to relocate
>                  * its contents to another node.
>                  */
> -               if (do_demote_pass && migrate_demote_page_ok(page)) {
> +               if (do_demote_pass && migrate_demote_page_ok(page, sc)) {
>                         list_add(&page->lru, &demote_pages);
>                         unlock_page(page);
>                         continue;
> @@ -2362,7 +2368,7 @@ static void get_scan_count(struct lruvec
>         enum lru_list lru;
>
>         /* If we have no swap space, do not bother scanning anon pages. */
> -       if (!sc->may_swap || !can_reclaim_anon_pages(memcg, pgdat->node_id)) {
> +       if (!sc->may_swap || !can_reclaim_anon_pages(memcg, pgdat->node_id, sc)) {
>                 scan_balance = SCAN_FILE;
>                 goto out;
>         }
> @@ -2737,7 +2743,7 @@ static inline bool should_continue_recla
>          */
>         pages_for_compaction = compact_gap(sc->order);
>         inactive_lru_pages = node_page_state(pgdat, NR_INACTIVE_FILE);
> -       if (can_reclaim_anon_pages(NULL, pgdat->node_id))
> +       if (can_reclaim_anon_pages(NULL, pgdat->node_id, sc))
>                 inactive_lru_pages += node_page_state(pgdat, NR_INACTIVE_ANON);
>
>         return inactive_lru_pages > pages_for_compaction;
> _
