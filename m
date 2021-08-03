Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6FE3DF1D1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 17:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237043AbhHCPwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 11:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237020AbhHCPwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 11:52:35 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6C0C061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 08:52:23 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id m10-20020a17090a34cab0290176b52c60ddso5277746pjf.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 08:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wfTha0RigLRF06x85Kk644/HudxJSq0sHBStjRH/Nn4=;
        b=rFYczh7OBxM9JDHqgnQjjKawvjkcAlXiwLtw1NUXoBcPHNvlH8+Riq7uzLzqC4MFHm
         q6hxcE1bwO6V+PIxXb0P4VYdjY6gUWKYiXBZcqHZA3ckSEq5oHSqtHRvce4Vtv3Lko7F
         i0AWXdE1YMkJbGFOR9NnWrNPjhtSAAZstmy6zZ81IQ8zK8tjyKrwnBm1C+iYbxFokDue
         nE8dWZrsiuMDtOW/4/nC9Gt4RzduxNB79ohlSVrzlH3/U/rsUSWEDou5AaWuOpfohtN6
         KR5AwpAXQBxTemIwhdhHvBEcedU88A58Mck3KWMrla/Xr4elREm8wx9ygqspfYWLwZK+
         66ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wfTha0RigLRF06x85Kk644/HudxJSq0sHBStjRH/Nn4=;
        b=hulfmpN3aIgogR3fz+wsDBmkcRe+10C9d26NMU3gK+y5leGXUreEHDYD5tbZgKl8wn
         5hDtkrXQG1Lwv+cSQouxl3yA9UcV2WXbXWZ1N1ntfnG390d8rNKCIdPs8APw8rTwwEeL
         hoLOkdnvC1uWCP6rT/GQa5xBBYUFuvBMcb0iqZsatDsdbYjhfIJIdShWUuR0iqS2IMxd
         m4e3UCGLhRaxbRGmttqshItdSKwMUksC+cOZsIv32dwx3f+YGWkRB67599zvIKd8k58W
         ui1p6BYA0lFrq1cZ1uQlcqg8y//2S9q92PgkZgCJJxT036+W9Bl8VpoSCnewbXztL9n3
         v9dA==
X-Gm-Message-State: AOAM533Dyo4gilWPHxvZkyjO7YyaKY0L3Wbyv3PoIduSr1vug8hNE36p
        N6R5LVDRNrofMvvl0pNEt/X3yg==
X-Google-Smtp-Source: ABdhPJxw/j6uXXIMtlidb0vRl8661a2gM+z2ArByG0qqBg1oqe+Y0+x8ZM5xs0kQgplOH2mvb4yOqw==
X-Received: by 2002:a63:1b5c:: with SMTP id b28mr489782pgm.175.1628005943381;
        Tue, 03 Aug 2021 08:52:23 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id z33sm11742433pga.20.2021.08.03.08.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 08:52:22 -0700 (PDT)
Date:   Tue, 3 Aug 2021 09:52:20 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Peter Zijlstra <peterz@infradead.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 14/38] coresight: Replace deprecated CPU-hotplug
 functions.
Message-ID: <20210803155220.GA3091608@p14s>
References: <20210803141621.780504-1-bigeasy@linutronix.de>
 <20210803141621.780504-15-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803141621.780504-15-bigeasy@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 04:15:57PM +0200, Sebastian Andrzej Siewior wrote:
> The functions get_online_cpus() and put_online_cpus() have been
> deprecated during the CPU hotplug rework. They map directly to
> cpus_read_lock() and cpus_read_unlock().
> 
> Replace deprecated CPU-hotplug functions with the official version.
> The behavior remains unchanged.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: coresight@lists.linaro.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/hwtracing/coresight/coresight-cpu-debug.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> index 9731d3a960735..00de46565bc40 100644
> --- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
> +++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> @@ -588,11 +588,11 @@ static int debug_probe(struct amba_device *adev, const struct amba_id *id)
>  
>  	drvdata->base = base;
>  
> -	get_online_cpus();
> +	cpus_read_lock();
>  	per_cpu(debug_drvdata, drvdata->cpu) = drvdata;
>  	ret = smp_call_function_single(drvdata->cpu, debug_init_arch_data,
>  				       drvdata, 1);
> -	put_online_cpus();
> +	cpus_read_unlock();
>

Applied - thanks,
Mathieu

>  	if (ret) {
>  		dev_err(dev, "CPU%d debug arch init failed\n", drvdata->cpu);
> -- 
> 2.32.0
> 
