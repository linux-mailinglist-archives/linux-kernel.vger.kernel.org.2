Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCBCF42EC52
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 10:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbhJOIaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 04:30:24 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:60948 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbhJOIaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634286495; x=1665822495;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v2/wdh25geUQc4WZEx7PPWApAsS6DjRgShuqkzLgWjc=;
  b=hrDG7Z3BA5tloCcXlw2pljulWGU8AIRyjrRTJGvO9UYBxhFyOtDfGI0w
   xAeaV40zCqy2U6O8zUqFLwf84jCc3ljbR49eA7MR5Obp27Z1DXxplfSi2
   SW+6SKL3E/zh3jLY5bRg15HppdlajWYFftKjVhu3kgWyT40AepTSJWPq4
   3oGd9u7i0Tm3jz+NC77oZ9fUkIuOyVzLJqIcYpyRG0oMlcpvO8iqIHjHs
   qOTWL0GF+RtCeMn5/uDnVj52olPNrlMqfT/F5jk6ePBEMIAGkc+BBFpsA
   Pcx74AfTRDBNnT6d/RH3J7aJR1ySn6yje1VfFOuRqOEY0o02Re1hopU5Y
   g==;
IronPort-SDR: KvEvlsXEeaAxDadhXz04g9fL5gozd+Ei/bzxt/j+UEvxoFi1y1AJG0Uw6E+MeNOJ5vl6MD1Hvp
 mMN8y8g139k4wc5fT0ZkGWvkhtQaqQXR6YY5f+DYTAAhPhQ6+Hl/5xsDJhzgerTAixnvajXvNE
 2rQL87E02PjP20uxQi+S8v0QeQkM0I6f6TTh9DMy78i5MxiDJEFhtCly9oiRdPLR4Q6O7eO59M
 ZfTKLYXQXUPyamtVe2rci4z6VTQ2mjEoLHUgtU63lO52IH8zZBRPTAoyulU1PBbGMKXCPh6eII
 DAw39jK2XX8WsABxsnYdS1bx
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="scan'208";a="133108709"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Oct 2021 01:28:14 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 15 Oct 2021 01:28:14 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Fri, 15 Oct 2021 01:28:14 -0700
Date:   Fri, 15 Oct 2021 10:29:42 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Rob Herring <robh@kernel.org>
CC:     <kishon@ti.com>, <vkoul@kernel.org>, <linux@armlinux.org.uk>,
        <andrew@lunn.ch>, <alexandre.belloni@bootlin.com>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: phy: Add binding includes for
 lan966x serdes
Message-ID: <20211015082942.fpyanrg6on3wgzbp@soft-dev3-1.localhost>
References: <20211006063523.3962427-1-horatiu.vultur@microchip.com>
 <20211006063523.3962427-3-horatiu.vultur@microchip.com>
 <YWh2J32hZftzIi+F@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <YWh2J32hZftzIi+F@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 10/14/2021 13:25, Rob Herring wrote:

> 
> On Wed, Oct 06, 2021 at 08:35:22AM +0200, Horatiu Vultur wrote:
> > Add include bindings for lan966x serdes
> >
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > ---
> >  include/dt-bindings/phy/lan966x_serdes.h | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >  create mode 100644 include/dt-bindings/phy/lan966x_serdes.h
> >
> > diff --git a/include/dt-bindings/phy/lan966x_serdes.h b/include/dt-bindings/phy/lan966x_serdes.h
> > new file mode 100644
> > index 000000000000..06e529473475
> > --- /dev/null
> > +++ b/include/dt-bindings/phy/lan966x_serdes.h
> > @@ -0,0 +1,14 @@
> > +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> > +
> > +#ifndef __LAN966X_SERDES_H__
> > +#define __LAN966X_SERDES_H__
> > +
> > +#define CU(x)                (x)
> > +#define CU_MAX               CU(2)
> > +#define SERDES6G(x)  (CU_MAX + 1 + (x))
> > +#define SERDES6G_MAX SERDES6G(3)
> > +#define RG(x)                (SERDES6G_MAX + 1 + (x))
> > +#define RG_MAX               RG(2)
> > +#define SERDES_MAX   (RG_MAX + 1)
> 
> I'm guessing these are used for the phy cells? If so, I can't figure out
> how and I shouldn't have to search the driver to figure it out.

These are just some constatns to be able to select between the
integrated PHYs, RGMII, SerDes interfaces. Because these interfaces
needs to be muxed according to the HW.

This is something similar with the Ocelot Serdes where there are only
2 Serdes types.

> 
> What's CU? What's RG?

Cu - copper PHY
RG - RGMII

I will create a new version where I will improve the log message.

-- 
/Horatiu
