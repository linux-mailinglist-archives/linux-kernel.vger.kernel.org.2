Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4FE4331E5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 11:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbhJSJNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 05:13:42 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:63783 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbhJSJNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 05:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634634687; x=1666170687;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SFnbRDPbh9Cnl0CjzDAQQBLnGioAW3IiP6jsl+JbKXg=;
  b=jPym3YQhHt0CQfa0VB3P5O4H4n+lhvg6ET/x7Q515621bxQ6crZFzwaB
   JnrgW6JcJH65dvr5I5AAxEhBrrgP3o0ZObNJBxfJSnHHBE6UjcWm6aXBl
   lOBVjC/2AFwF/Q1BfkHHKmlCenXbRWCXfcV4dSENpof/Vc0qB3YgZBqp7
   6ZFysEOnmz9cceScWWNTgtN5HmxVWlWHhMeh5JyiweOEhh7sNZ0f4i+/M
   K19BwAW0EYz3iy/TrpwHWaFK4VRcXaOwjnd/+IML1kJm7ldbrMizUBd0r
   RDiAlZgp6CEp7WfdoxyVIoVjSPQtcmImd1xZzMNxoYgFKgDfrtlvKlE5N
   Q==;
IronPort-SDR: aDBBwI1xiQi99aA95+ithxdVm7jIv/LL1zMQ24NUTEJ+nGIDBg93FpATujlCl7HSMccbVM6NZm
 0K8LJdN+5aeFshYHkZIkW1ya9l5k+bpP2rvSl9k9tiCc+BmDqtJwkHLn20j7VXW8AFIXGpV8ak
 k0NdEpg2zIDlo2VFwrJN1l6j4tC0xN/sB3t4oCnLYcmJxYDdYUcmIpMJ/3ogQc4c3Eq4hcs+fG
 eBmCm/n5e8Ra4YVNuZkwrPYECeb6Y9gtLbRPuxqxPya04qmdUrHWARXt1zL5ne6G1ELLiejBaU
 XlOAqhh3OP4iO8bt+Oh2tSee
X-IronPort-AV: E=Sophos;i="5.85,383,1624345200"; 
   d="scan'208";a="73497729"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Oct 2021 02:11:26 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 19 Oct 2021 02:11:26 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Tue, 19 Oct 2021 02:11:26 -0700
Date:   Tue, 19 Oct 2021 11:12:58 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Rob Herring <robh@kernel.org>
CC:     <kishon@ti.com>, <vkoul@kernel.org>, <andrew@lunn.ch>,
        <alexandre.belloni@bootlin.com>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: phy: Add constants for lan966x serdes
Message-ID: <20211019091258.3uet6lp3mxaoliqt@soft-dev3-1.localhost>
References: <20211015123920.176782-1-horatiu.vultur@microchip.com>
 <20211015123920.176782-3-horatiu.vultur@microchip.com>
 <YW3K2GX+hmkwt3EE@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <YW3K2GX+hmkwt3EE@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 10/18/2021 14:28, Rob Herring wrote:
> 
> On Fri, Oct 15, 2021 at 02:39:19PM +0200, Horatiu Vultur wrote:
> > Lan966x has: 2 integrated PHYs, 3 SerDes and 2 RGMII interfaces. Which
> > requires to be muxed based on the HW representation.
> >
> > So add constants for each interface to be able to distinguish them.
> >
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > ---
> >  include/dt-bindings/phy/phy-lan966x-serdes.h | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >  create mode 100644 include/dt-bindings/phy/phy-lan966x-serdes.h
> >
> > diff --git a/include/dt-bindings/phy/phy-lan966x-serdes.h b/include/dt-bindings/phy/phy-lan966x-serdes.h
> > new file mode 100644
> > index 000000000000..8a05f93ecf41
> > --- /dev/null
> > +++ b/include/dt-bindings/phy/phy-lan966x-serdes.h
> > @@ -0,0 +1,14 @@
> > +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> > +
> > +#ifndef __PHY_LAN966X_SERDES_H__
> > +#define __PHY_LAN966X_SERDES_H__
> > +
> > +#define PHY(x)               (x)
> > +#define PHY_MAX              PHY(2)
> > +#define SERDES6G(x)  (PHY_MAX + 1 + (x))
> > +#define SERDES6G_MAX SERDES6G(3)
> > +#define RGMII(x)     (SERDES6G_MAX + 1 + (x))
> > +#define RGMII_MAX    RGMII(2)
> > +#define SERDES_MAX   (RGMII_MAX + 1)
> 
> I still don't understand. #phy-cells description says we have:
> 
> <port idx> <serdes idx>
> 
> But here it's 3 numbers. How are these defines used to fill in the 2
> cells?

Actually they are still only a number. Or maybe I am missing something.

Maybe an example will help:

---
serdes: serdes@e2004010 {
    compatible = "microchip,lan966x-serdes";
    reg = <0xe202c000 0x9c>, <0xe2004010 0x4>;
    #phy-cells = <2>;
};

&port0 {
    ...
    phys = <&serdes 0 SERDES6G(1)>;
    ...
};

&port1 {
    ...
    phys = <&serdes 1 PHY(0)>;
    ...
}

...
---

Here are some existing examples based on which I have created this patch
series:
https://elixir.bootlin.com/linux/v5.15-rc6/source/arch/mips/boot/dts/mscc/ocelot_pcb120.dts#L99
https://elixir.bootlin.com/linux/v5.15-rc6/source/arch/mips/boot/dts/mscc/ocelot.dtsi#L274

> 
> Rob

-- 
/Horatiu
