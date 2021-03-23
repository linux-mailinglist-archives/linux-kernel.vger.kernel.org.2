Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2122346D3D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 23:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbhCWWem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 18:34:42 -0400
Received: from sibelius.xs4all.nl ([83.163.83.176]:62319 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234252AbhCWWd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 18:33:29 -0400
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id 2dca3855;
        Tue, 23 Mar 2021 23:33:25 +0100 (CET)
Date:   Tue, 23 Mar 2021 23:33:25 +0100 (CET)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Rob Herring <robh@kernel.org>
Cc:     sven@svenpeter.dev, iommu@lists.linux-foundation.org,
        joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        arnd@kernel.org, marcan@marcan.st, maz@kernel.org,
        mohamed.mediouni@caramail.com, stan@corellium.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <20210323205346.GA1283560@robh.at.kernel.org> (message from Rob
        Herring on Tue, 23 Mar 2021 14:53:46 -0600)
Subject: Re: [PATCH 0/3] Apple M1 DART IOMMU driver
References: <20210320151903.60759-1-sven@svenpeter.dev>
 <c1bcc0609e920bc6@bloch.sibelius.xs4all.nl> <20210323205346.GA1283560@robh.at.kernel.org>
Message-ID: <c1bccac6b36d4662@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Tue, 23 Mar 2021 14:53:46 -0600
> From: Rob Herring <robh@kernel.org>
> 
> On Sun, Mar 21, 2021 at 05:00:50PM +0100, Mark Kettenis wrote:
> > > Date: Sat, 20 Mar 2021 15:19:33 +0000
> > > From: Sven Peter <sven@svenpeter.dev>
> > > 
> > > Hi,
> > > 
> > > After Hector's initial work [1] to bring up Linux on Apple's M1 it's time to
> > > bring up more devices. Most peripherals connected to the SoC are behind a iommu
> > > which Apple calls "Device Address Resolution Table", or DART for short [2].
> > > Unfortunately, it only shares the name with PowerPC's DART.
> > > Configuring this iommu is mandatory if these peripherals require DMA access.
> > > 
> > > This patchset implements initial support for this iommu. The hardware itself
> > > uses a pagetable format that's very similar to the one already implement in
> > > io-pgtable.c. There are some minor modifications, namely some details of the
> > > PTE format and that there are always three pagetable levels, which I've
> > > implement as a new format variant.
> > > 
> > > I have mainly tested this with the USB controller in device mode which is
> > > compatible with Linux's dwc3 driver. Some custom PHY initialization (which is
> > > not yet ready or fully understood) is required though to bring up the ports,
> > > see e.g. my patches to our m1n1 bootloader [3,4]. If you want to test the same
> > > setup you will probably need that branch for now and add the nodes from
> > > the DT binding specification example to your device tree.
> > > 
> > > Even though each DART instances could support up to 16 devices usually only
> > > a single device is actually connected. Different devices generally just use
> > > an entirely separate DART instance with a seperate MMIO range, IRQ, etc.
> > > 
> > > I have just noticed today though that at least the USB DWC3 controller in host
> > > mode uses *two* darts at the same time. I'm not sure yet which parts seem to
> > > require which DART instance.
> > > 
> > > This means that we might need to support devices attached to two iommus
> > > simultaneously and just create the same iova mappings. Currently this only
> > > seems to be required for USB according to Apple's Device Tree.
> > > 
> > > I see two options for this and would like to get feedback before
> > > I implement either one:
> > > 
> > >     1) Change #iommu-cells = <1>; to #iommu-cells = <2>; and use the first cell
> > >        to identify the DART and the second one to identify the master.
> > >        The DART DT node would then also take two register ranges that would
> > >        correspond to the two DARTs. Both instances use the same IRQ and the
> > >        same clocks according to Apple's device tree and my experiments.
> > >        This would keep a single device node and the DART driver would then
> > >        simply map iovas in both DARTs if required.
> > > 
> > >     2) Keep #iommu-cells as-is but support
> > >             iommus = <&usb_dart1a 1>, <&usb_dart1b 0>;
> > >        instead.
> > >        This would then require two devices nodes for the two DART instances and
> > >        some housekeeping in the DART driver to support mapping iovas in both
> > >        DARTs.
> > >        I believe omap-iommu.c supports this setup but I will have to read
> > >        more code to understand the details there and figure out how to implement
> > >        this in a sane way.
> > > 
> > > I currently prefer the first option but I don't understand enough details of
> > > the iommu system to actually make an informed decision.
> 
> Please don't mix what does the h/w look like and what's easy to 
> implement in Linux's IOMMU subsytem. It's pretty clear (at least 
> from the description here) that option 2 reflects the h/w.

Apple does represent these as a single node in their device tree.  The
two instances share an interrupt and share power/clock gating.  So
they seem to be part of a single hardware block.

> > > I'm obviously also open to more options :-)
> > 
> > Hi Sven,
> > 
> > I don't think the first option is going to work for PCIe.  PCIe
> > devices will have to use "iommu-map" properties to map PCI devices to
> > the right iommu, and the currently implementation seems to assume that
> > #iommu-cells = <1>.  The devictree binding[1] doesn't explicitly state
> > that it relies on #iommu-cells = <1>, but it isn't clear how the
> > rid-base to iommu-base mapping mechanism would work when that isn't
> > the case.
> > 
> > Now the PCIe DARTs are simpler and seem to have only one "instance"
> > per DART.  So if we keep #iommu-cells = <1> for those, you'd still be
> > fine using the first approach.
> > 
> > As I mentioned before, not all DARTs support the full 32-bit aperture.
> > In particular the PCIe DARTs support a smaller address-space.  It is
> > not clear whether this is a restriction of the PCIe host controller or
> > the DART, but the Apple Device Tree has "vm-base" and "vm-size"
> > properties that encode the base address and size of the aperture.
> > These single-cell properties which is probably why for the USB DARTs
> > only "vm-base" is given; since "vm-base" is 0, a 32-bit number
> > wouldn't be able to encode the full aperture size.  We could make them
> > 64-bit numbers in the Linux device tree though and always be explicit
> > about the size.  Older Sun SPARC machines used a single "virtual-dma"
> > property to encode the aperture.  We could do someting similar.  You
> > would use this property to initialize domain->geometry.aperture_start
> > and domain->geometry.aperture_end in diff 3/3 of this series.
> 
> 'dma-ranges' is what should be used here.
> 
> Rob
> 
