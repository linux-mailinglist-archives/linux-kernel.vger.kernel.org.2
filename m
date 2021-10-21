Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3AE3436110
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 14:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhJUMKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 08:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbhJUMKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 08:10:04 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1FEC061749
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 05:07:48 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id o24-20020a05600c511800b0030d9da600aeso528182wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 05:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=jwitIqYt5KYJE8bMdOs497KWqf0OH0KRAwwe6MsrJao=;
        b=pLY2deFY5fIj2lxUXtmdZECyualMiecCGsuTTxM0lO6aYU7z8en+Zveke4smY1w31S
         YMP8mZJoktpcrbkeGPrQAz7yLYRlpe9thgQBPc5KN2ymEg90Pfb/Ytcrr730D87KcMB9
         Yeq2eQIdjhFWSJcOMKGmGuE4ktWju8BP9Omwe2NwLloQaCfiumVSGAEUcZQaahpc03s0
         FXa9pStbbkoRDhnGKW2twGt+9WG40oKmhA+RmKuUjaktDgH4CNi0pl5LrzQi+7g4ftzU
         8JidS3DV9bdc0a5gztZyuHMySFEwm/aoMZ2AlxP5h/6Ge4CLt6FjZbOCx7PvqDJEmP6L
         GB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jwitIqYt5KYJE8bMdOs497KWqf0OH0KRAwwe6MsrJao=;
        b=iz50uGgfw51vXjLaIutj9jV2OT0Cb0g0wON+GsZlyitxJAGxyVmcZR6CgzLGMiTgtQ
         Gf3OxbUg3eI/3E7+0+FveCPIirIk262vLLYVPIS8pme5120mbZ7+BdxhtW66on2d6kdW
         2mQSz4yZNyCSsrxxolYzeMeSNLWDLFGdp7V74ehOb0rWasLVVZO7kOLgm649OaLgHxhn
         vG/1w1Wkol03xLzxjG4m/6gDGVMw0tYp/EtvDom+QGBphTuJYmgpokFhYM76EB0SLTsR
         2vb0c9fFwfW1PMiFSUq2LZpSbcxDKTvqVf9EfVfQvykArK5Jcb7lcnhGPBU498PWqHcz
         PlKw==
X-Gm-Message-State: AOAM530ds4J1MiZq3z4aT2MUZX/uq7X6qfhRERo+fqWwxSm4WzFqantx
        oji02ztVpDHsim12La+PWSQi1Q==
X-Google-Smtp-Source: ABdhPJwgnpojvUNOkm5X3VWBKYdeVxr+KSsIdG8ATeJn4nSKXQDUUeJUwhFeIWr2MSmdrT8fFwjyyQ==
X-Received: by 2002:a1c:ac03:: with SMTP id v3mr6261500wme.127.1634818066843;
        Thu, 21 Oct 2021 05:07:46 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:2a2c:7ed:66a0:d637? ([2a01:e34:ed2f:f020:2a2c:7ed:66a0:d637])
        by smtp.googlemail.com with ESMTPSA id r5sm7503539wmh.28.2021.10.21.05.07.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 05:07:46 -0700 (PDT)
Subject: Re: [PATCH] clocksource/drivers: depend on sub-architecture for
 Exynos MCT and Samsung PWM
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20211021063500.39314-1-krzysztof.kozlowski@canonical.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <fc0e9d34-72f6-0d95-fa4f-a25f5d8e5125@linaro.org>
Date:   Thu, 21 Oct 2021 14:07:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211021063500.39314-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2021 08:35, Krzysztof Kozlowski wrote:
> The Exynos MCT and Samsung PWM Timer clocksource drivers are not usable
> on anything else than Samsung Exynos, S3C or S5P SoC platforms.  These
> are integral parts of a SoC.  Even though the drivers are not user
> selectable, still document the hardware architecture explicitly with
> depends on ARCH_EXYNOS and others.  This also serves a purpose of
> documenting use-case, if someone ever wonders whether to select the
> driver for his platform.  No functional change, because drivers are
> already selected by the platform described in depends. We follow similar
> approach also for other SoC-specific drivers.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  drivers/clocksource/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 0f5e3983951a..3ff6e1f87246 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -418,12 +418,14 @@ config ATMEL_TCB_CLKSRC
>  config CLKSRC_EXYNOS_MCT
>  	bool "Exynos multi core timer driver" if COMPILE_TEST
>  	depends on ARM || ARM64
> +	depends on ARCH_EXYNOS || COMPILE_TEST
>  	help
>  	  Support for Multi Core Timer controller on Exynos SoCs.
>  
>  config CLKSRC_SAMSUNG_PWM
>  	bool "PWM timer driver for Samsung S3C, S5P" if COMPILE_TEST
>  	depends on HAS_IOMEM
> +	depends on ARCH_EXYNOS || ARCH_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210 || COMPILE_TEST
>  	help
>  	  This is a new clocksource driver for the PWM timer found in
>  	  Samsung S3C, S5P and Exynos SoCs, replacing an earlier driver
> 

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
