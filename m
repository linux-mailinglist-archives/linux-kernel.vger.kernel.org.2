Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE78355AED
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 20:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbhDFSBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 14:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbhDFSBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 14:01:48 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72600C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 11:01:40 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id s2so654853uap.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 11:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nbgL2Qq4BnarnUuwkqdsPhJlo1aRh+4yOXd+IwjHg+o=;
        b=Tsy8czEEzk6mVMWek893ZuICWwWNznqaOeneAGUu0Xy0w6oRImpv3CyYSo1dq66qfG
         BHHkJfB0K7VklqQUEWYa+yBwbX1q1wnuT4VwcQw7PyeaGcX44V9e8Z/wNwGNcP5NDCiG
         ij9mol6gRQEWCJ+LQvCCjqESbmstqwXnS5+Ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nbgL2Qq4BnarnUuwkqdsPhJlo1aRh+4yOXd+IwjHg+o=;
        b=JWtJ7HB1w+uOvtZTA/eZtoGtt9XVb1DoyM2flszXwbEU7DPdOLkyuKqWK8lpzEcTQz
         tnrY3O7xusEERVC4hifJWjPCSwvfDMHYTDaDZI+uhdUAwkorGv/aPesZCXyo67d0fr/k
         Ls9Be0p2N9udvqEpsiymk6acjuDgbkl6fanb8lBZ9VYSbyyYllD8OkHcGml4r1/0cW1f
         vSdE9wsPhnt9bBv1QjmkwgCcGusr+PU94I2V9lFG0MgEsAGfGlpzOTrbbpRVkK6ApCCh
         FMwoFPh+zelE4HZBlLeuug4vW1FGPdy8i6S/Vblh/0UoPuqi1SDgscS5Pc/zdNmrV31M
         1wlw==
X-Gm-Message-State: AOAM530cERLNIf6PTLfUSUJjg7rPqoUk2phf1RBy4zQqXHepHIE6ee7V
        e0LpaRMhi5by1JFoNlSlvhqvkVLDfHv/eyR9TOhEtg==
X-Google-Smtp-Source: ABdhPJxIBX8FPIcavna8dpkkkJzqxvRkitCszIZiZaoDO1jByymqs+zNZyMuzPZKO/wRuv3V5UH7u+KPe8SbGetujrQ=
X-Received: by 2002:ab0:3885:: with SMTP id z5mr4476593uav.84.1617732099269;
 Tue, 06 Apr 2021 11:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210405231344.1403025-1-grundler@chromium.org>
 <YGumuzcPl+9l5ZHV@lunn.ch> <CANEJEGsYQm9EhqVLA4oedP2fuKrP=3bOUDV9=7owfdZzX7SpUA@mail.gmail.com>
 <YGxbXOXquilXNV2W@lunn.ch>
In-Reply-To: <YGxbXOXquilXNV2W@lunn.ch>
From:   Grant Grundler <grundler@chromium.org>
Date:   Tue, 6 Apr 2021 18:01:27 +0000
Message-ID: <CANEJEGs7LtNCG4qPMi1PTK_NWBybO9TjzF3nMrFQYV5S5ZqZ9g@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/4] usbnet: speed reporting for devices
 without MDIO
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Grant Grundler <grundler@chromium.org>,
        Oliver Neukum <oneukum@suse.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Roland Dreier <roland@kernel.org>,
        nic_swsd <nic_swsd@realtek.com>, netdev <netdev@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Key part of Andew's reply: "Yes, this discussion should not prevent
this patchset from being merged."]

On Tue, Apr 6, 2021 at 1:00 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > Speed: 2500Mb/s and Duplex: Half is very unlikely. You really only
> > > ever see 10 Half and occasionally 100 Half. Anything above that will
> > > be full duplex.
> > >
> > > It is probably best to admit the truth and use DUPLEX_UNKNOWN.
> >
> > Agreed. I didn't notice this "lie" until I was writing the commit
> > message and wasn't sure off-hand how to fix it. Decided a follow on
> > patch could fix it up once this series lands.
> >
> > You are right that DUPLEX_UNKNOWN is the safest (and usually correct) default.
> > Additionally, if RX and TX speed are equal, I am willing to assume
> > this is DUPLEX_FULL.
>
> Is this same interface used by WiFi?

I doubt WiFi could work with this driver interface (though maybe with
"SendEncapsulatedCommand").
All the Wifi Devices I'm familiar with need WPA support and
communicate through 80211 kernel subsystem.

I was thinking of just about everything else: Cellular modem
(cdc_ether), xDSL, or other broadband.

> Ethernet does not support
> different rates in each direction. So if RX and TX are different, i
> would actually say something is broken.

Agreed. The question is: Is there data or some heuristics we can use
to determine if the physical layer/link is ethernet?
I'm pessimistic we will be able to since this is at odds with the
intent of the CDC spec.

> 10 Half is still doing 10Mbps
> in each direction, it just cannot do both at the same time.
> WiFi can have asymmetric speeds.

*nod*

> > I can propose something like this in a patch:
> >
> > grundler <1637>git diff
> > diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
> > index 86eb1d107433..a7ad9a0fb6ae 100644
> > --- a/drivers/net/usb/usbnet.c
> > +++ b/drivers/net/usb/usbnet.c
> > @@ -978,6 +978,11 @@ int usbnet_get_link_ksettings_internal(struct
> > net_device *net,
> >         else
> >                 cmd->base.speed = SPEED_UNKNOWN;
> >
> > +       if (dev->rx_speed == dev->tx_speed)
> > +               cmd->base.duplex = DUPLEX_FULL;
> > +       else
> > +               cmd->base.duplex =DUPLEX_UNKNOWN;
> > +
> >         return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(usbnet_get_link_ksettings_internal);
>
> So i would say this is wrong. I would just set DUPLEX_UNKNOWN and be
> done.

Ok.

> > I can send this out later once this series lands or you are welcome to
> > post this with additional checks if you like.
>
> Yes, this discussion should not prevent this patchset from being
> merged.

Good. That's what I'm hoping for.

> > If we want to assume autoneg is always on (regardless of which type of
> > media cdc_ncm/cdc_ether are talking to), we could set both supported
> > and advertising to AUTO and lp_advertising to UNKNOWN.
>
> I pretty much agree autoneg has to be on. If it is not, and it is
> using a forced speed, there would need to be an additional API to set
> what it is forced to. There could be such proprietary calls, but the
> generic cdc_ncm/cdc_ether won't support them.

Good observation. Agreed.

> But i also don't know how setting autoneg actually helps the user.

Just to let them know the link rate can change and is dynamically determined.

> Everybody just assumes it is supported. If you really know auto-neg is
> not supported and you can reliably indicate that autoneg is not
> supported, that would be useful. But i expect most users want to know
> if their USB 2.0 device is just doing 100Mbps, or if their USB 3.0
> device can do 2.5G. For that, you need to see what is actually
> supported.

Yes. Other than using a table to look up USB VID:PID, I don't see
anything in the spec which provides "media-specific" information.

I was curious about the "can do 2.5Gbps?" question by looking at the
CDC Ethernet Networking Functional Descriptor (USBECM12) and other CDC
specs. The spec feels like a "compatibility wrapper" to make a
cellular modem look like an ethernet device. This statement in the
ECM120.pdf I have suggests we can not determine media layer:
    The effect of a "reset" on the device physical layer is
media-dependent and beyond the scope of this specification.

cheers,
grant
