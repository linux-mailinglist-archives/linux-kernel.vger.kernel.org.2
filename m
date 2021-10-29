Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D4743FCC8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 14:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbhJ2M7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 08:59:37 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:64247 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbhJ2M7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 08:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1635512226; x=1667048226;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kGqPbd0h3tvmjh82j7vteTCNPQqaMIaKsYGT5beGgLU=;
  b=xJiSMQqeuLRmiBYE9IPUHun/owSuBJKI6jooM+GXYTiflqksr/UG2VVt
   bdiyCGd7QeFfPPvI2fi449VIjQBz+hQK2UBcQDEsOzYqTaob1NO4Wxj99
   vpTHxaHUOgCuRjT2tUu3iHDjtcV5Sw3q6ra5BPXUpDtzCzJ1uHr9J0F0/
   MkxqkAKINEFscsWtOJMFR/ZDDevlKRnjah5nmVgQoI5SnDA10k5Yribdl
   WiJ6ypwuCjpa7PaHTdf/oUYm4JwFlH7EE6s3Hmcv/7RhGSaDUcj2IUZrt
   iSvJd5nZp5XCO6y/0tGjB1UZ1XyvQgetIIE+iZoJ0OQC3mhgYYLrsyhgV
   w==;
IronPort-SDR: DAZjWUtulJBBB+Sw4lw8dphJRnUfomseQVj3P2jeJuGVl+u/1f7GH2lM+L9L4feTgTVH/tbYq+
 +A28zKes9lJcrq98/vvir+BPU+dxnS2jWsHHlEqiMGpYM8hIjtoMiajqeuw76jtdr3Sovu/UEL
 vSQo41q7z23mMqbs1fqeprBQcnSrTx4nK1BmJwUz++aH8Xbad6lIjl7ohmexC8tP0CjnpmuDzn
 iIKTCI0j4YaXIC4HvirSw/zwvFwhpBEOXqqx3EUJc5vsNdXSP1dbk1mMf9QDKjode8lMZ4ZLFj
 0U4WFgZ2jcwafARO9B/LG69+
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="137336076"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Oct 2021 05:57:05 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 29 Oct 2021 05:57:05 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Fri, 29 Oct 2021 05:57:04 -0700
Date:   Fri, 29 Oct 2021 14:58:48 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Rob Herring <robh@kernel.org>
CC:     <p.zabel@pengutronix.de>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: reset: lan966x phy reset driver bindings
Message-ID: <20211029125848.k4vwmzxpljbwlve6@soft-dev3-1.localhost>
References: <20211019115205.1516311-1-horatiu.vultur@microchip.com>
 <20211019115205.1516311-2-horatiu.vultur@microchip.com>
 <YXjD9o8ws5KWlafb@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <YXjD9o8ws5KWlafb@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 10/26/2021 22:13, Rob Herring wrote:

Hi Rob,

> 
> On Tue, Oct 19, 2021 at 01:52:04PM +0200, Horatiu Vultur wrote:
> > Document the lan966x phy reset device driving bindings.
> > It is using register access for the internal PHYs and toggles
> > GPIO for external PHYs.
> >
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > ---
> >  .../bindings/reset/lan966x-phy,rst.yaml       | 53 +++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/reset/lan966x-phy,rst.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/reset/lan966x-phy,rst.yaml b/Documentation/devicetree/bindings/reset/lan966x-phy,rst.yaml
> > new file mode 100644
> > index 000000000000..35a32458cafe
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/reset/lan966x-phy,rst.yaml
> > @@ -0,0 +1,53 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/reset/lan966x-phy,rst.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: Microchip Lan966x PHY Reset
> > +
> > +maintainers:
> > +  - Horatiu Vultur <horatiu.vultur@microchip.com>
> > +
> > +description: |
> > +  The Microchip Lan966x Switch provides 2 internal PHY which needs to be
> > +  released from reset before they can be accessed. Also it might have external
> > +  PHYs which requires to toggle a GPIO before the access to the PHYs.
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: "^phy-reset@[0-9a-f]+$"
> 
> ^reset-controller@[0-9a-f]+$

I will update this

> 
> > +
> > +  compatible:
> > +    const: microchip,lan966x-phy-reset
> > +
> > +  reg:
> > +    items:
> > +      - description: internal phy reset registers
> 
> Just: maxItems: 1

Same here

> 
> > +
> > +  reg-names:
> > +    const: phy
> 
> Not all that useful with only 1 entry.

And here

> 
> > +
> > +  "#reset-cells":
> > +    const: 1
> > +
> > +  external-phy-reset-gpios:
> > +    description: used for release of reset of the external PHY
> > +    maxItems: 1
> 
> This belongs in the external PHY's node.

My problem is if I put this in the external PHY's node, once the switch
gets reset it would reset also the GPIO pin and then it can't connect
to the external PHYs anymore.

The switch will need anyway to call this driver to release the reset of
the internal PHYs, so I was thinking to put also the release of the
external PHYs in the same driver.

Initially we wanted to extend the 'sparx5-switch-reset' driver to do
this but the output of that discussion was to have 2 different drivers,
one for the switch and one for the PHYs.

> 
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +  - "#reset-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    phy_reset: phy-reset@e2010010 {
> > +        compatible = "microchip,lan966x-phy-reset";
> > +        reg = <0xe2010010 0x14>;
> > +        reg-names = "phy";
> > +        #reset-cells = <1>;
> > +    };
> > --
> > 2.33.0
> >
> >

-- 
/Horatiu
