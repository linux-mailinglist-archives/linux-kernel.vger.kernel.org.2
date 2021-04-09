Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1B135958B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 08:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbhDIGcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 02:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbhDIGcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 02:32:22 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D11BC061761
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 23:32:10 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id v8so2244533plz.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 23:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=28/bcnH/X+FO3xScorwIPxjziJdMECQ4SflmNRtuhf4=;
        b=nnobsVWbu3INJH0G3qQfwEkWoUf9+e7bCTJcA3kHFGiLT6KMMyjWn1PC4z/qRpW3E1
         pE2mVB0gQVKgQiX4CRqADVcHiV0C3O0jZYtBAAcoa+5mVaNZUMHVowdc2Zw3VOtTpvIR
         TpSDYDnVwuLfGZCBAgItXh9NhOdQce0R/9noZYoS+G3G57HmsLEKOUkTyCLZu6fRWQFY
         4W8XXWXKpqEyu1hG9/h9l82iE9AP0OZ7iGTsKNNjEucCuH543u3EkOioqWy+uF2Eoqah
         yrZYYi7H1+zyis1a7lx3hsz8/4mBt87WjW22mXIV+4bu5pQQqXQgpyAFf/hm+CVTMZtd
         0EHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=28/bcnH/X+FO3xScorwIPxjziJdMECQ4SflmNRtuhf4=;
        b=dHKdHWdsOTv4LzzbkoYZGyGWOlLE64SyTZ4GcvA1lihLASGE/o/bXM5PLooNW8Yxpa
         rwSbMZRWAINhy6VghVvtkmI2ilVMct/SDVn/q2UzV1yGFcz4t4CLBg82wgirZkIaGzzn
         /h29VZ8kVjCZ+ymbmnynpJ6MmzKBF9fQ5fy4kzFkRh6vs1vT5fPHy07lMYVsGBELl6K/
         Qo6nUsIbjl0sdhgoia+h4w33A0Ww+eEGQ693tZVl2y5GxUWzVphzxsD+ETb/R2dO8LCh
         dZYtnqtfZGHh0kfPgfC8ATgSPitlQ/Os6yf4AmJEARicamW+FGaOwLuTjoP52INo4SND
         V+kw==
X-Gm-Message-State: AOAM531CsuTdBvtq96iNBAy4iZ4HnBPqO5uKoBgqqVd4Cnag/gOLcZGK
        IbrjD46ckanIUb6SMVEvYybh
X-Google-Smtp-Source: ABdhPJzix94dGzGY3LxNVQhxzpy7L+sEbK4QOpLOA2Sfv46f0OsksuItNs6U/pFtB8lnPmwOd5v03g==
X-Received: by 2002:a17:902:c643:b029:e7:3c10:4695 with SMTP id s3-20020a170902c643b02900e73c104695mr11511308pls.41.1617949929607;
        Thu, 08 Apr 2021 23:32:09 -0700 (PDT)
Received: from work ([103.77.37.131])
        by smtp.gmail.com with ESMTPSA id g26sm1359647pge.67.2021.04.08.23.32.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Apr 2021 23:32:08 -0700 (PDT)
Date:   Fri, 9 Apr 2021 12:02:05 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org,
        daniel.lezcano@linaro.org
Subject: Re: [PATCH -next] clocksource/drivers/qcom: add missing iounmap() on
 error in msm_dt_timer_init()
Message-ID: <20210409063205.GC4376@work>
References: <20210409045657.666888-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409045657.666888-1-yangyingliang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 12:56:57PM +0800, Yang Yingliang wrote:
> base and cpu0_base are not unmapped on error path, add the missing
> iounmap() before return msm_dt_timer_init() in the error handling
> cases.
> 
> Fixes: 6e3321631ac2 ("ARM: msm: Add DT support to msm_timer")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/clocksource/timer-qcom.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-qcom.c b/drivers/clocksource/timer-qcom.c
> index b4afe3a67583..3488876198e0 100644
> --- a/drivers/clocksource/timer-qcom.c
> +++ b/drivers/clocksource/timer-qcom.c
> @@ -213,7 +213,8 @@ static int __init msm_dt_timer_init(struct device_node *np)
>  	irq = irq_of_parse_and_map(np, 1);
>  	if (irq <= 0) {
>  		pr_err("Can't get irq\n");
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto err_unmap_base;
>  	}
>  
>  	/* We use CPU0's DGT for the clocksource */
> @@ -223,18 +224,19 @@ static int __init msm_dt_timer_init(struct device_node *np)
>  	ret = of_address_to_resource(np, 0, &res);
>  	if (ret) {
>  		pr_err("Failed to parse DGT resource\n");
> -		return ret;
> +		goto err_unmap_base;
>  	}
>  
>  	cpu0_base = ioremap(res.start + percpu_offset, resource_size(&res));
>  	if (!cpu0_base) {
>  		pr_err("Failed to map source base\n");
> -		return -EINVAL;

Missing "ret = -EINVAL" assignment. With that fixed,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> +		goto err_unmap_base;
>  	}
>  
>  	if (of_property_read_u32(np, "clock-frequency", &freq)) {
>  		pr_err("Unknown frequency\n");
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto err_unmap_cpu0_base;
>  	}
>  
>  	event_base = base + 0x4;
> @@ -243,7 +245,18 @@ static int __init msm_dt_timer_init(struct device_node *np)
>  	freq /= 4;
>  	writel_relaxed(DGT_CLK_CTL_DIV_4, source_base + DGT_CLK_CTL);
>  
> -	return msm_timer_init(freq, 32, irq, !!percpu_offset);
> +	ret = msm_timer_init(freq, 32, irq, !!percpu_offset);
> +	if (ret)
> +		goto err_unmap_cpu0_base;
> +
> +	return 0;
> +
> +err_unmap_cpu0_base:
> +	iounmap(cpu0_base);
> +err_unmap_base:
> +	iounmap(base);
> +
> +	return ret;
>  }
>  TIMER_OF_DECLARE(kpss_timer, "qcom,kpss-timer", msm_dt_timer_init);
>  TIMER_OF_DECLARE(scss_timer, "qcom,scss-timer", msm_dt_timer_init);
> -- 
> 2.25.1
> 
