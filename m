Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B751C31BA48
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 14:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhBON0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 08:26:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:38100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230160AbhBONXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 08:23:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3AE0A64DF0;
        Mon, 15 Feb 2021 13:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613395370;
        bh=FhCmQwKltXlewXN8BYTXPAp/o1kYguxQ89M5HonSGq4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FM1/iqq3ZHy2ksIoZWnwxxgAw6yOwiqBR01KLjivOn3iN2GKRSPLIPyZlMN4N6Dce
         zWAQkeJe2oYvpa/UX1jQkKRQBznYnNm5ulGqCrmM7BYrwSQu8WLpZiqdINQ9QkUQep
         ey4Dq+7oJg0WqYWc+SmhIdimBalErLKU+OPKzG34=
Date:   Mon, 15 Feb 2021 14:22:47 +0100
From:   gregkh <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
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
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 00/25] Apple M1 SoC platform bring-up
Message-ID: <YCp1p1tRHF6OyR0C@kroah.com>
References: <20210215121713.57687-1-marcan@marcan.st>
 <CAK8P3a1bXiWcieqTSZARN+to=J5RjC2cwbn_8ZOCYw2hhyyBYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1bXiWcieqTSZARN+to=J5RjC2cwbn_8ZOCYw2hhyyBYw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 01:57:39PM +0100, Arnd Bergmann wrote:
> On Mon, Feb 15, 2021 at 1:16 PM Hector Martin <marcan@marcan.st> wrote:
> >
> > This series brings up initial support for the Apple M1 SoC, used in the
> > 2020 Mac Mini, MacBook Pro, and MacBook Air models.
> >
> > The following features are supported in this initial port:
> >
> > - UART (samsung-style) with earlycon support
> > - Interrupts, including affinity and IPIs (Apple Interrupt Controller)
> > - SMP (through standard spin-table support)
> > - simplefb-based framebuffer
> > - Devicetree for the Mac Mini (should work for the others too at this
> >   stage)
> 
> I am essentially happy with the state of this series, the comments I had
> in v1 by email and IRC are all addressed, but of course with the timing
> during the merge window, it is not going to be in v5.12.
> 
> (adding maintainers for the serial/irqchip/clocksource drivers and
> arch/arm64 to cc)
> 
> I would suggest merging it together as a series through the soc tree for
> v5.13, once each patch has been reviewed by the respective subsystem
> maintainers, with possible add-on patches on the same branch for
> additional drivers that may become ready during the 5.12-rc cycle.
> After the initial merge, driver patches will of course go through subsystem
> trees as normal.
> 
> Let me know if that works for everyone.

Sure, as long as the maintainers get to see the patches, I don't think
I've seen the serial ones at all...
