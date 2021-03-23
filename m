Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701F434697C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 21:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbhCWUAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 16:00:52 -0400
Received: from sibelius.xs4all.nl ([83.163.83.176]:56918 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbhCWUAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 16:00:16 -0400
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id 7e6c98e9;
        Tue, 23 Mar 2021 21:00:12 +0100 (CET)
Date:   Tue, 23 Mar 2021 21:00:12 +0100 (CET)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     "Sven Peter" <sven@svenpeter.dev>
Cc:     iommu@lists.linux-foundation.org, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, robh+dt@kernel.org, arnd@kernel.org,
        marcan@marcan.st, maz@kernel.org, mohamed.mediouni@caramail.com,
        stan@corellium.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <d280843b-77e3-4fa8-9452-5a2f8a45052e@www.fastmail.com>
        (sven@svenpeter.dev)
Subject: Re: [PATCH 0/3] Apple M1 DART IOMMU driver
References: <20210320151903.60759-1-sven@svenpeter.dev>
 <c1bcc0609e920bc6@bloch.sibelius.xs4all.nl>
 <8360b3b3-296c-450d-abc3-bb47159bf4e1@www.fastmail.com>
 <c1bcc0be8ae6e500@bloch.sibelius.xs4all.nl> <d280843b-77e3-4fa8-9452-5a2f8a45052e@www.fastmail.com>
Message-ID: <c1bcca33753f71d3@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Mon, 22 Mar 2021 23:17:31 +0100
> From: "Sven Peter" <sven@svenpeter.dev>
> 
> Hi Mark,
> 
> On Sun, Mar 21, 2021, at 19:35, Mark Kettenis wrote:
> >
> > Guess we do need to understand a little bit better how the USB DART
> > actually works.  My hypothesis (based on our discussion on #asahi) is
> > that the XHCI host controller and the peripheral controller of the
> > DWC3 block use different DMA "streams" that are handled by the
> > different sub-DARTs.
> 
> I've done some more experiments and the situation is unfortunately more
> complicated: Most DMA transfers are translated with the first DART.
> But sometimes (and I have not been able to figure out the exact conditions)
> transfers instead have to go through the second DART. 
> This happens e.g. with one of my USB keyboards after a stop EP command
> is issued: Suddenly the xhci_ep_ctx struct must be translated through the
> second DART.
> 
> What this likely means is that we'll need to point both DARTs
> to the same pagetables and just issue the TLB maintenance operations
> as a group.
> 
> > 
> > The Corellium folks use a DART + sub-DART model in their driver and a
> > single node in the device tree that represents both.  That might sense
> > since the error registers and interrupts are shared.  Maybe it would
> > make sense to select the appropriate sub-DART based on the DMA stream
> > ID?
> 
> dwc3 specifically seems to require stream id #1 from the DART
> at <0x5 0x02f00000> and stream id #0 from the DART at <0x5 0x02f80000>.
> Both of these only share a IRQ line but are otherwise completely independent.
> Each has their own error registers, etc. and we need some way to
> specify these two DARTs + the appropriate stream ID.
> 
> Essentially we have three options to represent this now:
> 
> 1) Add both DARTs as separate regs, use #iommu-cells = <2> and have the
>    first cell select the DART and the second one the stream ID.
>    We could allow #iommu-cells = <1> in case only one reg is specified
>    for the PCIe DART:
> 
>    usb_dart1@502f00000 {
>      compatible = "apple,t8103-dart";
>      reg = <0x5 0x02f00000 0x0 0x4000>, <0x5 0x02f80000 0x0 0x4000>;
>      #iommu-cells = <2>;
>      ...
>    };
> 
>    usb1 {
>      iommus = <&usb_dart1 0 1>, <&usb_dart1 1 0>;
>      ...
>    };
> 
>    I prefer this option because we fully describe the DART in a single
>    device node here. It also feels natural to group them like this because
>    they need to share some properties (like dma-window and the interrupt)
>    anyway. 
> 
> 2) Create two DART nodes which share the same IRQ line and attach them
>    both to the master node:
> 
>    usb_dart1a@502f00000 {
>      compatible = "apple,t8103-dart";
>      reg = <0x5 0x02f00000 0x0 0x4000>;
>      #iommu-cells = <1>;
>      ...
>    };
>    usb_dart1b@502f80000 {
>      compatible = "apple,t8103-dart";
>      reg = <0x5 0x02f80000 0x0 0x4000>;
>      #iommu-cells = <1>;
>      ...
>    };
> 
>    usb1 {
>      iommus = <&usb_dart1a 1>, <&usb_dart1b 0>;
>      ...
>    };
> 
>    I dislike this one because attaching those two DARTs to a single device
>    seems rather unusual. We'd also have to duplicate the dma-window setting,
>    make sure it's the same for both DARTs and there are probably even more
>    complications I can't think of right now. It seems like this would also
>    make the device tree very verbose and the implementation itself more
>    complicated.
> 
> 3) Introduce another property and let the DART driver take care of
>    mirroring the pagetables. I believe this would be similar to
>    the sid-remap property:
> 
>    usb_dart1@502f00000 {
>      compatible = "apple,t8103-dart";
>      reg = <0x5 0x02f00000 0x0 0x4000>, <0x5 0x02f80000 0x0 0x4000>;
>      #iommu-cells = <1>;
>      sid-remap = <0 1>;
>    };
>    usb1 {
>      iommus = <&usb_dart1 0>;
>    };
> 
>    I slightly dislike this one because we now specify which stream id 
>    to use in two places: Once in the device node and another time in the
>    new property in the DART node. I also don't think the binding is much
>    simpler than the first one.

Hi Sven,

The problem with both #1 and #2 is that you end up with two references
to (effectively) different iommu's in the dwc3 device node.  I don't
see how that is compatible with the idea of using a single translation
table for both sub-DARTs.

If you no longer think that is desirable, you'll still have the
problem that you'll need to modify the dwc3 driver code such that it
uses the right IOMMU to do its DMA address translation.  Given what
you write above that sounds really ugly and confusing.  I would
certainly want to avoid doing that in OpenBSD.

So I think #3 is the only realistic option here.  In my opinion it is
perfectly fine for the devicetree to present a workable model of the
hardware instead of a 100% accurate model.

> > > where #dma-address-cells and #dma-size-cells default to
> > > #address-cells and #size-cells respectively if I understand
> > > the code correctly. That way we could also just always use
> > > a 64bit address and size in the DT, e.g.
> > > 
> > >   pcie_dart {
> > >       [ ... ]
> > >       dma-window = <0 0x100000 0 0x3fe00000>;
> > >       [ ... ]
> > >   };
> > 
> > That sounds like a serious contender to me!  Hopefully one of the
> > Linux kernel developers can give this some sort of blessing.
> > 
> > I think it would make sense for us to just rely on the #address-cells
> > and #size-cells defaults for the M1 device tree.
> >
> 
> Agreed.
> 
> 
> Best,
> 
> Sven
> 
