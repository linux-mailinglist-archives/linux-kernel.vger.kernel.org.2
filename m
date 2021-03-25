Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069F534880B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 05:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhCYEqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 00:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhCYEpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 00:45:49 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78525C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 21:45:47 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id u19so565639pgh.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 21:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TZCYtGh2HBZtUVwJorCovGBfNLPiq/K1lzfxSXvx4vk=;
        b=lzA+PtY6tk9j1jqEKwnNE5FodVwxJ9SyNKaRzguSdVMKJtTPibr5m1YDbHDZlUL2cs
         SR/WoxKC8NySNh/4JjG/Znk7Aie03DSrUstcP7iOw8i94KmW+Kkkk67bBYKa73BBIWDM
         dhJQ1gtok7zH5JjmRoBSaERFY98YE+gCnB4DC+ye5O5GEU5uqtFdB0itt8LIJerXImJC
         c5Em5mBoBVSfzGK7Ll96X3XCOd6CcXbLKgLDZbqTQa3HhoKktwXqpQV1AwK4yiIXy/4y
         Zn52mvV9lo1PLmDD8GiNfOHWxWM2fHzElKXG7B9Pg1OZtaM8IlwZ5ODnC/UjnTApQ/pc
         IHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TZCYtGh2HBZtUVwJorCovGBfNLPiq/K1lzfxSXvx4vk=;
        b=QeyTkNgCgz2Bpzdr5JJlp2yHRVJCYfHVv0wHjhZPM/PQuk8XfkXq3fMNEPidWO7FAn
         qKd1asLgZOQdu6sEgVyzs51uBKKWI+PM20llz8lpERRpr9WpCCaXWpL5VRIFko7tK6h2
         HEDGNWAZELWBha6dZUt1p0bHJjQGkts9w7qx5bv853XbR1vFlj+09UUrGAXZhI2tnobz
         354SHbx8klChhZ7cYhNvp2jBUP1AlvFiXraO+XBmXTv4Y58Mqu2mtndySPcCScYufgOv
         Ca144W+xIRRfoFTh3l5tsx9yl7zI+LWI6d6SwkqFmzsn9KVHy08kkqHyjhXMX8sFzwXM
         YQug==
X-Gm-Message-State: AOAM532JXpCZVfS9kFPsCEKQL1FwNqHi43X0sfY+OmMKNp6+/28Jen9I
        skDTtPi1rNpC89nm6h+GMYn9Gw==
X-Google-Smtp-Source: ABdhPJwRrt10DupXwEJjP8A67bAxSHZqwqEv0CXzC8EE9Gp5F4JjjxuGgK+6nDLP8r23sBYTPqL5aQ==
X-Received: by 2002:a63:ec50:: with SMTP id r16mr5740664pgj.451.1616647546798;
        Wed, 24 Mar 2021 21:45:46 -0700 (PDT)
Received: from localhost ([122.172.6.13])
        by smtp.gmail.com with ESMTPSA id f15sm3727168pgg.84.2021.03.24.21.45.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Mar 2021 21:45:46 -0700 (PDT)
Date:   Thu, 25 Mar 2021 10:15:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     quanyang.wang@windriver.com
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: dt: check the error returned by
 dev_pm_opp_of_cpumask_add_table
Message-ID: <20210325044541.rsncitrmkpaes4dm@vireshk-i7>
References: <20210325043129.2255918-1-quanyang.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325043129.2255918-1-quanyang.wang@windriver.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-03-21, 12:31, quanyang.wang@windriver.com wrote:
> From: Quanyang Wang <quanyang.wang@windriver.com>
> 
> The function dev_pm_opp_of_cpumask_add_table may return zero or an
> error. When it returns an error, this means that no OPP table is
> added for the cpumask because _dev_pm_opp_cpumask_remove_table is
> called to free all OPPs associated with the cpu devices in the error
> label "remove_table". So continuing to run the next function
> dev_pm_opp_get_opp_count is meaningless since it always return the
> count value as 0.
> 
> There is another reason why we should check the error returned by
> dev_pm_opp_of_cpumask_add_table is that it may return -EPROBE_DEFER
> which comes from clk_get(dev, NULL) in _update_opp_table_clk. When
> the clk for cpu device isn't ready, dt_cpufreq_probe should be deferred
> and wait to be called again. But if we ignore the return error of
> dev_pm_opp_of_cpumask_add_table, dt_cpufreq_probe will return -ENODEV
> because dev_pm_opp_get_opp_count returns the count value as 0,
> the cpufreq-dt driver will fail with the error log as below:
> 
> [    0.724069] cpu cpu0: OPP table can't be empty
> 
> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
> ---
>  drivers/cpufreq/cpufreq-dt.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index b1e1bdc63b01..f24359f47b1a 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -255,10 +255,16 @@ static int dt_cpufreq_early_init(struct device *dev, int cpu)
>  	 * before updating priv->cpus. Otherwise, we will end up creating
>  	 * duplicate OPPs for the CPUs.
>  	 *
> -	 * OPPs might be populated at runtime, don't check for error here.

As the comment (which you removed) clearly says, the OPPs maybe added
at runtime, don't check for error here.

When we say runtime, we mean someone may have called dev_pm_opp_add()
for the devices.

> +	 * We need check the return value here, if it is non-zero, there is
> +	 * need to go on.
>  	 */
> -	if (!dev_pm_opp_of_cpumask_add_table(priv->cpus))
> -		priv->have_static_opps = true;
> +	ret = dev_pm_opp_of_cpumask_add_table(priv->cpus);
> +	if (ret) {
> +		dev_err(cpu_dev, "Failed to add OPP table for CPUs\n");
> +		goto out;
> +	}
> +
> +	priv->have_static_opps = true;
>  
>  	/*
>  	 * The OPP table must be initialized, statically or dynamically, by this

-- 
viresh
