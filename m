Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454C242A771
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 16:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237383AbhJLOl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 10:41:29 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:31911 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237285AbhJLOlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 10:41:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634049561; x=1665585561;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WtvyiwpQIdZSLb8nnAndMS1Cf2XB7Oc9bMXdt1ZKjI8=;
  b=x0rK7ip+hRIiP4az1MXhYo7WJNQJ7SnRnPtc5cN7gGZ+I2GMpPpfW7K+
   +Ec3ORI1H4icEBCsUY7t4619pTZZbc51cOwkesy0W68tkMt8bNJQQQDM9
   a66qq9LiWKaIiP+0Oro70jfhS3GNsX/02K4HlrBlAyfgxJiJnSVOkP3BY
   NVRnDke2gR+tAhM9hdjfI1Fh6XcbxDikg7Bn8Cd8ZltnMpnoUVyHyyFhy
   vP8+rtTx/FMIvuaosQTa5hYYWI4C7cr41w7rDNxis5K65kivrW0iSDXic
   tHzGnVnNwqX93LuU00LwKmSfVM+wAyG4oqu2eiiP695qgh9AQZC5WRwdA
   Q==;
IronPort-SDR: d07ygs5Vjduz6DOM6xDKgqbCuKmg/1GTwqx1wU3Lgl+Ybg81S1Z+7ir49SyqHVhQKSBpWm9ubq
 9mAwirrkE/1cPlHmP+/3W89dQvP0sWNewuyDExl3g/Lb2+UaMPttsbZrb6qXTzff9ewlXZLD3Z
 ebScA9AMtMKjU2ZQg5+5dK34xFS/zyz5mo/JuVRXovvJzBBV29gbWrWoERGO8p0m7pDLy/Cc7G
 FZMaGWA0E5zihjRtVRGWpH3fU3SvWhIb1nVrTRyZXiQE/9tAEsB4XdI48jkB3sW5GFWzolElmH
 NY05ZyIzP97C4HlOZVf6Yjxg
X-IronPort-AV: E=Sophos;i="5.85,367,1624345200"; 
   d="scan'208";a="147780029"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Oct 2021 07:39:21 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 12 Oct 2021 07:39:20 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Tue, 12 Oct 2021 07:39:20 -0700
Date:   Tue, 12 Oct 2021 16:40:52 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
CC:     <robh+dt@kernel.org>, <andrew@lunn.ch>,
        <lars.povlsen@microchip.com>, <Steen.Hegelund@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: reset: Add lan966x support
Message-ID: <20211012144052.pmn4u3s2j27itwxe@soft-dev3-1.localhost>
References: <20211012114238.2060101-1-horatiu.vultur@microchip.com>
 <20211012114238.2060101-2-horatiu.vultur@microchip.com>
 <91ae922d66b4b8c521142c8030bdd1a9f6d2fad1.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <91ae922d66b4b8c521142c8030bdd1a9f6d2fad1.camel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 10/12/2021 15:35, Philipp Zabel wrote:

Hi Philipp,
> 
> Hi Horatiu,
> 
> On Tue, 2021-10-12 at 13:42 +0200, Horatiu Vultur wrote:
> > This adds support for lan966x.
> >
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > ---
> >  .../devicetree/bindings/reset/microchip,rst.yaml   | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/reset/microchip,rst.yaml b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
> > index 370579aeeca1..622cf3d0455d 100644
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
> > +
> > +  gpios:
> 
> From the description I'd expect this to be called phy-reset-gpios.

Yes, I can rename this.

> 
> > +    description: used for release of reset of the external PHY
> > +    maxItems: 1
> > +
> 
> Shouldn't an external PHY be described as a separate DT node, with its
> own reset gpio?

I am not sure, this is more board specific than PHY specific. On lan966x
ung8290 board, the external PHYs are kept in reset until this GPIO is toggled.

> 
> regards
> Philipp

-- 
/Horatiu
