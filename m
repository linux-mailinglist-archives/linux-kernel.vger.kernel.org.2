Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60C23081A2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 00:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbhA1XAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 18:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhA1XAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 18:00:32 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD17C061573
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 14:59:52 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id q9so6864484ilo.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 14:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dFJK6skzuv7WXL1ehM9px+SpSijJRgTs+lbhkcv3Vog=;
        b=NzFG7U82hXos2rAvu/Y6qtDnklian0fVaMNUWqOxbUz0oM08ttRJicraUpiQwHspeu
         s45uzx8MWE5yNCVJYoQ+yUSyet3/0PISXQlHGBPVNPT/zryqT9dX4ttjMFO8kCH64xQg
         9YOtuO9rVRB4PJPJNuZhX6MSFZGNUuHz2svBm8MR+nii/k5O+XhNU9vghAD6D9T030lN
         bVTWpTmXP7ZTCZJH8ESoxDF1L1mnhAPNFxX2zvowIcg7qphSLCJ8oyGhC7v0tEXn9CXy
         MEe5bhqWk+5xbuU+SZYG5zcNjUFY8vv5ClR1ButcvLUhGQLlJ1Tw5V1s40+w2yzKMom0
         F4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dFJK6skzuv7WXL1ehM9px+SpSijJRgTs+lbhkcv3Vog=;
        b=tfhHdzkL12cdzXmwkK3X61DmzMP6GzWdSDyvRXifa3PhbuESnPfvN5QVRs7GZe+bx/
         icWPwX7/Hor3sgm2z7w7IJhd6Vd4raddb5WXS8Oy8RjA4DSeoYjhS9blX4yAZ+2El4Rn
         27EZ6Xsb7UWg5GYOpZl0nINYn+fwzad4iJLkBoljzcC5mOnZsg/umpv7bAyIgGNavX4Y
         TOZxgTw5Fx3MXpO7xk0SGXswGUhBMZYygKxQ47O6+pdU5TXh1Yq6XH42QrsSxQrCKotC
         TvNuksIspz1Mh4Zu4wfj9aXhEpcOa7m6FbDvgleoQfumv1zpMBstloMuGlW5gL/gHcad
         iDzg==
X-Gm-Message-State: AOAM5337/eI/Bkoxt8g8fuwPxMPkeW0a9Lezqn75BzS91+gKnryQRpXE
        HQCCd9NgCvIutg4VHqXkUYED0hiG4R3R0kkpmZ+IQA==
X-Google-Smtp-Source: ABdhPJwg9DhcaTdssPKIzqgWNSLTg025jyZtrXvlChKpmMe6YmfcJXMZpz3WCx7Fz/m5RSIu7O0An9aTHLLDurlyH5E=
X-Received: by 2002:a92:358a:: with SMTP id c10mr1085037ilf.258.1611874791399;
 Thu, 28 Jan 2021 14:59:51 -0800 (PST)
MIME-Version: 1.0
References: <20210115170907.24498-1-peterx@redhat.com> <20210115170907.24498-22-peterx@redhat.com>
In-Reply-To: <20210115170907.24498-22-peterx@redhat.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 28 Jan 2021 14:59:13 -0800
Message-ID: <CAJHvVcg4tjgRis=WF77phGC6Xm=DBo1W5pDa_d0ZP-Df1VXRxw@mail.gmail.com>
Subject: Re: [PATCH RFC 21/30] hugetlb: Pass vma into huge_pte_alloc()
To:     Peter Xu <peterx@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 9:09 AM Peter Xu <peterx@redhat.com> wrote:
>
> It is a preparation work to be able to behave differently in the per
> architecture huge_pte_alloc() according to different VMA attributes.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/arm64/mm/hugetlbpage.c   | 2 +-
>  arch/ia64/mm/hugetlbpage.c    | 3 ++-
>  arch/mips/mm/hugetlbpage.c    | 4 ++--
>  arch/parisc/mm/hugetlbpage.c  | 2 +-
>  arch/powerpc/mm/hugetlbpage.c | 3 ++-
>  arch/s390/mm/hugetlbpage.c    | 2 +-
>  arch/sh/mm/hugetlbpage.c      | 2 +-
>  arch/sparc/mm/hugetlbpage.c   | 2 +-
>  include/linux/hugetlb.h       | 2 +-
>  mm/hugetlb.c                  | 6 +++---
>  mm/userfaultfd.c              | 2 +-
>  11 files changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 55ecf6de9ff7..5b32ec888698 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -252,7 +252,7 @@ void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr,
>                 set_pte(ptep, pte);
>  }
>
> -pte_t *huge_pte_alloc(struct mm_struct *mm,
> +pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>                       unsigned long addr, unsigned long sz)
>  {
>         pgd_t *pgdp;
> diff --git a/arch/ia64/mm/hugetlbpage.c b/arch/ia64/mm/hugetlbpage.c
> index b331f94d20ac..f993cb36c062 100644
> --- a/arch/ia64/mm/hugetlbpage.c
> +++ b/arch/ia64/mm/hugetlbpage.c
> @@ -25,7 +25,8 @@ unsigned int hpage_shift = HPAGE_SHIFT_DEFAULT;
>  EXPORT_SYMBOL(hpage_shift);
>
>  pte_t *
> -huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz)
> +huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
> +              unsigned long addr, unsigned long sz)
>  {
>         unsigned long taddr = htlbpage_to_page(addr);
>         pgd_t *pgd;
> diff --git a/arch/mips/mm/hugetlbpage.c b/arch/mips/mm/hugetlbpage.c
> index 77ffece9c270..c1d8f51c5255 100644
> --- a/arch/mips/mm/hugetlbpage.c
> +++ b/arch/mips/mm/hugetlbpage.c
> @@ -21,8 +21,8 @@
>  #include <asm/tlb.h>
>  #include <asm/tlbflush.h>
>
> -pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr,
> -                     unsigned long sz)
> +pte_t *huge_pte_alloc(struct mm_struct *mm, structt vm_area_struct *vma,

This was pointed out to me just after I sent v3 of my series today
(which includes this patch):

Typo, s/structt/struct/.

> +                     unsigned long addr, unsigned long sz)
>  {
>         pgd_t *pgd;
>         p4d_t *p4d;
> diff --git a/arch/parisc/mm/hugetlbpage.c b/arch/parisc/mm/hugetlbpage.c
> index d7ba014a7fbb..e141441bfa64 100644
> --- a/arch/parisc/mm/hugetlbpage.c
> +++ b/arch/parisc/mm/hugetlbpage.c
> @@ -44,7 +44,7 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>  }
>
>
> -pte_t *huge_pte_alloc(struct mm_struct *mm,
> +pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>                         unsigned long addr, unsigned long sz)
>  {
>         pgd_t *pgd;
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index 36c3800769fb..2514884c0d20 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -106,7 +106,8 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
>   * At this point we do the placement change only for BOOK3S 64. This would
>   * possibly work on other subarchs.
>   */
> -pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz)
> +pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
> +                     unsigned long addr, unsigned long sz)
>  {
>         pgd_t *pg;
>         p4d_t *p4;
> diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
> index 3b5a4d25ca9b..da36d13ffc16 100644
> --- a/arch/s390/mm/hugetlbpage.c
> +++ b/arch/s390/mm/hugetlbpage.c
> @@ -189,7 +189,7 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
>         return pte;
>  }
>
> -pte_t *huge_pte_alloc(struct mm_struct *mm,
> +pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>                         unsigned long addr, unsigned long sz)
>  {
>         pgd_t *pgdp;
> diff --git a/arch/sh/mm/hugetlbpage.c b/arch/sh/mm/hugetlbpage.c
> index 220d7bc43d2b..999ab5916e69 100644
> --- a/arch/sh/mm/hugetlbpage.c
> +++ b/arch/sh/mm/hugetlbpage.c
> @@ -21,7 +21,7 @@
>  #include <asm/tlbflush.h>
>  #include <asm/cacheflush.h>
>
> -pte_t *huge_pte_alloc(struct mm_struct *mm,
> +pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>                         unsigned long addr, unsigned long sz)
>  {
>         pgd_t *pgd;
> diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
> index ec423b5f17dd..ae06f7df9750 100644
> --- a/arch/sparc/mm/hugetlbpage.c
> +++ b/arch/sparc/mm/hugetlbpage.c
> @@ -272,7 +272,7 @@ static unsigned long huge_tte_to_size(pte_t pte)
>         return size;
>  }
>
> -pte_t *huge_pte_alloc(struct mm_struct *mm,
> +pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>                         unsigned long addr, unsigned long sz)
>  {
>         pgd_t *pgd;
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index fe1dde0afbaf..7d4c5669e118 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -162,7 +162,7 @@ extern struct list_head huge_boot_pages;
>
>  /* arch callbacks */
>
> -pte_t *huge_pte_alloc(struct mm_struct *mm,
> +pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>                         unsigned long addr, unsigned long sz);
>  pte_t *huge_pte_offset(struct mm_struct *mm,
>                        unsigned long addr, unsigned long sz);
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 18b236bac6cd..eb7cd0c7d6d2 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3767,7 +3767,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>                 src_pte = huge_pte_offset(src, addr, sz);
>                 if (!src_pte)
>                         continue;
> -               dst_pte = huge_pte_alloc(dst, addr, sz);
> +               dst_pte = huge_pte_alloc(dst, vma, addr, sz);
>                 if (!dst_pte) {
>                         ret = -ENOMEM;
>                         break;
> @@ -4484,7 +4484,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>          */
>         mapping = vma->vm_file->f_mapping;
>         i_mmap_lock_read(mapping);
> -       ptep = huge_pte_alloc(mm, haddr, huge_page_size(h));
> +       ptep = huge_pte_alloc(mm, vma, haddr, huge_page_size(h));
>         if (!ptep) {
>                 i_mmap_unlock_read(mapping);
>                 return VM_FAULT_OOM;
> @@ -5407,7 +5407,7 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
>  #endif /* CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
>
>  #ifdef CONFIG_ARCH_WANT_GENERAL_HUGETLB
> -pte_t *huge_pte_alloc(struct mm_struct *mm,
> +pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>                         unsigned long addr, unsigned long sz)
>  {
>         pgd_t *pgd;
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 480d91b783d4..3d49b888e3e8 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -291,7 +291,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
>                 mutex_lock(&hugetlb_fault_mutex_table[hash]);
>
>                 err = -ENOMEM;
> -               dst_pte = huge_pte_alloc(dst_mm, dst_addr, vma_hpagesize);
> +               dst_pte = huge_pte_alloc(dst_mm, dst_vma, dst_addr, vma_hpagesize);
>                 if (!dst_pte) {
>                         mutex_unlock(&hugetlb_fault_mutex_table[hash]);
>                         i_mmap_unlock_read(mapping);
> --
> 2.26.2
>
