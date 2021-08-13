Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59FBF3EBC17
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 20:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbhHMSdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 14:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbhHMSdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 14:33:10 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B6CC061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 11:32:43 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id q11so14448144wrr.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 11:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=WaQTBe3xC/88raPQmY8ZZ8JJn9RnHYoGZNkxhX1EO84=;
        b=V+bl624JupBf+D+XFrPzacGflvEDgE0vwcRjyTf6yw3Omk0lTSIj+cL5vZN31H3msb
         P0LLdOEByqjgjyyd3dyaIfzRNVgVEs92ctms+VZvDxX1nzb6iqV/LSBeAIMNS64XlThX
         xX2itLVNjYZGEYV7yn9LKCrpDIQqZBl9fu5iybvAb+TVE/8pgcP7T6NPiRK+JvTE2D8e
         PYl9SZQxN8PfLsoHRwHSt/KYqBzHiEbEcrUkRWmnbmfSUE0XI+cFb8gAOnexhZQe/NkY
         944wO3FDXa6XcPIOa/QC3819HAqUEX4zJ5lU6qVGeJIX067olgR8fV/k2NOOfADN+Z5K
         UzIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WaQTBe3xC/88raPQmY8ZZ8JJn9RnHYoGZNkxhX1EO84=;
        b=H9qYiRVK31h+tNrg4zzBrAi/PjjmJGkcwTY8B9QTzHp8Y645ysD9d9ygL5amD+z63z
         jNol1axLeWjGxO5BpjUcT4YfL7R/jyvWdzj1kPUqQaBMTMf+UTJ94nZk59L6P8SCi4RL
         2XDrIgHtI9wNN236TOV1j1H9j8uCIjFFEVWZJD5ibSq8Z+yUApMNY5l8kCMUva1ZM9AX
         kBwUZOnSOaAjlaZHD44ZOYO3ro9hiM6REeXgZEV/2Xdt3EDjvyrhy0tYNQEVjkFQVbqj
         K+rjmx9QbZODZRvByri0PjSg9RI4Pa13diWZh3/g4qzCJKdVmJQy1egkwTfqkDYr7k2/
         k4Ag==
X-Gm-Message-State: AOAM530+cmdV65AP4iYWjuGwz8nLn1fg0Ejzg+qR4do9iYUGW89UKe7S
        rjSb6z317ZBS8wSLcQ9i6bUn1yeukjuSHWQZ
X-Google-Smtp-Source: ABdhPJxSGnm8fSXSKk8KR1FG/lpboSwc0HyN1WAywHVXeyGOcUHqbb+YEA41TVyCGc4vuBrO0ayCFw==
X-Received: by 2002:adf:f707:: with SMTP id r7mr4514805wrp.175.1628879561564;
        Fri, 13 Aug 2021 11:32:41 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:5df3:d0eb:3945:640d? ([2a01:e34:ed2f:f020:5df3:d0eb:3945:640d])
        by smtp.googlemail.com with ESMTPSA id k186sm2382823wme.45.2021.08.13.11.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 11:32:40 -0700 (PDT)
Subject: Re: [PATCH v2] genirq/timings: Fix error return code in
 irq_timings_test_irqs()
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <20210811093333.2376-1-thunder.leizhen@huawei.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <da85194b-34d1-25b7-3319-e98f52a52be5@linaro.org>
Date:   Fri, 13 Aug 2021 20:32:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210811093333.2376-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/2021 11:33, Zhen Lei wrote:
> Fix to return a negative error code from the error handling case instead
> of 0, as done elsewhere in this function.
> 
> Fixes: f52da98d900e ("genirq/timings: Add selftest for irqs circular buffer")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  kernel/irq/timings.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> v1 --> v2:
> Replace -EFAULT with two more appropriate error codes.
> 
> diff --git a/kernel/irq/timings.c b/kernel/irq/timings.c
> index d309d6fbf5bd..59affb3bfdfa 100644
> --- a/kernel/irq/timings.c
> +++ b/kernel/irq/timings.c
> @@ -794,12 +794,14 @@ static int __init irq_timings_test_irqs(struct timings_intervals *ti)
>  
>  		__irq_timings_store(irq, irqs, ti->intervals[i]);
>  		if (irqs->circ_timings[i & IRQ_TIMINGS_MASK] != index) {
> +			ret = -EBADSLT;
>  			pr_err("Failed to store in the circular buffer\n");
>  			goto out;
>  		}
>  	}
>  
>  	if (irqs->count != ti->count) {
> +		ret = -ERANGE;
>  		pr_err("Count differs\n");
>  		goto out;
>  	}
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
