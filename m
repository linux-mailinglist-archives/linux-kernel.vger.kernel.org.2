Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89586432D7D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 07:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbhJSF51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 01:57:27 -0400
Received: from foss.arm.com ([217.140.110.172]:44698 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229742AbhJSF5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 01:57:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96E3E2F;
        Mon, 18 Oct 2021 22:55:07 -0700 (PDT)
Received: from [10.163.74.241] (unknown [10.163.74.241])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 572E93F73D;
        Mon, 18 Oct 2021 22:55:04 -0700 (PDT)
Subject: Re: [PATCH v5 12/15] coresight: trbe: Make sure we have enough space
To:     Suzuki K Poulose <suzuki.poulose@arm.com>, will@kernel.org,
        mathieu.poirier@linaro.org
Cc:     catalin.marinas@arm.com, mike.leach@linaro.org, leo.yan@linaro.org,
        maz@kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211014223125.2605031-1-suzuki.poulose@arm.com>
 <20211014223125.2605031-13-suzuki.poulose@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <2363663b-72b4-e249-49d1-b036866fc4fe@arm.com>
Date:   Tue, 19 Oct 2021 11:25:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211014223125.2605031-13-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/15/21 4:01 AM, Suzuki K Poulose wrote:
> The TRBE driver makes sure that there is enough space for a meaningful
> run, otherwise pads the given space and restarts the offset calculation
> once. But there is no guarantee that we may find space or hit "no space".
> Make sure that we repeat the step until, either :
>   - We have the minimum space
>    OR
>   - There is NO space at all.
> 
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  drivers/hwtracing/coresight/coresight-trbe.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 4a50309a892d..5fb9f49eab33 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -477,10 +477,14 @@ static unsigned long trbe_normal_offset(struct perf_output_handle *handle)
>  	 * If the head is too close to the limit and we don't
>  	 * have space for a meaningful run, we rather pad it
>  	 * and start fresh.
> +	 *
> +	 * We might have to do this more than once to make sure
> +	 * we have enough required space.
>  	 */
> -	if (limit && ((limit - head) < trbe_min_trace_buf_size(handle))) {
> +	while (limit && ((limit - head) < trbe_min_trace_buf_size(handle))) {
>  		trbe_pad_buf(handle, limit - head);
>  		limit = __trbe_normal_offset(handle);
> +		head = PERF_IDX2OFF(handle->head, buf);
>  	}
>  	return limit;
>  }
> 
