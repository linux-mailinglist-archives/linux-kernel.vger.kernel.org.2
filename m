Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB6531FBA9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 16:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhBSPGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 10:06:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:38760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhBSPGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 10:06:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC63C64EB2;
        Fri, 19 Feb 2021 15:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613747149;
        bh=TFnkMI7UMPE4haMLe6s3+bb5ZQ9eOM3Ey+RTradDiDw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ty/5YzIJLHmMx8pxXU6Xc7TCwPBY6RbIS1pQ4CF6uDiuX+7FxIhwy+nCphfhw8t1D
         DF5259hbST/ddPx6JoNwaTwrgoLgE9mWvRGY73dXjcc9Ckv75Pwut5lqeMWH4FB1Vg
         6IEmPCVOZkyHBc0FipmPYOE9+eIgmc1syhp+DjL9fzogqV4fEHL1b4e2Zis2U6Es6R
         mBjEoFwJUsApP4sKTP0OsobfOXTLP2RWLdtkelJmn8dkQr3sFcQKIiFDvdOBMjffSM
         vYEvq9Q5b9USTWMAojfaOklBNLa1/O3wi8GM77UwP2uvPGQ0Z3mUZ0zWOKD8JoGUct
         ucaYhVS1Qbvuw==
Received: by mail-ej1-f42.google.com with SMTP id jt13so14050110ejb.0;
        Fri, 19 Feb 2021 07:05:48 -0800 (PST)
X-Gm-Message-State: AOAM532k1MrC2Nm/leb3RSWT894h2DQ8m8OJLHM9mscfwkLhV6Caeo+j
        2LBfbvvRjaQfu55d6FoR8LCmpG2vAnqKhohvRQ==
X-Google-Smtp-Source: ABdhPJxwf92OLiYw/F0K/zCoeETq2eLzpqjZQCpW2a8fUC6ug9uXCBJkRGGcFN3inDyFBjc6U9JNrumZ23ohXOLG+BQ=
X-Received: by 2002:a17:906:d1d0:: with SMTP id bs16mr9376281ejb.468.1613747147168;
 Fri, 19 Feb 2021 07:05:47 -0800 (PST)
MIME-Version: 1.0
References: <20210210171040.684659-1-mka@chromium.org> <20210210091015.v5.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <20210217210441.GA2709172@robh.at.kernel.org> <YC3D/+DZYFjgHQ3H@google.com>
In-Reply-To: <YC3D/+DZYFjgHQ3H@google.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 19 Feb 2021 09:05:32 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+=LOwOiorpR85UYwYgXCGT-Ai2MbBPWNf+t3X0tLYhqA@mail.gmail.com>
Message-ID: <CAL_Jsq+=LOwOiorpR85UYwYgXCGT-Ai2MbBPWNf+t3X0tLYhqA@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] dt-bindings: usb: Add binding for discrete onboard
 USB hubs
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Peter Chen <peter.chen@nxp.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Bastien Nocera <hadess@hadess.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 7:33 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Hi Rob,
>
> thanks for your review!
>
> On Wed, Feb 17, 2021 at 03:04:41PM -0600, Rob Herring wrote:
> > On Wed, Feb 10, 2021 at 09:10:36AM -0800, Matthias Kaehlcke wrote:
> > > Discrete onboard USB hubs (an example for such a hub is the Realtek
> > > RTS5411) need to be powered and may require initialization of other
> > > resources (like GPIOs or clocks) to work properly. This adds a device
> > > tree binding for these hubs.
> > >
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> > >
> > > Changes in v5:
> > > - updated 'title'
> > > - only use standard USB compatible strings
> > > - deleted 'usb_hub' node
> > > - renamed 'usb_controller' node to 'usb-controller'
> > > - removed labels from USB nodes
> > > - added 'vdd-supply' to USB nodes
> > >
> > > Changes in v4:
> > > - none
> > >
> > > Changes in v3:
> > > - updated commit message
> > > - removed recursive reference to $self
> > > - adjusted 'compatible' definition to support multiple entries
> > > - changed USB controller phandle to be a node
> > >
> > > Changes in v2:
> > > - removed 'wakeup-source' and 'power-off-in-suspend' properties
> > > - consistently use spaces for indentation in example
> > >
> > >  .../bindings/usb/onboard_usb_hub.yaml         | 49 +++++++++++++++++++
> > >  1 file changed, 49 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml b/Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml
> > > new file mode 100644
> > > index 000000000000..bf4ec52e6c7b
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml
> > > @@ -0,0 +1,49 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/usb/onboard_usb_hub.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Binding for discrete onboard USB hubs
> >
> > This isn't really generic. Maybe there's a set of hubs with only a
> > single supply much like 'simple-panel', but I kind of doubt that here.
> > There aren't hundreds of hub chips like panels. Though, we should put
> > this into bindings/usb/hub/ so we start collecting hub bindings in one
> > place.
>
> Ok, I agree that the name of the binding is too generic, I anticipated that
> the power supply section would need to be extended to support other hub
> chips.
>
> > A generic driver doesn't have to have a generic binding.
>
> That's a good point, it seems to make sense to have separate bindings in
> this case.
>
> > You can have a specific device binding which is handled by a generic
> > driver. Or not. Who knows. Maybe a simple user like u-boot has a generic
> > driver while something more feature rich has a device specific binding.
> >
> > > +
> > > +maintainers:
> > > +  - Matthias Kaehlcke <mka@chromium.org>
> >
> > Now we have usb-device.yaml, you need:
> >
> > allOf:
> >   - $ref: usb-device.yaml#
>
> ok
>
> So with your comments addressed it seems we have a binding that could be
> acceptable. I'll still hold back a bit to see if we can make progress with
> the discussion about using the 'graph' binding (https://lore.kernel.org/patchwork/patch/1379002/#1578294).
> The one thing I don't like about the current binding is that it wouldn't
> work out of the box with a hierarchy of hubs. To make that work on the
> driver side an additional property would be needed to indicate that two
> (or more) USB hub devices are related (i.e. are provided by the same
> chip). This is needed to be able to decide whether the hub should be
> powered down during system suspend.

How about a 'hub-companion' property or similar?

Rob
