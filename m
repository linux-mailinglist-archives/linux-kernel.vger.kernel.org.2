Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0908F321E4E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 18:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhBVRkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 12:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbhBVRj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 12:39:58 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3180DC061786
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 09:39:18 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id q20so7021327pfu.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 09:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MF4APfFlsanpI0r4zsRHCQLQgfReqF48Ze/kE7l1vkE=;
        b=ElFKTM8eUw2BY9ppbokoLTTd00JRQei2N5HBMaXvoy866vTrLd+ZryHOS5tT1lHkmM
         6sBJCbbiOZ2buOZF4WFU7ulZmfuFjZ8SwYOEym0G/+yOwwm2Y+4n3FprefgkLZdWkI5K
         0lSchaoEx05aKUYyJOkAHrmPY0p1N9ZFI76DA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MF4APfFlsanpI0r4zsRHCQLQgfReqF48Ze/kE7l1vkE=;
        b=i8qzMa2LpoXZXaoq7HtEzHxipZeTI2qDgM0KL7h9/0Rca9OEvX3zMFDY93Oe18IIT4
         xGGDlFAtiqOoZzr7Z1IOl95Ss0du0hB+hVaHL8rZcPpVTc54kVp6NQDFdZWpg6mWi8RN
         2XmMyNu6Wjo6W51F4tDjFltmnxHYOM6Ywauwy0wD3ZwdVqUCIzknMMAqGN/DuS+EtSgI
         AN1Fqe4j7qTu6aKO77uSCqs+KzRwkce5OjxK3SRN4X6EjWV91hBILUS8RlmPZQn2Vix7
         q8qqtQ3tunS9P6sVYlKWFK5jnrms1mZgDZw6eLGOA5DH7qAJdI0A3itJe7NM4RwFHIRo
         4r4g==
X-Gm-Message-State: AOAM532jvjQoLGgM6sqB/r/LCpe0V0bJ4HyWhEeXH23RAfQRK3xuqBaa
        3yv3tkcdoQ8KfcsEV+QEvt+QOQ==
X-Google-Smtp-Source: ABdhPJzxxps/L0tFLihFXaGaCOzegV5h5itBz+sA8whlMY95Fx09Bei5MVSeuNsqyFKXgtKrX71Zfg==
X-Received: by 2002:a62:83ca:0:b029:1ed:78d1:531a with SMTP id h193-20020a6283ca0000b02901ed78d1531amr9730539pfe.56.1614015555373;
        Mon, 22 Feb 2021 09:39:15 -0800 (PST)
Received: from localhost ([2620:15c:202:1:61bd:1a6e:a387:22f0])
        by smtp.gmail.com with UTF8SMTPSA id o18sm3927pjq.44.2021.02.22.09.39.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 09:39:14 -0800 (PST)
Date:   Mon, 22 Feb 2021 09:39:12 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rob Herring <robh@kernel.org>
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
Subject: Re: [PATCH v5 1/4] dt-bindings: usb: Add binding for discrete
 onboard USB hubs
Message-ID: <YDPsQNm95Zpm+cjl@google.com>
References: <20210210171040.684659-1-mka@chromium.org>
 <20210210091015.v5.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <20210217210441.GA2709172@robh.at.kernel.org>
 <YC3D/+DZYFjgHQ3H@google.com>
 <CAL_Jsq+=LOwOiorpR85UYwYgXCGT-Ai2MbBPWNf+t3X0tLYhqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+=LOwOiorpR85UYwYgXCGT-Ai2MbBPWNf+t3X0tLYhqA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 09:05:32AM -0600, Rob Herring wrote:
> On Wed, Feb 17, 2021 at 7:33 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > Hi Rob,
> >
> > thanks for your review!
> >
> > On Wed, Feb 17, 2021 at 03:04:41PM -0600, Rob Herring wrote:
> > > On Wed, Feb 10, 2021 at 09:10:36AM -0800, Matthias Kaehlcke wrote:
> > > > Discrete onboard USB hubs (an example for such a hub is the Realtek
> > > > RTS5411) need to be powered and may require initialization of other
> > > > resources (like GPIOs or clocks) to work properly. This adds a device
> > > > tree binding for these hubs.
> > > >
> > > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > > ---
> > > >
> > > > Changes in v5:
> > > > - updated 'title'
> > > > - only use standard USB compatible strings
> > > > - deleted 'usb_hub' node
> > > > - renamed 'usb_controller' node to 'usb-controller'
> > > > - removed labels from USB nodes
> > > > - added 'vdd-supply' to USB nodes
> > > >
> > > > Changes in v4:
> > > > - none
> > > >
> > > > Changes in v3:
> > > > - updated commit message
> > > > - removed recursive reference to $self
> > > > - adjusted 'compatible' definition to support multiple entries
> > > > - changed USB controller phandle to be a node
> > > >
> > > > Changes in v2:
> > > > - removed 'wakeup-source' and 'power-off-in-suspend' properties
> > > > - consistently use spaces for indentation in example
> > > >
> > > >  .../bindings/usb/onboard_usb_hub.yaml         | 49 +++++++++++++++++++
> > > >  1 file changed, 49 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml b/Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml
> > > > new file mode 100644
> > > > index 000000000000..bf4ec52e6c7b
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml
> > > > @@ -0,0 +1,49 @@
> > > > +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/usb/onboard_usb_hub.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Binding for discrete onboard USB hubs
> > >
> > > This isn't really generic. Maybe there's a set of hubs with only a
> > > single supply much like 'simple-panel', but I kind of doubt that here.
> > > There aren't hundreds of hub chips like panels. Though, we should put
> > > this into bindings/usb/hub/ so we start collecting hub bindings in one
> > > place.
> >
> > Ok, I agree that the name of the binding is too generic, I anticipated that
> > the power supply section would need to be extended to support other hub
> > chips.
> >
> > > A generic driver doesn't have to have a generic binding.
> >
> > That's a good point, it seems to make sense to have separate bindings in
> > this case.
> >
> > > You can have a specific device binding which is handled by a generic
> > > driver. Or not. Who knows. Maybe a simple user like u-boot has a generic
> > > driver while something more feature rich has a device specific binding.
> > >
> > > > +
> > > > +maintainers:
> > > > +  - Matthias Kaehlcke <mka@chromium.org>
> > >
> > > Now we have usb-device.yaml, you need:
> > >
> > > allOf:
> > >   - $ref: usb-device.yaml#
> >
> > ok
> >
> > So with your comments addressed it seems we have a binding that could be
> > acceptable. I'll still hold back a bit to see if we can make progress with
> > the discussion about using the 'graph' binding (https://lore.kernel.org/patchwork/patch/1379002/#1578294).
> > The one thing I don't like about the current binding is that it wouldn't
> > work out of the box with a hierarchy of hubs. To make that work on the
> > driver side an additional property would be needed to indicate that two
> > (or more) USB hub devices are related (i.e. are provided by the same
> > chip). This is needed to be able to decide whether the hub should be
> > powered down during system suspend.
> 
> How about a 'hub-companion' property or similar?

Yes, something like that is what I had in mind.

Another inconvenient is that collaboration from the controller /
generic hub driver is needed, however it seems at least Alan would be
ok with that.
