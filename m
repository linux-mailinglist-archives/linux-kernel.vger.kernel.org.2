Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2DD6331B7D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 01:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhCIAPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 19:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbhCIAPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 19:15:06 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFEEC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 16:14:58 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id l12so17441161edt.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 16:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yUB3jp73XK4SAneJ1S8s1LTi7ahcluSZc6auK97PcQI=;
        b=QykJj0vYvhQmts0pIy+A4Qt6Pjibu8bZoP1PN1A/jHUPOUgk9i8sFS+MU7Ggy6Q6Aw
         ifGuJ29sMKqKs/YX1RDA+VYqhzf60T2HxmzwFFZSNtKV3kPzkpXoD1frqGZCcy9KYbj6
         0eu90B4UOopBnUzYTozx2D96uhSls4DTc/ZR9CyIUngyvY73CbcUuOulBRvY+QFVKV4/
         4RynYbQyxF78//Z8M5KneWbE9XHb3WhZEKDmUcu0cftSEgqo/zhYi5EBV7i/RKADId23
         FD6PzqrB76YNivvfpoCgiSTNhd1SNFEy9fM7V/1xdba7rIn5llmp8hyeIWqwMIh2dx6x
         hU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yUB3jp73XK4SAneJ1S8s1LTi7ahcluSZc6auK97PcQI=;
        b=YxcukXc3Qfrg0rB2TyhZoYq67ohO3Pzn48poG5REIDpsR/Rwlyu8ZmwpmBH55nn2cH
         7yQRX75Tiom/cWJlgAPNXqWRmhhHk/eH8f1s/Y0YZIn6Bg5JffCzcWUAiT7r2CspjlmT
         A6KXY8KxDOn/1X5vkVY5ZkuOT2Hq8JioMeCXoPJ94VGV5XfwhMKw+a6/mcO7tvm98Ghj
         15I/VFt3lagEBEdW/BRXnjxQjaGW21lS4V7AGwaxH2VD8RuwXjuQ0xhyZfs/53Nk40r3
         /rdcr/hFKJNGVOrF3iUWX7fTfT1Mr2X/jBsdeT9ot5I/DBi92SlMry+ZmlDkXhJAN4aJ
         xTdw==
X-Gm-Message-State: AOAM5314DCdiP/WQGOphsZ/6uF3kDh7/IQNV7FJrVI7gRFLOr3ZxBr1d
        TRGdhP8zN0WLL0E15HZCBSSe5rPzvcN5XILUKDg=
X-Google-Smtp-Source: ABdhPJwAZ9Gu4Mkmbmz3iAeQ075ICY/IWk1U0j4xtGyghi+zOeZFzliOGslqaZmXlUDpsMDX+wmHUTPH0utLNvWAmIg=
X-Received: by 2002:a50:bec3:: with SMTP id e3mr1094426edk.290.1615248897079;
 Mon, 08 Mar 2021 16:14:57 -0800 (PST)
MIME-Version: 1.0
References: <20210304235949.7922C1C3@viggo.jf.intel.com> <20210305000002.D171810D@viggo.jf.intel.com>
In-Reply-To: <20210305000002.D171810D@viggo.jf.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 8 Mar 2021 16:14:45 -0800
Message-ID: <CAHbLzkrEd_LapbzmwvEY9z=eaG0qjA9mKLhKu254rZD=ezLGTA@mail.gmail.com>
Subject: Re: [PATCH 07/10] mm/vmscan: add helper for querying ability to age
 anonymous pages
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
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
> Anonymous pages are kept on their own LRU(s).  These lists could
> theoretically always be scanned and maintained.  But, without swap,
> there is currently nothing the kernel can *do* with the results of a
> scanned, sorted LRU for anonymous pages.
>
> A check for '!total_swap_pages' currently serves as a valid check as
> to whether anonymous LRUs should be maintained.  However, another
> method will be added shortly: page demotion.
>
> Abstract out the 'total_swap_pages' checks into a helper, give it a
> logically significant name, and check for the possibility of page
> demotion.

Reviewed-by: Yang Shi <shy828301@gmail.com>

>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: osalvador <osalvador@suse.de>
> ---
>
>  b/mm/vmscan.c |   28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
>
> diff -puN mm/vmscan.c~mm-vmscan-anon-can-be-aged mm/vmscan.c
> --- a/mm/vmscan.c~mm-vmscan-anon-can-be-aged    2021-03-04 15:35:58.935806422 -0800
> +++ b/mm/vmscan.c       2021-03-04 15:35:58.942806422 -0800
> @@ -2517,6 +2517,26 @@ out:
>         }
>  }
>
> +/*
> + * Anonymous LRU management is a waste if there is
> + * ultimately no way to reclaim the memory.
> + */
> +bool anon_should_be_aged(struct lruvec *lruvec)
> +{
> +       struct pglist_data *pgdat = lruvec_pgdat(lruvec);
> +
> +       /* Aging the anon LRU is valuable if swap is present: */
> +       if (total_swap_pages > 0)
> +               return true;
> +
> +       /* Also valuable if anon pages can be demoted: */
> +       if (next_demotion_node(pgdat->node_id) >= 0)
> +               return true;
> +
> +       /* No way to reclaim anon pages.  Should not age anon LRUs: */
> +       return false;
> +}
> +
>  static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
>  {
>         unsigned long nr[NR_LRU_LISTS];
> @@ -2626,7 +2646,8 @@ static void shrink_lruvec(struct lruvec
>          * Even if we did not try to evict anon pages at all, we want to
>          * rebalance the anon lru active/inactive ratio.
>          */
> -       if (total_swap_pages && inactive_is_low(lruvec, LRU_INACTIVE_ANON))
> +       if (anon_should_be_aged(lruvec) &&
> +           inactive_is_low(lruvec, LRU_INACTIVE_ANON))
>                 shrink_active_list(SWAP_CLUSTER_MAX, lruvec,
>                                    sc, LRU_ACTIVE_ANON);
>  }
> @@ -3455,10 +3476,11 @@ static void age_active_anon(struct pglis
>         struct mem_cgroup *memcg;
>         struct lruvec *lruvec;
>
> -       if (!total_swap_pages)
> +       lruvec = mem_cgroup_lruvec(NULL, pgdat);
> +
> +       if (!anon_should_be_aged(lruvec))
>                 return;
>
> -       lruvec = mem_cgroup_lruvec(NULL, pgdat);
>         if (!inactive_is_low(lruvec, LRU_INACTIVE_ANON))
>                 return;
>
> _
>
