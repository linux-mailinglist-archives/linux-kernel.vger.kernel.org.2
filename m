Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88A883EB9A4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 18:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241376AbhHMQAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 12:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241089AbhHMQAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 12:00:30 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EA3C061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 09:00:03 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v4so6833589wro.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 09:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7PXtXujZD4XZng1PTJIntgXjl3GoFzqtFBNOKPV0DYw=;
        b=rjD26/ksnY5lq/8q+yTqUfc8CoO5cbcVjSoG4sUphipTrgHoKHtgHb8wR39HdrVVPC
         LoODPOfIw8tp0hCi2WK/QDtzJ8N7nBvUIdcTNxdyj/FBydLmVE8DTvZPhU8CV+64Udhu
         4aySdcuQpkK++1v7eKui6/bGhzkBSAJAadneDzKFEDhmEaEeSgHLwWsrjba9wDYIMiLY
         9CTIsLyLjsmkPuJrCqVN6l8lpRTgTS1OYiCO5St8M5jnmTk6Qa8gDeaco/DTG6D7Xcnc
         IYR5F5W1UHcnZxVJnLJ5H+XUagAVfRmoFHxbnvOPxNpeuvLUv0GOeRlW1ybDSAHVOIQV
         Pebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7PXtXujZD4XZng1PTJIntgXjl3GoFzqtFBNOKPV0DYw=;
        b=R5rKrJ4qEYML+XIUUfnoQE+TUi1UWOPF6HXs3i+k4h3bRvkds8Q4SrsdH58kfIsVhJ
         3oj5rJKfMch9jCnxbP+XEj21zmhtCUkVWtDHpAvHie9/VYOet7QjGCOWeAClwx54TIlH
         PbxvIH8qgQoSVNp0Acyez6qRE4L1XX7mxy8Ul8I5WhM8oW2RfH3ZzK3UoapUW+DgItFW
         Hqi5GNVFXU20cIGB6w9ijkKUl226DETneUPrhrhOr4Z5ieJ8OH8E7XEIxSyEmL4ZTVsU
         lmUoYctUwsP+b6nRQfao1T6xZw9wTBti4csx1555Mf0Lf6ftFZx+hk0IC1qnzIp+Nz5m
         /FXQ==
X-Gm-Message-State: AOAM533hrfS/qCMItMErV8lcZdem1rVDFym3qhI6rCd39k2XnpWhVW8u
        h6X3TW1L5vFzQGcqC/+gGUTEYT2ZCE0+fW5x
X-Google-Smtp-Source: ABdhPJytmOoWuLmKkvkzL+gxg9fROF5WJi55LAKimehnefpeQrWrDvlcGOzfjBVM3rru93L7DeqW7A==
X-Received: by 2002:adf:97d7:: with SMTP id t23mr3885245wrb.81.1628870401615;
        Fri, 13 Aug 2021 09:00:01 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:5df3:d0eb:3945:640d? ([2a01:e34:ed2f:f020:5df3:d0eb:3945:640d])
        by smtp.googlemail.com with ESMTPSA id x18sm1956929wrw.19.2021.08.13.09.00.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 09:00:01 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] clocksource/drivers/sprd: Add module support to
 Unisoc timer
To:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210715065455.392923-1-zhang.lyra@gmail.com>
 <20210715065455.392923-4-zhang.lyra@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <47dcce5a-f438-9f12-5b60-651dc5f2b92c@linaro.org>
Date:   Fri, 13 Aug 2021 18:00:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715065455.392923-4-zhang.lyra@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/2021 08:54, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> Timers still have devices created for them. So, when compiling a timer
> driver as a module, implement it as a normal platform device driver.
> 
> Original-by: Baolin Wang <baolin.wang7@gmail.com>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  drivers/clocksource/Kconfig      |  2 +-
>  drivers/clocksource/timer-sprd.c | 15 ++++++++++-----
>  2 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index eb661b539a3e..a5a5b7c883ec 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -461,7 +461,7 @@ config MTK_TIMER
>  	  Support for Mediatek timer driver.
>  
>  config SPRD_TIMER
> -	bool "Spreadtrum timer driver" if EXPERT
> +	tristate "Spreadtrum timer driver" if EXPERT
>  	depends on HAS_IOMEM
>  	depends on (ARCH_SPRD || COMPILE_TEST)
>  	default ARCH_SPRD
> diff --git a/drivers/clocksource/timer-sprd.c b/drivers/clocksource/timer-sprd.c
> index 430cb99d8d79..a8a7d3ea3464 100644
> --- a/drivers/clocksource/timer-sprd.c
> +++ b/drivers/clocksource/timer-sprd.c
> @@ -5,6 +5,8 @@
>  
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
>  
>  #include "timer-of.h"
>  
> @@ -141,7 +143,7 @@ static struct timer_of to = {
>  	},
>  };
>  
> -static int __init sprd_timer_init(struct device_node *np)
> +static int sprd_timer_init(struct device_node *np)

Does the __init annotation really need to be removed ?

>  {
>  	int ret;
>  
> @@ -190,7 +192,7 @@ static struct clocksource suspend_clocksource = {
>  	.flags	= CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SUSPEND_NONSTOP,
>  };
>  
> -static int __init sprd_suspend_timer_init(struct device_node *np)
> +static int sprd_suspend_timer_init(struct device_node *np)
>  {
>  	int ret;
>  
> @@ -204,6 +206,9 @@ static int __init sprd_suspend_timer_init(struct device_node *np)
>  	return 0;
>  }
>  
> -TIMER_OF_DECLARE(sc9860_timer, "sprd,sc9860-timer", sprd_timer_init);
> -TIMER_OF_DECLARE(sc9860_persistent_timer, "sprd,sc9860-suspend-timer",
> -		 sprd_suspend_timer_init);
> +TIMER_PLATFORM_DRIVER_BEGIN(sprd_timer)
> +TIMER_MATCH("sprd,sc9860-timer", sprd_timer_init)
> +TIMER_MATCH("sprd,sc9860-suspend-timer", sprd_suspend_timer_init)
> +TIMER_PLATFORM_DRIVER_END(sprd_timer);

Please replace the above by something like:

TIMER_PLATFORM_DECLARE(sc9860_timer,
			"sprd,sc9860-timer",
			sprd_timer_init);

TIMER_PLATFORM_DECLARE(sc9860_persistent_timer,
			"sprd,sc9860-suspend-timer",
			sprd_suspend_timer_init);

Without TIMER_PLATFORM_DRIVER_BEGIN/END, and if possible the
MODULE_DESCRIPTION/LICENSE in the TIMER_PLATFORM_DECLARE macro itself.
The module description could be the first argument of the timer platform
declaration.

> +MODULE_DESCRIPTION("Unisoc broadcast timer module");
> +MODULE_LICENSE("GPL");



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
