Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005EB3AFFF1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 11:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhFVJML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 05:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhFVJMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 05:12:10 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0AFC061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 02:09:53 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id x22so8575417pll.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 02:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ydvc8Rl7wiGHkzj56eR2KVXaD0RfaW+A51LSajQqcq4=;
        b=g1rAp2Bihui++TbOWNROj8o+aLubfPXZ3PUScW959ZG5twVElrZwvWaluQCF4Est7y
         Vl/ixHVWoiJlMyCH/KSt/31oz/Z9vHSLsxLaAuUPhRGEzqXOwmCVxO3Uh3GdvhvyfrcI
         vq/RWS8s+QlIxCq8iN9kjVBU6qAOJcWgRth+FUYtS+iGm0r6hf50yqUHlWHJC/fQeP5u
         Wh992mbKoH1/dKpHm4BBzJRn7kmVtpVNGKlP67c9+9Ch8Zj7VL+a28aodxdL5ufCVsnR
         PBHRdMGZabz0DXgbrSONevPohFugavyglw4frfBWxJXYkwMaRKz1uygu72Z9oRDuRb2k
         1uIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ydvc8Rl7wiGHkzj56eR2KVXaD0RfaW+A51LSajQqcq4=;
        b=q0mWAP+aolJ/867vx8ls7gmr/9ISchK/J/TwF9MuMCjyon48/Tx99SprLiCcoHuvqp
         6sbpnz8lEq6iYfDlFx/KMwdB+FVwniUrjJaJ8eiM3xmBTdZZVdFuSmAzIztMNCqGDKnQ
         qJ9toiY5H7UiICH/eNkqANGRf+UiK1zitwEMLQCwM9a1YTUmqkb/i/VxTr5Qf9KOGsNF
         UzGmH7xbWh3IPcTy+qsHepy3+qj228Qul+kvysyjD0kJVypLRwny0fPyDa+MDqNY8d+E
         NejZMRW8qaJC01gi6NKpMuMrTyUdFeuyMmDMoS9k1pEGlQB9Ty4WHr41hF/EcPH1vTsy
         IfAg==
X-Gm-Message-State: AOAM531RSjNkwjGQhvkxv8bD9x2vk3uvVhh5u+8rHsJdwQ/TfSC6XN7/
        GzA5u2t7AXYJugBS4+yGA6cAAAijA2J4z02JCV1/Tw==
X-Google-Smtp-Source: ABdhPJxbCIlOoOQgk5yDdp1DjFNkdWnsRIDQST6UuhHQt6UWX5eK79Z59CtP9V6JBOhqTGG4aWUPuHW+BgXT81YTIxI=
X-Received: by 2002:a17:90b:4c8c:: with SMTP id my12mr2891403pjb.13.1624352993336;
 Tue, 22 Jun 2021 02:09:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210622021423.154662-1-mike.kravetz@oracle.com> <20210622021423.154662-2-mike.kravetz@oracle.com>
In-Reply-To: <20210622021423.154662-2-mike.kravetz@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 22 Jun 2021 17:09:14 +0800
Message-ID: <CAMZfGtVqJjVVgG+sd33er8Eg-MieF7V=nVExvQZTFhbxteaCGQ@mail.gmail.com>
Subject: Re: [External] [PATCH 1/2] hugetlb: remove prep_compound_huge_page cleanup
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Youquan Song <youquan.song@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 10:15 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> The routine prep_compound_huge_page is a simple wrapper to call either
> prep_compound_gigantic_page or prep_compound_page.  However, it is only
> called from gather_bootmem_prealloc which only processes gigantic pages.
> Eliminate the routine and call prep_compound_gigantic_page directly.
>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Nice clean-up. Thanks.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

> ---
>  mm/hugetlb.c | 29 ++++++++++-------------------
>  1 file changed, 10 insertions(+), 19 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 760b5fb836b8..50596b7d6da9 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1320,8 +1320,6 @@ static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
>         return alloc_contig_pages(nr_pages, gfp_mask, nid, nodemask);
>  }
>
> -static void prep_new_huge_page(struct hstate *h, struct page *page, int nid);
> -static void prep_compound_gigantic_page(struct page *page, unsigned int order);
>  #else /* !CONFIG_CONTIG_ALLOC */
>  static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
>                                         int nid, nodemask_t *nodemask)
> @@ -2759,16 +2757,10 @@ int __alloc_bootmem_huge_page(struct hstate *h)
>         return 1;
>  }
>
> -static void __init prep_compound_huge_page(struct page *page,
> -               unsigned int order)
> -{
> -       if (unlikely(order > (MAX_ORDER - 1)))
> -               prep_compound_gigantic_page(page, order);
> -       else
> -               prep_compound_page(page, order);
> -}
> -
> -/* Put bootmem huge pages into the standard lists after mem_map is up */
> +/*
> + * Put bootmem huge pages into the standard lists after mem_map is up.
> + * Note: This only applies to gigantic (order > MAX_ORDER) pages.
> + */
>  static void __init gather_bootmem_prealloc(void)
>  {
>         struct huge_bootmem_page *m;
> @@ -2777,20 +2769,19 @@ static void __init gather_bootmem_prealloc(void)
>                 struct page *page = virt_to_page(m);
>                 struct hstate *h = m->hstate;
>
> +               VM_BUG_ON(!hstate_is_gigantic(h));
>                 WARN_ON(page_count(page) != 1);
> -               prep_compound_huge_page(page, huge_page_order(h));
> +               prep_compound_gigantic_page(page, huge_page_order(h));
>                 WARN_ON(PageReserved(page));
>                 prep_new_huge_page(h, page, page_to_nid(page));
>                 put_page(page); /* free it into the hugepage allocator */
>
>                 /*
> -                * If we had gigantic hugepages allocated at boot time, we need
> -                * to restore the 'stolen' pages to totalram_pages in order to
> -                * fix confusing memory reports from free(1) and another
> -                * side-effects, like CommitLimit going negative.
> +                * We need to restore the 'stolen' pages to totalram_pages
> +                * in order to fix confusing memory reports from free(1) and
> +                * other side-effects, like CommitLimit going negative.
>                  */
> -               if (hstate_is_gigantic(h))
> -                       adjust_managed_page_count(page, pages_per_huge_page(h));
> +               adjust_managed_page_count(page, pages_per_huge_page(h));
>                 cond_resched();
>         }
>  }
> --
> 2.31.1
>
