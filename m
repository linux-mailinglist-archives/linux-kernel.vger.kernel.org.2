Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F2C3C5ACF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbhGLK2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 06:28:50 -0400
Received: from foss.arm.com ([217.140.110.172]:53130 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229725AbhGLK2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 06:28:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CE9C1FB;
        Mon, 12 Jul 2021 03:25:56 -0700 (PDT)
Received: from [10.57.35.32] (unknown [10.57.35.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 651863F694;
        Mon, 12 Jul 2021 03:25:55 -0700 (PDT)
Subject: Re: [PATCH 1/2] coresight: tmc-etr: Correct memory sync ranges in SG
 mode
To:     Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210710070206.462875-1-leo.yan@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <3038eb59-155c-5c3d-18e3-e45e56b52523@arm.com>
Date:   Mon, 12 Jul 2021 11:25:54 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210710070206.462875-1-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On 10/07/2021 08:02, Leo Yan wrote:
> Current code syncs the buffer range is [offset, offset+len), it doesn't
> consider the case when the trace data is wrapped around, in this case
> 'offset+len' is bigger than 'etr_buf->size'.  Thus it syncs buffer out
> of the memory buffer, and it also misses to sync buffer from the start
> of the memory.
> 

I doubt this claim is valid. We do the sync properly, taking the page
corresponding to the "offset" wrapping it around in "page" index.

Here is the code :



void tmc_sg_table_sync_data_range(struct tmc_sg_table *table,
                                   u64 offset, u64 size)
{
         int i, index, start;
         int npages = DIV_ROUND_UP(size, PAGE_SIZE);
         struct device *real_dev = table->dev->parent;
         struct tmc_pages *data = &table->data_pages;

         start = offset >> PAGE_SHIFT;
         for (i = start; i < (start + npages); i++) {
                 index = i % data->nr_pages;
                 dma_sync_single_for_cpu(real_dev, data->daddrs[index],
                                         PAGE_SIZE, DMA_FROM_DEVICE);
         }
}


See that the npages accounts for the "size" requested and we wrap the
"index" by the total number of pages in the buffer and pick the right
page.

So, I think this fix is not needed.

Cheers
Suzuki


> This patch corrects the memory sync ranges, when detects the wrapping
> around case, it splits into two chunks: one chunk is the tail of the
> buffer and another chunk is from the start of the buffer after wrapping
> around.
> 


> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>   .../hwtracing/coresight/coresight-tmc-etr.c    | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 888b0f929d33..a1afefcbf175 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -780,7 +780,23 @@ static void tmc_etr_sync_sg_buf(struct etr_buf *etr_buf, u64 rrp, u64 rwp)
>   	else
>   		etr_buf->len = ((w_offset < r_offset) ? etr_buf->size : 0) +
>   				w_offset - r_offset;
> -	tmc_sg_table_sync_data_range(table, r_offset, etr_buf->len);
> +
> +	if (r_offset + etr_buf->len > etr_buf->size) {
> +		int len1, len2;
> +
> +		/*
> +		 * If trace data is wrapped around, sync AUX bounce buffer
> +		 * for two chunks: "len1" is for the trace date length at
> +		 * the tail of bounce buffer, and "len2" is the length from
> +		 * the start of the buffer after wrapping around.
> +		 */
> +		len1 = etr_buf->size - r_offset;
> +		len2 = etr_buf->len - len1;
> +		tmc_sg_table_sync_data_range(table, r_offset, len1);
> +		tmc_sg_table_sync_data_range(table, 0, len2);
> +	} else {
> +		tmc_sg_table_sync_data_range(table, r_offset, etr_buf->len);
> +	}
>   }
>   
>   static const struct etr_buf_operations etr_sg_buf_ops = {
> 

