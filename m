Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289273D8260
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 00:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbhG0WR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 18:17:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:60862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232223AbhG0WR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 18:17:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A879B60F46;
        Tue, 27 Jul 2021 22:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627424276;
        bh=NTx2AmyGC2otSjSs47CuSipTZNW0kKqQ1vQxftaHk4A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q/7sSe4oHU/CTPp80Dk3jddqbKeLpeVtJTMwJbDHTa5/VKBhx/nZkQHEbnyTobEc1
         q2WzaXZhV5V2zjYqkP3U7/VXHaxmzm2/A1G0XkrfsxaVoSM/UwxO+yl7nVJF00sqGk
         d7AD5UzHRa1NjI84Hxoz+s+efE47CeQgKrZgiph2mNdwJC7m3pwY0KcKdxRyftWz+1
         F63gNsi7C/7FbTmapOVHpRS0LWCTWtUe0EH3Crgn6TlVtRtS438i2w2ahGL9/Qq8cd
         mguUY59Nehy7ydcOZ205/5jbvzpVfSGzQ+Do9F1ImBnjdZ5cMqu1QH+qflSUWEVI6f
         cQ05kefvWSwJQ==
Received: by mail-ed1-f41.google.com with SMTP id n2so453928eda.10;
        Tue, 27 Jul 2021 15:17:56 -0700 (PDT)
X-Gm-Message-State: AOAM532LiwSvmkKHi2WW759FIYJyrFHIrA8CpwbEZgKHkQoMYpWpltxw
        6iuVtFszqCrg6WOvi274QRBt9FVpi5XAmBX4kQ==
X-Google-Smtp-Source: ABdhPJyNP8M8aAQKXxx5tCub5TYW/KAfNDMcwrn6O2Dj7lhqKvX7EyCiM+Atq5P85EUfEBlNdMu/b2yTd8MfL06uTNo=
X-Received: by 2002:aa7:cb19:: with SMTP id s25mr30783265edt.194.1627424275171;
 Tue, 27 Jul 2021 15:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626855713.git.mchehab+huawei@kernel.org>
 <946f2426bc542638240980931eae924c57f2ba27.1626855713.git.mchehab+huawei@kernel.org>
 <20210723225059.GA2727093@robh.at.kernel.org> <20210724021244.780297ee@coco.lan>
 <CAL_JsqLA7Z908SQKkZpyEcCvpkWsW3pa42eajpxCSkbUy4rv9g@mail.gmail.com>
 <20210727015020.403bbf73@coco.lan> <20210727085205.5aafb5c9@coco.lan>
In-Reply-To: <20210727085205.5aafb5c9@coco.lan>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 27 Jul 2021 16:17:43 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+5raGQAK5T4SoC=Jfzsbov-y4u-rdJ3DJt+ryYOK8q2w@mail.gmail.com>
Message-ID: <CAL_Jsq+5raGQAK5T4SoC=Jfzsbov-y4u-rdJ3DJt+ryYOK8q2w@mail.gmail.com>
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

On Tue, Jul 27, 2021 at 12:52 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Em Tue, 27 Jul 2021 01:50:20 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:
>
> > Em Mon, 26 Jul 2021 15:37:28 -0600
> > Rob Herring <robh@kernel.org> escreveu:
> >
>
> > > > > > +  reset-gpios:
> > > > > > +    description: PCI PERST reset GPIOs
> > > > > > +    maxItems: 4
> > > > > > +
> > > > > > +  clkreq-gpios:
> > > > > > +    description: Clock request GPIOs
> > > > > > +    maxItems: 3
> > > > >
> > > > > Again, this will not work.
> > > >
> > > > Just to be sure: you're talking about the PERST# gpios (e. g. reset-gpios)
> > > > here, right?
> > >
> > > Both that and CLKREQ.
>
> The original DT from the downstream version (found at Linaro's tree)
> has:
>
>         pcie@f4000000 {
>                 compatible = "hisilicon,hikey970";
> ...
>                 switch,reset-gpios = <&gpio7 0 0 >;
>                 eth,reset-gpios = <&gpio25 2 0 >;
>                 m_2,reset-gpios = <&gpio3 1 0 >;
>                 mini1,reset-gpios = <&gpio27 4 0 >;
>
>                 eth,clkreq-gpios = <&gpio20 6 0 >;
>                 m_2,clkreq-gpios = <&gpio27 3 0 >;
>                 mini1,clkreq-gpios = <&gpio17 0 0 >;
>         };
>
> So, if we're willing to have a single reset-gpios for the PCIe
> interface, in order to follow the current pci-bus.yaml schema,
> this would probably be:
>
>         reset-gpios = <&gpio7 0 0 >;
>
> which maps to the PEX8606 PCIe bridge chip.
>
> With that, DT still need to point a per-slot clkreq and
> reset-gpio.
>
> One alternative would be to map it as either 3 PCI or PHY
> child nodes. E. g. something like this:
>
>         pcie@f4000000 {
>                 compatible = "hisilicon,kirin970-pcie";
> ...
>                 reset-gpios = <&gpio7 0 0 >;
>
>                 slot {
>                         eth {
>                                 reset-gpios = <&gpio25 2 0>;
>                                 clkreq-gpios = <&gpio20 6 0>;
>                         };
>                         m2 {
>                                 reset-gpios = <&gpio3 1 0>;
>                                 clkreq-gpios = <&gpio27 3 0>;
>                         };
>                         mini1 {
>                                 reset-gpios = <&gpio27 4 0>;
>                                 clkreq-gpios = <&gpio17 0 0>;
>                         };
>                 };
>         };
>
>
> Placing the child nodes ("slot"?) at the pci bus properties makes more
> sense to me, but placing them at the PHY node has the advantage of
> only affecting Kirin 970.
>
> In either case, if each child would need a different power supply,
> it won't be hard to add a "slot-supply" property later on.
>
> Would something like that be acceptable for you?

On the right track, but there's already a definition for what child
devices look like in pci2_1.pdf. I think you want something like this:

pcie@f4000000 { // RP: Bus 0, Device 0
    compatible = "hisilicon,kirin970-pcie";
    ...
    reset-gpios = <&gpio7 0 0>;  // PERST to switch

    pcie@0 { // PCIe switch: Bus 1, Device 0
        reg = <0 0 0 0 0>;
        compatible = "pciclass,0604";
        device_type = "pci";

        pcie@1 { // NC (Can omit this node)
            reg = <0x80 0 0 0 0>;
            compatible = "pciclass,0604";
            device_type = "pci";
        };

        pcie@4 { // M.2
            reg = <0x200 0 0 0 0>;
            compatible = "pciclass,0604";
            device_type = "pci";
            reset-gpios = <&gpio7 1 0>; // PERST to M.2 slot
       };

        pcie@5 { // Mini
            reg = <0x280 0 0 0 0>;
            compatible = "pciclass,0604";
            device_type = "pci";
            reset-gpios = <&gpio7 2 0>; // PERST to Mini slot
        };

        pcie@7 { // Ethernet
            reg = <0x380 0 0 0 0>;
            compatible = "pciclass,0604";
            device_type = "pci";
            reset-gpios = <&gpio7 3 0>; // PERST to Ethernet

            ethernet@0 {
                reg = <0 0 0 0 0>;
                local-mac-address = [ 00 01 02 03 04 05 06 ];
            };
        };

        pcie@9 { // NC
            reg = <0x480 0 0 0 0>;
            compatible = "pciclass,0604";
            device_type = "pci";
       };
};

This is based on what you previously sent:
00:00.0 PCI bridge: Huawei Technologies Co., Ltd. Device 3670 (rev 01)
01:00.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI
Express Gen 2 (5.0 GT/s) Switch (rev ba)
02:01.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI
Express Gen 2 (5.0 GT/s) Switch (rev ba)
02:04.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI
Express Gen 2 (5.0 GT/s) Switch (rev ba)
02:05.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI
Express Gen 2 (5.0 GT/s) Switch (rev ba)
02:07.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI
Express Gen 2 (5.0 GT/s) Switch (rev ba)
02:09.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI
Express Gen 2 (5.0 GT/s) Switch (rev ba)
06:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 07)

A few notes:
I left out #size-cells, #address-cells, and ranges for brevity.

I'm not completely sure I've got the bridges mapped to the right
functions on Hikey970. That's my best guess looking at the schematics.
You should be able to confirm which bridge is the parent bridge for
ethernet at least.

The compatible strings aren't strictly needed. Linux doesn't look at them.

There's a pretty complete example in:
arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi

The simplest Linux implementation to handle the above is just walk the
child nodes and get all the 'reset-gpios' properties. That's not the
implementation I think we should have though. We should handle the
GPIO as each bridge is probed and children scanned.

Rob
