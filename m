Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4FD442C32
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 12:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbhKBLMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 07:12:33 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:49432
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230407AbhKBLMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 07:12:31 -0400
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D2D3B3F1BB
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 11:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635851395;
        bh=LV8zs29Q6RtVe0ovS7PkdLCxTId0vPm+EpRZ40grHT8=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=ZzRgH9Ttp4w899YDPr/iVoTCNB0FuMEJGWHr+kRlYvc27o12jB/Pwf3y8boQh3eNJ
         d6bmYLvsQrX9JIQpA3AW1+lm87h9SaZuaE+D1vGei6bxzlcSW344F0fVdAijJujWKM
         70FNTQwRDe9Ht21ALtFj+EvB2Ve54RqfPGMm+7cjjPBfw4TG0j2FeZwHiW8dGLhTGR
         diZ5MgCwk/GXiI68lTcZDvwtFP+An4Nwb2bfKbFXY1Nf276fC/Xm6qbM3JZZLtK0p0
         etvMEXSQp/rzfPOWPtmBAblekxwXNM6YJx29T0zgvHv/98sFGnja9/N6eoIpb4vRBO
         GEZdsJLJ0WpNw==
Received: by mail-lf1-f71.google.com with SMTP id x27-20020ac2489b000000b004002367bdbbso1181325lfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 04:09:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LV8zs29Q6RtVe0ovS7PkdLCxTId0vPm+EpRZ40grHT8=;
        b=5ipuKqfxL4az793K8wk89lISU1w4aqpNjRfrdvn2FlxhBN7Q3YqLgeAJUr2v+Pg2on
         glPEOsb2SVe0mBUtC6Tt1PCeMcy8Pfhrl16g+/nWVFnv680nDDi+q0tqddP9M9MbJToY
         0s++8j6+rbkTbHD76l7/IgKKaFniaRxY+FTC2jwnqEz/Qb6Zo8BjqvZbrhlHtt0vcLB6
         7F0fcf5/FOyAoUu+zd+weLDE9H04h6+Uzs09JMv7y7oRtnPZvWFrdebPmmoGKwEnMC57
         xmbUqERVtMRnZr2YanZG7WruoHLUnrZhAnJJBmJ60Ttn0FFqVKEJOt7sKXzPQTVOq42q
         s0eQ==
X-Gm-Message-State: AOAM531laARFwSZOS3adDGCvuubDZr46dIHaYnSFSk0vjcsIl8Cf3vJF
        q7R0L3lmE19JbqDm5dGyO2cEChTjYfAlHd0SnSnn3719BORhbpdptEr+AKoLpt9dYA9DTN0CaSG
        4qfcFlLA1GoHkiHHFn2z1caXc7hvy28JygojXDQFLQQ==
X-Received: by 2002:a2e:1613:: with SMTP id w19mr25306073ljd.497.1635851395274;
        Tue, 02 Nov 2021 04:09:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJ0HmZ1dkezyX/zCwdDYgsh3fblrYuUykZMqFUiHD0Jz1RxUEVZ6U6g3H6ZXKdyhxk0Wt7Rw==
X-Received: by 2002:a2e:1613:: with SMTP id w19mr25306035ljd.497.1635851394931;
        Tue, 02 Nov 2021 04:09:54 -0700 (PDT)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id p3sm459928ljj.4.2021.11.02.04.09.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 04:09:54 -0700 (PDT)
Message-ID: <52054093-bd8d-ee79-6f32-9ada9b3deb24@canonical.com>
Date:   Tue, 2 Nov 2021 12:09:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [RFC PATCH] ARM: s3c: mark as deprecated and schedule removal
 after 2022
Content-Language: en-US
To:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        Kukjin Kim <kgene@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Inki Dae <inki.dae@samsung.com>, Cedric Roux <sed@free.fr>,
        Sam Van Den Berge <sam.van.den.berge@telenet.be>,
        Lihua Yao <ylhuajnu@outlook.com>,
        Heiko Stuebner <heiko@sntech.de>
References: <20211102110519.142434-1-krzysztof.kozlowski@canonical.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211102110519.142434-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2021 12:05, Krzysztof Kozlowski wrote:
> The Samsung S3C24xx and S3C64xx platforms are very old designs. S3C2416
> was introduced in 2008 and S3C6410 in 2009/2010.  They are not widely
> available anymore - out-of-stock on FriendlyArm (one of manufacturers of
> boards) and only few specialist stores still offer them for quite a high
> price.
> 
> The community around these platforms was not very active, so I suspect
> no one really uses them anymore. Maintenance takes precious time so
> there is little sense in keeping them alive if there are no real users.
> 
> Let's mark all S3C24xx and S3C64xx platforms as deprecated and mention
> possible removal in one year (after 2022).  The deprecation message will
> be as text in Kconfig, build message (not a warning though) and runtime
> print error.
> 
> If there are any users, they might respond and postpone the removal.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  arch/arm/Kconfig                  | 7 ++++++-
>  arch/arm/mach-s3c/Kconfig.s3c64xx | 7 ++++++-
>  arch/arm/mach-s3c/cpu.c           | 1 +
>  arch/arm/mach-s3c/init.c          | 2 ++
>  arch/arm/mach-s3c/s3c24xx.c       | 5 +++++
>  arch/arm/mach-s3c/s3c64xx.c       | 5 +++++
>  6 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index f0f9e8bec83a..bd8237c7e7f1 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -473,7 +473,7 @@ config ARCH_SA1100
>  	  Support for StrongARM 11x0 based boards.
>  
>  config ARCH_S3C24XX
> -	bool "Samsung S3C24XX SoCs"
> +	bool "Samsung S3C24XX SoCs (deprecated, see help)"
>  	select ATAGS
>  	select CLKSRC_SAMSUNG_PWM
>  	select GPIO_SAMSUNG
> @@ -491,6 +491,11 @@ config ARCH_S3C24XX
>  	  (<http://www.simtec.co.uk/products/EB110ITX/>), the IPAQ 1940 or the
>  	  Samsung SMDK2410 development board (and derivatives).
>  
> +	  The platform is deprecated and scheduled in removal. Please reach to

Language typo - "for removal". I'll fix it in v2, if the idea looks
reasonable.

Best regards,
Krzysztof
