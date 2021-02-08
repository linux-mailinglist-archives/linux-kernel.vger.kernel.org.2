Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B44313004
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 12:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbhBHLCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 06:02:11 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:44861 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbhBHKzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 05:55:53 -0500
Received: by mail-ed1-f48.google.com with SMTP id q2so14373384eds.11;
        Mon, 08 Feb 2021 02:55:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d28/+ehhh0ZhQclaDcWhBfLkJrjhoZ5O8rTtqBPqgLw=;
        b=Z0PziFVh9vy0veXbp0IamL5JbJTC/qKn+alGtnEcSrR/T6wxn54xtcj7rqfujTgyE4
         vHFnwg2Aoh9byJ/HmqUCtJoV6vzbFOt5nnAl9cWm/EaPHey+EahsQbAVEn0XezDj6yn5
         RyKMX7HiCG38H7jAAi14KUPTjuHBIL1z1gHVbTcmta+IP/Z/7GamPiRnm6Rbib0Mmv6r
         lVnq2lcaa4/wTxxc+MoK9iI6s9kwP6cBCkoDW/dcvBscmWeDGmWApnQyRTbakAn8SjAe
         mHTjbisoShzdjdK4mHVDq2g3iVlRkpTJj7crjzMVjaGekvQ3dG3AOEx8Doj5uIxvzNaN
         uGkA==
X-Gm-Message-State: AOAM532SrBCUnb77+QJRmW7fVVZbLUETJIJ8I2WQLy4DzrC2SuitLvN8
        ZMDqLhysKLWYX8nfKgPnoCo=
X-Google-Smtp-Source: ABdhPJyGsiKhRTZ1eVwxz7lPBthis/fMxt/4N+Q66uye8ZUE5K0dCeftQkoCwVrxWQtyMVQi0KlKYQ==
X-Received: by 2002:aa7:c58f:: with SMTP id g15mr9311665edq.383.1612781694161;
        Mon, 08 Feb 2021 02:54:54 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id w8sm8985959edd.39.2021.02.08.02.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 02:54:53 -0800 (PST)
Date:   Mon, 8 Feb 2021 11:54:51 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, robh+dt@kernel.org,
        Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 05/18] tty: serial: samsung_tty: add support for Apple
 UARTs
Message-ID: <20210208105451.yumjjunjeyrglfnw@kozik-lap>
References: <20210204203951.52105-1-marcan@marcan.st>
 <20210204203951.52105-6-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210204203951.52105-6-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 05:39:38AM +0900, Hector Martin wrote:
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
>  drivers/tty/serial/samsung_tty.c | 297 +++++++++++++++++++++++++++----
>  include/linux/serial_s3c.h       |  16 ++
>  include/uapi/linux/serial_core.h |   3 +
>  3 files changed, 280 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index 8ae3e03fbd8c..6d812ba1b748 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -56,6 +56,9 @@
>  /* flag to ignore all characters coming in */
>  #define RXSTAT_DUMMY_READ (0x10000000)
>  
> +/* IRQ number used when the handler is called in non-IRQ context */
> +#define NO_IRQ -1
> +
>  struct s3c24xx_uart_info {
>  	char			*name;
>  	unsigned int		type;
> @@ -144,6 +147,14 @@ struct s3c24xx_uart_port {
>  #endif
>  };
>  
> +enum s3c24xx_irq_type {
> +	IRQ_DISCRETE = 0,
> +	IRQ_S3C6400 = 1,
> +	IRQ_APPLE = 2,

It seems you add the third structure to differentiate type of UART.
There is already port type and s3c24xx_serial_drv_data, no need for
third structure (kind of similar to tries of Tamseel Shams in recent
patches). It's too much. Instead, differentiate by port type or prepare
own set of uart_ops if it's really different (like you did with startup
op).

> +};
> +
> +static void s3c24xx_serial_start_next_tx(struct s3c24xx_uart_port *ourport);
> +
>  /* conversion functions */
>  
>  #define s3c24xx_dev_to_port(__dev) dev_get_drvdata(__dev)
> @@ -231,11 +242,20 @@ static int s3c24xx_serial_txempty_nofifo(struct uart_port *port)
>  /*
>   * s3c64xx and later SoC's include the interrupt mask and status registers in
>   * the controller itself, unlike the s3c24xx SoC's which have these registers
> - * in the interrupt controller. Check if the port type is s3c64xx or higher.
> + * in the interrupt controller. Apple SoCs use a different flavor of mask
> + * and status registers. This function returns the IRQ style to use.
>   */
> -static int s3c24xx_serial_has_interrupt_mask(struct uart_port *port)
> +static int s3c24xx_irq_type(struct uart_port *port)
>  {
> -	return to_ourport(port)->info->type == PORT_S3C6400;
> +	switch (to_ourport(port)->info->type) {
> +	case PORT_S3C6400:
> +		return IRQ_S3C6400;
> +	case PORT_APPLE:
> +		return IRQ_APPLE;
> +	default:
> +		return IRQ_DISCRETE;
> +	}
> +

No empty lines at end of function.

>  }
>  
>  static void s3c24xx_serial_rx_enable(struct uart_port *port)
> @@ -289,10 +309,17 @@ static void s3c24xx_serial_stop_tx(struct uart_port *port)
>  	if (!ourport->tx_enabled)
>  		return;
>  
> -	if (s3c24xx_serial_has_interrupt_mask(port))
> +	switch (s3c24xx_irq_type(port)) {
> +	case IRQ_APPLE:
> +		s3c24xx_clear_bit(port, APPLE_UCON_TXTHRESH_ENA, S3C2410_UCON);
> +		break;
> +	case IRQ_S3C6400:
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
> @@ -315,8 +342,6 @@ static void s3c24xx_serial_stop_tx(struct uart_port *port)
>  	ourport->tx_mode = 0;
>  }
>  
> -static void s3c24xx_serial_start_next_tx(struct s3c24xx_uart_port *ourport);
> -
>  static void s3c24xx_serial_tx_dma_complete(void *args)
>  {
>  	struct s3c24xx_uart_port *ourport = args;
> @@ -353,10 +378,17 @@ static void enable_tx_dma(struct s3c24xx_uart_port *ourport)
>  	u32 ucon;
>  
>  	/* Mask Tx interrupt */
> -	if (s3c24xx_serial_has_interrupt_mask(port))
> +	switch (s3c24xx_irq_type(port)) {
> +	case IRQ_APPLE:
> +		WARN_ON(1); // No DMA
> +		break;
> +	case IRQ_S3C6400:
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
> @@ -369,6 +401,8 @@ static void enable_tx_dma(struct s3c24xx_uart_port *ourport)
>  	ourport->tx_mode = S3C24XX_TX_DMA;
>  }
>  
> +static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id);
> +
>  static void enable_tx_pio(struct s3c24xx_uart_port *ourport)
>  {
>  	struct uart_port *port = &ourport->port;
> @@ -383,16 +417,30 @@ static void enable_tx_pio(struct s3c24xx_uart_port *ourport)
>  	ucon = rd_regl(port, S3C2410_UCON);
>  	ucon &= ~(S3C64XX_UCON_TXMODE_MASK);
>  	ucon |= S3C64XX_UCON_TXMODE_CPU;
> -	wr_regl(port,  S3C2410_UCON, ucon);
>  
>  	/* Unmask Tx interrupt */
> -	if (s3c24xx_serial_has_interrupt_mask(port))
> -		s3c24xx_clear_bit(port, S3C64XX_UINTM_TXD,
> -				  S3C64XX_UINTM);
> -	else
> +	switch (s3c24xx_irq_type(port)) {
> +	case IRQ_APPLE:
> +		ucon |= APPLE_UCON_TXTHRESH_ENA_MSK;
> +		break;
> +	case IRQ_S3C6400:
> +		s3c24xx_clear_bit(port, S3C64XX_UINTM_TXD, S3C64XX_UINTM);
> +		break;
> +	default:
>  		enable_irq(ourport->tx_irq);
> +		break;
> +	}
> +
> +	wr_regl(port,  S3C2410_UCON, ucon);
>  
>  	ourport->tx_mode = S3C24XX_TX_PIO;
> +
> +	/*
> +	 * The Apple version only has edge triggered TX IRQs, so we need
> +	 * to kick off the process by sending some characters here.
> +	 */
> +	if (s3c24xx_irq_type(port) == IRQ_APPLE)
> +		s3c24xx_serial_tx_chars(NO_IRQ, ourport);
>  }
>  
>  static void s3c24xx_serial_start_tx_pio(struct s3c24xx_uart_port *ourport)
> @@ -513,11 +561,18 @@ static void s3c24xx_serial_stop_rx(struct uart_port *port)
>  
>  	if (ourport->rx_enabled) {
>  		dev_dbg(port->dev, "stopping rx\n");
> -		if (s3c24xx_serial_has_interrupt_mask(port))
> -			s3c24xx_set_bit(port, S3C64XX_UINTM_RXD,
> -					S3C64XX_UINTM);
> -		else
> -			disable_irq_nosync(ourport->rx_irq);
> +		switch (s3c24xx_irq_type(port)) {
> +		case IRQ_APPLE:
> +			s3c24xx_clear_bit(port, APPLE_UCON_RXTHRESH_ENA, S3C2410_UCON);
> +			s3c24xx_clear_bit(port, APPLE_UCON_RXTO_ENA, S3C2410_UCON);
> +			break;
> +		case IRQ_S3C6400:
> +			s3c24xx_set_bit(port, S3C64XX_UINTM_RXD, S3C64XX_UINTM);
> +			break;
> +		default:
> +			disable_irq_nosync(ourport->tx_irq);
> +			break;
> +		}
>  		ourport->rx_enabled = 0;
>  	}
>  	if (dma && dma->rx_chan) {
> @@ -651,14 +706,18 @@ static void enable_rx_pio(struct s3c24xx_uart_port *ourport)
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
> +	if (s3c24xx_irq_type(port) != IRQ_APPLE) {
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
> @@ -831,7 +890,9 @@ static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
>  	unsigned long flags;
>  	int count, dma_count = 0;
>  
> -	spin_lock_irqsave(&port->lock, flags);
> +	/* Only lock if called from IRQ context */
> +	if (irq != NO_IRQ)
> +		spin_lock_irqsave(&port->lock, flags);

I would prefer to have two functions - unlocked (doing actual stuff) and
a locking wrapper. Something like is done for regulator_is_enabled().
However the s3c24xx_serial_tx_chars() also unlocks-locks inside, so it
might be not easy to split common part Anyway hacking interrupt handler
to NO_IRQ is confusing and not readable.

>  
>  	count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
>  
> @@ -893,7 +954,8 @@ static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
>  		s3c24xx_serial_stop_tx(port);
>  
>  out:
> -	spin_unlock_irqrestore(&port->lock, flags);
> +	if (irq != NO_IRQ)
> +		spin_unlock_irqrestore(&port->lock, flags);
>  	return IRQ_HANDLED;
>  }
>  
> @@ -916,6 +978,26 @@ static irqreturn_t s3c64xx_serial_handle_irq(int irq, void *id)
>  	return ret;
>  }
>  
> +/* interrupt handler for Apple SoC's.*/
> +static irqreturn_t apple_serial_handle_irq(int irq, void *id)
> +{
> +	struct s3c24xx_uart_port *ourport = id;
> +	struct uart_port *port = &ourport->port;
> +	unsigned int pend = rd_regl(port, S3C2410_UTRSTAT);
> +	irqreturn_t ret = IRQ_HANDLED;
> +
> +	if (pend & (APPLE_UTRSTAT_RXTHRESH | APPLE_UTRSTAT_RXTO)) {
> +		wr_regl(port, S3C2410_UTRSTAT, APPLE_UTRSTAT_RXTHRESH | APPLE_UTRSTAT_RXTO);
> +		ret = s3c24xx_serial_rx_chars(irq, id);
> +	}
> +	if (pend & APPLE_UTRSTAT_TXTHRESH) {
> +		wr_regl(port, S3C2410_UTRSTAT, APPLE_UTRSTAT_TXTHRESH);
> +		ret = s3c24xx_serial_tx_chars(irq, id);
> +	}
> +
> +	return ret;
> +}
> +
>  static unsigned int s3c24xx_serial_tx_empty(struct uart_port *port)
>  {
>  	struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
> @@ -1098,7 +1180,7 @@ static void s3c24xx_serial_shutdown(struct uart_port *port)
>  	struct s3c24xx_uart_port *ourport = to_ourport(port);
>  
>  	if (ourport->tx_claimed) {
> -		if (!s3c24xx_serial_has_interrupt_mask(port))
> +		if (s3c24xx_irq_type(port) == IRQ_DISCRETE)
>  			free_irq(ourport->tx_irq, ourport);
>  		ourport->tx_enabled = 0;
>  		ourport->tx_claimed = 0;
> @@ -1106,18 +1188,34 @@ static void s3c24xx_serial_shutdown(struct uart_port *port)
>  	}
>  
>  	if (ourport->rx_claimed) {
> -		if (!s3c24xx_serial_has_interrupt_mask(port))
> +		if (s3c24xx_irq_type(port) == IRQ_DISCRETE)
>  			free_irq(ourport->rx_irq, ourport);
>  		ourport->rx_claimed = 0;
>  		ourport->rx_enabled = 0;
>  	}
>  
>  	/* Clear pending interrupts and mask all interrupts */
> -	if (s3c24xx_serial_has_interrupt_mask(port)) {
> +	switch (s3c24xx_irq_type(port)) {
> +	case IRQ_APPLE: {
> +		unsigned int ucon;
> +
> +		ucon = rd_regl(port, S3C2410_UCON);
> +		ucon &= ~(APPLE_UCON_TXTHRESH_ENA_MSK |
> +			APPLE_UCON_RXTHRESH_ENA_MSK |
> +			APPLE_UCON_RXTO_ENA_MSK);
> +		wr_regl(port, S3C2410_UCON, ucon);
> +
> +		wr_regl(port, S3C2410_UTRSTAT, APPLE_UTRSTAT_ALL_FLAGS);
> +
> +		free_irq(port->irq, ourport);
> +		break;
> +	}
> +	case IRQ_S3C6400:
>  		free_irq(port->irq, ourport);
>  
>  		wr_regl(port, S3C64XX_UINTP, 0xf);
>  		wr_regl(port, S3C64XX_UINTM, 0xf);
> +		break;
>  	}
>  
>  	if (ourport->dma)
> @@ -1215,6 +1313,47 @@ static int s3c64xx_serial_startup(struct uart_port *port)
>  	return ret;
>  }
>  
> +static int apple_serial_startup(struct uart_port *port)
> +{
> +	struct s3c24xx_uart_port *ourport = to_ourport(port);
> +	unsigned long flags;
> +	unsigned int ufcon;
> +	int ret;
> +
> +	wr_regl(port, S3C2410_UTRSTAT, APPLE_UTRSTAT_ALL_FLAGS);
> +
> +	ret = request_irq(port->irq, apple_serial_handle_irq, IRQF_SHARED,
> +			  s3c24xx_serial_portname(port), ourport);
> +	if (ret) {
> +		dev_err(port->dev, "cannot get irq %d\n", port->irq);
> +		return ret;
> +	}
> +
> +	/* For compatibility with s3c24xx Soc's */
> +	ourport->rx_enabled = 1;
> +	ourport->rx_claimed = 1;
> +	ourport->tx_enabled = 0;
> +	ourport->tx_claimed = 1;
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
> +	s3c24xx_set_bit(port, APPLE_UCON_RXTHRESH_ENA, S3C2410_UCON);
> +	s3c24xx_set_bit(port, APPLE_UCON_RXTO_ENA, S3C2410_UCON);
> +
> +	return ret;
> +}
> +
>  /* power power management control */
>  
>  static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level,
> @@ -1544,6 +1683,8 @@ static const char *s3c24xx_serial_type(struct uart_port *port)
>  		return "S3C2412";
>  	case PORT_S3C6400:
>  		return "S3C6400/10";
> +	case PORT_APPLE:
> +		return "APPLE";

"Apple S5L"?

>  	default:
>  		return NULL;
>  	}
> @@ -1868,9 +2009,16 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
>  	/* setup info for port */
>  	port->dev	= &platdev->dev;
>  
> +	switch (s3c24xx_irq_type(port)) {
> +	/* Startup sequence is different for Apple SoC's */
> +	case IRQ_APPLE:
> +		s3c24xx_serial_ops.startup = apple_serial_startup;
> +		break;
>  	/* Startup sequence is different for s3c64xx and higher SoC's */
> -	if (s3c24xx_serial_has_interrupt_mask(port))
> +	case IRQ_S3C6400:
>  		s3c24xx_serial_ops.startup = s3c64xx_serial_startup;

Don't overwrite specific ops. It's difficult to see then which ops are
being used. Instead create a new set of uart_ops matching the needs.

Best regards,
Krzysztof
