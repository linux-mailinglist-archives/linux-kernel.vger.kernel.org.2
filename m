Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363213EB9BA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 18:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241536AbhHMQDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 12:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241209AbhHMQDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 12:03:52 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21924C0617AD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 09:03:25 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id f9-20020a05600c1549b029025b0f5d8c6cso9995793wmg.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 09:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x0xWLTk86tzzRjkpfY1Nei5soG6C/jHVAXTF3VFx8as=;
        b=oid8lx5rMiXxBC7FhshiK5zRVwBoupwa7etIGRHYqQP5Ghxv3EasyGjtRUp/q5Z46g
         dPi4hgDi6lfE5M69WkGUYoB4UpHQjdbW7/b5w+LQt9p0RZAURATPXapoGxPpFNZGjzQ2
         Va9LQd+pJxCIAWHKes5nlRutYkbGgOx43p5fIFbu9CspxwKZ0CrPNYFzCNlRiL+FJ93W
         TklrGcoUss7pCNoyZU9yjb2EHpT0pnIOHwJ3YWr6JRwQpdEjkHA7IduQ3ogIp5ZS3EEF
         TY52xmFQkxtmdRAbmlYH2KZXBZWX0m8UvuZV3/wRxjMEJMwUP5V9hqpzXnySsIbfOhVF
         3TFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x0xWLTk86tzzRjkpfY1Nei5soG6C/jHVAXTF3VFx8as=;
        b=o14u+Ek0fdWHk4at/93oA+q1y5R81Ww0LTKovULMIhPooZrZDoWbPajINYeEFiLP66
         nvYlqcOpvPtuH8IInO2Lo75G5z6+4uQeJm+4oLA6fs0y6Z3wAmRI6P4SheHCT3rp0aEj
         NuPK7S1snwpQC1xod3j+erBmvfxm58KECOyH52TPgV081SqwXFJe60s/cTG4uhtZYeb8
         YOd41VIOlSnGu1WaAVdbskAANkYHvXGO6KLZo1n4Ro+SQvZEw9XCeiptNTtwDebA92Uh
         eSE9JofrJQIuI7RpDXL5GKBvR5M3SuHQPt+0cKsP8LvGhBuNsJTV275Kx06NJye/oE6i
         Br4A==
X-Gm-Message-State: AOAM5303gTOF1Rwvtx3gNE+q2qhAM3TcnGF2I+s282UVwb6gkgFDC5KL
        hSBDT9me2QjnEGD96AZr0tAsmg==
X-Google-Smtp-Source: ABdhPJxcIJRrl7o4ZN0CYfus5qLWkxvFiJ5ZwqVc8qhAmA8Ox/ETKV+ybqsxewm9Za6B47x1WERQbA==
X-Received: by 2002:a05:600c:2290:: with SMTP id 16mr3333448wmf.26.1628870603592;
        Fri, 13 Aug 2021 09:03:23 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:5df3:d0eb:3945:640d? ([2a01:e34:ed2f:f020:5df3:d0eb:3945:640d])
        by smtp.googlemail.com with ESMTPSA id i9sm2470529wre.36.2021.08.13.09.03.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 09:03:23 -0700 (PDT)
Subject: Re: [PATCH v4 4/9] clocksource/drivers/pistachio: Make it selectable
 for MIPS
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, mturquette@baylibre.com,
        linus.walleij@linaro.org, vkoul@kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org
References: <20210723022543.4095-1-jiaxun.yang@flygoat.com>
 <20210723022543.4095-5-jiaxun.yang@flygoat.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <9db45153-d4d6-aab9-8cf8-12fdb76be249@linaro.org>
Date:   Fri, 13 Aug 2021 18:03:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210723022543.4095-5-jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/2021 04:25, Jiaxun Yang wrote:
> So it will be avilable for generic MIPS kernel.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  drivers/clocksource/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 39aa21d01e05..58ad7af8c673 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -234,8 +234,9 @@ config CLKSRC_LPC32XX
>  	  Support for the LPC32XX clocksource.
>  
>  config CLKSRC_PISTACHIO
> -	bool "Clocksource for Pistachio SoC" if COMPILE_TEST
> +	bool "Clocksource for Pistachio SoC"
>  	depends on HAS_IOMEM
> +	depends on MIPS || COMPILE_TEST

The dependency on the platform is only required if the COMPILE_TEST
fails on other platforms.

The selection is done from arch/mips/Kconfig directly otherwise.

>  	select TIMER_OF
>  	help
>  	  Enables the clocksource for the Pistachio SoC.
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
