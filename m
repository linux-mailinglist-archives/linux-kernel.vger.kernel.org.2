Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE16C3B8471
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 15:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbhF3N4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 09:56:20 -0400
Received: from foss.arm.com ([217.140.110.172]:38576 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235781AbhF3Nw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 09:52:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66FB26D;
        Wed, 30 Jun 2021 06:50:00 -0700 (PDT)
Received: from [10.57.40.45] (unknown [10.57.40.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C08BC3F718;
        Wed, 30 Jun 2021 06:49:58 -0700 (PDT)
Subject: Re: [PATCH v3] swiotlb: fix implicit debugfs_create_dir declaration
To:     Claire Chang <tientzu@chromium.org>, konrad.wilk@oracle.com,
        hch@lst.de, m.szyprowski@samsung.com,
        Will Deacon <will@kernel.org>, sstabellini@kernel.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org, Nicolas Boichat <drinkcat@chromium.org>,
        kernel test robot <lkp@intel.com>
References: <20210630040616.3914990-1-tientzu@chromium.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <0ed2f689-2593-5387-dccb-96a82243910f@arm.com>
Date:   Wed, 30 Jun 2021 14:49:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210630040616.3914990-1-tientzu@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-30 05:06, Claire Chang wrote:
> Factor out the debugfs bits from rmem_swiotlb_device_init() into a separate
> rmem_swiotlb_debugfs_init().
> 
> Fixes: 461021875c50 ("swiotlb: Add restricted DMA pool initialization")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Claire Chang <tientzu@chromium.org>
> ---
>   kernel/dma/swiotlb.c | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 0ffbaae9fba2..355dc98d381c 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -709,6 +709,16 @@ static int __init swiotlb_create_default_debugfs(void)
>   
>   late_initcall(swiotlb_create_default_debugfs);
>   
> +static void rmem_swiotlb_debugfs_init(const char *name, struct io_tlb_mem *mem)

Nit: maybe just pass in the reserved_mem, then dereference rmem->name 
and rmem->priv inside here?

> +{
> +	mem->debugfs = debugfs_create_dir(name, debugfs_dir);
> +	swiotlb_create_debugfs_files(mem);
> +}
> +#else
> +__maybe_unused static void rmem_swiotlb_debugfs_init(const char *name,
> +						     struct io_tlb_mem *mem)
> +{
> +}
>   #endif
>   
>   #ifdef CONFIG_DMA_RESTRICTED_POOL
> @@ -766,11 +776,8 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
>   
>   		rmem->priv = mem;
>   
> -		if (IS_ENABLED(CONFIG_DEBUG_FS)) {
> -			mem->debugfs =
> -				debugfs_create_dir(rmem->name, debugfs_dir);
> -			swiotlb_create_debugfs_files(mem);
> -		}
> +		if (IS_ENABLED(CONFIG_DEBUG_FS))
> +			rmem_swiotlb_debugfs_init(rmem->name, mem);

Just make the call unconditional (and drop the __maybe_unused annotation 
above) - the stub already does nothing for the DEBUG_FS=n case, so the 
IS_ENABLED() is pointless.

Robin.

>   	}
>   
>   	dev->dma_io_tlb_mem = mem;
> 
