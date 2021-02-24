Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F17232405A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbhBXOxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 09:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237768AbhBXNrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 08:47:31 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6102C06178C
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 05:46:49 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id d8so3167599ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 05:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8fSkNXLVwfaOZwL997IP3xh+QkpM3w54V6mdvtgPHDo=;
        b=R8IbeDKckrUJCPV8WkN11D1QAcubF61ffw5bKVMkjYp2iHLYaS4xLjPgW4eJnE+mUs
         fJj/TrfQYj/jth+4BdkHMZPvhwR+qEbr18htei7UfCQlkbJOfd1jMvoVrfBaOVad2+d/
         529Gvy9eHyMT0FTSBhWs0AnAWOTPmtShwwYtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8fSkNXLVwfaOZwL997IP3xh+QkpM3w54V6mdvtgPHDo=;
        b=XCgk0OF7dH693YFuK6eJgkZSsn5aCh1g4W/xk6H/bpP9TCGITtakvcioRAJnoHuxx8
         gTXMaN12JSUWyIHKXJZh3BfsITEIDYY6Z4ZCmBF4tqVKlwcJSqT5+Stv9MKbHuvTBHpd
         FpnwacjHFy7zH3WhD5tQVoJMptkUTeLb6LEvTOVCKfYd8S8K0ti8Vh+8h5hLQ7s1IWdQ
         z7fngAB+1GCMV15ntIhanRBYKnssuwhgg2gq+vj3Ndmb61MY8KPnncB0B2mQJmowssw9
         IXY788ciwkuEpokKpJQuJ6VJF69CVdLw2w5fV/0gfCRvWKgdHGnCukts7PZOiVNVsALt
         oGNw==
X-Gm-Message-State: AOAM533+Nl+ZsURvt1izfLCkXIvVxpjPFb7daNbrgbZfqtIW0C36xnMa
        ciibw2IPx0Rni119KK3VL9bvvoIRtVS98/5yRcJAIAH/XKi/nw==
X-Google-Smtp-Source: ABdhPJy4M7Jrx45XkSBdTw0LnVY5/pPeBd7sbCgZ6AyCdvMI1KeuGBbDsK9rvPWI7uWXwL9SimiWGVVLwBPeagSkZnI=
X-Received: by 2002:a17:906:b0d8:: with SMTP id bk24mr31788687ejb.252.1614174408444;
 Wed, 24 Feb 2021 05:46:48 -0800 (PST)
MIME-Version: 1.0
References: <20210214175211.105107-1-jagan@amarulasolutions.com>
 <YCpmZWRoiWULiANx@pendragon.ideasonboard.com> <CAMty3ZDt2EDB8E2nNLx_jfqE7-ActVYVoeFo2Eso+nVuUfVL+w@mail.gmail.com>
 <YDZRFeuzsamKyIJo@pendragon.ideasonboard.com>
In-Reply-To: <YDZRFeuzsamKyIJo@pendragon.ideasonboard.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 24 Feb 2021 19:16:31 +0530
Message-ID: <CAMty3ZBsfwoWq4Cm6hxFD2rJkLHA5H_zjgemfyx-SJ-gNL=W-Q@mail.gmail.com>
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

On Wed, Feb 24, 2021 at 6:44 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Jagan,
>
> On Wed, Feb 24, 2021 at 06:07:43PM +0530, Jagan Teki wrote:
> > On Mon, Feb 15, 2021 at 5:48 PM Laurent Pinchart wrote:
> > > On Sun, Feb 14, 2021 at 11:22:10PM +0530, Jagan Teki wrote:
> > > > ICN6211 is MIPI-DSI to RGB Convertor bridge from Chipone.
> > > >
> > > > It has a flexible configuration of MIPI DSI signal input and
> > > > produce RGB565, RGB666, RGB888 output format.
> > > >
> > > > Add dt-bingings for it.
> > > >
> > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > ---
> > > > Changes for v3:
> > > > - updated to new dt-bindings style
> > > >
> > > >  .../display/bridge/chipone,icn6211.yaml       | 90 +++++++++++++++++++
> > > >  1 file changed, 90 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml b/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml
> > > > new file mode 100644
> > > > index 000000000000..13764f13fe46
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml
> > > > @@ -0,0 +1,90 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/display/bridge/chipone,icn6211.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Chipone ICN6211 MIPI-DSI to RGB Converter bridge
> > > > +
> > > > +maintainers:
> > > > +  - Jagan Teki <jagan@amarulasolutions.com>
> > > > +
> > > > +description: |
> > > > +  ICN6211 is MIPI-DSI to RGB Convertor bridge from chipone.
> > > > +
> > > > +  It has a flexible configuration of MIPI DSI signal input and
> > > > +  produce RGB565, RGB666, RGB888 output format.
> > >
> > > How does one select between the output formats ? Should the output
> > > connection option be described in the device tree ?
> >
> > I think that is a good option to select output formats via dts. what
> > if it makes it a generic property like data-lanes? since it is common
> > across many other bridges.
>
> Describing the output connection in the device tree sounds like a good
> idea indeed. The bus-width property could be used for this, maybe along
> the lines of
> https://lore.kernel.org/dri-devel/20201013020619.GG3942@pendragon.ideasonboard.com/.

I think this bridge is doing, what we discussed? am I correct?
Documentation/devicetree/bindings/display/bridge/ti,tfp410.yaml

>
> If, for a given wiring of the output, different formats could be used,
> then we would need to select them at runtime.

That means the opposite of what mipi_dsi_pixel_format_to_bpp is doing
right? like given bpp we need to select format.

Jagan.
