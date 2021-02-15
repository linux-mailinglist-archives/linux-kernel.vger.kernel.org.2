Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F2831C0BC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 18:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhBORiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 12:38:02 -0500
Received: from marcansoft.com ([212.63.210.85]:59966 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231474AbhBOQzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 11:55:19 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 2E39F419B4;
        Mon, 15 Feb 2021 16:54:26 +0000 (UTC)
To:     gregkh <gregkh@linuxfoundation.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Stan Skowronek <stan@corellium.com>
References: <20210215121713.57687-1-marcan@marcan.st>
 <CAK8P3a1bXiWcieqTSZARN+to=J5RjC2cwbn_8ZOCYw2hhyyBYw@mail.gmail.com>
 <YCp1p1tRHF6OyR0C@kroah.com> <7c8bcf79-233b-7ea8-4fea-2fb29ca430ef@marcan.st>
 <YCqdi/5TSlbt0w/2@kroah.com>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v2 00/25] Apple M1 SoC platform bring-up
Message-ID: <e77a02eb-8493-14f0-f71c-a15646324d19@marcan.st>
Date:   Tue, 16 Feb 2021 01:54:25 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YCqdi/5TSlbt0w/2@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2021 01.12, gregkh wrote:
> On Tue, Feb 16, 2021 at 12:57:27AM +0900, Hector Martin wrote:
>> On 15/02/2021 22.22, gregkh wrote:
>>> On Mon, Feb 15, 2021 at 01:57:39PM +0100, Arnd Bergmann wrote:
>>>> (adding maintainers for the serial/irqchip/clocksource drivers and
>>>> arch/arm64 to cc)
>>>>
>>>> I would suggest merging it together as a series through the soc tree for
>>>> v5.13, once each patch has been reviewed by the respective subsystem
>>>> maintainers, with possible add-on patches on the same branch for
>>>> additional drivers that may become ready during the 5.12-rc cycle.
>>>> After the initial merge, driver patches will of course go through subsystem
>>>> trees as normal.
>>>>
>>>> Let me know if that works for everyone.
>>>
>>> Sure, as long as the maintainers get to see the patches, I don't think
>>> I've seen the serial ones at all...
>>
>> Sorry, I figured Krzysztof would take a look at it first and I didn't want
>> to spam too much. I'm still getting used to figuring out who to CC...
> 
> scripts/get_maintainer.pl is your friend.

It's the additional step of figuring out who to include from 
get_maintainer.pl output, and whether any subsetting is warranted at 
all, that I'm finding less well documented... :-)

(In particular for a bring-up series such as this one, where most people 
are only concerned with a few patches... but maybe I'm just overthinking 
things)

>> Do you want to take a look at v2, or wait for v3?
> 
> v3 is fine, I can't do anything until after 5.12-rc1 is out anyway.

Got it, thanks!

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
