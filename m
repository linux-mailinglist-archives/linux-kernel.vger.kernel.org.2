Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5073630E30B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 20:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbhBCTGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 14:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbhBCTF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 14:05:57 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F2DC061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 11:05:16 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id e12so394396pls.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 11:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EE8xr8WGSTtKixE8YworouSjrlGN2kJD3jxgfGoDHgE=;
        b=UEFjhXbHS4GnVyDF/OKRVjVLat60WtlEynnBNIm4xMvIAYfFDxZ/DmT4HXfxrpQ/zo
         4F2NJt51TWh+FbWeiGdc/y9Q/axfuAnHqQ268gzS0OfSxaYO6n9N3jwHniBl0eP5Ksuc
         9cJmIjU+dVkoaRlIPAXbW3D2rvXhe5aK+9czpA0OXiR6G0MtCSmgcxQSWyj7hwvpI8/8
         KoEo14EOqCeN0spKGMr8mXwCti66Y45EVKmLz4hWCSiemgfeBHB6wBAELuM6glK/sZIh
         bkEULEW5CdTji8ZXEvPudK8n3i7dZfTT2hC/kSlgfnjBNomjktwxKVyHAiWE9z+1dmEu
         4gyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EE8xr8WGSTtKixE8YworouSjrlGN2kJD3jxgfGoDHgE=;
        b=gQrBEM7e+UV8UKXY3DEI9/5hWAxTsyiVt03pGVlJ1ayfMqg3bhLwpWbrRvMrpXO3jL
         4y90ELX0zVfiIbqpQOknu1YFF6xk22aJ8jfiQKBVpPIF4NuFMWEngI9wZ+AAJNwsKU/Q
         suqtvwBeD4/2D3bDP6mGxBOYNqYeiUFpEj9NSUc4T7r+Nru6pvMNi1WDbIfcgIvPmAzR
         pUJI4adqZHFANaAFBQVrPKvokZA8GXomG+3uxzGhI43qphxIyfeQJGXMKZUzO5trdo+X
         tSh+NaMbcMktrFDs01seWGkmsWq9bLEFWrt4KenjWgCSGWER/vMmTBLmY7KCcKX93/no
         vAyg==
X-Gm-Message-State: AOAM532yPtBQrEuv9LRtRO7jLysL+IZ+szcnm+iRCZE1MeFKYzxcC2rg
        xLs6KdXdBM529TzFPlALysX3eQ==
X-Google-Smtp-Source: ABdhPJzszjqDHIZVTAHhfi1g+ceBJqGxQv3ur8DNrPgD8N5+IQnBrtpXOIzi74TARuyQF0Qu6719mQ==
X-Received: by 2002:a17:902:8f97:b029:e1:1388:2705 with SMTP id z23-20020a1709028f97b02900e113882705mr4302999plo.56.1612379116413;
        Wed, 03 Feb 2021 11:05:16 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id b17sm2960392pfo.151.2021.02.03.11.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 11:05:15 -0800 (PST)
Date:   Wed, 3 Feb 2021 12:05:13 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org,
        lcherian@marvell.com, linux-kernel@vger.kernel.org,
        Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH V3 07/14] coresight: etm-perf: Handle stale output handles
Message-ID: <20210203190513.GF1536093@xps15>
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
 <1611737738-1493-8-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611737738-1493-8-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 02:25:31PM +0530, Anshuman Khandual wrote:
> From: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> The context associated with an ETM for a given perf event
> includes :
>   - handle -> the perf output handle for the AUX buffer.
>   - the path for the trace components
>   - the buffer config for the sink.
> 
> The path and the buffer config are part of the "aux_priv" data
> (etm_event_data) setup by the setup_aux() callback, and made available
> via perf_get_aux(handle).
> 
> Now with a sink supporting IRQ, the sink could "end" an output
> handle when the buffer reaches the programmed limit and would try
> to restart a handle. This could fail if there is not enough
> space left the AUX buffer (e.g, the userspace has not consumed
> the data). This leaves the "handle" disconnected from the "event"
> and also the "perf_get_aux()" cleared. This all happens within
> the sink driver, without the etm_perf driver being aware.
> Now when the event is actually stopped, etm_event_stop()
> will need to access the "event_data". But since the handle
> is not valid anymore, we loose the information to stop the
> "trace" path. So, we need a reliable way to access the etm_event_data
> even when the handle may not be active.
> 
> This patch replaces the per_cpu handle array with a per_cpu context
> for the ETM, which tracks the "handle" as well as the "etm_event_data".
> The context notes the etm_event_data at etm_event_start() and clears
> it at etm_event_stop(). This makes sure that we don't access a
> stale "etm_event_data" as we are guaranteed that it is not
> freed by free_aux() as long as the event is active and tracing,
> also provides us with access to the critical information
> needed to wind up a session even in the absence of an active
> output_handle.
> 
> This is not an issue for the legacy sinks as none of them supports
> an IRQ and is centrally handled by the etm-perf.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm-perf.c | 45 +++++++++++++++++++++---
>  1 file changed, 40 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index eb9e7e9..a3977b0 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -24,7 +24,26 @@
>  static struct pmu etm_pmu;
>  static bool etm_perf_up;
>  
> -static DEFINE_PER_CPU(struct perf_output_handle, ctx_handle);
> +/*
> + * An ETM context for a running event includes the perf aux handle
> + * and aux_data. For ETM, the aux_data (etm_event_data), consists of
> + * the trace path and the sink configuration. The event data is accessible
> + * via perf_get_aux(handle). However, a sink could "end" a perf output
> + * handle via the IRQ handler. And if the "sink" encounters a failure
> + * to "begin" another session (e.g due to lack of space in the buffer),
> + * the handle will be cleared. Thus, the event_data may not be accessible
> + * from the handle when we get to the etm_event_stop(), which is required
> + * for stopping the trace path. The event_data is guaranteed to stay alive
> + * until "free_aux()", which cannot happen as long as the event is active on
> + * the ETM. Thus the event_data for the session must be part of the ETM context
> + * to make sure we can disable the trace path.
> + */
> +struct etm_ctxt {
> +	struct perf_output_handle handle;
> +	struct etm_event_data *event_data;
> +};
> +
> +static DEFINE_PER_CPU(struct etm_ctxt, etm_ctxt);
>  static DEFINE_PER_CPU(struct coresight_device *, csdev_src);
>  
>  /* ETMv3.5/PTM's ETMCR is 'config' */
> @@ -332,7 +351,8 @@ static void etm_event_start(struct perf_event *event, int flags)
>  {
>  	int cpu = smp_processor_id();
>  	struct etm_event_data *event_data;
> -	struct perf_output_handle *handle = this_cpu_ptr(&ctx_handle);
> +	struct etm_ctxt *ctxt = this_cpu_ptr(&etm_ctxt);
> +	struct perf_output_handle *handle = &ctxt->handle;
>  	struct coresight_device *sink, *csdev = per_cpu(csdev_src, cpu);
>  	struct list_head *path;
> 
        if (!csdev)
                goto fail;

        /*
         * Something went wrong if an event data is already associated
         * with a context.
         */
        if (WARN_ONE(ctxt->event_data))
                goto fail;
 
> @@ -374,6 +394,8 @@ static void etm_event_start(struct perf_event *event, int flags)
>  	if (source_ops(csdev)->enable(csdev, event, CS_MODE_PERF))
>  		goto fail_disable_path;
>  
> +	/* Save the event_data for this ETM */
> +	ctxt->event_data = event_data;
>  out:
>  	return;
>  
> @@ -392,13 +414,20 @@ static void etm_event_stop(struct perf_event *event, int mode)
>  	int cpu = smp_processor_id();
>  	unsigned long size;
>  	struct coresight_device *sink, *csdev = per_cpu(csdev_src, cpu);
> -	struct perf_output_handle *handle = this_cpu_ptr(&ctx_handle);
> -	struct etm_event_data *event_data = perf_get_aux(handle);
> +	struct etm_ctxt *ctxt = this_cpu_ptr(&etm_ctxt);
> +	struct perf_output_handle *handle = &ctxt->handle;

	struct etm_event_data *event_data = perf_get_aux(handle);
>  	struct list_head *path;
>

        if (WARN_ON(event_data && event_data != ctxt->event_data))
                return;

        event_data = ctxt->event_data;       
	/* Clear the event_data as this ETM is stopping the trace. */
	ctxt->event_data = NULL;

With the above:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
  
>  	if (event->hw.state == PERF_HES_STOPPED)
>  		return;
>  
> +	/* We must have a valid event_data for a running event */
> +	if (WARN_ON(!event_data))
> +		return;
> +
>  	if (!csdev)
>  		return;
>  
> @@ -416,7 +445,13 @@ static void etm_event_stop(struct perf_event *event, int mode)
>  	/* tell the core */
>  	event->hw.state = PERF_HES_STOPPED;
>  
> -	if (mode & PERF_EF_UPDATE) {
> +	/*
> +	 * If the handle is not bound to an event anymore
> +	 * (e.g, the sink driver was unable to restart the
> +	 * handle due to lack of buffer space), we don't
> +	 * have to do anything here.
> +	 */
> +	if (handle->event && (mode & PERF_EF_UPDATE)) {
>  		if (WARN_ON_ONCE(handle->event != event))
>  			return;
>  
> -- 
> 2.7.4
> 
