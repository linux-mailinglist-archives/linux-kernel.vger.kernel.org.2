Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D483C98D7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 08:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbhGOGkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 02:40:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231149AbhGOGkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 02:40:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3239561260;
        Thu, 15 Jul 2021 06:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626331034;
        bh=aGEHrV/rpUEWOWqAEiPjKe1RFXbQnO8o1vEWbtoEo2k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oNw/G78O5xC1KuhLj+qCVJEpH+CFRpYOdthOg0zjDVlekWBXddUuaiQj8WOpr7Esr
         snM3V6EsInLhXStQPK8Tuj+4dw0LaYKpXRNpZ7UKrcvTV/kq5itm+goOeZ+AxWmucz
         uGG9tay/iSlRRedM4j+FtZfjZwGuZzBXGQF+4K5+PSHHm9pux24kjVrMs8C81S6/mI
         rTB9MQXjXYqFt8r1aH7gSSB9R0WEdHZHNtNhvvB33+PKIoJfJzM4SuNuYQNfw+cD54
         WR7AqcZ4bkqJ0zct6z8fgH9rOnNmbkrauOEsemP+eVkHHmektR+YHy9PlixaYeHtjd
         pQf3myhfIJjRg==
Date:   Thu, 15 Jul 2021 08:37:09 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v5 2/8] dt-bindings: phy: Add bindings for HiKey 970
 PCIe PHY
Message-ID: <20210715083709.35dade89@coco.lan>
In-Reply-To: <20210714174225.GA8988@workstation>
References: <cover.1626157454.git.mchehab+huawei@kernel.org>
        <baa7e71e13953b28a11fffdcef35195099feb7fd.1626157454.git.mchehab+huawei@kernel.org>
        <20210714022649.GA1324196@robh.at.kernel.org>
        <20210714091435.322d68b1@coco.lan>
        <20210714174225.GA8988@workstation>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mani,

Em Wed, 14 Jul 2021 23:12:25 +0530
Manivannan Sadhasivam <mani@kernel.org> escreveu:

> Hi Mauro,
> 
> On Wed, Jul 14, 2021 at 09:14:35AM +0200, Mauro Carvalho Chehab wrote:
> > Em Tue, 13 Jul 2021 20:26:49 -0600
> > Rob Herring <robh@kernel.org> escreveu:
> >   
> > > On Tue, Jul 13, 2021 at 08:28:35AM +0200, Mauro Carvalho Chehab wrote:  
> >   
> > > > +  reset-gpios:
> > > > +    description: PCI PERST reset GPIOs
> > > > +    maxItems: 4    
> > > 
> > > Hiding the 4 ports in the phy?  
> > 
> > Rob,
> > 
> > I'm not trying to hide anything.
> > 
> > There are several differences with regards to how PERST# is handled between
> > HiKey 960 and HiKey 970.
> > 
> > From hardware perspective, you can see the schematics of both boards:
> > 
> > 	https://github.com/96boards/documentation/raw/master/consumer/hikey/hikey960/hardware-docs/HiKey960_SoC_Reference_Manual.pdf
> > 	https://www.96boards.org/documentation/consumer/hikey/hikey970/hardware-docs/files/hikey970-schematics.pdf
> > 
> > The 960 PHY has the SoC directly connected to a PCIE M.2 slot 
> > (model 10130616) without any external bridge chipset. It uses a single 
> > GPIO (GPIO 089) for the PERST# signal, connected via a voltage converter
> > (from 1.8V to 3.3V).
> > 
> > 	$ lspci
> > 	00:00.0 PCI bridge: Huawei Technologies Co., Ltd. Device 3660 (rev 01)
> > 
> > The 970 PHY has an external PCI bridge chipset (PLX Technology PEX 8606).
> > Besides the bridge, the hardware comes with an Ethernet PCI adapter, a
> > M.2 slot and a mini-PCIe connector. Each one with its own PERST# signal,
> > mapped to different GPIO pins, and each one using its own voltage
> > converter.
> > 
> > 	$ lspci
> > 	00:00.0 PCI bridge: Huawei Technologies Co., Ltd. Device 3670 (rev 01)
> > 	01:00.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
> > 	02:01.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
> > 	02:04.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
> > 	02:05.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
> > 	02:07.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
> > 	02:09.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
> > 	06:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 07)
> > 
> > On other words, there are 4 GPIOs mapped to different PERST# pins in
> > the hardware:
> > 
> > - GPIO 56 is connected to the PERST# pin at PEX 8606;
> > - GPIO 25 is connected to the PERST# pin at the M.2 slot;
> > - GPIO 220 is connected to the PERST# pin at the PCIe mini slot;
> > - GPIO 203 is connected to the PERST# pin at the Ethernet chipset.
> > 
> > Maybe due to different electrical requirements, the hardware design
> > use different GPIOs instead of feeding them altogether.
> > 
> > Anyway, the fact is that the PHY on 970 has 4 different GPIOs that are
> > need in order for the hardware to work. and this is specific to this
> > particular PHY.
> >   
> 
> I'm not sure about this. That fact that the PCIe device's PERST# signal
> wired to different GPIOs doesn't mean that those GPIOs belong to the PHY.
> Those GPIOs should be independent of the PCIe core controlled manually
> by the driver.
> 
> I think this issue is somewhat similar to the one we are dealing on the
> Qcom platforms [1] where each PCIe device uses a different GPIO and voltage
> config to operate. And those need to be active for the link training to
> succeed.
> 
> So perhaps we should aim for a common solution? The GPIO and voltage
> layout should be described in DT for each port exposed by the SoC/board.

It doesn't seem to be the same case. In the case of Hikey 970[1], it uses
one pullup for each GPIO to convert from 1V8 to the voltage needed by
each chipset. There's no regulators envolved: the output voltage is
fixed. From the diagram, it seems that PEX8606 uses 2V5 (via U2602), while 
the other 3 GPIOs (M.2, PCIe mini and Ethernet) use 3V3. Interesting
enough, the layout uses a separate gate chip for Ethernet (U3107),
while both M.2 and PCIe mini use two ports at the same gate chip (U2801).

[1] https://www.96boards.org/documentation/consumer/hikey/hikey970/hardware-docs/files/hikey970-schematics.pdf

I can think on a couple of reasons why the hardware designers opted to
use 4 different GPIOs:

- the PCIe external bridge required a lower voltage;
- the current drained by each output port could be different;
- the chips used by the pullup could have some sort of protection to
  minimize the risk of damaging the hardware due to a bad contact
  and/or short circuit (for M.2 and PCIe mini connectors).

In any case, from DT perspective, the only thing that makes sense to
expose are the 4 GPIOs used by the PERST# signal, as the output voltages
and max currents are fixed.

Conceptually, IMO, such pullup logic can be considered as part of 
the physical layer, but, as Rob pointed, all PCIe devices need to
have PERST#. So, they could be just mapped as gpio-resets at the
PCIe OF node.

In summary, IMO, mapping those 4 GPIOs via DT can be done by
either:

1. Place all of them at the PCIe OF node;
2. Place all of them at the PHY OF node;
3. Place one of them at the PCIe, and the other three at PHY.

IMO, (3) is messier. So, I would go either for (1) or (2). Between them,
I don't have any preferences, as both would work.

Right now, pci-bus.yaml doesn't allow (1), as it limits reset-gpios
to a maximum of 1 item, but this is easily fixable, but it requires
a patch against https://github.com/devicetree-org/dt-schema to raise
MaxItems to at least 4.

Rob,

Among the above alternatives, what do you prefer?

Thanks,
Mauro
