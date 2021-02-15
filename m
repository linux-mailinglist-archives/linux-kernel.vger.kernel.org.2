Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73B831C24C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 20:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhBOTOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 14:14:12 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:46839 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhBOTNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 14:13:54 -0500
Received: by mail-wr1-f45.google.com with SMTP id t15so10210212wrx.13;
        Mon, 15 Feb 2021 11:13:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VG8YDwejqnY2BEVQOItbi7W34az9Snn1ccP4m1gB/ic=;
        b=qoOEHsPBiyKGtJnBt8OF7lCrOgS/3woVv8f5KGwdcCdFX4E4xdRe78BSeNImLaF/nb
         jkV18Cdbgj69O9iexqO1uCtbStUK4dzRwYOHZUXvBuykGiK6zm+y3A73Oq7M9KjJM9N/
         Imph2ccZxTQiInSWQH0QgYEyrE70u9H8tA+kk50lzYjz6AQ+mvirp1zIpUx+lgknRpz+
         xhGRPCHISWp+MBntDXM1/NCqa/JiNlLzANFc0ACoLTssbPG+T4mQBz3wc+wZjZEQHj6D
         6QZt3ex29/dokqcyLkq7d7Mog2bD4b8k4aNY1iVlKr5weqAgCKyqYgWy6yja+h5yNEyO
         Hhtw==
X-Gm-Message-State: AOAM532tN7OPErqrVBDeiU/UD9VxkfgjvXi5JPfMN8MF3r/bwnS3BlzF
        wzXZRGqqHaLecXdEwT78sHg=
X-Google-Smtp-Source: ABdhPJw93w93MxRX3Lxi6iNTqmcvwTCbhJaepjxbqUqsWBSf2dF8uFpUsglpTf/niG4SBsKb6wxZ7g==
X-Received: by 2002:a05:6000:2cf:: with SMTP id o15mr19482991wry.184.1613416391500;
        Mon, 15 Feb 2021 11:13:11 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id p9sm386457wmc.1.2021.02.15.11.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 11:13:10 -0800 (PST)
Date:   Mon, 15 Feb 2021 20:13:09 +0100
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
Subject: Re: [PATCH v2 22/25] tty: serial: samsung_tty: Add support for Apple
 UARTs
Message-ID: <20210215191309.k7qkak73usqj7jxp@kozik-lap>
References: <20210215121713.57687-1-marcan@marcan.st>
 <20210215121713.57687-23-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210215121713.57687-23-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 09:17:10PM +0900, Hector Martin wrote:
> Apple SoCs are a distant descendant of Samsung designs and use yet
> another variant of their UART style, with different interrupt handling.
> 
> In particular, this variant has the following differences with existing
> ones:
> 
> * It includes a built-in interrupt controller with different registers,
>   using only a single platform IRQ
> 
> * Internal interrupt sources are treated as edge-triggered, even though
>   the IRQ output is level-triggered. This chiefly affects the TX IRQ
>   path: the driver can no longer rely on the TX buffer empty IRQ
>   immediately firing after TX is enabled, but instead must prime the
>   FIFO with data directly.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/tty/serial/Kconfig       |   2 +-
>  drivers/tty/serial/samsung_tty.c | 228 +++++++++++++++++++++++++++++--
>  include/linux/serial_s3c.h       |  16 +++
>  3 files changed, 236 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 34a2899e69c0..9bfe4ec1e761 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -236,7 +236,7 @@ config SERIAL_CLPS711X_CONSOLE
>  
>  config SERIAL_SAMSUNG
>  	tristate "Samsung SoC serial support"
> -	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
> +	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || ARCH_APPLE || COMPILE_TEST
>  	select SERIAL_CORE
>  	help
>  	  Support for the on-chip UARTs on the Samsung S3C24XX series CPUs,
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index 619bc4864e2a..e7ab0b9d89a7 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -59,6 +59,7 @@
>  enum s3c24xx_port_type {
>  	TYPE_S3C24XX,
>  	TYPE_S3C6400,
> +	TYPE_APPLE_S5L,
>  };
>  
>  struct s3c24xx_uart_info {
> @@ -290,6 +291,9 @@ static void s3c24xx_serial_stop_tx(struct uart_port *port)
>  		return;
>  
>  	switch (ourport->info->type) {
> +	case TYPE_APPLE_S5L:
> +		s3c24xx_clear_bit(port, APPLE_S5L_UCON_TXTHRESH_ENA, S3C2410_UCON);
> +		break;
>  	case TYPE_S3C6400:
>  		s3c24xx_set_bit(port, S3C64XX_UINTM_TXD, S3C64XX_UINTM);
>  		break;
> @@ -356,6 +360,9 @@ static void enable_tx_dma(struct s3c24xx_uart_port *ourport)
>  
>  	/* Mask Tx interrupt */
>  	switch (ourport->info->type) {
> +	case TYPE_APPLE_S5L:
> +		WARN_ON(1); // No DMA
> +		break;
>  	case TYPE_S3C6400:
>  		s3c24xx_set_bit(port, S3C64XX_UINTM_TXD, S3C64XX_UINTM);
>  		break;
> @@ -389,10 +396,12 @@ static void enable_tx_pio(struct s3c24xx_uart_port *ourport)
>  	ucon = rd_regl(port, S3C2410_UCON);
>  	ucon &= ~(S3C64XX_UCON_TXMODE_MASK);
>  	ucon |= S3C64XX_UCON_TXMODE_CPU;
> -	wr_regl(port,  S3C2410_UCON, ucon);
>  
>  	/* Unmask Tx interrupt */
>  	switch (ourport->info->type) {
> +	case TYPE_APPLE_S5L:
> +		ucon |= APPLE_S5L_UCON_TXTHRESH_ENA_MSK;
> +		break;
>  	case TYPE_S3C6400:
>  		s3c24xx_clear_bit(port, S3C64XX_UINTM_TXD, S3C64XX_UINTM);
>  		break;
> @@ -401,7 +410,16 @@ static void enable_tx_pio(struct s3c24xx_uart_port *ourport)
>  		break;
>  	}
>  
> +	wr_regl(port,  S3C2410_UCON, ucon);

You are now configuring the PIO mode after unmasking interrupt. I don't
think it's a good idea to change the order... and if it were, it
would deserve a separate patch.

> +
>  	ourport->tx_mode = S3C24XX_TX_PIO;
> +
> +	/*
> +	 * The Apple version only has edge triggered TX IRQs, so we need
> +	 * to kick off the process by sending some characters here.
> +	 */
> +	if (ourport->info->type == TYPE_APPLE_S5L)
> +		s3c24xx_serial_tx_chars(ourport);
>  }
>  
>  static void s3c24xx_serial_start_tx_pio(struct s3c24xx_uart_port *ourport)
> @@ -523,6 +541,10 @@ static void s3c24xx_serial_stop_rx(struct uart_port *port)
>  	if (ourport->rx_enabled) {
>  		dev_dbg(port->dev, "stopping rx\n");
>  		switch (ourport->info->type) {
> +		case TYPE_APPLE_S5L:
> +			s3c24xx_clear_bit(port, APPLE_S5L_UCON_RXTHRESH_ENA, S3C2410_UCON);
> +			s3c24xx_clear_bit(port, APPLE_S5L_UCON_RXTO_ENA, S3C2410_UCON);
> +			break;
>  		case TYPE_S3C6400:
>  			s3c24xx_set_bit(port, S3C64XX_UINTM_RXD, S3C64XX_UINTM);
>  			break;
> @@ -663,14 +685,18 @@ static void enable_rx_pio(struct s3c24xx_uart_port *ourport)
>  
>  	/* set Rx mode to DMA mode */
>  	ucon = rd_regl(port, S3C2410_UCON);
> -	ucon &= ~(S3C64XX_UCON_TIMEOUT_MASK |
> -			S3C64XX_UCON_EMPTYINT_EN |
> -			S3C64XX_UCON_DMASUS_EN |
> -			S3C64XX_UCON_TIMEOUT_EN |
> -			S3C64XX_UCON_RXMODE_MASK);
> -	ucon |= 0xf << S3C64XX_UCON_TIMEOUT_SHIFT |
> -			S3C64XX_UCON_TIMEOUT_EN |
> -			S3C64XX_UCON_RXMODE_CPU;
> +	ucon &= ~S3C64XX_UCON_RXMODE_MASK;
> +	ucon |= S3C64XX_UCON_RXMODE_CPU;
> +
> +	/* Apple types use these bits for IRQ masks */
> +	if (ourport->info->type != TYPE_APPLE_S5L) {
> +		ucon &= ~(S3C64XX_UCON_TIMEOUT_MASK |
> +				S3C64XX_UCON_EMPTYINT_EN |
> +				S3C64XX_UCON_DMASUS_EN |
> +				S3C64XX_UCON_TIMEOUT_EN);
> +		ucon |= 0xf << S3C64XX_UCON_TIMEOUT_SHIFT |
> +				S3C64XX_UCON_TIMEOUT_EN;
> +	}
>  	wr_regl(port, S3C2410_UCON, ucon);
>  
>  	ourport->rx_mode = S3C24XX_RX_PIO;
> @@ -934,6 +960,27 @@ static irqreturn_t s3c64xx_serial_handle_irq(int irq, void *id)
>  	return ret;
>  }
>  
> +/* interrupt handler for Apple SoC's.*/
> +static irqreturn_t apple_serial_handle_irq(int irq, void *id)
> +{
> +	struct s3c24xx_uart_port *ourport = id;
> +	struct uart_port *port = &ourport->port;
> +	unsigned int pend = rd_regl(port, S3C2410_UTRSTAT);
> +	irqreturn_t ret = IRQ_NONE;
> +
> +	if (pend & (APPLE_S5L_UTRSTAT_RXTHRESH | APPLE_S5L_UTRSTAT_RXTO)) {
> +		wr_regl(port, S3C2410_UTRSTAT,
> +			APPLE_S5L_UTRSTAT_RXTHRESH | APPLE_S5L_UTRSTAT_RXTO);
> +		ret = s3c24xx_serial_rx_irq(irq, id);
> +	}
> +	if (pend & APPLE_S5L_UTRSTAT_TXTHRESH) {
> +		wr_regl(port, S3C2410_UTRSTAT, APPLE_S5L_UTRSTAT_TXTHRESH);
> +		ret = s3c24xx_serial_tx_irq(irq, id);
> +	}
> +
> +	return ret;
> +}
> +
>  static unsigned int s3c24xx_serial_tx_empty(struct uart_port *port)
>  {
>  	struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
> @@ -1153,6 +1200,32 @@ static void s3c64xx_serial_shutdown(struct uart_port *port)
>  	ourport->tx_in_progress = 0;
>  }
>  
> +static void apple_s5l_serial_shutdown(struct uart_port *port)
> +{
> +	struct s3c24xx_uart_port *ourport = to_ourport(port);
> +
> +	unsigned int ucon;
> +
> +	ucon = rd_regl(port, S3C2410_UCON);
> +	ucon &= ~(APPLE_S5L_UCON_TXTHRESH_ENA_MSK |
> +		  APPLE_S5L_UCON_RXTHRESH_ENA_MSK |
> +		  APPLE_S5L_UCON_RXTO_ENA_MSK);
> +	wr_regl(port, S3C2410_UCON, ucon);
> +
> +	wr_regl(port, S3C2410_UTRSTAT, APPLE_S5L_UTRSTAT_ALL_FLAGS);
> +
> +	free_irq(port->irq, ourport);
> +
> +	ourport->tx_enabled = 0;
> +	ourport->tx_mode = 0;
> +	ourport->rx_enabled = 0;
> +
> +	if (ourport->dma)
> +		s3c24xx_serial_release_dma(ourport);
> +
> +	ourport->tx_in_progress = 0;
> +}
> +
>  static int s3c24xx_serial_startup(struct uart_port *port)
>  {
>  	struct s3c24xx_uart_port *ourport = to_ourport(port);
> @@ -1240,6 +1313,45 @@ static int s3c64xx_serial_startup(struct uart_port *port)
>  	return ret;
>  }
>  
> +static int apple_s5l_serial_startup(struct uart_port *port)
> +{
> +	struct s3c24xx_uart_port *ourport = to_ourport(port);
> +	unsigned long flags;
> +	unsigned int ufcon;
> +	int ret;
> +
> +	wr_regl(port, S3C2410_UTRSTAT, APPLE_S5L_UTRSTAT_ALL_FLAGS);
> +
> +	ret = request_irq(port->irq, apple_serial_handle_irq, 0,
> +			  s3c24xx_serial_portname(port), ourport);
> +	if (ret) {
> +		dev_err(port->dev, "cannot get irq %d\n", port->irq);
> +		return ret;
> +	}
> +
> +	/* For compatibility with s3c24xx Soc's */
> +	ourport->rx_enabled = 1;
> +	ourport->tx_enabled = 0;
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +
> +	ufcon = rd_regl(port, S3C2410_UFCON);
> +	ufcon |= S3C2410_UFCON_RESETRX | S5PV210_UFCON_RXTRIG8;
> +	if (!uart_console(port))
> +		ufcon |= S3C2410_UFCON_RESETTX;
> +	wr_regl(port, S3C2410_UFCON, ufcon);
> +
> +	enable_rx_pio(ourport);
> +
> +	spin_unlock_irqrestore(&port->lock, flags);
> +
> +	/* Enable Rx Interrupt */
> +	s3c24xx_set_bit(port, APPLE_S5L_UCON_RXTHRESH_ENA, S3C2410_UCON);
> +	s3c24xx_set_bit(port, APPLE_S5L_UCON_RXTO_ENA, S3C2410_UCON);
> +
> +	return ret;
> +}
> +
>  /* power power management control */
>  
>  static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level,
> @@ -1567,6 +1679,8 @@ static const char *s3c24xx_serial_type(struct uart_port *port)
>  		return "S3C24XX";
>  	case TYPE_S3C6400:
>  		return "S3C6400/10";
> +	case TYPE_APPLE_S5L:
> +		return "APPLE S5L";
>  	default:
>  		return NULL;
>  	}
> @@ -1658,6 +1772,27 @@ static const struct uart_ops s3c64xx_serial_ops = {
>  #endif
>  };
>  
> +static const struct uart_ops apple_s5l_serial_ops = {
> +	.pm		= s3c24xx_serial_pm,
> +	.tx_empty	= s3c24xx_serial_tx_empty,
> +	.get_mctrl	= s3c24xx_serial_get_mctrl,
> +	.set_mctrl	= s3c24xx_serial_set_mctrl,
> +	.stop_tx	= s3c24xx_serial_stop_tx,
> +	.start_tx	= s3c24xx_serial_start_tx,
> +	.stop_rx	= s3c24xx_serial_stop_rx,
> +	.break_ctl	= s3c24xx_serial_break_ctl,
> +	.startup	= apple_s5l_serial_startup,
> +	.shutdown	= apple_s5l_serial_shutdown,
> +	.set_termios	= s3c24xx_serial_set_termios,
> +	.type		= s3c24xx_serial_type,
> +	.config_port	= s3c24xx_serial_config_port,
> +	.verify_port	= s3c24xx_serial_verify_port,
> +#if defined(CONFIG_SERIAL_SAMSUNG_CONSOLE) && defined(CONFIG_CONSOLE_POLL)
> +	.poll_get_char = s3c24xx_serial_get_poll_char,
> +	.poll_put_char = s3c24xx_serial_put_poll_char,
> +#endif
> +};
> +
>  static struct uart_driver s3c24xx_uart_drv = {
>  	.owner		= THIS_MODULE,
>  	.driver_name	= "s3c2410_serial",
> @@ -1969,6 +2104,18 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
>  
>  	/* Keep all interrupts masked and cleared */
>  	switch (ourport->info->type) {
> +	case TYPE_APPLE_S5L: {

Usually you put TYPE_APPLE at the end of switch, so please keep it
consistent. Can be first or last - just everywhere the same, unless you
have a fall-through on purpose.

> +		unsigned int ucon;
> +
> +		ucon = rd_regl(port, S3C2410_UCON);
> +		ucon &= ~(APPLE_S5L_UCON_TXTHRESH_ENA_MSK |
> +			APPLE_S5L_UCON_RXTHRESH_ENA_MSK |
> +			APPLE_S5L_UCON_RXTO_ENA_MSK);
> +		wr_regl(port, S3C2410_UCON, ucon);
> +
> +		wr_regl(port, S3C2410_UTRSTAT, APPLE_S5L_UTRSTAT_ALL_FLAGS);
> +		break;
> +	}
>  	case TYPE_S3C6400:
>  		wr_regl(port, S3C64XX_UINTM, 0xf);
>  		wr_regl(port, S3C64XX_UINTP, 0xf);
> @@ -2053,6 +2200,9 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
>  	case TYPE_S3C6400:
>  		ourport->port.ops = &s3c64xx_serial_ops;
>  		break;
> +	case TYPE_APPLE_S5L:
> +		ourport->port.ops = &apple_s5l_serial_ops;
> +		break;
>  	}
>  
>  	if (np) {
> @@ -2179,6 +2329,32 @@ static int s3c24xx_serial_resume_noirq(struct device *dev)
>  	if (port) {
>  		/* restore IRQ mask */
>  		switch (ourport->info->type) {
> +		case TYPE_APPLE_S5L: {
> +			unsigned int ucon;
> +
> +			clk_prepare_enable(ourport->clk);
> +			if (!IS_ERR(ourport->baudclk))
> +				clk_prepare_enable(ourport->baudclk);

We should start checking the return values of clk operations. I know
that existing code does it only in few places, so basically you are not
making it worse...

> +
> +			ucon = rd_regl(port, S3C2410_UCON);
> +
> +			ucon &= ~(APPLE_S5L_UCON_TXTHRESH_ENA_MSK |
> +				  APPLE_S5L_UCON_RXTHRESH_ENA_MSK |
> +				  APPLE_S5L_UCON_RXTO_ENA_MSK);
> +
> +			if (ourport->tx_enabled)
> +				ucon |= APPLE_S5L_UCON_TXTHRESH_ENA_MSK;
> +			if (ourport->rx_enabled)
> +				ucon |= APPLE_S5L_UCON_RXTHRESH_ENA_MSK |
> +					APPLE_S5L_UCON_RXTO_ENA_MSK;
> +
> +			wr_regl(port, S3C2410_UCON, ucon);
> +
> +			if (!IS_ERR(ourport->baudclk))
> +				clk_disable_unprepare(ourport->baudclk);
> +			clk_disable_unprepare(ourport->clk);
> +			break;
> +		}
>  		case TYPE_S3C6400: {
>  			unsigned int uintm = 0xf;
>  
> @@ -2604,6 +2780,35 @@ static struct s3c24xx_serial_drv_data exynos5433_serial_drv_data = {
>  #define EXYNOS5433_SERIAL_DRV_DATA (kernel_ulong_t)NULL
>  #endif
>  
> +#ifdef CONFIG_ARCH_APPLE
> +static struct s3c24xx_serial_drv_data s5l_serial_drv_data = {
> +	.info = &(struct s3c24xx_uart_info) {
> +		.name		= "Apple S5L UART",
> +		.type		= TYPE_APPLE_S5L,
> +		.port_type	= PORT_8250,
> +		.fifosize	= 16,
> +		.rx_fifomask	= S3C2410_UFSTAT_RXMASK,
> +		.rx_fifoshift	= S3C2410_UFSTAT_RXSHIFT,
> +		.rx_fifofull	= S3C2410_UFSTAT_RXFULL,
> +		.tx_fifofull	= S3C2410_UFSTAT_TXFULL,
> +		.tx_fifomask	= S3C2410_UFSTAT_TXMASK,
> +		.tx_fifoshift	= S3C2410_UFSTAT_TXSHIFT,
> +		.def_clk_sel	= S3C2410_UCON_CLKSEL0,
> +		.num_clks	= 1,
> +		.clksel_mask	= 0,
> +		.clksel_shift	= 0,
> +	},
> +	.def_cfg = &(struct s3c2410_uartcfg) {
> +		.ucon		= APPLE_S5L_UCON_DEFAULT,
> +		.ufcon		= S3C2410_UFCON_DEFAULT,
> +	},
> +};
> +#define S5L_SERIAL_DRV_DATA ((kernel_ulong_t)&s5l_serial_drv_data)
> +#else
> +#define S5L_SERIAL_DRV_DATA ((kernel_ulong_t)NULL)
> +#endif
> +
> +

Only one line break.

Best regards,
Krzysztof
