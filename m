Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B4E3CF2BE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 05:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347263AbhGTC5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 22:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347014AbhGTCzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 22:55:06 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A188EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 20:35:45 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id p186so22481091iod.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 20:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Alslk6Prg1CBpjKfbX08zH3+SKnc41nPkrWR78zk388=;
        b=SRBm7fQvCWVrkmK8khsSUs8hWdy9w9FidNrH/U0PJv5xb79oaaJ4kFdfa4oWbE6oO7
         LTrWRu1Ce2/GTK6TouZn8D0MqunjkfPQ59x7IDKYZDmpcCOacTcY6W/5vHY60XChEq7e
         Dyh2Pj1fQx+tWYoBkeykUY83Dgnu/3TVcWqsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Alslk6Prg1CBpjKfbX08zH3+SKnc41nPkrWR78zk388=;
        b=gze1YJirlvDth3TZknpeCypkadcnjAtqejA/FE+GS3dJkGiprxLtJQh/PGaVLjlbHZ
         /UoxHJrYsLB3QrJeifpTd4HIrICP658hjH1x15/jfNg027aHUIIcFpAxefveW8vs22jm
         7e7x38qvCtg5C1Af6/B6LhgesJj2UtbsXFO2NyByaeSwTcsHBFhzGfJ/sN/1BnpRXe94
         Hz7Dzw6DM3L8uC9oxhsLtOK7cN4fod3IodHWSikXsWmRjwFKm+XyLz88pBVzH0BJUJTH
         bgphQqSp9FHYfpUDTy8xDoDxjO6JCLtg9iIIeItNbi68RzriJSu8FImgBLYPSv44enuL
         eUAw==
X-Gm-Message-State: AOAM5316P2J2MCqHtEtQzfh4dmzbqVZDShMy25LtJIxKhCzGzx6Tc+lQ
        SfFkG6CxED1AemK23EoiR0Lvw7IkaNJ3YA==
X-Google-Smtp-Source: ABdhPJwHgcgXD7X5h1LqRXzJu9ZCTqs13vki0Q8XNe+jt41lRAWGZxUqv88feZDAQnohlrLycXvXrg==
X-Received: by 2002:a05:6638:3796:: with SMTP id w22mr8312419jal.34.1626752144845;
        Mon, 19 Jul 2021 20:35:44 -0700 (PDT)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com. [209.85.166.42])
        by smtp.gmail.com with ESMTPSA id z24sm5594083iog.46.2021.07.19.20.35.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 20:35:44 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id g22so22529161iom.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 20:35:44 -0700 (PDT)
X-Received: by 2002:a05:6602:24d8:: with SMTP id h24mr21332263ioe.27.1626752143829;
 Mon, 19 Jul 2021 20:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210719123054.6844-1-will@kernel.org> <20210719123054.6844-3-will@kernel.org>
In-Reply-To: <20210719123054.6844-3-will@kernel.org>
From:   Claire Chang <tientzu@chromium.org>
Date:   Tue, 20 Jul 2021 11:35:33 +0800
X-Gmail-Original-Message-ID: <CALiNf29VMGF0Pu5RfLUJMOiYB3T8zyeFt+Q499-=Vf40+8FEkw@mail.gmail.com>
Message-ID: <CALiNf29VMGF0Pu5RfLUJMOiYB3T8zyeFt+Q499-=Vf40+8FEkw@mail.gmail.com>
Subject: Re: [PATCH 2/5] swiotlb: Point io_default_tlb_mem at static allocation
To:     Will Deacon <will@kernel.org>
Cc:     "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 8:31 PM Will Deacon <will@kernel.org> wrote:
>
> Since commit 69031f500865 ("swiotlb: Set dev->dma_io_tlb_mem to the
> swiotlb pool used"), 'struct device' may hold a copy of the global
> 'io_default_tlb_mem' pointer if the device is using swiotlb for DMA. A
> subsequent call to swiotlb_exit() will therefore leave dangling pointers
> behind in these device structures, resulting in KASAN splats such as:
>
>   |  BUG: KASAN: use-after-free in __iommu_dma_unmap_swiotlb+0x64/0xb0
>   |  Read of size 8 at addr ffff8881d7830000 by task swapper/0/0
>   |
>   |  CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.12.0-rc3-debug #1
>   |  Hardware name: HP HP Desktop M01-F1xxx/87D6, BIOS F.12 12/17/2020
>   |  Call Trace:
>   |   <IRQ>
>   |   dump_stack+0x9c/0xcf
>   |   print_address_description.constprop.0+0x18/0x130
>   |   kasan_report.cold+0x7f/0x111
>   |   __iommu_dma_unmap_swiotlb+0x64/0xb0
>   |   nvme_pci_complete_rq+0x73/0x130
>   |   blk_complete_reqs+0x6f/0x80
>   |   __do_softirq+0xfc/0x3be
>
> Point 'io_default_tlb_mem' at a static structure, so that the per-device
> pointers remain valid after swiotlb_exit() has been invoked. The 'slots'
> array is still allocated dynamically and referenced via a pointer rather
> than a flexible array member.
>
> Cc: Claire Chang <tientzu@chromium.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Fixes: 69031f500865 ("swiotlb: Set dev->dma_io_tlb_mem to the swiotlb pool used")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Tested-by: Nathan Chancellor <nathan@kernel.org>

Tested-by: Claire Chang <tientzu@chromium.org>

> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  include/linux/swiotlb.h |  2 +-
>  kernel/dma/swiotlb.c    | 34 +++++++++++++++++++++-------------
>  2 files changed, 22 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 39284ff2a6cd..d3b617c19045 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -103,7 +103,7 @@ struct io_tlb_mem {
>                 phys_addr_t orig_addr;
>                 size_t alloc_size;
>                 unsigned int list;
> -       } slots[];
> +       } *slots;
>  };
>  extern struct io_tlb_mem *io_tlb_default_mem;
>
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index f1a9ae7fad8f..992d73cdc944 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -71,6 +71,7 @@
>  enum swiotlb_force swiotlb_force;
>
>  struct io_tlb_mem *io_tlb_default_mem;
> +static struct io_tlb_mem _io_tlb_default_mem;
>
>  /*
>   * Max segment that we can provide which (if pages are contingous) will
> @@ -201,7 +202,7 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
>
>  int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
>  {
> -       struct io_tlb_mem *mem;
> +       struct io_tlb_mem *mem = &_io_tlb_default_mem;
>         size_t alloc_size;
>
>         if (swiotlb_force == SWIOTLB_NO_FORCE)
> @@ -211,9 +212,9 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
>         if (WARN_ON_ONCE(io_tlb_default_mem))
>                 return -ENOMEM;
>
> -       alloc_size = PAGE_ALIGN(struct_size(mem, slots, nslabs));
> -       mem = memblock_alloc(alloc_size, PAGE_SIZE);
> -       if (!mem)
> +       alloc_size = PAGE_ALIGN(array_size(sizeof(*mem->slots), nslabs));
> +       mem->slots = memblock_alloc(alloc_size, PAGE_SIZE);
> +       if (!mem->slots)
>                 panic("%s: Failed to allocate %zu bytes align=0x%lx\n",
>                       __func__, alloc_size, PAGE_SIZE);
>
> @@ -304,7 +305,7 @@ swiotlb_late_init_with_default_size(size_t default_size)
>  int
>  swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
>  {
> -       struct io_tlb_mem *mem;
> +       struct io_tlb_mem *mem = &_io_tlb_default_mem;
>         unsigned long bytes = nslabs << IO_TLB_SHIFT;
>
>         if (swiotlb_force == SWIOTLB_NO_FORCE)
> @@ -314,12 +315,11 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
>         if (WARN_ON_ONCE(io_tlb_default_mem))
>                 return -ENOMEM;
>
> -       mem = (void *)__get_free_pages(GFP_KERNEL,
> -               get_order(struct_size(mem, slots, nslabs)));
> -       if (!mem)
> +       mem->slots = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
> +               get_order(array_size(sizeof(*mem->slots), nslabs)));
> +       if (!mem->slots)
>                 return -ENOMEM;
>
> -       memset(mem, 0, sizeof(*mem));
>         set_memory_decrypted((unsigned long)tlb, bytes >> PAGE_SHIFT);
>         swiotlb_init_io_tlb_mem(mem, virt_to_phys(tlb), nslabs, true);
>
> @@ -337,12 +337,13 @@ void __init swiotlb_exit(void)
>         if (!mem)
>                 return;
>
> -       size = struct_size(mem, slots, mem->nslabs);
> +       size = array_size(sizeof(*mem->slots), mem->nslabs);
>         if (mem->late_alloc)
> -               free_pages((unsigned long)mem, get_order(size));
> +               free_pages((unsigned long)mem->slots, get_order(size));
>         else
> -               memblock_free_late(__pa(mem), PAGE_ALIGN(size));
> +               memblock_free_late(__pa(mem->slots), PAGE_ALIGN(size));
>         io_tlb_default_mem = NULL;
> +       memset(mem, 0, sizeof(*mem));
>  }
>
>  /*
> @@ -783,10 +784,17 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
>          * to it.
>          */
>         if (!mem) {
> -               mem = kzalloc(struct_size(mem, slots, nslabs), GFP_KERNEL);
> +               mem = kzalloc(sizeof(*mem), GFP_KERNEL);
>                 if (!mem)
>                         return -ENOMEM;
>
> +               mem->slots = kzalloc(array_size(sizeof(*mem->slots), nslabs),
> +                                    GFP_KERNEL);
> +               if (!mem->slots) {
> +                       kfree(mem);
> +                       return -ENOMEM;
> +               }
> +
>                 set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
>                                      rmem->size >> PAGE_SHIFT);
>                 swiotlb_init_io_tlb_mem(mem, rmem->base, nslabs, false);
> --
> 2.32.0.402.g57bb445576-goog
>
