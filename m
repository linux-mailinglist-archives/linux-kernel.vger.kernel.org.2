Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756D4307C80
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 18:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbhA1Ram (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 12:30:42 -0500
Received: from foss.arm.com ([217.140.110.172]:36260 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233033AbhA1R2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 12:28:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5065A13A1;
        Thu, 28 Jan 2021 09:27:29 -0800 (PST)
Received: from [10.57.35.163] (unknown [10.57.35.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A1EC3F7C3;
        Thu, 28 Jan 2021 09:27:26 -0800 (PST)
Subject: Re: [PATCH 1/3] Adding page_offset_mask to device_dma_parameters
To:     Jianxiong Gao <jxgao@google.com>, erdemaktas@google.com,
        marcorr@google.com, hch@lst.de, m.szyprowski@samsung.com,
        gregkh@linuxfoundation.org, saravanak@google.com,
        heikki.krogerus@linux.intel.com, rafael.j.wysocki@intel.com,
        andriy.shevchenko@linux.intel.com, dan.j.williams@intel.com,
        bgolaszewski@baylibre.com, jroedel@suse.de,
        iommu@lists.linux-foundation.org, konrad.wilk@oracle.com,
        kbusch@kernel.org, axboe@fb.com, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210128003829.1892018-1-jxgao@google.com>
 <20210128003829.1892018-2-jxgao@google.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <2863b6d2-47f6-51fa-f60c-ba24904818e9@arm.com>
Date:   Thu, 28 Jan 2021 17:27:25 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210128003829.1892018-2-jxgao@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-28 00:38, Jianxiong Gao wrote:
> Some devices rely on the address offset in a page to function
> correctly (NVMe driver as an example). These devices may use
> a different page size than the Linux kernel. The address offset
> has to be preserved upon mapping, and in order to do so, we
> need to record the page_offset_mask first.
> 
> Signed-off-by: Jianxiong Gao <jxgao@google.com>
> ---
>   include/linux/device.h      |  1 +
>   include/linux/dma-mapping.h | 17 +++++++++++++++++
>   2 files changed, 18 insertions(+)
> 
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 1779f90eeb4c..f44e0659fc66 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -292,6 +292,7 @@ struct device_dma_parameters {
>   	 */
>   	unsigned int max_segment_size;
>   	unsigned long segment_boundary_mask;
> +	unsigned int page_offset_mask;

Could we call this something more like "min_align_mask" (sorry, I can't 
think of a name that's actually good and descriptive right now). 
Essentially I worry that having "page" in there is going to be too easy 
to misinterpret as having anything to do what "page" means almost 
everywhere else (even before you throw IOMMU pages into the mix).

Also note that of all the possible ways to pack two ints and a long, 
this one is the worst ;)

Robin.

>   };
>   
>   /**
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 2e49996a8f39..5529a31fefba 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -500,6 +500,23 @@ static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
>   	return -EIO;
>   }
>   
> +static inline unsigned int dma_get_page_offset_mask(struct device *dev)
> +{
> +	if (dev->dma_parms)
> +		return dev->dma_parms->page_offset_mask;
> +	return 0;
> +}
> +
> +static inline int dma_set_page_offset_mask(struct device *dev,
> +		unsigned int page_offset_mask)
> +{
> +	if (dev->dma_parms) {
> +		dev->dma_parms->page_offset_mask = page_offset_mask;
> +		return 0;
> +	}
> +	return -EIO;
> +}
> +
>   static inline int dma_get_cache_alignment(void)
>   {
>   #ifdef ARCH_DMA_MINALIGN
> 
