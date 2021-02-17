Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D5031DC87
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 16:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbhBQPj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 10:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbhBQPjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 10:39:19 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77ABDC0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 07:38:38 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id v206so13128172qkb.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 07:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XRJ+49TR+P9xR+Yv/N5YNz5Xe+uRVUn68R2bZSbodzQ=;
        b=i+F9VmpOBxKQqz8SyUGCrE1A9zkcBw8vEiEfn6bWK2F/JEyUyqpignvI8EhPLwJ/JW
         fg3mHsoPjP1vUxzi/cmDzUVAuJSOmtpH0AFYIVH7MlrUgtrQlyRQLta/89k7RY/CPfSs
         7rUOiMU/nuq+bmaRgBy8v68//dBh4UjBU2BCdpiEuF0r7FuP8A7I7ok8JfooEBjFkpzq
         94vn9DmpPXoSK14ONJKHWroDT/QsfvzIkjTK73BBmuObxg3BpzJqsfHuqNgPMy7cIcew
         OnLW/d5mKw5Ix7aoXY9qCqJkLM0mIlJXdwA1FHnB5UDyHf2bIJSALhhIdyouhuUDUXfH
         szew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XRJ+49TR+P9xR+Yv/N5YNz5Xe+uRVUn68R2bZSbodzQ=;
        b=AnuQ0Uhk5nXEJMJKCMlEuZ6c70he6kQYpjSICG4Ptd9NL7APwe4hYZODTUe57BQhS3
         OHgWJzJL3b/+dKTEklIAKW6pwARD+JsXZLlUNyum3UW0/sL/AkN8sircvlkCsL2LHVfd
         eEnkIPF0a0YA82yC+ytL5CtwVkwG77tb0a2KfKbJCSABXyF9i9RXX66NTHNY5Ovqi5iP
         Ss0J30xTUsOzfE/HST/mhHfDkYmNBEXRUTuVOiWTeIJcMKZSLDkbas3+zEmQWYstY5jr
         AN2wjsmVezNbsgBNoB7wTMGvaZh3vvgngbIdqf7dBKChvxe4xpeuX76EjXzuf0Ut29ty
         TQdQ==
X-Gm-Message-State: AOAM532i5d3G+ruJjV4Nqf0GuNPUZ5ToWmNU6yMLvkH4cRX8ajxD1JAJ
        PxE0EAQsr/N44vuU1ixWfjQf7ND0+77krg==
X-Google-Smtp-Source: ABdhPJw3KOW63BdC9SznzI+lfQbZxm6pHpLjZ2ef4CxTvvC0j38/yrkQOCEeS7wBLHQeViRC7eVfDA==
X-Received: by 2002:ae9:e90c:: with SMTP id x12mr15897393qkf.498.1613576317376;
        Wed, 17 Feb 2021 07:38:37 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id h186sm1766262qke.129.2021.02.17.07.38.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Feb 2021 07:38:36 -0800 (PST)
Subject: Re: [PATCH] thermal: cpufreq_cooling: freq_qos_update_request()
 returns < 0 on error
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "v5 . 7+" <stable@vger.kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <b2b7e84944937390256669df5a48ce5abba0c1ef.1613540713.git.viresh.kumar@linaro.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <a23d2d44-1636-2ce1-d469-f6d344db66a1@linaro.org>
Date:   Wed, 17 Feb 2021 10:38:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b2b7e84944937390256669df5a48ce5abba0c1ef.1613540713.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/17/21 12:48 AM, Viresh Kumar wrote:
> freq_qos_update_request() returns 1 if the effective constraint value
> has changed, 0 if the effective constraint value has not changed, or a
> negative error code on failures.
> 
> The frequency constraints for CPUs can be set by different parts of the
> kernel. If the maximum frequency constraint set by other parts of the
> kernel are set at a lower value than the one corresponding to cooling
> state 0, then we will never be able to cool down the system as
> freq_qos_update_request() will keep on returning 0 and we will skip
> updating cpufreq_state and thermal pressure.
> 
> Fix that by doing the updates even in the case where
> freq_qos_update_request() returns 0, as we have effectively set the
> constraint to a new value even if the consolidated value of the
> actual constraint is unchanged because of external factors.
> 
> Cc: v5.7+ <stable@vger.kernel.org> # v5.7+
> Reported-by: Thara Gopinath <thara.gopinath@linaro.org>
> Fixes: f12e4f66ab6a ("thermal/cpu-cooling: Update thermal pressure in case of a maximum frequency capping")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Hi Guys,
> 
> This needs to go in 5.12-rc.
> 
> Thara, please give this a try and give your tested-by :).

It fixes the thermal runaway issue on sdm845 that I had reported. So,

Tested-by: Thara Gopinath<thara.gopinath@linaro.org>

> 
>   drivers/thermal/cpufreq_cooling.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> index f5af2571f9b7..10af3341e5ea 100644
> --- a/drivers/thermal/cpufreq_cooling.c
> +++ b/drivers/thermal/cpufreq_cooling.c
> @@ -485,7 +485,7 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
>   	frequency = get_state_freq(cpufreq_cdev, state);
>   
>   	ret = freq_qos_update_request(&cpufreq_cdev->qos_req, frequency);
> -	if (ret > 0) {
> +	if (ret >= 0) {
>   		cpufreq_cdev->cpufreq_state = state;
>   		cpus = cpufreq_cdev->policy->cpus;
>   		max_capacity = arch_scale_cpu_capacity(cpumask_first(cpus));
> 

-- 
Warm Regards
Thara
