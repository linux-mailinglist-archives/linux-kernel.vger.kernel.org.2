Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC613CF247
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 04:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345227AbhGTCRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 22:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235860AbhGTCQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 22:16:34 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FC8C0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 19:57:12 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id dj21so26771416edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 19:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ARkIuYATvHijD8XSWeM3n42afJoDm+rNzi1meXbXw5I=;
        b=QL5FkO5N2icD8kCtOXcxxZ0Rqthk681wn1TgMqBfRKJUo0qUVbtLQXtPNA8G4sU0Ao
         419DXq9TFx8RMxB+OCjTER5zC1tzWGSXirca7Jymsol+oeU0XtKu0XhLCH8qVT+sFgO0
         MRpyYDucCxlRgfy/y5xusAG/6blF4Sze2o4s0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ARkIuYATvHijD8XSWeM3n42afJoDm+rNzi1meXbXw5I=;
        b=eEvBZWIgcZDxtiwjeekh+Z1sNzaTQfcn30AaSD+1ilVcp3uJnsNm13a5apth8ygfqw
         wSD6nBE/VxrLAfYXNQ6vMPd4nbKIKApmh4/Me/LRKQtEC0zaMgTM0RO6ACxbLZX06gb5
         MgMYjQkPSkwZukqN9Z4xbtgWkiXdJJ1HxZ+9/dE+xRA3JQjGU97wNcKddLn4LEzH+gFm
         rnDU81ej2hd0lyyM1fecmPMuua1gcESwugquKoeVytF85fJLJVqPJT3aLVreJxwiQWTh
         leuIo2pJP+vacX6RhmnnHXeHtw9d3C2g723w7H/Tq3uRmHv+l+cYJPMGdCvjEJVdmWRT
         Q07g==
X-Gm-Message-State: AOAM531ES5du7vpY0OBcLrdOPmaRyGd9nnwB/6SySt3EeJVOdLfqo/xc
        DYnLfAXFAWc2xaGVlH68MOWHnVosN+pBaCotrwIYF/N4tGwykQ==
X-Google-Smtp-Source: ABdhPJwrixo2eV3JX8+zlh7Mcq5pmNkQuNd1/alqHfKOTAwf5VQFdznjgweS35WQ2IuK4mOUtlanjfGDsBWNBc166Hg=
X-Received: by 2002:a05:6402:c13:: with SMTP id co19mr37911017edb.64.1626749831079;
 Mon, 19 Jul 2021 19:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210712060912.995381202@linuxfoundation.org> <20210712060916.499546891@linuxfoundation.org>
 <CAFxkdApAJ2i_Bg6Ghd38Tw9Lz5s6FTKP=3-+pSWM-cDT427i2g@mail.gmail.com>
 <YPNavEl340mxcNVd@epycbox.lan> <CAFxkdApGaw30O2HEkTA8r6g4_dLZEbykVjnnDnfTiX=3hVQwvw@mail.gmail.com>
In-Reply-To: <CAFxkdApGaw30O2HEkTA8r6g4_dLZEbykVjnnDnfTiX=3hVQwvw@mail.gmail.com>
From:   Justin Forbes <jmforbes@linuxtx.org>
Date:   Mon, 19 Jul 2021 21:57:00 -0500
Message-ID: <CAFxkdAqd69oXdhUBEmMRvmfuk2YpWS7qsDKLjUEAEg8rhQkTyQ@mail.gmail.com>
Subject: Re: [PATCH 5.13 024/800] usb: renesas-xhci: Fix handling of unknown
 ROM state
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 10:33 AM Justin Forbes <jmforbes@linuxtx.org> wrote:
>
> On Sat, Jul 17, 2021 at 5:33 PM Moritz Fischer <mdf@kernel.org> wrote:
> >
> > Justin,
> >
> > On Sat, Jul 17, 2021 at 08:39:19AM -0500, Justin Forbes wrote:
> > > On Mon, Jul 12, 2021 at 2:31 AM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > From: Moritz Fischer <mdf@kernel.org>
> > > >
> > > > commit d143825baf15f204dac60acdf95e428182aa3374 upstream.
> > > >
> > > > The ROM load sometimes seems to return an unknown status
> > > > (RENESAS_ROM_STATUS_NO_RESULT) instead of success / fail.
> > > >
> > > > If the ROM load indeed failed this leads to failures when trying to
> > > > communicate with the controller later on.
> > > >
> > > > Attempt to load firmware using RAM load in those cases.
> > > >
> > > > Fixes: 2478be82de44 ("usb: renesas-xhci: Add ROM loader for uPD720201")
> > > > Cc: stable@vger.kernel.org
> > > > Cc: Mathias Nyman <mathias.nyman@intel.com>
> > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Cc: Vinod Koul <vkoul@kernel.org>
> > > > Tested-by: Vinod Koul <vkoul@kernel.org>
> > > > Reviewed-by: Vinod Koul <vkoul@kernel.org>
> > > > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > > > Link: https://lore.kernel.org/r/20210615153758.253572-1-mdf@kernel.org
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > >
> > >
> > > After sending out 5.12.17 for testing, we had a user complain that all
> > > of their USB devices disappeared with the error:
> > >
> > > Jul 15 23:18:53 kernel: xhci_hcd 0000:04:00.0: Direct firmware load
> > > for renesas_usb_fw.mem failed with error -2
> > > Jul 15 23:18:53 kernel: xhci_hcd 0000:04:00.0: request_firmware failed: -2
> > > Jul 15 23:18:53 kernel: xhci_hcd: probe of 0000:04:00.0 failed with error -2
> >
> > This looks like it fails finding the actual firmware file (ENOENT). Any
> > chance you could give this a whirl on top of the original patch?
> >
>
> Sure. test kernel building now, will let you know when the user reports back.

The original user reports success with this patch on top of the original patch.

Justin

>
> Justin
>
> > diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> > index 18c2bbddf080..cde8f6f1ec5d 100644
> > --- a/drivers/usb/host/xhci-pci.c
> > +++ b/drivers/usb/host/xhci-pci.c
> > @@ -379,7 +379,11 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
> >         driver_data = (struct xhci_driver_data *)id->driver_data;
> >         if (driver_data && driver_data->quirks & XHCI_RENESAS_FW_QUIRK) {
> >                 retval = renesas_xhci_check_request_fw(dev, id);
> > -               if (retval)
> > +               /*
> > +                * If firmware wasn't found there's still a chance this might work without
> > +                * loading firmware on some systems, so let's try at least.
> > +                */
> > +               if (retval && retval != -ENOENT)
> >                         return retval;
> >         }
> >
> >
> > Thanks,
> > Moritz
