Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7ADE3D68CA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 23:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbhGZU5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 16:57:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229687AbhGZU5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 16:57:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ECD7C60F94;
        Mon, 26 Jul 2021 21:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627335462;
        bh=ZcD1WIUawkgfZBZNJkhH1ow7d5Z+9PDDwa+G0n8VIiQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a9DtXb0KfLUQYkjS+6fbStt58Hvt7ZaEwayUG1vdNoEw6Yj+/JHkUQ5esU+j/dDNS
         iGN4n7N8u4bW/akKlHU3uqPx3v37SUHdH571sR/HzugjqugDMM4MkULF876yBwYJmh
         C68xdeOm1HFpR2h6kfYHehBOZ/4B1ZZ/50vxskO02VT9T8n/lAhDSCxsazmZeuX6yc
         y+EPpxdjPbmClu7zTbfLzAl+X4dhKt8B9jcna9UsL68XBl1Wc1EBIFja4INjTxBvFy
         /0LcB2tfTzROC1X5k1rhlQ4GXEsGkaTGDGDo/7waFDbG2jOX9jtwexnOAeZGLW+DIz
         nTD6D5BNPDsGQ==
Received: by mail-ed1-f45.google.com with SMTP id n2so12508255eda.10;
        Mon, 26 Jul 2021 14:37:41 -0700 (PDT)
X-Gm-Message-State: AOAM530/ZJkaDrmoXIqA+kAWa+afflw2vZNKm7HkOmtNzlz+WANYftmK
        6mlSsdRi8vcqPpt95fC5QCNU7ZpzuvRTEwu/MQ==
X-Google-Smtp-Source: ABdhPJwnjb7lf4erlIvyRSX6CIXgqla4rWiINStqd3VbaIdW9hnyj9zPEA2nNnYWOD02YZlWelOmFPMdXwGo3H7z3R4=
X-Received: by 2002:aa7:cb19:: with SMTP id s25mr24307258edt.194.1627335460433;
 Mon, 26 Jul 2021 14:37:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626855713.git.mchehab+huawei@kernel.org>
 <946f2426bc542638240980931eae924c57f2ba27.1626855713.git.mchehab+huawei@kernel.org>
 <20210723225059.GA2727093@robh.at.kernel.org> <20210724021244.780297ee@coco.lan>
In-Reply-To: <20210724021244.780297ee@coco.lan>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 26 Jul 2021 15:37:28 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLA7Z908SQKkZpyEcCvpkWsW3pa42eajpxCSkbUy4rv9g@mail.gmail.com>
Message-ID: <CAL_JsqLA7Z908SQKkZpyEcCvpkWsW3pa42eajpxCSkbUy4rv9g@mail.gmail.com>
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

On Fri, Jul 23, 2021 at 6:12 PM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Em Fri, 23 Jul 2021 16:50:59 -0600
> Rob Herring <robh@kernel.org> escreveu:
>
> > On Wed, Jul 21, 2021 at 10:39:08AM +0200, Mauro Carvalho Chehab wrote:
> > > Document the bindings for HiKey 970 (hi3670) PCIe PHY
> > > interface, supported via the pcie-kirin driver.
> > >
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > ---
> > >  .../phy/hisilicon,phy-hi3670-pcie.yaml        | 95 +++++++++++++++++++
> > >  1 file changed, 95 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml b/Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml
> > > new file mode 100644
> > > index 000000000000..a5ea13332cac
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml
> > > @@ -0,0 +1,95 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/phy/hisilicon,phy-hi3670-pcie.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: HiSilicon Kirin970 PCIe PHY
> > > +
> > > +maintainers:
> > > +  - Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > +
> > > +description: |+
> > > +  Bindings for PCIe PHY on HiSilicon Kirin 970.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: hisilicon,hi970-pcie-phy
> > > +
> > > +  "#phy-cells":
> > > +    const: 0
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +    description: PHY Control registers
> > > +
> > > +  phy-supply:
> > > +    description: The PCIe PHY power supply
> > > +
> > > +  clocks:
> > > +    items:
> > > +      - description: PCIe PHY clock
> > > +      - description: PCIe AUX clock
> > > +      - description: PCIe APB PHY clock
> > > +      - description: PCIe APB SYS clock
> > > +      - description: PCIe ACLK clock
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: phy_ref
> > > +      - const: aux
> > > +      - const: apb_phy
> > > +      - const: apb_sys
> > > +      - const: aclk
> > > +
> > > +  reset-gpios:
> > > +    description: PCI PERST reset GPIOs
> > > +    maxItems: 4
> > > +
> > > +  clkreq-gpios:
> > > +    description: Clock request GPIOs
> > > +    maxItems: 3
> >
> > Again, this will not work.
>
> Just to be sure: you're talking about the PERST# gpios (e. g. reset-gpios)
> here, right?

Both that and CLKREQ.

> > It boils down to this fails to describe how the GPIOs are connected
> > which is the point of GPIOs in DT. This in no way captures the hierarchy
> > of devices. While you may be lucky that you can just assert or
> > deassert all the lines at one time, that's not likely to work in a
> > more complicated case (such as having to power up/down each device).
>
> There's no way to power up/down each device, as they all share the
> same regulator line (LDO33). So, when this is powered on, all PCI
> devices are powered at the same time.

I understand that for your board, but you could easily have a power
supply per device (or multiple supplies per device).

> The original DT had names for each reset-gpio, but this was just
> informative, as the only possible way for this hardware to work is
> to send the PERST# signal via all GPIOs at the same time.

What's the timing requirement here? I doubt 'at the same time' is the
actual h/w requirement. My guess is it is before the PCI bus scan if
you don't have any hook before each child bus is scanned.

> Ok, we might overdesign the DT, in order to consider a non-existent
> scenario where it would be possible to power on and reset the devices
> in separate, but I can't think on a way to do that, except by maybe
> creating virtual phy (or pcie) DT nodes, one for each combination of
> regulator + PERST#, and have separate drivers for each one. Such kind
> of scenario only makes sense when each PCIe device can be powered on
> independently (which is not the case here).

If someone made hikey970 with the topology you have, then someone can
just as easily make a different topology and one that doesn't work
with the assumptions you've made. We're only going to see more and
more embedded boards with multiple PCI devices.

> If you have a better idea, I'm all ears.

There's already a spec for populating PCI devices in DT. It's existed
for over 20 years with OpenFirmware[1]. It's not widely used on FDT
systems because most cases to date are just a single device attached
and they don't have extra things needing to be described in DT. There
are a few, but not many examples in the tree of PCI devices with DT
nodes. That's the only way to generically describe the topology you
have.

While I haven't seen another case exactly like yours yet, there are
frequent cases of PCI devices (and other discoverable buses) that have
extra resources that are not discoverable. And some of those need
control before the device can be discovered. I see various
work-arounds to the problem, but describing the devices in DT is the
right way. It's only going to get solved if the work-arounds are
rejected. I care more that the DT binding is correct and less if the
kernel side is clean. The kernel implementation can evolve, the DT
cannot.

> > I realize the right solution is more complex, but that's the only way to
> > handle this in a host bridge and board independent way.
> >
> > If you want the simple solution, just configure all these GPIOs in
> > firmware before Linux boots.
>
> This won't work. The PERST# signal should be sent after initializing
> the PCIe + PHY and powering up the PEX8606 PCIe bridge chipset
> (via LDO33). That happens when the PCIe driver is loaded.

Only because you have no hooks for handling PERST# on devices
downstream of the PEX8606. Surely a sequence like this would work:
deassert root PERST# (to PEX8606), scan root bus, find and init PCIe
bridge, deassert PEX8606 child bus(es) PERST#, scan child bus(es),
find and init child devices. I think the .add_bus() hook could work
for you. IIRC, that's called before a child bus is scanned.

Rob

[1] https://www.devicetree.org/open-firmware/home.html#OFDbussupps
