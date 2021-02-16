Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6812631C998
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 12:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhBPLW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 06:22:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:38414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229807AbhBPLWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 06:22:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 586E964DEC;
        Tue, 16 Feb 2021 11:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613474482;
        bh=sGdysOLwQ/vMTi6/cVtKA8MKh2ozaYEspwLLEkybZGg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TQYHRnVe7JndLjnuQU4eFOkLPlP7JYk78oQVaYcBjR7RNODDjKJyeAIgF5ahXUirA
         ApKGzblkY79ikREmqs8iyMl5FJEsBZkoQJI62CSiLMinyqqYqMUQraS/A7jVm5TiLZ
         lLyCWLoGhmOyF8Nexwqc+Cpwhb559ectSEdXwKP2wpjhIn2pFuct0MbkSdSHl04uKX
         FJoXYjyJK+sSFBYdOzMVMwTRfWDS02gjazD8cGT3yDjG2Xtkt+BDZJRO+uiawXmPrf
         3p4GIPNtBfuKs8MH3x3iEi4FEJZ5QYx2rjSYOI/vm6rqOGhB4aywkDNYne18WUPFk5
         b23sB6xz2QV5w==
Received: by mail-ot1-f51.google.com with SMTP id c16so8720140otp.0;
        Tue, 16 Feb 2021 03:21:22 -0800 (PST)
X-Gm-Message-State: AOAM530Y/CQy5G7fcilvMPQUGhWYYyz77PvQ71TKJcu5fB38IJ4zIWoy
        Jn5CWsEBFYettoogq4kvR0admroSvVM7U2CzOcc=
X-Google-Smtp-Source: ABdhPJyv2CYeHeZ1SBVRBNXR0A/V33lDQYMOTu+CjmWbeCC6//6Y/a53hTr8YDYVa3GMct6RQ8aW7uE7pDs+7W78NRw=
X-Received: by 2002:a05:6830:18e6:: with SMTP id d6mr15005260otf.251.1613474481601;
 Tue, 16 Feb 2021 03:21:21 -0800 (PST)
MIME-Version: 1.0
References: <20210215121713.57687-1-marcan@marcan.st> <20210215121713.57687-15-marcan@marcan.st>
 <CAK8P3a3rGurSQBubZ8i4+OHpDgM8mOfXiC6UhDYmL0MSQK4BRA@mail.gmail.com> <c1bc451789d233df@bloch.sibelius.xs4all.nl>
In-Reply-To: <c1bc451789d233df@bloch.sibelius.xs4all.nl>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 16 Feb 2021 12:21:05 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2pOUWqZjuk3PcBSsy9b3qv1D_1LiBH62bmTr7Uusp90A@mail.gmail.com>
Message-ID: <CAK8P3a2pOUWqZjuk3PcBSsy9b3qv1D_1LiBH62bmTr7Uusp90A@mail.gmail.com>
Subject: Re: [PATCH v2 14/25] dt-bindings: interrupt-controller: Add DT
 bindings for apple-aic
To:     Mark Kettenis <mark.kettenis@xs4all.nl>
Cc:     Hector Martin <marcan@marcan.st>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 12:00 PM Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> > From: Arnd Bergmann <arnd@kernel.org>
> > Date: Tue, 16 Feb 2021 10:41:11 +0100
> >
> > On Mon, Feb 15, 2021 at 1:17 PM Hector Martin <marcan@marcan.st> wrote:
> > > +
> > > +      The 2nd cell contains the interrupt number.
> > > +        - HW IRQs: interrupt number
> > > +        - FIQs:
> > > +          - 0: physical HV timer
> > > +          - 1: virtual HV timer
> > > +          - 2: physical guest timer
> > > +          - 3: virtual guest timer
> >
> > I wonder if you could just model the FIQ as a single shared level interrupt
> > (which is essentially what it is), and have every driver that uses it do a
> > request_irq() on the same IRQ number.
> >
> > This would avoid having to come up with a fake binding for it, and simplify
> > the implementation that then no longer has to peek into each interrupt
> > source.
>
> That would tie the binding more closely to the implementation as it
> would remove the option of peeking at the interrupt source.

I don't think having the binding match the implementation is a bad thing ;-)

If a future SoC variant handles it differently, it will need a binding update
anyway.

> And wouldn't it mean that the arch_timer driver would need to know whether
> the interrupt is shared or not?

Indeed, it does require each driver to pass IRQF_SHARED, and be
prepared to be called when no irq is pending (returning IRQ_NONE
otherwise), so a downside would be that this requires changing the
bindings for the timer and anything else that ends up using FIQ
later. It may be possible to just always pass IRQF_SHARED when
registering the arch timer handler, not sure if there are any downsides
in case for the normal (non-shared) case.

This is a drawback, but I still find it a little cleaner than having to
encode information about the individual irq sources into the irqchip
driver.

      Arnd
