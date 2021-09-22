Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA0F41458A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 11:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbhIVJwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 05:52:20 -0400
Received: from foss.arm.com ([217.140.110.172]:45890 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234308AbhIVJwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 05:52:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6734A11B3;
        Wed, 22 Sep 2021 02:50:47 -0700 (PDT)
Received: from [10.163.73.113] (unknown [10.163.73.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A90C3F719;
        Wed, 22 Sep 2021 02:50:43 -0700 (PDT)
Subject: Re: [PATCH v2 13/17] coresight: trbe: Add a helper to determine the
 minimum buffer size
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com, james.morse@arm.com,
        leo.yan@linaro.org, mike.leach@linaro.org,
        mathieu.poirier@linaro.org, will@kernel.org, lcherian@marvell.com,
        coresight@lists.linaro.org
References: <20210921134121.2423546-1-suzuki.poulose@arm.com>
 <20210921134121.2423546-14-suzuki.poulose@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <586a307e-a51d-d176-b9f9-fc730278317e@arm.com>
Date:   Wed, 22 Sep 2021 15:21:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210921134121.2423546-14-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/21/21 7:11 PM, Suzuki K Poulose wrote:
> For the TRBE to operate, we need a minimum space available to collect
> meaningful trace session. This is currently a few bytes, but we may need
> to extend this for working around errata. So, abstract this into a helper
> function.
> 
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-trbe.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 797d978f9fa7..3373f4e2183b 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -277,6 +277,11 @@ trbe_handle_to_cpudata(struct perf_output_handle *handle)
>  	return buf->cpudata;
>  }
>  
> +static u64 trbe_min_trace_buf_size(struct perf_output_handle *handle)
> +{
> +	return TRBE_TRACE_MIN_BUF_SIZE;
> +}

Assuming that struct perf_output_handle could provide all the
required support for a variable minimum trace buffer length.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> +
>  /*
>   * TRBE Limit Calculation
>   *
> @@ -447,7 +452,7 @@ static unsigned long trbe_normal_offset(struct perf_output_handle *handle)
>  	 * have space for a meaningful run, we rather pad it
>  	 * and start fresh.
>  	 */
> -	if (limit && (limit - head < TRBE_TRACE_MIN_BUF_SIZE)) {
> +	if (limit && ((limit - head) < trbe_min_trace_buf_size(handle))) {
>  		trbe_pad_buf(handle, limit - head);
>  		limit = __trbe_normal_offset(handle);
>  	}
> 
