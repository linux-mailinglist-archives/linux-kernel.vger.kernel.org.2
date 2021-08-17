Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42F43EE4FB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 05:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236746AbhHQDZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 23:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbhHQDZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 23:25:10 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AB3C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 20:24:37 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id i8so14108440ybt.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 20:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R7t78EbJ4SBQR4PW9PP+EHALfMTimXWJ4a8o/k9vg3E=;
        b=TvFFwtmlL3L2+ir/JLvkG9HSbp6wG0WN7eoWHjuvbqXI/776osypQlgOrDrJUXLFjL
         94vLmlXhpIhhPlKhhiwszEk5kK6XzKmgsMfM/A3jvpMEuqbVyeX3vxyGQeKdQZFR3yr3
         Ioj8WJTKLQsxO2rclDVfBKJYXSWlDN3Tu90wM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R7t78EbJ4SBQR4PW9PP+EHALfMTimXWJ4a8o/k9vg3E=;
        b=o26IQGxrHh2v9VpjYBQ/FguqQndJwQZ0C0sy5J7I/xvkd0ne6GmbMhyZ5W57avIAfs
         /KvnIreBqGAgZFqwTVPh/FutV2JL1WZ1ZwYfTXdqt1ZyRcTJ8lZcBry5uQjEukX3iO2W
         /n2hJDRp/Z8qWP2R+D2LBkFk6qBrrpCjB2FQ/gtiYQ0mVnNQqwx+kG3wM6Z/lBWjLizH
         4d2FWhnvqsguEdGfSrmJWl3BOsdt7yD2KBo93AH2GzQPaxL7p09B7Ct/X8e8ZUhpEPXM
         5iDzXlRU8Oznct5oXbSeaLLjFjxF4cfDjXDvndDEIXn37c8j4+qJUpybo/P6dfcARVHB
         y7VA==
X-Gm-Message-State: AOAM531U/BP14q08GE7C8U2FmqNOCNfGU6kAORjxNWxjSJBRQKE5QJNl
        kc/cFNpAwbH3LtmbLxm/AHf34WdvQiUPoGpR0s7h
X-Google-Smtp-Source: ABdhPJzKYOIuc7NAVJ7T2p4GvCqFkDmXaCHT1oHt/jMQX6BHv/wp7fy0gQ89E1PH6Sc5hPjbcFazBGEGNlpJr4nUvig=
X-Received: by 2002:a25:3f85:: with SMTP id m127mr1773427yba.21.1629170676840;
 Mon, 16 Aug 2021 20:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210723214031.3251801-1-atish.patra@wdc.com> <20210723214031.3251801-2-atish.patra@wdc.com>
 <CAJF2gTT+zS=ySrmQUzVe7hf56E2K7XoGjzMyeaH5oFPUNwFqZA@mail.gmail.com>
In-Reply-To: <CAJF2gTT+zS=ySrmQUzVe7hf56E2K7XoGjzMyeaH5oFPUNwFqZA@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 16 Aug 2021 20:24:26 -0700
Message-ID: <CAOnJCU+Sebr-3zt-xy9F6hGb8qj30QsH_SQvEkrvWhw6sVmbcw@mail.gmail.com>
Subject: Re: [RFC 1/5] RISC-V: Implement arch_sync_dma* functions
To:     Guo Ren <guoren@kernel.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        devicetree <devicetree@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Guo Ren <guoren@linux.alibaba.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 6:48 PM Guo Ren <guoren@kernel.org> wrote:
>
> On Sat, Jul 24, 2021 at 5:40 AM Atish Patra <atish.patra@wdc.com> wrote:
> >
> > To facilitate streaming DMA APIs, this patch introduces a set of generic
> > cache operations related dma sync. Any platform can use the generic ops
> > to provide platform specific cache management operations. Once the
> > standard RISC-V CMO extension is available, it can be built on top of it.
> >
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > ---
> >  arch/riscv/include/asm/dma-noncoherent.h | 19 +++++++
> >  arch/riscv/mm/Makefile                   |  1 +
> >  arch/riscv/mm/dma-noncoherent.c          | 66 ++++++++++++++++++++++++
> >  3 files changed, 86 insertions(+)
> >  create mode 100644 arch/riscv/include/asm/dma-noncoherent.h
> >  create mode 100644 arch/riscv/mm/dma-noncoherent.c
> >
> > diff --git a/arch/riscv/include/asm/dma-noncoherent.h b/arch/riscv/include/asm/dma-noncoherent.h
> > new file mode 100644
> > index 000000000000..5bdb03c9c427
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/dma-noncoherent.h
> > @@ -0,0 +1,19 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (c) 2021 Western Digital Corporation or its affiliates.
> > + */
> > +
> > +#ifndef __ASM_RISCV_DMA_NON_COHERENT_H
> > +#define __ASM_RISCV_DMA_NON_COHERENT_H
> > +
> > +#ifdef CONFIG_RISCV_DMA_NONCOHERENT
> > +struct riscv_dma_cache_sync {
> > +       void (*cache_invalidate)(phys_addr_t paddr, size_t size);
> > +       void (*cache_clean)(phys_addr_t paddr, size_t size);
> > +       void (*cache_flush)(phys_addr_t paddr, size_t size);
> > +};
> I like the style like this than my previous patch which using
> sbi_call. The c906 has custom instructions that could be called in
> S-mode directly.
>

How are you going to include the custom instructions in the upstream kernel ?

> Hope the patch could be soon merged, after correct the
> DMA_FROM/TO_DEVICE/BIDIRECTIONAL and alternatives ops_set.
>
> > +
> > +void riscv_dma_cache_sync_set(struct riscv_dma_cache_sync *ops);
> > +#endif
> > +
> > +#endif
> > diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
> > index 7ebaef10ea1b..959bef49098b 100644
> > --- a/arch/riscv/mm/Makefile
> > +++ b/arch/riscv/mm/Makefile
> > @@ -27,3 +27,4 @@ KASAN_SANITIZE_init.o := n
> >  endif
> >
> >  obj-$(CONFIG_DEBUG_VIRTUAL) += physaddr.o
> > +obj-$(CONFIG_RISCV_DMA_NONCOHERENT) += dma-noncoherent.o
> > diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
> > new file mode 100644
> > index 000000000000..2f6e9627c4aa
> > --- /dev/null
> > +++ b/arch/riscv/mm/dma-noncoherent.c
> > @@ -0,0 +1,66 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * RISC-V specific functions to support DMA for non-coherent devices
> > + *
> > + * Copyright (c) 2021 Western Digital Corporation or its affiliates.
> > + */
> > +
> > +#include <linux/dma-direct.h>
> > +#include <linux/dma-map-ops.h>
> > +#include <linux/init.h>
> > +#include <linux/io.h>
> > +#include <linux/libfdt.h>
> > +#include <linux/mm.h>
> > +#include <linux/of.h>
> > +#include <linux/of_fdt.h>
> > +#include <asm/dma-noncoherent.h>
> > +
> > +static struct riscv_dma_cache_sync *dma_cache_sync;
> > +unsigned long riscv_dma_uc_offset;
> > +
> > +static void __dma_sync(phys_addr_t paddr, size_t size, enum dma_data_direction dir)
> > +{
> > +       if ((dir == DMA_FROM_DEVICE) && (dma_cache_sync->cache_invalidate))
> > +               dma_cache_sync->cache_invalidate(paddr, size);
> > +       else if ((dir == DMA_TO_DEVICE) && (dma_cache_sync->cache_clean))
> > +               dma_cache_sync->cache_clean(paddr, size);
> > +       else if ((dir == DMA_BIDIRECTIONAL) && dma_cache_sync->cache_flush)
> > +               dma_cache_sync->cache_flush(paddr, size);
> > +}
> > +
> > +void arch_sync_dma_for_device(phys_addr_t paddr, size_t size, enum dma_data_direction dir)
> > +{
> > +       if (!dma_cache_sync)
> > +               return;
> > +
> > +       __dma_sync(paddr, size, dir);
> > +}
> > +
> > +void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size, enum dma_data_direction dir)
> > +{
> > +       if (!dma_cache_sync)
> > +               return;
> > +
> > +       __dma_sync(paddr, size, dir);
> > +}
> > +
> > +void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> > +               const struct iommu_ops *iommu, bool coherent)
> > +{
> > +       /* If a specific device is dma-coherent, set it here */
> > +       dev->dma_coherent = coherent;
> > +}
> > +
> > +void arch_dma_prep_coherent(struct page *page, size_t size)
> > +{
> > +       void *flush_addr = page_address(page);
> > +
> > +       memset(flush_addr, 0, size);
> > +       if (dma_cache_sync && dma_cache_sync->cache_flush)
> > +               dma_cache_sync->cache_flush(__pa(flush_addr), size);
> > +}
> > +
> > +void riscv_dma_cache_sync_set(struct riscv_dma_cache_sync *ops)
> > +{
> > +       dma_cache_sync = ops;
> > +}
> > --
> > 2.31.1
> >
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
>
>
>
> --
> Best Regards
>  Guo Ren
>
> ML: https://lore.kernel.org/linux-csky/
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
Regards,
Atish
