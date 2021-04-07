Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B39C35770A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 23:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbhDGVky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 17:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbhDGVkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 17:40:52 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74928C061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 14:40:42 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u21so30049639ejo.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 14:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xcr7lkbzXaoQQpjftuqW3C9GNiBJ/UK2Pd0JhhADfVc=;
        b=jBIJI4CajgIYTLrsGgHZPCltrspIBa9ahPXL/098Ibl5qMITduKF13NU/xadSZUgsM
         O1YNdcqhimuxaPNp019e4WXYfA1NppYy9HdRf2pDugPB8pPUjgZyPbmK/0ghJmkNhm7F
         EgDFbX8l2jlZ43QCH8pyx0clmmhB1jkCqzhXwhUL0GuxPMdDR6+0f7J6Mr1XIOCMrs0Z
         e9xXvn6axD8MSguM8kbutN45Ffd4DlNyEeOb19t1FweGN+lcll2hi7yk5qoLHl1uV9Vi
         YBMcJjHJAkCl7h8F8KQzCTvX29hhrJnZH/61TTzy++MturPeVrdPfVCg0BcbMretMnSG
         rp0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xcr7lkbzXaoQQpjftuqW3C9GNiBJ/UK2Pd0JhhADfVc=;
        b=V2hvn1Lj3IR+45hBSvaKy+4lxo9QYm7dEdgIQsoGJk8AwU07h0+hP6OZs49nFXwBBH
         PhBmz8PgtCgje10pmvWJpYNdQBqBUwgOCMGtlceOPQzQL80bywsW8Is1TGmiFxjW6TKZ
         GwkKfw92fFevTzGs/lnEZVTZXAOg5MGY1T5/9qXoj1XYV/FMQjafMBsYDF3kumv2ILRJ
         AfTCv+2viSNEavsdy+OleJAfDclxvk7RFOW5OVg5bw3KMxJsrmi8lpyhNfREZUfEW4uN
         NB/k7X2CKzbBb1IIcl8ojoK2aR/ap5rxU5+HGImd7Fic6hcfz6yEk7zi1HuqL6TDGri9
         mhEA==
X-Gm-Message-State: AOAM533X2tu6a1tBWC21paHs5LZpJub6Igdrse3+rA6MnU4FXPLN+wHq
        pUdhR5mAKbqXCrS6mSAf0FJvk6AXhudb8qb3nRE=
X-Google-Smtp-Source: ABdhPJwOotE1A406II6Ivvxrg18GdLK2JisXrwWSKVKOsx9wZKJHxA/9CIGYdc+gv/hPf8GUJpeo5ZxcVr98wKeKhhs=
X-Received: by 2002:a17:906:4bce:: with SMTP id x14mr6056959ejv.383.1617831641231;
 Wed, 07 Apr 2021 14:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210407030548.189104-1-yanfei.xu@windriver.com> <20210407030548.189104-2-yanfei.xu@windriver.com>
In-Reply-To: <20210407030548.189104-2-yanfei.xu@windriver.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 7 Apr 2021 14:40:29 -0700
Message-ID: <CAHbLzkqicptMUAVU+Xc_gfRwXU5hTDjGFhrYo5kuWPkEZK++rw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: khugepaged: use macro to align addresses
To:     yanfei.xu@windriver.com
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 6, 2021 at 8:06 PM <yanfei.xu@windriver.com> wrote:
>
> From: Yanfei Xu <yanfei.xu@windriver.com>
>
> We could use macro to deal with the addresses which need to be aligned
> to improve readability of codes.

Reviewed-by: Yang Shi <shy828301@gmail.com>

>
> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
> ---
>  mm/khugepaged.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index a7d6cb912b05..a6012b9259a2 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -517,8 +517,8 @@ int khugepaged_enter_vma_merge(struct vm_area_struct *vma,
>         if (!hugepage_vma_check(vma, vm_flags))
>                 return 0;
>
> -       hstart = (vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK;
> -       hend = vma->vm_end & HPAGE_PMD_MASK;
> +       hstart = ALIGN(vma->vm_start, HPAGE_PMD_SIZE);
> +       hend = ALIGN_DOWN(vma->vm_end, HPAGE_PMD_SIZE);
>         if (hstart < hend)
>                 return khugepaged_enter(vma, vm_flags);
>         return 0;
> @@ -979,8 +979,8 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
>         if (!vma)
>                 return SCAN_VMA_NULL;
>
> -       hstart = (vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK;
> -       hend = vma->vm_end & HPAGE_PMD_MASK;
> +       hstart = ALIGN(vma->vm_start, HPAGE_PMD_SIZE);
> +       hend = ALIGN_DOWN(vma->vm_end, HPAGE_PMD_SIZE);
>         if (address < hstart || address + HPAGE_PMD_SIZE > hend)
>                 return SCAN_ADDRESS_RANGE;
>         if (!hugepage_vma_check(vma, vma->vm_flags))
> @@ -1070,7 +1070,7 @@ static void collapse_huge_page(struct mm_struct *mm,
>         struct mmu_notifier_range range;
>         gfp_t gfp;
>
> -       VM_BUG_ON(address & ~HPAGE_PMD_MASK);
> +       VM_BUG_ON(!IS_ALIGNED(address, HPAGE_PMD_SIZE));
>
>         /* Only allocate from the target node */
>         gfp = alloc_hugepage_khugepaged_gfpmask() | __GFP_THISNODE;
> @@ -1235,7 +1235,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
>         int node = NUMA_NO_NODE, unmapped = 0;
>         bool writable = false;
>
> -       VM_BUG_ON(address & ~HPAGE_PMD_MASK);
> +       VM_BUG_ON(!IS_ALIGNED(address, HPAGE_PMD_SIZE));
>
>         pmd = mm_find_pmd(mm, address);
>         if (!pmd) {
> @@ -1414,7 +1414,7 @@ static int khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
>  {
>         struct mm_slot *mm_slot;
>
> -       VM_BUG_ON(addr & ~HPAGE_PMD_MASK);
> +       VM_BUG_ON(!IS_ALIGNED(addr, HPAGE_PMD_SIZE));
>
>         spin_lock(&khugepaged_mm_lock);
>         mm_slot = get_mm_slot(mm);
> @@ -1437,7 +1437,7 @@ static int khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
>   */
>  void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
>  {
> -       unsigned long haddr = addr & HPAGE_PMD_MASK;
> +       unsigned long haddr = ALIGN_DOWN(addr, HPAGE_PMD_SIZE);
>         struct vm_area_struct *vma = find_vma(mm, haddr);
>         struct page *hpage;
>         pte_t *start_pte, *pte;
> @@ -1584,7 +1584,7 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
>                 if (vma->anon_vma)
>                         continue;
>                 addr = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
> -               if (addr & ~HPAGE_PMD_MASK)
> +               if (!IS_ALIGNED(addr, HPAGE_PMD_SIZE))
>                         continue;
>                 if (vma->vm_end < addr + HPAGE_PMD_SIZE)
>                         continue;
> @@ -2070,7 +2070,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
>  {
>         struct mm_slot *mm_slot;
>         struct mm_struct *mm;
> -       struct vm_area_struct *vma;
> +       struct vm_area_struct *vma = NULL;
>         int progress = 0;
>
>         VM_BUG_ON(!pages);
> @@ -2092,7 +2092,6 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
>          * Don't wait for semaphore (to avoid long wait times).  Just move to
>          * the next mm on the list.
>          */
> -       vma = NULL;
>         if (unlikely(!mmap_read_trylock(mm)))
>                 goto breakouterloop_mmap_lock;
>         if (likely(!khugepaged_test_exit(mm)))
> @@ -2112,15 +2111,15 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
>                         progress++;
>                         continue;
>                 }
> -               hstart = (vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK;
> -               hend = vma->vm_end & HPAGE_PMD_MASK;
> +               hstart = ALIGN(vma->vm_start, HPAGE_PMD_SIZE);
> +               hend = ALIGN_DOWN(vma->vm_end, HPAGE_PMD_SIZE);
>                 if (hstart >= hend)
>                         goto skip;
>                 if (khugepaged_scan.address > hend)
>                         goto skip;
>                 if (khugepaged_scan.address < hstart)
>                         khugepaged_scan.address = hstart;
> -               VM_BUG_ON(khugepaged_scan.address & ~HPAGE_PMD_MASK);
> +               VM_BUG_ON(!IS_ALIGNED(khugepaged_scan.address, HPAGE_PMD_SIZE));
>                 if (shmem_file(vma->vm_file) && !shmem_huge_enabled(vma))
>                         goto skip;
>
> --
> 2.27.0
>
