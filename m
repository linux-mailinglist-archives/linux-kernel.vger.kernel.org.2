Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F013425431
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 15:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241576AbhJGNh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 09:37:59 -0400
Received: from mout01.posteo.de ([185.67.36.141]:40905 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233197AbhJGNh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 09:37:58 -0400
X-Greylist: delayed 460 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Oct 2021 09:37:57 EDT
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id A5AC824002A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 15:28:22 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4HQBwL6nS7z9rxK;
        Thu,  7 Oct 2021 15:28:18 +0200 (CEST)
Subject: Re: [PATCH] tty: serial: atmel: use macros instead of hardcoded
 values
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        richard.genoud@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20211007112014.2332019-1-claudiu.beznea@microchip.com>
From:   Richard Genoud <richard.genoud@gmail.com>
Message-ID: <5e1ab713-b198-b3ed-27eb-0af728ebe274@posteo.net>
Date:   Thu,  7 Oct 2021 13:28:18 +0000
MIME-Version: 1.0
In-Reply-To: <20211007112014.2332019-1-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 07/10/2021 à 13:20, Claudiu Beznea a écrit :
> Use UART_PM_STATE_ON, UART_PM_STATE_OFF instead of hardcoded values.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Acked-by: Richard Genoud <richard.genoud@gmail.com>

> ---
>   drivers/tty/serial/atmel_serial.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 249ea35088d2..2c99a47a2535 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -2084,7 +2084,7 @@ static void atmel_serial_pm(struct uart_port *port, unsigned int state,
>   	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
>   
>   	switch (state) {
> -	case 0:
> +	case UART_PM_STATE_ON:
>   		/*
>   		 * Enable the peripheral clock for this serial port.
>   		 * This is called on uart_open() or a resume event.
> @@ -2094,7 +2094,7 @@ static void atmel_serial_pm(struct uart_port *port, unsigned int state,
>   		/* re-enable interrupts if we disabled some on suspend */
>   		atmel_uart_writel(port, ATMEL_US_IER, atmel_port->backup_imr);
>   		break;
> -	case 3:
> +	case UART_PM_STATE_OFF:
>   		/* Back up the interrupt mask and disable all interrupts */
>   		atmel_port->backup_imr = atmel_uart_readl(port, ATMEL_US_IMR);
>   		atmel_uart_writel(port, ATMEL_US_IDR, -1);
> 
Thanks !
