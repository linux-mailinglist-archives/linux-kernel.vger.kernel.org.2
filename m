Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586C9331B8C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 01:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbhCIASf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 19:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhCIASL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 19:18:11 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68848C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 16:18:11 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id r17so23972471ejy.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 16:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=acy184sOM2Hs8owvmipcSybCC3rkN87Sp2pyk/zaHQE=;
        b=aisPV7atKgL/mLmBaGxLjbfcoHANQ61HpIHqsY33wWfrYftjiBJsIP4tUXdm8hMD7b
         BpKDh9ilB2NLaTAL7ut9Irgt2LCGcjFM/XUUMuERWLfl126owOzE9et1tOnbMldkN8Mn
         KgvOlAVBQfd7JQkrmVnbsDLiX0LztI+RIVioWLDzB/vG5lRmAyJ2MUctty+6zi4JHxST
         RgfWq62dcInvhvotUJOFWi/+l1zhrlENyBAoJVjbA746kHIBjO64rH/spWyTKfPXXOMI
         jdTPwMZ33WTtjP5TJdSs/qA8sjjoY5G1risgqy/8bWp1ky56zdUmb4VlC9Fu8+FVqDV5
         Gi0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=acy184sOM2Hs8owvmipcSybCC3rkN87Sp2pyk/zaHQE=;
        b=sbMQIMjIud2Kq6hhhlxzXqN7O0IClKcFIluFtSozcuGwpJzVTu7CUOJMfGNNTt4g1f
         YFqPF3TDCoat/YuXK0VYQ3UOoZbRs9Gyr9voKjtQxdOk4g6+C91Yn8h0OiSLGV/SNzo4
         H+OyUoWhzl6S3xCCxgBciP+/4vutaNXQxG5Jj3JRKwGfZc9XXzXLB2iulPB/vGAltmRl
         w3hYvuVr2u/jWciPXayDEDmOOUdfJrG5ZXcnkU0kkOFlGEBZpT7ajCwp40Y42rKA5rf1
         8BRi7sAU1vrtcoufYbfcQlg64bWOIqINV3mX3/YEEnl6r30v6++Y3l18Vm4tI2fwJHGY
         CjMw==
X-Gm-Message-State: AOAM533PAq+hBavJvlTk8hsO/0KO/ExxNj16NAhv76UyUiG+GPsQ6tCF
        viJ2wsAR/NPA2YmjEiZ114gupaEJ16hqBwH0Sp6y34rJnpk=
X-Google-Smtp-Source: ABdhPJysrK1+AUi6SQiTbAU2PAYnh9SKajWZMYxLW5DKnp41jK6xkg3ebdb7ptOgWTjAZRUW8kJSQvWrb0msLsrEdKQ=
X-Received: by 2002:a17:906:a147:: with SMTP id bu7mr17027664ejb.383.1615249090238;
 Mon, 08 Mar 2021 16:18:10 -0800 (PST)
MIME-Version: 1.0
References: <20210304235949.7922C1C3@viggo.jf.intel.com> <20210305000006.3799F4BE@viggo.jf.intel.com>
In-Reply-To: <20210305000006.3799F4BE@viggo.jf.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 8 Mar 2021 16:17:58 -0800
Message-ID: <CAHbLzkrugnnsSN-z9GBZ+=KqPt3F=B=TPUGXpLdr1S1j5L8_VQ@mail.gmail.com>
Subject: Re: [PATCH 09/10] mm/vmscan: never demote for memcg reclaim
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

On Thu, Mar 4, 2021 at 4:02 PM Dave Hansen <dave.hansen@linux.intel.com> wrote:
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

Reviewed-by: Yang Shi <shy828301@gmail.com>

>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Suggested-by: Yang Shi <yang.shi@linux.alibaba.com>
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
> --- a/mm/vmscan.c~never-demote-for-memcg-reclaim        2021-03-04 15:36:01.067806417 -0800
> +++ b/mm/vmscan.c       2021-03-04 15:36:01.072806417 -0800
> @@ -288,7 +288,8 @@ static bool writeback_throttling_sane(st
>  #endif
>
>  static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
> -                                         int node_id)
> +                                         int node_id,
> +                                         struct scan_control *sc)
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
> @@ -1063,7 +1064,8 @@ static enum page_references page_check_r
>         return PAGEREF_RECLAIM;
>  }
>
> -static bool migrate_demote_page_ok(struct page *page)
> +static bool migrate_demote_page_ok(struct page *page,
> +                                  struct scan_control *sc)
>  {
>         int next_nid = next_demotion_node(page_to_nid(page));
>
> @@ -1071,6 +1073,10 @@ static bool migrate_demote_page_ok(struc
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
> @@ -1326,7 +1332,7 @@ retry:
>                  * Before reclaiming the page, try to relocate
>                  * its contents to another node.
>                  */
> -               if (do_demote_pass && migrate_demote_page_ok(page)) {
> +               if (do_demote_pass && migrate_demote_page_ok(page, sc)) {
>                         list_add(&page->lru, &demote_pages);
>                         unlock_page(page);
>                         continue;
> @@ -2371,7 +2377,7 @@ static void get_scan_count(struct lruvec
>         enum lru_list lru;
>
>         /* If we have no swap space, do not bother scanning anon pages. */
> -       if (!sc->may_swap || !can_reclaim_anon_pages(memcg, pgdat->node_id)) {
> +       if (!sc->may_swap || !can_reclaim_anon_pages(memcg, pgdat->node_id, sc)) {
>                 scan_balance = SCAN_FILE;
>                 goto out;
>         }
> @@ -2746,7 +2752,7 @@ static inline bool should_continue_recla
>          */
>         pages_for_compaction = compact_gap(sc->order);
>         inactive_lru_pages = node_page_state(pgdat, NR_INACTIVE_FILE);
> -       if (can_reclaim_anon_pages(NULL, pgdat->node_id))
> +       if (can_reclaim_anon_pages(NULL, pgdat->node_id, sc))
>                 inactive_lru_pages += node_page_state(pgdat, NR_INACTIVE_ANON);
>
>         return inactive_lru_pages > pages_for_compaction;
> _
>
