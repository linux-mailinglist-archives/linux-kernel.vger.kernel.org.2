Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E629D448047
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 14:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239959AbhKHN2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 08:28:07 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:48752
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239960AbhKHN14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 08:27:56 -0500
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4ACF53F1C0
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 13:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1636377911;
        bh=cQNVECNpHuXn3Gv40lUHf3vm0HMBLn3SO5kTNb9udHg=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Xr0QgcLll4nIHDrkgRf1692DTjeVtsdoED8rrcLVJ4kYK0OJ5XqjDzkLap2O4pFKM
         YwBtsox5xnn2CNqFlHkpimqmXLQqcGXIlC+5bSUiQuP65wKrBLGTzWuUg7EQYDuauB
         D9PiFFyL5QaSnYnwOJqiAqQdazXnkZjVvqNZimcNZ02kAUzUgdeCPVEVLazmYWc8YW
         v4miPdtaENhm3lYXZGRQyxhEL61yGTAq+qOfLL3WZiuse/ljO1CSpRWma2tEfQMl6n
         FDEgavs8GneddPn0A/F6nXHJyUVA6gBKD1eHycJDWGsIj5yloMxt7r28YOfRaQTG4N
         OF4bqYfSVK9tA==
Received: by mail-lf1-f71.google.com with SMTP id s18-20020ac25c52000000b004016bab6a12so6456790lfp.21
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 05:25:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cQNVECNpHuXn3Gv40lUHf3vm0HMBLn3SO5kTNb9udHg=;
        b=qCdjIPOdO/SnRBjVKQY5HXL5rkwzret6+y8PXiVO7vyTlFsAertzfPH2OiBlPEG5Pj
         3Rzl1kSXmyWkifMMKzPNm41LIckg52D3peMtywW3J/lTIGsGirzpYucP9kALBAsSTK+C
         2VZVELAOWz3/u7uiYmMwmOV0DPwhDh8PK3xMbOAs/MtfQ4XMuCocBtWWYkejea0Su+E7
         /jQF6PjRYh22+9WxdCZaQK5uDyKHp/ozTLfg0ZQvn/CEGfoSk7oD1vdOIY1vSLG3F7Ul
         qvFHFw7GWpxhiz23/yPVR1xhnjrh7eYrEZ/t4An4/hEoX8nS38e5QvsNKPQxFrE9/AUJ
         veuw==
X-Gm-Message-State: AOAM5302FWvKfTZ9O59tsDuPLBn6jaF80zDPPDBYxuE8ySC9BmOOAgp2
        0ABvia6K45X73zI9mM8f3ptlr70PZwB7IhOI/bI+AGYG44jn5ER0K93lvfnaARYjUeIYXFuA2fM
        2bG7aSaNG47AuBTbkHat/nWlAIHvA2258vY13LR3lRw==
X-Received: by 2002:ac2:4f02:: with SMTP id k2mr74616247lfr.415.1636377910764;
        Mon, 08 Nov 2021 05:25:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyVkWMjaG1ydKUi2N53zvF6W6a1WDL4riE4vI34E9xDpFmNKcciyZDkrjMVTWlTTUO5Qz090A==
X-Received: by 2002:ac2:4f02:: with SMTP id k2mr74616212lfr.415.1636377910531;
        Mon, 08 Nov 2021 05:25:10 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id c23sm1550726ljr.85.2021.11.08.05.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 05:25:10 -0800 (PST)
Message-ID: <0bf73f1a-3be0-5135-747c-f31eb4007314@canonical.com>
Date:   Mon, 8 Nov 2021 14:25:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v3 12/12] watchdog: s3c2410: Add Exynos850 support
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20211107202943.8859-1-semen.protsenko@linaro.org>
 <20211107202943.8859-13-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211107202943.8859-13-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2021 21:29, Sam Protsenko wrote:
> Exynos850 is a bit different from SoCs already supported in WDT driver:
>   - AUTOMATIC_WDT_RESET_DISABLE register is removed, so its value is
>     always 0; .disable_auto_reset callback is not set for that reason
>   - MASK_WDT_RESET_REQUEST register is replaced with
>     CLUSTERx_NONCPU_IN_EN register; instead of masking (disabling) WDT
>     reset interrupt it's now enabled with the same value; .mask_reset
>     callback is reused for that functionality though
>   - To make WDT functional, WDT counter needs to be enabled in
>     CLUSTERx_NONCPU_OUT register; it's done using .enable_counter
>     callback
> 
> Also Exynos850 has two CPU clusters, each has its own dedicated WDT
> instance. Different PMU registers and bits are used for each cluster. So
> driver data is now modified in probe, adding needed info depending on
> cluster index passed from device tree.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
> Changes in v3:
>   - Renamed "samsung,index" property to more descriptive
>     "samsung,cluster-index"
>   - Used pre-defined and completely set driver data for cluster0 and
>     cluster1
> 
> Changes in v2:
>   - Used single compatible for Exynos850, populating missing driver data
>     in probe
>   - Added "index" property to specify CPU cluster index
> 
>  drivers/watchdog/s3c2410_wdt.c | 62 +++++++++++++++++++++++++++++++++-
>  1 file changed, 61 insertions(+), 1 deletion(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
