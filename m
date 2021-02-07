Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830A9312328
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 10:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhBGJYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 04:24:24 -0500
Received: from marcansoft.com ([212.63.210.85]:34428 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229611AbhBGJYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 04:24:16 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 58C4142852;
        Sun,  7 Feb 2021 09:23:30 +0000 (UTC)
To:     Marc Zyngier <maz@kernel.org>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
References: <20210204203951.52105-1-marcan@marcan.st>
 <20210204203951.52105-12-marcan@marcan.st> <87ft29kxmp.wl-maz@kernel.org>
From:   Hector Martin 'marcan' <marcan@marcan.st>
Subject: Re: [PATCH 11/18] arm64: Kconfig: Require FIQ support for ARCH_APPLE
Message-ID: <860b7dac-ccad-b6c9-c7be-537d6b1c5ede@marcan.st>
Date:   Sun, 7 Feb 2021 18:23:28 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87ft29kxmp.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2021 00.46, Marc Zyngier wrote:
>>   config ARCH_APPLE
>>   	bool "Apple Silicon SoC family"
>>   	select GENERIC_IRQ_CHIP
>> +	select ARM64_FIQ_SUPPORT
> 
> Ah, this is what I was expecting in the previous patch. I guess the
> initial ARCH_APPLE patch could be moved down the line and add all the
> dependencies in one go.

I was trying to introduce the Kconfig before the code that depends on 
it; is it kosher to have it in the other order, looking for CONFIG_ 
defines that don't exist yet?

Though in this case the only user earlier in the series is the Samsung 
stuff, which doesn't care about FIQs, so I can just sort things as 
FIQ->ARCH_APPLE->samsung->AIC...

I'm not sure about AIC vs. ARCH_APPLE though. Right now the pattern is 
that AIC depends on ARCH_APPLE and also defaults to that. But then you 
can build with ARCH_APPLE and AIC disabled if you so choose, which does 
result in a broken system on these machines. AIC should build without 
ARCH_APPLE (as long as we're on ARM64), so we could reverse that.

-- 
Hector Martin "marcan" (marcan@marcan.st)
Public Key: https://mrcn.st/pub
