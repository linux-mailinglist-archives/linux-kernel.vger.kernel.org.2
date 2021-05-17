Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0C5386B4D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 22:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240153AbhEQUWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 16:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239066AbhEQUWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 16:22:45 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677EEC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 13:21:28 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id h21so5864758qtu.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 13:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YbOc4wBUAuWLpQV8tQYF0Szc0TEanL1YgzGe8uwJTk0=;
        b=MDsTJSWmGwCIDzu6zW9zcrriVhwGiwCq3aJpoDMW9oN1778XWwMHUUcYYP6Di8riOw
         zwDAQH1Yem8aJ4di6f1iiO2XYeZqWUgO/BPE4w0IWLzGJA7z0/Y8U4WPoLtWDfrXKPJN
         sNW777niA54Q9l7QP5t4QstVsHnD2iLaMKph0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YbOc4wBUAuWLpQV8tQYF0Szc0TEanL1YgzGe8uwJTk0=;
        b=ZsbXmN46Lp2kt+allHncXW4pXSlvmDoSV+fxd3Ir68JVuneK4P44ybfzvhD3SYoJMb
         4Q8NsPZ52FxrtnkL9QgzezPn19WTfK9xTY6vW3hYHAeCqPRKkXkpDf5eijgyHkhUK/UD
         w07/KrGhDAI3DOCQ6/nGsikaDEcTZ53bstzgBuRfeNZrYlraR824gnaVMdoLeyART2B6
         +UkxXi/DqDbz1cSemeMBDk42+LJRi4Z/ttTwldelfyNLDGB89hELWBcmQdPSINGoSQx8
         syaDQkZGemXsNtDIa6H8yVRc0Mu3kmBJI7Motb6oW0iobcRJEg9L/ldnzM0CIkJ9XaxQ
         X/sw==
X-Gm-Message-State: AOAM533rW7Rycb9QAW0eLirDdG5mcPqiMda+FP1DFXoGqFdOA9jybZcq
        uYoGYiAwDeEx/0EySPaVwk2Xdm2UJmfXgQ==
X-Google-Smtp-Source: ABdhPJyimHmHFxseHY4XKosgHOD7ZdpKaqjEwuwAZNe07TzcQuHHK5qVrlHcfc+ezP84HskhIGQw5g==
X-Received: by 2002:aed:2067:: with SMTP id 94mr1300899qta.90.1621282887362;
        Mon, 17 May 2021 13:21:27 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id 2sm11254258qko.28.2021.05.17.13.21.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 13:21:26 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id y2so10194644ybq.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 13:21:25 -0700 (PDT)
X-Received: by 2002:a05:6902:512:: with SMTP id x18mr2401179ybs.405.1621282885353;
 Mon, 17 May 2021 13:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <1619416756-3533-1-git-send-email-rajeevny@codeaurora.org>
 <1619416756-3533-2-git-send-email-rajeevny@codeaurora.org>
 <20210429180435.GA1385465@robh.at.kernel.org> <CAD=FV=V-kdySH5Pp-Fb-PRYk60Ha_UOTXJHcvMp+uV3P1oo7Uw@mail.gmail.com>
 <78c4bd291bd4a17ae2a1d02d0217de43@codeaurora.org> <CAD=FV=XW90L6or8NKA-Rjjp3s3fRno1xSkD+X0PA1rTyeKgpMw@mail.gmail.com>
 <c867b2e59e90899e6c1648e06f5f9cd2@codeaurora.org> <CAD=FV=XBb9zs=ZGG-Ky8=_is20L1O6pJ-xBV1k5cF6-vL78pgA@mail.gmail.com>
In-Reply-To: <CAD=FV=XBb9zs=ZGG-Ky8=_is20L1O6pJ-xBV1k5cF6-vL78pgA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 17 May 2021 13:21:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XPDLn187AR06xzChwT1Y0pCeQmRvhO_MjEoMoabXwybg@mail.gmail.com>
Message-ID: <CAD=FV=XPDLn187AR06xzChwT1Y0pCeQmRvhO_MjEoMoabXwybg@mail.gmail.com>
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

On Tue, May 11, 2021 at 4:17 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Tue, May 11, 2021 at 11:12 AM <rajeevny@codeaurora.org> wrote:
> >
> > On 01-05-2021 03:08, Doug Anderson wrote:
> > > Hi,
> > >
> > > On Fri, Apr 30, 2021 at 8:10 AM <rajeevny@codeaurora.org> wrote:
> > >>
> > >> On 30-04-2021 02:33, Doug Anderson wrote:
> > >> > Hi,
> > >> >
> > >> > On Thu, Apr 29, 2021 at 11:04 AM Rob Herring <robh@kernel.org> wrote:
> > >> >>
> > >> >> On Mon, Apr 26, 2021 at 11:29:15AM +0530, Rajeev Nandan wrote:
> > >> >> > Add bindings for DisplayPort aux backlight driver.
> > >> >> >
> > >> >> > Changes in v2:
> > >> >> > - New
> > >> >> >
> > >> >> > Signed-off-by: Rajeev Nandan <rajeevny@codeaurora.org>
> > >> >> > ---
> > >> >> >  .../bindings/leds/backlight/dp-aux-backlight.yaml  | 49 ++++++++++++++++++++++
> > >> >> >  1 file changed, 49 insertions(+)
> > >> >> >  create mode 100644 Documentation/devicetree/bindings/leds/backlight/dp-aux-backlight.yaml
> > >> >> >
> > >> >> > diff --git a/Documentation/devicetree/bindings/leds/backlight/dp-aux-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/dp-aux-backlight.yaml
> > >> >> > new file mode 100644
> > >> >> > index 00000000..0fa8bf0
> > >> >> > --- /dev/null
> > >> >> > +++ b/Documentation/devicetree/bindings/leds/backlight/dp-aux-backlight.yaml
> > >> >> > @@ -0,0 +1,49 @@
> > >> >> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > >> >> > +%YAML 1.2
> > >> >> > +---
> > >> >> > +$id: http://devicetree.org/schemas/leds/backlight/dp-aux-backlight.yaml#
> > >> >> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > >> >> > +
> > >> >> > +title: DisplayPort aux backlight driver bindings
> > >> >> > +
> > >> >> > +maintainers:
> > >> >> > +  - Rajeev Nandan <rajeevny@codeaurora.org>
> > >> >> > +
> > >> >> > +description:
> > >> >> > +  Backlight driver to control the brightness over DisplayPort aux channel.
> > >> >> > +
> > >> >> > +allOf:
> > >> >> > +  - $ref: common.yaml#
> > >> >> > +
> > >> >> > +properties:
> > >> >> > +  compatible:
> > >> >> > +    const: dp-aux-backlight
> > >> >> > +
> > >> >> > +  ddc-i2c-bus:
> > >> >> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > >> >> > +    description:
> > >> >> > +      A phandle to the system I2C controller connected to the DDC bus used
> > >> >> > +      for the DisplayPort AUX channel.
> > >> >> > +
> > >> >> > +  enable-gpios:
> > >> >> > +    maxItems: 1
> > >> >> > +    description: GPIO specifier for backlight enable pin.
> > >> >> > +
> > >> >> > +  max-brightness: true
> > >> >> > +
> > >> >> > +required:
> > >> >> > +  - compatible
> > >> >> > +  - ddc-i2c-bus
> > >> >> > +
> > >> >> > +additionalProperties: false
> > >> >> > +
> > >> >> > +examples:
> > >> >> > +  - |
> > >> >> > +    backlight {
> > >> >> > +        compatible = "dp-aux-backlight";
> > >> >> > +        ddc-i2c-bus = <&sn65dsi86_bridge>;
> > >> >> > +        enable-gpios = <&tlmm 12 GPIO_ACTIVE_HIGH>;
> > >> >>
> > >> >> So the DDC bus is connected to a backlight and also a panel? This
> > >> >> binding is not reflecting the h/w, but rather what you want for some
> > >> >> driver.
> > >> >>
> > >> >> There's only one thing here and that's an eDP panel which supports
> > >> >> backlight control via DP aux channel. You can figure all that out from
> > >> >> the panel's compatible and/or reading the EDID.
> > >> >>
> > >> >> You might also be interested in this thread:
> > >> >>
> > >> >> https://lore.kernel.org/lkml/YIKsDtjcIHGNvW0u@orome.fritz.box/
> > >> >
> > >> > I think Rajeev needs to rework everything anyway as per:
> > >> >
> > >> > https://lore.kernel.org/r/87zgxl5qar.fsf@intel.com
> > >> >
> > >> > ...but you're right that it makes sense not to model the backlight as
> > >> > a separate node in the device tree. The panel driver can handle
> > >> > setting up the backlight.
> > >> >
> > >> > -Doug
> > >>
> > >> It was not a good idea to create a separate backlight driver and use
> > >> ddc-i2c-bus to get access to DP aux. I am working to move the code
> > >> to the panel driver and to utilize the new DRM helper functions
> > >> (drm_edp_backlight_*) Lyude has added [1].
> > >>
> > >> To use these helper functions, the panel driver should have access to
> > >> the
> > >> "struct drm_dp_aux *". The simple-panel has a "ddc-i2c-bus" property
> > >> to give the panel access to the DDC bus and is currently being used to
> > >> get the EDID from the panel. Can I use the same ddc bus i2c_adapter to
> > >> get
> > >> the "struct drm_dp_aux *"?
> > >>
> > >> As per the suggestion [2], I get the "struct drm_dp_aux *" from the
> > >> i2c_adapter of ddc bus (maybe I didn't understand the suggestion
> > >> correctly),
> > >> and, it turned out, the way I have implemented is not the right way
> > >> [3].
> > >> So, I am afraid to use the same method in the panel driver.
> > >>
> > >>
> > >> [1] https://lore.kernel.org/dri-devel/871rb5bcf9.fsf@intel.com/
> > >> [2] https://www.spinics.net/lists/dri-devel/msg295429.html
> > >> [3]
> > >> https://lore.kernel.org/dri-devel/20210426111116.4lc3ekxjugjr3oho@maple.lan/
> > >
> > > So it's definitely up to maintainers, not me. ...but I guess I would
> > > have expected something like a new property called "ddc-aux-bus". Then
> > > you'd have to create a new API call called something like
> > > "of_find_ddc_aux_adapter_by_node()" that would allow you to find it.
> > >
> >
> > To implement the first suggestion, I can think of the following way
> > to get the "struct drm_dp_aux" in the panel_simple_probe function:
> >
> > - Create a new panel-simple DT property "ddc-aux-bus", a phandle to the
> > platform device that implements the AUX channel.
> >
> > - Create a global list of drm_dp_aux in drm_dp_helper.c. Initialize list
> > head
> > in drm_dp_aux_init(), add the drm_dp_aux onto the list in
> > drm_dp_aux_register().
> > Similarly, remove the drm_dp_aux from list in drm_dp_aux_unregister().
> >
> > - Create a new function of_drm_find_dp_aux_by_node() to get the expected
> > drm_dp_aux from this global list.
> >
> > Please let me know your views on this implementation.
>
> BTW: a bunch of discussion today on IRC:
>
> https://people.freedesktop.org/~cbrill/dri-log/?channel=dri-devel&highlight_names=&date=2021-05-11&show_html=true

To finish adding breadcrumbs to those playing at home, v7 of my patch
series should get the AUX channel to the panel device:

https://lore.kernel.org/r/20210517200907.1459182-1-dianders@chromium.org/

Assuming that people don't hate that solution it may be a good things
for you to build your patches atop. :-)

-Doug
