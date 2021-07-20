Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D803CF2C3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 05:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347001AbhGTC53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 22:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347071AbhGTCz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 22:55:27 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF1BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 20:36:05 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id z11so22573556iow.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 20:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jfs1xv5cKWVRJ1qtbdS51k1USQ3B8wtm35pXmmoKryU=;
        b=LFeTgoRuKZnHD0GvA1dTYaAuabVcP5fN21a9fEHVx9PnauoUp1lue+RNhnBFBte+AR
         M8imBX5vwCVTIIpu3Snmd7ZWwJSJezCeJwCyYgvVO4q11y3dGW6DSqYaR0aqyaHWO0zl
         H2KKj6kOlThtwW3DoQDowJuUB9H2dQdi3eM3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jfs1xv5cKWVRJ1qtbdS51k1USQ3B8wtm35pXmmoKryU=;
        b=QJe89pNjordeDae/A7hGgCWJsu35//cyI5IMqDVrNTruohWvLNNvLiAXZ1GRrslTah
         cUnB8QUPwimfQEYRFJzzVWcJN8QDbuyvYJuV5kdVKwpIU2qXvbs1gawJOJ1a8ZzB7w1A
         Xjk89wjCw7xAawShYU1SiZ+gadFUHFUxedQpSEDpHsp+R5JFova/das0Anb2Zn4hJif5
         G8zx27DFj+JZYuPwyXm2uDn7iw+IoYKMx/t5d6AO6hc4IYg4Ro/u/PYd8bvlUiVwgZJ+
         k9vymiBWgLZl71QaspY8FQUJVBFH7eDYjsLbSNr6XRo6FWz6svemo5i8If79s2KyQRnY
         AMKg==
X-Gm-Message-State: AOAM5337k02iwmG6o7zE8MFowin+dWvuwGecMjXAhtSGj1W20lzs3O5M
        2HdpYN2tMplKDjRYcTtueVzxele1mrz31w==
X-Google-Smtp-Source: ABdhPJyk4Mz9zhUSGsTVpX6STtD26T+hUf2uVN5+uqmD+b9WPJZai1YXVPypFexLBYYOC/kxPgVbvA==
X-Received: by 2002:a5e:8208:: with SMTP id l8mr21378474iom.197.1626752164182;
        Mon, 19 Jul 2021 20:36:04 -0700 (PDT)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com. [209.85.166.48])
        by smtp.gmail.com with ESMTPSA id l5sm11586348ion.44.2021.07.19.20.36.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 20:36:03 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id w22so14344144ioc.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 20:36:03 -0700 (PDT)
X-Received: by 2002:a5d:97c6:: with SMTP id k6mr18707977ios.69.1626752163074;
 Mon, 19 Jul 2021 20:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210719123054.6844-1-will@kernel.org> <20210719123054.6844-4-will@kernel.org>
In-Reply-To: <20210719123054.6844-4-will@kernel.org>
From:   Claire Chang <tientzu@chromium.org>
Date:   Tue, 20 Jul 2021 11:35:52 +0800
X-Gmail-Original-Message-ID: <CALiNf28WYFs9ayvWp4XsK8YFL_=sy7Djb5_Mpj-egYjfRh4BEw@mail.gmail.com>
Message-ID: <CALiNf28WYFs9ayvWp4XsK8YFL_=sy7Djb5_Mpj-egYjfRh4BEw@mail.gmail.com>
Subject: Re: [PATCH 3/5] swiotlb: Remove io_tlb_default_mem indirection
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
> The indirection from the global 'io_tlb_default_mem' pointer to the
> static '_io_tlb_default_mem' structure is ugly and unnecessary.
>
> Convert all users to reference the static structure directly, using the
> 'nslabs' field to determine whether swiotlb has been initialised.
>
> Cc: Claire Chang <tientzu@chromium.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Tested-by: Nathan Chancellor <nathan@kernel.org>

Tested-by: Claire Chang <tientzu@chromium.org>

> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  drivers/base/core.c       |  2 +-
>  drivers/xen/swiotlb-xen.c |  4 ++--
>  include/linux/swiotlb.h   |  2 +-
>  kernel/dma/swiotlb.c      | 38 ++++++++++++++++++--------------------
>  4 files changed, 22 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index ea5b85354526..b49824001cfa 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2848,7 +2848,7 @@ void device_initialize(struct device *dev)
>         dev->dma_coherent = dma_default_coherent;
>  #endif
>  #ifdef CONFIG_SWIOTLB
> -       dev->dma_io_tlb_mem = io_tlb_default_mem;
> +       dev->dma_io_tlb_mem = &io_tlb_default_mem;
>  #endif
>  }
>  EXPORT_SYMBOL_GPL(device_initialize);
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index 785ec7e8be01..f06d9b4f1e0f 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -164,7 +164,7 @@ int __ref xen_swiotlb_init(void)
>         int rc = -ENOMEM;
>         char *start;
>
> -       if (io_tlb_default_mem != NULL) {
> +       if (io_tlb_default_mem.nslabs) {
>                 pr_warn("swiotlb buffer already initialized\n");
>                 return -EEXIST;
>         }
> @@ -547,7 +547,7 @@ xen_swiotlb_sync_sg_for_device(struct device *dev, struct scatterlist *sgl,
>  static int
>  xen_swiotlb_dma_supported(struct device *hwdev, u64 mask)
>  {
> -       return xen_phys_to_dma(hwdev, io_tlb_default_mem->end - 1) <= mask;
> +       return xen_phys_to_dma(hwdev, io_tlb_default_mem.end - 1) <= mask;
>  }
>
>  const struct dma_map_ops xen_swiotlb_dma_ops = {
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index d3b617c19045..b0cb2a9973f4 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -105,7 +105,7 @@ struct io_tlb_mem {
>                 unsigned int list;
>         } *slots;
>  };
> -extern struct io_tlb_mem *io_tlb_default_mem;
> +extern struct io_tlb_mem io_tlb_default_mem;
>
>  static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
>  {
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 992d73cdc944..7948f274f9bb 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -70,8 +70,7 @@
>
>  enum swiotlb_force swiotlb_force;
>
> -struct io_tlb_mem *io_tlb_default_mem;
> -static struct io_tlb_mem _io_tlb_default_mem;
> +struct io_tlb_mem io_tlb_default_mem;
>
>  /*
>   * Max segment that we can provide which (if pages are contingous) will
> @@ -102,7 +101,7 @@ early_param("swiotlb", setup_io_tlb_npages);
>
>  unsigned int swiotlb_max_segment(void)
>  {
> -       return io_tlb_default_mem ? max_segment : 0;
> +       return io_tlb_default_mem.nslabs ? max_segment : 0;
>  }
>  EXPORT_SYMBOL_GPL(swiotlb_max_segment);
>
> @@ -135,9 +134,9 @@ void __init swiotlb_adjust_size(unsigned long size)
>
>  void swiotlb_print_info(void)
>  {
> -       struct io_tlb_mem *mem = io_tlb_default_mem;
> +       struct io_tlb_mem *mem = &io_tlb_default_mem;
>
> -       if (!mem) {
> +       if (!mem->nslabs) {
>                 pr_warn("No low mem\n");
>                 return;
>         }
> @@ -164,11 +163,11 @@ static inline unsigned long nr_slots(u64 val)
>   */
>  void __init swiotlb_update_mem_attributes(void)
>  {
> -       struct io_tlb_mem *mem = io_tlb_default_mem;
> +       struct io_tlb_mem *mem = &io_tlb_default_mem;
>         void *vaddr;
>         unsigned long bytes;
>
> -       if (!mem || mem->late_alloc)
> +       if (!mem->nslabs || mem->late_alloc)
>                 return;
>         vaddr = phys_to_virt(mem->start);
>         bytes = PAGE_ALIGN(mem->nslabs << IO_TLB_SHIFT);
> @@ -202,14 +201,14 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
>
>  int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
>  {
> -       struct io_tlb_mem *mem = &_io_tlb_default_mem;
> +       struct io_tlb_mem *mem = &io_tlb_default_mem;
>         size_t alloc_size;
>
>         if (swiotlb_force == SWIOTLB_NO_FORCE)
>                 return 0;
>
>         /* protect against double initialization */
> -       if (WARN_ON_ONCE(io_tlb_default_mem))
> +       if (WARN_ON_ONCE(mem->nslabs))
>                 return -ENOMEM;
>
>         alloc_size = PAGE_ALIGN(array_size(sizeof(*mem->slots), nslabs));
> @@ -220,7 +219,6 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
>
>         swiotlb_init_io_tlb_mem(mem, __pa(tlb), nslabs, false);
>
> -       io_tlb_default_mem = mem;
>         if (verbose)
>                 swiotlb_print_info();
>         swiotlb_set_max_segment(mem->nslabs << IO_TLB_SHIFT);
> @@ -305,14 +303,14 @@ swiotlb_late_init_with_default_size(size_t default_size)
>  int
>  swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
>  {
> -       struct io_tlb_mem *mem = &_io_tlb_default_mem;
> +       struct io_tlb_mem *mem = &io_tlb_default_mem;
>         unsigned long bytes = nslabs << IO_TLB_SHIFT;
>
>         if (swiotlb_force == SWIOTLB_NO_FORCE)
>                 return 0;
>
>         /* protect against double initialization */
> -       if (WARN_ON_ONCE(io_tlb_default_mem))
> +       if (WARN_ON_ONCE(mem->nslabs))
>                 return -ENOMEM;
>
>         mem->slots = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
> @@ -323,7 +321,6 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
>         set_memory_decrypted((unsigned long)tlb, bytes >> PAGE_SHIFT);
>         swiotlb_init_io_tlb_mem(mem, virt_to_phys(tlb), nslabs, true);
>
> -       io_tlb_default_mem = mem;
>         swiotlb_print_info();
>         swiotlb_set_max_segment(mem->nslabs << IO_TLB_SHIFT);
>         return 0;
> @@ -331,10 +328,10 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
>
>  void __init swiotlb_exit(void)
>  {
> -       struct io_tlb_mem *mem = io_tlb_default_mem;
>         size_t size;
> +       struct io_tlb_mem *mem = &io_tlb_default_mem;
>
> -       if (!mem)
> +       if (!mem->nslabs)
>                 return;
>
>         size = array_size(sizeof(*mem->slots), mem->nslabs);
> @@ -342,7 +339,6 @@ void __init swiotlb_exit(void)
>                 free_pages((unsigned long)mem->slots, get_order(size));
>         else
>                 memblock_free_late(__pa(mem->slots), PAGE_ALIGN(size));
> -       io_tlb_default_mem = NULL;
>         memset(mem, 0, sizeof(*mem));
>  }
>
> @@ -697,7 +693,9 @@ size_t swiotlb_max_mapping_size(struct device *dev)
>
>  bool is_swiotlb_active(struct device *dev)
>  {
> -       return dev->dma_io_tlb_mem != NULL;
> +       struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
> +
> +       return mem && mem->nslabs;
>  }
>  EXPORT_SYMBOL_GPL(is_swiotlb_active);
>
> @@ -712,10 +710,10 @@ static void swiotlb_create_debugfs_files(struct io_tlb_mem *mem)
>
>  static int __init swiotlb_create_default_debugfs(void)
>  {
> -       struct io_tlb_mem *mem = io_tlb_default_mem;
> +       struct io_tlb_mem *mem = &io_tlb_default_mem;
>
>         debugfs_dir = debugfs_create_dir("swiotlb", NULL);
> -       if (mem) {
> +       if (mem->nslabs) {
>                 mem->debugfs = debugfs_dir;
>                 swiotlb_create_debugfs_files(mem);
>         }
> @@ -814,7 +812,7 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
>  static void rmem_swiotlb_device_release(struct reserved_mem *rmem,
>                                         struct device *dev)
>  {
> -       dev->dma_io_tlb_mem = io_tlb_default_mem;
> +       dev->dma_io_tlb_mem = &io_tlb_default_mem;
>  }
>
>  static const struct reserved_mem_ops rmem_swiotlb_ops = {
> --
> 2.32.0.402.g57bb445576-goog
>
