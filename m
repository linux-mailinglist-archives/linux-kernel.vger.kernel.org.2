Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86484313D5E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbhBHSYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbhBHPsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:48:52 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD72C061786;
        Mon,  8 Feb 2021 07:48:11 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 9F3BA4207F;
        Mon,  8 Feb 2021 15:48:07 +0000 (UTC)
Subject: Re: [PATCH 11/18] arm64: Kconfig: Require FIQ support for ARCH_APPLE
To:     Marc Zyngier <maz@kernel.org>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
References: <20210204203951.52105-1-marcan@marcan.st>
 <20210204203951.52105-12-marcan@marcan.st> <87ft29kxmp.wl-maz@kernel.org>
 <860b7dac-ccad-b6c9-c7be-537d6b1c5ede@marcan.st>
 <2a93bf0df74df8cb022e61d69d1de88e@kernel.org>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <4ed0001c-2196-5e54-9de0-e77236b2a306@marcan.st>
Date:   Tue, 9 Feb 2021 00:48:05 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <2a93bf0df74df8cb022e61d69d1de88e@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2021 21.05, Marc Zyngier wrote:
>> I was trying to introduce the Kconfig before the code that depends on
>> it; is it kosher to have it in the other order, looking for CONFIG_
>> defines that don't exist yet?
> 
> Absolutely. The only requirement is to make sure that nothing breaks in
> the middle of a series.
> 
>> Though in this case the only user earlier in the series is the Samsung
>> stuff, which doesn't care about FIQs, so I can just sort things as
>> FIQ->ARCH_APPLE->samsung->AIC...
> 
> Seems fine to me. Sorting out the infrastructure first (FIQ, memory
> attributes) first is a requirement anyway, so the ordering of the
> series could reflect that priority.

Cool, that simplifies things.

>> I'm not sure about AIC vs. ARCH_APPLE though. Right now the pattern is
>> that AIC depends on ARCH_APPLE and also defaults to that. But then you
>> can build with ARCH_APPLE and AIC disabled if you so choose, which
>> does result in a broken system on these machines. AIC should build
>> without ARCH_APPLE (as long as we're on ARM64), so we could reverse
>> that.
> 
> As long as ARCH_APPLE selects AIC, you can make AIC selectable on
> its own. What I'm trying to avoid is people ending up with an unbootable
> system, and not having interrupts is one thing that makes it really hard
> to debug...

Sounds good, I'll flip it over.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
