Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B431831C1E1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 19:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhBOSqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 13:46:53 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:36955 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhBOSk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 13:40:57 -0500
Received: by mail-wr1-f46.google.com with SMTP id v15so10159521wrx.4;
        Mon, 15 Feb 2021 10:40:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ndRKNNc8/xGtpRkqHnsCIvQWf569YNGGMO1MNEH3zpI=;
        b=XFIx6rqcFA84NUJmp3JvE5BvjVNK8f0Uo7OZ7H/Lxau37HuMkLcdDFhoEmKAXSh3pf
         v5IFqRc+o8J5AdbtZvi7/rBxBLgoqgs5W6ltB1wo7sbi2FCksESy6Lp0LKpSOhq0N0fM
         XpQCSE0S1HqYQL20uCZaqho0mTWsxDBJiYaULHQFycmNVtyvPOa2FASDTRGcK5ild9aS
         IZVgtQUGkFF2k7ibdVuJMvb7//FeNDDN9M9RtCBQsLAjsV2Nbb9iYkqJ9d95ZIgKf72p
         mbB5Dufjf6i5+Oyk8cOYq6h3CDOEoT57AWcowVwvkCDVmeDro2USNMpOzuUNmvB8LGkr
         yCFw==
X-Gm-Message-State: AOAM5339I/LdOoOVb+rXokCGx4SHSf7qcmw/+WjMRkOC9sLLuEt3YvyU
        +QPcw04RPTBi1YB3ccpyJwY=
X-Google-Smtp-Source: ABdhPJyVcBQ0bLHE/Ww5ODhUu055JCyMWzRGPGh5VzxkxdbACBpfAYOFZTNu53lo6BDz8n0NbJD8Zg==
X-Received: by 2002:adf:8084:: with SMTP id 4mr18715152wrl.49.1613414414946;
        Mon, 15 Feb 2021 10:40:14 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id s5sm191052wmh.45.2021.02.15.10.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 10:40:13 -0800 (PST)
Date:   Mon, 15 Feb 2021 19:40:12 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
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
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 19/25] tty: serial: samsung_tty: IRQ rework
Message-ID: <20210215184012.sf6p6dbk5c25phdm@kozik-lap>
References: <20210215121713.57687-1-marcan@marcan.st>
 <20210215121713.57687-20-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210215121713.57687-20-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 09:17:07PM +0900, Hector Martin wrote:
> * Split out s3c24xx_serial_tx_chars from s3c24xx_serial_tx_irq,
>   where only the latter acquires the port lock.

I miss here information why you do all this.

> 
> * For S3C64xx, return IRQ_NONE if no flag bits were set, so the
>   interrupt core can detect IRQ storms. Note that both IRQ handlers
>   always return IRQ_HANDLED anyway, so 'or' logic isn't necessary here,
>   if either handler ran we are always going to return IRQ_HANDLED.

It looks like separate patch. Your patches should do only one thing at
once. The fact that you have here three bullet points is a warning
sign. This is even more important if you do some refactorings and
cleanups which should not affect functionality. Hiding there changes
which could affect functionality is a no-go.

> 
> * Rename s3c24xx_serial_rx_chars to s3c24xx_serial_rx_irq for
>   consistency with the above. All it does now is call two other
>   functions anyway.

Separate patch for trivial renaming.

> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/tty/serial/samsung_tty.c | 41 +++++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index 21955be680a4..821cd0e4f870 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -151,6 +151,9 @@ struct s3c24xx_uart_port {
>  #endif
>  };
>  
> +static void s3c24xx_serial_start_next_tx(struct s3c24xx_uart_port *ourport);
> +static void s3c24xx_serial_tx_chars(struct s3c24xx_uart_port *ourport);
> +
>  /* conversion functions */
>  
>  #define s3c24xx_dev_to_port(__dev) dev_get_drvdata(__dev)
> @@ -316,8 +319,6 @@ static void s3c24xx_serial_stop_tx(struct uart_port *port)
>  	ourport->tx_mode = 0;
>  }
>  
> -static void s3c24xx_serial_start_next_tx(struct s3c24xx_uart_port *ourport);
> -

Why moving this? Why adding s3c24xx_serial_tx_chars() forward
declaration?

Best regards,
Krzysztof
