Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A083841459F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 11:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbhIVJ6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 05:58:48 -0400
Received: from foss.arm.com ([217.140.110.172]:45970 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234413AbhIVJ6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 05:58:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7246A11B3;
        Wed, 22 Sep 2021 02:57:17 -0700 (PDT)
Received: from [10.163.73.113] (unknown [10.163.73.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3F0D3F719;
        Wed, 22 Sep 2021 02:57:13 -0700 (PDT)
Subject: Re: [PATCH v2 14/17] coresight: trbe: Make sure we have enough space
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com, james.morse@arm.com,
        leo.yan@linaro.org, mike.leach@linaro.org,
        mathieu.poirier@linaro.org, will@kernel.org, lcherian@marvell.com,
        coresight@lists.linaro.org
References: <20210921134121.2423546-1-suzuki.poulose@arm.com>
 <20210921134121.2423546-15-suzuki.poulose@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <60e75e7b-4a04-03d4-c861-88dd5fadef99@arm.com>
Date:   Wed, 22 Sep 2021 15:28:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210921134121.2423546-15-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/21/21 7:11 PM, Suzuki K Poulose wrote:
> The TRBE driver makes sure that there is enough space for a meaningful
> run, otherwise pads the given space and restarts the offset calculation
> once. But there is no guarantee that we may find space or hit "no space".

So what happens currently when it neither finds the required minimum buffer
space for a meaningful run nor does it hit the "no space" scenario ?

> Make sure that we repeat the step until, either :
>   - We have the minimum space
>    OR
>   - There is NO space at all.
> 
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-trbe.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 3373f4e2183b..02f9e00e2091 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -451,10 +451,14 @@ static unsigned long trbe_normal_offset(struct perf_output_handle *handle)
>  	 * If the head is too close to the limit and we don't
>  	 * have space for a meaningful run, we rather pad it
>  	 * and start fresh.
> +	 *
> +	 * We might have to do this more than once to make sure
> +	 * we have enough required space.

OR no space at all, as explained in the commit message.
Hence this comment needs an update.

>  	 */
> -	if (limit && ((limit - head) < trbe_min_trace_buf_size(handle))) {
> +	while (limit && ((limit - head) < trbe_min_trace_buf_size(handle))) {
>  		trbe_pad_buf(handle, limit - head);
>  		limit = __trbe_normal_offset(handle);
> +		head = PERF_IDX2OFF(handle->head, buf);

Should the loop be bound with a retry limit as well ?

>  	}
>  	return limit;
>  }
> 
