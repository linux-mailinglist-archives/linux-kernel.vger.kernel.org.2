Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129A63E4422
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 12:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbhHIKrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 06:47:02 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:40594
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234754AbhHIKq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 06:46:27 -0400
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 367AB3F102
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 10:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628505964;
        bh=pwc/Ajo5YOokojxDuHXAQR0/29n7VNaZg9Jjhi/i3UA=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=Cuv+YxvtKcb02BiitN7JIOyz6yLPvQAIU8ueb59MSkhta3yJtEEru2NTIqBukhosT
         pkq7K0P4ow5gB67KdpZ6znSwshYTvOr1wHUWEm65BB33gBExCBchbSgYzGaczBuQF7
         OBSc8JVr+kgoVKlsZPPo2V9epf/tyzD2xCqGSUNyT7zQU1T39X9bekMjYLSu5+Qq3m
         M9PMGQmgf2pOqAHzxG0WTqk9qZutZyd3kxBgRVK42AusFXSqOljaT6nlLv8bnt+zkc
         f3U7SYJLMYT8E9zmj3e6+46Ue2DVavlu7JJDUbMfiHsPt70Ob4xoPHbK/k/mhDyw2J
         ETI36ydyy/pCg==
Received: by mail-lf1-f72.google.com with SMTP id s1-20020a0565122141b02903bf02f21443so5033761lfr.17
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 03:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pwc/Ajo5YOokojxDuHXAQR0/29n7VNaZg9Jjhi/i3UA=;
        b=DLOmcCmm0Sgef5QEgmnwKnc5rHxeM8zjvyxHZbXsE7aWxlTxK9NvgiPnMMsGxGAR3C
         q68Ikh9Dh5VVprHiCv6VLwO6XwaBcr3M3Qa9M60Mqf5+RZQAKvnhlK6ke8TJ0NpvenYY
         HlD5PdWPHjemWpkWZXr52Gg3Vppwh/5vie/gAUSffGXT0DENOI/kgzoRNPYklupT/URn
         NDRCYUgt9wsPQnoHMS4/iFov2CGi78ofcd3jJlJvXtQ+f0w0DeC3V6k+jDqDwmNbH/1U
         HFeKeTQGMkD5K8m8SWXRtN+AkjPj1wIAELETZ5WRSsuNrDaq65g15dLkSTCMsUWPP1e+
         0HdA==
X-Gm-Message-State: AOAM531ZGw9RPVAnzmZxLOEInZ24TkqYxWKuKow+Yef+2kRafHiC/tBt
        Z3LCWoqIJv70+7VCO42hwmdgfvH/Uwv7pZkhYsn7ih8lQhs//PWFCHUs+sm8a1DbQeDDEkTdpFa
        YDkv1FI/Kf9vSw3VBYMe9ytns2lFIkK1WBZG59fjrBw==
X-Received: by 2002:aa7:c5c4:: with SMTP id h4mr5179333eds.108.1628505953505;
        Mon, 09 Aug 2021 03:45:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFSBcXzH8i0TbMJa2dVdWnWI4e22vKyQF/gVsYMDX7OTcWMN3P9vHHAxa6pmNrrW6QiFGZ8w==
X-Received: by 2002:aa7:c5c4:: with SMTP id h4mr5179300eds.108.1628505953372;
        Mon, 09 Aug 2021 03:45:53 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id m25sm2212168edv.81.2021.08.09.03.45.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 03:45:53 -0700 (PDT)
Subject: Re: [PATCH v2 4/8] tty: serial: samsung: Init USI to keep clocks
 running
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        =?UTF-8?Q?Pawe=c5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
        Ryu Euiyoul <ryu.real@samsung.com>,
        Tom Gall <tom.gall@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20210806152146.16107-1-semen.protsenko@linaro.org>
 <20210806152146.16107-5-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <85df3188-0227-f926-61bf-30db1a5ef41d@canonical.com>
Date:   Mon, 9 Aug 2021 12:45:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210806152146.16107-5-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2021 17:21, Sam Protsenko wrote:
> UART block is a part of USI (Universal Serial Interface) IP-core in
> Samsung SoCs since Exynos9810 (e.g. in Exynos850). USI allows one to
> enable one of three types of serial interface: UART, SPI or I2C. That's
> possible because USI shares almost all internal circuits within each
> protocol. USI also provides some additional registers so it's possible
> to configure it.
> 
> One USI register called USI_OPTION has reset value of 0x0. Because of
> this the clock gating behavior is controlled by hardware (HWACG =
> Hardware Auto Clock Gating), which simply means the serial won't work
> after reset as is. In order to make it work, USI_OPTION[2:1] bits must
> be set to 0b01, so that HWACG is controlled manually (by software).
> Bits meaning:
>   - CLKREQ_ON = 1: clock is continuously provided to IP
>   - CLKSTOP_ON = 0: drive IP_CLKREQ to High (needs to be set along with
>                     CLKREQ_ON = 1)
> 
> USI is not present on older chips, like s3c2410, s3c2412, s3c2440,
> s3c6400, s5pv210, exynos5433, exynos4210. So the new boolean field
> '.has_usi' was added to struct s3c24xx_uart_info. USI registers will be
> only actually accessed when '.has_usi' field is set to "1".
> 
> This feature is needed for further serial enablement on Exynos850, but
> some other new Exynos chips (like Exynos9810) may benefit from this
> feature as well.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
> Changes in v2:
>   - Non-intrusive modification of USI registers
>   - Improved comments
>   - Rearranged USI register definitions to conform with existing style
> 
>  drivers/tty/serial/samsung_tty.c | 32 +++++++++++++++++++++++++++++++-
>  include/linux/serial_s3c.h       |  9 +++++++++
>  2 files changed, 40 insertions(+), 1 deletion(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>



Best regards,
Krzysztof
