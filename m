Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0477E3A0656
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 23:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbhFHVpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 17:45:01 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:42693 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234344AbhFHVpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 17:45:00 -0400
Received: by mail-pf1-f173.google.com with SMTP id s14so15865621pfd.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 14:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uRns9NnJOGwY9YKrCNhTNDZgOaY9mrjmuIMA1gs2P5c=;
        b=BqdZ8YJi49HLO2WUYvYTFzMNXjAYsawXOs9xcAJg5Z6cH6mNTckzD4j8afaFd8hPRs
         0N0sO3PSL2eL/8596q9dUcxukgH/SC+sOjl9VWBN6ND4g1wMmrruSGvwPMxqY8rMY5yc
         0FbO9zZeAOl+mLeQq8M0AmOvikR7bRjmx+sL6tW0b7bdLPpSOE4vU8AY5mDLteGLNJKl
         3Eo0+6zRfH2oPfmW/eZL7fqWzVxUavsdAJ4m6CPoKtG6r1aHBPUeCjBgg2Cg+i1DSw86
         qFyG8fzBd8VVHnAY8QCEj4gFshTIcHNqRXiixpQiOeR3lYd8gfGgFkX3JcpU/PhBfevN
         3IqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uRns9NnJOGwY9YKrCNhTNDZgOaY9mrjmuIMA1gs2P5c=;
        b=NHDN0JeCbtBbWbABVinA1U9aifIBc05o4rb1HnbUeelBxBIKx4hI7J8uV2jkffvaPo
         epMKLSmDcv4V5QF8m19MS7jeRBoq2MI91tm8xPnTzJcL1aS9t3vMhfdRqS+8/xeeXPB5
         Rg/tN4tfMptA/2QFdoVEBlPnYdrRGSwAtBk2vPYC+mkeauzzuG3Y9nH1Rfe6AKuLqBLS
         RwKiT/ptUCaXYvPCsw094a/4qwaicSQEiSZU7SMPq/1u2Op1ZWbPESMFDjl+ezeXsVRP
         2oGA6HeXlEg07fwbkF+EkaXkH9y71q0aRbq08pEtpW5hOJUYxfdOEzhXPpL0nDU7QHKL
         AAyw==
X-Gm-Message-State: AOAM530MILON+EaRO3RqAbEF8n0vEPfTDqJtw8oIWkItE4LLVQUCP60V
        DPgHau+l4tvg78XjUE4hjoi4eg==
X-Google-Smtp-Source: ABdhPJydfM9fHJbihCtK4s0D2JVplUs4msM39xDVuXjmUKrrqwDRC7+G/UHTamzIBhoXavzmBrLsrw==
X-Received: by 2002:aa7:9809:0:b029:2ed:46da:1824 with SMTP id e9-20020aa798090000b02902ed46da1824mr1752272pfl.48.1623188512795;
        Tue, 08 Jun 2021 14:41:52 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id p14sm13007313pgb.2.2021.06.08.14.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 14:41:51 -0700 (PDT)
Date:   Tue, 8 Jun 2021 15:41:49 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Denis Nikitin <denik@google.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 1/3] coresight: etm-perf: Correct buffer syncing for
 snapshot
Message-ID: <20210608214149.GA331611@p14s>
References: <20210528161552.654907-1-leo.yan@linaro.org>
 <20210528161552.654907-2-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528161552.654907-2-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2021 at 12:15:50AM +0800, Leo Yan wrote:
> The perf tool records the Arm CoreSight trace data with snapshot mode
> with the option '-S', when receiving USR2 signal, it is observed the
> captured trace data size is very varied: from several MBs to ~20MBs.
> This can be reproduced with the command:
> 
>   perf record -e cs_etm// -S \
> 	-- dd if=/dev/zero of=/dev/null > /dev/null 2>&1 &
>   PERFPID=$!
>   sleep 1
>   kill -USR2 $PERFPID
> 
> It's different for only specifying option '-S' than options '-a -S'.  If
> without option '-a', perf tool creates separate AUX buffers for every
> CPU, but the tracer will be enabled only when the profiled program is
> scheduled onto the corresponding CPU, this might lead to record very
> old trace data when snapshot.

I'm very perplexed by this paragraph...  The '-a' option means tracing on all
CPUs, which will definitely allocate an AUX buffer per CPU.

> 
> Let's see below diagram:
>                                                             snapshot
>   CPU0: ______###P1###__________________________________________|
>   CPU1: __________________________###P3###____________###P5###__|
>   CPU2: ____________________________________###P4###____________|
>   CPU3: ________________###P2###________________________________V
> 
> In this diagram, the program runs for 5 periods (from P1 to P5), these 5
> periods show the task run on different CPUs, e.g. during P1 period the
> program runs on CPU0, and during P2 period the program is migrated to
> CPU1, and so on.  At the end of P1 period when the program is switched
> out from CPU0, the ETR trace data is saved into AUX trace buffer, this
> AUX buffer is a dedicated buffer for CPU0's tracer.  With the same
> logic, P2's trace data is saved into CPU3's tracer buffer, P4's trace
> data is saved into CPU2's buffer, P3 and P5's trace data is saved into
> CPU1's.  Therefore, when snapshot, it saves the trace data from all AUX
> ring buffers (in this case, it have total 4 AUX ring buffers) into perf
> data file.
>

When a snapshot happens and if the event is currently active, traces
accumulated since the event was _installed_ on the CPU will be copied from the
coresight buffer to the AUX buffer.  Trace data accumulated in other buffers will
already have been copied when the event was scheduled out.

I *think* what is happening here is that if P5 was still active when the
snapshot occurs, we would get trace data from P3 and P5, and not P4.  Is my
understanding correct?

> This is why we can see varied trace data size, it's quite dependent on
> the task scheduling on CPUs, if the task is spinned to only one CPU and
> without scheduling out, it will only record trace data from only one
> AUX trace buffer.  If the task is frequently scheduled in and out, then
> it gives more chance to fill trace data into the AUX buffer.
> 
> In this example, it also causes the discontinuous trace data.  If P3's
> trace data is lost after P5's trace data overwrites the AUX trace data,
> thus perf tool fails to record continuous trace data if only have
> trace data for P1/P2/P4/P5.
> 
> For snapshot mode, usually the user only wants to capture the trace data
> for the specific time point and prior to the that point the tracer
> should work with free run mode.  This means it's not necessary to
> capture trace data for task's scheduling in and out until the perf tool
> explicitly disables tracers for snapshot.  This can be fulfilled by
> checking the variable "event->ctx->is_active", when the task is
> scheduled out this variable is set to zero, and when snapshot this
> variable is still non-zero value.  So the driver can only record trace
> data only when "event->ctx->is_active" is non-zero.

The problem with this approach is that if the AUX buffer is 4MB and the CS
buffer is 1MB then we only record 1MB, but because of N:1 topologies we may not
be able to do better.  I haven't looked at the code yet, something I will do
tomorrow.

> 
> After applying this change, the perf tool can record the consistent
> trace data size for snapshot.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  .../hwtracing/coresight/coresight-etm-perf.c  | 30 +++++++++++++++++--
>  .../hwtracing/coresight/coresight-etm-perf.h  |  2 ++
>  2 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index 6f398377fec9..fd36d0530087 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -284,6 +284,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>  	if (!event_data)
>  		return NULL;
>  	INIT_WORK(&event_data->work, free_event_data);
> +	event_data->overwrite = overwrite;
>  
>  	/* First get the selected sink from user space. */
>  	if (event->attr.config2) {
> @@ -517,9 +518,32 @@ static void etm_event_stop(struct perf_event *event, int mode)
>  		if (!sink_ops(sink)->update_buffer)
>  			return;
>  
> -		size = sink_ops(sink)->update_buffer(sink, handle,
> -					      event_data->snk_config);
> -		perf_aux_output_end(handle, size);
> +		/*
> +		 * In the snapshot mode, if only specifies option '-S' (note,
> +		 * user doesn't specify option '-a' in this case), the AUX ring
> +		 * buffers are allocated for every CPU but the AUX trace is
> +		 * recorded in per-thread mode.  In this mode, it's needless to
> +		 * save AUX trace data into the AUX ring buffer when the
> +		 * profiled program is scheduled out from a CPU, alternatively,
> +		 * the driver should only capture AUX trace data when the perf
> +		 * tool receives USR2 signal for taking snapshot.
> +		 *
> +		 * The variable "event->ctx->is_active" can be used to
> +		 * distinguish the cases between the program scheduling out and
> +		 * snapshot: its value is zero when the profiled task scheduled
> +		 * out, and it is a non-zero value when perf tool invokes ioctl
> +		 * PERF_EVENT_IOC_DISABLE for snapshot.
> +		 *
> +		 * Only updates AUX ring buffer for snapshot, or for the perf
> +		 * session which is not in snapshot mode.
> +		 */
> +		if (!event_data->overwrite || event->ctx->is_active) {
> +			size = sink_ops(sink)->update_buffer(sink, handle,
> +						      event_data->snk_config);
> +			perf_aux_output_end(handle, size);
> +		} else {
> +			perf_aux_output_end(handle, 0);
> +		}
>  	}
>  
>  	/* Disabling the path make its elements available to other sessions */
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
> index 3e4f2ad5e193..2cc3af05495f 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.h
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
> @@ -49,12 +49,14 @@ struct etm_filters {
>   * @mask:		Hold the CPU(s) this event was set for.
>   * @snk_config:		The sink configuration.
>   * @path:		An array of path, each slot for one CPU.
> + * @overwrite:		Flag for snapshot mode.
>   */
>  struct etm_event_data {
>  	struct work_struct work;
>  	cpumask_t mask;
>  	void *snk_config;
>  	struct list_head * __percpu *path;
> +	bool overwrite;
>  };
>  
>  #if IS_ENABLED(CONFIG_CORESIGHT)
> -- 
> 2.25.1
> 
