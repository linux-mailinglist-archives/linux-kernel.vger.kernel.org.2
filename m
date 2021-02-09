Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44A2315412
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 17:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbhBIQj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 11:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbhBIQjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 11:39:36 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B8EC061574
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 08:38:55 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id k204so18491082oih.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 08:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D1W20Sq6TDjaUrVZvwmz75ySVD0FOUb+UxbG/t0eOoA=;
        b=sSkdzcMRmGDjsifSGK/jX2Vc8A6gs87kgs/VT4JncpFc2NXQXZ7Wo/pv2KcoUztrGr
         hc9oJHfpEpTVNeXYPgQzZf/qOk0MiXscFUGsyp36ZxxcwGhOCJo+9eJ5Gr6rZCFbYkFB
         rnjOz+PosFlEzlSxO/arOu9Oc+2xgFyg/cgqRYfrDIXU15v4amvidtEyktIpUJNq05hl
         hEFuvxFfdP+bnoLVWJfYp3zECWr+vKhZlkWEaBCSIOZVAmTxPBwuMJ/MIy67BaYHWn97
         3D4W6sAXDMwXfxDq0H8xnyMoLYth9IMbarJZOQY4uB2XcZkM5Hla2th7sTwro69JCAEE
         R1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D1W20Sq6TDjaUrVZvwmz75ySVD0FOUb+UxbG/t0eOoA=;
        b=lQJhA6cTotMY4eG4H0GpfPe/9/lBUJ9FpcB+EfmKryGhjimcjnBaEHJhKB9UrfqRzr
         l8ms/ONHxTnaUDIJESu1y8CknrVG/9J9Uu/JQLlAFzxcG6eNO9bUR4xCbrgQaC3yMtRP
         JJgSmYahMy7LiZZEJBAUYRIWEmk37eVdOi3iabM0p0JWU0GNgR3p1QPSpcdO9BCZKteV
         tnA9Ho1pgv+0zoXn+vBSPdLRvErsMnZO2j7icUmPjp570YCUORJp4cKByCuHdBKdxcgD
         mxawWcRbrxS7Hc0otu2lPxSlwP9An8ojSc6m8s+AbZSP4q45AhLZagwFndjErFbPEsj0
         a6wQ==
X-Gm-Message-State: AOAM5315g5tnDN8s9UHBKEFGSZLr0dQnYXBxIprkLlTbRQSTWJKRDjzl
        o3roghb0In6gZB0IPj6biBclucE8yg6qLVi3VN72SYU+rG8=
X-Google-Smtp-Source: ABdhPJzrYrvRsCx/SaVSQEfLelG+EocEdczfs1JYffxGBzLnGbfxqcWY6RCs0/Lc4X1xz1BwlT/ukEE2l1kzxS52vgw=
X-Received: by 2002:aca:5a57:: with SMTP id o84mr3034936oib.0.1612888735437;
 Tue, 09 Feb 2021 08:38:55 -0800 (PST)
MIME-Version: 1.0
References: <20210209125912.3398-1-nsaenzjulienne@suse.de> <20210209125912.3398-10-nsaenzjulienne@suse.de>
 <CAMEGJJ3i_hEAnO4rDQ+emqB=OYXetLyKh1kMRwAbUnYZ1e48VA@mail.gmail.com> <56e237a8d0646c03d4ff44e439d1b0f81c800a9b.camel@suse.de>
In-Reply-To: <56e237a8d0646c03d4ff44e439d1b0f81c800a9b.camel@suse.de>
From:   Phil Elwell <phil@raspberrypi.com>
Date:   Tue, 9 Feb 2021 16:38:45 +0000
Message-ID: <CAMEGJJ3d-d7-h_=B2XpFAiwSAdfnsPGh1mZjX5=sdeu3PNTPmg@mail.gmail.com>
Subject: Re: [RFC/PATCH v2 09/16] soc: bcm: bcm2835-power: Add support for
 BCM2711's Argon ASB
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>, wahrenst@gmx.net,
        linux-arm-kernel@lists.infradead.org, mripard@kernel.org,
        eric@anholt.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas,


On Tue, 9 Feb 2021 at 14:00, Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> On Tue, 2021-02-09 at 13:19 +0000, Phil Elwell wrote:
> > Hi Nicolas,
> >
> > On Tue, 9 Feb 2021 at 13:00, Nicolas Saenz Julienne
> > <nsaenzjulienne@suse.de> wrote:
> > >
> > > In BCM2711 the new ARGON ASB took over V3D. The old ASB is still present
> > > with the ISP and H264 bits, and V3D is in the same place in the new ASB
> > > as the old one.
> > >
> > > Use the fact that 'pm->argon_asb' is populated as a hint that we're on
> > > BCM2711. On top of that introduce the macro ASB_BASE() which will select
> > > the correct ASB register base, based on whether we're trying to access
> > > V3D and which platform we're on.
> >
> > Please don't refer to this block as ARGON - it is the IP of Raspberry
> > Pi Trading and it's name is RPiVid.
>
> OK, sorry for that. I, again, mixed both ASB names. I'll rename the Argon ASB
> to RPiVid. How should I call the one present in older RPis?

It can keep its unqualified name of ASB_*.

>
> > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > >
> > > ---
> > >
> > > Changes since v1:
> > >  - Correct names
> > >
> > >  drivers/soc/bcm/bcm2835-power.c | 68 ++++++++++++++++++++-------------
> > >  1 file changed, 42 insertions(+), 26 deletions(-)
> > >
> > > diff --git a/drivers/soc/bcm/bcm2835-power.c b/drivers/soc/bcm/bcm2835-power.c
> > > index 59b8abfc5617..42e105758b47 100644
> > > --- a/drivers/soc/bcm/bcm2835-power.c
>
> [...]
>
> > >         case BCM2835_POWER_DOMAIN_USB:
> > >                 PM_WRITE(PM_USB, 0);
> > > @@ -626,13 +633,22 @@ static int bcm2835_power_probe(struct platform_device *pdev)
> > >         power->dev = dev;
> > >         power->base = pm->base;
> > >         power->rpivid_asb = pm->rpivid_asb;
> > > +       power->argon_asb = pm->argon_asb;
> > >
> > > -       id = ASB_READ(ASB_AXI_BRDG_ID);
> > > +       id = ASB_READ(ASB_AXI_BRDG_ID, false);
> > >         if (id != 0x62726467 /* "BRDG" */) {
> > > -               dev_err(dev, "ASB register ID returned 0x%08x\n", id);
> > > +               dev_err(dev, "RPiVid ASB register ID returned 0x%08x\n", id);
> > >                 return -ENODEV;
> > >         }
> > >
> > > +       if (pm->argon_asb) {
> > > +               id = ASB_READ(ASB_AXI_BRDG_ID, true);
> > > +               if (id != 0x62726467 /* "BRDG" */) {
> > > +                       dev_err(dev, "Argon ASB register ID returned 0x%08x\n", id);
> > > +                       return -ENODEV;
> > > +               }
> > > +       }
> > > +
> >
> > Surely these are the same register. Is this the result of a bad merge?
>
> AFAIU There are two ASBs the old one at 0x7e00a000 and the new RPiVid one at
> 0x7ec11000. They both can be checked for valid IDs. Note the new argument in
> ASB_READ().

You're right - I'd missed the parameter. Apologies.

Phil
