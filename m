Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A378930B349
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 00:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhBAXST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 18:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhBAXSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 18:18:03 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B33C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 15:17:23 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id u11so10993088plg.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 15:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WiVW7ot/7Bs4emoXR4is3+8ZOoMXMm7ez2m0Jch1wlI=;
        b=Ax2WSwcmIBOnPaGK4BN6bjbR66I4xEmRdn3SxDZewH539rN6ewBgz1peMtp3GGLr9r
         w7S+uqK4rBSVGP6yh450YewAvxZkavOG/yUwAHGFyHV0/DJFOy3tdy+16Fq3gg5ki4+M
         ffVK5Pn7XmUgxUIiYyufBJrednNbYTtIOnrKS+t51sXwX6NLZQAA1Y1EENpsJ4ykLjV7
         ejOKzSqH8XLVV3acGvyeDUDAv7rtmzOEJaKUjK2m31iIIqYmdWMbqKmt7yqcneIm4njk
         VxoxbKYG2bCgYarGKitoDRxA0doQl4H9qd4/01ec8eDAYLUW5gLLmrwL/mgQK84rFSDR
         QkLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WiVW7ot/7Bs4emoXR4is3+8ZOoMXMm7ez2m0Jch1wlI=;
        b=D/RjwmZAUuhpPmu7lQqw9I3y/qbD9aNjyEi58te0pjiz65zlVEcoBDdzRSOAxK9jA5
         zlzUdod2GLkDUwTDqNWzMAzSS7NSI4/RFv85HsNUyiaaH1GRKLrwYx4J1aeR+0lW3/JE
         BGVSbI5AVLRrzzMNIef/olpfAn8PO7+QAS4ZajKPJvE18UgJvCAXp6mINWKfzo01YcBQ
         FIDgS641xIILZ5yqgM2dkTS72KkHhXsFltoDG/ldL45kYA2VYyS3U2qNH1nLl4wdUoBz
         xVcd9Z4X7425YCqeSEgG2qScJ5CtshDXE2wN8eDfmjFJnI1OIvTNEeWoOXk7BaH0/jWa
         Wk0w==
X-Gm-Message-State: AOAM5307QfYmmL5xkk4ZDtB7Ja8J/gPRWJzKPYiZeUWZa2/+royD5drx
        H0juu+bN4oVFOEOsoZKFPXQExw==
X-Google-Smtp-Source: ABdhPJx07eYsqdX287umI3KnoSZtawfJ9AWKu6DRxCA571bImMHR2Df1E1oI0pS5WI0i4VCvhSbFFg==
X-Received: by 2002:a17:90a:808a:: with SMTP id c10mr1106975pjn.229.1612221442648;
        Mon, 01 Feb 2021 15:17:22 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id s15sm18685016pfh.107.2021.02.01.15.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 15:17:21 -0800 (PST)
Date:   Mon, 1 Feb 2021 16:17:20 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org,
        lcherian@marvell.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 01/14] coresight: etm-perf: Allow an event to use
 different sinks
Message-ID: <20210201231720.GB1475392@xps15>
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
 <1611737738-1493-2-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611737738-1493-2-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

I have started reviewing this set.  As it is quite voluminous comments will
come over serveral days.  I will let you know when I am done.

On Wed, Jan 27, 2021 at 02:25:25PM +0530, Anshuman Khandual wrote:
> From: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> When there are multiple sinks on the system, in the absence
> of a specified sink, it is quite possible that a default sink
> for an ETM could be different from that of another ETM. However
> we do not support having multiple sinks for an event yet. This
> patch allows the event to use the default sinks on the ETMs
> where they are scheduled as long as the sinks are of the same
> type.
> 
> e.g, if we have 1x1 topology with per-CPU ETRs, the event can
> use the per-CPU ETR for the session. However, if the sinks
> are of different type, e.g TMC-ETR on one and a custom sink
> on another, the event will only trace on the first detected
> sink.
>

I found the above changelog very confusing - I read it several times and still
couldn't get all of it.  In the end this patch prevents sinks of different types
from being used for session, and this is what the text should reflect.
 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Tested-by: Linu Cherian <lcherian@marvell.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm-perf.c | 48 +++++++++++++++++++-----
>  1 file changed, 38 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index bdc34ca..eb9e7e9 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -204,6 +204,13 @@ static void etm_free_aux(void *data)
>  	schedule_work(&event_data->work);
>  }
>  
> +static bool sinks_match(struct coresight_device *a, struct coresight_device *b)
> +{
> +	if (!a || !b)
> +		return false;
> +	return (sink_ops(a) == sink_ops(b));

Yes

> +}
> +
>  static void *etm_setup_aux(struct perf_event *event, void **pages,
>  			   int nr_pages, bool overwrite)
>  {
> @@ -212,6 +219,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>  	cpumask_t *mask;
>  	struct coresight_device *sink = NULL;

        struct coresight_device *user_sink = NULL;

>  	struct etm_event_data *event_data = NULL;
> +	bool sink_forced = false;
>  
>  	event_data = alloc_event_data(cpu);
>  	if (!event_data)
> @@ -222,6 +230,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>  	if (event->attr.config2) {
>  		id = (u32)event->attr.config2;
>  		sink = coresight_get_sink_by_id(id);

                user_sink = coresight_get_sink_by_id(id);

> +		sink_forced = true;
>  	}
>  
>  	mask = &event_data->mask;
> @@ -235,7 +244,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>  	 */
>  	for_each_cpu(cpu, mask) {
>  		struct list_head *path;
> -		struct coresight_device *csdev;

                struct coresight_device *last_sink = NULL;

> +		struct coresight_device *csdev, *new_sink;
>  
>  		csdev = per_cpu(csdev_src, cpu);
>  		/*
> @@ -249,21 +258,35 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>  		}
>  
>  		/*
> -		 * No sink provided - look for a default sink for one of the
> -		 * devices. At present we only support topology where all CPUs
> -		 * use the same sink [N:1], so only need to find one sink. The
> -		 * coresight_build_path later will remove any CPU that does not
> -		 * attach to the sink, or if we have not found a sink.
> +		 * No sink provided - look for a default sink for all the devices.
> +		 * We only support multiple sinks, only if all the default sinks
> +		 * are of the same type, so that the sink buffer can be shared
> +		 * as the event moves around. We don't trace on a CPU if it can't

s/can't/can't./

> +		 *

Extra line

>  		 */
> -		if (!sink)
> -			sink = coresight_find_default_sink(csdev);
> +		if (!sink_forced) {
> +			new_sink = coresight_find_default_sink(csdev);
> +			if (!new_sink) {
> +				cpumask_clear_cpu(cpu, mask);
> +				continue;
> +			}
> +			/* Skip checks for the first sink */
> +			if (!sink) {
> +			       sink = new_sink;
> +			} else if (!sinks_match(new_sink, sink)) {
> +				cpumask_clear_cpu(cpu, mask);
> +				continue;
> +			}
> +		} else {
> +			new_sink = sink;
> +		}

                if (!user_sink) {
                        /* find default sink for this CPU */
                        sink = coresight_find_default_sink(csdev);
                        if (!sink) {
                                cpumask_clear_cpu(cpu, mask);
                                continue;
                        }

                        /* Chech new sink with last sink */
                        if (last_sink && !sink_match(last_sink, sink)) {
                                cpumask_clear_cpu(cpu, mask);
                                continue;
                        }

                        last_sink = sink;
                } else {
                        sink = user_sink;
                }

>  
>  		/*
>  		 * Building a path doesn't enable it, it simply builds a
>  		 * list of devices from source to sink that can be
>  		 * referenced later when the path is actually needed.
>  		 */
> -		path = coresight_build_path(csdev, sink);
> +		path = coresight_build_path(csdev, new_sink);
>  		if (IS_ERR(path)) {
>  			cpumask_clear_cpu(cpu, mask);
>  			continue;
> @@ -284,7 +307,12 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
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
> 2.7.4
> 
