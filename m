Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80AB142DDF2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 17:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbhJNPUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 11:20:50 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:50433 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbhJNPUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 11:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634224724; x=1665760724;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z7CD2Tv4qDXC2h6Botmdx0mIsBjOQ6u1ErVrgraCLuE=;
  b=u15fJyoZd1vhdltU9DrJdq3gF5LDjiUPE1YQVmRXJ5rAZzMOtx9yHQFP
   AWpGulhw1RQs+AWmon46OXCKOmtChWaRLj8rK4gGAN9r20MoZwVjCwrry
   AzMdZozMbmunEEWYRIBj51JHcWEmm8iCxOTZXmw2cYoqCI3xiK74Wq6Q5
   Ug6JLP1kQwxQqiQaqKT1dwXsc0IX+pVjExJBm+NvzA+kwcTX6+KmO6TCt
   TmyElXBOFvroOTF5njEDs1tJ+oX5XVc0hlyN+rLEDIsZyN1kc2lL+UEhv
   z0ak5AoE/7Spto4Mt6GPHONalvNeXOtuqi8sBR6YOro1iVAklr2hYwh1G
   Q==;
IronPort-SDR: r3p/gD8jDs0V9OQjJbiEaAgfVUonEWenthRCyR5Ha5mmECaVwqWrfUhSdRRvlPYfDzTIuH8MgP
 CzuoDAV82yG4t4OM1jj8YFD6KRbbFvppx2kCwsDK/hq+ur1dOVm8xvZYSluyBuZfmkz/KutKtL
 lnPtTXHF6SMcf2sA/fAT56ScaW9uZvK/d3xi0FoWRIztFdm2TOTFpYEF38Z7ck9Q5zVx/gEPlS
 kT+BBdmwOK/YY2PJB1DKb4jMmkZe8C0QVW3zKfbq8XBkXLgLMTDlRwscuDQ+BamMDiJfqXVSs6
 0gz/Y22xDo749DcDdP2uhLAk
X-IronPort-AV: E=Sophos;i="5.85,372,1624345200"; 
   d="scan'208";a="135530014"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Oct 2021 08:18:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 14 Oct 2021 08:18:42 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Thu, 14 Oct 2021 08:18:42 -0700
Date:   Thu, 14 Oct 2021 17:20:16 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
CC:     <robh+dt@kernel.org>, <andrew@lunn.ch>,
        <lars.povlsen@microchip.com>, <Steen.Hegelund@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: reset: Add lan966x support
Message-ID: <20211014152016.wuwaesswc5iiil42@soft-dev3-1.localhost>
References: <20211013073807.2282230-1-horatiu.vultur@microchip.com>
 <20211013073807.2282230-2-horatiu.vultur@microchip.com>
 <838af7b574968fc55d517a3becede5fa106ed896.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <838af7b574968fc55d517a3becede5fa106ed896.camel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

The 10/14/2021 13:55, Philipp Zabel wrote:
> 
> On Wed, 2021-10-13 at 09:38 +0200, Horatiu Vultur wrote:
> > This adds support for lan966x.
> >
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > ---
> >  .../devicetree/bindings/reset/microchip,rst.yaml   | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/reset/microchip,rst.yaml b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
> > index 370579aeeca1..fb170ed2c57a 100644
> > --- a/Documentation/devicetree/bindings/reset/microchip,rst.yaml
> > +++ b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
> > @@ -20,7 +20,11 @@ properties:
> >      pattern: "^reset-controller@[0-9a-f]+$"
> >
> >    compatible:
> > -    const: microchip,sparx5-switch-reset
> > +    oneOf:
> > +      - items:
> > +          - const: microchip,sparx5-switch-reset
> > +      - items:
> > +          - const: microchip,lan966x-switch-reset
> >
> >    reg:
> >      items:
> > @@ -37,6 +41,14 @@ properties:
> >      $ref: "/schemas/types.yaml#/definitions/phandle"
> >      description: syscon used to access CPU reset
> >
> > +  cuphy-syscon:
> > +    $ref: "/schemas/types.yaml#/definitions/phandle"
> > +    description: syscon used to access CuPHY
> 
> Can this be used on sparx5?

No, because the sparx5 doesn't have any internal PHYs that need to
be released of the reset.

> Is it optional on lan966x?

No, it is required on lan966x. I will update the binding to show this.

> 
> > +  phy-reset-gpios:
> > +    description: used for release of reset of the external PHY
> > +    maxItems: 1
> > +
> >  required:
> >    - compatible
> >    - reg
> 
> I'd like somebody to reassure me that putting the CuPHY reset and
> external PHY GPIO reset in the reset controller is the right thing to
> do.
> 
> It looks fine to me, but I'm not sure if these should rather be in
> separate phy nodes that are referenced from the switch.
> 
> regards
> Philipp

-- 
/Horatiu
