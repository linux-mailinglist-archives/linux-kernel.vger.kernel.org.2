Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D143DB2FB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 07:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236603AbhG3FyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 01:54:04 -0400
Received: from foss.arm.com ([217.140.110.172]:37308 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229948AbhG3FyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 01:54:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96D0D31B;
        Thu, 29 Jul 2021 22:53:58 -0700 (PDT)
Received: from [10.163.66.9] (unknown [10.163.66.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D7333F66F;
        Thu, 29 Jul 2021 22:53:55 -0700 (PDT)
Subject: Re: [PATCH v2 09/10] coresight: trbe: End the AUX handle on
 truncation
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tamas.zsoldos@arm.com, al.grant@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, mathieu.poirier@linaro.org,
        jinlmao@qti.qualcomm.com, Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
References: <20210723124611.3828908-1-suzuki.poulose@arm.com>
 <20210723124611.3828908-10-suzuki.poulose@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <d7c68b50-1537-32d9-6803-cf0c5973c880@arm.com>
Date:   Fri, 30 Jul 2021 11:24:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210723124611.3828908-10-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/23/21 6:16 PM, Suzuki K Poulose wrote:
> When we detect that there isn't enough space left to start
> a meaningful session, we disable the TRBE, marking the buffer
> as TRUNCATED. But we delay the notification to the perf layer
> by perf_aux_output_end() until the event is scheduled out.

via the CoreSight PMU layer's stop event ?

> This will cause significant black outs in the trace. Now that
> the CoreSight PMU layer can handle a closed "AUX" handle
> properly, we can close the handle as soon as we detect the
> case, allowing the userspace to collect and re-enable the
> event.
> 
> Also, while in the IRQ handler, move the irq_work_run() after
> we have updated the handle, to make sure the "TRUNCATED" flag
> causes the event to be disabled as soon as possible.

Makes sense.

Minor nit. Commit message here should be reformatted to be expanded
upto 75 character width.

> 
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-trbe.c | 25 ++++++++++++--------
>  1 file changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 6d6aad171c72..e7567727e8fc 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -134,6 +134,7 @@ static void trbe_stop_and_truncate_event(struct perf_output_handle *handle)
>  	trbe_drain_and_disable_local();
>  	perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED |
>  				     PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW);
> +	perf_aux_output_end(handle, 0);
>  	*this_cpu_ptr(buf->cpudata->drvdata->handle) = NULL;
>  }
>  
> @@ -699,7 +700,7 @@ static void trbe_handle_spurious(struct perf_output_handle *handle)
>  	isb();
>  }
>  
> -static void trbe_handle_overflow(struct perf_output_handle *handle)
> +static int trbe_handle_overflow(struct perf_output_handle *handle)
>  {
>  	struct perf_event *event = handle->event;
>  	struct trbe_buf *buf = etm_perf_sink_config(handle);
> @@ -728,10 +729,10 @@ static void trbe_handle_overflow(struct perf_output_handle *handle)
>  		 */
>  		trbe_drain_and_disable_local();
>  		*this_cpu_ptr(buf->cpudata->drvdata->handle) = NULL;
> -		return;
> +		return -EINVAL;
>  	}
>  
> -	__arm_trbe_enable(buf, handle);
> +	return __arm_trbe_enable(buf, handle);
>  }
>  
>  static bool is_perf_trbe(struct perf_output_handle *handle)
> @@ -762,6 +763,7 @@ static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
>  	struct perf_output_handle *handle = *handle_ptr;
>  	enum trbe_fault_action act;
>  	u64 status;
> +	bool truncated = false;
>  
>  	/* Reads to TRBSR_EL1 is fine when TRBE is active */
>  	status = read_sysreg_s(SYS_TRBSR_EL1);
> @@ -786,24 +788,27 @@ static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
>  	if (!is_perf_trbe(handle))
>  		return IRQ_NONE;
>  
> -	/*
> -	 * Ensure perf callbacks have completed, which may disable
> -	 * the trace buffer in response to a TRUNCATION flag.
> -	 */
> -	irq_work_run();
> -
>  	act = trbe_get_fault_act(status);
>  	switch (act) {
>  	case TRBE_FAULT_ACT_WRAP:
> -		trbe_handle_overflow(handle);
> +		truncated = !!trbe_handle_overflow(handle);
>  		break;
>  	case TRBE_FAULT_ACT_SPURIOUS:
>  		trbe_handle_spurious(handle);
>  		break;
>  	case TRBE_FAULT_ACT_FATAL:
>  		trbe_stop_and_truncate_event(handle);
> +		truncated = true;
>  		break;
>  	}
> +
> +	/*
> +	 * If the buffer was truncated, ensure perf callbacks
> +	 * have completed, which will disable the event.
> +	 */
> +	if (truncated)
> +		irq_work_run();
> +
>  	return IRQ_HANDLED;
>  }
>  
> 

LGTM.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
