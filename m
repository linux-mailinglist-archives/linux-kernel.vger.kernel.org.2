Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F9F31EBFC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 17:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbhBRQC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 11:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhBRNax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 08:30:53 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C046DC061788
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 05:29:31 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 5984A3FA55;
        Thu, 18 Feb 2021 13:24:58 +0000 (UTC)
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
 <20210215121713.57687-18-marcan@marcan.st>
 <20210215180652.tbccd5dhsfjpdayp@kozik-lap>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v2 17/25] tty: serial: samsung_tty: Separate S3C64XX ops
 structure
Message-ID: <4475513e-ffe5-6064-d37e-8dbc16805dc7@marcan.st>
Date:   Thu, 18 Feb 2021 22:24:55 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210215180652.tbccd5dhsfjpdayp@kozik-lap>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2021 03.06, Krzysztof Kozlowski wrote:
> On Mon, Feb 15, 2021 at 09:17:05PM +0900, Hector Martin wrote:
>> +static void s3c64xx_serial_shutdown(struct uart_port *port)
>> +{
>> +	struct s3c24xx_uart_port *ourport = to_ourport(port);
>> +
>> +	free_irq(port->irq, ourport);
>> +
>> +	wr_regl(port, S3C64XX_UINTP, 0xf);
>> +	wr_regl(port, S3C64XX_UINTM, 0xf);
>> +
>> +	ourport->tx_enabled = 0;
>> +	ourport->tx_mode = 0;
>> +	ourport->rx_enabled = 0;
> 
> For S3C64xx type this is not equivalent: the assignments were
> happening before free_irq() and wr_regl(). Honestly I don't know whether
> it matters (except some barriers coming from these functions) but please
> do not change the order of code in this patch. If needed, the
> re-ordering should be a patch on its own. With explanation why.

Honestly, I think if anything the masking should happen first (to make 
sure no IRQs go off), but at this point it's probably better to play it 
safe and not introduce any logic changes, so I've moved the assignments 
first to retain the old behavior.

> Make the s3c24xx_serial_ops const as well.

Done for v3, thanks.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
