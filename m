Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D30F3E9219
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 15:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhHKNDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 09:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhHKND3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 09:03:29 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4ACC0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 06:03:05 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id k5-20020a05600c1c85b02902e699a4d20cso1932823wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 06:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AqwR7UHrn20S3n/wFp8Ztpc7zTrM7eu8gtRouwgpGvc=;
        b=verhkYONjh/bmkxuuMlb05dYBtGbRA2R5V6q4zs5orZxTT2tMsXq2OK4IE53C8Al4D
         OAXA5mnFmtat3PrXziIkX/B5Np+BAvRD/FXP6b2i2BPzC4UhSSXlxvNTIhCZCnhwzcaZ
         1yKwr7YVC8bQ5YKTr/m1xxO6CVXspl2E4h7oKgKJxVTRgcwTNW3Xng/HQXaWT7bL5Tzw
         FfA3xlO2GNIBtpGgy9KXEiypr0ZlJlRl5RGsd8dFOj8aedMc2GXLdJyALF5X4ROCXeuk
         lWgiaG1WaqcEwTssvx2COP2NHrEmm3gwF5b5IV8DQ+dbsIpH6Z2EQSW2UefCUYufvArZ
         RU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AqwR7UHrn20S3n/wFp8Ztpc7zTrM7eu8gtRouwgpGvc=;
        b=I6mQyEMozUU2k2Q8ysbMTQaWiucgjdMOSmzk+FMMiJRoQvFwPLMaapPzG0myC/JNwl
         JWXTi3fkHJmi3xswQDeUpQ6g6PJoYc5mdilA1fGTsjX8JaukzZux6EidxIdsmgxWAjiC
         VcS6b2w1L7CKMs3PMQiFA6eLf5Jb5UA58uU2cNSHMiTy5YoqhwufhIRrcVTs/3RACL65
         Mx65g3a+NOFQ+xFkY0/k4nNGyzH6BKbOIxODBdNK7N6/spoIeUmTwGFGLVnlR8m8IA1N
         0SA7BHRHp5HJObIW1ed8Bc/2t27OfRLQ4T+2Yj3zjZU+eXE19lgWYDWioLgU7OVsvC41
         Z4gg==
X-Gm-Message-State: AOAM533lIo+TO9pB8wz/QJ3gfquO84XC1IQXGoLMefy7qCn2fzx0/8CE
        Ni73cGg7jxDQS3pAbn5qSBvXDg==
X-Google-Smtp-Source: ABdhPJx26mqFbKQ5oB8WhMSfI6s7eRRmgFFGuwTfvgXtp69+qln4lHzYRD1kpJS07EOfAn/E7B6sfA==
X-Received: by 2002:a05:600c:19cd:: with SMTP id u13mr5890407wmq.143.1628686983626;
        Wed, 11 Aug 2021 06:03:03 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:43fd:e634:73d9:e10e])
        by smtp.gmail.com with ESMTPSA id h8sm5771860wmb.35.2021.08.11.06.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 06:03:03 -0700 (PDT)
Date:   Wed, 11 Aug 2021 14:02:57 +0100
From:   Quentin Perret <qperret@google.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/9] cpufreq: Auto-register with energy model if asked
Message-ID: <YRPKgdVxM7Mytf75@google.com>
References: <cover.1628682874.git.viresh.kumar@linaro.org>
 <9ca302a02d6b51240af8668634c93972183b593f.1628682874.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ca302a02d6b51240af8668634c93972183b593f.1628682874.git.viresh.kumar@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 Aug 2021 at 17:28:39 (+0530), Viresh Kumar wrote:
> Many cpufreq drivers register with the energy model for each policy and
> do exactly the same thing. Follow the footsteps of thermal-cooling, to
> get it done from the cpufreq core itself.
> 
> Provide a new callback, which will be called, if present, by the cpufreq
> core at the right moment (more on that in the code's comment). Also
> provide a generic implementation that uses dev_pm_opp_of_register_em().
> 
> This also allows us to register with the EM at a later point of time,
> compared to ->init(), from where the EM core can access cpufreq policy
> directly using cpufreq_cpu_get() type of helpers and perform other work,
> like marking few frequencies inefficient, this will be done separately.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 12 ++++++++++++
>  include/linux/cpufreq.h   | 14 ++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 06c526d66dd3..75974e7d6cc5 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1493,6 +1493,18 @@ static int cpufreq_online(unsigned int cpu)
>  		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>  	}
>  
> +	/*
> +	 * Register with the energy model before sched_cpufreq_governor_change()
> +	 * is called, which will result in rebuilding of the sched domains,
> +	 * which should only be done once the energy model is properly
> +	 * initialized for the policy first.
> +	 *
> +	 * Also, this should be called before the policy is registered with
> +	 * cooling framework.
> +	 */
> +	if (cpufreq_driver->register_em)
> +		cpufreq_driver->register_em(policy);

Maybe move that to the 'if (new_policy)' block above? There is currently
no need to re-register the EM on CPU hotplug.

>  	ret = cpufreq_init_policy(policy);
>  	if (ret) {
>  		pr_err("%s: Failed to initialize policy for cpu: %d (%d)\n",
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 9fd719475fcd..1295621f6c28 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -9,10 +9,12 @@
>  #define _LINUX_CPUFREQ_H
>  
>  #include <linux/clk.h>
> +#include <linux/cpu.h>
>  #include <linux/cpumask.h>
>  #include <linux/completion.h>
>  #include <linux/kobject.h>
>  #include <linux/notifier.h>
> +#include <linux/pm_opp.h>
>  #include <linux/pm_qos.h>
>  #include <linux/spinlock.h>
>  #include <linux/sysfs.h>
> @@ -373,6 +375,12 @@ struct cpufreq_driver {
>  	/* platform specific boost support code */
>  	bool		boost_enabled;
>  	int		(*set_boost)(struct cpufreq_policy *policy, int state);
> +
> +	/*
> +	 * Set by drivers that want the core to automatically register the
> +	 * policy's devices with Energy Model.
> +	 */
> +	void		(*register_em)(struct cpufreq_policy *policy);
>  };
>  
>  /* flags */
> @@ -1046,4 +1054,10 @@ unsigned int cpufreq_generic_get(unsigned int cpu);
>  void cpufreq_generic_init(struct cpufreq_policy *policy,
>  		struct cpufreq_frequency_table *table,
>  		unsigned int transition_latency);
> +
> +static inline void cpufreq_register_em_with_opp(struct cpufreq_policy *policy)
> +{
> +	dev_pm_opp_of_register_em(get_cpu_device(policy->cpu),
> +				  policy->related_cpus);
> +}

I was thinking this could go in pm_opp.h instead, but it doesn't really
matter.

So, with the first comment above fixed:

Reviewed-by: Quentin Perret <qperret@google.com>

Thanks,
Quentin
