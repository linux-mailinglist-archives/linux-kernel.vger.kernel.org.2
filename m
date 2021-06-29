Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF883B7289
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 14:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbhF2MzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 08:55:13 -0400
Received: from foss.arm.com ([217.140.110.172]:50542 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233497AbhF2Myr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 08:54:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04B5B106F;
        Tue, 29 Jun 2021 05:52:20 -0700 (PDT)
Received: from [10.57.46.146] (unknown [10.57.46.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67C163F718;
        Tue, 29 Jun 2021 05:52:18 -0700 (PDT)
Subject: Re: [PATCH v2] swiotlb: fix implicit debugfs_create_dir declaration
To:     Claire Chang <tientzu@chromium.org>, konrad.wilk@oracle.com,
        hch@lst.de, m.szyprowski@samsung.com,
        Will Deacon <will@kernel.org>, sstabellini@kernel.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org, Nicolas Boichat <drinkcat@chromium.org>,
        kernel test robot <lkp@intel.com>
References: <20210629121625.3633999-1-tientzu@chromium.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <7f544c68-721c-bbcc-3614-cbadce7261a9@arm.com>
Date:   Tue, 29 Jun 2021 13:52:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210629121625.3633999-1-tientzu@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-29 13:16, Claire Chang wrote:
> Remove the ifdef to fix implicit function declaration for other pools.
> 
> Fixes: 1d9f94400a7a ("swiotlb: Refactor swiotlb_create_debugfs")

There doesn't appear to be a problem with that commit - AFAICS it's 
461021875c50 ("swiotlb: Add restricted DMA pool initialization") which 
introduces a reference to debugfs_create_dir() outside the existing 
#ifdef guards.

FWIW (assuming it's the real problem) I'd be inclined to factor out the 
debugfs bits from rmem_swiotlb_device_init() into a separate 
rmem_swiotlb_debugfs_init() (or similar) function which can live 
alongside the others under the #ifdef and be stubbed out in an #else case.

Robin.

> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Claire Chang <tientzu@chromium.org>
> ---
>   kernel/dma/swiotlb.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 0ffbaae9fba2..8ae0bef392c3 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -36,9 +36,7 @@
>   #include <linux/scatterlist.h>
>   #include <linux/mem_encrypt.h>
>   #include <linux/set_memory.h>
> -#ifdef CONFIG_DEBUG_FS
>   #include <linux/debugfs.h>
> -#endif
>   #ifdef CONFIG_DMA_RESTRICTED_POOL
>   #include <linux/io.h>
>   #include <linux/of.h>
> @@ -686,7 +684,6 @@ bool is_swiotlb_active(struct device *dev)
>   }
>   EXPORT_SYMBOL_GPL(is_swiotlb_active);
>   
> -#ifdef CONFIG_DEBUG_FS
>   static struct dentry *debugfs_dir;
>   
>   static void swiotlb_create_debugfs_files(struct io_tlb_mem *mem)
> @@ -709,8 +706,6 @@ static int __init swiotlb_create_default_debugfs(void)
>   
>   late_initcall(swiotlb_create_default_debugfs);
>   
> -#endif
> -
>   #ifdef CONFIG_DMA_RESTRICTED_POOL
>   struct page *swiotlb_alloc(struct device *dev, size_t size)
>   {
> 
