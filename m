Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1545C31C129
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 19:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhBOSHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 13:07:50 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:51087 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhBOSHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 13:07:37 -0500
Received: by mail-wm1-f50.google.com with SMTP id a132so506161wmc.0;
        Mon, 15 Feb 2021 10:07:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Uq9ok5qeaOLSPTWCnZGzu5H9WnX3D/qNhhgRdr5WRpY=;
        b=MZGOZZEXtVPbssSDkcTVU9d90bw1gtuvmTLZxzUbdRnwC+2FUVLZ7ciJzaStDxe54G
         ki2j7T79tE/rH9J7nHNGV9AnAtJcfOwjd9ATYMUI4NB6ykeFMkma2hHMOMyEiq2HCYZ9
         YZ7sjZ56cIau1X1O9bpRnU3OKeGbTLsfzMXHNGW/C3bD56VHOOOI/SX7KfU6NBdGC/yy
         EPbeY7ZCkQWuS+Em7eRa6olThxb0qBb69/vRZFMG52Zzw1xDrpfTWiSg7wrrDAIWmaO/
         1lz7EXO7/OykdTXhj2HOZe4YMMSbhpNOhZ23gdYQqgs37xIeptYUzMrfY2z82Ha95iHF
         4L5w==
X-Gm-Message-State: AOAM531xRWbg31G7hip50MT/NRZ+mTpyA7SJOEvRNjZm5CW3vsLSorx/
        YeLuvngNxwGOD9ugsZCmZh0=
X-Google-Smtp-Source: ABdhPJxqLXrWVHWaQDbtqDJ1sogUJqeL92isd/Z4Sjj0G9Ucwa4zbxSzmbjXjOoxK5JwOxdwCnLZXw==
X-Received: by 2002:a7b:c305:: with SMTP id k5mr85993wmj.57.1613412415233;
        Mon, 15 Feb 2021 10:06:55 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id i10sm32418022wrp.0.2021.02.15.10.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 10:06:53 -0800 (PST)
Date:   Mon, 15 Feb 2021 19:06:52 +0100
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
Subject: Re: [PATCH v2 17/25] tty: serial: samsung_tty: Separate S3C64XX ops
 structure
Message-ID: <20210215180652.tbccd5dhsfjpdayp@kozik-lap>
References: <20210215121713.57687-1-marcan@marcan.st>
 <20210215121713.57687-18-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210215121713.57687-18-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 09:17:05PM +0900, Hector Martin wrote:
> Instead of patching a single global ops structure depending on the port
> type, use a separate s3c64xx_serial_ops for the S3C64XX type. This
> allows us to mark the structures as const.
> 
> Also split out s3c64xx_serial_shutdown into a separate function now that
> we have a separate ops structure; this avoids excessive branching
> control flow and mirrors s3c64xx_serial_startup. tx_claimed and
> rx_claimed are only used in the S3C24XX functions.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/tty/serial/samsung_tty.c | 69 ++++++++++++++++++++++++--------
>  1 file changed, 53 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index 8ae3e03fbd8c..6b661f3ec1ae 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -1098,27 +1098,36 @@ static void s3c24xx_serial_shutdown(struct uart_port *port)
>  	struct s3c24xx_uart_port *ourport = to_ourport(port);
>  
>  	if (ourport->tx_claimed) {
> -		if (!s3c24xx_serial_has_interrupt_mask(port))
> -			free_irq(ourport->tx_irq, ourport);
> +		free_irq(ourport->tx_irq, ourport);
>  		ourport->tx_enabled = 0;
>  		ourport->tx_claimed = 0;
>  		ourport->tx_mode = 0;
>  	}
>  
>  	if (ourport->rx_claimed) {
> -		if (!s3c24xx_serial_has_interrupt_mask(port))
> -			free_irq(ourport->rx_irq, ourport);
> +		free_irq(ourport->rx_irq, ourport);
>  		ourport->rx_claimed = 0;
>  		ourport->rx_enabled = 0;
>  	}
>  
> -	/* Clear pending interrupts and mask all interrupts */
> -	if (s3c24xx_serial_has_interrupt_mask(port)) {
> -		free_irq(port->irq, ourport);
> +	if (ourport->dma)
> +		s3c24xx_serial_release_dma(ourport);
>  
> -		wr_regl(port, S3C64XX_UINTP, 0xf);
> -		wr_regl(port, S3C64XX_UINTM, 0xf);
> -	}
> +	ourport->tx_in_progress = 0;
> +}
> +
> +static void s3c64xx_serial_shutdown(struct uart_port *port)
> +{
> +	struct s3c24xx_uart_port *ourport = to_ourport(port);
> +
> +	free_irq(port->irq, ourport);
> +
> +	wr_regl(port, S3C64XX_UINTP, 0xf);
> +	wr_regl(port, S3C64XX_UINTM, 0xf);
> +
> +	ourport->tx_enabled = 0;
> +	ourport->tx_mode = 0;
> +	ourport->rx_enabled = 0;

For S3C64xx type this is not equivalent: the assignments were
happening before free_irq() and wr_regl(). Honestly I don't know whether
it matters (except some barriers coming from these functions) but please
do not change the order of code in this patch. If needed, the
re-ordering should be a patch on its own. With explanation why.

>  
>  	if (ourport->dma)
>  		s3c24xx_serial_release_dma(ourport);
> @@ -1193,9 +1202,7 @@ static int s3c64xx_serial_startup(struct uart_port *port)
>  
>  	/* For compatibility with s3c24xx Soc's */
>  	ourport->rx_enabled = 1;
> -	ourport->rx_claimed = 1;
>  	ourport->tx_enabled = 0;
> -	ourport->tx_claimed = 1;
>  
>  	spin_lock_irqsave(&port->lock, flags);
>  
> @@ -1631,6 +1638,29 @@ static struct uart_ops s3c24xx_serial_ops = {
>  #endif
>  };
>  
> +static const struct uart_ops s3c64xx_serial_ops = {
> +	.pm		= s3c24xx_serial_pm,
> +	.tx_empty	= s3c24xx_serial_tx_empty,
> +	.get_mctrl	= s3c24xx_serial_get_mctrl,
> +	.set_mctrl	= s3c24xx_serial_set_mctrl,
> +	.stop_tx	= s3c24xx_serial_stop_tx,
> +	.start_tx	= s3c24xx_serial_start_tx,
> +	.stop_rx	= s3c24xx_serial_stop_rx,
> +	.break_ctl	= s3c24xx_serial_break_ctl,
> +	.startup	= s3c64xx_serial_startup,
> +	.shutdown	= s3c64xx_serial_shutdown,
> +	.set_termios	= s3c24xx_serial_set_termios,
> +	.type		= s3c24xx_serial_type,
> +	.release_port	= s3c24xx_serial_release_port,
> +	.request_port	= s3c24xx_serial_request_port,
> +	.config_port	= s3c24xx_serial_config_port,
> +	.verify_port	= s3c24xx_serial_verify_port,
> +#if defined(CONFIG_SERIAL_SAMSUNG_CONSOLE) && defined(CONFIG_CONSOLE_POLL)
> +	.poll_get_char = s3c24xx_serial_get_poll_char,
> +	.poll_put_char = s3c24xx_serial_put_poll_char,
> +#endif
> +};
> +

Make the s3c24xx_serial_ops const as well.

Best regards,
Krzysztof
