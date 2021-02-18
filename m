Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5674931EC73
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 17:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbhBRQmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 11:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbhBRN6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 08:58:07 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9755AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 05:57:26 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id C0AB541E96;
        Thu, 18 Feb 2021 13:53:12 +0000 (UTC)
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
 <20210215121713.57687-20-marcan@marcan.st>
 <20210215184012.sf6p6dbk5c25phdm@kozik-lap>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v2 19/25] tty: serial: samsung_tty: IRQ rework
Message-ID: <31068a51-736b-08f6-6c00-1779734465ea@marcan.st>
Date:   Thu, 18 Feb 2021 22:53:10 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210215184012.sf6p6dbk5c25phdm@kozik-lap>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2021 03.40, Krzysztof Kozlowski wrote:
> On Mon, Feb 15, 2021 at 09:17:07PM +0900, Hector Martin wrote:
>> * Split out s3c24xx_serial_tx_chars from s3c24xx_serial_tx_irq,
>>    where only the latter acquires the port lock.
> 
> I miss here information why you do all this.

Added an explanation for v3. This is used by a subsequent patch in the 
series.

>>
>> * For S3C64xx, return IRQ_NONE if no flag bits were set, so the
>>    interrupt core can detect IRQ storms. Note that both IRQ handlers
>>    always return IRQ_HANDLED anyway, so 'or' logic isn't necessary here,
>>    if either handler ran we are always going to return IRQ_HANDLED.
> 
> It looks like separate patch. Your patches should do only one thing at
> once. The fact that you have here three bullet points is a warning
> sign. This is even more important if you do some refactorings and
> cleanups which should not affect functionality. Hiding there changes
> which could affect functionality is a no-go.

I've reverted this one. I don't think it should affect functionality, 
but I don't have any way to test on these devices, so I'll leave it to 
someone else to be safe :)

>>
>> * Rename s3c24xx_serial_rx_chars to s3c24xx_serial_rx_irq for
>>    consistency with the above. All it does now is call two other
>>    functions anyway.
> 
> Separate patch for trivial renaming.

I think it makes sense to do this rename together with the first change 
above, as it keeps both functions symmetric. Otherwise we end up with an 
inconsistent function naming between both patches. If you really want it 
separate though, I can do that.

> 
>>
>> Signed-off-by: Hector Martin <marcan@marcan.st>
>> ---
>>   drivers/tty/serial/samsung_tty.c | 41 +++++++++++++++++++-------------
>>   1 file changed, 24 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
>> index 21955be680a4..821cd0e4f870 100644
>> --- a/drivers/tty/serial/samsung_tty.c
>> +++ b/drivers/tty/serial/samsung_tty.c
>> @@ -151,6 +151,9 @@ struct s3c24xx_uart_port {
>>   #endif
>>   };
>>   
>> +static void s3c24xx_serial_start_next_tx(struct s3c24xx_uart_port *ourport);
>> +static void s3c24xx_serial_tx_chars(struct s3c24xx_uart_port *ourport);
>> +
>>   /* conversion functions */
>>   
>>   #define s3c24xx_dev_to_port(__dev) dev_get_drvdata(__dev)
>> @@ -316,8 +319,6 @@ static void s3c24xx_serial_stop_tx(struct uart_port *port)
>>   	ourport->tx_mode = 0;
>>   }
>>   
>> -static void s3c24xx_serial_start_next_tx(struct s3c24xx_uart_port *ourport);
>> -
> 
> Why moving this? Why adding s3c24xx_serial_tx_chars() forward
> declaration?

This should've gone in the next patch. A previous reviewer told me to 
put declarations at the top of the file, so I put it there and moved 
this one along with it, but I'll keep it to the additon only for v3.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
