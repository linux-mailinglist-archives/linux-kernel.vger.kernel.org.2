Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3028D42F4F2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 16:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240269AbhJOOO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 10:14:58 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:45209 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240242AbhJOOOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 10:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634307157; x=1665843157;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vhKqUtsyI8eiBctTx58Hoeyu/C3PecsWgYb6HWtRnkE=;
  b=Ks103VOGh3RXLAYqln16j8X9uU5Q03jbAA6sEpM/ugvr/JIMh9kwLsEF
   YF+osDDTbV0x4UYHGqjLd+rJPZlU2JFiYTurXGiX2QZbuOSh0/tRxrdNa
   rIb3gx3u26wxIvBodk6JyyS+NwHOatmO1ao0FyHYra6mYY8tiVs2/v8tO
   5dubiDyH7Sq4FboxTkVpCw391ySep0yg8l/n3B/x3XdVtxw1+QBQDySk+
   K2BXkM57WbszVgJDZTKcsL/TB6mUrc/jvGT40lrSoRgLz4+cLAVOnGc6P
   rna6RM/pf2QiSibV1/Vro7jxdyayJ3iaMhOJtYZ5Co69tTY8LNLs7T/Rs
   g==;
IronPort-SDR: 1LqGw4wudZsJmutI5/fs2v8NG8v+7mJiYQYRu4y36zP4wmYF4uCNxGspx0UXhdrElT1MHs7lEP
 Ef7vJ4FfgE9+LIWpZZxm9MhPU4VudvkJNPqBY5yguc910c2iZcwVZbUKCOGn0aCITjHBzGB3nf
 H1YAuQjfwQLSd3rejtOjlMwl/9Ckznm65ZpCEFQdCeyXGIsbQwFtPWm06RnrS6+G9bmCKx6C+I
 UH8UFtyi6w0St1Ki06pxTuNT23hQK66htkw8kK83WfFbTrAH2Da+V924BLXv63IxLDk04wufU1
 21LHPbbFBS6+qgfToYCxW3KP
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="scan'208";a="148241186"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Oct 2021 07:12:36 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 15 Oct 2021 07:12:36 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Fri, 15 Oct 2021 07:12:36 -0700
Date:   Fri, 15 Oct 2021 16:14:04 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
CC:     <robh+dt@kernel.org>, <andrew@lunn.ch>,
        <lars.povlsen@microchip.com>, <Steen.Hegelund@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: reset: Add lan966x support
Message-ID: <20211015141404.5eiylskcfy2fxi42@soft-dev3-1.localhost>
References: <20211013073807.2282230-1-horatiu.vultur@microchip.com>
 <20211013073807.2282230-2-horatiu.vultur@microchip.com>
 <838af7b574968fc55d517a3becede5fa106ed896.camel@pengutronix.de>
 <20211014152016.wuwaesswc5iiil42@soft-dev3-1.localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20211014152016.wuwaesswc5iiil42@soft-dev3-1.localhost>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 10/14/2021 17:20, Horatiu Vultur wrote:
> Hi Philipp,
> 
> The 10/14/2021 13:55, Philipp Zabel wrote:
> > 
> > On Wed, 2021-10-13 at 09:38 +0200, Horatiu Vultur wrote:
> > > This adds support for lan966x.
> > >
> > > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > > ---
> > >  .../devicetree/bindings/reset/microchip,rst.yaml   | 14 +++++++++++++-
> > >  1 file changed, 13 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/reset/microchip,rst.yaml b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
> > > index 370579aeeca1..fb170ed2c57a 100644
> > > --- a/Documentation/devicetree/bindings/reset/microchip,rst.yaml
> > > +++ b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
> > > @@ -20,7 +20,11 @@ properties:
> > >      pattern: "^reset-controller@[0-9a-f]+$"
> > >
> > >    compatible:
> > > -    const: microchip,sparx5-switch-reset
> > > +    oneOf:
> > > +      - items:
> > > +          - const: microchip,sparx5-switch-reset
> > > +      - items:
> > > +          - const: microchip,lan966x-switch-reset
> > >
> > >    reg:
> > >      items:
> > > @@ -37,6 +41,14 @@ properties:
> > >      $ref: "/schemas/types.yaml#/definitions/phandle"
> > >      description: syscon used to access CPU reset
> > >
> > > +  cuphy-syscon:
> > > +    $ref: "/schemas/types.yaml#/definitions/phandle"
> > > +    description: syscon used to access CuPHY
> > 
> > Can this be used on sparx5?
> 
> No, because the sparx5 doesn't have any internal PHYs that need to
> be released of the reset.
> 
> > Is it optional on lan966x?
> 
> No, it is required on lan966x. I will update the binding to show this.
> 
> > 
> > > +  phy-reset-gpios:
> > > +    description: used for release of reset of the external PHY
> > > +    maxItems: 1
> > > +
> > >  required:
> > >    - compatible
> > >    - reg
> > 
> > I'd like somebody to reassure me that putting the CuPHY reset and
> > external PHY GPIO reset in the reset controller is the right thing to
> > do.
> > 
> > It looks fine to me, but I'm not sure if these should rather be in
> > separate phy nodes that are referenced from the switch.

Were you thinking to have just another reset driver('phy-reset') and then
the switch to refer to both of them?
I like this idea because then is more clear what is doing each driver.

> > 
> > regards
> > Philipp
> 
> -- 
> /Horatiu

-- 
/Horatiu
