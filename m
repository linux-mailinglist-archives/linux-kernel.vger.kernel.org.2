Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D5937B262
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 01:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhEKXTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 19:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhEKXTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 19:19:22 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D8AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 16:18:14 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id q6so11145798qvb.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 16:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+fBXq+6nPKqVOlk+v8W280PjoWncpfOOR+yyoDwgdjE=;
        b=FZRXFHPjEvaukkFmoW4Ji7tyfmF/7vZuOOSEuHFuAwxDPa6oRl7/2Fx9ldAhWulLVk
         8whcYaziq01nUC0N5yGEmtBFrbFcoLwntKUZgrRBnDZxKr6McpG120KZkCYkv1V8oHZS
         WZbLnAWGAhhLco7gcDxvDVK/ZcJW3NJt2MV5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+fBXq+6nPKqVOlk+v8W280PjoWncpfOOR+yyoDwgdjE=;
        b=uEO4KgFpB/q/yzqLbY/7r9mmfDRKjtH/qptvWwXUgrfzUS15JhZvyqI6YfoZ9ygOZi
         L9lowmX9QGofXfNp4ALwBF2hD6HCGFIjFAZn2u9HKBPcUqzwyq7kYRUa45zBIwAKFLf5
         iVy10DmiilKGXAeSf7RyBqysi/O//snDdT+FEAwOVvGhj7TW8k9+JYbvvEehvmQkFZXS
         pp1jelwRcxN9P1W+syrxTqicPqm4pS6R+i7mD+jd/wlnVLF3j4XW/r8TgP+CE/fAhyRp
         OPscrzK1DQcjZF8R6RlBDoDWeye5IzKqaVIU6ehVzt8pb31Pt5/04iWsvTsJLXH/Kx18
         p/ZA==
X-Gm-Message-State: AOAM530SnpQ8hkuyFNUG+sWMnpl5GG7mEQp4r71/LHeroUmkS2RTRrCl
        S2O3AqGizGhf2MUKLkZLNrhQgA9SO855qg==
X-Google-Smtp-Source: ABdhPJxKLykYHvWNJ/7fXu9HaFUk5lH2GSnHnUkylo93O9/l2kjlqhWUValZEzqfyh7oCi0unWIg/g==
X-Received: by 2002:a0c:9e4e:: with SMTP id z14mr24501083qve.31.1620775093008;
        Tue, 11 May 2021 16:18:13 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id y8sm16204805qtn.61.2021.05.11.16.18.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 16:18:11 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id y2so28444681ybq.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 16:18:10 -0700 (PDT)
X-Received: by 2002:a25:6088:: with SMTP id u130mr45609181ybb.257.1620775090443;
 Tue, 11 May 2021 16:18:10 -0700 (PDT)
MIME-Version: 1.0
References: <1619416756-3533-1-git-send-email-rajeevny@codeaurora.org>
 <1619416756-3533-2-git-send-email-rajeevny@codeaurora.org>
 <20210429180435.GA1385465@robh.at.kernel.org> <CAD=FV=V-kdySH5Pp-Fb-PRYk60Ha_UOTXJHcvMp+uV3P1oo7Uw@mail.gmail.com>
 <78c4bd291bd4a17ae2a1d02d0217de43@codeaurora.org> <CAD=FV=XW90L6or8NKA-Rjjp3s3fRno1xSkD+X0PA1rTyeKgpMw@mail.gmail.com>
 <c867b2e59e90899e6c1648e06f5f9cd2@codeaurora.org>
In-Reply-To: <c867b2e59e90899e6c1648e06f5f9cd2@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 11 May 2021 16:17:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XBb9zs=ZGG-Ky8=_is20L1O6pJ-xBV1k5cF6-vL78pgA@mail.gmail.com>
Message-ID: <CAD=FV=XBb9zs=ZGG-Ky8=_is20L1O6pJ-xBV1k5cF6-vL78pgA@mail.gmail.com>
Subject: Re: [v3 1/2] dt-bindings: backlight: add DisplayPort aux backlight
To:     Rajeev Nandan <rajeevny@codeaurora.org>
Cc:     Rob Herring <robh@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>, mkrishn@codeaurora.org,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>,
        "Lankhorst, Maarten" <maarten.lankhorst@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 11, 2021 at 11:12 AM <rajeevny@codeaurora.org> wrote:
>
> On 01-05-2021 03:08, Doug Anderson wrote:
> > Hi,
> >
> > On Fri, Apr 30, 2021 at 8:10 AM <rajeevny@codeaurora.org> wrote:
> >>
> >> On 30-04-2021 02:33, Doug Anderson wrote:
> >> > Hi,
> >> >
> >> > On Thu, Apr 29, 2021 at 11:04 AM Rob Herring <robh@kernel.org> wrote:
> >> >>
> >> >> On Mon, Apr 26, 2021 at 11:29:15AM +0530, Rajeev Nandan wrote:
> >> >> > Add bindings for DisplayPort aux backlight driver.
> >> >> >
> >> >> > Changes in v2:
> >> >> > - New
> >> >> >
> >> >> > Signed-off-by: Rajeev Nandan <rajeevny@codeaurora.org>
> >> >> > ---
> >> >> >  .../bindings/leds/backlight/dp-aux-backlight.yaml  | 49 ++++++++++++++++++++++
> >> >> >  1 file changed, 49 insertions(+)
> >> >> >  create mode 100644 Documentation/devicetree/bindings/leds/backlight/dp-aux-backlight.yaml
> >> >> >
> >> >> > diff --git a/Documentation/devicetree/bindings/leds/backlight/dp-aux-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/dp-aux-backlight.yaml
> >> >> > new file mode 100644
> >> >> > index 00000000..0fa8bf0
> >> >> > --- /dev/null
> >> >> > +++ b/Documentation/devicetree/bindings/leds/backlight/dp-aux-backlight.yaml
> >> >> > @@ -0,0 +1,49 @@
> >> >> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> >> > +%YAML 1.2
> >> >> > +---
> >> >> > +$id: http://devicetree.org/schemas/leds/backlight/dp-aux-backlight.yaml#
> >> >> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> >> > +
> >> >> > +title: DisplayPort aux backlight driver bindings
> >> >> > +
> >> >> > +maintainers:
> >> >> > +  - Rajeev Nandan <rajeevny@codeaurora.org>
> >> >> > +
> >> >> > +description:
> >> >> > +  Backlight driver to control the brightness over DisplayPort aux channel.
> >> >> > +
> >> >> > +allOf:
> >> >> > +  - $ref: common.yaml#
> >> >> > +
> >> >> > +properties:
> >> >> > +  compatible:
> >> >> > +    const: dp-aux-backlight
> >> >> > +
> >> >> > +  ddc-i2c-bus:
> >> >> > +    $ref: /schemas/types.yaml#/definitions/phandle
> >> >> > +    description:
> >> >> > +      A phandle to the system I2C controller connected to the DDC bus used
> >> >> > +      for the DisplayPort AUX channel.
> >> >> > +
> >> >> > +  enable-gpios:
> >> >> > +    maxItems: 1
> >> >> > +    description: GPIO specifier for backlight enable pin.
> >> >> > +
> >> >> > +  max-brightness: true
> >> >> > +
> >> >> > +required:
> >> >> > +  - compatible
> >> >> > +  - ddc-i2c-bus
> >> >> > +
> >> >> > +additionalProperties: false
> >> >> > +
> >> >> > +examples:
> >> >> > +  - |
> >> >> > +    backlight {
> >> >> > +        compatible = "dp-aux-backlight";
> >> >> > +        ddc-i2c-bus = <&sn65dsi86_bridge>;
> >> >> > +        enable-gpios = <&tlmm 12 GPIO_ACTIVE_HIGH>;
> >> >>
> >> >> So the DDC bus is connected to a backlight and also a panel? This
> >> >> binding is not reflecting the h/w, but rather what you want for some
> >> >> driver.
> >> >>
> >> >> There's only one thing here and that's an eDP panel which supports
> >> >> backlight control via DP aux channel. You can figure all that out from
> >> >> the panel's compatible and/or reading the EDID.
> >> >>
> >> >> You might also be interested in this thread:
> >> >>
> >> >> https://lore.kernel.org/lkml/YIKsDtjcIHGNvW0u@orome.fritz.box/
> >> >
> >> > I think Rajeev needs to rework everything anyway as per:
> >> >
> >> > https://lore.kernel.org/r/87zgxl5qar.fsf@intel.com
> >> >
> >> > ...but you're right that it makes sense not to model the backlight as
> >> > a separate node in the device tree. The panel driver can handle
> >> > setting up the backlight.
> >> >
> >> > -Doug
> >>
> >> It was not a good idea to create a separate backlight driver and use
> >> ddc-i2c-bus to get access to DP aux. I am working to move the code
> >> to the panel driver and to utilize the new DRM helper functions
> >> (drm_edp_backlight_*) Lyude has added [1].
> >>
> >> To use these helper functions, the panel driver should have access to
> >> the
> >> "struct drm_dp_aux *". The simple-panel has a "ddc-i2c-bus" property
> >> to give the panel access to the DDC bus and is currently being used to
> >> get the EDID from the panel. Can I use the same ddc bus i2c_adapter to
> >> get
> >> the "struct drm_dp_aux *"?
> >>
> >> As per the suggestion [2], I get the "struct drm_dp_aux *" from the
> >> i2c_adapter of ddc bus (maybe I didn't understand the suggestion
> >> correctly),
> >> and, it turned out, the way I have implemented is not the right way
> >> [3].
> >> So, I am afraid to use the same method in the panel driver.
> >>
> >>
> >> [1] https://lore.kernel.org/dri-devel/871rb5bcf9.fsf@intel.com/
> >> [2] https://www.spinics.net/lists/dri-devel/msg295429.html
> >> [3]
> >> https://lore.kernel.org/dri-devel/20210426111116.4lc3ekxjugjr3oho@maple.lan/
> >
> > So it's definitely up to maintainers, not me. ...but I guess I would
> > have expected something like a new property called "ddc-aux-bus". Then
> > you'd have to create a new API call called something like
> > "of_find_ddc_aux_adapter_by_node()" that would allow you to find it.
> >
>
> To implement the first suggestion, I can think of the following way
> to get the "struct drm_dp_aux" in the panel_simple_probe function:
>
> - Create a new panel-simple DT property "ddc-aux-bus", a phandle to the
> platform device that implements the AUX channel.
>
> - Create a global list of drm_dp_aux in drm_dp_helper.c. Initialize list
> head
> in drm_dp_aux_init(), add the drm_dp_aux onto the list in
> drm_dp_aux_register().
> Similarly, remove the drm_dp_aux from list in drm_dp_aux_unregister().
>
> - Create a new function of_drm_find_dp_aux_by_node() to get the expected
> drm_dp_aux from this global list.
>
> Please let me know your views on this implementation.

BTW: a bunch of discussion today on IRC:

https://people.freedesktop.org/~cbrill/dri-log/?channel=dri-devel&highlight_names=&date=2021-05-11&show_html=true

-Doug
