Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A523B3AA7BD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 01:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbhFPXxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 19:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234815AbhFPXxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 19:53:15 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DC8C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 16:51:07 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id u14so706736qvq.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 16:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+xxjClQX2Ln4rMUIu3nYcCllQ0vQo3Bff596QN80lzw=;
        b=x9ojLAXLOsklJd/OZ4pyLbRHZk0A2n0VWcNUAwluM8llF+TVqy6aRzXywflgbpQV4A
         Ue+/rFqexSb/i02pUJ1VYBqGbcPkpzRe7v/c5SBPk3MfJMcG+6W/QkzSHiOpw1TpCY4O
         eptqV1HMP5IHiHCavjKmTQY+N5NZls1goODOAgXm2HPvnKJpCYGij5oDsfnbhsqkY02e
         800yTJp0NIrpYAxNbwoGh8fe7U72e3SVMtN1qW+BOeUZ4KNwi3z4ixQyuD2YCDalwSbc
         H3DWE9BxXSBrLIUJFQ/wXsmky4xB6VTZrp3NFtRWl6MkJ/VbXIfkIDmjQTMLCNRfXICs
         m6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+xxjClQX2Ln4rMUIu3nYcCllQ0vQo3Bff596QN80lzw=;
        b=RS7J4dAChRCyXv3dTDS/8W4TpNbojhfES6JoXhPe71ZuOifpEeembYED/I+eHMpo2F
         6tgg9aGuHEfmo4Z37QOlEnoZ7yXDllKrfclTju3bxZtRydd1CS3m2kTYDeeWTfNIoDNy
         BYRuoinNVvd1WPj7+thZjfHAEcb322wOLwbbrnM+I/mjpZZ3+FnAe3rqgEpEk5xx/Ig8
         AF3DHiuwoVWM4Pmefm0A42sCSooI8s9gl4XdX8g19ImhcT83nh5QsfHPzziZtXNJeiiD
         tqZDJlCbAlu5m8q1uw2sU49IyRgNr+0/mQlkGFA72ed+kflSB7hYldr/Wk8wXsB2Y6W1
         5vfQ==
X-Gm-Message-State: AOAM530MfEDrY5SAnbcXy6KtFshT/6EzxnKzGCbx9urgS7QmcaowwMts
        IUPh+tNO7UVnMu2EBUEph+NqxjoFarC/XB9SC9EP3w==
X-Google-Smtp-Source: ABdhPJwp+Bz+m79mmaF/d4WYXZvilQIXkSEONK+MxAQMA/PIjyEws+gn3jzWrXVgV7V0/fhk4xsxhRcINJoUOhru3+Q=
X-Received: by 2002:a0c:e88b:: with SMTP id b11mr2743208qvo.59.1623887467103;
 Wed, 16 Jun 2021 16:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210616190759.2832033-1-mw@semihalf.com> <20210616190759.2832033-3-mw@semihalf.com>
 <YMpR+lJqcgQU2DMO@lunn.ch>
In-Reply-To: <YMpR+lJqcgQU2DMO@lunn.ch>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Thu, 17 Jun 2021 01:50:55 +0200
Message-ID: <CAPv3WKdOkxV695DbhhYr+wf1rnphtj-pyERZ-74RrdZyQJGt=g@mail.gmail.com>
Subject: Re: [net-next: PATCH v2 2/7] net: mdiobus: Introduce fwnode_mdbiobus_register()
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Grzegorz Bernacki <gjb@semihalf.com>, upstream@semihalf.com,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        Jon Nettleton <jon@solid-run.com>,
        Tomasz Nowicki <tn@semihalf.com>, rjw@rjwysocki.net,
        lenb@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 16 cze 2021 o 21:33 Andrew Lunn <andrew@lunn.ch> napisa=C5=82(a):
>
> On Wed, Jun 16, 2021 at 09:07:54PM +0200, Marcin Wojtas wrote:
> > This patch introduces a new helper function that
> > wraps acpi_/of_ mdiobus_register() and allows its
> > usage via common fwnode_ interface.
> >
> > Fall back to raw mdiobus_register() in case CONFIG_FWNODE_MDIO
> > is not enabled, in order to satisfy compatibility
> > in all future user drivers.
>
> > Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> > ---
> >  include/linux/fwnode_mdio.h    | 12 +++++++++++
> >  drivers/net/mdio/fwnode_mdio.c | 22 ++++++++++++++++++++
> >  2 files changed, 34 insertions(+)
> >
> > diff --git a/include/linux/fwnode_mdio.h b/include/linux/fwnode_mdio.h
> > index faf603c48c86..13d4ae8fee0a 100644
> > --- a/include/linux/fwnode_mdio.h
> > +++ b/include/linux/fwnode_mdio.h
> > @@ -16,6 +16,7 @@ int fwnode_mdiobus_phy_device_register(struct mii_bus=
 *mdio,
> >  int fwnode_mdiobus_register_phy(struct mii_bus *bus,
> >                               struct fwnode_handle *child, u32 addr);
> >
> > +int fwnode_mdiobus_register(struct mii_bus *bus, struct fwnode_handle =
*fwnode);
> >  #else /* CONFIG_FWNODE_MDIO */
> >  int fwnode_mdiobus_phy_device_register(struct mii_bus *mdio,
> >                                      struct phy_device *phy,
> > @@ -30,6 +31,17 @@ static inline int fwnode_mdiobus_register_phy(struct=
 mii_bus *bus,
> >  {
> >       return -EINVAL;
> >  }
> > +
> > +static inline int fwnode_mdiobus_register(struct mii_bus *bus,
> > +                                       struct fwnode_handle *fwnode)
> > +{
> > +     /*
> > +      * Fall back to mdiobus_register() function to register a bus.
> > +      * This way, we don't have to keep compat bits around in drivers.
> > +      */
> > +
> > +     return mdiobus_register(mdio);
> > +}
>
> I'm not sure this fallback is correct.
>
> Any driver which decides to use fwmode is going to select it. If it is
> not selected, you want a link time error, or a compiler time error to
> tell you, you are missing FWNODE_MDIO. Calling mdiobus_register() is
> unlikely to work, or the driver would of done that directly.
>

This kind of fallback is done in of_mdiobus_register and acpi_mdiobus_regis=
ter.

Actually mvmdio driver is using this fallback for non-dt platforms
(e.g. Orion). Therefore I would prefer to keep the current behavior.

Best regards,
Marcin
