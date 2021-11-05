Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDB74468C9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 20:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbhKETOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 15:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbhKETOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 15:14:43 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADE1C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 12:12:03 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id i13so7926296qvm.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 12:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9VbAQ4CycpeCydCl+3e6Z9qMj0HfgIwpfUKF3TZpwTw=;
        b=aHXSVZGBnFNVrscgu5YnLXxgZlLjwiiJ4V98kIwz5Rxoy7pm9zer1heuXbu5+Ph1Ul
         1sT5roSP6pI8+Y4jLH9GLHNdS5thhtFuy0hg8f9F36vXi4nqZVsgGblT2z5Jh8BLxEKq
         0eACSxvDJmzeG9r5XS5VCTojsT/Hhfqd+P+HENmA3YQOp39XgT9hWeMue1tsvBH1ild1
         UKYp8ZHGZYIfN9ShZOS3Vj9sJgLs6+nTd4YFoeeJPiRg18VQp9tDHh0yWGlxj8WXSgOk
         C/T5H5GeqWgMm53pSFqtY4qnZkbBhx56IQSho94dXqoRoelWHep2Ku5Hp1AEtHSkKXa1
         /bVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9VbAQ4CycpeCydCl+3e6Z9qMj0HfgIwpfUKF3TZpwTw=;
        b=Qs/py5aWDzbR/nSHLEdgcxWndvZUySzXJ4cUq79ef3iTzbA5XJKsqq/rJEPoWnuFfy
         wGuxX5o9tA5/Xp6MNJAUDxtAa9sF1Uw63DHjoNshNinu9L81+nhb/37ph8KqfQg/18zJ
         184sWo4mdxICM1eldqlWXVVekRK7Q8bHWeXylaRuOx8l5M60ayDXdzd8fC8yxfxxzER+
         BCUTtGyfDvgDe98MmPrTldfPdgKYRrXBeNhr1pGulhnUrGDGNSiCu4edYNJPdz7hzbrH
         bVJenMg+4DSPnPvNPuVw68/YArP4RyZxLpG6rdnt8IhfwuM/gLDb9uyTi9pGOKCPMaP6
         8ZUQ==
X-Gm-Message-State: AOAM532Mkkg3HDtXQlV2mRClSPMXvIgTGKLfheBkc0USciYNK/wq2aG0
        Z/4dKvZfo36C4VXOsFNNMR/Z5A==
X-Google-Smtp-Source: ABdhPJxeJE+3UWThCzYmmNpsdqTsnDzvmHohmwQv5Qxqs7WZ8rCVolNpJVy0SVneSw7k8wlsXQZqUA==
X-Received: by 2002:ad4:5965:: with SMTP id eq5mr1070840qvb.64.1636139522239;
        Fri, 05 Nov 2021 12:12:02 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id p16sm5893021qtx.92.2021.11.05.12.12.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 12:12:01 -0700 (PDT)
Subject: Re: [PATCH v3 4/5] cpufreq: qcom-cpufreq-hw: Use new thermal pressure
 update function
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, sudeep.holla@arm.com,
        will@kernel.org, catalin.marinas@arm.com, linux@armlinux.org.uk,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        viresh.kumar@linaro.org, amitk@kernel.org,
        daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
        bjorn.andersson@linaro.org, agross@kernel.org
References: <20211103161020.26714-1-lukasz.luba@arm.com>
 <20211103161020.26714-5-lukasz.luba@arm.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <c4a2618f-71ee-b688-6268-08256a8edf10@linaro.org>
Date:   Fri, 5 Nov 2021 15:12:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211103161020.26714-5-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,


On 11/3/21 12:10 PM, Lukasz Luba wrote:
> Thermal pressure provides a new API, which allows to use CPU frequency
> as an argument. That removes the need of local conversion to capacity.
> Use this new API and remove old local conversion code.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>   drivers/cpufreq/qcom-cpufreq-hw.c | 15 +++++----------
>   1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 0138b2ec406d..425f351450ad 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -275,10 +275,10 @@ static unsigned int qcom_lmh_get_throttle_freq(struct qcom_cpufreq_data *data)
>   
>   static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
>   {
> -	unsigned long max_capacity, capacity, freq_hz, throttled_freq;
>   	struct cpufreq_policy *policy = data->policy;
>   	int cpu = cpumask_first(policy->cpus);
>   	struct device *dev = get_cpu_device(cpu);
> +	unsigned long freq_hz, throttled_freq;
>   	struct dev_pm_opp *opp;
>   	unsigned int freq;
>   
> @@ -295,17 +295,12 @@ static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
>   
>   	throttled_freq = freq_hz / HZ_PER_KHZ;
>   
> -	/* Update thermal pressure */
> -
> -	max_capacity = arch_scale_cpu_capacity(cpu);
> -	capacity = mult_frac(max_capacity, throttled_freq, policy->cpuinfo.max_freq);
> -
>   	/* Don't pass boost capacity to scheduler */
> -	if (capacity > max_capacity)
> -		capacity = max_capacity;

So, I think this should go into the common 
topology_update_thermal_pressure in lieu of

+	if (WARN_ON(max_freq < capped_freq))
+		return;

This will fix the issue Steev Klimaszewski has been reporting
https://lore.kernel.org/linux-arm-kernel/3cba148a-7077-7b6b-f131-dc65045aa348@arm.com/


-- 
Warm Regards
Thara (She/Her/Hers)


> +	if (throttled_freq > policy->cpuinfo.max_freq)
> +		throttled_freq = policy->cpuinfo.max_freq;
>   
> -	arch_set_thermal_pressure(policy->related_cpus,
> -				  max_capacity - capacity);
> +	/* Update thermal pressure */
> +	arch_update_thermal_pressure(policy->related_cpus, throttled_freq);
>   
>   	/*
>   	 * In the unlikely case policy is unregistered do not enable
> 


