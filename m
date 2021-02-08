Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F0B313D85
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbhBHSbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:31:00 -0500
Received: from marcansoft.com ([212.63.210.85]:43722 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232597AbhBHQK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 11:10:58 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 2093141F47;
        Mon,  8 Feb 2021 16:10:03 +0000 (UTC)
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, robh+dt@kernel.org,
        Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Olof Johansson <olof@lixom.net>
References: <20210204203951.52105-1-marcan@marcan.st>
 <20210204203951.52105-6-marcan@marcan.st>
 <20210208105451.yumjjunjeyrglfnw@kozik-lap>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 05/18] tty: serial: samsung_tty: add support for Apple
 UARTs
Message-ID: <11d36c47-45c6-03ee-2d08-6692b5d0e241@marcan.st>
Date:   Tue, 9 Feb 2021 01:10:02 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210208105451.yumjjunjeyrglfnw@kozik-lap>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2021 19.54, Krzysztof Kozlowski wrote:
>> +enum s3c24xx_irq_type {
>> +	IRQ_DISCRETE = 0,
>> +	IRQ_S3C6400 = 1,
>> +	IRQ_APPLE = 2,
> 
> It seems you add the third structure to differentiate type of UART.
> There is already port type and s3c24xx_serial_drv_data, no need for
> third structure (kind of similar to tries of Tamseel Shams in recent
> patches). It's too much. Instead, differentiate by port type or prepare
> own set of uart_ops if it's really different (like you did with startup
> op).

This ties into little changes in a bunch of places, so separate uart_ops 
  callbacks for every one of those would end up duplicating a lot of code :(

That list is just used to map the port type to something that only 
represents the type of IRQs, but its only real purpose for the 
indirection is so I can do "== IRQ_DISCRETE" in some codepaths to mean 
"not apple or S3C6400".

e.g.

     if (s3c24xx_irq_type(port) == IRQ_DISCRETE)
         free_irq(ourport->rx_irq, ourport);

Would have to become

     if (port->type != IRQ_S3C6400 && port->type != IRQ_APPLE)
         free_irq(ourport->rx_irq, ourport);

or

     switch (port->type) {
     case IRQ_S3C6400:
     case IRQ_APPLE:
         break;
     default:
         free_irq(ourport->rx_irq, ourport);
     }

Which one do you prefer?

Aside: Marc didn't like introducing new port types into uapi, but if we 
don't do that then we need a "real" port type in drv_data that isn't the 
uapi-exposed port or something along those lines, with a separate enum 
containing all the true port type values for that.

>>   	/* Startup sequence is different for s3c64xx and higher SoC's */
>> -	if (s3c24xx_serial_has_interrupt_mask(port))
>> +	case IRQ_S3C6400:
>>   		s3c24xx_serial_ops.startup = s3c64xx_serial_startup;
> 
> Don't overwrite specific ops. It's difficult to see then which ops are
> being used. Instead create a new set of uart_ops matching the needs.

s3c24xx_serial_ops was already doing that here, but I can move that to a 
a separate uart_ops too.

Ack on all the other comments, I'll make the changes for v2.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
