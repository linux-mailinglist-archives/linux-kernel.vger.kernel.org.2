Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F553DB274
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 06:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhG3Eqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 00:46:45 -0400
Received: from foss.arm.com ([217.140.110.172]:36388 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229609AbhG3Eqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 00:46:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1440331B;
        Thu, 29 Jul 2021 21:46:39 -0700 (PDT)
Received: from [10.163.66.9] (unknown [10.163.66.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AFB73F73D;
        Thu, 29 Jul 2021 21:46:36 -0700 (PDT)
Subject: Re: [PATCH v2 05/10] coresight: trbe: Drop duplicate TRUNCATE flags
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tamas.zsoldos@arm.com, al.grant@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, mathieu.poirier@linaro.org,
        jinlmao@qti.qualcomm.com
References: <20210723124611.3828908-1-suzuki.poulose@arm.com>
 <20210723124611.3828908-6-suzuki.poulose@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <0292cfc7-df67-aa45-4268-2ebc7f53420a@arm.com>
Date:   Fri, 30 Jul 2021 10:17:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210723124611.3828908-6-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/23/21 6:16 PM, Suzuki K Poulose wrote:
> We mark the buffer as TRUNCATED when there is no space left
> in the buffer. But we do it at different points.
>     __trbe_normal_offset()
> and also, at all the callers of the above function via
> compute_trbe_buffer_limit(), when the limit == base (i.e
> offset = 0 as returned by the __trbe_normal_offset()).
> 
> So, given that the callers already mark the buffer as TRUNCATED
> drop the caller inside the __trbe_normal_offset().
> 
> This is in preparation to moving the handling of TRUNCATED
> into a central place.
> 
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-trbe.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 446f080f8320..62e1a08f73ff 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -253,13 +253,9 @@ static unsigned long __trbe_normal_offset(struct perf_output_handle *handle)
>  	 * trbe_base				trbe_base + nr_pages
>  	 *
>  	 * Perf aux buffer does not have any space for the driver to write into.
> -	 * Just communicate trace truncation event to the user space by marking
> -	 * it with PERF_AUX_FLAG_TRUNCATED.
>  	 */
> -	if (!handle->size) {
> -		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
> +	if (!handle->size)
>  		return 0;
> -	}
>  
>  	/* Compute the tail and wakeup indices now that we've aligned head */
>  	tail = PERF_IDX2OFF(handle->head + handle->size, buf);
> @@ -361,7 +357,6 @@ static unsigned long __trbe_normal_offset(struct perf_output_handle *handle)
>  		return limit;
>  
>  	trbe_pad_buf(handle, handle->size);
> -	perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
>  	return 0;
>  }

What about in trbe_handle_spurious() path which used to set the flag via
compute_trbe_buffer_limit(), but would not any more after this change. I
guess following additional change would be required to preserve the past
behaviour.

--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -685,6 +685,7 @@ static void trbe_handle_spurious(struct perf_output_handle *handle)
        buf->trbe_write = buf->trbe_base + PERF_IDX2OFF(handle->head, buf);
        if (buf->trbe_limit == buf->trbe_base) {
                trbe_drain_and_disable_local();
+               perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
                return;
        }
        trbe_enable_hw(buf);
