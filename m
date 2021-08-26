Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2303F81CB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 06:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238155AbhHZEtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 00:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhHZEsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 00:48:55 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A37C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 21:48:09 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id w6so1027162plg.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 21:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=CVByhjP1i2oA1KBEUJykBzcIy3uSqCrwHbgIyy+OMWM=;
        b=zhQLVwXtUQ1F9xPIqwJobzGM3h5hp6Kb+jAqR0TufspBhPHjmVsD+AGl+hG/tYR4S0
         LeADLT1tE+KRKccHrTnRTbTAvwjXEkHM8RT2b3peDV1kyJ243rn8yDekCV/Qsd8dAGQq
         ndSBRt8LHCjXK131bSl7A4HgruAK5pNgjiNYHCVovnYjEPvQzTknX/2XuQ9uMo4XC/xd
         xIN7YAx5mAIPCXP8wwVvnD5GI7aVu9w5hnqyJn1sfPsrWjK3plgphoKn3wQ7qxhzgHSe
         sny85sDvMCZ9gZh9akVe7bXNh5clX+Amj8nHwO4mGXDK2poM77d+SKYpjToRrs5iUGJX
         4BBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=CVByhjP1i2oA1KBEUJykBzcIy3uSqCrwHbgIyy+OMWM=;
        b=MmkBSgZwiV002Wb+6gecuSV8GrvsUkfyZXppBJyOQxJiZgrrWBHQHcqjguQb9LH7Gv
         Q1hYKbjmY8YHIwh4AlxSB5yLbLlqC8T4O2EZk+ImqmIEj7g5RSE6mExV+JaA1PyMSEns
         hsR8YVeFwgYvmzwkRDRvoespgK5IKYTmIKqowUr5kysIiWsHVlmeUl5GdDJD2r8pWOHd
         gkjz6mtMSvqnuT4KDVTM9SDe2/neVu+ZZE4OLScXvnr0pS1SreS7USWZi3IEWVS+KCAl
         pYx9kIW2yRSTuReYdmI40tZi40XrMeRc5W8UHMfRO8lGSmyTjNL54vrWzErUXNeu0bvj
         qGVA==
X-Gm-Message-State: AOAM5336VCmapt5JU1ase65+ynGdEFz73XVdUIIbPnpVI+BwCiH/N2q+
        CcdWKli7I8Q6frwpOpV7U88ZCA==
X-Google-Smtp-Source: ABdhPJwW/hCGfEDMPcpzaroks8UhmWJ1z7TQk2gskjWvpBtS/EGSHzKUSsDiTTWuk0fFJ3MUQWGHMA==
X-Received: by 2002:a17:902:f552:b029:12d:3d11:4ff1 with SMTP id h18-20020a170902f552b029012d3d114ff1mr1709114plf.1.1629953288396;
        Wed, 25 Aug 2021 21:48:08 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id q3sm1655685pgf.18.2021.08.25.21.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 21:48:07 -0700 (PDT)
Date:   Wed, 25 Aug 2021 21:48:07 -0700 (PDT)
X-Google-Original-Date: Wed, 25 Aug 2021 21:48:03 PDT (-0700)
Subject:     Re: [PATCH -next] riscv: Enable HAVE_ARCH_HUGE_VMAP for 64BIT
In-Reply-To: <20210805113837.805805-1-liushixin2@huawei.com>
CC:     corbet@lwn.net, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        liushixin2@huawei.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     liushixin2@huawei.com
Message-ID: <mhng-57cbc077-dfa6-48a7-a29d-b27862e1e800@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Aug 2021 04:38:37 PDT (-0700), liushixin2@huawei.com wrote:
> This sets the HAVE_ARCH_HUGE_VMAP option. Enable pmd vmap support and
> define the required page table functions(Currently, riscv has only
> three-level page tables support for 64BIT).
>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  .../features/vm/huge-vmap/arch-support.txt    |  2 +-
>  arch/riscv/Kconfig                            |  1 +
>  arch/riscv/include/asm/vmalloc.h              | 12 +++++
>  arch/riscv/mm/Makefile                        |  1 +
>  arch/riscv/mm/pgtable.c                       | 53 +++++++++++++++++++
>  5 files changed, 68 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/mm/pgtable.c
>
> diff --git a/Documentation/features/vm/huge-vmap/arch-support.txt b/Documentation/features/vm/huge-vmap/arch-support.txt
> index 439fd9069b8b..0ff394acc9cf 100644
> --- a/Documentation/features/vm/huge-vmap/arch-support.txt
> +++ b/Documentation/features/vm/huge-vmap/arch-support.txt
> @@ -22,7 +22,7 @@
>      |    openrisc: | TODO |
>      |      parisc: | TODO |
>      |     powerpc: |  ok  |
> -    |       riscv: | TODO |
> +    |       riscv: |  ok  |
>      |        s390: | TODO |
>      |          sh: | TODO |
>      |       sparc: | TODO |
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 8fcceb8eda07..94cc2a254773 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -61,6 +61,7 @@ config RISCV
>  	select GENERIC_TIME_VSYSCALL if MMU && 64BIT
>  	select HANDLE_DOMAIN_IRQ
>  	select HAVE_ARCH_AUDITSYSCALL
> +	select HAVE_ARCH_HUGE_VMAP if MMU && 64BIT
>  	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
>  	select HAVE_ARCH_JUMP_LABEL_RELATIVE if !XIP_KERNEL
>  	select HAVE_ARCH_KASAN if MMU && 64BIT
> diff --git a/arch/riscv/include/asm/vmalloc.h b/arch/riscv/include/asm/vmalloc.h
> index ff9abc00d139..8f17f421f80c 100644
> --- a/arch/riscv/include/asm/vmalloc.h
> +++ b/arch/riscv/include/asm/vmalloc.h
> @@ -1,4 +1,16 @@
>  #ifndef _ASM_RISCV_VMALLOC_H
>  #define _ASM_RISCV_VMALLOC_H
>
> +#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
> +
> +#define IOREMAP_MAX_ORDER (PMD_SHIFT)
> +
> +#define arch_vmap_pmd_supported	arch_vmap_pmd_supported
> +static inline bool __init arch_vmap_pmd_supported(pgprot_t prot)
> +{
> +	return true;
> +}
> +
> +#endif
> +
>  #endif /* _ASM_RISCV_VMALLOC_H */
> diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
> index 7ebaef10ea1b..f932b4d69946 100644
> --- a/arch/riscv/mm/Makefile
> +++ b/arch/riscv/mm/Makefile
> @@ -13,6 +13,7 @@ obj-y += extable.o
>  obj-$(CONFIG_MMU) += fault.o pageattr.o
>  obj-y += cacheflush.o
>  obj-y += context.o
> +obj-y += pgtable.o
>
>  ifeq ($(CONFIG_MMU),y)
>  obj-$(CONFIG_SMP) += tlbflush.o
> diff --git a/arch/riscv/mm/pgtable.c b/arch/riscv/mm/pgtable.c
> new file mode 100644
> index 000000000000..f68dd2b71dce
> --- /dev/null
> +++ b/arch/riscv/mm/pgtable.c
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <asm/pgalloc.h>
> +#include <linux/gfp.h>
> +#include <linux/kernel.h>
> +#include <linux/pgtable.h>
> +
> +#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
> +
> +int pud_set_huge(pud_t *pud, phys_addr_t phys, pgprot_t prot)
> +{
> +	return 0;
> +}
> +
> +int pud_clear_huge(pud_t *pud)
> +{
> +	return 0;
> +}
> +
> +int pud_free_pmd_page(pud_t *pud, unsigned long addr)
> +{
> +	return 0;
> +}

Do we actually need the PUD helpers?  I'd prefer to avoid adding these 
unimplemented stubs, IIUC the other architectures are relying on the 
generic implementations (which are themselves stubs) for configurations 
that don't have PUDs.

> +int pmd_set_huge(pmd_t *pmd, phys_addr_t phys, pgprot_t prot)
> +{
> +	pmd_t new_pmd = pfn_pmd(__phys_to_pfn(phys), prot);
> +
> +	set_pmd(pmd, new_pmd);
> +	return 1;
> +}
> +
> +int pmd_clear_huge(pmd_t *pmd)
> +{
> +	if (!pmd_leaf(READ_ONCE(*pmd)))
> +		return 0;
> +	pmd_clear(pmd);
> +	return 1;
> +}
> +
> +int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
> +{
> +	pte_t *pte;
> +
> +	pte = (pte_t *)pmd_page_vaddr(*pmd);
> +	pmd_clear(pmd);
> +
> +	flush_tlb_kernel_range(addr, addr + PMD_SIZE);
> +	pte_free_kernel(NULL, pte);
> +	return 1;
> +}
> +
> +#endif /* CONFIG_HAVE_ARCH_HUGE_VMAP */
