Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B433900A2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 14:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbhEYMQ3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 May 2021 08:16:29 -0400
Received: from mail-vs1-f51.google.com ([209.85.217.51]:33442 "EHLO
        mail-vs1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbhEYMQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 08:16:28 -0400
Received: by mail-vs1-f51.google.com with SMTP id f11so15921334vst.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 05:14:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pj56aY4Xje2/XFsPgSAam4CDwlt4HgBOWFt6/S6iUKs=;
        b=PgqbXiUNiXNq3x8ZR+vsOgR5H0Cv9FEcsrVwkkn9YZY1znar7SJxoeY+AYASFHkI4S
         muutCbWldYh9xV/tkYInB9iynNqNK76V6kUyGnQOszNzHzlSPa61+Y44NC23wQZe0w0a
         LXQVl3yPL9ez09UcyLMMs3frYQPHTWeH3z1bS8S2EhhOe6kVXkZQnYzoVrb3hpmhB6B9
         kDyW/d6NRPpIIveMQ48C7eRw08IDSp9XOnppmWFhh0TFr0v5EL3vjc3WBKWI49LXct67
         J1z38+VwbN1H4M0ALZvaSJ9BoVM6UBMl2MrMfpJpD1hYLPyF7tNFSwamUOsHq8iVsPqI
         LZrg==
X-Gm-Message-State: AOAM532rlFFfHCBmV96VXPqCVgId+p/hLRuk7HVUh/vqFNJT8NITM+GO
        P0M9GX8DAv/Tik5HVl0Blwyq7QjE0x21Qrcp3P0=
X-Google-Smtp-Source: ABdhPJw69r9WZwqAnuuPcSMgjRDTgE4SyU38WoEYw6XDTcu4hGID4MT3/v4F0poCDmkco+PPrHJSvaIVnQ83pUctBE4=
X-Received: by 2002:a67:3c2:: with SMTP id 185mr25394841vsd.42.1621944897583;
 Tue, 25 May 2021 05:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210430082850.462609-1-sunnanyong@huawei.com> <20210430082850.462609-5-sunnanyong@huawei.com>
In-Reply-To: <20210430082850.462609-5-sunnanyong@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 May 2021 14:14:45 +0200
Message-ID: <CAMuHMdWxQO1ik_-On3qZMN9+r8V8YMgfg2EArxiMDvoHQRo=+g@mail.gmail.com>
Subject: Re: [PATCH -next 4/4] riscv: mm: add THP support on 64-bit
To:     Nanyong Sun <sunnanyong@huawei.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, palmerdabbelt@google.com,
        atish.patra@wdc.com, wangkefeng.wang@huawei.com,
        Jisheng Zhang <jszhang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nanyong,

On Fri, Apr 30, 2021 at 9:58 AM Nanyong Sun <sunnanyong@huawei.com> wrote:
> Bring Transparent HugePage support to riscv. A
> transparent huge page is always represented as a pmd.
>
> Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>

Thanks for your patch, which is now commit e88b333142e4aba7 ("riscv:
mm: add THP support on 64-bit") in riscv/for-next.

> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h

> @@ -438,6 +459,141 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
>         return ptep_test_and_clear_young(vma, address, ptep);
>  }
>
> +/*
> + * THP functions
> + */
> +static inline pmd_t pte_pmd(pte_t pte)
> +{
> +       return __pmd(pte_val(pte));
> +}
> +
> +static inline pmd_t pmd_mkhuge(pmd_t pmd)
> +{
> +       return pmd;
> +}
> +
> +static inline pmd_t pmd_mkinvalid(pmd_t pmd)
> +{
> +       return __pmd(pmd_val(pmd) & ~(_PAGE_PRESENT|_PAGE_PROT_NONE));
> +}
> +
> +#define __pmd_to_phys(pmd)  (pmd_val(pmd) >> _PAGE_PFN_SHIFT << PAGE_SHIFT)
> +
> +static inline unsigned long pmd_pfn(pmd_t pmd)s
> +{
> +       return ((__pmd_to_phys(pmd) & PMD_MASK) >> PAGE_SHIFT);
> +}
> +
> +static inline pmd_t mk_pmd(struct page *page, pgprot_t prot)
> +{
> +       return pfn_pmd(page_to_pfn(page), prot);
> +}
> +
> +static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
> +{
> +       return pte_pmd(pte_modify(pmd_pte(pmd), newprot));
> +}
> +
> +#define pmd_write pmd_write
> +static inline int pmd_write(pmd_t pmd)
> +{
> +       return pte_write(pmd_pte(pmd));
> +}
> +
> +static inline int pmd_dirty(pmd_t pmd)
> +{
> +       return pte_dirty(pmd_pte(pmd));
> +}
> +
> +static inline int pmd_young(pmd_t pmd)
> +{
> +       return pte_young(pmd_pte(pmd));
> +}
> +
> +static inline pmd_t pmd_mkold(pmd_t pmd)
> +{
> +       return pte_pmd(pte_mkold(pmd_pte(pmd)));
> +}
> +
> +static inline pmd_t pmd_mkyoung(pmd_t pmd)
> +{
> +       return pte_pmd(pte_mkyoung(pmd_pte(pmd)));
> +}
> +
> +static inline pmd_t pmd_mkwrite(pmd_t pmd)
> +{
> +       return pte_pmd(pte_mkwrite(pmd_pte(pmd)));
> +}
> +
> +static inline pmd_t pmd_wrprotect(pmd_t pmd)
> +{
> +       return pte_pmd(pte_wrprotect(pmd_pte(pmd)));
> +}
> +
> +static inline pmd_t pmd_mkclean(pmd_t pmd)
> +{
> +       return pte_pmd(pte_mkclean(pmd_pte(pmd)));
> +}
> +
> +static inline pmd_t pmd_mkdirty(pmd_t pmd)
> +{
> +       return pte_pmd(pte_mkdirty(pmd_pte(pmd)));
> +}
> +
> +static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
> +                               pmd_t *pmdp, pmd_t pmd)
> +{
> +       return set_pte_at(mm, addr, (pte_t *)pmdp, pmd_pte(pmd));
> +}

This conflicts with the existing definition recently added in commit
756a8896b6166bba ("riscv: mremap speedup - enable HAVE_MOVE_PUD and
HAVE_MOVE_PMD"):

    arch/riscv/include/asm/pgtable.h:579:20: error: redefinition of ‘set_pmd_at’
      579 | static inline void set_pmd_at(struct mm_struct *mm,
unsigned long addr,
          |                    ^~~~~~~~~~
    arch/riscv/include/asm/pgtable.h:420:20: note: previous definition
of ‘set_pmd_at’ was here
      420 | static inline void set_pmd_at(struct mm_struct *mm,
unsigned long addr,
          |                    ^~~~~~~~~~

> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +static inline int pmd_trans_huge(pmd_t pmd)
> +{
> +       return pmd_leaf(pmd);
> +}
> +
> +#define __HAVE_ARCH_PMDP_SET_ACCESS_FLAGS
> +static inline int pmdp_set_access_flags(struct vm_area_struct *vma,
> +                                       unsigned long address, pmd_t *pmdp,
> +                                       pmd_t entry, int dirty)
> +{
> +       return ptep_set_access_flags(vma, address, (pte_t *)pmdp, pmd_pte(entry), dirty);
> +}
> +
> +#define __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
> +static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
> +                                       unsigned long address, pmd_t *pmdp)
> +{
> +       return ptep_test_and_clear_young(vma, address, (pte_t *)pmdp);
> +}
> +
> +#define __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR
> +static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
> +                                       unsigned long address, pmd_t *pmdp)
> +{
> +       return pte_pmd(ptep_get_and_clear(mm, address, (pte_t *)pmdp));
> +}
> +
> +#define __HAVE_ARCH_PMDP_SET_WRPROTECT
> +static inline void pmdp_set_wrprotect(struct mm_struct *mm,
> +                                       unsigned long address, pmd_t *pmdp)
> +{
> +       ptep_set_wrprotect(mm, address, (pte_t *)pmdp);
> +}
> +
> +#define pmdp_establish pmdp_establish
> +static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
> +                               unsigned long address, pmd_t *pmdp, pmd_t pmd)
> +{
> +       return __pmd(atomic_long_xchg((atomic_long_t *)pmdp, pmd_val(pmd)));
> +}
> +
> +#define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
> +void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
> +                       unsigned long end);
> +
> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> +
>  /*
>   * Encode and decode a swap entry
>   *

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
