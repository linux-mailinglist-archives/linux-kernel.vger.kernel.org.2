Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66DDD3143C1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 00:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbhBHX2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 18:28:09 -0500
Received: from sibelius.xs4all.nl ([83.163.83.176]:62438 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbhBHX1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 18:27:53 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Feb 2021 18:27:52 EST
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id 114b1b6b;
        Tue, 9 Feb 2021 00:20:25 +0100 (CET)
Date:   Tue, 9 Feb 2021 00:20:25 +0100 (CET)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     marcan@marcan.st, devicetree@vger.kernel.org, maz@kernel.org,
        linux-kernel@vger.kernel.org, soc@kernel.org, robh+dt@kernel.org,
        olof@lixom.net, linux-arm-kernel@lists.infradead.org
In-Reply-To: <CAK8P3a2Ad+xmmMWgznOHPpxgCXKWFYfpHBqt_49_UuxrwFSq+A@mail.gmail.com>
        (message from Arnd Bergmann on Mon, 8 Feb 2021 23:57:20 +0100)
Subject: Re: [PATCH 13/18] arm64: ioremap: use nGnRnE mappings on platforms
 that require it
References: <20210204203951.52105-1-marcan@marcan.st>
 <20210204203951.52105-14-marcan@marcan.st> <CAK8P3a2Ad+xmmMWgznOHPpxgCXKWFYfpHBqt_49_UuxrwFSq+A@mail.gmail.com>
Message-ID: <c1bc2a087747c4d9@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Arnd Bergmann <arnd@kernel.org>
> Date: Mon, 8 Feb 2021 23:57:20 +0100
> 
> On Thu, Feb 4, 2021 at 9:39 PM Hector Martin <marcan@marcan.st> wrote:
> 
> > (3) Do it at a lower level, in ioremap() itself. This requires that
> >     ioremap() somehow discriminates based on address range to pick what
> >     kind of mapping to make.
> >
> >     Declaring these address ranges would be an issue. Options:
> >
> >     a) An out of band list in a DT node, a la /reserved-memory
> >
> >     b) Something based on the existing DT hierarchy, where we can scan
> >        bus ranges and locate buses with a property that says "nGnRnE" or
> >        "nGnRE" and dynamically build the list based on that.
> >
> >     The advantage of this option is that it doesn't touch non-arch code.
> >     The disadvantage is that it adds a complete new bespoke mechanism to
> >     the DT, and that it does not let device drivers actually select the
> >     IO mode, which might be desirable in the future anyway for some
> >     devices.
> 
> I tried investigating further what this would look like, but scanning through
> the ADT dump for what nodes use which register ranges. At first it seemed
> the range 0x200000000-0x2ffffffff is used for all normal devices, while
> the three PCI buses fall into the 0x380000000-0x4ffffffff,
> 0x500000000-0x67fffffff and 0x680000000-0x6ffffffff ranges
> respectively. This would allow a nice abstraction where one node
> contains all the devices in the 0x200000000-0x2ffffffff, and we do a
> translation in of_address_to_resource(),  similar to what we have for
> pci and isa nodes with their special addresses.
> 
> However, I did find that there are several nodes that use mmio
> addresses next to the PCI addresses, e.g. apciec0, dart-apciec0,
> apciec0-piodma, dart-acio0, acio0, acio-cpu0, atc0-dpin0, atc-phy0,
> dart-usb0, and usb-drd0 in the 0x380000000-0x3ffffffff range, just
> before the MMIO space of the first PCIe bus, so it gets a little
> more complicated.
> 
> The actual device node could look something like
> 
> #define MAP_NONPOSTED 0x80000000
> 
> arm-io { /* name for adt, should be changed */
>      compatible = "apple,m1-internal-bus";
>      #address-cells = <2>; /* or maybe <3> if we want */
>      #size-cells = <2>;
>      ranges =
>                /* on-chip MMIO */
>                <(MAP_NONPOSTED | 0x2) 0x0   0x2 0x0 0x1 0x0>,
> 
>               /* first PCI: 2GB control, 4GB memory space */
>              <(MAP_NONPOSTED | 0x3) 0x80000000  0x3 0x80000000  0x0 0x80000000>,
>               <0x4 0x0   0x4 0x0  0x1 0x0>,
> 
>               /* second PCI: 2GB control, 4GB memory space */
>              <(MAP_NONPOSTED | 0x5) 0x0  0x5 0x0  0x0 0x80000000>,
>               <0x5 0x80000000  0x5 0x80000000  0x1>,
> 
>               /* third PCI  0.5GB control, 1.5GB memory space*/
>              <(MAP_NONPOSTED | 0x6) 0x80000000  0x6 0x80000000  0x0 0x20000000>,
>              <0x6 0xa0000000   0x6 0xa0000000  0x0 0x60000000>;
> }
> 
> The MAP_NONPOSTED flag then gets interpreted by the .translate() and
> .get_flags() callbacks of "struct of_bus" in the kernel, where it is put into
> a "struct resource" flag, and interpreted when the resource gets mapped.
> 
> The PCI host controller nests inside of the node above, and (in theory)
> uses the same trick to distinguish between prefetchable and non-prefetchable
> memory, except in practice this is handled in device drivers that already
> know whether to call ioremap() or ioremap_wc().

It is only PCI mmio space that needs to be nGnRE.  The PCI host
controller register space itself needs nGnRnE just like all other
integrated peripherals (or at least it works that way).

For U-Boot I'm using the following memory map:

static struct mm_region apple_mem_map[] = {
	{
		/* I/O */
		.virt = 0x200000000,
		.phys = 0x200000000,
		.size = 8UL * SZ_1G,
		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
			 PTE_BLOCK_NON_SHARE |
			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
	}, {
		/* I/O */
		.virt = 0x500000000,
		.phys = 0x500000000,
		.size = 2UL * SZ_1G,
		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
			 PTE_BLOCK_NON_SHARE |
			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
	}, {
		/* I/O */
		.virt = 0x680000000,
		.phys = 0x680000000,
		.size = SZ_512M,
		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
			 PTE_BLOCK_NON_SHARE |
			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
	}, {
		/* PCIE */
		.virt = 0x6a0000000,
		.phys = 0x6a0000000,
		.size = SZ_512M,
		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
			 PTE_BLOCK_INNER_SHARE |
			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
	}, {
		/* PCIE */
		.virt = 0x6c0000000,
		.phys = 0x6c0000000,
		.size = SZ_1G,
		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
			 PTE_BLOCK_INNER_SHARE |
			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
	}, {
		/* RAM */
		.virt = 0x800000000,
		.phys = 0x800000000,
		.size = 8UL * SZ_1G,
		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
			 PTE_BLOCK_INNER_SHARE
	}, {
		/* List terminator */
		0,
	}
};

struct mm_region *mem_map = apple_mem_map;

This seems to work so far.  It only has the regions for one PCIe
controller.  I suppose the other two are there to support the TB4
ports?

So there is one 512M region for "32-bit" mmio starting at 0x6a0000000
and one 1G region for "64-bit" mmio starting at 0x6c0000000.

Cheers,

Mark

