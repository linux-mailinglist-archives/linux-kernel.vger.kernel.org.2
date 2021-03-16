Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4A733DE8F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 21:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhCPUYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 16:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhCPUXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 16:23:49 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5758C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 13:23:48 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id e26so9605216pfd.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 13:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kRpApWjSog39CsE2V8rrYvB6wV6tXRr/QolU6+hEFVY=;
        b=ZbK5tiU9+Ze+z4m+sPOpX9ekbEAhHqEZRo5L3ATa7I+Dvk/9R8Lgma1U9b2V3cAYwo
         85DMdZkZ5PasJr4Rvkmhr4FHPoRCSODqhMvphFUBR/3tlw+pOBEuj7+vhyOFF7lbjLvE
         FPO9lsGUU8JCMbO915fIXOdcK23yOH516oELuCKKMwDDf91ulTbLIR9nQzflJeSTgN3N
         5yU15Jqqu98EFLt8LbNBrB+8m1d+ry+oCmfJTlS0ekLENckRRXnGAFh2KvyAwLzkUq8b
         m/u4p7h359offwQwfyQWNLOGw3fPf5tFodB92/kHGGhyD97byQSNKDTKx1quYsyDiYqF
         4WJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kRpApWjSog39CsE2V8rrYvB6wV6tXRr/QolU6+hEFVY=;
        b=I4VperXPk1yIynBzAqPBQzb2Q4DtwDrAnePRHMT6i7xNuXmF2pChqnBmsq8HQBLpt2
         XSv8dJmcoV2ei0E0oInzSRt7VFjYDmI6mO/ncY73qXnrfx2AzT+cLW0jqsa0pPvfBZc1
         AEChcIsj8aJkBqLYVFGtw8lnADiOSMgsY0V+qTY+Ie2Ma9FUfVk16rsVsMfqw0fG2IdA
         ZAFXmDB3QNtZCdU6xPLEzfw4A7mjO7WIdl3FR5gv2WkItIxnAd5rOLztaQ7BGvVNQ1VE
         tZwMOkvVFXNkHoAeE7iH4/AXuzamiVib+dVwwJ1pJofmkMNl1/VbZ4LhL5zELMf3uru5
         DxIw==
X-Gm-Message-State: AOAM5304NY8TMZMCtZlsyxllSirra+i7H0xYOJLLLJlYNWKYL+RONBSD
        iMEzCciiOTQm4uncDOd6ZfDpMQ==
X-Google-Smtp-Source: ABdhPJz3k6DWIAM4yVc3PpYl2ZRiZhv+GU9W4TaS3w6K/fEjGfO/qXXp1c7H59UaTA8pdaXRackS1w==
X-Received: by 2002:a63:695:: with SMTP id 143mr1246647pgg.314.1615926228122;
        Tue, 16 Mar 2021 13:23:48 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id d20sm228987pjv.47.2021.03.16.13.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 13:23:47 -0700 (PDT)
Date:   Tue, 16 Mar 2021 14:23:45 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com,
        leo.yan@linaro.org, Linu Cherian <lcherian@marvell.com>
Subject: Re: [PATCH v4 10/19] coresight: etm-perf: Allow an event to use
 different sinks
Message-ID: <20210316202345.GE1387186@xps15>
References: <20210225193543.2920532-1-suzuki.poulose@arm.com>
 <20210225193543.2920532-11-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225193543.2920532-11-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 07:35:34PM +0000, Suzuki K Poulose wrote:
> When a sink is not specified by the user, the etm perf driver
> finds a suitable sink automatically, based on the first ETM
> where this event could be scheduled. Then we allocate the
> sink buffer based on the selected sink. This is fine for a
> CPU bound event as the "sink" is always guaranteed to be
> reachable from the ETM (as this is the only ETM where the
> event is going to be scheduled). However, if we have a thread
> bound event, the event could be scheduled on any of the ETMs
> on the system. In this case, currently we automatically select
> a sink and exclude any ETMs that cannot reach the selected
> sink. This is problematic especially for 1x1 configurations.
> We end up in tracing the event only on the "first" ETM,
> as the default sink is local to the first ETM and unreachable
> from the rest. However, we could allow the other ETMs to
> trace if they all have a sink that is compatible with the
> "selected" sink and can use the sink buffer. This can be
> easily done by verifying that they are all driven by the
> same driver and matches the same subtype. Please note
> that at anytime there can be only one ETM tracing the event.
> 
> Adding support for different types of sinks for a single
> event is complex and is not something that we expect
> on a sane configuration.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Tested-by: Linu Cherian <lcherian@marvell.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes:
> - Rename sinks_match => sinks_compatible
> - Tighten the check by matching the sink subtype
> - Use user_sink instead of "sink_forced" and clean up the code (Mathieu)
> - More comments, better commit description
> ---
>  .../hwtracing/coresight/coresight-etm-perf.c  | 60 ++++++++++++++++---
>  1 file changed, 52 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index 0f603b4094f2..aa0974bd265b 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -232,6 +232,25 @@ static void etm_free_aux(void *data)
>  	schedule_work(&event_data->work);
>  }
>  
> +/*
> + * Check if two given sinks are compatible with each other,
> + * so that they can use the same sink buffers, when an event
> + * moves around.
> + */
> +static bool sinks_compatible(struct coresight_device *a,
> +			     struct coresight_device *b)
> +{
> +	if (!a || !b)
> +		return false;
> +	/*
> +	 * If the sinks are of the same subtype and driven
> +	 * by the same driver, we can use the same buffer
> +	 * on these sinks.
> +	 */
> +	return (a->subtype.sink_subtype == b->subtype.sink_subtype) &&
> +	       (sink_ops(a) == sink_ops(b));

Ok

> +}
> +
>  static void *etm_setup_aux(struct perf_event *event, void **pages,
>  			   int nr_pages, bool overwrite)
>  {
> @@ -239,6 +258,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>  	int cpu = event->cpu;
>  	cpumask_t *mask;
>  	struct coresight_device *sink = NULL;
> +	struct coresight_device *user_sink = NULL, *last_sink = NULL;
>  	struct etm_event_data *event_data = NULL;
>  
>  	event_data = alloc_event_data(cpu);
> @@ -249,7 +269,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>  	/* First get the selected sink from user space. */
>  	if (event->attr.config2) {
>  		id = (u32)event->attr.config2;
> -		sink = coresight_get_sink_by_id(id);
> +		sink = user_sink = coresight_get_sink_by_id(id);
>  	}
>  
>  	mask = &event_data->mask;
> @@ -277,14 +297,33 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>  		}
>  
>  		/*
> -		 * No sink provided - look for a default sink for one of the
> -		 * devices. At present we only support topology where all CPUs
> -		 * use the same sink [N:1], so only need to find one sink. The
> -		 * coresight_build_path later will remove any CPU that does not
> -		 * attach to the sink, or if we have not found a sink.
> +		 * No sink provided - look for a default sink for all the ETMs,
> +		 * where this event can be scheduled.
> +		 * We allocate the sink specific buffers only once for this
> +		 * event. If the ETMs have different default sink devices, we
> +		 * can only use a single "type" of sink as the event can carry
> +		 * only one sink specific buffer. Thus we have to make sure
> +		 * that the sinks are of the same type and driven by the same
> +		 * driver, as the one we allocate the buffer for. As such
> +		 * we choose the first sink and check if the remaining ETMs
> +		 * have a compatible default sink. We don't trace on a CPU
> +		 * if the sink is not compatible.
>  		 */
> -		if (!sink)
> +		if (!user_sink) {
> +			/* Find the default sink for this ETM */
>  			sink = coresight_find_default_sink(csdev);
> +			if (!sink) {
> +				cpumask_clear_cpu(cpu, mask);
> +				continue;
> +			}
> +
> +			/* Check if this sink compatible with the last sink */
> +			if (last_sink && !sinks_compatible(last_sink, sink)) {
> +				cpumask_clear_cpu(cpu, mask);
> +				continue;
> +			}
> +			last_sink = sink;

This is much better.

I thought about something when I first looked a this patch in the previous
revision...  With the above we are changing the behavior of the CS framework for
systems that have one sink per CPU _clusters_, but for once it is for the better.

With this patch coresight_find_default_sink() is called for every CPU,
allowing CPUs in the second cluster to find a valid path and be included in the
trace session.  Before this patch CPUs in the second cluster couldn't
establish a valid path to the sink since it was only reachable from the first
cluster.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

More comments to come tomorrow.

Thanks,
Mathieu

> +		}
>  
>  		/*
>  		 * Building a path doesn't enable it, it simply builds a
> @@ -312,7 +351,12 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>  	if (!sink_ops(sink)->alloc_buffer || !sink_ops(sink)->free_buffer)
>  		goto err;
>  
> -	/* Allocate the sink buffer for this session */
> +	/*
> +	 * Allocate the sink buffer for this session. All the sinks
> +	 * where this event can be scheduled are ensured to be of the
> +	 * same type. Thus the same sink configuration is used by the
> +	 * sinks.
> +	 */
>  	event_data->snk_config =
>  			sink_ops(sink)->alloc_buffer(sink, event, pages,
>  						     nr_pages, overwrite);
> -- 
> 2.24.1
> 
