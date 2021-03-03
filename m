Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEFE332BEF3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 00:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576295AbhCCRr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383548AbhCCOjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:39:24 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A95C0610CC
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 06:38:47 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id mm21so42322226ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 06:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ck25IRRAzQRsE2FVn23n0Fb1oL1B65fMX3eO7JLfyO0=;
        b=JeFWotm8zb2Osqdclg+G/gulOOPrJbi4JobuhZ4JCIvS/VrzS9ABhcYsQcTENmrFM3
         nmaUhG9+fTbcDqHoykLtDuGX8AP4SicklyIt2yzHSY62OgKIyi8JC3CthKBfpJ9kf6Hi
         ZdOB9Zv0MbkYmClDfsewJXZr16AqVTC63bOI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ck25IRRAzQRsE2FVn23n0Fb1oL1B65fMX3eO7JLfyO0=;
        b=A2gbACjhitnQBJdCqTkHRZITNXjOpqOMfqXrhR1Mg4TOdzOJxNIkwcAVpY9Dz22Kb0
         PzbIUW/aXy21Ch7H6EjB9ryqHdJ/WtASQhQ2qD4ruSNJsIG1rNIVNy4SMwTrqMCbit68
         YaraQ7oWACtTNzY9zzWg7ULj+/ZDO9du3iVeanoNgeIBgiO3IZ3JnemTe38l3ApszkSq
         Wr9Am3FWJwl9Vx2yf/10eTVU5BZzbtgfPyowNEL9O889L82qvgKzwb/sPWyf5qbZEMSq
         nmDkGz+CzTWcILkNhZkF/a3vT1Q5JHPwcGBCzH5m216pZQblsWe0eX/b8IdzECgQa49D
         n3KA==
X-Gm-Message-State: AOAM531sayVLJ7vcnvgwmwDoPuhh1Q0lkonrwoaSTPhtuBXUWg+FjAKG
        7WJmYnr0cMIWHb2DJlpXrJQKBhwBMh5Np5VH67romw==
X-Google-Smtp-Source: ABdhPJx72bf74kr4tzQv3XgUtVxlR5d6WMRhG3LbVaZcA0Hrldpowdd4mNb8kexGQSz/vQJSrcumxbjjEfv3yoF5x8U=
X-Received: by 2002:a17:906:b0d8:: with SMTP id bk24mr26433707ejb.252.1614782326494;
 Wed, 03 Mar 2021 06:38:46 -0800 (PST)
MIME-Version: 1.0
References: <20210214175211.105107-1-jagan@amarulasolutions.com>
 <YCpmZWRoiWULiANx@pendragon.ideasonboard.com> <CAMty3ZDt2EDB8E2nNLx_jfqE7-ActVYVoeFo2Eso+nVuUfVL+w@mail.gmail.com>
 <YDZRFeuzsamKyIJo@pendragon.ideasonboard.com>
In-Reply-To: <YDZRFeuzsamKyIJo@pendragon.ideasonboard.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 3 Mar 2021 20:08:35 +0530
Message-ID: <CAMty3ZBHKzksbrWoWapZb9h4hmbL9Lk1baqS_Lb7WPdmRr2hGQ@mail.gmail.com>
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

I have seen an issue by passing bus-width where the same bus-with 24
can use by RGB888 and RGB666 according to
mipi_dsi_pixel_format_to_bpp. Having a default RGB888 format now and
update it when it supports properly, can be a good Idea I thought of.
Let me know if you have any comments?

Jagan.
