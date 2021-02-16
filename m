Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5324331CC06
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 15:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhBPOec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 09:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhBPOeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 09:34:21 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE04CC06174A;
        Tue, 16 Feb 2021 06:33:40 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id E54DB42037;
        Tue, 16 Feb 2021 14:33:34 +0000 (UTC)
Subject: Re: [PATCH v2 06/25] arm64: arch_timer: implement support for
 interrupt-names
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210215121713.57687-1-marcan@marcan.st>
 <20210215121713.57687-7-marcan@marcan.st> <YCq8Kl8KYQzpBEy0@atomide.com>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <f171b37d-1158-5592-807e-8f12ebc3585f@marcan.st>
Date:   Tue, 16 Feb 2021 23:33:32 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YCq8Kl8KYQzpBEy0@atomide.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2021 03.23, Tony Lindgren wrote:
> * Hector Martin <marcan@marcan.st> [210215 12:18]:
>> This allows the devicetree to correctly represent the available set of
>> timers, which varies from device to device, without the need for fake
>> dummy interrupts for unavailable slots.
> 
> I like the idea of using interrupt-names property for mapping timers :)
> 
> Similar approach might help other SoCs too. And clocksources never really
> had similar issues.

Yeah, there are some SoCs using dummy IRQs right now for this reason, so 
this should help with those too (though it's too late to introduce it 
now into those DTs without breaking backwards-compat with older kernels, 
sadly).

> With Marc's comments addressed, please feel free to add:
> 
> Reviewed-by: Tony Lindgren <tony@atomide.com>

Thank you!

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
