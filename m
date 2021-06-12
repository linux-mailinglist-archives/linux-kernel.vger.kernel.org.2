Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3678A3A4FD2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 18:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhFLRBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 13:01:22 -0400
Received: from mail-pj1-f52.google.com ([209.85.216.52]:39755 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbhFLRBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 13:01:21 -0400
Received: by mail-pj1-f52.google.com with SMTP id w14-20020a17090aea0eb029016e9e0e7983so1091222pjy.4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 09:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=BkJ9VfaVDWckj1qLY318bk4f+lp9IhMIKatyOGiiDZQ=;
        b=gHWhfC/FFvWaZ0SZAUGyB42W55ECJuwoOO3WjN+Qv9Uk6bua9/Z7werOn2eP+RgQ5p
         VihbNPczLeWWaHWl5zEed2Q7saGu50ju0beRqZZ72s/1/xJEugRzA+GntXI+r4U4V4dE
         xlWnWGLH0L74JSQbrkNoThogBTml3nCJkyNEyrmP22YFJph4jFgjauJGfXSNZ2FUffs4
         JSylKfqNfua3tzTzvGYBWYmunmg6vWQoLGGRgjUyofmv0J5HbNMi0pRC1wYk+9YYiy/n
         5Tmkser+R/MGTkr4El5dJIs4WFKmY+c6TT4jVttGrYy6J8BD2t1i8YakGUOAmD3d7s/W
         4J9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=BkJ9VfaVDWckj1qLY318bk4f+lp9IhMIKatyOGiiDZQ=;
        b=JzUr7+Y0EcfRqYl3QfNbqOhJkKMWUxhvbfnSBc+9vU2d0w5uCnhElyObx5kO3fdor/
         /oKnKo5VjsqZ0RpWTImiKV+L73kL1xh+iZtrCisSwJgc6iNDSzMUbnxjbVlvo6GAZwhd
         E+oMDAgtrmFynnBAmQtWQUfWblESk/jl5OZIDfk/JOxZcObKogHlkRgjXyWQrqexQsnV
         K8FQEHY4sH3T7GprnrXob5YfdDwFPFMou+jaXWV7wbkkhZTi4l1OI5A7MTtbN5k0Z+4e
         jJLF3p4zJ/XegMbmSXnU6lNUtyzY9mNdySfZ1kpcYOCK/3b+tA43jXEWFvU/3voODezl
         feVQ==
X-Gm-Message-State: AOAM531ExBd9lv79o5Z9kdePTsXEbUxvGxkKuJVQeBjX94YOTi5aFDb/
        EZSvWNgj0MbDaUBHxZGqHgMlvw==
X-Google-Smtp-Source: ABdhPJz+5Xx/cipqmT511r0mFGMwVv3NgngF3Lbu8RkxfM3aIFngBHOQ0hTAY7Ex2NfvSKK3jbI8kw==
X-Received: by 2002:a17:902:6b04:b029:10d:8c9e:5f56 with SMTP id o4-20020a1709026b04b029010d8c9e5f56mr9207024plk.8.1623517089386;
        Sat, 12 Jun 2021 09:58:09 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id bg16sm2236899pjb.16.2021.06.12.09.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 09:58:08 -0700 (PDT)
Date:   Sat, 12 Jun 2021 09:58:08 -0700 (PDT)
X-Google-Original-Date: Sat, 12 Jun 2021 09:58:06 PDT (-0700)
Subject:     Re: [PATCH -next] riscv: Enable HAVE_ARCH_HUGE_VMAP for 64BIT
In-Reply-To: <20210605054838.2017817-1-liushixin2@huawei.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        liushixin2@huawei.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     liushixin2@huawei.com
Message-ID: <mhng-20fb7613-b83d-45a7-a2b0-5a6734ead69e@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Jun 2021 22:48:37 PDT (-0700), liushixin2@huawei.com wrote:
> This sets the HAVE_ARCH_HUGE_VMAP option. Enable pmd vmap support and
> define the required page table functions(Currently, riscv has only
> three-level page tables support for 64BIT).
>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  arch/riscv/Kconfig               |  1 +
>  arch/riscv/include/asm/vmalloc.h | 12 ++++++++++
>  arch/riscv/mm/Makefile           |  1 +
>  arch/riscv/mm/pgtable.c          | 40 ++++++++++++++++++++++++++++++++
>  4 files changed, 54 insertions(+)
>  create mode 100644 arch/riscv/mm/pgtable.c
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 4c0bfb2569e9..fb3c48fa96c1 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -61,6 +61,7 @@ config RISCV
>  	select GENERIC_TIME_VSYSCALL if MMU && 64BIT
>  	select HANDLE_DOMAIN_IRQ
>  	select HAVE_ARCH_AUDITSYSCALL
> +	select HAVE_ARCH_HUGE_VMAP if MMU && 64BIT
>  	select HAVE_ARCH_JUMP_LABEL
>  	select HAVE_ARCH_JUMP_LABEL_RELATIVE
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
> index 000000000000..738dc6f3530f
> --- /dev/null
> +++ b/arch/riscv/mm/pgtable.c
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <asm/pgalloc.h>
> +#include <linux/gfp.h>
> +#include <linux/kernel.h>
> +#include <linux/pgtable.h>
> +
> +#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
> +
> +#ifndef __PAGETABLE_PMD_FOLDED
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
> +#endif
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

Thanks, this is on for-next.
