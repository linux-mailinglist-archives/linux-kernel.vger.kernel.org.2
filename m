Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C3131C052
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 18:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbhBORR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 12:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbhBOP6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 10:58:16 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4EDC061786;
        Mon, 15 Feb 2021 07:57:36 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id B87384216C;
        Mon, 15 Feb 2021 15:57:29 +0000 (UTC)
To:     gregkh <gregkh@linuxfoundation.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        DTML <devicetree@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stan Skowronek <stan@corellium.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Arnd Bergmann <arnd@kernel.org>
References: <20210215121713.57687-1-marcan@marcan.st>
 <CAK8P3a1bXiWcieqTSZARN+to=J5RjC2cwbn_8ZOCYw2hhyyBYw@mail.gmail.com>
 <YCp1p1tRHF6OyR0C@kroah.com>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v2 00/25] Apple M1 SoC platform bring-up
Message-ID: <7c8bcf79-233b-7ea8-4fea-2fb29ca430ef@marcan.st>
Date:   Tue, 16 Feb 2021 00:57:27 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YCp1p1tRHF6OyR0C@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/2021 22.22, gregkh wrote:
> On Mon, Feb 15, 2021 at 01:57:39PM +0100, Arnd Bergmann wrote:
>> (adding maintainers for the serial/irqchip/clocksource drivers and
>> arch/arm64 to cc)
>>
>> I would suggest merging it together as a series through the soc tree for
>> v5.13, once each patch has been reviewed by the respective subsystem
>> maintainers, with possible add-on patches on the same branch for
>> additional drivers that may become ready during the 5.12-rc cycle.
>> After the initial merge, driver patches will of course go through subsystem
>> trees as normal.
>>
>> Let me know if that works for everyone.
> 
> Sure, as long as the maintainers get to see the patches, I don't think
> I've seen the serial ones at all...

Sorry, I figured Krzysztof would take a look at it first and I didn't 
want to spam too much. I'm still getting used to figuring out who to CC...

Do you want to take a look at v2, or wait for v3?

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
