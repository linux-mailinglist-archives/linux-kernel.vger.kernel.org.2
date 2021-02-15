Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5A631C259
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 20:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhBOTSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 14:18:41 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:43982 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhBOTSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 14:18:33 -0500
Received: by mail-wr1-f51.google.com with SMTP id n8so10253896wrm.10;
        Mon, 15 Feb 2021 11:18:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RnUuiLgVFPTZZUMQRfYlfI3qlm9oP70j4KEJYtmavWc=;
        b=DeljH/i39giX+n3lOiBe8+FO3RfMr4H9VIa8ruRmDYYE+FM8MHi/KrRJTqC8edT506
         9TxB5bAGN7CqHHE5Z3o44kiDJDPnK+PX6dySW+tSzzUv9mWpLRfy13wKvxZhS7LtnxTa
         nb2YkBWcOIQRMinQtcgzk1wgnwcz7lnTVoNjImcHRweFLv+mbV/wO9fH19vSRJBwGDd+
         WmFtoFP5HiK4Wrx5ucLtdce/Wmuild9BfRPAuMljKipQWFwTpzEajtyzna3b6E00ydkz
         OVmRMf6Q5ThYEgRWIFYIbK0q9L1Jy3bqLE15mjQZPj8b810z40Sp9dwNTVaaLzzxhnkZ
         C3dA==
X-Gm-Message-State: AOAM533YcGRqd+RbuqV5xzTUkyeE9QbrVprTR2XxKZ8bCmb6/11GDPgN
        ccUSdUvbAH6WwihOgO+hol8=
X-Google-Smtp-Source: ABdhPJzfhGTniQs4SY6DZRV5BSwoQM07GAafV6qca9gl95yAcrEK36EThwQNbBoVq+JPYTJA1X9Vcg==
X-Received: by 2002:a5d:6b42:: with SMTP id x2mr19619128wrw.117.1613416671312;
        Mon, 15 Feb 2021 11:17:51 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id d15sm20505885wru.80.2021.02.15.11.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 11:17:50 -0800 (PST)
Date:   Mon, 15 Feb 2021 20:17:48 +0100
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
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 23/25] tty: serial: samsung_tty: Add earlycon support
 for Apple UARTs
Message-ID: <20210215191748.uhus2e6gclkwgjo5@kozik-lap>
References: <20210215121713.57687-1-marcan@marcan.st>
 <20210215121713.57687-24-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210215121713.57687-24-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 09:17:11PM +0900, Hector Martin wrote:
> Earlycon support is identical to S3C2410, but Apple SoCs also need
> MMIO mapped as nGnRnE. This is handled generically for normal drivers
> including the normal UART path here, but earlycon uses fixmap and
> runs before that scaffolding is ready.
> 
> Since this is the only case where we need this fix, it makes more
> sense to do it here in the UART driver instead of introducing a
> whole fdt nonposted-mmio resolver just for earlycon/fixmap.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/tty/serial/samsung_tty.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index e7ab0b9d89a7..00262f0e704b 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -2988,6 +2988,23 @@ OF_EARLYCON_DECLARE(s5pv210, "samsung,s5pv210-uart",
>  			s5pv210_early_console_setup);
>  OF_EARLYCON_DECLARE(exynos4210, "samsung,exynos4210-uart",
>  			s5pv210_early_console_setup);
> +
> +/* Apple S5L */
> +static int __init apple_s5l_early_console_setup(struct earlycon_device *device,
> +						const char *opt)
> +{
> +	/* Close enough to S3C2410 for earlycon... */
> +	device->port.private_data = &s3c2410_early_console_data;
> +
> +#ifdef CONFIG_ARM64

if IS_ENABLED()
(unless it cannot be used due to missing symbol?)

> +	/* ... but we need to override the existing fixmap entry as nGnRnE */
> +	__set_fixmap(FIX_EARLYCON_MEM_BASE, device->port.mapbase,
> +		     __pgprot(PROT_DEVICE_nGnRnE));
> +#endif
> +	return samsung_early_console_setup(device, opt);

Don't you need to handle the error code - set PROT_DEFAULT() or whatever
was there before?

Best regards,
Krzysztof
