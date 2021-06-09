Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400EB3A1B57
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 18:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbhFIQ7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 12:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbhFIQ7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 12:59:18 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C008C061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 09:57:09 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id my49so22776894ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 09:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TXctnUYixoW0A/kJEo058WpwAtJZAbBXZy8bod3hZqo=;
        b=aJpEJemzXe9mmmp7movvi/u3bQ0GX+CyhJKtIyTe8HFVlJuhVHVSsJyMbd067xhWaz
         QoADZkt+SwCaKbFMsZ9E3QX2nE7I0HjNve5jRUgkwsS5x+t2yID3rUPXpIJ0ZZMgW8lV
         FFCjuK+ZkiVMP3Ydq1BsFgb5A8lmXZxcgNUJkmMXPwS/NREFrSaqkbocDsiQGQwE+pSG
         s4FALIuOKdjvRiUw9pKwLRuFQR3UhohZ6BFxF55HXslpiq9OZsOcTUSIBeQnbg6pUJJe
         U9M28iqBeXQi5NQg++xfbdyhENrKG2n0pavjohzHrZyRtgDI4dbkSjGkPYB+ag+nZlDe
         JjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TXctnUYixoW0A/kJEo058WpwAtJZAbBXZy8bod3hZqo=;
        b=c3yybRWi1EK+pXxS5tHyHLfyE/1sw2K7ZyYWd0367GQKsK8iEf8sK/RxQgKtSGOjo9
         qx5BncqL8PYD7cvb3w2KBS+/b++rS/Xmpj0xEhO/wlbqSBH1yZsdJIeAJDX3IDAjTN1z
         nKCBHdkULooEqxjprMqp2pryz0F0iNkMIyzroDPmKHJjMVDQw/+IkzpFnnKgkKdTiZJ/
         7bG/LtOkX+V82MBl7cZq8gq64ojBTkywOyLXmVwlUjMSlZ5qZxQtmbqiA4fz3RCuwzM1
         LuVLD7M1VaQtiD8kDtQUzPpeLgWFaIQPiNGOXUGGUHISpU8xVVg9esMgYhGe9tdHshzB
         MZwA==
X-Gm-Message-State: AOAM532So/b/h177ccgSWGGcYQLUzwS9Mn8JTPU1yXO+cW0l4G98L7KN
        B+49zI2FqmlRUqubyS03vO86TViLCVwIlVzd+Xk=
X-Google-Smtp-Source: ABdhPJwey1Dlg5RCU3SyaIskut7J7lFnzQGcirn5ooBTwEQCse7phCzoOqEQUZZzTbd1/4H23fV0X6jO8OLY2T1TwCE=
X-Received: by 2002:a17:906:e2d6:: with SMTP id gr22mr815795ejb.514.1623257827601;
 Wed, 09 Jun 2021 09:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <af88612-1473-2eaa-903-8d1a448b26@google.com> <21ea9ca-a1f5-8b90-5e88-95fb1c49bbfa@google.com>
In-Reply-To: <21ea9ca-a1f5-8b90-5e88-95fb1c49bbfa@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 9 Jun 2021 09:56:55 -0700
Message-ID: <CAHbLzkqFba6c7=PM39sPqBdZyc+Yqp=9v2SxdwWM-4Z946ZsRw@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] mm/thp: make is_huge_zero_pmd() safe and quicker
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
        Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 8, 2021 at 9:08 PM Hugh Dickins <hughd@google.com> wrote:
>
> Most callers of is_huge_zero_pmd() supply a pmd already verified present;
> but a few (notably zap_huge_pmd()) do not - it might be a pmd migration
> entry, in which the pfn is encoded differently from a present pmd: which
> might pass the is_huge_zero_pmd() test (though not on x86, since L1TF
> forced us to protect against that); or perhaps even crash in pmd_page()
> applied to a swap-like entry.
>
> Make it safe by adding pmd_present() check into is_huge_zero_pmd() itself;
> and make it quicker by saving huge_zero_pfn, so that is_huge_zero_pmd()
> will not need to do that pmd_page() lookup each time.
>
> __split_huge_pmd_locked() checked pmd_trans_huge() before: that worked,
> but is unnecessary now that is_huge_zero_pmd() checks present.
>
> Fixes: e71769ae5260 ("mm: enable thp migration for shmem thp")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: <stable@vger.kernel.org>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
> Patch added (replacing part of first) since the v1 series was posted.
>
>  include/linux/huge_mm.h | 8 +++++++-
>  mm/huge_memory.c        | 5 ++++-
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 9626fda5efce..2a8ebe6c222e 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -286,6 +286,7 @@ struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
>  vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t orig_pmd);
>
>  extern struct page *huge_zero_page;
> +extern unsigned long huge_zero_pfn;
>
>  static inline bool is_huge_zero_page(struct page *page)
>  {
> @@ -294,7 +295,7 @@ static inline bool is_huge_zero_page(struct page *page)
>
>  static inline bool is_huge_zero_pmd(pmd_t pmd)
>  {
> -       return is_huge_zero_page(pmd_page(pmd));
> +       return READ_ONCE(huge_zero_pfn) == pmd_pfn(pmd) && pmd_present(pmd);
>  }
>
>  static inline bool is_huge_zero_pud(pud_t pud)
> @@ -440,6 +441,11 @@ static inline bool is_huge_zero_page(struct page *page)
>         return false;
>  }
>
> +static inline bool is_huge_zero_pmd(pmd_t pmd)
> +{
> +       return false;
> +}
> +
>  static inline bool is_huge_zero_pud(pud_t pud)
>  {
>         return false;
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 42cfefc6e66e..5885c5f5836f 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -62,6 +62,7 @@ static struct shrinker deferred_split_shrinker;
>
>  static atomic_t huge_zero_refcount;
>  struct page *huge_zero_page __read_mostly;
> +unsigned long huge_zero_pfn __read_mostly = ~0UL;
>
>  bool transparent_hugepage_enabled(struct vm_area_struct *vma)
>  {
> @@ -98,6 +99,7 @@ static bool get_huge_zero_page(void)
>                 __free_pages(zero_page, compound_order(zero_page));
>                 goto retry;
>         }
> +       WRITE_ONCE(huge_zero_pfn, page_to_pfn(zero_page));
>
>         /* We take additional reference here. It will be put back by shrinker */
>         atomic_set(&huge_zero_refcount, 2);
> @@ -147,6 +149,7 @@ static unsigned long shrink_huge_zero_page_scan(struct shrinker *shrink,
>         if (atomic_cmpxchg(&huge_zero_refcount, 1, 0) == 1) {
>                 struct page *zero_page = xchg(&huge_zero_page, NULL);
>                 BUG_ON(zero_page == NULL);
> +               WRITE_ONCE(huge_zero_pfn, ~0UL);
>                 __free_pages(zero_page, compound_order(zero_page));
>                 return HPAGE_PMD_NR;
>         }
> @@ -2071,7 +2074,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>                 return;
>         }
>
> -       if (pmd_trans_huge(*pmd) && is_huge_zero_pmd(*pmd)) {
> +       if (is_huge_zero_pmd(*pmd)) {
>                 /*
>                  * FIXME: Do we want to invalidate secondary mmu by calling
>                  * mmu_notifier_invalidate_range() see comments below inside
> --
> 2.26.2
>
