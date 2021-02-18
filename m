Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEFF31EC80
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 17:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbhBRQrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 11:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbhBROCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 09:02:19 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B64C061574;
        Thu, 18 Feb 2021 06:01:32 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id B9663419B4;
        Thu, 18 Feb 2021 14:01:23 +0000 (UTC)
Subject: Re: [PATCH v2 20/25] tty: serial: samsung_tty: Use
 devm_ioremap_resource
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
 <20210215121713.57687-21-marcan@marcan.st>
 <20210215185135.onivzktfscv5myh2@kozik-lap>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <20274436-7275-9734-5a07-d6da46b45c5f@marcan.st>
Date:   Thu, 18 Feb 2021 23:01:21 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210215185135.onivzktfscv5myh2@kozik-lap>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2021 03.51, Krzysztof Kozlowski wrote:
>> Also fix a bug checking the return value, which should use IS_ERR().
> 
> No, no, no. We never, never combine fixing bugs with some rework.
> However devm_ioremap() returns NULL so where is the error?

Sorry, this was a commit message mistake. The code is correct and so is 
the patch: just the NULL check is correct for the previous variant and 
IS_ERR is correct for devm_ioremap_resource. I confused myself while 
writing the commit message after the fact.

> Did you test your patches on existing platforms? If not, please mark all
> of them as RFT on next submission, so Greg does not pick them too fast.

I unfortunately don't have any Exynos devices where I could test the 
code (I have a couple but no serial connections, and I have no idea if 
mailine would run on them). I'll mark v3 as RFT.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
