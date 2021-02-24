Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6558323BF6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 13:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbhBXMik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 07:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbhBXMih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 07:38:37 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773B6C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 04:37:56 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id c6so2327796ede.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 04:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g07oglWDP6MW/sT/0KORfHFay4I08yTBqKpnsZcOxR0=;
        b=JkQw5OpKBkdZyh07F+JVOE82ubO8e/yH6drILRD6olCknp04OYbWD4oNqMHuM/UjK7
         +zBfNqPxRal7XD1E0ebOlxQAfduFI6Nn9+JmjgCYDPZg4HrB9UR3emBLUwvTq68oONb0
         9DnsGxRqNiIwUq3wwJU0Ww3mcInwW+P7LtdMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g07oglWDP6MW/sT/0KORfHFay4I08yTBqKpnsZcOxR0=;
        b=sWMpJOdhTftjishowWjQM8LVW/rlgh8yiu4CcR1y5rxxceiol6nkzTuwZZdGsQ0ROa
         H3zehIH7SRErcscAkIxAeRa4DuqOd2PKIRhSrF1x+oHJ5VKzllWh+h+tQC4d1ozRRbkA
         cXYTvRxhL1UFhaWVK6W5z7oTnzAx8ITZxocSmyoRuVH8i1e9cWklwXNr0deaQXWvo208
         3s/Ef8i5OmrPX+CO0xuWtaGZ1Vo7/4PskknFQgJGgFii+pHvhxSRBVpDs42M8d0yiyvP
         dG848MLWWAgz984yWrHSvFBjr8uvyPlgDZG60WRRYIplwUD/MEa7t7doa8wjSaZU+O8J
         1dbg==
X-Gm-Message-State: AOAM533aTAy/+Ld/R3mbrcnFMdTuCODnBtT8+T0Nf+/H3n2eJdBgMIFe
        EuQwgSiALysOEq4OMozpPqEsQfp/IoFaqF1d8UmhfQ==
X-Google-Smtp-Source: ABdhPJyVP8jYaoGikQdL4uI2tbLxt5QZyKSbb5dZCpNiGmPPFJtjCN7iayaf+Wq/05Dty7VWud+PoyKrDNCgfqwiU/c=
X-Received: by 2002:a05:6402:33a:: with SMTP id q26mr28983732edw.150.1614170275198;
 Wed, 24 Feb 2021 04:37:55 -0800 (PST)
MIME-Version: 1.0
References: <20210214175211.105107-1-jagan@amarulasolutions.com> <YCpmZWRoiWULiANx@pendragon.ideasonboard.com>
In-Reply-To: <YCpmZWRoiWULiANx@pendragon.ideasonboard.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 24 Feb 2021 18:07:43 +0530
Message-ID: <CAMty3ZDt2EDB8E2nNLx_jfqE7-ActVYVoeFo2Eso+nVuUfVL+w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: display: bridge: Add bindings for
 Chipone ICN6211
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Mon, Feb 15, 2021 at 5:48 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Jagan,
>
> Thank you for the patch.
>
> On Sun, Feb 14, 2021 at 11:22:10PM +0530, Jagan Teki wrote:
> > ICN6211 is MIPI-DSI to RGB Convertor bridge from Chipone.
> >
> > It has a flexible configuration of MIPI DSI signal input and
> > produce RGB565, RGB666, RGB888 output format.
> >
> > Add dt-bingings for it.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> > Changes for v3:
> > - updated to new dt-bindings style
> >
> >  .../display/bridge/chipone,icn6211.yaml       | 90 +++++++++++++++++++
> >  1 file changed, 90 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml b/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml
> > new file mode 100644
> > index 000000000000..13764f13fe46
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml
> > @@ -0,0 +1,90 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/bridge/chipone,icn6211.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Chipone ICN6211 MIPI-DSI to RGB Converter bridge
> > +
> > +maintainers:
> > +  - Jagan Teki <jagan@amarulasolutions.com>
> > +
> > +description: |
> > +  ICN6211 is MIPI-DSI to RGB Convertor bridge from chipone.
> > +
> > +  It has a flexible configuration of MIPI DSI signal input and
> > +  produce RGB565, RGB666, RGB888 output format.
>
> How does one select between the output formats ? Should the output
> connection option be described in the device tree ?

I think that is a good option to select output formats via dts. what
if it makes it a generic property like data-lanes? since it is common
across many other bridges.

>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - chipone,icn6211
> > +
> > +  reg:
> > +    maxItems: 1
> > +    description: virtual channel number of a DSI peripheral
> > +
> > +  reset-gpios:
> > +    description: GPIO connected for the reset pin
> > +
> > +  ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +
> > +    properties:
> > +      port@0:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description:
> > +          Video port for MIPI DSI input
> > +
> > +      port@1:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description:
> > +          Video port for MIPI DPI output (panel or connector).
> > +
> > +    required:
> > +      - port@0
> > +      - port@1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reset-gpios
> > +  - ports
>
> How about regulators ?

Will add it in the next version.

Jagan.
