Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2F6312304
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 10:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhBGJNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 04:13:01 -0500
Received: from marcansoft.com ([212.63.210.85]:59634 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229506AbhBGJMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 04:12:54 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 55E874283E;
        Sun,  7 Feb 2021 09:12:08 +0000 (UTC)
To:     Marc Zyngier <maz@kernel.org>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Olof Johansson <olof@lixom.net>,
        Thomas Abraham <thomas.abraham@linaro.org>
References: <20210204203951.52105-1-marcan@marcan.st>
 <20210204203951.52105-6-marcan@marcan.st> <87lfc1l4lo.wl-maz@kernel.org>
From:   Hector Martin 'marcan' <marcan@marcan.st>
Subject: Re: [PATCH 05/18] tty: serial: samsung_tty: add support for Apple
 UARTs
Message-ID: <e842f37d-d788-2d34-05e4-86ef94aed8f5@marcan.st>
Date:   Sun, 7 Feb 2021 18:12:05 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87lfc1l4lo.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/2021 22.15, Marc Zyngier wrote:
>> -static int s3c24xx_serial_has_interrupt_mask(struct uart_port *port)
>> +static int s3c24xx_irq_type(struct uart_port *port)
>>   {
>> -	return to_ourport(port)->info->type == PORT_S3C6400;
>> +	switch (to_ourport(port)->info->type) {
>> +	case PORT_S3C6400:
>> +		return IRQ_S3C6400;
>> +	case PORT_APPLE:
>> +		return IRQ_APPLE;
>> +	default:
>> +		return IRQ_DISCRETE;
>> +	}
>> +
> 
> nit: For ease of reviewing, it'd be good if you could split this patch
> with introducing the S3C6400 and "discrete" support initially, and
> only then add the new stuff.

Good idea, will do for v2.

>> +	if (s3c24xx_irq_type(port) == IRQ_APPLE)
>> +		s3c24xx_serial_tx_chars(NO_IRQ, ourport);
> 
> Instead of directly calling into the handler (which has its own
> problems, see below), could you just tickle the interrupt status
> register to make an interrupt pending and trigger an actual interrupt?
> I have no idea whether the HW supports this kind of trick though.

I thought of that, but I tried really hard to find such a feature with 
no success. The best I can do is unmask and trigger the *RX* timeout 
interrupt which will eventually fire but... this doesn't work so well in 
practice. There is no way to trigger IRQ flags directly (as those bits 
are write-1-to-clear).

>> -	spin_lock_irqsave(&port->lock, flags);
>> +	/* Only lock if called from IRQ context */
>> +	if (irq != NO_IRQ)
>> +		spin_lock_irqsave(&port->lock, flags);
> 
> Isn't that actually dangerous? What prevents the interrupt from firing
> right in the middle of this sequence and create havoc when called from
> enable_tx_pio()? I fail to see what you gain with sidestepping the
> locking.

The callpath here is:

uart_start -> __uart_start -> (uart_ops.start_tx) 
s3c24xx_serial_start_tx -> s3c24xx_serial_start_tx_pio -> enable_tx_pio 
-> s3c24xx_serial_tx_chars

And uart_start takes the uart_port lock. None of the serial functions 
take the lock because the serial core already does, but obviously the 
IRQ handler needs to, *if* it's called as an IRQ handler only.

> The default should be IRQ_NONE, otherwise the kernel cannot detect a
> screaming spurious interrupt.

Good point, and this needs fixing in s3c64xx_serial_handle_irq too then 
(which is what I based mine off of).

>> +	ret = request_irq(port->irq, apple_serial_handle_irq, IRQF_SHARED,
>> +			  s3c24xx_serial_portname(port), ourport);
> 
> Why IRQF_SHARED? Do you expect any other device sharing the same line
> with this UART?

This also came from s3c64xx_serial_startup and... now I wonder why that 
one needs it. Maybe on some SoCs it does get shared? Certainly not for 
discrete rx/tx irq chips (and indeed those don't set the flag)...

CCing Thomas, who added the S3C64xx support (and should probably review 
this patch); is there a reason for IRQF_SHARED there? NB: v1 breaks the 
build on arm or with CONFIG_PM_SLEEP, those will be fixed for v2.

Either way, certainly not for Apple SoCs; I'll get rid of IRQF_SHARED 
for v2.

>> diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
>> index 62c22045fe65..59d102b674db 100644
>> --- a/include/uapi/linux/serial_core.h
>> +++ b/include/uapi/linux/serial_core.h
>> @@ -277,4 +277,7 @@
>>   /* Freescale LINFlexD UART */
>>   #define PORT_LINFLEXUART	122
>>   
>> +/* Apple Silicon (M1/T8103) UART (Samsung variant) */
>> +#define PORT_APPLE	123
>> +
> 
> Do you actually need a new port type here? Looking at the driver
> itself, it is mainly used to work out the IRQ model. Maybe introducing
> a new irq_type field in the port structure would be better than
> exposing this to userspace (which should see something that is exactly
> the same as a S3C UART).

Well... every S3C variant already has its own port type here.

#define PORT_S3C2410    55
#define PORT_S3C2440    61
#define PORT_S3C2400    67
#define PORT_S3C2412    73
#define PORT_S3C6400    84

If we don't introduce a new one, which one should we pretend to be? :)

I agree that it might make sense to merge all of these into one, though; 
I don't know what the original reason for splitting them out is. But now 
that they're part of the userspace API, this might not be a good idea. 
Though, unsurprisingly, some googling suggests there are zero users of 
these defines in userspace.

-- 
Hector Martin "marcan" (marcan@marcan.st)
Public Key: https://mrcn.st/pub
