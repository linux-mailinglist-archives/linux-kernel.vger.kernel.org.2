Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1468632CF63
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 10:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236170AbhCDJL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 04:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbhCDJLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 04:11:08 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F29DC061756
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 01:10:28 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id ci14so28869215ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 01:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gynRsFiEHgePHyaarQ8hzDU1xilkr7SD/fM6H3+AlvU=;
        b=Ubk+98S/cBq11/zbb9HafDOhME3HEcJiiJ9bhN0cmVHvYm+yV1zUxk0XEoHEOILs2U
         IsQvDjENTdrE5Qd6gE3jWnmlU4Bwz4XdeOL+0PXqWiisZKTwlfjlo3vM3gTcLKsBpWk+
         Rvg2jE/LhIV2dt4MSiRaFrasfcMztTaMte5s8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gynRsFiEHgePHyaarQ8hzDU1xilkr7SD/fM6H3+AlvU=;
        b=qSvzfdiePlj9v6jkinXnkd3aOBkj0xciyS9V00Bz/94Ly0BOWmWERGJzpijzvAyUut
         jlZVe0z4hLubXxw0M95shGzKTb+5K0yKoPs7EEyGjw3fASr54VoI4BFhvmpz8RV49SZx
         QR77tGrvQEV40vm052pchYzdTfgbMYEXcPsoWru1ZfLjcBZ+NhGVVE+XE5Vb+DqbfDPs
         3mW7oCnagVHO44zIRzwuqjK72grznjbgmzhszQBJ2GIQyA9CRBU2kbSVtwYRdz0X939z
         6iOT9szemJ9KbNiuVZM/Hn/74Ha5Ll4OUT3Ok9cPbOwQueQ7/yQiAiwjqEB9pgh7ynsy
         ZdYA==
X-Gm-Message-State: AOAM532KNc8BJ5enl7vPDGzMFUvQdcH0L5z6qOn+vyY74OIQgjKuFXuc
        IRC3NQbUsmK32ZguYNbXuZicKsT3SoHbVtaThOgBRA==
X-Google-Smtp-Source: ABdhPJzSTAn6jTvFpWH0XRgSeuhut8parDgXEnI2p1Z+Nx534TlGSdgNeTzbFxrQs/g2tJzgq9KJrXI9ySKVZuruQc4=
X-Received: by 2002:a17:906:3fc3:: with SMTP id k3mr3172834ejj.522.1614849026928;
 Thu, 04 Mar 2021 01:10:26 -0800 (PST)
MIME-Version: 1.0
References: <20210214175211.105107-1-jagan@amarulasolutions.com>
 <YCpmZWRoiWULiANx@pendragon.ideasonboard.com> <CAMty3ZDt2EDB8E2nNLx_jfqE7-ActVYVoeFo2Eso+nVuUfVL+w@mail.gmail.com>
 <YDZRFeuzsamKyIJo@pendragon.ideasonboard.com> <CAMty3ZBHKzksbrWoWapZb9h4hmbL9Lk1baqS_Lb7WPdmRr2hGQ@mail.gmail.com>
 <YEAUyUsZb+4Oe0Ye@pendragon.ideasonboard.com>
In-Reply-To: <YEAUyUsZb+4Oe0Ye@pendragon.ideasonboard.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 4 Mar 2021 14:40:15 +0530
Message-ID: <CAMty3ZDAz28BWUJRLW0LwmJ5v6dOPZmxRzfzseoQMiMkTVBW6Q@mail.gmail.com>
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

On Thu, Mar 4, 2021 at 4:29 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Jagan,
>
> On Wed, Mar 03, 2021 at 08:08:35PM +0530, Jagan Teki wrote:
> > On Wed, Feb 24, 2021 at 6:44 PM Laurent Pinchart wrote:
> > > On Wed, Feb 24, 2021 at 06:07:43PM +0530, Jagan Teki wrote:
> > > > On Mon, Feb 15, 2021 at 5:48 PM Laurent Pinchart wrote:
> > > > > On Sun, Feb 14, 2021 at 11:22:10PM +0530, Jagan Teki wrote:
> > > > > > ICN6211 is MIPI-DSI to RGB Convertor bridge from Chipone.
> > > > > >
> > > > > > It has a flexible configuration of MIPI DSI signal input and
> > > > > > produce RGB565, RGB666, RGB888 output format.
> > > > > >
> > > > > > Add dt-bingings for it.
> > > > > >
> > > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > > > ---
> > > > > > Changes for v3:
> > > > > > - updated to new dt-bindings style
> > > > > >
> > > > > >  .../display/bridge/chipone,icn6211.yaml       | 90 +++++++++++++++++++
> > > > > >  1 file changed, 90 insertions(+)
> > > > > >  create mode 100644 Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml
> > > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml b/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml
> > > > > > new file mode 100644
> > > > > > index 000000000000..13764f13fe46
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml
> > > > > > @@ -0,0 +1,90 @@
> > > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > > +%YAML 1.2
> > > > > > +---
> > > > > > +$id: http://devicetree.org/schemas/display/bridge/chipone,icn6211.yaml#
> > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > +
> > > > > > +title: Chipone ICN6211 MIPI-DSI to RGB Converter bridge
> > > > > > +
> > > > > > +maintainers:
> > > > > > +  - Jagan Teki <jagan@amarulasolutions.com>
> > > > > > +
> > > > > > +description: |
> > > > > > +  ICN6211 is MIPI-DSI to RGB Convertor bridge from chipone.
> > > > > > +
> > > > > > +  It has a flexible configuration of MIPI DSI signal input and
> > > > > > +  produce RGB565, RGB666, RGB888 output format.
> > > > >
> > > > > How does one select between the output formats ? Should the output
> > > > > connection option be described in the device tree ?
> > > >
> > > > I think that is a good option to select output formats via dts. what
> > > > if it makes it a generic property like data-lanes? since it is common
> > > > across many other bridges.
> > >
> > > Describing the output connection in the device tree sounds like a good
> > > idea indeed. The bus-width property could be used for this, maybe along
> > > the lines of
> > > https://lore.kernel.org/dri-devel/20201013020619.GG3942@pendragon.ideasonboard.com/.
> >
> > I have seen an issue by passing bus-width where the same bus-with 24
> > can use by RGB888 and RGB666 according to
> > mipi_dsi_pixel_format_to_bpp. Having a default RGB888 format now and
> > update it when it supports properly, can be a good Idea I thought of.
> > Let me know if you have any comments?
>
> I'm fine with hardcoding a default for now. If a given bus wiring (which
> is described in DT by bus-width) can transport different formats, that's
> something that should be configured dynamically, either by querying what
> format a sink (such as a panel) requires, or if both the source and the
> sink can support different formats, possibly by involving userspace in
> the selection.

Not sure how we can get userspace involvement in DRM here, but if
source and sink can have different formats then having precedence to
the source would be a good option as it handles low-level
configuration for formats.

Look like it is worth trying-feature. Maybe we can come up with some
RFC and have a discussion.

Jagan.
