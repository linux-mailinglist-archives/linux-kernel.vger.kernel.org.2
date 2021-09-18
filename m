Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141E3410422
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 07:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236543AbhIRFJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 01:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236595AbhIRFJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 01:09:12 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53869C0613D8;
        Fri, 17 Sep 2021 22:07:10 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id c21so37445385edj.0;
        Fri, 17 Sep 2021 22:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UELVW64OGifaAHac3foR5XI65mlaDJfcYXp7k1se3yQ=;
        b=mVodZ0Ytl/BlGYZyd0GWpZDL/5dBZeG8+tWuQDf573eX92F5cAPyOG3e2d6eyxjpTt
         whZ2pCyI/fBSW9woM067wT/HP14ThWqDB+aI1Oug1mEoYosBiOZvk6pEDLAIGEutDmoh
         c/cp7UQCYO6//H2ouhMjuXerDElDTvtL/Or05tvSRRkIYV0W8SXe8e7sejImPM13QPeI
         sfPt45iOPFKs9IAZ1soBHDxJ1f0XOs6n3IPbBQqvbn9cmRnQeWnq3LJ06vO2pbZJsskR
         ljwlNYYiLo+8gjYdcVTAuwepN6TLjKHqWNVfk90pJqi/GPYi4X4pPFE5R+ayB/J58T0H
         dHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UELVW64OGifaAHac3foR5XI65mlaDJfcYXp7k1se3yQ=;
        b=0dIbm9zZCgi4xv/MFY8TZbTeukXkc4X46qJHyKAApg7bdpXMjmYxW6BwRPlHoKYs8l
         wJdyLBUc8bJ6n9Geo59hZcUoI6o1mlo6No1/wiuO82vNEAidnAmmd4/uAO2aJzMRsnt7
         fli1so7BaamzPWLu0NLMsjVKGR/MLDA/a6wKoFktFWfdbEEtjY6vtl23oDei0c0XdVPG
         jK8pdgdGifo1nfNmawWyvRMI8ZMieDc4i4HTRNI3lrMbjU1tcKueNE2y1k/1xRaGSLB8
         AKwKESvLXvl9lKAIarKFKYi57VZseQ8TALUIBHlkCenKM3jrK3QwXJxcHfFvCjqh+z21
         QypQ==
X-Gm-Message-State: AOAM533YFBBFxpMddpMkkGPd8o9kqvUxDUX17aX6UY6+HLKa3T4yvej0
        AnY5yKeI3hGQAMMXpd+58/+k5ySWQ6dJR/y7aSo=
X-Google-Smtp-Source: ABdhPJxaxXTMZhPBf0+ZkOJ27I9Sr9wmiURH3GEowKm/Irh+EpHvO991mZoMS137Rjkz/N5p7vQL5F7pUUWq6PUZJII=
X-Received: by 2002:a17:906:dbe5:: with SMTP id yd5mr16064766ejb.134.1631941629538;
 Fri, 17 Sep 2021 22:07:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210917034815.80264-1-songmuchun@bytedance.com> <20210917034815.80264-4-songmuchun@bytedance.com>
In-Reply-To: <20210917034815.80264-4-songmuchun@bytedance.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Sat, 18 Sep 2021 17:06:58 +1200
Message-ID: <CAGsJ_4yWZTcRqnBmLrYJ3Z1Yo_7oWRgR4B3qK5m570xgpeJ-5Q@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 3/4] mm: sparsemem: use page table lock to
 protect kernel pmd operations
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mike.kravetz@oracle.com, Andrew Morton <akpm@linux-foundation.org>,
        osalvador@suse.de, mhocko@suse.com,
        Barry Song <song.bao.hua@hisilicon.com>, david@redhat.com,
        chenhuang5@huawei.com, bodeddub@amazon.com,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2021 at 12:09 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> The init_mm.page_table_lock is used to protect kernel page tables, we
> can use it to serialize splitting vmemmap PMD mappings instead of mmap
> write lock, which can increase the concurrency of vmemmap_remap_free().
>

Curious what is the actual benefit we get in user scenarios from this patch,
1. we set bootargs to reserve hugetlb statically
2. we "echo" some figures to sys or proc.

In other words, Who is going to care about this concurrency?
Can we have some details on this to put in the commit log?

> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/ptdump.c         | 16 ++++++++++++----
>  mm/sparse-vmemmap.c | 49 ++++++++++++++++++++++++++++++++++---------------
>  2 files changed, 46 insertions(+), 19 deletions(-)
>
> diff --git a/mm/ptdump.c b/mm/ptdump.c
> index da751448d0e4..eea3d28d173c 100644
> --- a/mm/ptdump.c
> +++ b/mm/ptdump.c
> @@ -40,8 +40,10 @@ static int ptdump_pgd_entry(pgd_t *pgd, unsigned long addr,
>         if (st->effective_prot)
>                 st->effective_prot(st, 0, pgd_val(val));
>
> -       if (pgd_leaf(val))
> +       if (pgd_leaf(val)) {
>                 st->note_page(st, addr, 0, pgd_val(val));
> +               walk->action = ACTION_CONTINUE;
> +       }
>
>         return 0;
>  }
> @@ -61,8 +63,10 @@ static int ptdump_p4d_entry(p4d_t *p4d, unsigned long addr,
>         if (st->effective_prot)
>                 st->effective_prot(st, 1, p4d_val(val));
>
> -       if (p4d_leaf(val))
> +       if (p4d_leaf(val)) {
>                 st->note_page(st, addr, 1, p4d_val(val));
> +               walk->action = ACTION_CONTINUE;
> +       }
>
>         return 0;
>  }
> @@ -82,8 +86,10 @@ static int ptdump_pud_entry(pud_t *pud, unsigned long addr,
>         if (st->effective_prot)
>                 st->effective_prot(st, 2, pud_val(val));
>
> -       if (pud_leaf(val))
> +       if (pud_leaf(val)) {
>                 st->note_page(st, addr, 2, pud_val(val));
> +               walk->action = ACTION_CONTINUE;
> +       }
>
>         return 0;
>  }
> @@ -101,8 +107,10 @@ static int ptdump_pmd_entry(pmd_t *pmd, unsigned long addr,
>
>         if (st->effective_prot)
>                 st->effective_prot(st, 3, pmd_val(val));
> -       if (pmd_leaf(val))
> +       if (pmd_leaf(val)) {
>                 st->note_page(st, addr, 3, pmd_val(val));
> +               walk->action = ACTION_CONTINUE;
> +       }
>
>         return 0;
>  }
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index 62e3d20648ce..e636943ccfc4 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -64,8 +64,8 @@ struct vmemmap_remap_walk {
>   */
>  #define NR_RESET_STRUCT_PAGE           3
>
> -static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start,
> -                                 struct vmemmap_remap_walk *walk)
> +static int __split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start,
> +                                   struct vmemmap_remap_walk *walk)
>  {
>         pmd_t __pmd;
>         int i;
> @@ -87,15 +87,37 @@ static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start,
>                 set_pte_at(&init_mm, addr, pte, entry);
>         }
>
> -       /* Make pte visible before pmd. See comment in __pte_alloc(). */
> -       smp_wmb();
> -       pmd_populate_kernel(&init_mm, pmd, pgtable);
> +       spin_lock(&init_mm.page_table_lock);
> +       if (likely(pmd_leaf(*pmd))) {
> +               /* Make pte visible before pmd. See comment in __pte_alloc(). */
> +               smp_wmb();
> +               pmd_populate_kernel(&init_mm, pmd, pgtable);
> +               flush_tlb_kernel_range(start, start + PMD_SIZE);
> +               spin_unlock(&init_mm.page_table_lock);
>
> -       flush_tlb_kernel_range(start, start + PMD_SIZE);
> +               return 0;
> +       }
> +       spin_unlock(&init_mm.page_table_lock);
> +       pte_free_kernel(&init_mm, pgtable);
>
>         return 0;
>  }
>
> +static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start,
> +                                 struct vmemmap_remap_walk *walk)
> +{
> +       int ret;
> +
> +       spin_lock(&init_mm.page_table_lock);
> +       ret = pmd_leaf(*pmd);
> +       spin_unlock(&init_mm.page_table_lock);
> +
> +       if (ret)
> +               ret = __split_vmemmap_huge_pmd(pmd, start, walk);
> +
> +       return ret;
> +}
> +
>  static void vmemmap_pte_range(pmd_t *pmd, unsigned long addr,
>                               unsigned long end,
>                               struct vmemmap_remap_walk *walk)
> @@ -132,13 +154,12 @@ static int vmemmap_pmd_range(pud_t *pud, unsigned long addr,
>
>         pmd = pmd_offset(pud, addr);
>         do {
> -               if (pmd_leaf(*pmd)) {
> -                       int ret;
> +               int ret;
> +
> +               ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK, walk);
> +               if (ret)
> +                       return ret;
>
> -                       ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK, walk);
> -                       if (ret)
> -                               return ret;
> -               }
>                 next = pmd_addr_end(addr, end);
>                 vmemmap_pte_range(pmd, addr, next, walk);
>         } while (pmd++, addr = next, addr != end);
> @@ -321,10 +342,8 @@ int vmemmap_remap_free(unsigned long start, unsigned long end,
>          */
>         BUG_ON(start - reuse != PAGE_SIZE);
>
> -       mmap_write_lock(&init_mm);
> +       mmap_read_lock(&init_mm);
>         ret = vmemmap_remap_range(reuse, end, &walk);
> -       mmap_write_downgrade(&init_mm);
> -
>         if (ret && walk.nr_walked) {
>                 end = reuse + walk.nr_walked * PAGE_SIZE;
>                 /*
> --
> 2.11.0
>

Thanks
barry
