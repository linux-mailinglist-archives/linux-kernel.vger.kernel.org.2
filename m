Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAAC3C89F4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 19:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239848AbhGNRpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 13:45:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:60634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230170AbhGNRpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 13:45:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84F8E613AB;
        Wed, 14 Jul 2021 17:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626284553;
        bh=TkCzfR8l+WPsOeYqxQfU5E9hJqIQYCL4keS+qZTCaUE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xn8MwWL+QbFcwRBdQbnIVVEdQdQxZ9Rxbe8Z+VWr9PrdXi3BUYwJPIGq85wnPVltZ
         zgDpxKPPwPOwpMhWm+Oq8NpcYL6ct9E5sGOjE879izdAIWdjKeMuaDtxZ0N2JWSxRl
         /zvcXr0KMw7oLyzAKTFi0t91khx5uoPXTjddOBtD7fYqkEILdJTu3+7hcQsHqHMYeq
         McFKAoYYM0JFIGB5NjNdHTXcZUMfJSvr6QywTd9AdzLquifr1f5Al6tHNXgI00gGq+
         3jkaU1Cee9llFcyaE15yQl7SPj0DcbTz8/WYkaTbK/6CmzHvGNQxCNNw8skKKUcySx
         37cU3w0sGS7MQ==
Date:   Wed, 14 Jul 2021 23:12:25 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v5 2/8] dt-bindings: phy: Add bindings for HiKey 970 PCIe
 PHY
Message-ID: <20210714174225.GA8988@workstation>
References: <cover.1626157454.git.mchehab+huawei@kernel.org>
 <baa7e71e13953b28a11fffdcef35195099feb7fd.1626157454.git.mchehab+huawei@kernel.org>
 <20210714022649.GA1324196@robh.at.kernel.org>
 <20210714091435.322d68b1@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714091435.322d68b1@coco.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On Wed, Jul 14, 2021 at 09:14:35AM +0200, Mauro Carvalho Chehab wrote:
> Em Tue, 13 Jul 2021 20:26:49 -0600
> Rob Herring <robh@kernel.org> escreveu:
> 
> > On Tue, Jul 13, 2021 at 08:28:35AM +0200, Mauro Carvalho Chehab wrote:
> 
> > > +  reset-gpios:
> > > +    description: PCI PERST reset GPIOs
> > > +    maxItems: 4  
> > 
> > Hiding the 4 ports in the phy?
> 
> Rob,
> 
> I'm not trying to hide anything.
> 
> There are several differences with regards to how PERST# is handled between
> HiKey 960 and HiKey 970.
> 
> From hardware perspective, you can see the schematics of both boards:
> 
> 	https://github.com/96boards/documentation/raw/master/consumer/hikey/hikey960/hardware-docs/HiKey960_SoC_Reference_Manual.pdf
> 	https://www.96boards.org/documentation/consumer/hikey/hikey970/hardware-docs/files/hikey970-schematics.pdf
> 
> The 960 PHY has the SoC directly connected to a PCIE M.2 slot 
> (model 10130616) without any external bridge chipset. It uses a single 
> GPIO (GPIO 089) for the PERST# signal, connected via a voltage converter
> (from 1.8V to 3.3V).
> 
> 	$ lspci
> 	00:00.0 PCI bridge: Huawei Technologies Co., Ltd. Device 3660 (rev 01)
> 
> The 970 PHY has an external PCI bridge chipset (PLX Technology PEX 8606).
> Besides the bridge, the hardware comes with an Ethernet PCI adapter, a
> M.2 slot and a mini-PCIe connector. Each one with its own PERST# signal,
> mapped to different GPIO pins, and each one using its own voltage
> converter.
> 
> 	$ lspci
> 	00:00.0 PCI bridge: Huawei Technologies Co., Ltd. Device 3670 (rev 01)
> 	01:00.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
> 	02:01.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
> 	02:04.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
> 	02:05.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
> 	02:07.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
> 	02:09.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
> 	06:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 07)
> 
> On other words, there are 4 GPIOs mapped to different PERST# pins in
> the hardware:
> 
> - GPIO 56 is connected to the PERST# pin at PEX 8606;
> - GPIO 25 is connected to the PERST# pin at the M.2 slot;
> - GPIO 220 is connected to the PERST# pin at the PCIe mini slot;
> - GPIO 203 is connected to the PERST# pin at the Ethernet chipset.
> 
> Maybe due to different electrical requirements, the hardware design
> use different GPIOs instead of feeding them altogether.
> 
> Anyway, the fact is that the PHY on 970 has 4 different GPIOs that are
> need in order for the hardware to work. and this is specific to this
> particular PHY.
> 

I'm not sure about this. That fact that the PCIe device's PERST# signal
wired to different GPIOs doesn't mean that those GPIOs belong to the PHY.
Those GPIOs should be independent of the PCIe core controlled manually
by the driver.

I think this issue is somewhat similar to the one we are dealing on the
Qcom platforms [1] where each PCIe device uses a different GPIO and voltage
config to operate. And those need to be active for the link training to
succeed.

So perhaps we should aim for a common solution? The GPIO and voltage
layout should be described in DT for each port exposed by the SoC/board.

Thanks,
Mani

[1] https://lkml.org/lkml/2021/6/21/1524
