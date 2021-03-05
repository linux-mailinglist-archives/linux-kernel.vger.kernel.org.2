Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E11D32E68B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 11:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhCEKg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 05:36:26 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50195 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbhCEKgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 05:36:12 -0500
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lI7n5-0007ZH-CM
        for linux-kernel@vger.kernel.org; Fri, 05 Mar 2021 10:34:39 +0000
Received: by mail-wr1-f69.google.com with SMTP id g2so861761wrx.20
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 02:34:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RWwbwcqn7+V68bGLU4ZDn1q+MKGqnLhOEC9uAVuE8zc=;
        b=kDRcpHoMfbeFy3ixmH+5fCI8Y6TrgmZSdfcifctQwnxKb/pGRK5QiqRnUrVSQ4/FIm
         wOBFRuxJbSiLVgnAkvxXlOcG76/PTMMFe0uV6l/v8GmNZfum5yLvFKeM1q7ks20Db6jn
         lJECoehg1c894iorLWpyu2171iUniJ2GNJsR4VxmDKVveabIhG/a3TIMMh/MEk/TO7KH
         AYZ/nrhQzCoQrQhUyGIMhP94JHy8gZJY0Gx4ar1HWnll+sL/PQJcVXBs8uEzChatvYc8
         SF+RoF8FbGPYZp1IlEnO8i71ddm91DAxr+2ZqM74JIAmG6qYY1MYM2nJNywoYyg8A7GW
         Jrag==
X-Gm-Message-State: AOAM533m/HKKuJTEsZ/3omqjknNLF4dU071HCGnxIE6qa7ZX9FGjVCA2
        D5KieTiT1/A64DVEEkPo3gfYGJLHIa+1qCdARRV9RxF9L0IPu5QDFZsGXfVKjx2qZ18tqLDeMbM
        0hn8V2zraIpIg6VpK1bkNxdlkxU63cjV9leRYpJcJIA==
X-Received: by 2002:adf:fe01:: with SMTP id n1mr8647743wrr.341.1614940478802;
        Fri, 05 Mar 2021 02:34:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxL/xW+AO3OBrJBdGRjyMx7XXgn/DcEVAjw6nrX4rZjq/i98eqo/Tr07xkBjjsbwJ/68iC9lg==
X-Received: by 2002:adf:fe01:: with SMTP id n1mr8647714wrr.341.1614940478678;
        Fri, 05 Mar 2021 02:34:38 -0800 (PST)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id p6sm3759537wru.2.2021.03.05.02.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 02:34:38 -0800 (PST)
Subject: Re: [RFT PATCH v3 19/27] tty: serial: samsung_tty: Add ucon_mask
 parameter
To:     Hector Martin <marcan@marcan.st>,
        linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210304213902.83903-1-marcan@marcan.st>
 <20210304213902.83903-20-marcan@marcan.st>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <1e665346-15eb-3a9f-6dc3-7494a8050972@canonical.com>
Date:   Fri, 5 Mar 2021 11:34:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210304213902.83903-20-marcan@marcan.st>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2021 22:38, Hector Martin wrote:
> This simplifies the code by removing the only distinction between the
> S3C2410 and S3C2440 codepaths.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/tty/serial/samsung_tty.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index 78dc6e9240fb..33b421dbeb83 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -70,6 +70,7 @@ struct s3c24xx_uart_info {
>  	unsigned long		num_clks;
>  	unsigned long		clksel_mask;
>  	unsigned long		clksel_shift;
> +	unsigned long		ucon_mask;
>  
>  	/* uart port features */
>  
> @@ -1736,14 +1737,9 @@ static void s3c24xx_serial_resetport(struct uart_port *port,
>  {
>  	struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
>  	unsigned long ucon = rd_regl(port, S3C2410_UCON);
> -	unsigned int ucon_mask;
>  
> -	ucon_mask = info->clksel_mask;
> -	if (info->type == PORT_S3C2440)
> -		ucon_mask |= S3C2440_UCON0_DIVMASK;
> -
> -	ucon &= ucon_mask;
> -	wr_regl(port, S3C2410_UCON,  ucon | cfg->ucon);
> +	ucon &= (info->clksel_mask | info->ucon_mask);
> +	wr_regl(port, S3C2410_UCON, ucon | cfg->ucon);

This line (wr_regl()) is not related, please split it to separate
white-space cleanups.

With the change:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Tested-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
