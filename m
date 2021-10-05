Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCFB9422AF4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbhJEO0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234437AbhJEO0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:26:16 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7680FC061749;
        Tue,  5 Oct 2021 07:24:25 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id f13so9160937uan.6;
        Tue, 05 Oct 2021 07:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fkUZ7DdFeWkEpyDRZ/1dM/ty+cqUyDxv2VSxJU7d1zc=;
        b=bU5JIPdpARDVB55z0K2+CLoUJgHYBy6m9RQhkSHDIhiVsRqGHWwn1rHOEi9hKGl345
         rbytzpzJXF89ylrynFg9UnGnph3EHP40DqVbiriw6oF3io73pcJNqv6cKVZ1KTvpposF
         UkD7gZYhfkG9qcSjHP7X8xTdrb1W2OoYvnVgFliw+uINq6Cp16FyvBWwIdIcpSBSw9K3
         r+7glMFCnUt3LW6IuttDWBqIY7v0vuxbPUP5A4sPQfOKkp8SO+6v8jOGKEBkro6hAE/D
         lGVTwDvAeTr0IzrtN0icLbweNZgPH7lT30H9bAJplbQZ3I8XIHlSYBW311J5lQI9AJRd
         Os3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fkUZ7DdFeWkEpyDRZ/1dM/ty+cqUyDxv2VSxJU7d1zc=;
        b=au2mCCeNyisJvfupD/gB045B2gY0On6cX5eeV6pQSmfHb792o1aY6SlVopIXBuUqe6
         NVPyndZK20nidak6l7ezSq7v38Ql5y3Loa3EpBPJV01W8jvVcDc6fIZ94p/LZ9PvzIWr
         yyYvPpW3fxPldgWzJjpVxLnFI20BqNXVT1pnZZqC4e+vfhlLl8rQ0X2E8Zg3mKVjSzub
         lSgzHIFQe1Xx0xggfQHffNdK3vI2vKO4VpjJraJdsG1ucEbwk9q+E153TuBeaUbJdly8
         AkZc8d2u6LsCWv24LE4GPG1uKeny19xS1ty5LfxYBG1SmopZjPhqka8rLl9qH5vpf8PV
         obtw==
X-Gm-Message-State: AOAM533BMWPOZGn6CYn2fGjK8Qnl42dxZcN/YqMnxfvW75hzRGi8Cm64
        i9pNsCTXt6Etf9PPwPLjjGucu5RZo6sIlk2lm8rec5st8mg=
X-Google-Smtp-Source: ABdhPJyvi75JWiWJrIbgesEtwwpwS2QwxXNTC393L1igtxGKdv0pJbR/hj13HjwDvZJngNIPNVjl0CV2RV76dVUFLJg=
X-Received: by 2002:ab0:538b:: with SMTP id k11mr12027715uaa.131.1633443864593;
 Tue, 05 Oct 2021 07:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210926145931.14603-1-sergio.paracuellos@gmail.com>
 <20210926145931.14603-3-sergio.paracuellos@gmail.com> <YVtCtGcLjNcO2NJ0@robh.at.kernel.org>
 <CAMhs-H9TDEWEffDn7hBQxT127RNU4eUtPxaSciuiis0fPqTN_w@mail.gmail.com> <CAL_Jsq+U_0JnCoJVaHH0T+kdmxX_OosD9=OT0dWyNdwbe=CLoQ@mail.gmail.com>
In-Reply-To: <CAL_Jsq+U_0JnCoJVaHH0T+kdmxX_OosD9=OT0dWyNdwbe=CLoQ@mail.gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 5 Oct 2021 16:24:12 +0200
Message-ID: <CAMhs-H_3Z34e3_n4VrMayvbOt0MJ_RuJ=jYDgQynT6Zdo1eDVw@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt: bindings: add ralink RT2880 resets device tree
 binding documentation
To:     Rob Herring <robh@kernel.org>
Cc:     linux-staging@lists.linux.dev, John Crispin <john@phrozen.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
        NeilBrown <neil@brown.name>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, Oct 5, 2021 at 3:27 PM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Oct 4, 2021 at 1:23 PM Sergio Paracuellos
> <sergio.paracuellos@gmail.com> wrote:
> >
> > Hi Rob,
> >
> > On Mon, Oct 4, 2021 at 8:06 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Sun, Sep 26, 2021 at 04:59:30PM +0200, Sergio Paracuellos wrote:
> > > > Adds device tree binding documentation for resets in the ralink RT2880 SoCs.
> > > >
> > > > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > > > ---
> > > >  .../bindings/reset/ralink,rt2880-reset.yaml   | 39 +++++++++++++++++++
> > > >  1 file changed, 39 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/reset/ralink,rt2880-reset.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/reset/ralink,rt2880-reset.yaml b/Documentation/devicetree/bindings/reset/ralink,rt2880-reset.yaml
> > > > new file mode 100644
> > > > index 000000000000..88eddeb4ee45
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/reset/ralink,rt2880-reset.yaml
> > > > @@ -0,0 +1,39 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/reset/ralink,rt2880-reset.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Ralink RT2880 Reset Controller Device Tree Bindings
> > > > +
> > > > +maintainers:
> > > > +  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > > > +
> > > > +description: |
> > > > +  Ralink RT2880 reset controller driver which supports the SoC
> > > > +  system controller supplied reset registers for the various peripherals
> > > > +  of the SoC.
> > > > +
> > > > +  See also:
> > > > +  - dt-bindings/reset/ralink-rt2880.h
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: ralink,rt2880-reset
> > > > +
> > > > +  '#reset-cells':
> > > > +    const: 1
> > > > +
> > > > +required:
> > > > +  - '#reset-cells'
> > > > +  - compatible
> > > > +
> > > > +additionalProperties: false
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    #include <dt-bindings/reset/ralink-rt2880.h>
> > > > +    rstctrl: reset-controller {
> > > > +      compatible = "ralink,rt2880-reset";
> > > > +      #reset-cells = <1>;
> > >
> > > How is this h/w controlled? If this is part of a system controller, then
> > > it needs to be documented as such. IOW, you need to document the binding
> > > for the whole block.
> > >
> > > Do you really need a child node here? All you need to make a system
> > > controller a reset provider is add '#reset-cells' to it.
> >
> > I am just documenting what is already mainlined (see [0]) in order to
> > get mt7621-dts out of staging at some point of my life. What am I
> > supposed to do? Should I rewrite all already mainlined code? Because
> > if that is the case we need to rewrite tons of things from the ralink
> > platform...
>
> On the flip side, am I not supposed to review bindings because the dts
> is already in staging? Code dependent on DT bindings shouldn't have
> been mainlined without any documented binding.

Thanks for reviewing this. I guess I should have sent a complete
patchset with all remaining bindings and the move for the complete
binding instead of sending single binding doc patches.

>
> Looks like the resets are part of "mediatek,mt7621-sysc" to answer my
> question. Add a #reset-cell to that node (and binding) and then change
> this line to "mediatek,mt7621-sysc":
>
>         reset_dev.of_node = of_find_compatible_node(NULL, NULL,
>                                                 "ralink,rt2880-reset");
>
> That's the minimal change, but really I would move the reset code to
> the clock driver as that is what handles the sysc node.

It is not that easy since the code in reset.c is shared for all ralink
platforms and the mediatek,mt7621-sysc node is only for mt7621. So I
guess I have to "duplicate" the reset code and put it in the clock
driver for mt7621 as you are pointing out here. I have to also review
how other drivers are using the reset, using reset apis or directly
through the syscon.

>
>
> > I'd also like to know what we should do with those nodes already added
> > to the dtsi file that have not got associated compatible driver
> > mainlined. Can we just get rid of them?
>
> Yes. Typically dts files start with minimal support.
>
> A dts file in staging is odd. We shouldn't be adding them there.

Thanks for clarification.

Best regards,
    Sergio Paracuellos

>
> Rob
