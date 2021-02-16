Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695FC31C764
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 09:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhBPIeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 03:34:02 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:1071 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhBPIdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 03:33:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1613464430; x=1645000430;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UsAM3OgOF88PKPJUrS6PF+V4H++1+TNlVsxMRqoaP3U=;
  b=E/rZpzYQpvgCbr8j0VEG5ys2RklMfs0YIMm9x1T+L1OmmgqB5u+Y7BTs
   CN/41+9pvI5KThBxAY9WJakzFWSB0T3TKDQANTerGo5BDN3wkOQskVftg
   AQ58fQm6kSp2e+oeOiwjeU5Rr4nHNt7cr0lvUPTovh9ORzhaACKqxizUa
   5T5QMfUbc/53mn+lyQwIqfkJNY/c6CGjWWmA9m/meQ+yTjvhzxFK2JHsE
   Fit14a+vQRqIXFF/kD86HpXZXkEXjbpcpCWUQvuTssLJA9jMx7alUS7qR
   P5JUZGIYBjj4XuF1vtdw5i16EJ5ZG1dClybL5kJPniB12IGbELoNsfVpU
   A==;
IronPort-SDR: Gbl2FOFsSdbLZdQpxDwOMALTZtbt5uA9Byb67ABYppXv6QKWsV3YLh31nXPct9ZolxlaMQq4Km
 SfiOXkF49KMFd7tIhCglqO93X8tq8j9mYDKld09z3uJkXY6RDuA/+kGwoy2t7dXVDku9Weo8Bp
 jIbM4TDysPdaOyAMKZ4cJImvae0DhGLsmve/CiDpXXLgnf1qqb2rGGPeec3VPk56SMnM3dfUJL
 M2qaKV4xHA7iVFMrI4pPKzegXtWiR1SQfvKV/q64zRRe7o4eZ/KMcA7hBZM37uGbRVeLRi3Deo
 /5I=
X-IronPort-AV: E=Sophos;i="5.81,183,1610434800"; 
   d="scan'208";a="109335444"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Feb 2021 01:32:32 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 16 Feb 2021 01:32:30 -0700
Received: from tyr.hegelund-hansen.dk (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 16 Feb 2021 01:32:28 -0700
Message-ID: <f4d3c144326ce2984acfbc0e4b04c7f3edd6c4e8.camel@microchip.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: reset: microchip sparx5 reset
 driver bindings
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Date:   Tue, 16 Feb 2021 09:32:28 +0100
In-Reply-To: <20210215173232.GM6798@piout.net>
References: <20210210091952.2013027-1-steen.hegelund@microchip.com>
         <20210210091952.2013027-2-steen.hegelund@microchip.com>
         <20210215173232.GM6798@piout.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Mon, 2021-02-15 at 18:32 +0100, Alexandre Belloni wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you
> know the content is safe
> 
> On 10/02/2021 10:19:50+0100, Steen Hegelund wrote:
> > Document the Sparx5 reset device driver bindings
> > 
> > The driver uses two IO ranges on sparx5 for access to
> > the reset control and the reset status.
> > 
> > Signed-off-by: Steen Hegelund <steen.hegelund@microchip.com>
> > ---
> >  .../bindings/reset/microchip,rst.yaml         | 55
> > +++++++++++++++++++
> >  1 file changed, 55 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/reset/microchip,rst.yaml
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/reset/microchip,rst.yaml
> > b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
> > new file mode 100644
> > index 000000000000..80046172c9f8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
> > @@ -0,0 +1,55 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/reset/microchip,rst.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: Microchip Sparx5 Switch Reset Controller
> > +
> > +maintainers:
> > +  - Steen Hegelund <steen.hegelund@microchip.com>
> > +  - Lars Povlsen <lars.povlsen@microchip.com>
> > +
> > +description: |
> > +  The Microchip Sparx5 Switch provides reset control and
> > implements the following
> > +  functions
> > +    - One Time Switch Core Reset (Soft Reset)
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: "^reset-controller@[0-9a-f]+$"
> > +
> > +  compatible:
> > +    const: microchip,sparx5-switch-reset
> > +
> > +  reg:
> > +    items:
> > +      - description: cpu block registers
> > +      - description: global control block registers
> > +
> > +  reg-names:
> > +    items:
> > +      - const: cpu
> > +      - const: gcb
> > +
> 
> I still think this is not right because then you will be mapping the
> same set of register using multiple drivers without any form of
> synchronisation which will work because you are mapping the region
> without requesting it. But this may lead to issues later.
> 
> At least, you should make cpu start at 0x80 and of size 4. Else, you
> won't be able to define and use the GPRs that are in front of
> CPU_REGS:RESET.
> 
> I would still keep DEVCPU_GCB:CHIP_REGS as a syscon, especially since
> you are mapping the whole set of registers.

Ok.  I will use a syscon for the General Control Block and a very small
range for the CPU Reset register, to minimize the register footprint.

> 
> 
> > +  "#reset-cells":
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +  - "#reset-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    reset: reset-controller@0 {
> > +        compatible = "microchip,sparx5-switch-reset";
> > +        #reset-cells = <1>;
> > +        reg = <0x0 0xd0>,
> > +              <0x11010000 0x10000>;
> > +        reg-names = "cpu", "gcb";
> > +    };
> > +
> > --
> > 2.30.0
> > 
> 
> --
> Alexandre Belloni, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com


Thanks for your comments


-- 
BR
Steen

-=-=-=-=-=-=-=-=-=-=-=-=-=-=
steen.hegelund@microchip.com

