Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4AEB31EC33
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 17:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbhBRQWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 11:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbhBRNiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 08:38:03 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D46DC061574;
        Thu, 18 Feb 2021 05:37:16 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 806163FA55;
        Thu, 18 Feb 2021 13:37:09 +0000 (UTC)
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
 <20210215121713.57687-19-marcan@marcan.st>
 <20210215182651.rjte67udhk3vhbsk@kozik-lap>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v2 18/25] tty: serial: samsung_tty: add s3c24xx_port_type
Message-ID: <a48c407c-67ce-a46f-5678-11a5426cab50@marcan.st>
Date:   Thu, 18 Feb 2021 22:37:03 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210215182651.rjte67udhk3vhbsk@kozik-lap>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2021 03.26, Krzysztof Kozlowski wrote:
>> This removes s3c24xx_serial_has_interrupt_mask, which was just checking
>> for a specific type anyway, and adds the ucon_mask port info member to
>> avoid having S3C2440 as a distinct type.
> 
> Please split setting the ucon_mask to separate patch. It's a nice
> code simplification on its own.

Done for v3.

>>   	/* Unmask Tx interrupt */
>> -	if (s3c24xx_serial_has_interrupt_mask(port))
>> -		s3c24xx_clear_bit(port, S3C64XX_UINTM_TXD,
>> -				  S3C64XX_UINTM);
>> -	else
>> +	switch (ourport->info->type) {
>> +	case TYPE_S3C6400:
>> +		s3c24xx_clear_bit(port, S3C64XX_UINTM_TXD, S3C64XX_UINTM);
> 
> Please do not re-wrap. It makes reviewing more difficult. You can
> perform proper re-wrapping as a separate cleanup patch.

>>   	if (ourport->rx_enabled) {
>>   		dev_dbg(port->dev, "stopping rx\n");
>> -		if (s3c24xx_serial_has_interrupt_mask(port))
>> -			s3c24xx_set_bit(port, S3C64XX_UINTM_RXD,
>> -					S3C64XX_UINTM);
> 
> The same.

Reverted those two lines for v3.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
