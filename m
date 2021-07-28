Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0BFB3D88FB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 09:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbhG1Hiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 03:38:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235051AbhG1Hip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 03:38:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 04BEA60F9C;
        Wed, 28 Jul 2021 07:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627457924;
        bh=vQGOtmQFxhzVI7TCtuuD+DuN+LJJ67er3BftWND9aJg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YjyyYNMW4TWF32j+eC4tkU4l/8urpTyZWoPFJFlwK37jkgibTUrVZ/WcjI00c38lp
         cmL86D4uKuBaPQzjTFrqI+7DfYb6rpbuYOCO/Zo2ROFPYhtKemTDd+kSElNIAk9WCD
         UCuhQGPH2OHdA+BOWh/zxd0/5ME16/3NuJU6t94smMM7bHg7yLDyW7t4rfg6gESbC5
         Rpr1mMW/H1iiz+mLANfSnj/X+quAJEqSRj6iD4SqSY/vs5x1WVOmHFNzaVAOACQ3is
         oQB5VVHnF7Fr13NVKGsazo8IPR16UgnMLkKyVj+0AA/xEeffmvclxFnIHa4Qq9f9eS
         Jq30sidQjA/JA==
Date:   Wed, 28 Jul 2021 09:38:38 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Linuxarm <linuxarm@huawei.com>, mauro.chehab@huawei.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v7 06/10] dt-bindings: phy: Add bindings for HiKey 970
 PCIe PHY
Message-ID: <20210728093838.4c7114bf@coco.lan>
In-Reply-To: <CAL_Jsq+5raGQAK5T4SoC=Jfzsbov-y4u-rdJ3DJt+ryYOK8q2w@mail.gmail.com>
References: <cover.1626855713.git.mchehab+huawei@kernel.org>
        <946f2426bc542638240980931eae924c57f2ba27.1626855713.git.mchehab+huawei@kernel.org>
        <20210723225059.GA2727093@robh.at.kernel.org>
        <20210724021244.780297ee@coco.lan>
        <CAL_JsqLA7Z908SQKkZpyEcCvpkWsW3pa42eajpxCSkbUy4rv9g@mail.gmail.com>
        <20210727015020.403bbf73@coco.lan>
        <20210727085205.5aafb5c9@coco.lan>
        <CAL_Jsq+5raGQAK5T4SoC=Jfzsbov-y4u-rdJ3DJt+ryYOK8q2w@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 27 Jul 2021 16:17:43 -0600
Rob Herring <robh@kernel.org> escreveu:

> On Tue, Jul 27, 2021 at 12:52 AM Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> >
> > Em Tue, 27 Jul 2021 01:50:20 +0200
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:
> >  
> > > Em Mon, 26 Jul 2021 15:37:28 -0600
> > > Rob Herring <robh@kernel.org> escreveu:
> > >  
> >  
> > > > > > > +  reset-gpios:
> > > > > > > +    description: PCI PERST reset GPIOs
> > > > > > > +    maxItems: 4
> > > > > > > +
> > > > > > > +  clkreq-gpios:
> > > > > > > +    description: Clock request GPIOs
> > > > > > > +    maxItems: 3  
> > > > > >
> > > > > > Again, this will not work.  
> > > > >
> > > > > Just to be sure: you're talking about the PERST# gpios (e. g. reset-gpios)
> > > > > here, right?  
> > > >
> > > > Both that and CLKREQ.  
> >
> > The original DT from the downstream version (found at Linaro's tree)
> > has:
> >
> >         pcie@f4000000 {
> >                 compatible = "hisilicon,hikey970";
> > ...
> >                 switch,reset-gpios = <&gpio7 0 0 >;
> >                 eth,reset-gpios = <&gpio25 2 0 >;
> >                 m_2,reset-gpios = <&gpio3 1 0 >;
> >                 mini1,reset-gpios = <&gpio27 4 0 >;
> >
> >                 eth,clkreq-gpios = <&gpio20 6 0 >;
> >                 m_2,clkreq-gpios = <&gpio27 3 0 >;
> >                 mini1,clkreq-gpios = <&gpio17 0 0 >;
> >         };
> >
> > So, if we're willing to have a single reset-gpios for the PCIe
> > interface, in order to follow the current pci-bus.yaml schema,
> > this would probably be:
> >
> >         reset-gpios = <&gpio7 0 0 >;
> >
> > which maps to the PEX8606 PCIe bridge chip.
> >
> > With that, DT still need to point a per-slot clkreq and
> > reset-gpio.
> >
> > One alternative would be to map it as either 3 PCI or PHY
> > child nodes. E. g. something like this:
> >
> >         pcie@f4000000 {
> >                 compatible = "hisilicon,kirin970-pcie";
> > ...
> >                 reset-gpios = <&gpio7 0 0 >;
> >
> >                 slot {
> >                         eth {
> >                                 reset-gpios = <&gpio25 2 0>;
> >                                 clkreq-gpios = <&gpio20 6 0>;
> >                         };
> >                         m2 {
> >                                 reset-gpios = <&gpio3 1 0>;
> >                                 clkreq-gpios = <&gpio27 3 0>;
> >                         };
> >                         mini1 {
> >                                 reset-gpios = <&gpio27 4 0>;
> >                                 clkreq-gpios = <&gpio17 0 0>;
> >                         };
> >                 };
> >         };
> >
> >
> > Placing the child nodes ("slot"?) at the pci bus properties makes more
> > sense to me, but placing them at the PHY node has the advantage of
> > only affecting Kirin 970.
> >
> > In either case, if each child would need a different power supply,
> > it won't be hard to add a "slot-supply" property later on.
> >
> > Would something like that be acceptable for you?  
> 
> On the right track, but there's already a definition for what child
> devices look like in pci2_1.pdf. I think you want something like this:
> 
> pcie@f4000000 { // RP: Bus 0, Device 0
>     compatible = "hisilicon,kirin970-pcie";
>     ...
>     reset-gpios = <&gpio7 0 0>;  // PERST to switch
> 
>     pcie@0 { // PCIe switch: Bus 1, Device 0
>         reg = <0 0 0 0 0>;
>         compatible = "pciclass,0604";
>         device_type = "pci";
> 
>         pcie@1 { // NC (Can omit this node)
>             reg = <0x80 0 0 0 0>;
>             compatible = "pciclass,0604";
>             device_type = "pci";
>         };
> 
>         pcie@4 { // M.2
>             reg = <0x200 0 0 0 0>;

Not sure what to put at reg. I suspect that the best would be to follow
the PEX port number, as, if one day someone decides to implement an
I2C driver, this might be useful.


>             compatible = "pciclass,0604";
>             device_type = "pci";
>             reset-gpios = <&gpio7 1 0>; // PERST to M.2 slot

We also need the clock-req phandle for the three devices.

>        };
> 
>         pcie@5 { // Mini
>             reg = <0x280 0 0 0 0>;
>             compatible = "pciclass,0604";
>             device_type = "pci";
>             reset-gpios = <&gpio7 2 0>; // PERST to Mini slot
>         };
> 
>         pcie@7 { // Ethernet
>             reg = <0x380 0 0 0 0>;
>             compatible = "pciclass,0604";
>             device_type = "pci";
>             reset-gpios = <&gpio7 3 0>; // PERST to Ethernet
> 
>             ethernet@0 {
>                 reg = <0 0 0 0 0>;
>                 local-mac-address = [ 00 01 02 03 04 05 06 ];
>             };

No need to add a mac address here. The Ethernet card has a mac
already:

	60:fa:9d:xx:xx:xx

Which seems to be a valid one:

	https://hwaddress.com/?q=60%3Afa%3A9d

>         };
> 
>         pcie@9 { // NC
>             reg = <0x480 0 0 0 0>;
>             compatible = "pciclass,0604";
>             device_type = "pci";
>        };
> };
> 
> This is based on what you previously sent:
> 00:00.0 PCI bridge: Huawei Technologies Co., Ltd. Device 3670 (rev 01)
> 01:00.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI
> Express Gen 2 (5.0 GT/s) Switch (rev ba)
> 02:01.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI
> Express Gen 2 (5.0 GT/s) Switch (rev ba)
> 02:04.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI
> Express Gen 2 (5.0 GT/s) Switch (rev ba)
> 02:05.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI
> Express Gen 2 (5.0 GT/s) Switch (rev ba)
> 02:07.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI
> Express Gen 2 (5.0 GT/s) Switch (rev ba)
> 02:09.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI
> Express Gen 2 (5.0 GT/s) Switch (rev ba)
> 06:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 07)
> 
> A few notes:
> I left out #size-cells, #address-cells, and ranges for brevity.
> 
> I'm not completely sure I've got the bridges mapped to the right
> functions on Hikey970. That's my best guess looking at the schematics.
> You should be able to confirm which bridge is the parent bridge for
> ethernet at least.

I added a NVMe to M.2 slot:

$ lspci -D -P -PP
0000:00:00.0 PCI bridge: Huawei Technologies Co., Ltd. Device 3670 (rev 01)
0000:00:00.0/01:00.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
0000:00:00.0/01:00.0/02:01.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
0000:00:00.0/01:00.0/02:04.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
0000:00:00.0/01:00.0/02:05.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
0000:00:00.0/01:00.0/02:07.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
0000:00:00.0/01:00.0/02:09.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
0000:00:00.0/01:00.0/02:01.0/03:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd Device a809
0000:00:00.0/01:00.0/02:07.0/06:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 07)

it sounds that all devices are behind the PEX 8606 bridge:
	- port 1 seems to be the M.2 slot
	- port 7 seems to be the Ethernet adapter

I don't have any mini PCIe devices here. I'll try to get one in order to be
sure about the topology.

> The compatible strings aren't strictly needed. Linux doesn't look at them.

If not needed, IMO the best would be to not add it, keeping it as
simple as possible.

> 
> There's a pretty complete example in:
> arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi

Thanks!

> The simplest Linux implementation to handle the above is just walk the
> child nodes and get all the 'reset-gpios' properties. That's not the
> implementation I think we should have though. We should handle the
> GPIO as each bridge is probed and children scanned.

The power-on sequence is:

	1. CLK, PHY and DWC initialization;
	2. 21ms delay;
	3. PERST# sent to each device;
	4. 10ms delay;
	5. adjust the eye diagram;
	6. power off NOC.

Most of the above are at the PHY driver. Now, it would be possible to
map those as:

	phy->init() - steps 1 and 2;
	phy->power_on() - steps 4, 5 and 6.

And change somehow the pcie-kirin driver to only call phy->power_on()
after doing the bus probing sequence, but a change like that would mean
that the eye diagram will only be adjusted at the end. That doesn't
sound a good idea to me, as probing devices with a wrong eye diagram 
could cause bit errors when talking to the devices inside the PCI bus. 
This is likely not a problem if all devices are directly connected to
the hardware, but it could be an issue if someone uses either a M.2 or
a mini-PCI extensor.

So, IMO, the best would be for the PHY driver to walk the child nodes 
and get all the 'reset-gpios' properties.

With regards to the clock-req phandles, those should be enabled before
the PHY clocks, in order to avoid the SError issue.

It should be easy to implement this at the the PCIe driver, but, this
should happen in early stages at the power-on sequence (before enabling
the DWC PHY clocks). So, the PCIe driver (or the PHY) will need to
walk the child nodes and get all the 'reset-gpios' properties.

For the sake of avoiding to duplicate the walk-though and parsing
logic, I would do it only at the PHY driver.

Thanks,
Mauro
