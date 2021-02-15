Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5E731BC1F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 16:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhBOPS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 10:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbhBOPOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 10:14:33 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5344C061574;
        Mon, 15 Feb 2021 07:13:52 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 9357A419B4;
        Mon, 15 Feb 2021 15:13:46 +0000 (UTC)
Subject: Re: [PATCH v2 06/25] arm64: arch_timer: implement support for
 interrupt-names
To:     Marc Zyngier <maz@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, Alexander Graf <graf@amazon.com>,
        Olof Johansson <olof@lixom.net>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Mark Kettenis <mark.kettenis@xs4all.nl>
References: <20210215121713.57687-1-marcan@marcan.st>
 <20210215121713.57687-7-marcan@marcan.st> <87tuqdpije.wl-maz@kernel.org>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <152b52a4-b035-a416-4a78-f7fc7c970e95@marcan.st>
Date:   Tue, 16 Feb 2021 00:13:44 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87tuqdpije.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/2021 22.28, Marc Zyngier wrote:
> nit: I'd prefer it if the array was described as:
> 
> 	[ARCH_TIMER_PHYS_SECURE_PPI] = "phys-secure",
> 	[...]
> 
> just to avoid that the two get out of sync.

Good point, changed it for v3.

>>   
>> -	arch_timers_present |= ARCH_TIMER_TYPE_CP15;
> 
> You probably didn't want to drop this line, did you?

Ouch. Thanks for catching that.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
