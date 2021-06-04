Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE7939B4CD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 10:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhFDI0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 04:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhFDI0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 04:26:53 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B27C06174A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 01:24:58 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id o127so4856407wmo.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 01:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9B11phrLUGX5wIVrRA8NHtveBN9OW2EGh60dz1Otdhs=;
        b=FZoqlOXCsRfpBuaLPbPOsQ5vFsPSKGEJg6ezShtIvyOVEvvnBe+nejWMntFwXGkuCr
         aN4YfLjlDEalKbG30jN9VSOu1uGXJIA5vLgPGSW3oBVx0rhWzhUR67YZNg+VrO9PPoYF
         WEy5rrCWDCrkhVcdN9dIwKYANnCx1uWfhdo3z6+PZnR5f/W1N4UbUdbtxysPAJe2na+P
         ElmSBwzSd55+d50n+Qgy2dJ0YaKDGQH2jq8amICQJrtBp3Lh+x08573sUozXVMU2ztRq
         8XGnCMOevhlyNOcffDVw6XBNQtEx1s8eTO5qBWynfqJRZZZKj8oHcFKina3e990OC1u+
         HRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9B11phrLUGX5wIVrRA8NHtveBN9OW2EGh60dz1Otdhs=;
        b=s397S3bzWMjBiDdB5AO3KnidXUKF5vOUUTR9XtP1bxkF5qNGm4vTmL7Tyc1X5EE1De
         Blv4ftDCghE3+M8OyI/TNfzlSZZUCzww6+d/XNeHa1NVX2/qMrsG1Lck7siNB8bcjBMR
         wJ6tTr4yapB7pXq/X6X1HYnOcwGIor5/ntFMTNcHPac9Chws3x3rZRsAp7DJIiKVzUnn
         /Z/vBt2JInX6lEb8LKEilUoP7koXqkkfKtts4wuGZzYqC5HVfJ+dk1ru9NN+yBbSmLbd
         POSKGknmaQ1RhVp8/m7uXRJNm6FnzQ3Mf5ccaKx8xTVP5HCWAJgdE5Z+zM+ot38Qt2mz
         qnqQ==
X-Gm-Message-State: AOAM531OsbQ1jZdWvrrU+nVIRd1HfGai626Y8C8dwCGUI4q0sNy189zA
        ksY28XyGesTYbsqzC1XHZMBjZ+1iPoH4pyUX
X-Google-Smtp-Source: ABdhPJwV/PQZLT2XuSMOzmoRFOi9oNgOsBloqY2EquPgUV9s3LfP/3hG1TZp76wvSPWEIWf0bC0QJA==
X-Received: by 2002:a05:600c:d0:: with SMTP id u16mr2375599wmm.155.1622795096064;
        Fri, 04 Jun 2021 01:24:56 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:70d3:6c26:978:999d? ([2a01:e34:ed2f:f020:70d3:6c26:978:999d])
        by smtp.googlemail.com with ESMTPSA id f18sm4958389wmj.13.2021.06.04.01.24.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 01:24:55 -0700 (PDT)
Subject: Re: [PATCH] clocksource/drivers/sprd: Remove the dependency between
 sprd timer and SPRD arch
To:     Nianfu Bai <bnf20061983@gmail.com>, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, nianfu.bai@unisoc.com,
        ruifeng.zhang1@unisoc.com
References: <1620716925-4329-1-git-send-email-bnf20061983@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <aac6c6a3-6666-075a-6901-7e3c3b2ae01d@linaro.org>
Date:   Fri, 4 Jun 2021 10:24:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1620716925-4329-1-git-send-email-bnf20061983@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2021 09:08, Nianfu Bai wrote:
> From: Nianfu Bai <nianfu.bai@unisoc.com>
> 
> Tick broadcast installed by insmod cannot switch to oneshot mode correctly
> caused by linux timer framework, need to build in kernel image.

What timer is compiled as a module? Why the timer framework does not
allow to switch to it ?

> SPRD_TIMER
> has been selected by SPRD arch, we have to enable SPRD arch when we build
> sprd timer in kernel image, this action conflicts with general kernel image,

Why this is conflicting with general kernel image?

> so we need to remove the dependency between sprd timer and SPRD arch.

Can you rephrase the changelog, I'm not getting the point.

> Signed-off-by: Nianfu Bai <nianfu.bai@unisoc.com>
> Signed-off-by: Ruifeng Zhang <ruifeng.zhang1@unisoc.com>
> ---
>  drivers/clocksource/Kconfig | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 39aa21d..04b333c 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -447,10 +447,8 @@ config MTK_TIMER
>  	  Support for Mediatek timer driver.
>  
>  config SPRD_TIMER
> -	bool "Spreadtrum timer driver" if EXPERT
> +	bool "Spreadtrum timer driver" if COMPILE_TEST
>  	depends on HAS_IOMEM
> -	depends on (ARCH_SPRD || COMPILE_TEST)
> -	default ARCH_SPRD
>  	select TIMER_OF
>  	help
>  	  Enables support for the Spreadtrum timer driver.
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
