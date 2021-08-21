Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECDE3F3977
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 10:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbhHUIFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 04:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbhHUIFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 04:05:34 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DEBC061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 01:04:55 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id k5-20020a05600c1c85b02902e699a4d20cso7393137wms.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 01:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uh9vOjxCEuetWpRRMkkr6kHfMZciZ9fURucTYmDUTL8=;
        b=IwgXBSK+Mel+gBYnvHhL7cY3ZZ1QNwTx5yqkXhwcXaMAIj+b1sO6PpgUJ+HiFEXCfW
         MphKwZIJAIUV4joaxRNP9+Iwws2iaxRFaQDwCJSU13lcunb6rMpr4H1mO9zf3JqWMWpT
         iJDp1sc1ZrFIAOuZngGwENJEuB6UljmStVCdIgGXFPNRn79KR0UzVCa85dPnbZnZNIkE
         Tg8qkR6TVm13X/PP+t+mS5e78/D6uX+Ho7qP5DA6ddlVA30pGMS8M4dUYV+y3/A6uKjU
         9H3LWUBt4gUAVDArw/1XvQ/3MgO7NX9F7O2mY5NTg+jYpV/inYYeSy1eVkZtrrnwjnsn
         dhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uh9vOjxCEuetWpRRMkkr6kHfMZciZ9fURucTYmDUTL8=;
        b=EW/AV3eUrMQRPXSYGL6F1xqhE72KdrQN/GMi583huy5RZAl7GGN8/GcmpL2O7YuVIy
         geifMTTfBv1xMTnVtqtkRCcdP0dYS26syBC+H7Rq66SRtsto5mBl5R+Bs6SuMlfrHhf+
         V9VDOWeldLlidRfQonUPtWdhGxVJtCx+2ZKtLj6EfNJhijNIReG0MR4puUhOIpUCQq6L
         XeuOtKEeLfmeD3iW8Y54Rsrlzfu5ikvpSlmZSulK/f5+2oN0rGeN9OvDDcrFyMrAHTN4
         RYrrzGhw5HBJJFRFpJHNAV/Eda2sOIWqZ1/xPdBLYQif0/NSVjKMNvBT7iJIpTmbTtKs
         tmwA==
X-Gm-Message-State: AOAM530DfGJXKy4SM2yoe4WCG/QYOw5/yPDqKotagnQqGXmhrhAj0UBU
        tkz29jxctFiHqqgGaVUzumhpWV8eD/XgOw3L
X-Google-Smtp-Source: ABdhPJyBcD4ZZAsWImBN1aDFpC/I1JKu3AAOQA5rQlHznIwOqulyHAnLfTDvWG3upQHsJsFUI9iE4w==
X-Received: by 2002:a1c:f610:: with SMTP id w16mr1468014wmc.116.1629533092995;
        Sat, 21 Aug 2021 01:04:52 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:e7c:3055:aad:f62d? ([2a01:e34:ed2f:f020:e7c:3055:aad:f62d])
        by smtp.googlemail.com with ESMTPSA id j1sm2956333wrd.50.2021.08.21.01.04.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Aug 2021 01:04:52 -0700 (PDT)
Subject: Re: [PATCH 2/2] clocksource/drivers/fttmr010: Be stricter on IRQs
To:     Guenter Roeck <linux@roeck-us.net>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
        Joel Stanley <joel@jms.id.au>
References: <20210724224424.2085404-1-linus.walleij@linaro.org>
 <20210724224424.2085404-2-linus.walleij@linaro.org>
 <20210821042010.GA1759866@roeck-us.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d5e8d6f3-52e0-4393-b6f2-0c5bce8fc810@linaro.org>
Date:   Sat, 21 Aug 2021 10:04:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210821042010.GA1759866@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/2021 06:20, Guenter Roeck wrote:
> Hi,
> 
> On Sun, Jul 25, 2021 at 12:44:24AM +0200, Linus Walleij wrote:
>> Make sure we check that the right interrupt occurred before
>> calling the event handler for timer 1. Report spurious IRQs
>> as IRQ_NONE.
>>
>> Cc: Cédric Le Goater <clg@kaod.org>
>> Cc: Joel Stanley <joel@jms.id.au>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> This patch results in boot stalls with several qemu aspeed emulations
> (quanta-q71l-bmc, palmetto-bmc, witherspoon-bmc, ast2500-evb,
> romulus-bmc, g220a-bmc). Reverting this patch together with
> "clocksource/drivers/fttmr010: Clear also overflow bit on AST2600"
> fixes the problem. Bisect log is attached.

Thanks Guenter for git-bisecting.

Linus I have dropped the aforementioned patches.

Thanks

  -- Daniel

> ---
> # bad: [86ed57fd8c93fdfaabb4f58e78455180fa7d8a84] Add linux-next specific files for 20210820
> # good: [7c60610d476766e128cc4284bb6349732cbd6606] Linux 5.14-rc6
> git bisect start 'HEAD' 'v5.14-rc6'
> # good: [2b14a6beaaddc78bd4c7aeb0d94ef4d1ba708b7b] Merge remote-tracking branch 'crypto/master'
> git bisect good 2b14a6beaaddc78bd4c7aeb0d94ef4d1ba708b7b
> # good: [ecbc858174455ac847fb308ececc33ad408d2b3c] Merge remote-tracking branch 'tip/auto-latest'
> git bisect good ecbc858174455ac847fb308ececc33ad408d2b3c
> # bad: [7a307d6053886b8c05f897b4386365d0f556c2e9] Merge remote-tracking branch 'staging/staging-next'
> git bisect bad 7a307d6053886b8c05f897b4386365d0f556c2e9
> # bad: [b97ca8377c80f00f51767c249310ee37db949df4] Merge remote-tracking branch 'tty/tty-next'
> git bisect bad b97ca8377c80f00f51767c249310ee37db949df4
> # bad: [e83fe57c15b3a06707266e28590ee805920be987] Merge remote-tracking branch 'kvm/next'
> git bisect bad e83fe57c15b3a06707266e28590ee805920be987
> # good: [213605c149ff869a7206db53eefbee14fd22a78d] kcsan: selftest: Cleanup and add missing __init
> git bisect good 213605c149ff869a7206db53eefbee14fd22a78d
> # good: [049e1cd8365ea416016e21eb2c7d9ca553fc1dc7] KVM: x86: don't disable APICv memslot when inhibited
> git bisect good 049e1cd8365ea416016e21eb2c7d9ca553fc1dc7
> # bad: [c01ef7a90edfa8be6dc8aaa9e0bfdfe0eb7ea083] Merge remote-tracking branch 'irqchip/irq/irqchip-next'
> git bisect bad c01ef7a90edfa8be6dc8aaa9e0bfdfe0eb7ea083
> # good: [4513fb87e1402ad815912ec7f027eb17149f44ee] Merge branch irq/misc-5.15 into irq/irqchip-next
> git bisect good 4513fb87e1402ad815912ec7f027eb17149f44ee
> # bad: [dcc5fdc6b0f491a612ca372ad18d098103103bdb] Merge remote-tracking branch 'edac/edac-for-next'
> git bisect bad dcc5fdc6b0f491a612ca372ad18d098103103bdb
> # bad: [8903227aa72ce8c013e47b027be8e153e114bf19] clocksource/drivers/fttmr010: Be stricter on IRQs
> git bisect bad 8903227aa72ce8c013e47b027be8e153e114bf19
> # good: [be83c3b6e7b8ff22f72827a613bf6f3aa5afadbb] clocksource/drivers/sh_cmt: Fix wrong setting if don't request IRQ for clock source channel
> git bisect good be83c3b6e7b8ff22f72827a613bf6f3aa5afadbb
> # good: [ce9570657d45d6387a68d7f419fe70d085200a2f] clocksource/drivers/mediatek: Optimize systimer irq clear flow on shutdown
> git bisect good ce9570657d45d6387a68d7f419fe70d085200a2f
> # good: [3a95de59730eb9ac8dd6a367018f5653a873ecaa] clocksource/drivers/fttmr010: Pass around less pointers
> git bisect good 3a95de59730eb9ac8dd6a367018f5653a873ecaa
> # first bad commit: [8903227aa72ce8c013e47b027be8e153e114bf19] clocksource/drivers/fttmr010: Be stricter on IRQs
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
