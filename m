Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848D03A24A3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 08:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhFJGoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 02:44:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39842 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhFJGoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 02:44:14 -0400
Received: from mail-wm1-f72.google.com ([209.85.128.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lrEOQ-0005A0-8y
        for linux-kernel@vger.kernel.org; Thu, 10 Jun 2021 06:42:18 +0000
Received: by mail-wm1-f72.google.com with SMTP id f186-20020a1c1fc30000b02901aaa08ad8f4so3393422wmf.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 23:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V7+XL9sJ4avOAFbP8M5lm1xje4LiQLiEskoJgKOFT0w=;
        b=pw8rSmCKfEOkzQhCNofEbohP7r+xCL9IpJ5UFCRauEqn3Efx4WKIQeYzHVg534CQg2
         /mBSHY7IzmKBQDJzIt2OYQKTGFRZnIIoXH0Z7dgAr8j9yketB0ZnU1qiWUVETjVtbBhV
         H01YA6gomJQMzRiF/zqkWYkGqAGf6xczJHWoKsRv1+d6ftOyp0vPNH8IShd+VM1Bp8CD
         VdUUP6JaOLODzQHSLeyGUlVN/ZDXY9gjwHob8YTsYdv7K9nk9wd1FMmVbAZ7UCVfgg/z
         kX0K4knknWHkSry2TuGhD3QQeoRR9IgKYATmIOVIEkGE8Z5FehmA9+asZwfxrGXrft1b
         QabQ==
X-Gm-Message-State: AOAM532fyKjeQkDC548A+fi1c4I9L6kFM4PJCONPSlDtWCen84D/N9tu
        YGlbGZ5w3JYRUJRj0g4k4SB9kZ1yhNWYISRwcKUPvJi8mAzHNOFIdOssPWCtamklJO6v+DZSEkt
        akQPWQ7r5t8EcnCS4ZWjXYIcpEro3wiDl3uyCtQWDFQ==
X-Received: by 2002:adf:eb82:: with SMTP id t2mr3473061wrn.337.1623307337805;
        Wed, 09 Jun 2021 23:42:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlNhcMYrDVL1IhoA/EKJ232q5LCxiyh5RMHIvdN4gRnzqxkVa6hl0Ki6hS5rAH/xKnsxMs5Q==
X-Received: by 2002:adf:eb82:: with SMTP id t2mr3473045wrn.337.1623307337644;
        Wed, 09 Jun 2021 23:42:17 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id u18sm1853015wmj.15.2021.06.09.23.42.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 23:42:17 -0700 (PDT)
Subject: Re: [PATCH 1/2] memory: tegra: Add missing dependencies
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210609112806.3565057-1-thierry.reding@gmail.com>
 <20210609112806.3565057-2-thierry.reding@gmail.com>
 <0c762772-929e-2eb8-6568-4aa82ea2f9ad@gmail.com>
 <ee2846c0-9274-0888-90ac-dac72d2ab5fd@canonical.com>
 <YMDzkyjaMhoJjMzL@orome.fritz.box>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <97fc44f9-30d5-cbcf-431a-fd0c4c7517b7@canonical.com>
Date:   Thu, 10 Jun 2021 08:42:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YMDzkyjaMhoJjMzL@orome.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2021 19:00, Thierry Reding wrote:
> On Wed, Jun 09, 2021 at 03:19:12PM +0200, Krzysztof Kozlowski wrote:
>> On 09/06/2021 13:58, Dmitry Osipenko wrote:
>>> 09.06.2021 14:28, Thierry Reding пишет:
>>>> From: Thierry Reding <treding@nvidia.com>
>>>>
>>>> When enabling the COMPILE_TEST Kconfig option, the Tegra memory
>>>> controller can be built without ARCH_TEGRA being selected. However, the
>>>> driver implicitly depends on some symbols pulled in via ARCH_TEGRA,
>>>> which causes the build to break.
>>>>
>>>> Add explicit dependencies for OF_EARLY_FLATTREE and OF_RESERVED_MEM to
>>>> the Tegra MC Kconfig option to make sure they are selected even if
>>>> ARCH_TEGRA is not.
>>>>
>>>> Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>>>> ---
>>>>  drivers/memory/tegra/Kconfig | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/memory/tegra/Kconfig b/drivers/memory/tegra/Kconfig
>>>> index f9bae36c03a3..ecfb071fc4f4 100644
>>>> --- a/drivers/memory/tegra/Kconfig
>>>> +++ b/drivers/memory/tegra/Kconfig
>>>> @@ -48,6 +48,8 @@ config TEGRA124_EMC
>>>>  config TEGRA210_EMC_TABLE
>>>>  	bool
>>>>  	depends on ARCH_TEGRA_210_SOC || COMPILE_TEST
>>>> +	select OF_EARLY_FLATTREE
>>>> +	select OF_RESERVED_MEM
>>>>  
>>>>  config TEGRA210_EMC
>>>>  	tristate "NVIDIA Tegra210 External Memory Controller driver"
>>>>
>>>
>>> Will this work if CONFIG_OF is disabled?
>>
>> Yeah, good question. That's why I propose "depends on". No issues with
>> unmet or circular dependencies.
> 
> I couldn't find a way to make this work with "depends on" because
> OF_RESERVED_MEM is not user-visible and the only way to get it enabled
> is if something also selects OF_EARLY_FLATTREE, which is only ever done
> at the architecture Kconfig level (and for OF unit testing).
> 
> So switching this to a "depends on" causes the TEGRA210_EMC never to get
> enabled.

Right.

> 
> However, with OF disabled, the above causes issues because it can lead
> to unmet direct dependencies. That, in turn, can be fixed by appending
> && OF to the COMPILE_TEST branch, which seems like a good enough
> compromise.
> 
> Here's what I have on top of the above patch and that seems to do the
> trick.
> 
> --- >8 ---
> diff --git a/drivers/memory/tegra/Kconfig b/drivers/memory/tegra/Kconfig
> index ecfb071fc4f4..1c553895160c 100644
> --- a/drivers/memory/tegra/Kconfig
> +++ b/drivers/memory/tegra/Kconfig
> @@ -47,13 +47,13 @@ config TEGRA124_EMC
>  
>  config TEGRA210_EMC_TABLE
>  	bool
> -	depends on ARCH_TEGRA_210_SOC || COMPILE_TEST
> +	depends on ARCH_TEGRA_210_SOC || (COMPILE_TEST && OF)
>  	select OF_EARLY_FLATTREE
>  	select OF_RESERVED_MEM
>  
>  config TEGRA210_EMC
>  	tristate "NVIDIA Tegra210 External Memory Controller driver"
> -	depends on ARCH_TEGRA_210_SOC || COMPILE_TEST
> +	depends on ARCH_TEGRA_210_SOC || (COMPILE_TEST && OF)
>  	select TEGRA210_EMC_TABLE
>  	help
>  	  This driver is for the External Memory Controller (EMC) found on
> --- >8 ---
> 
> So in a nutshell this will only get compile-tested if OF is enabled, but
> then it will select OF_RESERVED_MEM and OF_EARLY_FLATTREE to get the
> required symbols.

Could be also separate "depends on OF", even though it is included in
ARCH_TEGRA_XXX, but I am fine with this here.

Best regards,
Krzysztof
