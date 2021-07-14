Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0103E3C8635
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 16:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239469AbhGNOex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 10:34:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231994AbhGNOev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 10:34:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 794F6611C0;
        Wed, 14 Jul 2021 14:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626273120;
        bh=yOtNr7+suOgCN8lqCfrgSJAyiWcSVdSY6iRNrdbFZhk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CUy3JmLCk2IixwQv/YKxv0BOKrIP0Wng778B2qv0WWTi1D3mA4pwYuluzh1lT5sSH
         pUKvskeYOIZERqRWJ4F6TBvBz7GPpeJeRDTBiSLHmvu09MepIoWnlyu5zdfnHNaWZo
         jOHlJuG/JLPdGOSNyPSPU3s5SAIxvf+xEzmrCVHmVs4bh4pimol5Bi/q36n6KSmeKr
         FC+9YwtZ2RvfPaaVo/ekzvTcf5A8vKqP8ZIjegfPhq0vgOfQXdg7zoTGqVERwkf1to
         C/DHZQjLJw8xnjxNETTkpYJc2b8fRhIfRfAFRdfysueWqUmefn2K7e7akTXXzdqRpZ
         c/7Rh0WShWwhg==
Date:   Wed, 14 Jul 2021 16:31:54 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Linuxarm <linuxarm@huawei.com>,
        mauro.chehab@huawei.com, Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v5 2/8] dt-bindings: phy: Add bindings for HiKey 970
 PCIe PHY
Message-ID: <20210714163154.02e7d5b9@coco.lan>
In-Reply-To: <CAL_JsqJehoGakG1kXs8XC_c4UHfVE9oF2M3Ww9eizCa_Jn_TDQ@mail.gmail.com>
References: <cover.1626157454.git.mchehab+huawei@kernel.org>
        <baa7e71e13953b28a11fffdcef35195099feb7fd.1626157454.git.mchehab+huawei@kernel.org>
        <20210714022649.GA1324196@robh.at.kernel.org>
        <20210714091435.322d68b1@coco.lan>
        <CAL_JsqJehoGakG1kXs8XC_c4UHfVE9oF2M3Ww9eizCa_Jn_TDQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 14 Jul 2021 08:17:05 -0600
Rob Herring <robh@kernel.org> escreveu:

> On Wed, Jul 14, 2021 at 1:14 AM Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> >
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
> >         https://github.com/96boards/documentation/raw/master/consumer/hikey/hikey960/hardware-docs/HiKey960_SoC_Reference_Manual.pdf
> >         https://www.96boards.org/documentation/consumer/hikey/hikey970/hardware-docs/files/hikey970-schematics.pdf
> >
> > The 960 PHY has the SoC directly connected to a PCIE M.2 slot
> > (model 10130616) without any external bridge chipset. It uses a single
> > GPIO (GPIO 089) for the PERST# signal, connected via a voltage converter
> > (from 1.8V to 3.3V).
> >
> >         $ lspci
> >         00:00.0 PCI bridge: Huawei Technologies Co., Ltd. Device 3660 (rev 01)
> >
> > The 970 PHY has an external PCI bridge chipset (PLX Technology PEX 8606).
> > Besides the bridge, the hardware comes with an Ethernet PCI adapter, a
> > M.2 slot and a mini-PCIe connector. Each one with its own PERST# signal,
> > mapped to different GPIO pins, and each one using its own voltage
> > converter.
> >
> >         $ lspci
> >         00:00.0 PCI bridge: Huawei Technologies Co., Ltd. Device 3670 (rev 01)
> >         01:00.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
> >         02:01.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
> >         02:04.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
> >         02:05.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
> >         02:07.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
> >         02:09.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
> >         06:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 07)
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
> 
> This hierarchy could be done on any board. It has nothing to do with the PHY.

True, but right now, the pci-bus.yaml prevents it, as it allows just 
one reset GPIO[1]:

  reset-gpios:
    description: GPIO controlled connection to PERST# signal
    maxItems: 1

[1] https://github.com/robherring/dt-schema/blob/master/schemas/pci/pci-bus.yaml

If the schema will be changed to allow multiple reset-gpios, It should
be possible to keep this at the pcie-kirin.c driver with something like:

	static int kirin_pcie_power_on(struct kirin_pcie *kirin_pcie)
	{
		int ret;

		ret = phy_init(kirin_pcie->phy);
		if (ret)
			return ret;

		ret = phy_power_on(kirin_pcie->phy);

                /* perst assert Endpoints */
                usleep_range(21000, 23000);
                for (i = 0; i < phy->n_gpio_resets; i++) {
                        ret = gpio_direction_output(phy->gpio_id_reset[i], 1);
                        if (ret) {
				phy_power_off(kirin_pcie->phy);
                                return ret;
			}
                }
                usleep_range(10000, 11000);

		return phy_reset(kirin_pcie->phy);
	}

This would work for both 960 - where phy_reset() is not needed,
and for 970, where it would set the eye diagram for the PHY.

Should I send a patch for pci-bus.yaml via github?

Thanks,
Mauro
