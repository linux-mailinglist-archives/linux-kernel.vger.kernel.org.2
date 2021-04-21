Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6693B36752E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 00:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236263AbhDUWcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 18:32:25 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:43979 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbhDUWcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 18:32:24 -0400
Received: by mail-oi1-f181.google.com with SMTP id x20so10190104oix.10;
        Wed, 21 Apr 2021 15:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pJS91dUrjK9PabCMqdvfN/5r3xfPYnYNUCDr56dm7/I=;
        b=UBOn/X1aGGdhJEq8hQNBGvjo0Q1CzNarDm3BwhG4QItMCYlt7W4w9dBRfJfDwY79HG
         XxHO89KMRhF7hh0UbiPx7yAgFFINaTOc1H1v21DrhHcLZ4ZjTUCG16eDQTHJAHN5laiq
         C7YIXSfHoz1YUoDGiFMhWIrpeZh6Wktsu3oGeWY5ibJP+6IJ32ZVKYj1kOAX16IRfCl9
         sS7U+UyLwGpCIUzXUG9m8B7JGuoYNwOEebWxrUzHloqrfLc1UEgSbACTzlnGhOq3XQoJ
         hWhZLuGl+oEzxPevHpNgy2NzS70D/fB2rQOcEWU3PHi821lmhAKm9Uu0lY0lSD3+UV1I
         ZWEQ==
X-Gm-Message-State: AOAM531uT0JCMtq84X/N/HWxWxfidlgGDA7odSmNQr54Wm1GVH1gDmw3
        BLfuPwwGDZBEmtWyFEIZkFiLMO1QdQ==
X-Google-Smtp-Source: ABdhPJyltzopczGcfV9YdI2XwlbbJwZKn7Mm+TtioesKy0/KPoYSSRr44ytf6rEtkn2vqyFLWiuCpw==
X-Received: by 2002:aca:aa10:: with SMTP id t16mr8090448oie.57.1619044307045;
        Wed, 21 Apr 2021 15:31:47 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d16sm180662ote.56.2021.04.21.15.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 15:31:46 -0700 (PDT)
Received: (nullmailer pid 1733632 invoked by uid 1000);
        Wed, 21 Apr 2021 22:31:45 -0000
Date:   Wed, 21 Apr 2021 17:31:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] dt-bindings: clock: Convert ti,sci-clk to json schema
Message-ID: <20210421223145.GB1705110@robh.at.kernel.org>
References: <20210416063721.20538-1-nm@ti.com>
 <20210416063721.20538-3-nm@ti.com>
 <161861731160.46595.786611690053722257@swboyd.mtv.corp.google.com>
 <20210417125127.vigq23mdoodje6b5@velcro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210417125127.vigq23mdoodje6b5@velcro>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2021 at 07:51:27AM -0500, Nishanth Menon wrote:
> On 16:55-20210416, Stephen Boyd wrote:
> > Quoting Nishanth Menon (2021-04-15 23:37:19)
> > > diff --git a/Documentation/devicetree/bindings/clock/ti,sci-clk.yaml b/Documentation/devicetree/bindings/clock/ti,sci-clk.yaml
> > > new file mode 100644
> > > index 000000000000..72633651f0c7
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/clock/ti,sci-clk.yaml
> > > @@ -0,0 +1,52 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/clock/ti,sci-clk.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: TI-SCI clock controller node bindings
> > > +
> > > +maintainers:
> > > +  - Nishanth Menon <nm@ti.com>
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/clock/clock.yaml#
> > 
> > Is this needed?

No. It is already applied to every node.

> https://github.com/devicetree-org/dt-schema/blob/master/schemas/clock/clock.yaml
> This standardizes provider properties like '#clock-cells' etc, allowing
> you to add more stricter checks or controls in the future if necessary.
> 
> while:
> 
> https://github.com/devicetree-org/dt-schema/blob/master/meta-schemas/clocks.yaml
> is more a consumer node description.

No, the meta-schema is what checks the schemas just as the schemas check 
dts files.

> Should I have picked a different yaml as base for a standard clock-controller
> base?
> 
> > 
> > > +
> > > +description: |
> > > +  Some TI SoCs contain a system controller (like the Power Management Micro
> > > +  Controller (PMMC) on Keystone 66AK2G SoC) that are responsible for controlling
> > > +  the state of the various hardware modules present on the SoC. Communication
> > > +  between the host processor running an OS and the system controller happens
> > > +  through a protocol called TI System Control Interface (TI-SCI protocol).
> > > +
> > > +  This clock controller node uses the TI SCI protocol to perform various clock
> > > +  management of various hardware modules (devices) present on the SoC. This
> > > +  node must be a child node of the associated TI-SCI system controller node.
> > > +
> > > +properties:
> > > +  $nodename:
> > > +    pattern: "^clock-controller$"
> > 
> > Is this nodename pattern check required?
> 
> I'd like the definition on rails and not subject to interpretation, and
> restrict the kind of subnodes under TISCI controller node.

If this schema was standalone and not defined as part of another, then 
yes it would be required. In your case, you can enforce the node name 
from the parent schema. For consistency though, it would be better to 
just always require $nodename. 

Actually, this schema will be applied twice. On it's own matching the 
compatible string and by the parent schema. You can prevent that with 
'select: false'. I don't mind the double validation as if the parent 
node had a compatible typo you'd get zero validation.

> 
> > 
> > > +
> > > +  compatible:
> > > +    const: ti,k2g-sci-clk
> > 
> > I thought most things keyed off the compatible string.
> 
> Yes, they are. I am not sure I understand your question here. Did you
> mean to indicate that having $nodename and compatible both are
> redundant?
> 
> Redundancy was'nt the intent of this schema definition, rather, I'd like
> to make sure that it is not upto interpretation or debate as to what the
> node name should be: I believe clock-controller is the correct nodename
> (without @0x... since this does'nt use reg property) instead of using
> clocks, tisci-clock as the node names.
> 
> 
> Do you suggest something  different?
> 
> -- 
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
