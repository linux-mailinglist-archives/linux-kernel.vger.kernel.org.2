Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD4A31B8C2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 13:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhBOMJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 07:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhBOMJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 07:09:09 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8592C061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 04:08:28 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id hs11so10759446ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 04:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bPb8pCUxI0r+QEvK3yWSBZjQ0Qvr7qfy1eHqEVbEFVE=;
        b=mjF2/dTDYzNdw4PENz6ACddiKtM2t8FGI2FHEx2WqSW+c+NLx8pGDGSBWKrU8B2+OF
         zGuZ6Xyza8gzdqqNlU89MduqwBUwLaS0NfIUU+L5TptDaBUh8ARAZ9NTBvh2Ok9an1xJ
         p4kGX2nh0tMLSWkhUVK1/tmmiXvQm4oI6zlIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bPb8pCUxI0r+QEvK3yWSBZjQ0Qvr7qfy1eHqEVbEFVE=;
        b=sRT+jdHkqeA9Z7nlCB3SEDPzsSB7/plUl4SUhGd2C+/awpC6R5NUym0957BVSWa/Hw
         ECjhfE9PwyxqLRW6jPGU5BDk97vjPsd8GX56nykzEy/75Wg2MUXrIaKEBoQQ/li2vI0f
         ucJQTZMfAKEW7G7heGRngoskj5rTwFWvE3wVEAfyNw5ECRqOvKpNiSUDy+xlrOhZvghh
         ANeEkA9JrhrrC6EewXHgwnzQzw1vdos3/xZdq5K2/ABShcKMSU035K+UsinnDUSQ8QI5
         8INzNwdgigB41u4aLd533+bRogRvOLh6RZgHbI3RmpcjNSzxfDuA2N1NRXyogKO/Tu2n
         /yAA==
X-Gm-Message-State: AOAM5314OixG+5Ly1cHbPCbvyGxvxvEtCBbTsPCYIGx9MUm+uga/W7XJ
        MAuw1o5RwK9Bq6UZ47ZXdyUBBt5nPOxy5OVPQsVgTw==
X-Google-Smtp-Source: ABdhPJxulpG94j5gqYFYTXkjqDBqhFcfbphzRi9wi7xdhRdh6Eq26k5RRzSumtPITQ220NwxQ1rpjV9gEgRzrWlrnog=
X-Received: by 2002:a17:906:4e45:: with SMTP id g5mr505637ejw.186.1613390907532;
 Mon, 15 Feb 2021 04:08:27 -0800 (PST)
MIME-Version: 1.0
References: <20210214175211.105107-1-jagan@amarulasolutions.com> <CAG3jFysAq0rSVRgjDSu6gF4kHcqOGAZt+b0Rz_reHgQr3Scy6A@mail.gmail.com>
In-Reply-To: <CAG3jFysAq0rSVRgjDSu6gF4kHcqOGAZt+b0Rz_reHgQr3Scy6A@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 15 Feb 2021 17:38:16 +0530
Message-ID: <CAMty3ZAk0W8KbFPo3fo3NavEvveRfptovOeaWA_hh0rXVYhDnw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: display: bridge: Add bindings for
 Chipone ICN6211
To:     Robert Foss <robert.foss@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 5:28 PM Robert Foss <robert.foss@linaro.org> wrote:
>
> Hey Jagan,
>
> Thanks for submitting this.
>
> checkpatch.pl threw some typ-o warnings, and I listed them below. I
> think either spelling is correct, but 'spelling.txt' does list this as
> a typ-o explicitly, so I would suggest conforming to that just to
> silence the checkpatch warning.
>
> This patch also passes 'dt_binding_check' and 'dtbs_check', but I
> think I'd like to defer to Rob Herring for an actual r-b.
>
> On Sun, 14 Feb 2021 at 18:55, Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
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
>
> $ scripts/checkpatch.pl --git HEAD~0
> WARNING: 'Convertor' may be misspelled - perhaps 'Converter'?

Thanks for pointing it.

I was aware of it before sending it and need to understand whether we
need to use vendor naming conversion or not. Chipone call these
devices are Convertor [1], So I have used the vendor notation for
better understanding.

Any comments are this would be welcome?

[1] http://en.chiponeic.com/content/details45_123.html

Jagan.
