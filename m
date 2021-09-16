Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2674740D3CE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 09:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbhIPHcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 03:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbhIPHcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 03:32:35 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7214FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 00:31:15 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id v10so11130533ybq.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 00:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DcXs9nwGMpt8302ByBmpQcnEcM0HsYv6Y94LXbzwtVc=;
        b=ppev6yIEH8Z4SB0z6juVTgZF69VfLX452de9cyZevggAq3KdjklOFMIV7Je9qih/ig
         avtCmsyAnKLSHmsQK3Dvpot4+zyBO4VXHqTPxvwRQLWKUBMQ1H95jDJTB50y40BrfhBR
         fjMb2rhaYT487pnoZ7uqWXfmX7p6m6U8LmmzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DcXs9nwGMpt8302ByBmpQcnEcM0HsYv6Y94LXbzwtVc=;
        b=W+txQ73RbD+zwUmAW4TtV5z2C1RrnRbliRqEfTHlvNDxVF/ue10MTY7PkC5TbJHt7B
         q3/8L3e4PhseyL4E/su9OAFKh9evTWeQqAOKMdcuACJ2CR+7Vs0ZpZ03FWMmiKAnoAoV
         YzBUFoRF5Zd6aF3b3zjbykjmF3i01nQOk8LkE5NTim1cUYti9ghVvmebCBpwC/N/t6mj
         RGZ+UUF8mbL+BWyRsut5HRjzsplmgwZH3MC0t71HI/yBLdAP8+FbmQxuMXIcq8FUZLQr
         Qhww6BpojvRB0Ikh0H2BBTDFpIa+m+vcxw42O1ui4adBMEvNSXOQS2+79jIGEKW+7Tow
         DK2Q==
X-Gm-Message-State: AOAM5314sdFqjtvvZa7a9Hv83ADGXXygPevc4hzbtbKSUARuCIziWPMp
        JrD+pGjkXfC1JeMi1wnfk3uajLBHRour504s/6XM
X-Google-Smtp-Source: ABdhPJy+tHCf89MBgFXZY23nS+LkuFh3rIIijZdgFtQ81Lr/QewHHscoYH+mid9462cykCA4uU4BJDOpq/69wLVa7Ks=
X-Received: by 2002:a25:f806:: with SMTP id u6mr4778018ybd.341.1631777474207;
 Thu, 16 Sep 2021 00:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210911092139.79607-1-guoren@kernel.org> <20210911092139.79607-3-guoren@kernel.org>
In-Reply-To: <20210911092139.79607-3-guoren@kernel.org>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 16 Sep 2021 00:31:03 -0700
Message-ID: <CAOnJCUJ-xZfa5Mut7LWgVVSAmd-U9hjJsMH082Rsj68WP9drYg@mail.gmail.com>
Subject: Re: [RFC PATCH V4 2/6] riscv: errata: pgtable: Add custom Svpbmt
 supported for Allwinner D1
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

On Sat, Sep 11, 2021 at 2:23 AM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> RISC-V Svpbmt is gradually maturing, the draft is:
>
> Svpbmt PTE format:
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
> But T-HEAD C906 in Allwinner D1 has defined a custom Svpbmt:
>
> T-HEAD C9xx PTE format:
> | 63 | 62 | 61 | 60 | 59-8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
>   SO   C    B    SH   RSW    D   A   G   U   X   W   R   V
>   ^    ^    ^    ^
> BIT(63): SO - Strong Order
> BIT(62): C  - Cacheable
> BIT(61): B  - Bufferable
> BIT(60): SH - Shareable
>
> MT_MASK : [63 - 59]
> MT_PMA  : C + SH
> MT_NC   : (none)
> MT_IO   : SO
>
> The patch not only implements the D1's PBMT extension but also
> considers future scalability by errata framework.
>
> We are trying to keep both below work together:
>  - "riscv spec acceptance policy" (Svpbmt extension in future)
>  - "Linux Keep real hardware work" (Allwinner D1's custom Svpbmt)
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Liu Shaohua <liush@allwinnertech.com>
> Signed-off-by: Wei Fu <wefu@redhat.com>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Anup Patel <anup.patel@wdc.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
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
>  arch/riscv/Kconfig.erratas             | 11 ++++++
>  arch/riscv/errata/Makefile             |  1 +
>  arch/riscv/errata/alternative.c        | 18 ++++++++++
>  arch/riscv/errata/thead/Makefile       |  1 +
>  arch/riscv/errata/thead/errata.c       | 47 ++++++++++++++++++++++++++
>  arch/riscv/include/asm/alternative.h   |  2 ++
>  arch/riscv/include/asm/fixmap.h        |  2 +-
>  arch/riscv/include/asm/pgtable-64.h    |  8 +++--
>  arch/riscv/include/asm/pgtable-bits.h  | 46 +++++++++++++++++++++++--
>  arch/riscv/include/asm/pgtable.h       | 30 ++++++++++------
>  arch/riscv/include/asm/vendorid_list.h |  1 +
>  arch/riscv/mm/init.c                   |  6 ++++
>  12 files changed, 157 insertions(+), 16 deletions(-)
>  create mode 100644 arch/riscv/errata/thead/Makefile
>  create mode 100644 arch/riscv/errata/thead/errata.c
>
> diff --git a/arch/riscv/Kconfig.erratas b/arch/riscv/Kconfig.erratas
> index b44d6ecdb46e..e130fd040494 100644
> --- a/arch/riscv/Kconfig.erratas
> +++ b/arch/riscv/Kconfig.erratas
> @@ -41,4 +41,15 @@ config ERRATA_SIFIVE_CIP_1200
>
>           If you don't know what to do here, say "Y".
>
> +config ERRATA_THEAD
> +       bool "T-HEAD errata"
> +       depends on RISCV_ERRATA_ALTERNATIVE
> +       default y
> +       help
> +         All T-HEAD errata Kconfig depend on this Kconfig. Disabling
> +         this Kconfig will disable all T-HEAD errata. Please say "Y"
> +         here if your platform uses T-HEAD CPU cores.
> +
> +         Otherwise, please say "N" here to avoid unnecessary overhead.
> +
>  endmenu
> diff --git a/arch/riscv/errata/Makefile b/arch/riscv/errata/Makefile
> index b8f8740a3e44..f6db15055e73 100644
> --- a/arch/riscv/errata/Makefile
> +++ b/arch/riscv/errata/Makefile
> @@ -1,2 +1,3 @@
>  obj-y  += alternative.o
>  obj-$(CONFIG_ERRATA_SIFIVE) += sifive/
> +obj-$(CONFIG_ERRATA_THEAD) += thead/
> diff --git a/arch/riscv/errata/alternative.c b/arch/riscv/errata/alternative.c
> index 3b15885db70b..b879aa546bc5 100644
> --- a/arch/riscv/errata/alternative.c
> +++ b/arch/riscv/errata/alternative.c
> @@ -72,3 +72,21 @@ void __init apply_boot_alternatives(void)
>                           cpu_mfr_info.arch_id, cpu_mfr_info.imp_id);
>  }
>
> +/*
> + * This is called very early form setup_vm in the boot process.
> + */
> +void __init apply_errata_setup_vm(void)
> +{
> +       riscv_fill_cpu_mfr_info();
> +
> +       switch (cpu_mfr_info.vendor_id) {
> +#ifdef CONFIG_ERRATA_THEAD
> +       case THEAD_VENDOR_ID:
> +               thead_errata_setup_vm(cpu_mfr_info.arch_id,
> +                                     cpu_mfr_info.imp_id);
> +               break;
> +#endif
> +       default:
> +               break;
> +       }
> +}
> diff --git a/arch/riscv/errata/thead/Makefile b/arch/riscv/errata/thead/Makefile
> new file mode 100644
> index 000000000000..2d644e19caef
> --- /dev/null
> +++ b/arch/riscv/errata/thead/Makefile
> @@ -0,0 +1 @@
> +obj-y += errata.o
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> new file mode 100644
> index 000000000000..1f5c0f82bc23
> --- /dev/null
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/kernel.h>
> +#include <linux/string.h>
> +#include <linux/bug.h>
> +#include <asm/patch.h>
> +#include <asm/alternative.h>
> +#include <asm/vendorid_list.h>
> +#include <asm/errata_list.h>
> +#include <asm/pgtable-bits.h>
> +
> +#ifdef CONFIG_64BIT
> +/*
> + * T-HEAD C9xx PTE format:
> + * | 63 | 62 | 61 | 60 | 59-8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
> + *   SO   C    B    SH   RSW    D   A   G   U   X   W   R   V
> + *   ^    ^    ^    ^    ^
> + * BIT(63): SO - Strong Order
> + * BIT(62): C  - Cacheable
> + * BIT(61): B  - Bufferable
> + * BIT(60): SH - Shareable
> + *
> + * MT_MASK : [63 - 59]
> + * MT_PMA  : C + SH
> + * MT_NC   : (none)
> + * MT_IO   : SO
> + */
> +#undef _PAGE_MT_MASK
> +#undef _PAGE_MT_PMA
> +#undef _PAGE_MT_NC
> +#undef _PAGE_MT_IO
> +
> +#define _PAGE_MT_MASK  0xf800000000000000
> +#define _PAGE_MT_PMA   0x5000000000000000
> +#define _PAGE_MT_NC    0x0
> +#define _PAGE_MT_IO    0x8000000000000000
> +#endif
> +
> +void __init thead_errata_setup_vm(unsigned long archid, unsigned long impid)
> +{
> +#ifdef CONFIG_64BIT
> +       __riscv_pbmt.mask       = _PAGE_MT_MASK;
> +       __riscv_pbmt.mt[MT_PMA] = _PAGE_MT_PMA;
> +       __riscv_pbmt.mt[MT_NC]  = _PAGE_MT_NC;
> +       __riscv_pbmt.mt[MT_IO]  = _PAGE_MT_IO;
> +#endif
> +}
> diff --git a/arch/riscv/include/asm/alternative.h b/arch/riscv/include/asm/alternative.h
> index e625d3cafbed..3605894081a8 100644
> --- a/arch/riscv/include/asm/alternative.h
> +++ b/arch/riscv/include/asm/alternative.h
> @@ -18,6 +18,7 @@
>  #include <asm/hwcap.h>
>
>  void __init apply_boot_alternatives(void);
> +void __init apply_errata_setup_vm(void);
>
>  struct alt_entry {
>         void *old_ptr;           /* address of original instruciton or data  */
> @@ -35,5 +36,6 @@ struct errata_checkfunc_id {
>  void sifive_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
>                               unsigned long archid, unsigned long impid);
>
> +void thead_errata_setup_vm(unsigned long archid, unsigned long impid);
>  #endif
>  #endif
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
> index 2ee413912926..38a33e076714 100644
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
> +extern struct __riscv_pbmt_struct {
> +       unsigned long mask;
> +       unsigned long mt[MT_MAX];
> +} __riscv_pbmt;
> +
> +#define _PAGE_DMA_MASK         __riscv_pbmt.mask
> +#define _PAGE_DMA_PMA          __riscv_pbmt.mt[MT_PMA]
> +#define _PAGE_DMA_NC           __riscv_pbmt.mt[MT_NC]
> +#define _PAGE_DMA_IO           __riscv_pbmt.mt[MT_IO]
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
> index 39b550310ec6..dcde56f2046e 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -115,7 +115,7 @@
>  #define USER_PTRS_PER_PGD   (TASK_SIZE / PGDIR_SIZE)
>
>  /* Page protection bits */
> -#define _PAGE_BASE     (_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_USER)
> +#define _PAGE_BASE     (_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_USER | _PAGE_DMA_PMA)
>
>  #define PAGE_NONE              __pgprot(_PAGE_PROT_NONE)
>  #define PAGE_READ              __pgprot(_PAGE_BASE | _PAGE_READ)
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
> @@ -490,6 +489,17 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
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
>  /*
>   * THP functions
>   */
> diff --git a/arch/riscv/include/asm/vendorid_list.h b/arch/riscv/include/asm/vendorid_list.h
> index 9d934215b3c8..bdfce1a4b42b 100644
> --- a/arch/riscv/include/asm/vendorid_list.h
> +++ b/arch/riscv/include/asm/vendorid_list.h
> @@ -6,5 +6,6 @@
>  #define ASM_VENDOR_LIST_H
>
>  #define SIFIVE_VENDOR_ID       0x489
> +#define  THEAD_VENDOR_ID       0x5b7
>
>  #endif
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 975c7322d6c4..ee6dba4e49b5 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -577,6 +577,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  #ifndef __PAGETABLE_PMD_FOLDED
>         pmd_t fix_bmap_spmd, fix_bmap_epmd;
>  #endif
> +       apply_errata_setup_vm();

We probably should call this only if pbmt extension is present. We
need to dynamically determine
the presence of PBMT anyways because DIRECT_REMAP will be enabled for
all platforms (single defconfig).
We need to think about all the following possible platforms with
different types of cache coherent I/O devices.

1. platform supporting standard PBMT extensions (future ones)
2. platform with custom PBMT extension  (Allwinner D1)
3. platform with uncached window approach (starlight)
4. platform with fully cache coherent IO (hifive unleashed/unmatched)

I think a simple global flag based on a DT property should be
sufficient. DMA generic code may also need to check
if the platform supports direct_remap in addition to checking the
config option.

For the DT property, we should define a generic extensible DT binding
for ISA extensions so that future ISA extensions
should be able to leverage that.

Just food for thought for RISC-V MC at plumbers next week.

>
>         setup_protection_map();
>
> @@ -927,3 +928,8 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>         return vmemmap_populate_basepages(start, end, node, NULL);
>  }
>  #endif
> +
> +#ifdef CONFIG_64BIT
> +struct __riscv_pbmt_struct __riscv_pbmt __ro_after_init;
> +EXPORT_SYMBOL(__riscv_pbmt);
> +#endif
> --
> 2.25.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



--
Regards,
Atish
