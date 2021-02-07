Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE929312333
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 10:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhBGJ1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 04:27:51 -0500
Received: from marcansoft.com ([212.63.210.85]:35302 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhBGJ1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 04:27:44 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id C083042852;
        Sun,  7 Feb 2021 09:26:45 +0000 (UTC)
Subject: Re: [PATCH 05/18] tty: serial: samsung_tty: add support for Apple
 UARTs
From:   Hector Martin 'marcan' <marcan@marcan.st>
To:     Marc Zyngier <maz@kernel.org>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20210204203951.52105-1-marcan@marcan.st>
 <20210204203951.52105-6-marcan@marcan.st> <87lfc1l4lo.wl-maz@kernel.org>
 <e842f37d-d788-2d34-05e4-86ef94aed8f5@marcan.st>
Message-ID: <e2bd8f99-58db-4cae-30b3-6fa608bc76dd@marcan.st>
Date:   Sun, 7 Feb 2021 18:26:43 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <e842f37d-d788-2d34-05e4-86ef94aed8f5@marcan.st>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2021 18.12, Hector Martin 'marcan' wrote:
> On 06/02/2021 22.15, Marc Zyngier wrote:
>> The default should be IRQ_NONE, otherwise the kernel cannot detect a
>> screaming spurious interrupt.
> 
> Good point, and this needs fixing in s3c64xx_serial_handle_irq too then
> (which is what I based mine off of).
> 
>>> +	ret = request_irq(port->irq, apple_serial_handle_irq, IRQF_SHARED,
>>> +			  s3c24xx_serial_portname(port), ourport);
>>
>> Why IRQF_SHARED? Do you expect any other device sharing the same line
>> with this UART?
> 
> This also came from s3c64xx_serial_startup and... now I wonder why that
> one needs it. Maybe on some SoCs it does get shared? Certainly not for
> discrete rx/tx irq chips (and indeed those don't set the flag)...
> 
> CCing Thomas, who added the S3C64xx support (and should probably review
> this patch); is there a reason for IRQF_SHARED there? NB: v1 breaks the
> build on arm or with CONFIG_PM_SLEEP, those will be fixed for v2.

Seems Thomas does not work for Linaro any more :)

CCing Krzysztof instead, who is the Samsung arch maintainer.

> 
> Either way, certainly not for Apple SoCs; I'll get rid of IRQF_SHARED
> for v2.

-- 
Hector Martin "marcan" (marcan@marcan.st)
Public Key: https://mrcn.st/pub
