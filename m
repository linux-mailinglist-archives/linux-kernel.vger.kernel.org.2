Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB6F320AFE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 15:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhBUOjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 09:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhBUOjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 09:39:04 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9143DC061574;
        Sun, 21 Feb 2021 06:38:24 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id BCB32425BE;
        Sun, 21 Feb 2021 14:38:18 +0000 (UTC)
To:     Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
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
 <20274436-7275-9734-5a07-d6da46b45c5f@marcan.st>
 <20210220191323.ugmzrtkvcxyqqolj@kozik-lap>
 <5a4b3d7095d1ec4be97ec154109632dc@kernel.org>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v2 20/25] tty: serial: samsung_tty: Use
 devm_ioremap_resource
Message-ID: <28128b77-87b4-3595-59fa-44600c5bdbc7@marcan.st>
Date:   Sun, 21 Feb 2021 23:38:16 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <5a4b3d7095d1ec4be97ec154109632dc@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/2021 04.17, Marc Zyngier wrote:
> On 2021-02-20 19:13, Krzysztof Kozlowski wrote:
>> On Thu, Feb 18, 2021 at 11:01:21PM +0900, Hector Martin wrote:
>>> On 16/02/2021 03.51, Krzysztof Kozlowski wrote:
>>>>> Also fix a bug checking the return value, which should use IS_ERR().
>>>>
>>>> No, no, no. We never, never combine fixing bugs with some rework.
>>>> However devm_ioremap() returns NULL so where is the error?
>>>
>>> Sorry, this was a commit message mistake. The code is correct and so
>>> is the
>>> patch: just the NULL check is correct for the previous variant and
>>> IS_ERR is
>>> correct for devm_ioremap_resource. I confused myself while writing the
>>> commit message after the fact.
>>>
>>>> Did you test your patches on existing platforms? If not, please mark all
>>>> of them as RFT on next submission, so Greg does not pick them too fast.
>>>
>>> I unfortunately don't have any Exynos devices where I could test the
>>> code (I
>>> have a couple but no serial connections, and I have no idea if mailine
>>> would
>>> run on them). I'll mark v3 as RFT.
>>
>> If you have one of Odroid boards with Exynos, then you can nicely test
>> Exynos. Others - depends, on board.
>> Anyway I can test them for you. I just want to be sure that Greg waits
>> for this testing.
> 
> Worse case, QEMU has some Exynos4210 emulation that is usable.

That's a good point; better than nothing, certainly.

Does anyone have a known good example of booting an exynos kernel under 
qemu? I tried building a plain 5.11 arm exynos_defconfig and booting it, 
but without much luck:

$ qemu-system-arm -kernel arch/arm/boot/zImage -append 
"console=ttySAC0,115200n8 debug" -dtb 
arch/arm/boot/dts/exynos4210-universal_c210.dtb -nographic -serial 
mon:stdio -M smdkc210 -smp 2

(I also tried without the -dtb option, in case qemu provides something 
usable)

Of course I'll still mark v3 as RFT, I just thought I might as well try 
qemu.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
