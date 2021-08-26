Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA123F8D03
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 19:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243168AbhHZR1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 13:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhHZR1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 13:27:30 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530C8C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 10:26:43 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id p83so5358773yba.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 10:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yYQs+t0EIVXNcJL/e7NXnt1eBliiSLI4KWvdYpv5yJE=;
        b=o5jF20zdFw4F7zlv6LWM4oAoDDwZcvpgD+hTrp8c1IKC+kbOpwiFoC5oZrmlXisWUr
         +bVFWBKQGVxN13QABD3DJkrBE5wBlKq1Wl68f12WRKy6c8zsll/DQrQHMrBLIQQwWSvh
         um1bA3vYFc5rDOa0+3QkrKyQrobizWzajT9YqYCwlieb5yBbTGFXj6UylPVd8J0z4SRF
         2LvQRQJ0W2TiRhY2gSwlh9gU2Nastn5DFAzidfuushv4T1u5e+S3BOlSaDkRfHN8FCcT
         GX3j1zK7QHZhi08aMfPYCcr1CKNlk++sTh1WUTWsT/zh/jiHPdDcD9gSh9EQWbE5JBTn
         h7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yYQs+t0EIVXNcJL/e7NXnt1eBliiSLI4KWvdYpv5yJE=;
        b=JXJ1Y+fMYQQb3+Lx6Ia1DmA9GF2j7gZsCPmE3qMthnq4p1XXw+5X1TCOhV9vOQWQSq
         fckFlDxx4YBO31fV+fOEs/mzZhjfEbtc7u5xLiMN02R5LdogJ+t4ReCtqf1iojXpqtDQ
         hm2tpkYJp5MfgzhaWtWvyLluSf87J9Rg3w5ssRBZCbQ40KceV5d4Jf0WpmPhH5g6BKFi
         IVgdEUD6v8Fb8o51/oXMZBRsZpxueAK8ZT4YF1b5KspkUjrkZNitxaHOyR9iTxcG0Lgk
         5OlBwq8kALYAtqbbaMtvZUxTDBY9Ak8ugscY69wWOy1RlqlvJGMqn0VOKK6yRqmbXZuh
         Lliw==
X-Gm-Message-State: AOAM5338HylMU+DUUzuesetJdL1vJKC2AtB9AqEfgNeETEcnwSWvxX0u
        czfoD+2mR7Pj1UoFOAOVgU/mYFvXqyr2WvRhoTMk7w==
X-Google-Smtp-Source: ABdhPJyq3Jew02iw5aPHXfc0ByWrxWyeFxGJb4Vo6/uSB293XxWewwqPv2hse5fVx2VzJ3gyHUYZTWhcgmcTiGeFweQ=
X-Received: by 2002:a25:d213:: with SMTP id j19mr4894695ybg.20.1629998802409;
 Thu, 26 Aug 2021 10:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210826074526.825517-1-saravanak@google.com> <20210826074526.825517-3-saravanak@google.com>
 <455824c8-51bf-9517-98fd-1f6b2a21261d@bang-olufsen.dk>
In-Reply-To: <455824c8-51bf-9517-98fd-1f6b2a21261d@bang-olufsen.dk>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 26 Aug 2021 10:26:06 -0700
Message-ID: <CAGETcx8yhH8o791=DNP3kUAqY+3xyH-Mem717hADqak==qpUtw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] net: dsa: rtl8366rb: Quick fix to work with fw_devlink=on
To:     =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 4:29 AM Alvin =C5=A0ipraga <ALSI@bang-olufsen.dk> w=
rote:
>
> Hi Saravana,
>
>  From looking at the code, the Marvell DSA driver mv88e6xxx may also
> suffer from the same problem if fw_devlink=3Don. Maybe somebody (Andrew?)
> could test so that you know whether include a simlar patch to that
> driver in your series.
>
> Other drivers may be effected too - as Andrew said in the other thread,
> this is not an uncommon pattern for DSA drivers.
>
> On 8/26/21 9:45 AM, Saravana Kannan wrote:
> > This is just a quick fix to make this driver work with fw_devlink=3Don.
> > The proper fix might need a significant amount of rework of the driver
> > of the framework to use a component device model.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>
> With the caveat that it's a test with my RFC rtl8365mb subdriver...
>
> Tested-by: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>

Thanks for testing. And just to be sure we are all on the same page:
Without this patch the PHYs get handled by the Generic PHY driver.
With this patch, the PHYs are handled by their specific driver.
Correct?

-Saravana

>
> Kind regards,
> Alvin
>
> > ---
> >   drivers/net/dsa/realtek-smi-core.c | 7 +++++++
> >   1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/net/dsa/realtek-smi-core.c b/drivers/net/dsa/realt=
ek-smi-core.c
> > index 8e49d4f85d48..f79c174f4954 100644
> > --- a/drivers/net/dsa/realtek-smi-core.c
> > +++ b/drivers/net/dsa/realtek-smi-core.c
> > @@ -394,6 +394,13 @@ static int realtek_smi_probe(struct platform_devic=
e *pdev)
> >       var =3D of_device_get_match_data(dev);
> >       np =3D dev->of_node;
> >
> > +     /* This driver assumes the child PHYs would be probed successfull=
y
> > +      * before this functions returns. That's not a valid assumption, =
but
> > +      * let fw_devlink know so that this driver continues to function =
with
> > +      * fw_devlink=3Don.
> > +      */
> > +     np->fwnode.flags |=3D FWNODE_FLAG_BROKEN_PARENT;
> > +
> >       smi =3D devm_kzalloc(dev, sizeof(*smi) + var->chip_data_sz, GFP_K=
ERNEL);
> >       if (!smi)
> >               return -ENOMEM;
> >
