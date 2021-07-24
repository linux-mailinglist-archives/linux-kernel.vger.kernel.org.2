Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56CAA3D43E2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 02:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbhGWXci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 19:32:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:43278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233558AbhGWXcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 19:32:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ECE6F60E8F;
        Sat, 24 Jul 2021 00:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627085570;
        bh=tZzsGQbCVxqev5G3k7WUFXUgpMB0JBN7B4ZZPYZRAZw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SR2vuI6t07CVs99l+aQJu9Hkz1PJkRZ7xUXT+DJl70ukAsfxdbwZ33dUqgBLzlEpk
         /53ho9YnR/WKtmO+xlk8d2q2t7p6c8vf9zWRzc8IBchVLLXGFNNl8M9A49u8QsrBiF
         yFoVnKzj7UCIKDZZxaR4LQ7Ykygx94NrIQo4u8yCovX/HLL7NzhDn8E4CcTtIG2RQN
         Vve2EwSsDZTSeSX9LwKzBO6KFGnoN3vwt4AUcHrM5VK5vrlnSwwrXdF4GVkSV5Q/Io
         SOvcwEtszVHEe7CExGm8rc+bQyskVbx9yIcgig7tXtrXWUTVFDQJUFGfn1hoLGiwLA
         jwyss24F0Mw5A==
Date:   Sat, 24 Jul 2021 02:12:44 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v7 06/10] dt-bindings: phy: Add bindings for HiKey 970
 PCIe PHY
Message-ID: <20210724021244.780297ee@coco.lan>
In-Reply-To: <20210723225059.GA2727093@robh.at.kernel.org>
References: <cover.1626855713.git.mchehab+huawei@kernel.org>
        <946f2426bc542638240980931eae924c57f2ba27.1626855713.git.mchehab+huawei@kernel.org>
        <20210723225059.GA2727093@robh.at.kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 23 Jul 2021 16:50:59 -0600
Rob Herring <robh@kernel.org> escreveu:

> On Wed, Jul 21, 2021 at 10:39:08AM +0200, Mauro Carvalho Chehab wrote:
> > Document the bindings for HiKey 970 (hi3670) PCIe PHY
> > interface, supported via the pcie-kirin driver.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  .../phy/hisilicon,phy-hi3670-pcie.yaml        | 95 +++++++++++++++++++
> >  1 file changed, 95 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml b/Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml
> > new file mode 100644
> > index 000000000000..a5ea13332cac
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml
> > @@ -0,0 +1,95 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/phy/hisilicon,phy-hi3670-pcie.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: HiSilicon Kirin970 PCIe PHY
> > +
> > +maintainers:
> > +  - Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > +
> > +description: |+
> > +  Bindings for PCIe PHY on HiSilicon Kirin 970.
> > +
> > +properties:
> > +  compatible:
> > +    const: hisilicon,hi970-pcie-phy
> > +
> > +  "#phy-cells":
> > +    const: 0
> > +
> > +  reg:
> > +    maxItems: 1
> > +    description: PHY Control registers
> > +
> > +  phy-supply:
> > +    description: The PCIe PHY power supply
> > +
> > +  clocks:
> > +    items:
> > +      - description: PCIe PHY clock
> > +      - description: PCIe AUX clock
> > +      - description: PCIe APB PHY clock
> > +      - description: PCIe APB SYS clock
> > +      - description: PCIe ACLK clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: phy_ref
> > +      - const: aux
> > +      - const: apb_phy
> > +      - const: apb_sys
> > +      - const: aclk
> > +
> > +  reset-gpios:
> > +    description: PCI PERST reset GPIOs
> > +    maxItems: 4
> > +
> > +  clkreq-gpios:
> > +    description: Clock request GPIOs
> > +    maxItems: 3  
> 
> Again, this will not work. 

Just to be sure: you're talking about the PERST# gpios (e. g. reset-gpios)
here, right?

> It boils down to this fails to describe how the GPIOs are connected 
> which is the point of GPIOs in DT. This in no way captures the hierarchy 
> of devices. While you may be lucky that you can just assert or 
> deassert all the lines at one time, that's not likely to work in a 
> more complicated case (such as having to power up/down each device).

There's no way to power up/down each device, as they all share the
same regulator line (LDO33). So, when this is powered on, all PCI
devices are powered at the same time.

The original DT had names for each reset-gpio, but this was just
informative, as the only possible way for this hardware to work is
to send the PERST# signal via all GPIOs at the same time.

Ok, we might overdesign the DT, in order to consider a non-existent
scenario where it would be possible to power on and reset the devices 
in separate, but I can't think on a way to do that, except by maybe
creating virtual phy (or pcie) DT nodes, one for each combination of
regulator + PERST#, and have separate drivers for each one. Such kind
of scenario only makes sense when each PCIe device can be powered on
independently (which is not the case here).

If you have a better idea, I'm all ears.

> 
> I realize the right solution is more complex, but that's the only way to 
> handle this in a host bridge and board independent way.
> 
> If you want the simple solution, just configure all these GPIOs in 
> firmware before Linux boots.

This won't work. The PERST# signal should be sent after initializing
the PCIe + PHY and powering up the PEX8606 PCIe bridge chipset
(via LDO33). That happens when the PCIe driver is loaded.

Thanks,
Mauro
