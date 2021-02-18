Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA3A31ECD2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 18:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhBRRE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 12:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbhBRORl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 09:17:41 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71507C061788;
        Thu, 18 Feb 2021 06:16:52 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 7159B41E96;
        Thu, 18 Feb 2021 14:16:44 +0000 (UTC)
To:     Krzysztof Kozlowski <krzk@kernel.org>
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
References: <20210215121713.57687-1-marcan@marcan.st>
 <20210215121713.57687-23-marcan@marcan.st>
 <20210215191309.k7qkak73usqj7jxp@kozik-lap>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v2 22/25] tty: serial: samsung_tty: Add support for Apple
 UARTs
Message-ID: <f08f4346-e6fd-1487-9b15-f879de4bc59a@marcan.st>
Date:   Thu, 18 Feb 2021 23:16:40 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210215191309.k7qkak73usqj7jxp@kozik-lap>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2021 04.13, Krzysztof Kozlowski wrote:
> On Mon, Feb 15, 2021 at 09:17:10PM +0900, Hector Martin wrote:
>> @@ -389,10 +396,12 @@ static void enable_tx_pio(struct s3c24xx_uart_port *ourport)
>>   	ucon = rd_regl(port, S3C2410_UCON);
>>   	ucon &= ~(S3C64XX_UCON_TXMODE_MASK);
>>   	ucon |= S3C64XX_UCON_TXMODE_CPU;
>> -	wr_regl(port,  S3C2410_UCON, ucon);
>>   
>>   	/* Unmask Tx interrupt */
>>   	switch (ourport->info->type) {
>> +	case TYPE_APPLE_S5L:
>> +		ucon |= APPLE_S5L_UCON_TXTHRESH_ENA_MSK;
>> +		break;
>>   	case TYPE_S3C6400:
>>   		s3c24xx_clear_bit(port, S3C64XX_UINTM_TXD, S3C64XX_UINTM);
>>   		break;
>> @@ -401,7 +410,16 @@ static void enable_tx_pio(struct s3c24xx_uart_port *ourport)
>>   		break;
>>   	}
>>   
>> +	wr_regl(port,  S3C2410_UCON, ucon);
> 
> You are now configuring the PIO mode after unmasking interrupt. I don't
> think it's a good idea to change the order... and if it were, it
> would deserve a separate patch.

For v3 I moved the wr_regl back and just write it again in the 
TYPE_APPLE_S5L branch; that way, setting the PIO mode and unmasking the 
interrupt are two discrete operations on S5L, like they are on other types.

>>   	/* Keep all interrupts masked and cleared */
>>   	switch (ourport->info->type) {
>> +	case TYPE_APPLE_S5L: {
> 
> Usually you put TYPE_APPLE at the end of switch, so please keep it
> consistent. Can be first or last - just everywhere the same, unless you
> have a fall-through on purpose.

Good point, thanks, moved it for v3. It was actually inconsistent in 
more places, I made all the orders the same (the enum order, and 
default: always goes at the end).

>> @@ -2179,6 +2329,32 @@ static int s3c24xx_serial_resume_noirq(struct device *dev)
>>   	if (port) {
>>   		/* restore IRQ mask */
>>   		switch (ourport->info->type) {
>> +		case TYPE_APPLE_S5L: {
>> +			unsigned int ucon;
>> +
>> +			clk_prepare_enable(ourport->clk);
>> +			if (!IS_ERR(ourport->baudclk))
>> +				clk_prepare_enable(ourport->baudclk);
> 
> We should start checking the return values of clk operations. I know
> that existing code does it only in few places, so basically you are not
> making it worse...

Added error checking for these for v3, thanks.

>> +#define S5L_SERIAL_DRV_DATA ((kernel_ulong_t)&s5l_serial_drv_data)
>> +#else
>> +#define S5L_SERIAL_DRV_DATA ((kernel_ulong_t)NULL)
>> +#endif
>> +
>> +
> 
> Only one line break.

Fixed in v3.

Thank you for the reviews!

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
