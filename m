Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B3D43D0EF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 20:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243596AbhJ0Sn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 14:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238382AbhJ0Snz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 14:43:55 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5741CC061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 11:41:30 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id e200-20020a4a55d1000000b002b8bedf08cdso1257208oob.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 11:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wHK6yHDny9iLB//O45DyauV4nk5jaYAc4hww2YZyQ0k=;
        b=FWwPL9M7EALBivB1WmQb630SogBJYmaJdteHDY//7nj3TsoFhGgdBTtaKSlNgMTPL9
         Ws/8t0W0AaFm3G8aIXeNr8B7+sCSvOqGj8uDiOG6OM5MXy3CGs91+UAyqvz/8VpERv8n
         TkD7WLp6AXPRil0K3rbFTSv8Jl/5sVoBafmx+8HN55/+vdpuUUmZmWcu61i42bnQu7QH
         Tv8Kid/q0wPQCuavDaOcN758r1sJl17OjeqSpNfGpsQZDfwoj5It25xUedUskUvVbnTk
         +IVeBv5PImQjTXvW4Vc2eAQmiJBdW5i1Fggryxm+SPYwkTYmwTrHdKNaQBV2mRJ+d/JK
         hYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wHK6yHDny9iLB//O45DyauV4nk5jaYAc4hww2YZyQ0k=;
        b=KwviZFaLdNQdeelnBlSQuf+7aytsfEQ6hcA3ZOL0HIeCTlnP8Av6Tcyd014BGOlUf7
         eRIYFvMuUGKjdMZtDsx8JokzusNO6bNbmtHBN8RTWQMpJKcQyLFViU8NVdjFyb3cbt4+
         Aigq6lqGR7ZbgpIFTyjKCB6JXsXBhuYwwe7Zt5rXdWk1vi0N19B5/Jo/E0sWUCKgVE9L
         nQFna4f5MkyFId5xI2lxTSQq+Wbm0BhmcnghEO3GHevb7cD830GE473viw3NStNLiexf
         IhJaAT+qkK/VCcDixDENLtBgfVk/o8uQGDtxPhzO/4e5n7n8YXtD5zuHKgO/mzrH97H+
         MRYA==
X-Gm-Message-State: AOAM530hD/JsxFvL1HxdK6+C5yj6h7nwWZytkD6fHyg3CiEUiQ4a3mQC
        Y5FE7008iueUmZFwYnZYw4pNXA==
X-Google-Smtp-Source: ABdhPJwFBBFotXZX5piAxteH5rE+Y4OBNlnksB1oGFkl2n2gZoSj8HvkonS0+VEay3gPQz66SSzY1Q==
X-Received: by 2002:a4a:b48a:: with SMTP id b10mr23498049ooo.24.1635360089665;
        Wed, 27 Oct 2021 11:41:29 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id w2sm257922ooa.26.2021.10.27.11.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 11:41:28 -0700 (PDT)
Date:   Wed, 27 Oct 2021 11:43:21 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, sudeep.holla@arm.com,
        will@kernel.org, catalin.marinas@arm.com, linux@armlinux.org.uk,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        viresh.kumar@linaro.org, amitk@kernel.org,
        daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
        thara.gopinath@linaro.org, agross@kernel.org
Subject: Re: [PATCH v2 1/5] arch_topology: Introduce thermal pressure update
 function
Message-ID: <YXmdyeOmNS2x3K0W@ripper>
References: <20211015144550.23719-1-lukasz.luba@arm.com>
 <20211015144550.23719-2-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015144550.23719-2-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 15 Oct 07:45 PDT 2021, Lukasz Luba wrote:
> diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
[..]
> +/**
> + * topology_thermal_pressure_update() - Update thermal pressure for CPUs
> + * @cpus	: The related CPUs for which capacity has been reduced
> + * @capped_freq	: The maximum allowed frequency that CPUs can run at

I know this matches what I see in e.g. the Qualcomm cpufreq hw driver,
but in what cases will @capped_freq differ from
cpufreq_get_hw_max_freq(cpumask_first(cpus))?

Regards,
Bjorn

> + *
> + * Update the value of thermal pressure for all @cpus in the mask. The
> + * cpumask should include all (online+offline) affected CPUs, to avoid
> + * operating on stale data when hot-plug is used for some CPUs. The
> + * @capped_freq must be less or equal to the max possible frequency and
> + * reflects the currently allowed max CPUs frequency due to thermal capping.
> + * The @capped_freq must be provided in kHz.
> + */
> +void topology_thermal_pressure_update(const struct cpumask *cpus,
> +				      unsigned long capped_freq)
> +{
> +	unsigned long max_capacity, capacity;
> +	int cpu;
> +
> +	if (!cpus)
> +		return;
> +
> +	cpu = cpumask_first(cpus);
> +	max_capacity = arch_scale_cpu_capacity(cpu);
> +
> +	/* Convert to MHz scale which is used in 'freq_factor' */
> +	capped_freq /= 1000;
> +
> +	capacity = mult_frac(capped_freq, max_capacity,
> +			     per_cpu(freq_factor, cpu));
> +
> +	arch_set_thermal_pressure(cpus, max_capacity - capacity);
> +}
> +EXPORT_SYMBOL_GPL(topology_thermal_pressure_update);
> +
>  static ssize_t cpu_capacity_show(struct device *dev,
>  				 struct device_attribute *attr,
>  				 char *buf)
> @@ -220,7 +255,6 @@ static void update_topology_flags_workfn(struct work_struct *work)
>  	update_topology = 0;
>  }
>  
> -static DEFINE_PER_CPU(u32, freq_factor) = 1;
>  static u32 *raw_capacity;
>  
>  static int free_raw_capacity(void)
