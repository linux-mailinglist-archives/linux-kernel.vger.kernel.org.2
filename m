Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8FF3F6DB1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 05:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237969AbhHYDco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 23:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhHYDcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 23:32:42 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEBBC061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 20:31:57 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id c17so21736160pgc.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 20:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=de2CSpUQO0idG+AiBQ/KE6mNPUJpXnby32dUUy1PTH8=;
        b=h4SjOaAagJlW/BkHrklNckUHyJ7EjF+MJ2L/tdhuDyqH27BueLlBuIgmVt4dsq5uXr
         SP9CWucSpxdeVVpVmAvN1/Fvn2qxa4nL3GvMoNJSZxnCX6OtQ1YdXaeG5MP66nv20QJ9
         FEC3T4Ds0heR/AEhKDuBs2MrbxV1s3L3dygMhd3/3G2iDk633jaLX+jdeFfuJdfHLtn6
         pK0l+DbM+t9wRUIb+ylW6reap9ta1rmF13/xB6o6xKjTSX4G/eQY3Dod44Bg6ArjfjjM
         yMrgHHRNWQS2x1sI5RsfSg/DOnkG4Ps0NulAAtbP2sKLsW31XA4dpasGaXtxuFCZibQs
         grLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=de2CSpUQO0idG+AiBQ/KE6mNPUJpXnby32dUUy1PTH8=;
        b=dt64zlUV95OajfS+byR2i7ziT55sSeoH/q21VJhD1C7h7OajCztVlz5/7/8HN6TmqY
         hz70/VPYfyRMe2nv8TS8JQkLYjFB3ECrcymmYYhpgDxJgGCJQMM0tRvYQdHlj1SkdfgY
         lJNU29q6hM1jetHGMVX4DWlysvW/swUYk1WLbYHhfvEHdC3O3oCDop55V+aX1GhB/28R
         O93Q7vrdLsCtaMScK7Dd5g+srQabUSWIzeItOWS9txIKwJ1cXX4S7O+jgw6/SEzu6HlU
         h7szByCZsGXNTUuAeq0dg5KjayToDZQUK71PA25FfK9cnz0JhGCUMpDn8Ql8uo6IiJ6x
         COYA==
X-Gm-Message-State: AOAM532eLvqy97tpilTkTcBdmdt7PvycFntDRUeahnZHOsjEscB+9DNY
        Z8btzpu6yuTCKi2FTLlMOLLgzQ==
X-Google-Smtp-Source: ABdhPJxlhpGyRI/QQR83pVLY5syDRHD1dy8ZI3FNSSRp+tZ2C1HmhbpP5IJZZDGJo3rpUXlY8gh5Bw==
X-Received: by 2002:a63:1247:: with SMTP id 7mr39547718pgs.366.1629862316998;
        Tue, 24 Aug 2021 20:31:56 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id e12sm20713732pfv.146.2021.08.24.20.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 20:31:55 -0700 (PDT)
Date:   Wed, 25 Aug 2021 09:01:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch_topology: Export cpu_scale and
 topology_set_thermal_pressure()
Message-ID: <20210825033152.hpxn73dlyqjai77t@vireshk-i7>
References: <a1053bd0e63ec0d985691b8a37bf7f6d5a1156aa.1629702403.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1053bd0e63ec0d985691b8a37bf7f6d5a1156aa.1629702403.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-08-21, 12:37, Viresh Kumar wrote:
> These are now used from a cpufreq driver which can be built as module,
> export them.
> 
> Fixes: 86afc1df661a ("cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> This needs to go via my ARM cpufreq tree. I will probably merge it with the
> concerned commit.
> 
>  drivers/base/arch_topology.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 921312a8d957..bf9d47a16d30 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -149,6 +149,7 @@ void topology_set_freq_scale(const struct cpumask *cpus, unsigned long cur_freq,
>  }
>  
>  DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
> +EXPORT_SYMBOL_GPL(cpu_scale);
>  
>  void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity)
>  {
> @@ -165,6 +166,7 @@ void topology_set_thermal_pressure(const struct cpumask *cpus,
>  	for_each_cpu(cpu, cpus)
>  		WRITE_ONCE(per_cpu(thermal_pressure, cpu), th_pressure);
>  }
> +EXPORT_SYMBOL_GPL(topology_set_thermal_pressure);
>  
>  static ssize_t cpu_capacity_show(struct device *dev,
>  				 struct device_attribute *attr,
> -- 
> 2.31.1.272.g89b43f80a514

+ this

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index bf9d47a16d30..43407665918f 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -149,7 +149,7 @@ void topology_set_freq_scale(const struct cpumask *cpus, unsigned long cur_freq,
 }

 DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
-EXPORT_SYMBOL_GPL(cpu_scale);
+EXPORT_PER_CPU_SYMBOL_GPL(cpu_scale);

 void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity)


-- 
viresh
