Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E1B3DB21A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 06:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhG3ENv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 00:13:51 -0400
Received: from foss.arm.com ([217.140.110.172]:35928 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhG3ENu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 00:13:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5725931B;
        Thu, 29 Jul 2021 21:13:46 -0700 (PDT)
Received: from [10.163.66.9] (unknown [10.163.66.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CDD93F73D;
        Thu, 29 Jul 2021 21:13:42 -0700 (PDT)
Subject: Re: [PATCH v2 03/10] coresight: etm-pmu: Ensure the AUX handle is
 valid
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tamas.zsoldos@arm.com, al.grant@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, mathieu.poirier@linaro.org,
        jinlmao@qti.qualcomm.com
References: <20210723124611.3828908-1-suzuki.poulose@arm.com>
 <20210723124611.3828908-4-suzuki.poulose@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <acd70df3-fdce-a08c-02f0-4cd6d806e6ba@arm.com>
Date:   Fri, 30 Jul 2021 09:44:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210723124611.3828908-4-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/23/21 6:16 PM, Suzuki K Poulose wrote:
> The ETM perf infrastructure closes out a handle during event_stop
> or on an error in starting the event. In either case, it is possible
> for a "sink" to update/close the handle, under certain circumstances.
> (e.g no space in ring buffer.). So, ensure that we handle this
> gracefully in the PMU driver by verifying the handle is still valid.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  .../hwtracing/coresight/coresight-etm-perf.c  | 27 ++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index 6f398377fec9..a6ab603afee4 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -450,8 +450,15 @@ static void etm_event_start(struct perf_event *event, int flags)
>  fail_disable_path:
>  	coresight_disable_path(path);
>  fail_end_stop:
> -	perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
> -	perf_aux_output_end(handle, 0);
> +	/*
> +	 * Check if the handle is still associated with the event,
> +	 * to handle cases where if the sink failed to start the
> +	 * trace and TRUNCATED the handle already.
> +	 */
> +	if (READ_ONCE(handle->event)) {
> +		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
> +		perf_aux_output_end(handle, 0);
> +	}

Makes sense as perf_aux_output_[flag|end]() helpers do not
validate the 'handle' themselves.

>  fail:
>  	event->hw.state = PERF_HES_STOPPED;
>  	goto out;
> @@ -519,7 +526,21 @@ static void etm_event_stop(struct perf_event *event, int mode)
>  
>  		size = sink_ops(sink)->update_buffer(sink, handle,
>  					      event_data->snk_config);
> -		perf_aux_output_end(handle, size);
> +		/*
> +		 * Make sure the handle is still valid as the
> +		 * sink could have closed it from an IRQ.
> +		 * The sink driver must handle the race with
> +		 * update_buffer() and IRQ. Thus either we
> +		 * should get a valid handle and valid size
> +		 * (which may be 0).
> +		 *
> +		 * But we should never get a non-zero size with
> +		 * an invalid handle.
> +		 */
> +		if (READ_ONCE(handle->event))
> +			perf_aux_output_end(handle, size);
> +		else
> +			WARN_ON(size);

Right.

>  	}
>  
>  	/* Disabling the path make its elements available to other sessions */
> 

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
