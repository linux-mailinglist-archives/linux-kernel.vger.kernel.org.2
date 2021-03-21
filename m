Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50AD5343416
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 19:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhCUSf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 14:35:28 -0400
Received: from sibelius.xs4all.nl ([83.163.83.176]:53067 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhCUSfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 14:35:07 -0400
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id 8ad311f2;
        Sun, 21 Mar 2021 19:35:04 +0100 (CET)
Date:   Sun, 21 Mar 2021 19:35:04 +0100 (CET)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     "Sven Peter" <sven@svenpeter.dev>
Cc:     iommu@lists.linux-foundation.org, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, robh+dt@kernel.org, arnd@kernel.org,
        marcan@marcan.st, maz@kernel.org, mohamed.mediouni@caramail.com,
        stan@corellium.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <8360b3b3-296c-450d-abc3-bb47159bf4e1@www.fastmail.com>
        (sven@svenpeter.dev)
Subject: Re: [PATCH 0/3] Apple M1 DART IOMMU driver
References: <20210320151903.60759-1-sven@svenpeter.dev>
 <c1bcc0609e920bc6@bloch.sibelius.xs4all.nl> <8360b3b3-296c-450d-abc3-bb47159bf4e1@www.fastmail.com>
Message-ID: <c1bcc0be8ae6e500@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Sun, 21 Mar 2021 18:22:15 +0100
> From: "Sven Peter" <sven@svenpeter.dev>
> 
> Hi Mark,
> 
>  On 21. Mar 2021, at 17:00, Mark Kettenis <mark.kettenis@xs4all.nl>
>  wrote:
> 
>  I don't think the first option is going to work for PCIe.  PCIe
>  devices will have to use "iommu-map" properties to map PCI devices to
>  the right iommu, and the currently implementation seems to assume that
>  #iommu-cells = <1>.  The devictree binding[1] doesn't explicitly state
>  that it relies on #iommu-cells = <1>, but it isn't clear how the
>  rid-base to iommu-base mapping mechanism would work when that isn't
>  the case.
> 
>  Now the PCIe DARTs are simpler and seem to have only one "instance"
>  per DART.  So if we keep #iommu-cells = <1> for those, you'd still be
>  fine using the first approach.
> 
> Good point, I guess that only leaves option two for now then.
> Having some DARTs use cells = <1> and others <2> sounds confusing to me.

Guess we do need to understand a little bit better how the USB DART
actually works.  My hypothesis (based on our discussion on #asahi) is
that the XHCI host controller and the peripheral controller of the
DWC3 block use different DMA "streams" that are handled by the
different sub-DARTs.

The Corellium folks use a DART + sub-DART model in their driver and a
single node in the device tree that represents both.  That might sense
since the error registers and interrupts are shared.  Maybe it would
make sense to select the appropriate sub-DART based on the DMA stream
ID?

>  As I mentioned before, not all DARTs support the full 32-bit aperture.
>  In particular the PCIe DARTs support a smaller address-space.  It is
>  not clear whether this is a restriction of the PCIe host controller or
>  the DART, but the Apple Device Tree has "vm-base" and "vm-size"
>  properties that encode the base address and size of the aperture.
>  These single-cell properties which is probably why for the USB DARTs
>  only "vm-base" is given; since "vm-base" is 0, a 32-bit number
>  wouldn't be able to encode the full aperture size.  We could make them
>  64-bit numbers in the Linux device tree though and always be explicit
>  about the size.  Older Sun SPARC machines used a single "virtual-dma"
>  property to encode the aperture.  We could do someting similar.  You
>  would use this property to initialize domain->geometry.aperture_start
>  and domain->geometry.aperture_end in diff 3/3 of this series.
> 
>  I think it would make sense to include this in this series, as this
>  would make adding support for PCIe very easy, and PCIe gives you
>  aupport for network (both wired and wireless) and the type-A USB ports
>  on the mini.
> 
> Agreed, I'd ideally like to converge on a device tree binding
> that won't have to change in the near future.
> 
> I've tried to use an address space larger than 32bit and that seems to
> work for parts of the dwc3 controller but breaks for the xhci parts because
> the upper lines don't seem to be connected there (e.g. if xhci tries to
> use <0x1 0xffff0000> I get a fault for <0 0xffff0000>).
> 
> Looking at other iommu drivers I have found the following two similar
> bindings:

Ah, missed those.

> qcom uses a ranges property with a 64bit address and 32 bit size [1]
> 
>   apps_iommu: iommu@1e20000 {
>       ...
>       ranges = <0 0x1e20000 0x40000>;
>       ...
>   };

Doesn't sound like a very good idea to me to repurpose "ranges" for
this...

> 
> and tegra seems to support a dma-window property with 32bit address
> and size [2]
> 
>   smmu {
>           [...]
>           dma-window = <0 0x40000000>;    /* IOVA start & length */
>           [...]
>   };
> 
> I believe there already is of_get_dma_window to handle parsing this
> in the common iommu code [3] but I can't find any place using it.
> It's a little bit more complex that we need since it allows to specify the
> number of cells for both the address and the size but it should allow us to
> express all possible configurations:
> 
>   usb_dart {
>       [ ... ]
>       #dma-address-cells = <1>;
>       #dma-size-cells = <2>;
>       dma-window = <0 0x1 0x0>;
>       [ ... ]
>   };
>   pcie_dart {
>       [ ... ]
>       #dma-address-cells = <1>;
>       #dma-size-cells = <1>;
>       dma-window = <0x100000 0x3fe00000>;
>       [ ... ]
>   };
> 
> where #dma-address-cells and #dma-size-cells default to
> #address-cells and #size-cells respectively if I understand
> the code correctly. That way we could also just always use
> a 64bit address and size in the DT, e.g.
> 
>   pcie_dart {
>       [ ... ]
>       dma-window = <0 0x100000 0 0x3fe00000>;
>       [ ... ]
>   };

That sounds like a serious contender to me!  Hopefully one of the
Linux kernel developers can give this some sort of blessing.

I think it would make sense for us to just rely on the #address-cells
and #size-cells defaults for the M1 device tree.
