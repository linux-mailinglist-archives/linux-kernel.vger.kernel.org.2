Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBD13DB68F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 12:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238371AbhG3KCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 06:02:11 -0400
Received: from foss.arm.com ([217.140.110.172]:39828 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230160AbhG3KBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 06:01:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3BBC1FB;
        Fri, 30 Jul 2021 03:01:12 -0700 (PDT)
Received: from [10.163.66.9] (unknown [10.163.66.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50CB13F73D;
        Fri, 30 Jul 2021 03:01:08 -0700 (PDT)
Subject: Re: [PATCH 02/10] coresight: trbe: Add a helper to calculate the
 trace generated
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        will@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, maz@kernel.org, mark.rutland@arm.com
References: <20210728135217.591173-1-suzuki.poulose@arm.com>
 <20210728135217.591173-3-suzuki.poulose@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <3f3643fc-95b5-43b2-c512-72a7357f9ca8@arm.com>
Date:   Fri, 30 Jul 2021 15:31:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210728135217.591173-3-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/21 7:22 PM, Suzuki K Poulose wrote:
> We collect the trace from the TRBE on FILL event from IRQ context
> and when via update_buffer(), when the event is stopped. Let us
> consolidate how we calculate the trace generated into a helper.
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-trbe.c | 48 ++++++++++++--------
>  1 file changed, 30 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 0368bf405e35..a0168ad204b3 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -528,6 +528,30 @@ static enum trbe_fault_action trbe_get_fault_act(u64 trbsr)
>  	return TRBE_FAULT_ACT_SPURIOUS;
>  }
>  
> +static unsigned long trbe_get_trace_size(struct perf_output_handle *handle,
> +					 struct trbe_buf *buf,
> +					 bool wrap)
> +{
> +	u64 write;
> +	u64 start_off, end_off;
> +
> +	/*
> +	 * If the TRBE has wrapped around the write pointer has
> +	 * wrapped and should be treated as limit.
> +	 */
> +	if (wrap)
> +		write = get_trbe_limit_pointer();
> +	else
> +		write = get_trbe_write_pointer();
> +
> +	end_off = write - buf->trbe_base;
> +	start_off = PERF_IDX2OFF(handle->head, buf);
> +
> +	if (WARN_ON_ONCE(end_off < start_off))
> +		return 0;
> +	return (end_off - start_off);
> +}
> +
>  static void *arm_trbe_alloc_buffer(struct coresight_device *csdev,
>  				   struct perf_event *event, void **pages,
>  				   int nr_pages, bool snapshot)
> @@ -589,9 +613,9 @@ static unsigned long arm_trbe_update_buffer(struct coresight_device *csdev,
>  	struct trbe_cpudata *cpudata = dev_get_drvdata(&csdev->dev);
>  	struct trbe_buf *buf = config;
>  	enum trbe_fault_action act;
> -	unsigned long size, offset;
> -	unsigned long write, base, status;
> +	unsigned long size, status;
>  	unsigned long flags;
> +	bool wrap = false;
>  
>  	WARN_ON(buf->cpudata != cpudata);
>  	WARN_ON(cpudata->cpu != smp_processor_id());
> @@ -633,8 +657,6 @@ static unsigned long arm_trbe_update_buffer(struct coresight_device *csdev,
>  	 * handle gets freed in etm_event_stop().
>  	 */
>  	trbe_drain_and_disable_local();
> -	write = get_trbe_write_pointer();
> -	base = get_trbe_base_pointer();
>  
>  	/* Check if there is a pending interrupt and handle it here */
>  	status = read_sysreg_s(SYS_TRBSR_EL1);
> @@ -658,20 +680,11 @@ static unsigned long arm_trbe_update_buffer(struct coresight_device *csdev,
>  			goto done;
>  		}
>  
> -		/*
> -		 * Otherwise, the buffer is full and the write pointer
> -		 * has reached base. Adjust this back to the Limit pointer
> -		 * for correct size. Also, mark the buffer truncated.
> -		 */
> -		write = get_trbe_limit_pointer();
>  		perf_aux_output_flag(handle, PERF_AUX_FLAG_COLLISION);
> +		wrap = true;
>  	}
>  
> -	offset = write - base;
> -	if (WARN_ON_ONCE(offset < PERF_IDX2OFF(handle->head, buf)))
> -		size = 0;
> -	else
> -		size = offset - PERF_IDX2OFF(handle->head, buf);
> +	size = trbe_get_trace_size(handle, buf, wrap);
>  
>  done:
>  	local_irq_restore(flags);
> @@ -752,11 +765,10 @@ static int trbe_handle_overflow(struct perf_output_handle *handle)
>  {
>  	struct perf_event *event = handle->event;
>  	struct trbe_buf *buf = etm_perf_sink_config(handle);
> -	unsigned long offset, size;
> +	unsigned long size;
>  	struct etm_event_data *event_data;
>  
> -	offset = get_trbe_limit_pointer() - get_trbe_base_pointer();
> -	size = offset - PERF_IDX2OFF(handle->head, buf);
> +	size = trbe_get_trace_size(handle, buf, true);
>  	if (buf->snapshot)
>  		handle->head += size;
>  
> 

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
