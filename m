Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B363F40C081
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 09:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236634AbhIOH3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 03:29:37 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:50440
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236601AbhIOH3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 03:29:33 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3542C4017C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 07:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631690894;
        bh=ppU//N0NUX+HEww/poMBVGUJs7BZs8SJh0ZQtOCNRAM=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=P/pdI/zCcXR2Y8OuTdF4T+Cw1HDD4dQSsvWiwDVex+g9hKuYT6XXh/cl5gnzfEq+3
         BcDUloM19tvVPRV8J2SXKGoobkJJDfQ3/nzDZMwNpmrOEcEAVBbzd6NdawWHVN2Y65
         lZ7PoKlDqbNW1YHxX5FprHEjTFEkr5uxgBCsJlRkVjoCPoy5y4JwPZqmWJFWNIHA8a
         GL+Vv9ymWRAOfZ46q6Z/E4gJdP/fEP0fYeS+WMe0FyLDETwJDdwJRYpZtTiEVaPwt9
         7NeNPWWFMRYWBhpnoMq9HfZAJOGWOIQweTp+Sf6Gq0Fma9ZOQkV8DrgCgVgrHXMD0u
         S4TOXRiYzbPGA==
Received: by mail-ed1-f72.google.com with SMTP id v13-20020a056402174d00b003c25d6b2f13so1076429edx.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 00:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ppU//N0NUX+HEww/poMBVGUJs7BZs8SJh0ZQtOCNRAM=;
        b=kWQxpQzS+5Sch9/cNG2OKofZbnFPHKYtL56rWSRP5hMQEuTW93iuOfwR1JdVJEq+IL
         sVKt85M8hvDrhPF39nteilhmSxucpcIFsF8RICzyYKz/VkfFvd/HGqGQ9qxunkKdZ5dc
         FnChqVuYStbvOxPhmd43sWfTZNqKZI5nUSnroB4EGYz6LYZpq+DhcpFezBOM+Ld5Ci/E
         ONX4X16DR62AKO25rvtaU4dWD3ZauY2KzzOSXUeo3JqJMNp29R2GLU2FCEYg0NLGDXnv
         qoSBy5i3zi+l1sf/inmo6b6jvM9+ipyr1QLuTjf4LQupNPm0e+kxxxkmSrpIBDX07jCC
         b5xA==
X-Gm-Message-State: AOAM5305v0mPezpnLOGXSJyyoY7nP89wPD+r2ZPFcSpcZPdT2/e3C/5n
        UKLLjWbi/CDU5em1VaewEbIuhh0TaOKpDUZEVp7qmBzFwWpmiSe1FYR3Co9P+C8bFcKj4BRABcJ
        +LHyzHB7P6DcTwAqwpXL/TXinm/Yxk4tfwEH4FyN7dA==
X-Received: by 2002:a17:906:2346:: with SMTP id m6mr23498755eja.512.1631690893433;
        Wed, 15 Sep 2021 00:28:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyN/EjBqzUCq1sM72TJYj/g0y3W59czzE+ItSwaFOFp4dbIj+7l0b+VUUuJ4BIofa079Yw9kQ==
X-Received: by 2002:a17:906:2346:: with SMTP id m6mr23498743eja.512.1631690893233;
        Wed, 15 Sep 2021 00:28:13 -0700 (PDT)
Received: from [192.168.3.211] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id b38sm1487559edf.46.2021.09.15.00.28.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 00:28:12 -0700 (PDT)
Subject: Re: [PATCH] tty: serial: samsung: Improve naming for common macro
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210914142315.26596-1-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <6efec37b-4392-dffe-1bda-d4f7aac6643f@canonical.com>
Date:   Wed, 15 Sep 2021 09:28:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210914142315.26596-1-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2021 16:23, Sam Protsenko wrote:
> Having "_USI" suffix in EXYNOS_COMMON_SERIAL_DRV_DATA_USI() macro is
> confusing. Rename it to just EXYNOS_COMMON_SERIAL_DRV_DATA() and provide
> USI registers availability for all Exynos variants instead.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  drivers/tty/serial/samsung_tty.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)>
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index e2f49863e9c2..542b7e2b99dc 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -2780,7 +2780,7 @@ static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
>  #endif
>  
>  #if defined(CONFIG_ARCH_EXYNOS)
> -#define EXYNOS_COMMON_SERIAL_DRV_DATA_USI(_has_usi)		\
> +#define EXYNOS_COMMON_SERIAL_DRV_DATA(_has_usi)			\
>  	.info = &(struct s3c24xx_uart_info) {			\
>  		.name		= "Samsung Exynos UART",	\
>  		.type		= TYPE_S3C6400,			\
> @@ -2804,21 +2804,18 @@ static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
>  		.has_fracval	= 1,				\
>  	}							\
>  
> -#define EXYNOS_COMMON_SERIAL_DRV_DATA				\
> -	EXYNOS_COMMON_SERIAL_DRV_DATA_USI(0)
> -
>  static struct s3c24xx_serial_drv_data exynos4210_serial_drv_data = {
> -	EXYNOS_COMMON_SERIAL_DRV_DATA,
> +	EXYNOS_COMMON_SERIAL_DRV_DATA(0),
>  	.fifosize = { 256, 64, 16, 16 },
>  };
>  
>  static struct s3c24xx_serial_drv_data exynos5433_serial_drv_data = {
> -	EXYNOS_COMMON_SERIAL_DRV_DATA,
> +	EXYNOS_COMMON_SERIAL_DRV_DATA(0),
>  	.fifosize = { 64, 256, 16, 256 },
>  };
>  
>  static struct s3c24xx_serial_drv_data exynos850_serial_drv_data = {
> -	EXYNOS_COMMON_SERIAL_DRV_DATA_USI(1),

Makes sense, although I would prefer to have here true or false. More
obvious. Otherwise "1" looks like counter/number for some property.

The has_usi field in struct could be then also converted to bool.


Best regards,
Krzysztof
