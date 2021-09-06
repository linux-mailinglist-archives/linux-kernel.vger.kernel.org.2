Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3091401949
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 11:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241682AbhIFJwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 05:52:12 -0400
Received: from foss.arm.com ([217.140.110.172]:54268 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241287AbhIFJwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 05:52:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B93E3D6E;
        Mon,  6 Sep 2021 02:51:06 -0700 (PDT)
Received: from [10.57.92.222] (unknown [10.57.92.222])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74BD13F73D;
        Mon,  6 Sep 2021 02:51:05 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] coresight: Update comments for removing
 cs_etm_find_snapshot()
To:     Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210905131237.1035322-1-leo.yan@linaro.org>
 <20210905131237.1035322-3-leo.yan@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <4db83b64-445d-2a04-a130-fd95f9157702@arm.com>
Date:   Mon, 6 Sep 2021 10:51:02 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210905131237.1035322-3-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo


On 05/09/2021 14:12, Leo Yan wrote:
> Commit 2f01c200d440 ("perf cs-etm: Remove callback cs_etm_find_snapshot()")
> has removed the function cs_etm_find_snapshot() from the perf tool in the
> user space, now CoreSight trace directly uses the perf common function
> __auxtrace_mmap__read() to calcualte the head and size for AUX trace data
> in snapshot mode.
> 
> Updates the comments in drivers to reflect the changes.

As such I would avoid referencing "userspace" function names in the
kernel driver. Please could we remove it or make it generic ?

Also, remember, perf is not the only userspace tool driving the kernel
perf.

Cheers
Suzuki

> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>   drivers/hwtracing/coresight/coresight-etb10.c   | 2 +-
>   drivers/hwtracing/coresight/coresight-tmc-etf.c | 2 +-
>   drivers/hwtracing/coresight/coresight-tmc-etr.c | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index f775cbee12b8..1cdb627d6c38 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -557,7 +557,7 @@ static unsigned long etb_update_buffer(struct coresight_device *csdev,
>   
>   	/*
>   	 * In snapshot mode we simply increment the head by the number of byte
> -	 * that were written.  User space function  cs_etm_find_snapshot() will
> +	 * that were written.  User space function __auxtrace_mmap__read() will
>   	 * figure out how many bytes to get from the AUX buffer based on the
>   	 * position of the head.
>   	 */
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index cd0fb7bfba68..a895931a2766 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -546,7 +546,7 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
>   
>   	/*
>   	 * In snapshot mode we simply increment the head by the number of byte
> -	 * that were written.  User space function  cs_etm_find_snapshot() will
> +	 * that were written.  User space function __auxtrace_mmap__read() will
>   	 * figure out how many bytes to get from the AUX buffer based on the
>   	 * position of the head.
>   	 */
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index d23c7690f29a..941abb70b827 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -1573,7 +1573,7 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
>   
>   	/*
>   	 * In snapshot mode we simply increment the head by the number of byte
> -	 * that were written.  User space function  cs_etm_find_snapshot() will
> +	 * that were written.  User space function __auxtrace_mmap__read() will
>   	 * figure out how many bytes to get from the AUX buffer based on the
>   	 * position of the head.
>   	 */
> 

