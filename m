Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E124031C181
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 19:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhBOS1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 13:27:42 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:33709 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhBOS1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 13:27:37 -0500
Received: by mail-wr1-f46.google.com with SMTP id 7so10170279wrz.0;
        Mon, 15 Feb 2021 10:27:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gP2xDtB3lcxU0X3FyErwAwrTvvvz5qh3O7yckuSfJh8=;
        b=P+hYpzuX3eMvA8/nzF3zpMD37Dz0XD7CXs2gh8QUSyuiFbjdrpfsgdQudDxMpfs4Ou
         RLFSWt5zMRMQ7+7SuNQnz7Tz157yPvTfSY1CEcaZP0YPF7pwIjuGyRwHFesxOup88MIR
         i1q7RABIXolTleb4fLz4O0+xFsUJy221xCdk+zIRSPSyyPTCBBRPZxdfhaPhmcYN51fB
         c8LVufzbbIHaTQj+aZdMb5R+GdwNoTA2+3UrHMJylusRZ7Ynu4n/nSOLCFgLAZUajRWy
         CFX/huhOf4XssIiu0XOCuwv8wZbTtH+mm96kJB1CDDuuyPxkvOEuqI+KOGPvlWkbqB8x
         5Lzw==
X-Gm-Message-State: AOAM531nkimL0PAd/PxTGgH5Ov9ObzrTf5uBI66kwpx+m0QBw901VoeH
        jWIa0Lcr0B4CB1uUOsewi50=
X-Google-Smtp-Source: ABdhPJzGPxk3WgZQkTrsPDsc4z3IRJaKsPKYZ8PmYi1n1RpgogPpFnHx9f2zdSNKSKKCEVGzjOMYMA==
X-Received: by 2002:a5d:5603:: with SMTP id l3mr4018054wrv.381.1613413614702;
        Mon, 15 Feb 2021 10:26:54 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id k11sm24292745wrv.51.2021.02.15.10.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 10:26:53 -0800 (PST)
Date:   Mon, 15 Feb 2021 19:26:51 +0100
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
Subject: Re: [PATCH v2 18/25] tty: serial: samsung_tty: add s3c24xx_port_type
Message-ID: <20210215182651.rjte67udhk3vhbsk@kozik-lap>
References: <20210215121713.57687-1-marcan@marcan.st>
 <20210215121713.57687-19-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210215121713.57687-19-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 09:17:06PM +0900, Hector Martin wrote:
> This decouples the TTY layer PORT_ types, which are exposed to
> userspace, from the driver-internal flag of what kind of port this is.
> 
> This removes s3c24xx_serial_has_interrupt_mask, which was just checking
> for a specific type anyway, and adds the ucon_mask port info member to
> avoid having S3C2440 as a distinct type.

Please split setting the ucon_mask to separate patch. It's a nice
code simplification on its own.

> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/tty/serial/samsung_tty.c | 131 ++++++++++++++++++-------------
>  1 file changed, 77 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index 6b661f3ec1ae..21955be680a4 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -56,9 +56,15 @@
>  /* flag to ignore all characters coming in */
>  #define RXSTAT_DUMMY_READ (0x10000000)
>  
> +enum s3c24xx_port_type {
> +	TYPE_S3C24XX,
> +	TYPE_S3C6400,
> +};
> +
>  struct s3c24xx_uart_info {
>  	char			*name;
> -	unsigned int		type;
> +	enum s3c24xx_port_type	type;
> +	unsigned int		port_type;
>  	unsigned int		fifosize;
>  	unsigned long		rx_fifomask;
>  	unsigned long		rx_fifoshift;
> @@ -70,6 +76,7 @@ struct s3c24xx_uart_info {
>  	unsigned long		num_clks;
>  	unsigned long		clksel_mask;
>  	unsigned long		clksel_shift;
> +	unsigned long		ucon_mask;
>  
>  	/* uart port features */
>  
> @@ -228,16 +235,6 @@ static int s3c24xx_serial_txempty_nofifo(struct uart_port *port)
>  	return rd_regl(port, S3C2410_UTRSTAT) & S3C2410_UTRSTAT_TXE;
>  }
>  
> -/*
> - * s3c64xx and later SoC's include the interrupt mask and status registers in
> - * the controller itself, unlike the s3c24xx SoC's which have these registers
> - * in the interrupt controller. Check if the port type is s3c64xx or higher.
> - */
> -static int s3c24xx_serial_has_interrupt_mask(struct uart_port *port)
> -{
> -	return to_ourport(port)->info->type == PORT_S3C6400;
> -}
> -
>  static void s3c24xx_serial_rx_enable(struct uart_port *port)
>  {
>  	struct s3c24xx_uart_port *ourport = to_ourport(port);
> @@ -289,10 +286,14 @@ static void s3c24xx_serial_stop_tx(struct uart_port *port)
>  	if (!ourport->tx_enabled)
>  		return;
>  
> -	if (s3c24xx_serial_has_interrupt_mask(port))
> +	switch (ourport->info->type) {
> +	case TYPE_S3C6400:
>  		s3c24xx_set_bit(port, S3C64XX_UINTM_TXD, S3C64XX_UINTM);
> -	else
> +		break;
> +	default:
>  		disable_irq_nosync(ourport->tx_irq);
> +		break;
> +	}
>  
>  	if (dma && dma->tx_chan && ourport->tx_in_progress == S3C24XX_TX_DMA) {
>  		dmaengine_pause(dma->tx_chan);
> @@ -353,10 +354,14 @@ static void enable_tx_dma(struct s3c24xx_uart_port *ourport)
>  	u32 ucon;
>  
>  	/* Mask Tx interrupt */
> -	if (s3c24xx_serial_has_interrupt_mask(port))
> +	switch (ourport->info->type) {
> +	case TYPE_S3C6400:
>  		s3c24xx_set_bit(port, S3C64XX_UINTM_TXD, S3C64XX_UINTM);
> -	else
> +		break;
> +	default:
>  		disable_irq_nosync(ourport->tx_irq);
> +		break;
> +	}
>  
>  	/* Enable tx dma mode */
>  	ucon = rd_regl(port, S3C2410_UCON);
> @@ -386,11 +391,14 @@ static void enable_tx_pio(struct s3c24xx_uart_port *ourport)
>  	wr_regl(port,  S3C2410_UCON, ucon);
>  
>  	/* Unmask Tx interrupt */
> -	if (s3c24xx_serial_has_interrupt_mask(port))
> -		s3c24xx_clear_bit(port, S3C64XX_UINTM_TXD,
> -				  S3C64XX_UINTM);
> -	else
> +	switch (ourport->info->type) {
> +	case TYPE_S3C6400:
> +		s3c24xx_clear_bit(port, S3C64XX_UINTM_TXD, S3C64XX_UINTM);

Please do not re-wrap. It makes reviewing more difficult. You can
perform proper re-wrapping as a separate cleanup patch.

> +		break;
> +	default:
>  		enable_irq(ourport->tx_irq);
> +		break;
> +	}
>  
>  	ourport->tx_mode = S3C24XX_TX_PIO;
>  }
> @@ -513,11 +521,14 @@ static void s3c24xx_serial_stop_rx(struct uart_port *port)
>  
>  	if (ourport->rx_enabled) {
>  		dev_dbg(port->dev, "stopping rx\n");
> -		if (s3c24xx_serial_has_interrupt_mask(port))
> -			s3c24xx_set_bit(port, S3C64XX_UINTM_RXD,
> -					S3C64XX_UINTM);

The same.

Best regards,
Krzysztof
