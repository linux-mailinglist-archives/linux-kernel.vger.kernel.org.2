Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF3E41E061
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 19:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352885AbhI3R4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 13:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352811AbhI3R4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 13:56:08 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D281DC06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 10:54:25 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id x8so4583402plv.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 10:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0KmUaUSxPFrDthgHl5NrUQGDAAGGVW2a0GFlAkUAvIU=;
        b=NAz57rMGn5OLdUWr/YrXqnrBhLM8Mtr6Xn4FIB8qaDKTBPH/sKBe1tKNqmsxNlx4pK
         Wy+dTR2oOKlJHw1XmS65bWVbVNftm7nokUJPeqLelQqC4ftDRz6n9Ia3ri3AxRqKWxZ9
         oF5rkelCFfmZlW4yByvL3aVkOoohHs870FTVuZQYyBYCmpXqftNY1LB9IBRFIc2UMkby
         1f/OvKovSO+WTZ/qbPMgLr4iZgKww7bPPzRr0QB0QFf9pus2cLmk9bAvzUM6i97k9/c+
         6oTlBxQRUJ0ZEP25bJejNPlLS05EG99bGzgj0iWo9SzNHtRxKj5nNZrEBUyKTDyRfB0A
         R0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0KmUaUSxPFrDthgHl5NrUQGDAAGGVW2a0GFlAkUAvIU=;
        b=iVkWohn1JSQO16lNicy+tg4cW3CrG0AjU2wjETpVuXG8CRBZ9f+D9EcIw46qT8w7en
         R/nEYvEw9cCnVCMMEx0V78t/qjcKgIahxOmcqi59tZCnv1tcJbjwZXpElufzMe+X0Xt6
         rWONAyem2Dtoh8T0dAJ7JdbrhjkxtYBbO1Mfn/P+pJ9K7iPdd609klvsnqDExCMOeOxH
         U0Qxk2hcD4V0pc3c7VIGs7Qcp0PfzKinJ7nT3OQ/NQmLJ+ad1J1sX7A1cZ1Tm0sxayLv
         bfXEfB9iiQGrThjRZ49xCgbOuJ7pmruvm2hnfCuqhF+LQhCXl2CcqvUX0onLTqAH2Klp
         7kWA==
X-Gm-Message-State: AOAM532dEm6NrlMVPVM/SmnHoOzsQ/6dKaC72gwyzuL8Fclj3MiANq/W
        cQ7RIjWIeAiBwdSf8vB1GfIGKA==
X-Google-Smtp-Source: ABdhPJzPHUM5gk/tdjyZUPRXZtbWX4aq0cADviFlGneSgCdQzEVFzKvTtmE2WcFp4hNavHbFWB1BzQ==
X-Received: by 2002:a17:902:e743:b0:13e:682b:91cc with SMTP id p3-20020a170902e74300b0013e682b91ccmr5327879plf.10.1633024465347;
        Thu, 30 Sep 2021 10:54:25 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id f2sm5846283pjw.52.2021.09.30.10.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 10:54:24 -0700 (PDT)
Date:   Thu, 30 Sep 2021 11:54:21 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        james.morse@arm.com, anshuman.khandual@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, will@kernel.org, lcherian@marvell.com,
        coresight@lists.linaro.org
Subject: Re: [PATCH v2 03/17] coresight: trbe: Add a helper to calculate the
 trace generated
Message-ID: <20210930175421.GB3047827@p14s>
References: <20210921134121.2423546-1-suzuki.poulose@arm.com>
 <20210921134121.2423546-4-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921134121.2423546-4-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Tue, Sep 21, 2021 at 02:41:07PM +0100, Suzuki K Poulose wrote:
> We collect the trace from the TRBE on FILL event from IRQ context
> and when via update_buffer(), when the event is stopped. Let us

s/"and when via"/"and via"

> consolidate how we calculate the trace generated into a helper.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-trbe.c | 48 ++++++++++++--------
>  1 file changed, 30 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 63f7edd5fd1f..063c4505a203 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -527,6 +527,30 @@ static enum trbe_fault_action trbe_get_fault_act(u64 trbsr)
>  	return TRBE_FAULT_ACT_SPURIOUS;
>  }
>  
> +static unsigned long trbe_get_trace_size(struct perf_output_handle *handle,
> +					 struct trbe_buf *buf,
> +					 bool wrap)

Stacking

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

In both arm_trbe_alloc_buffer() and trbe_handle_overflow() the base address is
acquired using get_trbe_base_pointer() but here it is referenced directly - any
reason for that?  It certainly makes reviewing this simple patch quite
difficult because I keep wondering if I am missing something subtle...  

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
> @@ -588,9 +612,9 @@ static unsigned long arm_trbe_update_buffer(struct coresight_device *csdev,
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
> @@ -630,8 +654,6 @@ static unsigned long arm_trbe_update_buffer(struct coresight_device *csdev,
>  	 * handle gets freed in etm_event_stop().
>  	 */
>  	trbe_drain_and_disable_local();
> -	write = get_trbe_write_pointer();
> -	base = get_trbe_base_pointer();
>  
>  	/* Check if there is a pending interrupt and handle it here */
>  	status = read_sysreg_s(SYS_TRBSR_EL1);
> @@ -655,20 +677,11 @@ static unsigned long arm_trbe_update_buffer(struct coresight_device *csdev,
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
> @@ -749,11 +762,10 @@ static int trbe_handle_overflow(struct perf_output_handle *handle)
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
> -- 
> 2.24.1
> 
