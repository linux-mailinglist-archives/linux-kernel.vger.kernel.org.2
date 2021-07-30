Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1484F3DB2EB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 07:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236642AbhG3Fj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 01:39:59 -0400
Received: from foss.arm.com ([217.140.110.172]:37138 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233424AbhG3Fj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 01:39:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F0C81FB;
        Thu, 29 Jul 2021 22:39:54 -0700 (PDT)
Received: from [10.163.66.9] (unknown [10.163.66.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68A773F73D;
        Thu, 29 Jul 2021 22:39:51 -0700 (PDT)
Subject: Re: [PATCH v2 08/10] coresight: trbe: Unify the enabling sequence
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tamas.zsoldos@arm.com, al.grant@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, mathieu.poirier@linaro.org,
        jinlmao@qti.qualcomm.com
References: <20210723124611.3828908-1-suzuki.poulose@arm.com>
 <20210723124611.3828908-9-suzuki.poulose@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <f24ad9f5-f26a-c49c-2d43-dd3c8c1a4772@arm.com>
Date:   Fri, 30 Jul 2021 11:10:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210723124611.3828908-9-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/23/21 6:16 PM, Suzuki K Poulose wrote:
> Unify the sequence of enabling the TRBE. We do this from
> event_start and also from the TRBE IRQ handler. Lets move
> this to a common helper. The only minor functional change
> is returning an error when we fail to enable the TRBE.
> This should be handled already.
> 
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-trbe.c | 34 +++++++++++---------
>  1 file changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index d50f142e86d1..6d6aad171c72 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -632,6 +632,20 @@ static unsigned long arm_trbe_update_buffer(struct coresight_device *csdev,
>  	return size;
>  }
>  
> +static int __arm_trbe_enable(struct trbe_buf *buf,
> +			     struct perf_output_handle *handle)
> +{
> +	buf->trbe_limit = compute_trbe_buffer_limit(handle);
> +	buf->trbe_write = buf->trbe_base + PERF_IDX2OFF(handle->head, buf);
> +	if (buf->trbe_limit == buf->trbe_base) {
> +		trbe_stop_and_truncate_event(handle);
> +		return -ENOSPC;
> +	}
> +	*this_cpu_ptr(buf->cpudata->drvdata->handle) = handle;
> +	trbe_enable_hw(buf);
> +	return 0;
> +}
> +
>  static int arm_trbe_enable(struct coresight_device *csdev, u32 mode, void *data)
>  {
>  	struct trbe_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> @@ -648,14 +662,8 @@ static int arm_trbe_enable(struct coresight_device *csdev, u32 mode, void *data)

There is this (now) redundant assignment which needs to be dropped.

*this_cpu_ptr(buf->cpudata->drvdata->handle) = handle;

>  	cpudata->buf = buf;
>  	cpudata->mode = mode;
>  	buf->cpudata = cpudata;> -	buf->trbe_limit = compute_trbe_buffer_limit(handle);
> -	buf->trbe_write = buf->trbe_base + PERF_IDX2OFF(handle->head, buf);
> -	if (buf->trbe_limit == buf->trbe_base) {
> -		trbe_stop_and_truncate_event(handle);
> -		return 0;
> -	}
> -	trbe_enable_hw(buf);
> -	return 0;
> +
> +	return __arm_trbe_enable(buf, handle);
>  }
>  
>  static int arm_trbe_disable(struct coresight_device *csdev)
> @@ -722,14 +730,8 @@ static void trbe_handle_overflow(struct perf_output_handle *handle)
>  		*this_cpu_ptr(buf->cpudata->drvdata->handle) = NULL;
>  		return;
>  	}
> -	buf->trbe_limit = compute_trbe_buffer_limit(handle);
> -	buf->trbe_write = buf->trbe_base + PERF_IDX2OFF(handle->head, buf);
> -	if (buf->trbe_limit == buf->trbe_base) {
> -		trbe_stop_and_truncate_event(handle);
> -		return;
> -	}
> -	*this_cpu_ptr(buf->cpudata->drvdata->handle) = handle;
> -	trbe_enable_hw(buf);
> +
> +	__arm_trbe_enable(buf, handle);
>  }
>  
>  static bool is_perf_trbe(struct perf_output_handle *handle)
> 
With that, this clean up makes sense.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
