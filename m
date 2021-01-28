Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2C4307D4F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhA1SCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:02:40 -0500
Received: from foss.arm.com ([217.140.110.172]:36818 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231416AbhA1SBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:01:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8E9313A1;
        Thu, 28 Jan 2021 10:01:02 -0800 (PST)
Received: from [10.57.35.163] (unknown [10.57.35.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B34273F719;
        Thu, 28 Jan 2021 10:00:59 -0800 (PST)
Subject: Re: [PATCH 3/3] Adding device_dma_parameters->offset_preserve_mask to
 NVMe driver.
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
 <20210128003829.1892018-4-jxgao@google.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <0550ca25-1389-ffc2-e738-8127ceb1712f@arm.com>
Date:   Thu, 28 Jan 2021 18:00:58 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210128003829.1892018-4-jxgao@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-28 00:38, Jianxiong Gao wrote:
> NVMe driver relies on the address offset to function properly.
> This patch adds the offset preserve mask to NVMe driver when mapping
> via dma_map_sg_attrs and unmapping via nvme_unmap_sg. The mask
> depends on the page size defined by CC.MPS register of NVMe
> controller.
> 
> Signed-off-by: Jianxiong Gao <jxgao@google.com>
> ---
>   drivers/nvme/host/pci.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 856aa31931c1..0b23f04068be 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -580,12 +580,15 @@ static void nvme_free_sgls(struct nvme_dev *dev, struct request *req)
>   static void nvme_unmap_sg(struct nvme_dev *dev, struct request *req)
>   {
>   	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> -
> +	if (dma_set_page_offset_mask(dev->dev, NVME_CTRL_PAGE_SIZE - 1))
> +		dev_warn(dev->dev, "dma_set_page_offset_mask failed to set offset\n");
>   	if (is_pci_p2pdma_page(sg_page(iod->sg)))
>   		pci_p2pdma_unmap_sg(dev->dev, iod->sg, iod->nents,
>   				    rq_dma_dir(req));
>   	else
>   		dma_unmap_sg(dev->dev, iod->sg, iod->nents, rq_dma_dir(req));
> +	if (dma_set_page_offset_mask(dev->dev, 0))
> +		dev_warn(dev->dev, "dma_set_page_offset_mask failed to reset offset\n");
>   }
>   
>   static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
> @@ -842,7 +845,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>   {
>   	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>   	blk_status_t ret = BLK_STS_RESOURCE;
> -	int nr_mapped;
> +	int nr_mapped, offset_ret;
>   
>   	if (blk_rq_nr_phys_segments(req) == 1) {
>   		struct bio_vec bv = req_bvec(req);
> @@ -868,12 +871,24 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>   	if (!iod->nents)
>   		goto out_free_sg;
>   
> +	offset_ret = dma_set_page_offset_mask(dev->dev, NVME_CTRL_PAGE_SIZE - 1);
> +	if (offset_ret) {
> +		dev_warn(dev->dev, "dma_set_page_offset_mask failed to set offset\n");
> +		goto out_free_sg;
> +	}
> +
>   	if (is_pci_p2pdma_page(sg_page(iod->sg)))
>   		nr_mapped = pci_p2pdma_map_sg_attrs(dev->dev, iod->sg,
>   				iod->nents, rq_dma_dir(req), DMA_ATTR_NO_WARN);
>   	else
>   		nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents,
>   					     rq_dma_dir(req), DMA_ATTR_NO_WARN);
> +
> +	offset_ret = dma_set_page_offset_mask(dev->dev, 0);
> +	if (offset_ret) {
> +		dev_warn(dev->dev, "dma_set_page_offset_mask failed to reset offset\n");
> +		goto out_free_sg;

If it were possible for this to fail, you might leak the DMA mapping 
here. However if dev->dma_parms somehow disappeared since a dozen lines 
above then I think you've got far bigger problems anyway.

That said, do you really need to keep toggling this back and forth all 
the time? Even if the device does make other mappings elsewhere that 
don't necessarily need the same strict alignment, would it be 
significantly harmful just to set it once at probe and leave it in place 
anyway?

Robin.

> +	}
>   	if (!nr_mapped)
>   		goto out_free_sg;
>   
> 
