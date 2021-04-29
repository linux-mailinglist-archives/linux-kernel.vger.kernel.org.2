Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8394536EF37
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 19:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240989AbhD2R4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 13:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbhD2R4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 13:56:12 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB45C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 10:55:25 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id d14so15796898edc.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 10:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PHY0KopoGt2jmHwl+eKZ+gMG2i1OKFgtzB7nz2g7rXM=;
        b=P43Ohrzl+8R4swusRNtAj4tOcBohHPeMOuDQJJcu2LXIqHfAsaQzh0ZIHMsbbrqOJn
         QsA1cZ1OUw6iw3pY1xKvaKelStWOLTKY/hC6UgG9I0VIk4zp9PmPFaN7DoQ63eVdPTu0
         veQbdWc2W+ufXQDy3/CzlEl+pshky3b1TAbafFm2ApD7wvNbQkCNQUh5o0y0DmS/ZCtW
         KEu0djbE6FPsfu7HRzV5+2gNQUQCbzSaMiwO2B7Jn568aK4l8zMe3cpP6BNUP44qsfNp
         L7NbqJ0YgOj58B20Jj1EP7qP2U1rkKlMEHDl+a4IwQVdE0LRUAN5QA1sSTcTM/x0EQhG
         e6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PHY0KopoGt2jmHwl+eKZ+gMG2i1OKFgtzB7nz2g7rXM=;
        b=HsouKgi20Y4Mm/8OsGx6bWK5eD3R42zJGwfrpw0qLS15az6NOF2Su67o6ypJqwgdmY
         oAx3jK0b8urqmYtjZmi0P7LS3ho1eIkAG11H19wNvjXCtWL4Dx/Laqlwb3iil0j7QEZj
         GDeDRQh4A62HtOAA7YnN+lqpZAMXxgdG4ApylzrcfWTKmYIbTtEglKnZhrKgJnj7H+VP
         bk9qAMb6qX7nZQnZ/d9bkVHYN70bfdO/KD9SyuSfCMxiJFY5l8uTLYcthq1fuo4ZInLd
         rjmjGE0J9Pu1vm6wMdJtvil/ONf5xNpsxswsHtiUFQS+0klJC8K/V1kHuoCzpb/eXEI+
         QZ/Q==
X-Gm-Message-State: AOAM532/bMqcWEc3n9Fr9w2NjCyIR1Q4ZiZQOD/pW6EIR9i9vfV8hX1R
        MULSV5Qwf0QXkV3NFw8EW2MGDDIZ4sJWbdFftJA=
X-Google-Smtp-Source: ABdhPJzb6RRhFjjAr4kXAzFrvemYzwT/kPxG+lWrqfmjA0xnzpUWx8Vcas5k4b7bm7r2HNA1W8mxdmEjsAon22PGF6I=
X-Received: by 2002:aa7:d658:: with SMTP id v24mr985550edr.290.1619718924045;
 Thu, 29 Apr 2021 10:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210429132648.305447-1-linmiaohe@huawei.com> <20210429132648.305447-5-linmiaohe@huawei.com>
In-Reply-To: <20210429132648.305447-5-linmiaohe@huawei.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 29 Apr 2021 10:55:12 -0700
Message-ID: <CAHbLzkr2o1xjY4sHFPMv=vZm9Dysu+YJkaiab9AtJd9FcZJ5sg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] mm/huge_memory.c: remove unnecessary
 tlb_remove_page_size() for huge zero pmd
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
        william.kucharski@oracle.com, Matthew Wilcox <willy@infradead.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        aneesh.kumar@linux.ibm.com, Ralph Campbell <rcampbell@nvidia.com>,
        Song Liu <songliubraving@fb.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Minchan Kim <minchan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 6:27 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> Commit aa88b68c3b1d ("thp: keep huge zero page pinned until tlb flush")
> introduced tlb_remove_page() for huge zero page to keep it pinned until
> flush is complete and prevents the page from being split under us. But
> huge zero page is kept pinned until all relevant mm_users reach zero since
> the commit 6fcb52a56ff6 ("thp: reduce usage of huge zero page's atomic
> counter"). So tlb_remove_page_size() for huge zero pmd is unnecessary now.

By reading the git history, it seems the lifecycle of huge zero page
is bound to process instead of page table due to the latter commit.
The patch looks correct to me. Reviewed-by: Yang Shi
<shy828301@gmail.com>

>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/huge_memory.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index e24a96de2e37..af30338ac49c 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1680,12 +1680,9 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>                 if (arch_needs_pgtable_deposit())
>                         zap_deposited_table(tlb->mm, pmd);
>                 spin_unlock(ptl);
> -               if (is_huge_zero_pmd(orig_pmd))
> -                       tlb_remove_page_size(tlb, pmd_page(orig_pmd), HPAGE_PMD_SIZE);
>         } else if (is_huge_zero_pmd(orig_pmd)) {
>                 zap_deposited_table(tlb->mm, pmd);
>                 spin_unlock(ptl);
> -               tlb_remove_page_size(tlb, pmd_page(orig_pmd), HPAGE_PMD_SIZE);
>         } else {
>                 struct page *page = NULL;
>                 int flush_needed = 1;
> --
> 2.23.0
>
>
