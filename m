Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC8340AAD4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 11:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbhINJ3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 05:29:24 -0400
Received: from foss.arm.com ([217.140.110.172]:41950 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230303AbhINJ26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 05:28:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 532941FB;
        Tue, 14 Sep 2021 02:27:29 -0700 (PDT)
Received: from [10.57.94.84] (unknown [10.57.94.84])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 372493F719;
        Tue, 14 Sep 2021 02:27:28 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] coresight: Update comments for removing
 cs_etm_find_snapshot()
To:     Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210912125748.2816606-1-leo.yan@linaro.org>
 <20210912125748.2816606-3-leo.yan@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <f6700a4d-80e1-cd53-232c-0e26f7179d1b@arm.com>
Date:   Tue, 14 Sep 2021 10:27:26 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210912125748.2816606-3-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2021 13:57, Leo Yan wrote:
> Commit 2f01c200d440 ("perf cs-etm: Remove callback cs_etm_find_snapshot()")
> has removed the function cs_etm_find_snapshot() from the perf tool in the
> user space, now CoreSight trace directly uses the perf common function
> __auxtrace_mmap__read() to calcualte the head and size for AUX trace data
> in snapshot mode.
> 
> This patch updates the comments in drivers to make them generic and not
> stick to any specific function from perf tool.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>   drivers/hwtracing/coresight/coresight-etb10.c   | 5 ++---
>   drivers/hwtracing/coresight/coresight-tmc-etf.c | 5 ++---
>   drivers/hwtracing/coresight/coresight-tmc-etr.c | 5 ++---
>   3 files changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index f775cbee12b8..efa39820acec 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -557,9 +557,8 @@ static unsigned long etb_update_buffer(struct coresight_device *csdev,
>   
>   	/*
>   	 * In snapshot mode we simply increment the head by the number of byte
> -	 * that were written.  User space function  cs_etm_find_snapshot() will
> -	 * figure out how many bytes to get from the AUX buffer based on the
> -	 * position of the head.
> +	 * that were written.  User space will figure out how many bytes to get
> +	 * from the AUX buffer based on the position of the head.
>   	 */
>   	if (buf->snapshot)
>   		handle->head += to_read;
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index cd0fb7bfba68..b416b1951d3e 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -546,9 +546,8 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
>   
>   	/*
>   	 * In snapshot mode we simply increment the head by the number of byte
> -	 * that were written.  User space function  cs_etm_find_snapshot() will
> -	 * figure out how many bytes to get from the AUX buffer based on the
> -	 * position of the head.
> +	 * that were written.  User space will figure out how many bytes to get
> +	 * from the AUX buffer based on the position of the head.
>   	 */
>   	if (buf->snapshot)
>   		handle->head += to_read;
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index d23c7690f29a..ce14eb83925c 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -1573,9 +1573,8 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
>   
>   	/*
>   	 * In snapshot mode we simply increment the head by the number of byte
> -	 * that were written.  User space function  cs_etm_find_snapshot() will
> -	 * figure out how many bytes to get from the AUX buffer based on the
> -	 * position of the head.
> +	 * that were written.  User space will figure out how many bytes to get
> +	 * from the AUX buffer based on the position of the head.
>   	 */
>   	if (etr_perf->snapshot)
>   		handle->head += size;
> 


Thanks for the revised patch, I have queued both the patches.

Kind regards
Suzuki

