Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739F43C5AD0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbhGLK3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 06:29:50 -0400
Received: from foss.arm.com ([217.140.110.172]:53148 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232768AbhGLK3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 06:29:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 528A31FB;
        Mon, 12 Jul 2021 03:26:55 -0700 (PDT)
Received: from [10.57.35.32] (unknown [10.57.35.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FE183F694;
        Mon, 12 Jul 2021 03:26:54 -0700 (PDT)
Subject: Re: [PATCH 2/2] coresight: catu: Correct memory sync ranges in catu
 mode
To:     Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210710070206.462875-1-leo.yan@linaro.org>
 <20210710070206.462875-2-leo.yan@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <8cdca2d5-5759-b3fd-be69-a596be384c2c@arm.com>
Date:   Mon, 12 Jul 2021 11:26:52 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210710070206.462875-2-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On 10/07/2021 08:02, Leo Yan wrote:
> Current code misses to handle the case for the trace wrapping around,
> thus it fails to sync the complete memory ranges in catu mode.
> 

Similar to the tmc-sg, the infrastructure take care of wrapping the page
indices to sync the correct memory.

Suzuki


> This patch corrects the memory sync ranges, when detects the wrapping
> around case, it splits into two chunks: one chunk is the tail of the
> buffer and another chunk is from the start of the buffer after wrapping
> around.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>   drivers/hwtracing/coresight/coresight-catu.c | 19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
> index e0740c6dbd54..634af451f0d3 100644
> --- a/drivers/hwtracing/coresight/coresight-catu.c
> +++ b/drivers/hwtracing/coresight/coresight-catu.c
> @@ -323,7 +323,24 @@ static void catu_sync_etr_buf(struct etr_buf *etr_buf, u64 rrp, u64 rwp)
>   	}
>   
>   	etr_buf->offset = r_offset;
> -	tmc_sg_table_sync_data_range(catu_table, r_offset, etr_buf->len);
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
> +		tmc_sg_table_sync_data_range(catu_table, r_offset, len1);
> +		tmc_sg_table_sync_data_range(catu_table, 0, len2);
> +	} else {
> +		tmc_sg_table_sync_data_range(catu_table, r_offset,
> +					     etr_buf->len);
> +	}
>   }
>   
>   static int catu_alloc_etr_buf(struct tmc_drvdata *tmc_drvdata,
> 

