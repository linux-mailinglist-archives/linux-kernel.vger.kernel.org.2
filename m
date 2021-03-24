Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9510D347C9A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 16:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbhCXP3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 11:29:54 -0400
Received: from foss.arm.com ([217.140.110.172]:35184 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236528AbhCXP3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:29:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BC90D6E;
        Wed, 24 Mar 2021 08:29:45 -0700 (PDT)
Received: from [10.57.50.37] (unknown [10.57.50.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC3053F7D7;
        Wed, 24 Mar 2021 08:29:42 -0700 (PDT)
Subject: Re: [PATCH 0/3] Apple M1 DART IOMMU driver
To:     Sven Peter <sven@svenpeter.dev>, iommu@lists.linux-foundation.org
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Marc Zyngier <maz@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20210320151903.60759-1-sven@svenpeter.dev>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <9b9d771a-f6d4-2d27-7516-f5b8315909ed@arm.com>
Date:   Wed, 24 Mar 2021 15:29:36 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210320151903.60759-1-sven@svenpeter.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-20 15:19, Sven Peter wrote:
> Hi,
> 
> After Hector's initial work [1] to bring up Linux on Apple's M1 it's time to
> bring up more devices. Most peripherals connected to the SoC are behind a iommu
> which Apple calls "Device Address Resolution Table", or DART for short [2].
> Unfortunately, it only shares the name with PowerPC's DART.
> Configuring this iommu is mandatory if these peripherals require DMA access.
> 
> This patchset implements initial support for this iommu. The hardware itself
> uses a pagetable format that's very similar to the one already implement in
> io-pgtable.c. There are some minor modifications, namely some details of the
> PTE format and that there are always three pagetable levels, which I've
> implement as a new format variant.
> 
> I have mainly tested this with the USB controller in device mode which is
> compatible with Linux's dwc3 driver. Some custom PHY initialization (which is
> not yet ready or fully understood) is required though to bring up the ports,
> see e.g. my patches to our m1n1 bootloader [3,4]. If you want to test the same
> setup you will probably need that branch for now and add the nodes from
> the DT binding specification example to your device tree.
> 
> Even though each DART instances could support up to 16 devices usually only
> a single device is actually connected. Different devices generally just use
> an entirely separate DART instance with a seperate MMIO range, IRQ, etc.
> 
> I have just noticed today though that at least the USB DWC3 controller in host
> mode uses *two* darts at the same time. I'm not sure yet which parts seem to
> require which DART instance.
> 
> This means that we might need to support devices attached to two iommus
> simultaneously and just create the same iova mappings. Currently this only
> seems to be required for USB according to Apple's Device Tree.
> 
> I see two options for this and would like to get feedback before
> I implement either one:
> 
>      1) Change #iommu-cells = <1>; to #iommu-cells = <2>; and use the first cell
>         to identify the DART and the second one to identify the master.
>         The DART DT node would then also take two register ranges that would
>         correspond to the two DARTs. Both instances use the same IRQ and the
>         same clocks according to Apple's device tree and my experiments.
>         This would keep a single device node and the DART driver would then
>         simply map iovas in both DARTs if required.

This is broadly similar to the approach used by rockchip-iommu and the 
special arm-smmu-nvidia implementation, where there are multiple 
instances which require programming identically, that are abstracted 
behind a single "device". Your case is a little different since you're 
not programming both *entirely* identically, although maybe that's a 
possibility if each respective ID isn't used by anything else on the 
"other" DART?

Overall I tend to view this approach as a bit of a hack because it's not 
really describing the hardware truthfully - just because two distinct 
functional blocks have their IRQ lines wired together doesn't suddenly 
make them a single monolithic block with multiple interfaces - and tends 
to be done for the sake of making the driver implementation easier in 
terms of the Linux IOMMU API (which, note, hasn't evolved all that far 
from its PCI-centric origins and isn't exactly great for arbitrary SoC 
topologies).

>      2) Keep #iommu-cells as-is but support
>              iommus = <&usb_dart1a 1>, <&usb_dart1b 0>;
>         instead.
>         This would then require two devices nodes for the two DART instances and
>         some housekeeping in the DART driver to support mapping iovas in both
>         DARTs.
>         I believe omap-iommu.c supports this setup but I will have to read
>         more code to understand the details there and figure out how to implement
>         this in a sane way.

This approach is arguably the most honest, and more robust in terms of 
making fewer assumptions, and is used by at least exynos-iommu and 
omap-iommu. In Linux it currently takes a little bit more housekeeping 
to keep track of linked instances within the driver since the IOMMU API 
holds the notion that any given client device is associated with "an 
IOMMU", but that's always free to change at any time, unlike the design 
of a DT binding.

There's also the funky "root" and "leaf" devices thing that ipmmu-vmsa 
does, although I believe that represents genuine hardware differences 
where the leaves are more like extra TLBs rather than fully-functional 
IOMMU blocks in their own right, so that may not be a relevant model here.

Robin.

> I currently prefer the first option but I don't understand enough details of
> the iommu system to actually make an informed decision.
> I'm obviously also open to more options :-)
> 
> 
> Best regards,
> 
> 
> Sven
> 
> [1] https://lore.kernel.org/linux-arch/20210304213902.83903-1-marcan@marcan.st/
> [2] https://developer.apple.com/library/archive/documentation/DeviceDrivers/Conceptual/IOKitFundamentals/DataMgmt/DataMgmt.html
> [3] https://github.com/svenpeter42/m1n1/commit/1e2661abf5ea2c820297b3ff591235c408d19a34
> [4] https://github.com/svenpeter42/m1n1/tree/usb-uartproxy-console-wip
> 
> 
> 
