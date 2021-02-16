Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7EE31C94E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 12:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhBPLDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 06:03:45 -0500
Received: from sibelius.xs4all.nl ([83.163.83.176]:64022 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbhBPLBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 06:01:18 -0500
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id 397eb703;
        Tue, 16 Feb 2021 12:00:32 +0100 (CET)
Date:   Tue, 16 Feb 2021 12:00:32 +0100 (CET)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     marcan@marcan.st, linux-arm-kernel@lists.infradead.org,
        maz@kernel.org, robh@kernel.org, olof@lixom.net, krzk@kernel.org,
        tony@atomide.com, mohamed.mediouni@caramail.com,
        stan@corellium.com, graf@amazon.com, will@kernel.org,
        linus.walleij@linaro.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <CAK8P3a3rGurSQBubZ8i4+OHpDgM8mOfXiC6UhDYmL0MSQK4BRA@mail.gmail.com>
        (message from Arnd Bergmann on Tue, 16 Feb 2021 10:41:11 +0100)
Subject: Re: [PATCH v2 14/25] dt-bindings: interrupt-controller: Add DT
 bindings for apple-aic
References: <20210215121713.57687-1-marcan@marcan.st> <20210215121713.57687-15-marcan@marcan.st> <CAK8P3a3rGurSQBubZ8i4+OHpDgM8mOfXiC6UhDYmL0MSQK4BRA@mail.gmail.com>
Message-ID: <c1bc451789d233df@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Arnd Bergmann <arnd@kernel.org>
> Date: Tue, 16 Feb 2021 10:41:11 +0100
> 
> On Mon, Feb 15, 2021 at 1:17 PM Hector Martin <marcan@marcan.st> wrote:
> > +
> > +      The 2nd cell contains the interrupt number.
> > +        - HW IRQs: interrupt number
> > +        - FIQs:
> > +          - 0: physical HV timer
> > +          - 1: virtual HV timer
> > +          - 2: physical guest timer
> > +          - 3: virtual guest timer
> 
> I wonder if you could just model the FIQ as a single shared level interrupt
> (which is essentially what it is), and have every driver that uses it do a
> request_irq() on the same IRQ number.
> 
> This would avoid having to come up with a fake binding for it, and simplify
> the implementation that then no longer has to peek into each interrupt
> source.

That would tie the binding more closely to the implementation as it
would remove the option of peeking at the interrupt source.  And
wouldn't it mean that the arch_timer driver would need to know whether
the interrupt is shared or not?
