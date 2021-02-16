Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37EDB31C91A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 11:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhBPKvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 05:51:21 -0500
Received: from marcansoft.com ([212.63.210.85]:34526 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229703AbhBPKvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 05:51:11 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 82C8D419B4;
        Tue, 16 Feb 2021 10:50:14 +0000 (UTC)
Subject: Re: [PATCH v2 23/25] tty: serial: samsung_tty: Add earlycon support
 for Apple UARTs
To:     Arnd Bergmann <arnd@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
References: <20210215121713.57687-1-marcan@marcan.st>
 <20210215121713.57687-24-marcan@marcan.st>
 <20210215191748.uhus2e6gclkwgjo5@kozik-lap>
 <CAK8P3a0YzRVa+fa_7xFxR8f+pwSCo5w5kuaPsSSQscR10jwPww@mail.gmail.com>
 <CAJKOXPc+j9F_TVq2ir0ehVvph96UgkjRRCK7Df4KR0tVgWOAng@mail.gmail.com>
 <CAK8P3a2mOCfVhR3aeey38sDudJovfz23OOMMHREd8bmy=9-5yw@mail.gmail.com>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <abc80b9b-ca18-cf37-61e7-44849ea086b2@marcan.st>
Date:   Tue, 16 Feb 2021 19:50:12 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2mOCfVhR3aeey38sDudJovfz23OOMMHREd8bmy=9-5yw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2021 19.29, Arnd Bergmann wrote:
> On Tue, Feb 16, 2021 at 11:20 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On Tue, 16 Feb 2021 at 11:19, Arnd Bergmann <arnd@kernel.org> wrote:
>>>>> +     return samsung_early_console_setup(device, opt);
>>>>
>>>> Don't you need to handle the error code - set PROT_DEFAULT() or whatever
>>>> was there before?
>>>
>>> __set_fixmap() has no return value, it just writes a page table entry and
>>> does not fail.
>>
>> I meant, handle samsung_early_console_setup() error code (NULL).
> 
> Ah, I see.
> 
> I don't think it makes a difference -- if ->setup() fails, the page table entry
> is just left in place unused, and the type of the unused mapping doesn't
> matter. If earlycon tried to unmap the page, the type also would not
> change anything.
> 
> With earlycon, I'd generally lean towards keeping things as simple as possible,
> in order to increase the chance of seeing anything at all. It clearly wouldn't
> hurt to try to add minimal error handling here.

There's no logic to clean this up in earlycon itself anyway, so there's 
no point in trying to do it for the override. If another earlycon driver 
ends up getting instantiated for some reason, it will override the 
mapping with a normal one again.


-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
