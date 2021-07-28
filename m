Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8323D90B0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 16:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbhG1Obf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 10:31:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:47462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236868AbhG1O2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 10:28:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4F8A60F91;
        Wed, 28 Jul 2021 14:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627482519;
        bh=98m7jHCj8Qw27iWe0c9Uq3hXqk5DfR0xhuh5cbT3b/0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NVHs085nLK/SJ7YUy+ykqb0d9RwebH/VQJFV83SsKAHb5wiP+oAClubC/c9X4Hs8u
         Qe8CdeOGt0omFrJdXRekq/rURpGum+tk9ho4GKAj6nj8GaU3oXUEzocYcV8+rfPYpP
         bM2eFd1+tKDFiqKY6ECx9Fh7+lKMnsMgMx/RgYn8bGe+0dpu/4Fla/bzOtGCOWyInW
         L7TQmZQMGZ25w8rdBx0QkkQvdXm5JMyIShQNX48cvQuGx5N0fmTXX5ozTpQAt9FfA2
         dZnTr2KhIK4wQtB8DO4rkWmJ+4iDXGSCduqKWNX2fycVxTlqR3iOjUmt0pD8eDi9mV
         UUAr16AJMjsRw==
Received: by mail-ej1-f48.google.com with SMTP id ga41so4898881ejc.10;
        Wed, 28 Jul 2021 07:28:39 -0700 (PDT)
X-Gm-Message-State: AOAM533IAIKeqR+Tbi9wr0BrrZDsRdxZAn++DZcB1Bo3kIQqe6vMnt7z
        e8OQJD9RmDNqxFfce3SwYZFDPY1gZyKyMIDMEQ==
X-Google-Smtp-Source: ABdhPJxbku8IzWJXJ8o8drnqIdmudsKIsqQxvtxY1mjL/QDryCiCm4S3m1bpO6OlSpU1n2oGnpG4hp7XGc775Evo+7o=
X-Received: by 2002:a17:907:766c:: with SMTP id kk12mr4450790ejc.525.1627482518348;
 Wed, 28 Jul 2021 07:28:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626855713.git.mchehab+huawei@kernel.org>
 <946f2426bc542638240980931eae924c57f2ba27.1626855713.git.mchehab+huawei@kernel.org>
 <20210723225059.GA2727093@robh.at.kernel.org> <20210724021244.780297ee@coco.lan>
 <CAL_JsqLA7Z908SQKkZpyEcCvpkWsW3pa42eajpxCSkbUy4rv9g@mail.gmail.com>
 <20210727015020.403bbf73@coco.lan> <20210727085205.5aafb5c9@coco.lan>
 <CAL_Jsq+5raGQAK5T4SoC=Jfzsbov-y4u-rdJ3DJt+ryYOK8q2w@mail.gmail.com> <20210728093838.4c7114bf@coco.lan>
In-Reply-To: <20210728093838.4c7114bf@coco.lan>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 28 Jul 2021 08:28:26 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLQX-zkWigA3P4PG2LikCQMq6Lrh8Ok95P4KbcbNS6+_w@mail.gmail.com>
Message-ID: <CAL_JsqLQX-zkWigA3P4PG2LikCQMq6Lrh8Ok95P4KbcbNS6+_w@mail.gmail.com>
Subject: Re: [PATCH v7 06/10] dt-bindings: phy: Add bindings for HiKey 970
 PCIe PHY
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Linuxarm <linuxarm@huawei.com>, mauro.chehab@huawei.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 1:38 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Em Tue, 27 Jul 2021 16:17:43 -0600
> Rob Herring <robh@kernel.org> escreveu:
>
> > On Tue, Jul 27, 2021 at 12:52 AM Mauro Carvalho Chehab
> > <mchehab+huawei@kernel.org> wrote:
> > >
> > > Em Tue, 27 Jul 2021 01:50:20 +0200
> > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:
> > >
> > > > Em Mon, 26 Jul 2021 15:37:28 -0600
> > > > Rob Herring <robh@kernel.org> escreveu:
> > > >
> > >
> > > > > > > > +  reset-gpios:
> > > > > > > > +    description: PCI PERST reset GPIOs
> > > > > > > > +    maxItems: 4
> > > > > > > > +
> > > > > > > > +  clkreq-gpios:
> > > > > > > > +    description: Clock request GPIOs
> > > > > > > > +    maxItems: 3
> > > > > > >
> > > > > > > Again, this will not work.
> > > > > >
> > > > > > Just to be sure: you're talking about the PERST# gpios (e. g. reset-gpios)
> > > > > > here, right?
> > > > >
> > > > > Both that and CLKREQ.
> > >
> > > The original DT from the downstream version (found at Linaro's tree)
> > > has:
> > >
> > >         pcie@f4000000 {
> > >                 compatible = "hisilicon,hikey970";
> > > ...
> > >                 switch,reset-gpios = <&gpio7 0 0 >;
> > >                 eth,reset-gpios = <&gpio25 2 0 >;
> > >                 m_2,reset-gpios = <&gpio3 1 0 >;
> > >                 mini1,reset-gpios = <&gpio27 4 0 >;
> > >
> > >                 eth,clkreq-gpios = <&gpio20 6 0 >;
> > >                 m_2,clkreq-gpios = <&gpio27 3 0 >;
> > >                 mini1,clkreq-gpios = <&gpio17 0 0 >;
> > >         };
> > >
> > > So, if we're willing to have a single reset-gpios for the PCIe
> > > interface, in order to follow the current pci-bus.yaml schema,
> > > this would probably be:
> > >
> > >         reset-gpios = <&gpio7 0 0 >;
> > >
> > > which maps to the PEX8606 PCIe bridge chip.
> > >
> > > With that, DT still need to point a per-slot clkreq and
> > > reset-gpio.
> > >
> > > One alternative would be to map it as either 3 PCI or PHY
> > > child nodes. E. g. something like this:
> > >
> > >         pcie@f4000000 {
> > >                 compatible = "hisilicon,kirin970-pcie";
> > > ...
> > >                 reset-gpios = <&gpio7 0 0 >;
> > >
> > >                 slot {
> > >                         eth {
> > >                                 reset-gpios = <&gpio25 2 0>;
> > >                                 clkreq-gpios = <&gpio20 6 0>;
> > >                         };
> > >                         m2 {
> > >                                 reset-gpios = <&gpio3 1 0>;
> > >                                 clkreq-gpios = <&gpio27 3 0>;
> > >                         };
> > >                         mini1 {
> > >                                 reset-gpios = <&gpio27 4 0>;
> > >                                 clkreq-gpios = <&gpio17 0 0>;
> > >                         };
> > >                 };
> > >         };
> > >
> > >
> > > Placing the child nodes ("slot"?) at the pci bus properties makes more
> > > sense to me, but placing them at the PHY node has the advantage of
> > > only affecting Kirin 970.
> > >
> > > In either case, if each child would need a different power supply,
> > > it won't be hard to add a "slot-supply" property later on.
> > >
> > > Would something like that be acceptable for you?
> >
> > On the right track, but there's already a definition for what child
> > devices look like in pci2_1.pdf. I think you want something like this:
> >
> > pcie@f4000000 { // RP: Bus 0, Device 0
> >     compatible = "hisilicon,kirin970-pcie";
> >     ...
> >     reset-gpios = <&gpio7 0 0>;  // PERST to switch
> >
> >     pcie@0 { // PCIe switch: Bus 1, Device 0
> >         reg = <0 0 0 0 0>;
> >         compatible = "pciclass,0604";
> >         device_type = "pci";
> >
> >         pcie@1 { // NC (Can omit this node)
> >             reg = <0x80 0 0 0 0>;
> >             compatible = "pciclass,0604";
> >             device_type = "pci";
> >         };
> >
> >         pcie@4 { // M.2
> >             reg = <0x200 0 0 0 0>;
>
> Not sure what to put at reg. I suspect that the best would be to follow
> the PEX port number, as, if one day someone decides to implement an
> I2C driver, this might be useful.

It's defined in the PCI bus binding. Basically, it's the BDF of the
device. However, as the bus number is dynamic, I think we want to
leave that as 0 for FDT. The function is optional and always 0 in this
case.


> >             compatible = "pciclass,0604";
> >             device_type = "pci";
> >             reset-gpios = <&gpio7 1 0>; // PERST to M.2 slot
>
> We also need the clock-req phandle for the three devices.

Hopefully, you can figure out where those belong now...

>
> >        };
> >
> >         pcie@5 { // Mini
> >             reg = <0x280 0 0 0 0>;
> >             compatible = "pciclass,0604";
> >             device_type = "pci";
> >             reset-gpios = <&gpio7 2 0>; // PERST to Mini slot
> >         };
> >
> >         pcie@7 { // Ethernet
> >             reg = <0x380 0 0 0 0>;
> >             compatible = "pciclass,0604";
> >             device_type = "pci";
> >             reset-gpios = <&gpio7 3 0>; // PERST to Ethernet
> >
> >             ethernet@0 {
> >                 reg = <0 0 0 0 0>;
> >                 local-mac-address = [ 00 01 02 03 04 05 06 ];
> >             };
>
> No need to add a mac address here. The Ethernet card has a mac
> already:

That was just for illustration of what a device node would look like
should you need extra properties for a device. If you only needed to
set the MAC address, guess what, you need to create the hierarchy
above.

>
>         60:fa:9d:xx:xx:xx
>
> Which seems to be a valid one:
>
>         https://hwaddress.com/?q=60%3Afa%3A9d
>
> >         };
> >
> >         pcie@9 { // NC
> >             reg = <0x480 0 0 0 0>;
> >             compatible = "pciclass,0604";
> >             device_type = "pci";
> >        };
> > };
> >
> > This is based on what you previously sent:
> > 00:00.0 PCI bridge: Huawei Technologies Co., Ltd. Device 3670 (rev 01)
> > 01:00.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI
> > Express Gen 2 (5.0 GT/s) Switch (rev ba)
> > 02:01.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI
> > Express Gen 2 (5.0 GT/s) Switch (rev ba)
> > 02:04.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI
> > Express Gen 2 (5.0 GT/s) Switch (rev ba)
> > 02:05.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI
> > Express Gen 2 (5.0 GT/s) Switch (rev ba)
> > 02:07.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI
> > Express Gen 2 (5.0 GT/s) Switch (rev ba)
> > 02:09.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI
> > Express Gen 2 (5.0 GT/s) Switch (rev ba)
> > 06:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> > RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 07)
> >
> > A few notes:
> > I left out #size-cells, #address-cells, and ranges for brevity.
> >
> > I'm not completely sure I've got the bridges mapped to the right
> > functions on Hikey970. That's my best guess looking at the schematics.
> > You should be able to confirm which bridge is the parent bridge for
> > ethernet at least.
>
> I added a NVMe to M.2 slot:
>
> $ lspci -D -P -PP
> 0000:00:00.0 PCI bridge: Huawei Technologies Co., Ltd. Device 3670 (rev 01)
> 0000:00:00.0/01:00.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
> 0000:00:00.0/01:00.0/02:01.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
> 0000:00:00.0/01:00.0/02:04.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
> 0000:00:00.0/01:00.0/02:05.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
> 0000:00:00.0/01:00.0/02:07.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
> 0000:00:00.0/01:00.0/02:09.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
> 0000:00:00.0/01:00.0/02:01.0/03:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd Device a809
> 0000:00:00.0/01:00.0/02:07.0/06:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 07)
>
> it sounds that all devices are behind the PEX 8606 bridge:
>         - port 1 seems to be the M.2 slot
>         - port 7 seems to be the Ethernet adapter
>
> I don't have any mini PCIe devices here. I'll try to get one in order to be
> sure about the topology.

I found the mapping in table 4-1 from
https://docs.broadcom.com/doc/PEX_8606-BA_Data_Book_v1.3_31Mar11.pdf

So it is like this:
Device 0 - lane 0 - upstream
Device 1 - lane 4 - m.2
Device 5 - lane 5 - mini PCIe
Device 7 - lane 6 - ethernet

'lane' is the signal numbering in the schematics.

>
> > The compatible strings aren't strictly needed. Linux doesn't look at them.
>
> If not needed, IMO the best would be to not add it, keeping it as
> simple as possible.

I would say that anything with extra properties should have a compatible.

> >
> > There's a pretty complete example in:
> > arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
>
> Thanks!
>
> > The simplest Linux implementation to handle the above is just walk the
> > child nodes and get all the 'reset-gpios' properties. That's not the
> > implementation I think we should have though. We should handle the
> > GPIO as each bridge is probed and children scanned.
>
> The power-on sequence is:
>
>         1. CLK, PHY and DWC initialization;
>         2. 21ms delay;
>         3. PERST# sent to each device;
>         4. 10ms delay;
>         5. adjust the eye diagram;
>         6. power off NOC.
>
> Most of the above are at the PHY driver. Now, it would be possible to
> map those as:
>
>         phy->init() - steps 1 and 2;
>         phy->power_on() - steps 4, 5 and 6.
>
> And change somehow the pcie-kirin driver to only call phy->power_on()
> after doing the bus probing sequence, but a change like that would mean
> that the eye diagram will only be adjusted at the end. That doesn't
> sound a good idea to me, as probing devices with a wrong eye diagram
> could cause bit errors when talking to the devices inside the PCI bus.
> This is likely not a problem if all devices are directly connected to
> the hardware, but it could be an issue if someone uses either a M.2 or
> a mini-PCI extensor.

The eye diagram only applies to the link between the RP and switch.
There's no way that any of the downstream PERSTs matter, that's just
not logical. So you only need to deassert PERST on that link.

What happens if you only handle the switch PERST and CLKREQ? You
should simply only discover the switch and no downstream devices.

> So, IMO, the best would be for the PHY driver to walk the child nodes
> and get all the 'reset-gpios' properties.
>
> With regards to the clock-req phandles, those should be enabled before
> the PHY clocks, in order to avoid the SError issue.

Huh? What exactly causes an SError. Has to be some bus access. But
again, it's only going to be the one for the RP link that matters
here.

> It should be easy to implement this at the the PCIe driver, but, this
> should happen in early stages at the power-on sequence (before enabling
> the DWC PHY clocks). So, the PCIe driver (or the PHY) will need to
> walk the child nodes and get all the 'reset-gpios' properties.
>
> For the sake of avoiding to duplicate the walk-though and parsing
> logic, I would do it only at the PHY driver.

Everyone else handles this stuff in their PCIe driver. You are not special...

I have a plan to make the PERST handling common across all PCIe host
drivers and also make the PHY handling common across DWC drivers.
Don't make that harder.

Rob
