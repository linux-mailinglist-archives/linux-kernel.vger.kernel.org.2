Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC69415AA5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 11:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240082AbhIWJO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 05:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239801AbhIWJO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 05:14:58 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A92C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 02:13:26 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id q11so15092417wrr.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 02:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uX3J9dkEPi/fez/1522JWdBVkRaD5hHK1YkH0F9Smc8=;
        b=LFd9SAE9iXhVOt7KcdDLVxmbbRntIXu2lgB334V/xMETAhlO7WVrIXVb5QfX+hiL0v
         UdVFJOrRz03qnDBkCRaicbO6exJ5FGA7TkKZYTpSwDtwsjROkqOGclHm992iu7r6Up6w
         BY2+WZAeJtIPBePFe2StErE2tilqNcBZb5vLUeJn8XFCYsWt1v/Q8Laj0X47aODwNhn9
         dvWcYZDS6jJcXeUfk0os9kxp7cDlWJ/GbRXC6eUr+m+gsx87iX4GQ/mXT8UDrTfXt7Yu
         ctZDbgws9kpFH0y/RAzHwyFyaAPLN2BXJU6cK+zSIJqRXoIkfOvmYuuEMxfAV32qd4dp
         oHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uX3J9dkEPi/fez/1522JWdBVkRaD5hHK1YkH0F9Smc8=;
        b=hXDSdYlnuHwYsj3yAIFD8vjTRZStCPhnM7FLjWZl5sDzsIX5H2QdUigLpnDr6QFItF
         gjq5adrKJqSdNhppXBAO7F2EsCxFBNjAAyzVOyXJndQ/mvGrQjb0CW3EC9s2RKpyKoey
         g00jary8OpsnhB4JMDee5xBilfKB/axg4IBHFq893zBiGIGPAGlS0ca4XOfWgu9chtqn
         LlgpNX2bHFbPUDO80D6E1qQUAxh2B15s5EqW99KyJzpt6FI+O+CT/NyuiHgoCPA2WoME
         EdAPdkta61qvvyMEib4wUqaFHgxiluf8ApgSZtOjHHpLPfFBkMbI5sveqsjChUbM3Gqx
         f3Kw==
X-Gm-Message-State: AOAM532XXmJ11kQGqmyomInd3pQv73p5QgdapH3Nq2VxvthGjmcqIh8B
        +afKSIKtMl7DfVB4C7T3BbuEmGDPZCX+W5xTgEYUIg==
X-Google-Smtp-Source: ABdhPJwEV7Qk2/eNtDyb0n3QcvlCBnvlPMBLz3KQpzB848Tbp/nFSwzYG+HlLjJmfMI4qtvaTxnz4HPCKJdEOPsDaVY=
X-Received: by 2002:a7b:cc14:: with SMTP id f20mr3234210wmh.137.1632388405395;
 Thu, 23 Sep 2021 02:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210923072716.913826-1-guoren@kernel.org>
In-Reply-To: <20210923072716.913826-1-guoren@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 23 Sep 2021 14:43:14 +0530
Message-ID: <CAAhSdy3S4iH7U-4BR-pS6aQrxRZKBfYT7vyTwYmFDePpe810kQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: Add RISC-V svpbmt extension
To:     Guo Ren <guoren@kernel.org>
Cc:     Anup Patel <anup.patel@wdc.com>, Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Christoph Hellwig <hch@lst.de>,
        liush <liush@allwinnertech.com>, wefu@redhat.com,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        taiten.peng@canonical.com, aniket.ponkshe@canonical.com,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        gordan.markus@canonical.com, Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Lustig <dlustig@nvidia.com>,
        Greg Favor <gfavor@ventanamicro.com>,
        Andrea Mondelli <andrea.mondelli@huawei.com>,
        Jonathan Behrens <behrensj@mit.edu>,
        Xinhaoqu <xinhaoqu@huawei.com>,
        Bill Huffman <huffman@cadence.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Allen Baum <allen.baum@esperantotech.com>,
        Josh Scheid <jscheid@ventanamicro.com>,
        Richard Trauben <rtrauben@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 12:57 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> This patch follows the standard pure RISC-V Svpbmt extension in
> privilege spec to solve the non-coherent SOC dma synchronization
> issues.
>
> Here is the svpbmt PTE format:
> | 63 | 62-61 | 60-8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
>   N     MT     RSW    D   A   G   U   X   W   R   V
>         ^
>
> Of the Reserved bits [63:54] in a leaf PTE, the high bit is already
> allocated (as the N bit), so bits [62:61] are used as the MT (aka
> MemType) field. This field specifies one of three memory types that
> are close equivalents (or equivalent in effect) to the three main x86
> and ARMv8 memory types - as shown in the following table.
>
> RISC-V
> Encoding &
> MemType     RISC-V Description
> ----------  ------------------------------------------------
> 00 - PMA    Normal Cacheable, No change to implied PMA memory type
> 01 - NC     Non-cacheable, idempotent, weakly-ordered Main Memory
> 10 - IO     Non-cacheable, non-idempotent, strongly-ordered I/O memory
> 11 - Rsvd   Reserved for future standard use
>
> The standard protection_map [] needn't be modified because the "PMA"
> type keeps the highest bits zero. The standard protection_map[] needn't
> be modified. So the whole modification is in the arch/riscv pgtable and
> using a global variable (__riscv_svpbmt) in the _PAGE_DMA_MASK/IO/NC
> for pgprot_noncached (&writecombine). We also need _PAGE_CHG_MASK to
> detect PFN than before.
>
> Devicetree: reuse "mmu-type" of cpu_section as a user interface to
> enable the feature or not:
>  - riscv,sv39,svpbmt
>  - riscv,sv48,svpbmt
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Liu Shaohua <liush@allwinnertech.com>
> Cc: Wei Fu <wefu@redhat.com>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Anup Patel <anup.patel@wdc.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Atish Patra <atish.patra@wdc.com>
> Cc: Drew Fustini <drew@beagleboard.org>
> Cc: Wei Fu <wefu@redhat.com>
> Cc: Wei Wu <lazyparser@gmail.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Maxime Ripard <maxime@cerno.tech>
> Cc: Daniel Lustig <dlustig@nvidia.com>
> Cc: Greg Favor <gfavor@ventanamicro.com>
> Cc: Andrea Mondelli <andrea.mondelli@huawei.com>
> Cc: Jonathan Behrens <behrensj@mit.edu>
> Cc: Xinhaoqu (Freddie) <xinhaoqu@huawei.com>
> Cc: Bill Huffman <huffman@cadence.com>
> Cc: Nick Kossifidis <mick@ics.forth.gr>
> Cc: Allen Baum <allen.baum@esperantotech.com>
> Cc: Josh Scheid <jscheid@ventanamicro.com>
> Cc: Richard Trauben <rtrauben@gmail.com>
> ---
>  .../devicetree/bindings/riscv/cpus.yaml       |  2 +
>  arch/riscv/include/asm/fixmap.h               |  2 +-
>  arch/riscv/include/asm/pgtable-64.h           |  8 ++--
>  arch/riscv/include/asm/pgtable-bits.h         | 46 ++++++++++++++++++-
>  arch/riscv/include/asm/pgtable.h              | 39 ++++++++++++----
>  arch/riscv/include/asm/processor.h            |  1 +
>  arch/riscv/kernel/cpufeature.c                | 23 ++++++++++
>  arch/riscv/kernel/setup.c                     |  2 +
>  arch/riscv/mm/init.c                          |  5 ++
>  9 files changed, 113 insertions(+), 15 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> index e534f6a7cfa1..1825cd8db0de 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -56,7 +56,9 @@ properties:
>      enum:
>        - riscv,sv32
>        - riscv,sv39
> +      - riscv,sv39,svpbmt
>        - riscv,sv48
> +      - riscv,sv48,svpbmt
>        - riscv,none

I think augmenting the "mmu-type" DT property is a good approach but the
description of "mmu-type" DT property needs to say:

"Identifies the MMU address translation mode and page based memory
type used on ..."

Also, DT bindings change is generally a separate patch so better to make
a separate patch for this.

>
>    riscv,isa:
> diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
> index 54cbf07fb4e9..5acd99d08e74 100644
> --- a/arch/riscv/include/asm/fixmap.h
> +++ b/arch/riscv/include/asm/fixmap.h
> @@ -43,7 +43,7 @@ enum fixed_addresses {
>         __end_of_fixed_addresses
>  };
>
> -#define FIXMAP_PAGE_IO         PAGE_KERNEL
> +#define FIXMAP_PAGE_IO         PAGE_IOREMAP
>
>  #define __early_set_fixmap     __set_fixmap
>
> diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
> index 228261aa9628..0b53ea67e91a 100644
> --- a/arch/riscv/include/asm/pgtable-64.h
> +++ b/arch/riscv/include/asm/pgtable-64.h
> @@ -61,12 +61,14 @@ static inline void pud_clear(pud_t *pudp)
>
>  static inline pmd_t *pud_pgtable(pud_t pud)
>  {
> -       return (pmd_t *)pfn_to_virt(pud_val(pud) >> _PAGE_PFN_SHIFT);
> +       return (pmd_t *)pfn_to_virt((pud_val(pud) & _PAGE_CHG_MASK)
> +                                               >> _PAGE_PFN_SHIFT);
>  }
>
>  static inline struct page *pud_page(pud_t pud)
>  {
> -       return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
> +       return pfn_to_page((pud_val(pud) & _PAGE_CHG_MASK)
> +                                               >> _PAGE_PFN_SHIFT);
>  }
>
>  static inline pmd_t pfn_pmd(unsigned long pfn, pgprot_t prot)
> @@ -76,7 +78,7 @@ static inline pmd_t pfn_pmd(unsigned long pfn, pgprot_t prot)
>
>  static inline unsigned long _pmd_pfn(pmd_t pmd)
>  {
> -       return pmd_val(pmd) >> _PAGE_PFN_SHIFT;
> +       return (pmd_val(pmd) & _PAGE_CHG_MASK) >> _PAGE_PFN_SHIFT;
>  }
>
>  #define mk_pmd(page, prot)    pfn_pmd(page_to_pfn(page), prot)
> diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
> index 2ee413912926..041fe4fdbafa 100644
> --- a/arch/riscv/include/asm/pgtable-bits.h
> +++ b/arch/riscv/include/asm/pgtable-bits.h
> @@ -7,7 +7,7 @@
>  #define _ASM_RISCV_PGTABLE_BITS_H
>
>  /*
> - * PTE format:
> + * rv32 PTE format:
>   * | XLEN-1  10 | 9             8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
>   *       PFN      reserved for SW   D   A   G   U   X   W   R   V
>   */
> @@ -24,6 +24,47 @@
>  #define _PAGE_DIRTY     (1 << 7)    /* Set by hardware on any write */
>  #define _PAGE_SOFT      (1 << 8)    /* Reserved for software */
>
> +#ifndef __ASSEMBLY__
> +#ifdef CONFIG_64BIT
> +/*
> + * rv64 PTE format:
> + * | 63 | 62 61 | 60 54 | 53  10 | 9             8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
> + *   N      MT     RSV    PFN      reserved for SW   D   A   G   U   X   W   R   V
> + * [62:61] Memory Type definitions:
> + *  00 - PMA    Normal Cacheable, No change to implied PMA memory type
> + *  01 - NC     Non-cacheable, idempotent, weakly-ordered Main Memory
> + *  10 - IO     Non-cacheable, non-idempotent, strongly-ordered I/O memory
> + *  11 - Rsvd   Reserved for future standard use
> + */
> +#define _PAGE_MT_MASK          ((u64)0x3 << 61)
> +#define _PAGE_MT_PMA           ((u64)0x0 << 61)
> +#define _PAGE_MT_NC            ((u64)0x1 << 61)
> +#define _PAGE_MT_IO            ((u64)0x2 << 61)
> +
> +enum {
> +       MT_PMA,
> +       MT_NC,
> +       MT_IO,
> +       MT_MAX
> +};
> +
> +extern struct __riscv_svpbmt_struct {
> +       unsigned long mask;
> +       unsigned long mt[MT_MAX];
> +} __riscv_svpbmt;
> +
> +#define _PAGE_DMA_MASK         __riscv_svpbmt.mask
> +#define _PAGE_DMA_PMA          __riscv_svpbmt.mt[MT_PMA]
> +#define _PAGE_DMA_NC           __riscv_svpbmt.mt[MT_NC]
> +#define _PAGE_DMA_IO           __riscv_svpbmt.mt[MT_IO]
> +#else
> +#define _PAGE_DMA_MASK         0
> +#define _PAGE_DMA_PMA          0
> +#define _PAGE_DMA_NC           0
> +#define _PAGE_DMA_IO           0
> +#endif /* CONFIG_64BIT */
> +#endif /* __ASSEMBLY__ */
> +
>  #define _PAGE_SPECIAL   _PAGE_SOFT
>  #define _PAGE_TABLE     _PAGE_PRESENT
>
> @@ -38,7 +79,8 @@
>  /* Set of bits to preserve across pte_modify() */
>  #define _PAGE_CHG_MASK  (~(unsigned long)(_PAGE_PRESENT | _PAGE_READ | \
>                                           _PAGE_WRITE | _PAGE_EXEC |    \
> -                                         _PAGE_USER | _PAGE_GLOBAL))
> +                                         _PAGE_USER | _PAGE_GLOBAL |   \
> +                                         _PAGE_DMA_MASK))
>  /*
>   * when all of R/W/X are zero, the PTE is a pointer to the next level
>   * of the page table; otherwise, it is a leaf PTE.
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 39b550310ec6..d07ba586c866 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -136,7 +136,8 @@
>                                 | _PAGE_PRESENT \
>                                 | _PAGE_ACCESSED \
>                                 | _PAGE_DIRTY \
> -                               | _PAGE_GLOBAL)
> +                               | _PAGE_GLOBAL \
> +                               | _PAGE_DMA_PMA)
>
>  #define PAGE_KERNEL            __pgprot(_PAGE_KERNEL)
>  #define PAGE_KERNEL_READ       __pgprot(_PAGE_KERNEL & ~_PAGE_WRITE)
> @@ -146,11 +147,9 @@
>
>  #define PAGE_TABLE             __pgprot(_PAGE_TABLE)
>
> -/*
> - * The RISC-V ISA doesn't yet specify how to query or modify PMAs, so we can't
> - * change the properties of memory regions.
> - */
> -#define _PAGE_IOREMAP _PAGE_KERNEL
> +#define _PAGE_IOREMAP  ((_PAGE_KERNEL & ~_PAGE_DMA_MASK) | _PAGE_DMA_IO)
> +
> +#define PAGE_IOREMAP           __pgprot(_PAGE_IOREMAP)
>
>  extern pgd_t swapper_pg_dir[];
>
> @@ -230,12 +229,12 @@ static inline unsigned long _pgd_pfn(pgd_t pgd)
>
>  static inline struct page *pmd_page(pmd_t pmd)
>  {
> -       return pfn_to_page(pmd_val(pmd) >> _PAGE_PFN_SHIFT);
> +       return pfn_to_page((pmd_val(pmd) & _PAGE_CHG_MASK) >> _PAGE_PFN_SHIFT);
>  }
>
>  static inline unsigned long pmd_page_vaddr(pmd_t pmd)
>  {
> -       return (unsigned long)pfn_to_virt(pmd_val(pmd) >> _PAGE_PFN_SHIFT);
> +       return (unsigned long)pfn_to_virt((pmd_val(pmd) & _PAGE_CHG_MASK) >> _PAGE_PFN_SHIFT);
>  }
>
>  static inline pte_t pmd_pte(pmd_t pmd)
> @@ -251,7 +250,7 @@ static inline pte_t pud_pte(pud_t pud)
>  /* Yields the page frame number (PFN) of a page table entry */
>  static inline unsigned long pte_pfn(pte_t pte)
>  {
> -       return (pte_val(pte) >> _PAGE_PFN_SHIFT);
> +       return ((pte_val(pte) & _PAGE_CHG_MASK) >> _PAGE_PFN_SHIFT);
>  }
>
>  #define pte_page(x)     pfn_to_page(pte_pfn(x))
> @@ -490,6 +489,28 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
>         return ptep_test_and_clear_young(vma, address, ptep);
>  }
>
> +#define pgprot_noncached pgprot_noncached
> +static inline pgprot_t pgprot_noncached(pgprot_t _prot)
> +{
> +       unsigned long prot = pgprot_val(_prot);
> +
> +       prot &= ~_PAGE_DMA_MASK;
> +       prot |= _PAGE_DMA_IO;
> +
> +       return __pgprot(prot);
> +}
> +
> +#define pgprot_writecombine pgprot_writecombine
> +static inline pgprot_t pgprot_writecombine(pgprot_t _prot)
> +{
> +       unsigned long prot = pgprot_val(_prot);
> +
> +       prot &= ~_PAGE_DMA_MASK;
> +       prot |= _PAGE_DMA_NC;
> +
> +       return __pgprot(prot);
> +}
> +
>  /*
>   * THP functions
>   */
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> index 021ed64ee608..92676156cbf6 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -70,6 +70,7 @@ struct device_node;
>  int riscv_of_processor_hartid(struct device_node *node);
>  int riscv_of_parent_hartid(struct device_node *node);
>
> +extern void riscv_svpbmt(void);

You can drop this change.

>  extern void riscv_fill_hwcap(void);
>  extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
>
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index d959d207a40d..4a2211c2c464 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -8,6 +8,7 @@
>
>  #include <linux/bitmap.h>
>  #include <linux/of.h>
> +#include <linux/pgtable.h>
>  #include <asm/processor.h>
>  #include <asm/hwcap.h>
>  #include <asm/smp.h>
> @@ -59,6 +60,28 @@ bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, int bit)
>  }
>  EXPORT_SYMBOL_GPL(__riscv_isa_extension_available);
>
> +void __init riscv_svpbmt(void)

Make this static function and call it from riscv_fill_hwcap().

> +{
> +#ifdef CONFIG_64BIT
> +       struct device_node *node;
> +       const char *str;
> +
> +       for_each_of_cpu_node(node) {
> +               if (of_property_read_string(node, "mmu-type", &str)) {
> +                       continue;
> +               }
> +
> +               if (!strncmp(str + 11, "svpbmt", 6)) {
> +                       __riscv_svpbmt.mask       = _PAGE_MT_MASK;
> +                       __riscv_svpbmt.mt[MT_PMA] = _PAGE_MT_PMA;
> +                       __riscv_svpbmt.mt[MT_NC]  = _PAGE_MT_NC;
> +                       __riscv_svpbmt.mt[MT_IO]  = _PAGE_MT_IO;
> +                       break;
> +               }

I don't agree with this loop.

The __riscv_svpbmt should be updated only when all CPU nodes
have "svpmbt" in the "mmu-type" DT property.

> +       }
> +#endif
> +}
> +
>  void __init riscv_fill_hwcap(void)
>  {
>         struct device_node *node;
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 120b2f6f71bc..e7457113b45e 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -294,6 +294,8 @@ void __init setup_arch(char **cmdline_p)
>         setup_smp();
>  #endif
>
> +       riscv_svpbmt();
> +

You can drop this change based on above comment.

>         riscv_fill_hwcap();
>  }
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 7cb4f391d106..43b2e11fd3e0 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -905,3 +905,8 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>         return vmemmap_populate_basepages(start, end, node, NULL);
>  }
>  #endif
> +
> +#ifdef CONFIG_64BIT
> +struct __riscv_svpbmt_struct __riscv_svpbmt __ro_after_init;
> +EXPORT_SYMBOL(__riscv_svpbmt);
> +#endif
> --
> 2.25.1
>

Appending "svpmb" suffix to "mmu-type" breaks print_mmu()
in arch/riscv/kernel/cpu.c. Please update that as well.

We will also need couple of Tested-by for existing boards.

Regards,
Anup
