Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B70449E4F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 22:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238157AbhKHVjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 16:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238291AbhKHVjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 16:39:45 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2D5C061764
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 13:37:00 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id u2so29849959oiu.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 13:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=swiecki.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IsLQjaQdlMGXIqecV4wPF8ML0lgecFSezbvs+txi9VE=;
        b=dO/8dgSkwsbaWeZhkST1HoJnZWRSi9WmJh6Z+KGnOn/I5nSUwEdWTYmTuxCFpoL0ms
         QXtz+2H8zmEf/z8pvOeYPDdyaAxvAganwCNlM7m6EOfImqGW9PSSYCfU1pt7DRoFDDXA
         MTmEbkAfnMFwS5N3tZ/HnExYQtnOEtpv8bknU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IsLQjaQdlMGXIqecV4wPF8ML0lgecFSezbvs+txi9VE=;
        b=PdoqB6bW2Ad91lYU859MDbE4JlP9o6t3vBeZVWgv9WnENeMBVYyieQJ5dpeUDOfYe5
         BJ3Yk+eCspXmJGc6adYUIHKw2v0XuD+XBvOx7p8wTb/DT+CyqnLzgU90Mqj0iN8CX4U4
         xkzGurdxXojPGq57ojIESYPpWdwil8JhoF59s/HTju8ivkGXghZSCuju3yVVFhjR5CvV
         45SCQcx7yTkRY+SKQVrjuJPOQYkzmwdIg+IZogFu2s7shsHoxlIsjCIva6hQxft8IxF8
         qtIHbPN/motFvQlBQKpATAOW9Ueq28bkoJHTuvhm0WPqS0iVg0e5DSH8KCMS7tLuDOND
         Dnkg==
X-Gm-Message-State: AOAM533XYi7lITvN4kAdlW3semdeyBm+3Zs/LKg4dWaCAmZRh7EdloUI
        J3Ic3VqmCpRDuykT47WU8pY8Pzr4VePldKgftT3w6A==
X-Google-Smtp-Source: ABdhPJxdmLSrnfD8gVnnutOGCvmzv2yNsvvaDMK3Mj2LQK2LTxpzAtdqhn4xDaUdcEVCmY4+jYIJjvEhNWnCKQH/g0Q=
X-Received: by 2002:a54:4e98:: with SMTP id c24mr1286748oiy.144.1636407419924;
 Mon, 08 Nov 2021 13:36:59 -0800 (PST)
MIME-Version: 1.0
References: <CAP145phj7jEy6tkdFMdW-rzPprMTUckaaSrtrVysE-u+S+=Lcg@mail.gmail.com>
 <20211108185823.GA1101310@bhelgaas> <20211108212226.253mwl4wp7xjckqz@pengutronix.de>
In-Reply-To: <20211108212226.253mwl4wp7xjckqz@pengutronix.de>
From:   =?UTF-8?B?Um9iZXJ0IMWad2nEmWNraQ==?= <robert@swiecki.net>
Date:   Mon, 8 Nov 2021 22:36:49 +0100
Message-ID: <CAP145phFHh+pMTXbdwwQK6bgxLBcF2JgQKwz2L+2vJRs2dMiVg@mail.gmail.com>
Subject: Re: [PATCH] pci: Don't call resume callback for nearly bound devices
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-i2c@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

> > Here's the call tree:
> >
> >     really_probe
> >       dev->driver = drv;                       # <--
> >       call_driver_probe
> >         dev->bus->probe
> >           pci_device_probe
> >             __pci_device_probe
> >               pci_call_probe
> >                 local_pci_probe
> >                   pm_runtime_get_sync
> >                     ...
> >                     pci_pm_runtime_resume
> >   -                   if (!pci_dev->driver)    # 2a4d9408c9e8 ("PCI: Use to_pci_driver() instead of pci_dev->driver")
> >   +                   if (!to_pci_driver(dev->driver))
> >                         return 0
> >                       pm->runtime_resume
> >                         i2c_dw_pci_resume
> >                           i_dev->init()        # <-- NULL ptr deref
> >   -                 pci_dev->driver = pci_drv  # b5f9c644eb1b ("PCI: Remove struct pci_dev->driver")
> >                   pci_drv->probe
> >                     i2c_dw_pci_probe
>
> I think this analysis is right.
>
> I didn't test this patch, @Robert, maybe you can do this?
>
> Best regards
> Uwe
>
>  drivers/pci/pci-driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 1d98c974381c..202533654012 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1299,7 +1299,7 @@ static int pci_pm_runtime_resume(struct device *dev)
>          */
>         pci_restore_standard_config(pci_dev);
>
> -       if (!to_pci_driver(dev->driver))
> +       if (!device_is_bound(dev))
>                 return 0;
>
>         pci_fixup_device(pci_fixup_resume_early, pci_dev);

Yes, that fixes it. Thanks for the patch.
