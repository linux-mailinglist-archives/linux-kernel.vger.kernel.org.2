Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C802B323FDC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbhBXOYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 09:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236322AbhBXNPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 08:15:08 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398AAC06174A;
        Wed, 24 Feb 2021 05:14:28 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BDBA458E;
        Wed, 24 Feb 2021 14:14:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1614172465;
        bh=5FXg3ZYXDanK+M7xH1Qmkj8gXTqz8/OnTRQgAeNfW2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hU2/MagZgvIYux/Xw2guJ5BlJ5D2B+ivuZG0+CxwcvPCbiJcP97o9sgx8z3Lc1upT
         iyXcYuxqzF+VDqUYCkapI2t0ol7dm86zOuiZ0QO6BJ2se8xZNMp/xn2Mq71lTV4bRt
         SgZ9DEEN/RaDUcasAhA6CbI70hNVt1VH2lK+oGnk=
Date:   Wed, 24 Feb 2021 15:13:57 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: display: bridge: Add bindings for
 Chipone ICN6211
Message-ID: <YDZRFeuzsamKyIJo@pendragon.ideasonboard.com>
References: <20210214175211.105107-1-jagan@amarulasolutions.com>
 <YCpmZWRoiWULiANx@pendragon.ideasonboard.com>
 <CAMty3ZDt2EDB8E2nNLx_jfqE7-ActVYVoeFo2Eso+nVuUfVL+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMty3ZDt2EDB8E2nNLx_jfqE7-ActVYVoeFo2Eso+nVuUfVL+w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan,

On Wed, Feb 24, 2021 at 06:07:43PM +0530, Jagan Teki wrote:
> On Mon, Feb 15, 2021 at 5:48 PM Laurent Pinchart wrote:
> > On Sun, Feb 14, 2021 at 11:22:10PM +0530, Jagan Teki wrote:
> > > ICN6211 is MIPI-DSI to RGB Convertor bridge from Chipone.
> > >
> > > It has a flexible configuration of MIPI DSI signal input and
> > > produce RGB565, RGB666, RGB888 output format.
> > >
> > > Add dt-bingings for it.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > > Changes for v3:
> > > - updated to new dt-bindings style
> > >
> > >  .../display/bridge/chipone,icn6211.yaml       | 90 +++++++++++++++++++
> > >  1 file changed, 90 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml b/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml
> > > new file mode 100644
> > > index 000000000000..13764f13fe46
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml
> > > @@ -0,0 +1,90 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/display/bridge/chipone,icn6211.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Chipone ICN6211 MIPI-DSI to RGB Converter bridge
> > > +
> > > +maintainers:
> > > +  - Jagan Teki <jagan@amarulasolutions.com>
> > > +
> > > +description: |
> > > +  ICN6211 is MIPI-DSI to RGB Convertor bridge from chipone.
> > > +
> > > +  It has a flexible configuration of MIPI DSI signal input and
> > > +  produce RGB565, RGB666, RGB888 output format.
> >
> > How does one select between the output formats ? Should the output
> > connection option be described in the device tree ?
> 
> I think that is a good option to select output formats via dts. what
> if it makes it a generic property like data-lanes? since it is common
> across many other bridges.

Describing the output connection in the device tree sounds like a good
idea indeed. The bus-width property could be used for this, maybe along
the lines of
https://lore.kernel.org/dri-devel/20201013020619.GG3942@pendragon.ideasonboard.com/.

If, for a given wiring of the output, different formats could be used,
then we would need to select them at runtime.

> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - chipone,icn6211
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +    description: virtual channel number of a DSI peripheral
> > > +
> > > +  reset-gpios:
> > > +    description: GPIO connected for the reset pin
> > > +
> > > +  ports:
> > > +    $ref: /schemas/graph.yaml#/properties/ports
> > > +
> > > +    properties:
> > > +      port@0:
> > > +        $ref: /schemas/graph.yaml#/properties/port
> > > +        description:
> > > +          Video port for MIPI DSI input
> > > +
> > > +      port@1:
> > > +        $ref: /schemas/graph.yaml#/properties/port
> > > +        description:
> > > +          Video port for MIPI DPI output (panel or connector).
> > > +
> > > +    required:
> > > +      - port@0
> > > +      - port@1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - reset-gpios
> > > +  - ports
> >
> > How about regulators ?
> 
> Will add it in the next version.

-- 
Regards,

Laurent Pinchart
