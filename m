Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31D730B1C8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 21:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbhBAU6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 15:58:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:47430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229567AbhBAU6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 15:58:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80C2564ECB;
        Mon,  1 Feb 2021 20:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612213083;
        bh=r/E49oyGnfm/yoB373RLEccYiXcRJsRAzM4O/KWNyro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MLNeG0uT1Jizxo/VSvEhaAFbENEPr3J3pVkEdTCXFnvp45+WXkRwuNYXZHiAbEQGL
         6r1vEHo72+yRV52MMdhEHETflCkFaA0zrY6YOtIl04a6LZyRIqgT+M6gFXjQhlqT0+
         iwxX1RGiP8hYyW8VCRNPNNSsxjw3AukWLTiVCLhELHR8drIrbmn0W4IznkIxMTD1Qv
         rVRNQqXpzLZJpU/B2IleHHNXcuUdZkteH6tzkEOMz21XK+6r1oGilNaArkXU7QYvFd
         8nX95YK7aByx+7b9Ch/nQO6Z17wJiZo6/g+UhrvQeL1WWPQQKtc362kVfMuZwVDoa2
         JqITgx85QiJfA==
Date:   Mon, 1 Feb 2021 12:57:59 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Jianxiong Gao <jxgao@google.com>
Cc:     erdemaktas@google.com, marcorr@google.com, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        gregkh@linuxfoundation.org, saravanak@google.com,
        heikki.krogerus@linux.intel.com, rafael.j.wysocki@intel.com,
        andriy.shevchenko@linux.intel.com, dan.j.williams@intel.com,
        bgolaszewski@baylibre.com, jroedel@suse.de,
        iommu@lists.linux-foundation.org, konrad.wilk@oracle.com,
        axboe@fb.com, sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 3/3] Adding
 device_dma_parameters->offset_preserve_mask to NVMe driver.
Message-ID: <20210201205759.GA2128135@dhcp-10-100-145-180.wdc.com>
References: <20210201183017.3339130-1-jxgao@google.com>
 <20210201183017.3339130-4-jxgao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201183017.3339130-4-jxgao@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 10:30:17AM -0800, Jianxiong Gao wrote:
> @@ -868,12 +871,24 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>  	if (!iod->nents)
>  		goto out_free_sg;
>  
> +	offset_ret = dma_set_min_align_mask(dev->dev, NVME_CTRL_PAGE_SIZE - 1);
> +	if (offset_ret) {
> +		dev_warn(dev->dev, "dma_set_min_align_mask failed to set offset\n");
> +		goto out_free_sg;
> +	}
> +
>  	if (is_pci_p2pdma_page(sg_page(iod->sg)))
>  		nr_mapped = pci_p2pdma_map_sg_attrs(dev->dev, iod->sg,
>  				iod->nents, rq_dma_dir(req), DMA_ATTR_NO_WARN);
>  	else
>  		nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents,
>  					     rq_dma_dir(req), DMA_ATTR_NO_WARN);
> +
> +	offset_ret = dma_set_min_align_mask(dev->dev, 0);
> +	if (offset_ret) {
> +		dev_warn(dev->dev, "dma_set_min_align_mask failed to reset offset\n");
> +		goto out_free_sg;
> +	}
>  	if (!nr_mapped)
>  		goto out_free_sg;

Why is this setting being done and undone on each IO? Wouldn't it be
more efficient to set it once during device initialization?

And more importantly, this isn't thread safe: one CPU may be setting the
device's dma alignment mask to 0 while another CPU is expecting it to be
NVME_CTRL_PAGE_SIZE - 1.
