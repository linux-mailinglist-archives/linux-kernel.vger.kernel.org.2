Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4A33FE382
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 22:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbhIAUEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 16:04:38 -0400
Received: from foss.arm.com ([217.140.110.172]:41206 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231246AbhIAUEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 16:04:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66A441063;
        Wed,  1 Sep 2021 13:03:38 -0700 (PDT)
Received: from [10.57.15.112] (unknown [10.57.15.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13E343F766;
        Wed,  1 Sep 2021 13:03:36 -0700 (PDT)
Subject: Re: [PATCH v3] coresight: tmc-etr: Speed up for bounce buffer in flat
 mode
To:     Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210829135409.186732-1-leo.yan@linaro.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <a94acd88-dab9-048d-ed9b-b4cac6c4d794@arm.com>
Date:   Wed, 1 Sep 2021 21:03:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210829135409.186732-1-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-29 14:54, Leo Yan wrote:
> The AUX bounce buffer is allocated with API dma_alloc_coherent(), in the
> low level's architecture code, e.g. for Arm64, it maps the memory with
> the attribution "Normal non-cacheable"; this can be concluded from the
> definition for pgprot_dmacoherent() in arch/arm64/include/asm/pgtable.h.
> 
> Later when access the AUX bounce buffer, since the memory mapping is
> non-cacheable, it's low efficiency due to every load instruction must
> reach out DRAM.
> 
> This patch changes to allocate pages with alloc_pages_node(), thus the
> driver can access the memory with cacheable mapping in the kernel linear
> virtual address; therefore, because load instructions can fetch data
> from cache lines rather than always read data from DRAM, the driver can
> boost memory coping performance.  After using the cacheable mapping, the
> driver uses dma_sync_single_for_cpu() to invalidate cacheline prior to
> read bounce buffer so can avoid read stale trace data.
> 
> By measurement the duration for function tmc_update_etr_buffer() with
> ftrace function_graph tracer, it shows the performance significant
> improvement for copying 4MiB data from bounce buffer:
> 
>    # echo tmc_etr_get_data_flat_buf > set_graph_notrace // avoid noise
>    # echo tmc_update_etr_buffer > set_graph_function
>    # echo function_graph > current_tracer
> 
>    before:
> 
>    # CPU  DURATION                  FUNCTION CALLS
>    # |     |   |                     |   |   |   |
>    2)               |    tmc_update_etr_buffer() {
>    ...
>    2) # 8148.320 us |    }
> 
>    after:
> 
>    # CPU  DURATION                  FUNCTION CALLS
>    # |     |   |                     |   |   |   |
>    2)               |  tmc_update_etr_buffer() {
>    ...
>    2) # 2463.980 us |  }
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> 
> Changes from v2:
> Sync the entire buffer in one go when the tracing is wrap around
> (Suzuki);
> Add Suzuki's review tage.
> 
> Changes from v1:
> Set "flat_buf->daddr" to 0 when fails to map DMA region; and dropped the
> unexpected if condition change in tmc_etr_free_flat_buf().
> 
>   .../hwtracing/coresight/coresight-tmc-etr.c   | 47 ++++++++++++++++---
>   1 file changed, 40 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 13fd1fc730ed..ac37e9376d2b 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -21,6 +21,7 @@
>   
>   struct etr_flat_buf {
>   	struct device	*dev;
> +	struct page	*pages;
>   	dma_addr_t	daddr;
>   	void		*vaddr;
>   	size_t		size;
> @@ -600,6 +601,7 @@ static int tmc_etr_alloc_flat_buf(struct tmc_drvdata *drvdata,
>   {
>   	struct etr_flat_buf *flat_buf;
>   	struct device *real_dev = drvdata->csdev->dev.parent;
> +	ssize_t	aligned_size;
>   
>   	/* We cannot reuse existing pages for flat buf */
>   	if (pages)
> @@ -609,11 +611,18 @@ static int tmc_etr_alloc_flat_buf(struct tmc_drvdata *drvdata,
>   	if (!flat_buf)
>   		return -ENOMEM;
>   
> -	flat_buf->vaddr = dma_alloc_coherent(real_dev, etr_buf->size,
> -					     &flat_buf->daddr, GFP_KERNEL);
> -	if (!flat_buf->vaddr) {
> -		kfree(flat_buf);
> -		return -ENOMEM;
> +	aligned_size = PAGE_ALIGN(etr_buf->size);
> +	flat_buf->pages = alloc_pages_node(node, GFP_KERNEL | __GFP_ZERO,
> +					   get_order(aligned_size));
> +	if (!flat_buf->pages)
> +		goto fail_alloc_pages;
> +
> +	flat_buf->vaddr = page_address(flat_buf->pages);
> +	flat_buf->daddr = dma_map_page(real_dev, flat_buf->pages, 0,
> +				       aligned_size, DMA_FROM_DEVICE);

Use dma_alloc_noncoherent() rather than open-coding this - bare 
alloc_pages() has no understanding of DMA masks, and you wouldn't want 
to end up in the worst case of dma_map_page() bounce-buffering your 
bounce buffer...

Robin.

> +	if (dma_mapping_error(real_dev, flat_buf->daddr)) {
> +		flat_buf->daddr = 0;
> +		goto fail_dma_map_page;
>   	}
>   
>   	flat_buf->size = etr_buf->size;
> @@ -622,6 +631,12 @@ static int tmc_etr_alloc_flat_buf(struct tmc_drvdata *drvdata,
>   	etr_buf->mode = ETR_MODE_FLAT;
>   	etr_buf->private = flat_buf;
>   	return 0;
> +
> +fail_dma_map_page:
> +	__free_pages(flat_buf->pages, get_order(aligned_size));
> +fail_alloc_pages:
> +	kfree(flat_buf);
> +	return -ENOMEM;
>   }
>   
>   static void tmc_etr_free_flat_buf(struct etr_buf *etr_buf)
> @@ -630,15 +645,20 @@ static void tmc_etr_free_flat_buf(struct etr_buf *etr_buf)
>   
>   	if (flat_buf && flat_buf->daddr) {
>   		struct device *real_dev = flat_buf->dev->parent;
> +		ssize_t aligned_size = PAGE_ALIGN(etr_buf->size);
>   
> -		dma_free_coherent(real_dev, flat_buf->size,
> -				  flat_buf->vaddr, flat_buf->daddr);
> +		dma_unmap_page(real_dev, flat_buf->daddr, aligned_size,
> +			       DMA_FROM_DEVICE);
> +		__free_pages(flat_buf->pages, get_order(aligned_size));
>   	}
>   	kfree(flat_buf);
>   }
>   
>   static void tmc_etr_sync_flat_buf(struct etr_buf *etr_buf, u64 rrp, u64 rwp)
>   {
> +	struct etr_flat_buf *flat_buf = etr_buf->private;
> +	struct device *real_dev = flat_buf->dev->parent;
> +
>   	/*
>   	 * Adjust the buffer to point to the beginning of the trace data
>   	 * and update the available trace data.
> @@ -648,6 +668,19 @@ static void tmc_etr_sync_flat_buf(struct etr_buf *etr_buf, u64 rrp, u64 rwp)
>   		etr_buf->len = etr_buf->size;
>   	else
>   		etr_buf->len = rwp - rrp;
> +
> +	/*
> +	 * The driver always starts tracing at the beginning of the buffer,
> +	 * the only reason why we would get a wrap around is when the buffer
> +	 * is full.  Sync the entire buffer in one go for this case.
> +	 */
> +	if (etr_buf->offset + etr_buf->len > etr_buf->size)
> +		dma_sync_single_for_cpu(real_dev, flat_buf->daddr,
> +					etr_buf->size, DMA_FROM_DEVICE);
> +	else
> +		dma_sync_single_for_cpu(real_dev,
> +					flat_buf->daddr + etr_buf->offset,
> +					etr_buf->len, DMA_FROM_DEVICE);
>   }
>   
>   static ssize_t tmc_etr_get_data_flat_buf(struct etr_buf *etr_buf,
> 
