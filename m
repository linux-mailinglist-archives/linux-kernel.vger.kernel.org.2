Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929D9458653
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 21:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbhKUUgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 15:36:40 -0500
Received: from polaris.svanheule.net ([84.16.241.116]:57380 "EHLO
        polaris.svanheule.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbhKUUgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 15:36:39 -0500
Received: from [IPv6:2a02:a03f:eafe:c901:8dd6:f03a:3dd2:dc7c] (unknown [IPv6:2a02:a03f:eafe:c901:8dd6:f03a:3dd2:dc7c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id AD43C2750D9;
        Sun, 21 Nov 2021 21:33:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1637526812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OtKz2p3bD/VRFZoE4PO3xM0gWar2Rm6PoLYiB2fSElM=;
        b=hn2eAFdwxggT9JbmN0XErMBhcATzSR+iGFnk6fr3NqpnK2ls/1fmQpfqh8WQWvDEUizOM+
        7Zk215lM9izzzXgUT8uKoJrv3n95VV3M9Fm+0cvDPYoP3BDO3pqGerPhul3l8IXmFoZK84
        OfNexTIqDnJv7SlcdJ9JogPhyET2iO3bXwoKRpRz931TgsfT45DcW+90e6NUpEzw2xYWFm
        SruY8hel63Y5BnWZPIoIVOsRbz/zL3xWyZLgjac7xy/BTc2IXtxapMKw6eQiLWpk0oSF7F
        o8ocbzXl168Qs40MZnRhAXA2/JAzdGDxHNsh8tCcYF03teqKi0bfhgE2YtBjTw==
Message-ID: <763394a6e5c83006eb4628a9d0242b7eb04b889d.camel@svanheule.net>
Subject: Re: realtek,rtl-intc IRQ mapping broken on 5.16-rc1
From:   Sander Vanheule <sander@svanheule.net>
To:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Birger Koblitz <mail@birger-koblitz.de>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Date:   Sun, 21 Nov 2021 21:33:28 +0100
In-Reply-To: <877dd46w2b.wl-maz@kernel.org>
References: <bbe5506a2458b2d6049bd22a5fda77ae6175ddec.camel@svanheule.net>
         <87ilwp6zm6.wl-maz@kernel.org>
         <fdfe6615a0ec0d4a770b04a437922956e8586078.camel@svanheule.net>
         <877dd46w2b.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc, Rob, Birger,

On Fri, 2021-11-19 at 14:48 +0000, Marc Zyngier wrote:
> On Thu, 18 Nov 2021 19:45:26 +0000,
> Sander Vanheule <sander@svanheule.net> wrote:
> > 
> > Hi Marc,
> > 
> > On Thu, 2021-11-18 at 19:19 +0000, Marc Zyngier wrote:
> > > Hi Sander,
> > > 
> > > On Thu, 18 Nov 2021 15:56:06 +0000,
> > > Sander Vanheule <sander@svanheule.net> wrote:
> > > > 
> > > > Hi everyone,
> > > > 
> > > > On 5.16-rc1, the realtek,rtl-intc interrupt controller driver for
> > > > Realtek RTL8380 SoCs (and related) appears broken. When booting, I
> > > > don't get a tty on the serial port, although serial output works.
> > > 
> > > Thanks for the heads up.
> > > 
> > > > The watchdog (currently under review) also cannot acquire the
> > > > required phase1 interrupt, and produces the following output:
> > > 
> > > > [    1.968228] realtek-otto-watchdog 18003150.watchdog: error -EINVAL:
> > > > Failed to get
> > > > IRQ 4
> > > > for phase1
> > > > [    1.978404] realtek-otto-watchdog: probe of 18003150.watchdog failed
> > > > with error -
> > > > 22
> > > > 
> > > > A bisects points to commit 041284181226 ("of/irq: Allow matching of
> > > > an interrupt-map local to an interrupt controller"). Reverting this
> > > > above commit and follow-up commit 10a20b34d735 ("of/irq: Don't
> > > > ignore interrupt-controller when interrupt-map failed") restores the
> > > > functionality from v5.15.
> > > 
> > > OK, back to square one, we need to debug this one.
> > > 
> > > [...]
> > > 
> > > >         cpuintc: cpuintc {
> > > >                 compatible = "mti,cpu-interrupt-controller";
> > > >                 #address-cells = <0>;
> > > >                 #interrupt-cells = <1>;
> > > >                 interrupt-controller;
> > > >         };
> > > > 
> > > 
> > > [...]
> > > 
> > > > 
> > > >                 intc: interrupt-controller@3000 {
> > > >                         compatible = "realtek,rtl-intc";
> > > >                         reg = <0x3000 0x20>;
> > > >                         interrupt-controller;
> > > >                         #interrupt-cells = <1>;
> > > > 
> > > >                         #address-cells = <0>;
> > > >                         interrupt-map =
> > > >                                 <31 &cpuintc 2>, /* UART0 */
> > > >                                 <20 &cpuintc 3>, /* SWCORE */
> > > >                                 <19 &cpuintc 4>, /* WDT IP1 */
> > > >                                 <18 &cpuintc 5>; /* WDT IP2 */
> > > >                 };
> > > 
> > > Something looks pretty odd. With 5.15, this interrupt-map would be
> > > completely ignored. With 5.16-rc1, we should actually honour it.
> > > 
> > > /me digs...
> > > 
> > > Gah, I see. This driver has its own interrupt-map parser and invents
> > > something out of thin air. I will bang my own head on the wall for
> > > having merged this horror.
> > > 
> > > Can you try applying the patch below and rename the interrupt-map
> > > property in your DT to "silly-interrupt-map" and let me know if that
> > > helps?
> > 
> > I've dropped the aforementioned reverts, and applied your suggested
> > changes to the DTS and irq-realtek-rtl. Interrupts now appear to
> > work like before; UART console and watchdog work as expected.
> 
> Right. So here's the problem: what this interrupt-map property means
> is "an interrupt descriptor with value 31 really is interrupt 2 on
> cpuintc, and nothing else matters(tm)". Up to 5.15, the kernel would
> simply ignore such directive. It now honours it.

At the time we were working on this driver, we were searching for a way to
implement the SoC-to-CPU interrupt mapping. "interrupt-map" seemed like a good
match. Looking back at the DT spec, my understanding now that it should only be
used for one-to-one mappings, like Marc noted.

Just to be clear, I'm not the expert on this platform's interrupt handling, but
I would like to provide some extra context. Since we don't have any proper
documentation, I've been looking at the SDK today to understand how the mapping
works.

Currently the mapping is written in the DT as:
<SOC_IRQ &cpuintc IRR_VALUE>.
The SDK only ever sets IRR values 1-5. As for the other values:
 * 0 doesn't appear to trigger anything,
 * 6 results in unhandled interrupts on IRQ #7 (MIPS R4K timer),
 * 7 causes the timer to be unable to claim its interrupt (because this driver
   already took it?).

The IRR_VALUE is currently translated literaly to a CPU IRQ, but it appears that
this is wrong. The SDK code for u-boot maps IRR values of {4,5} to respectively
CAUSEF_IP{5,6}. I think the IRR values should be seen as interrupt priorities,
rather than as literal parent interrupts.

Maybe the following would be an option:

   intc: interrupt-controller@3000 {
   compatible = "realtek,rtl-intc";
   reg = <0x3000 0x20>;
   #interrupt-cells = <2>; # [SoC interrupt index, interrupt priority]
   
   interrupt-parent = <&cpuintc>;
   # Optionally add "priority6" if the R4K timer is not used
   interrupt-names = "priority1", "priority2", "priority3",
   "priority4", "priority5";
   # Optionally add <7> if the R4K timer is not used
   interrupts = <2>, <3>, <4>, <5>, <6>;
   };
   
   serial@2000 {
   ...
   
   # Use SoC interrupt 31 from intc, with priority 2
   interrupt-parent = <&intc>
   interrupts = <31 2>;
   };

Although I'm not sure how well this would extend to a CPU with two threads and
matching interrupt controllers, while still being able to perform irq balancing.

> 
> There are only three solution to this:
> 
> (1) we change the DT and the driver so that it actually describes the
> HW rather than some crazy interpretation. This means breaking backward
> compatibility with older kernels on new DT, as well as new kernels on
> old DTs.
> 
> (2) we add a quirk to the core DT parsing code to ignore an
> interrupt-map property placed in a "realtek,rtl-intc" node.

> (3) we revert the change and break the Apple M1.
> 
> I'm obviously not keen on (3). I can (sort of) deal with (2), but I'd
> rather do (1) because what currently is in the DT doesn't describe the
> HW in any shape or form.

I don't feel we should be breaking other people's shiny new toys either :-)

As far as I know most (all) users come via OpenWrt, using backported patches. DT
sources are also in the OpenWrt tree, so we could convert in one patch series
with minimal breakage. The devices themselves don't provide any binary DT, so
that's not really an issue. If there's time and this is within the scope of
patches for an RC, I would prefer (1). Otherwise we could wait like Birger
suggested, until we have a better understaning of how to work with SMT, and do
(2) in the meantime.

Alternatively, a second compatible could perhaps be introduced and the current
one would be deprecated, using (2) to prevent breaking 5.16+ kernels. I don't
think that's really worth the effort though.

Best,
Sander
