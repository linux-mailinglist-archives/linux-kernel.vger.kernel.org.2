Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C915E3EE3F1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 03:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235784AbhHQBtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 21:49:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:39994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233327AbhHQBtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 21:49:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 48C1C60F46;
        Tue, 17 Aug 2021 01:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629164917;
        bh=YtLnIn3se4f3RGPKKpiGfQLFG/FwYWBuHWi8tDQgZ3o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V5gfadSiG1OSzw5T7WhzYHrrA8M/5D5HXW8JLQnGoqgwv3aCTlLxKeIDUajjPBjaE
         eY3Lcnq3eiSYzeDO4THtZHu12Z4VmIui59JoTN/5GWRXXRhOtkhXO7rgiYQ61F1As9
         gK0qomF8Klvn5SMTiX0xAGqTb48KNI5REvIrFhMZ6aRHvPxqqp3JZbLKwHsDpsIsJQ
         aThxaQXqB9Iuuz139GfgbCmq+nFTW7rx9Omcp/EOanSIu/XnHukZv8XeaJqPavv4HB
         6yk7YY1TV5DhGTnthEzeqsZtFYlv21+VPvbMEE7mGgTqPdxZKIEFEehikFMFIAvhiq
         W3WvBSRkkbe8w==
Received: by mail-lj1-f172.google.com with SMTP id x7so30269633ljn.10;
        Mon, 16 Aug 2021 18:48:37 -0700 (PDT)
X-Gm-Message-State: AOAM530uyDalKqWvzw7dtJ1uZ4EV0aspp5AW+a2+vGNJTFqkyx/XkXPr
        0xcmBq/B+QUr2eQZTi0KHTC/mcI2bf2v/1gLZok=
X-Google-Smtp-Source: ABdhPJx9ByYxBBndLZ7kK8lmdZtqotARGfuEsaRFuPPBmrHK1JviGoCUNSBXPoFEzsSJe9ISx3HnRJSEq2QXj742mBw=
X-Received: by 2002:a05:651c:39c:: with SMTP id e28mr912783ljp.498.1629164915532;
 Mon, 16 Aug 2021 18:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210723214031.3251801-1-atish.patra@wdc.com> <20210723214031.3251801-2-atish.patra@wdc.com>
In-Reply-To: <20210723214031.3251801-2-atish.patra@wdc.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 17 Aug 2021 09:48:24 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT+zS=ySrmQUzVe7hf56E2K7XoGjzMyeaH5oFPUNwFqZA@mail.gmail.com>
Message-ID: <CAJF2gTT+zS=ySrmQUzVe7hf56E2K7XoGjzMyeaH5oFPUNwFqZA@mail.gmail.com>
Subject: Re: [RFC 1/5] RISC-V: Implement arch_sync_dma* functions
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Tobias Klauser <tklauser@distanz.ch>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        iommu@lists.linux-foundation.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 24, 2021 at 5:40 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> To facilitate streaming DMA APIs, this patch introduces a set of generic
> cache operations related dma sync. Any platform can use the generic ops
> to provide platform specific cache management operations. Once the
> standard RISC-V CMO extension is available, it can be built on top of it.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/include/asm/dma-noncoherent.h | 19 +++++++
>  arch/riscv/mm/Makefile                   |  1 +
>  arch/riscv/mm/dma-noncoherent.c          | 66 ++++++++++++++++++++++++
>  3 files changed, 86 insertions(+)
>  create mode 100644 arch/riscv/include/asm/dma-noncoherent.h
>  create mode 100644 arch/riscv/mm/dma-noncoherent.c
>
> diff --git a/arch/riscv/include/asm/dma-noncoherent.h b/arch/riscv/include/asm/dma-noncoherent.h
> new file mode 100644
> index 000000000000..5bdb03c9c427
> --- /dev/null
> +++ b/arch/riscv/include/asm/dma-noncoherent.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2021 Western Digital Corporation or its affiliates.
> + */
> +
> +#ifndef __ASM_RISCV_DMA_NON_COHERENT_H
> +#define __ASM_RISCV_DMA_NON_COHERENT_H
> +
> +#ifdef CONFIG_RISCV_DMA_NONCOHERENT
> +struct riscv_dma_cache_sync {
> +       void (*cache_invalidate)(phys_addr_t paddr, size_t size);
> +       void (*cache_clean)(phys_addr_t paddr, size_t size);
> +       void (*cache_flush)(phys_addr_t paddr, size_t size);
> +};
I like the style like this than my previous patch which using
sbi_call. The c906 has custom instructions that could be called in
S-mode directly.

Hope the patch could be soon merged, after correct the
DMA_FROM/TO_DEVICE/BIDIRECTIONAL and alternatives ops_set.

> +
> +void riscv_dma_cache_sync_set(struct riscv_dma_cache_sync *ops);
> +#endif
> +
> +#endif
> diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
> index 7ebaef10ea1b..959bef49098b 100644
> --- a/arch/riscv/mm/Makefile
> +++ b/arch/riscv/mm/Makefile
> @@ -27,3 +27,4 @@ KASAN_SANITIZE_init.o := n
>  endif
>
>  obj-$(CONFIG_DEBUG_VIRTUAL) += physaddr.o
> +obj-$(CONFIG_RISCV_DMA_NONCOHERENT) += dma-noncoherent.o
> diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
> new file mode 100644
> index 000000000000..2f6e9627c4aa
> --- /dev/null
> +++ b/arch/riscv/mm/dma-noncoherent.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * RISC-V specific functions to support DMA for non-coherent devices
> + *
> + * Copyright (c) 2021 Western Digital Corporation or its affiliates.
> + */
> +
> +#include <linux/dma-direct.h>
> +#include <linux/dma-map-ops.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/libfdt.h>
> +#include <linux/mm.h>
> +#include <linux/of.h>
> +#include <linux/of_fdt.h>
> +#include <asm/dma-noncoherent.h>
> +
> +static struct riscv_dma_cache_sync *dma_cache_sync;
> +unsigned long riscv_dma_uc_offset;
> +
> +static void __dma_sync(phys_addr_t paddr, size_t size, enum dma_data_direction dir)
> +{
> +       if ((dir == DMA_FROM_DEVICE) && (dma_cache_sync->cache_invalidate))
> +               dma_cache_sync->cache_invalidate(paddr, size);
> +       else if ((dir == DMA_TO_DEVICE) && (dma_cache_sync->cache_clean))
> +               dma_cache_sync->cache_clean(paddr, size);
> +       else if ((dir == DMA_BIDIRECTIONAL) && dma_cache_sync->cache_flush)
> +               dma_cache_sync->cache_flush(paddr, size);
> +}
> +
> +void arch_sync_dma_for_device(phys_addr_t paddr, size_t size, enum dma_data_direction dir)
> +{
> +       if (!dma_cache_sync)
> +               return;
> +
> +       __dma_sync(paddr, size, dir);
> +}
> +
> +void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size, enum dma_data_direction dir)
> +{
> +       if (!dma_cache_sync)
> +               return;
> +
> +       __dma_sync(paddr, size, dir);
> +}
> +
> +void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> +               const struct iommu_ops *iommu, bool coherent)
> +{
> +       /* If a specific device is dma-coherent, set it here */
> +       dev->dma_coherent = coherent;
> +}
> +
> +void arch_dma_prep_coherent(struct page *page, size_t size)
> +{
> +       void *flush_addr = page_address(page);
> +
> +       memset(flush_addr, 0, size);
> +       if (dma_cache_sync && dma_cache_sync->cache_flush)
> +               dma_cache_sync->cache_flush(__pa(flush_addr), size);
> +}
> +
> +void riscv_dma_cache_sync_set(struct riscv_dma_cache_sync *ops)
> +{
> +       dma_cache_sync = ops;
> +}
> --
> 2.31.1
>
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
