Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B603636A1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 18:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbhDRQeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 12:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbhDRQes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 12:34:48 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401A1C06174A;
        Sun, 18 Apr 2021 09:34:17 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id g8so52277747lfv.12;
        Sun, 18 Apr 2021 09:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R+GRmRiyxozuqUSuRsmcn7yz3og3tcEpGFS7AC6KJUY=;
        b=vfHcIXBcB2091YsmbuiyyG/KbaYLt3Q1VpxF29sSZ7PKHf1YhsMEtl0t9lO0IH5nlg
         sC1Wp+tlh+1rhUJHJzMSl/53hzwlPtCj3VuI8Qn5BsPz54tk+2OZRJ+mVEIeUBo5zJHR
         12HGmO96hlTnnSCIEsT41eqp6qQk0gmugOdmAhTEAVLxRSaSj7lEqsarp1KSkmVG8Ojp
         oHxgJWVdbhCZEo+vpDo/4RSh9TjIx9ZjnY4ToNWEho8D/tsSU+en3o5uY/VFzxnHkTYG
         mLJY2+KBIa5up8XwEm0CCGlQYEvWsiMNvMP49uVCu8kJd1rF6TTBOj8L7StcvzvMnPBc
         o/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R+GRmRiyxozuqUSuRsmcn7yz3og3tcEpGFS7AC6KJUY=;
        b=qlYJ7PD7xKttCwfNGbfpGUiFdoz1ozITwAkzBssS3y+rfhN2nLDBQds8o2YZ4YIN1v
         NSraWhi5K66USI8rZYkZzlcSY/NuKgsx+jWkYkjx7wKMJ2T+Bdir0ztE+e+VihWzK7u7
         zcNp88DoxPAR5MNtXFEj+/fM+0bXX3RAtPWxyXW4JrJOmngbHvDqgVeaoWPtS8DC1t8k
         Gh8H52dilHM6/mQJ8OSaQcoutELXfYVxO9HBj7e4TqMSrmuuVKBd0cRc+StZkq7EtkzT
         E06PsSktBWKZl3khlhZ5kEVrGmTcPnXrVY7oxcO2UFFj2UVcPdx02rwSDQjxgUqlY6FK
         kf2A==
X-Gm-Message-State: AOAM533tkVFqbeYGx3qQStdD0ofDM7ckvn9Eq9QdiCEu9+xHIuNsMs56
        Sw/gVKXVQqlRxFAw/mZgieUQva2bMO5asMzueUZotLr7W6E=
X-Google-Smtp-Source: ABdhPJyo3F1O1wOwHslBcJQ3Hm8sh1ma4yEUKl8Hfm0ZNxLKGK6LDQSZA5FND7QPk8I3yWeSkxp9nlNc0OVXTmrxkp4=
X-Received: by 2002:a05:6512:3a83:: with SMTP id q3mr9641654lfu.460.1618763655782;
 Sun, 18 Apr 2021 09:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210222132822.7830-1-kevin3.tang@gmail.com> <20210222132822.7830-6-kevin3.tang@gmail.com>
 <20210324111316.ggo5deacaoecu27q@gilmour> <CAFPSGXah3gKKHXhukRAPT=RjQZTnvDznG+619+8tah-hfFrUzA@mail.gmail.com>
 <20210407104653.l4xwfl3qshaimat3@gilmour> <CAFPSGXaQKeKMKC7MGXhxQErB_yh_eE8khk1hOrjHnuOH20Gg4Q@mail.gmail.com>
 <20210415084230.moqxuy3caym3kupk@gilmour>
In-Reply-To: <20210415084230.moqxuy3caym3kupk@gilmour>
From:   Kevin Tang <kevin3.tang@gmail.com>
Date:   Mon, 19 Apr 2021 00:33:42 +0800
Message-ID: <CAFPSGXYujpe=C64f=MJAUmqGwoP6t=NE+nNqezmKUTcyrxt+=g@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] dt-bindings: display: add Unisoc's mipi dsi
 controller bindings
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxime Ripard <maxime@cerno.tech> =E4=BA=8E2021=E5=B9=B44=E6=9C=8815=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=884:42=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Apr 09, 2021 at 08:23:19AM +0800, Kevin Tang wrote:
> > Maxime Ripard <maxime@cerno.tech> =E4=BA=8E2021=E5=B9=B44=E6=9C=887=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=886:46=E5=86=99=E9=81=93=EF=BC=9A
> >
> > > On Wed, Mar 31, 2021 at 09:49:14AM +0800, Kevin Tang wrote:
> > > > Hi Maxime,
> > > >
> > > > Maxime Ripard <maxime@cerno.tech> =E4=BA=8E2021=E5=B9=B43=E6=9C=882=
4=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=887:13=E5=86=99=E9=81=93=EF=BC=
=9A
> > > >
> > > > > On Mon, Feb 22, 2021 at 09:28:21PM +0800, Kevin Tang wrote:
> > > > > > From: Kevin Tang <kevin.tang@unisoc.com>
> > > > > >
> > > > > > Adds MIPI DSI Controller
> > > > > > support for Unisoc's display subsystem.
> > > > > >
> > > > > > Cc: Orson Zhai <orsonzhai@gmail.com>
> > > > > > Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> > > > > > Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
> > > > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > > > ---
> > > > > >  .../display/sprd/sprd,sharkl3-dsi-host.yaml   | 102
> > > ++++++++++++++++++
> > > > > >  1 file changed, 102 insertions(+)
> > > > > >  create mode 100644
> > > > >
> > > Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.=
yaml
> > > > > >
> > > > > > diff --git
> > > > >
> > > a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-hos=
t.yaml
> > > > >
> > > b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-hos=
t.yaml
> > > > > > new file mode 100644
> > > > > > index 000000000..d439f688f
> > > > > > --- /dev/null
> > > > > > +++
> > > > >
> > > b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-hos=
t.yaml
> > > > > > @@ -0,0 +1,102 @@
> > > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > > +%YAML 1.2
> > > > > > +---
> > > > > > +$id:
> > > > > http://devicetree.org/schemas/display/sprd/sprd,sharkl3-dsi-host.=
yaml#
> > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > +
> > > > > > +title: Unisoc MIPI DSI Controller
> > > > > > +
> > > > > > +maintainers:
> > > > > > +  - Kevin Tang <kevin.tang@unisoc.com>
> > > > > > +
> > > > > > +properties:
> > > > > > +  compatible:
> > > > > > +    const: sprd,sharkl3-dsi-host
> > > > > > +
> > > > > > +  reg:
> > > > > > +    maxItems: 1
> > > > > > +
> > > > > > +  interrupts:
> > > > > > +    maxItems: 2
> > > > > > +
> > > > > > +  clocks:
> > > > > > +    minItems: 1
> > > > > > +
> > > > > > +  clock-names:
> > > > > > +    items:
> > > > > > +      - const: clk_src_96m
> > > > > > +
> > > > > > +  power-domains:
> > > > > > +    maxItems: 1
> > > > > > +
> > > > > > +  ports:
> > > > > > +    type: object
> > > > > > +
> > > > > > +    properties:
> > > > > > +      "#address-cells":
> > > > > > +        const: 1
> > > > > > +
> > > > > > +      "#size-cells":
> > > > > > +        const: 0
> > > > > > +
> > > > > > +      port@0:
> > > > > > +        type: object
> > > > > > +        description:
> > > > > > +          A port node with endpoint definitions as defined in
> > > > > > +
> > > Documentation/devicetree/bindings/media/video-interfaces.txt.
> > > > > > +          That port should be the input endpoint, usually comi=
ng
> > > from
> > > > > > +          the associated DPU.
> > > > > > +      port@1:
> > > > > > +        type: object
> > > > > > +        description:
> > > > > > +          A port node with endpoint definitions as defined in
> > > > > > +
> > > Documentation/devicetree/bindings/media/video-interfaces.txt.
> > > > > > +          That port should be the output endpoint, usually out=
put to
> > > > > > +          the associated panel.
> > > > >
> > > > > The DSI generic binding asks that peripherals that are controlled
> > > > > through a DCS be a subnode of the MIPI-DSI bus, not through a por=
t
> > > > > endpoint.
> > > > >
> > > >  Our DSI controller don't support DCS now...
> > >
> > > I'm not sure I follow you, you mentionned in the patch 4 that you wer=
e
> > > testing for a device to be in command mode, how would that work witho=
ut
> > > DCS support?
> > >
> > Sorry, I see DCS as DSC, pls ignore my previous comments.
> >
> > dsi input node is display controller and dsi output node is panel,
> > I still don't understand what it has to do with dcs? and it seems that
> > other vendors also like this.
> >
> > can you help provide some cases?
>
> So the device tree is a tree organized through which bus controls which
> device: Your DSI controller is accessed through a memory-mapped region
> and is thus a child node of the main bus (I guess?) and then, since the
> DSI panel is going to be controlled through the DSI controller and
> MIPI-DCS, it needs to be a child of the display controller.
Yeah, access DSI controller registers is through AHB bus.

I'm a little confused, DSI panel node should be a child of the display
controller?
I found a lot of cases are organized like this, we also do like it.
https://elixir.bootlin.com/linux/v5.11.15/source/arch/arm/boot/dts/tegra114=
-dalmore.dts#L48

>
> This is exactly what is being described here:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/devicetree/bindings/display/mipi-dsi-bus.txt#n42
>
> The second port is thus not needed at all
Yeah, dsi_out port is no need, should be detele.
Besides, I also have a question, if out dsi-phy is separate driver(eg,
dphy have it's own bus)
dsi_out port should be "dphy_in"?

>
> Maxime
