Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E4B45639D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 20:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbhKRTsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 14:48:32 -0500
Received: from polaris.svanheule.net ([84.16.241.116]:32786 "EHLO
        polaris.svanheule.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbhKRTsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 14:48:31 -0500
Received: from [IPv6:2a02:a03f:eafe:c901:baf4:d6c5:5600:301] (unknown [IPv6:2a02:a03f:eafe:c901:baf4:d6c5:5600:301])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id AA47827392C;
        Thu, 18 Nov 2021 20:45:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1637264730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hTg71gT4+sSOxaZJj0tu0X+/0mdwoiEc4gEID80RIMM=;
        b=k5l/w2mSnqHVRr/utbcyislFKhi2HMH8jKrrBIJFtn3PhA5TypA7dmA/xvf8Vl6lCC41by
        b7sgTKIF5RvtRUrBhxP1uulHAwY5Ej8goW0W1pKMubmRdDZeYRWSJ4kjse577z2mMu4MMP
        dMVY2IfWBds24uXAXEPLZ3/pxCVe5x6AJmeG+U23A4a1AHZQdBrKwlKT6ajAJBqKAvXCOx
        ezjRdh8f+h0E9WrWhjuo93qiahIXeml1vl/Y8rCE1n88qeDmLd1Id5pUxY2DLsOOcG6Hy+
        gxe9JYt66QOe9vAYelKIYuwzVDRfZNmFfadTuFbNDv/oanhOMSCxFliCTx61dQ==
Message-ID: <fdfe6615a0ec0d4a770b04a437922956e8586078.camel@svanheule.net>
Subject: Re: realtek,rtl-intc IRQ mapping broken on 5.16-rc1
From:   Sander Vanheule <sander@svanheule.net>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Birger Koblitz <mail@birger-koblitz.de>,
        Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Date:   Thu, 18 Nov 2021 20:45:26 +0100
In-Reply-To: <87ilwp6zm6.wl-maz@kernel.org>
References: <bbe5506a2458b2d6049bd22a5fda77ae6175ddec.camel@svanheule.net>
         <87ilwp6zm6.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Thu, 2021-11-18 at 19:19 +0000, Marc Zyngier wrote:
> Hi Sander,
> 
> On Thu, 18 Nov 2021 15:56:06 +0000,
> Sander Vanheule <sander@svanheule.net> wrote:
> > 
> > Hi everyone,
> > 
> > On 5.16-rc1, the realtek,rtl-intc interrupt controller driver for
> > Realtek RTL8380 SoCs (and related) appears broken. When booting, I
> > don't get a tty on the serial port, although serial output works.
> 
> Thanks for the heads up.
> 
> > The watchdog (currently under review) also cannot acquire the
> > required phase1 interrupt, and produces the following output:
> 
> > [    1.968228] realtek-otto-watchdog 18003150.watchdog: error -EINVAL: Failed to get
> > IRQ 4
> > for phase1
> > [    1.978404] realtek-otto-watchdog: probe of 18003150.watchdog failed with error -22
> > 
> > A bisects points to commit 041284181226 ("of/irq: Allow matching of
> > an interrupt-map local to an interrupt controller"). Reverting this
> > above commit and follow-up commit 10a20b34d735 ("of/irq: Don't
> > ignore interrupt-controller when interrupt-map failed") restores the
> > functionality from v5.15.
> 
> OK, back to square one, we need to debug this one.
> 
> [...]
> 
> >         cpuintc: cpuintc {
> >                 compatible = "mti,cpu-interrupt-controller";
> >                 #address-cells = <0>;
> >                 #interrupt-cells = <1>;
> >                 interrupt-controller;
> >         };
> > 
> 
> [...]
> 
> > 
> >                 intc: interrupt-controller@3000 {
> >                         compatible = "realtek,rtl-intc";
> >                         reg = <0x3000 0x20>;
> >                         interrupt-controller;
> >                         #interrupt-cells = <1>;
> > 
> >                         #address-cells = <0>;
> >                         interrupt-map =
> >                                 <31 &cpuintc 2>, /* UART0 */
> >                                 <20 &cpuintc 3>, /* SWCORE */
> >                                 <19 &cpuintc 4>, /* WDT IP1 */
> >                                 <18 &cpuintc 5>; /* WDT IP2 */
> >                 };
> 
> Something looks pretty odd. With 5.15, this interrupt-map would be
> completely ignored. With 5.16-rc1, we should actually honour it.
> 
> /me digs...
> 
> Gah, I see. This driver has its own interrupt-map parser and invents
> something out of thin air. I will bang my own head on the wall for
> having merged this horror.
> 
> Can you try applying the patch below and rename the interrupt-map
> property in your DT to "silly-interrupt-map" and let me know if that
> helps?

I've dropped the aforementioned reverts, and applied your suggested changes to the DTS and
irq-realtek-rtl. Interrupts now appear to work like before; UART console and watchdog work
as expected.

Best,
Sander

> 
> That's of course not the right fix, but that's just to confirm the
> extent of the damage...
> 
>         M.
> 
> diff --git a/drivers/irqchip/irq-realtek-rtl.c b/drivers/irqchip/irq-realtek-rtl.c
> index fd9f275592d2..3641cd2b1a2c 100644
> --- a/drivers/irqchip/irq-realtek-rtl.c
> +++ b/drivers/irqchip/irq-realtek-rtl.c
> @@ -114,7 +114,7 @@ static int __init map_interrupts(struct device_node *node, struct
> irq_domain *do
>         if (ret || tmp)
>                 return -EINVAL;
>  
> -       imap = of_get_property(node, "interrupt-map", &imaplen);
> +       imap = of_get_property(node, "silly-interrupt-map", &imaplen);
>         if (!imap || imaplen % 3)
>                 return -EINVAL;
>  
> 

