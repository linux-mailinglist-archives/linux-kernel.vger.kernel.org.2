Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C417A342D9B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 16:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhCTPUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 11:20:16 -0400
Received: from mail-40134.protonmail.ch ([185.70.40.134]:38676 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhCTPTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 11:19:38 -0400
Date:   Sat, 20 Mar 2021 15:19:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
        s=protonmail3; t=1616253575;
        bh=rRb0CjHmraJyeX+g9eakf9Qm7lh28jtpNuhNTu/RlwY=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=RkCqzYspbvUCMMsy777eroY/bnpCj4qZJg+IEZvKlr2YFE7M6Hdw+mZpZWo5GcI7w
         9x6vrc7I+OieqMiQ7QsdsLk3jQuSUSHY3Rn7JbcexUXVt4NCn/PsmjoXGH34vkQNkk
         0CkWJHu8Yf6ztHIPbQU4AK4eqM3TCr4iUkDvbBM8HJAKYnHyVunlMDX0ZS9j56lRnw
         JURq8ktUnC6bscDInomvcHgpZdUpgqHFNMCxnP9ZqJDHd5bgllEDop1SXjEyQyeTdh
         Upi3/K2G3ZeBRcxeDz5irK1VM7VXyb7mWD77l++lETMSNooQXJyEuvcGwiURyqzls0
         6Mn0vD7ohrQtw==
To:     iommu@lists.linux-foundation.org
From:   Sven Peter <sven@svenpeter.dev>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Marc Zyngier <maz@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Reply-To: Sven Peter <sven@svenpeter.dev>
Subject: [PATCH 0/3] Apple M1 DART IOMMU driver
Message-ID: <20210320151903.60759-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After Hector's initial work [1] to bring up Linux on Apple's M1 it's time t=
o
bring up more devices. Most peripherals connected to the SoC are behind a i=
ommu
which Apple calls "Device Address Resolution Table", or DART for short [2].
Unfortunately, it only shares the name with PowerPC's DART.
Configuring this iommu is mandatory if these peripherals require DMA access=
.

This patchset implements initial support for this iommu. The hardware itsel=
f
uses a pagetable format that's very similar to the one already implement in
io-pgtable.c. There are some minor modifications, namely some details of th=
e
PTE format and that there are always three pagetable levels, which I've
implement as a new format variant.

I have mainly tested this with the USB controller in device mode which is
compatible with Linux's dwc3 driver. Some custom PHY initialization (which =
is
not yet ready or fully understood) is required though to bring up the ports=
,
see e.g. my patches to our m1n1 bootloader [3,4]. If you want to test the s=
ame
setup you will probably need that branch for now and add the nodes from
the DT binding specification example to your device tree.

Even though each DART instances could support up to 16 devices usually only
a single device is actually connected. Different devices generally just use
an entirely separate DART instance with a seperate MMIO range, IRQ, etc.

I have just noticed today though that at least the USB DWC3 controller in h=
ost
mode uses *two* darts at the same time. I'm not sure yet which parts seem t=
o
require which DART instance.

This means that we might need to support devices attached to two iommus
simultaneously and just create the same iova mappings. Currently this only
seems to be required for USB according to Apple's Device Tree.

I see two options for this and would like to get feedback before
I implement either one:

    1) Change #iommu-cells =3D <1>; to #iommu-cells =3D <2>; and use the fi=
rst cell
       to identify the DART and the second one to identify the master.
       The DART DT node would then also take two register ranges that would
       correspond to the two DARTs. Both instances use the same IRQ and the
       same clocks according to Apple's device tree and my experiments.
       This would keep a single device node and the DART driver would then
       simply map iovas in both DARTs if required.

    2) Keep #iommu-cells as-is but support
            iommus =3D <&usb_dart1a 1>, <&usb_dart1b 0>;
       instead.
       This would then require two devices nodes for the two DART instances=
 and
       some housekeeping in the DART driver to support mapping iovas in bot=
h
       DARTs.
       I believe omap-iommu.c supports this setup but I will have to read
       more code to understand the details there and figure out how to impl=
ement
       this in a sane way.

I currently prefer the first option but I don't understand enough details o=
f
the iommu system to actually make an informed decision.
I'm obviously also open to more options :-)


Best regards,


Sven

[1] https://lore.kernel.org/linux-arch/20210304213902.83903-1-marcan@marcan=
.st/
[2] https://developer.apple.com/library/archive/documentation/DeviceDrivers=
/Conceptual/IOKitFundamentals/DataMgmt/DataMgmt.html
[3] https://github.com/svenpeter42/m1n1/commit/1e2661abf5ea2c820297b3ff5912=
35c408d19a34
[4] https://github.com/svenpeter42/m1n1/tree/usb-uartproxy-console-wip



