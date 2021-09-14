Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0088040A8B9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 09:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhINIAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 04:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhINIAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 04:00:19 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB40C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:59:02 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id r4so26297468ybp.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0pwGfJMV7NseEnAXPu8B0bfj+z3LRZz+NIFv3KDIqC8=;
        b=c7lpV8oW8ZCc73QyZnOFvbXq40J312LhEEq1FBJKPqDlu6GlL3LV+/tdN61//RwVqg
         4Z1ltcnV4gJzi5pAexn3I2vw99jzl/bYJVy5blKsqlAgD9IC8K+BmOzzk0lUl+uQIpRJ
         sIZAmuzmbQlctrRQG8Th2pqO2EtKqwSMzlPEn+rTvgwaf6iWJCLhI/fivQJXqUq346HT
         QbTshs9b7YdKIdy9u/UTBOj21Er8bFXn6qfXMF8qFvA7TtZwN/pbLzb+Wnmk/2MEalzj
         JPbvdXiTslo0usna3ET9NiOm5jxqSUnJ/RtTRSvsSMF8L5oaSMF9KD6qxk/o7poJ8362
         5bzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0pwGfJMV7NseEnAXPu8B0bfj+z3LRZz+NIFv3KDIqC8=;
        b=c6KF8R2HfLWEsVo5xgbsmkSpiZDtpTnsQor2QIlp+Xw53TgLAXz8xZ05EiLa1pUw2/
         yD7T2MJVzygzRaAEFpbNrR8UNBgcPTPDBWQB8tK8iKHinVs/GlZM7LxBvMaETU0mEuHQ
         DYrTSk4wENDb2uyr23Uu1uWxTEgPA98QmMfE7Xyteu0PoD6R8GabiZt2zdZPapka1Hjf
         KSELqzXa7ZK4qOibxDE3aQu3A0EKCfoQij1bxtdqNz6boP7V6HsM8XSlcKNWdMSvyBZA
         3yzHgZcbtQT8S+mNfDoVveJ1jNXhdlFrz2izST4nk+ZTVYxP2bEn77+Q8UEOdh9yNpDE
         bO6Q==
X-Gm-Message-State: AOAM533rnu08HqnA8hCIUm7PLX9cm8jOS2zAJvEcsXw812zMuhbgf9Nd
        ma7USAoef2FVu16+4OtudnNsB5OAjE+wRJZkxVfPgw==
X-Google-Smtp-Source: ABdhPJy1QpNn2oE5WlGYncvCzffQmkJWaNoB2BrVF0WUhlAGsaLvNXYhL1PATcrouJojFgpo1OVked7w8Hau9Vxh710=
X-Received: by 2002:a25:21c5:: with SMTP id h188mr19300583ybh.23.1631606341321;
 Tue, 14 Sep 2021 00:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210914043928.4066136-1-saravanak@google.com>
 <20210914043928.4066136-3-saravanak@google.com> <CAMuHMdU8n9LH7+sZ-OFuce_y89GsQvt+HGUYdQMYCqOxoM3Y7Q@mail.gmail.com>
In-Reply-To: <CAMuHMdU8n9LH7+sZ-OFuce_y89GsQvt+HGUYdQMYCqOxoM3Y7Q@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 14 Sep 2021 00:58:25 -0700
Message-ID: <CAGETcx8myxTU=F63MC_FFLXsWakMqBYBbajneV=buwXGs70j+w@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] driver core: Set deferred probe reason when
 deferred by driver core
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 12:01 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Saravana,
>
> On Tue, Sep 14, 2021 at 6:39 AM Saravana Kannan <saravanak@google.com> wrote:
> > When the driver core defers the probe of a device, set the deferred
> > probe reason so that it's easier to debug. The deferred probe reason is
> > available in debugfs under devices_deferred.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>
> Thanks for your patch!

Thanks for the reviews!

>
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -955,6 +955,29 @@ static void device_links_missing_supplier(struct device *dev)
> >         }
> >  }
> >
> > +/**
> > + * dev_set_def_probe_reason - Set the deferred probe reason for a device
> > + * @dev: the pointer to the struct device
> > + * @fmt: printf-style format string
> > + * @...: arguments as specified in the format string
> > + *
> > + * This is a more caller-friendly version of device_set_deferred_probe_reason()
> > + * that takes variable argument inputs similar to dev_info().
> > + */
> > +static void dev_set_def_probe_reason(const struct device *dev, const char *fmt, ...)
>
> So this is indeed similar to device_set_deferred_probe_reason(),
> but the function's name is completely different, unlike e.g.
> (v)printf()?

Yes.

>
> > +{
> > +       struct va_format vaf;
> > +       va_list args;
> > +
> > +       va_start(args, fmt);
> > +       vaf.fmt = fmt;
> > +       vaf.va = &args;
> > +
> > +       device_set_deferred_probe_reason(dev, &vaf);
> > +
> > +       va_end(args);
> > +}
>
> I think you can just make this a macro wrapper calling
> dev_err_probe(dev, -EPROBE_DEFER, fmt, ...).
> Or open-code that below.

Good point. I think I can make it be a wrapper macro.

>
> > +
> >  /**
> >   * device_links_check_suppliers - Check presence of supplier drivers.
> >   * @dev: Consumer device.
> > @@ -975,6 +998,7 @@ int device_links_check_suppliers(struct device *dev)
> >  {
> >         struct device_link *link;
> >         int ret = 0;
> > +       struct fwnode_handle *sup_fw;
> >
> >         /*
> >          * Device waiting for supplier to become available is not allowed to
> > @@ -983,10 +1007,13 @@ int device_links_check_suppliers(struct device *dev)
> >         mutex_lock(&fwnode_link_lock);
> >         if (dev->fwnode && !list_empty(&dev->fwnode->suppliers) &&
> >             !fw_devlink_is_permissive()) {
> > +               sup_fw = list_first_entry(&dev->fwnode->suppliers,
> > +                                         struct fwnode_link,
> > +                                         c_hook)->supplier;
> >                 dev_dbg(dev, "probe deferral - wait for supplier %pfwP\n",
> > -                       list_first_entry(&dev->fwnode->suppliers,
> > -                       struct fwnode_link,
> > -                       c_hook)->supplier);
> > +                       sup_fw);
> > +               dev_set_def_probe_reason(dev,
> > +                       "wait for supplier %pfwP\n", sup_fw);
>
> dev_err_probe() would replace both the dev_dbg() and the
> dev_set_def_probe_reason().

I intentionally didn't use dev_err_probe() because:

1. I wanted the messages to be a bit different -- not have the "probe
deferral" in the deferred_devices file but have it in the dmesg logs
so that the log is clearer.
2. And more importantly, I'm working on a patch (could take a few
weeks) that'll make this place return -EPROBE_DEFER vs -ENODEV (or
whatever) for different situations. And using dev_err_probe() with
-ENODEV would cause it to print the error (when I don't want it to).
And always doing dev_err_probe(dev, -EPROBE_DEFER,...) while returning
-ENODEV would be confusing.

>
> >                 mutex_unlock(&fwnode_link_lock);
> >                 return -EPROBE_DEFER;
> >         }
> > @@ -1003,6 +1030,9 @@ int device_links_check_suppliers(struct device *dev)
> >                         device_links_missing_supplier(dev);
> >                         dev_dbg(dev, "probe deferral - supplier %s not ready\n",
> >                                 dev_name(link->supplier));
> > +                       dev_set_def_probe_reason(dev,
> > +                               "supplier %s not ready\n",
> > +                               dev_name(link->supplier));
>
> Likewise.

Same reason as above.

I mainly added you for comments on 5/5. Hopefully you'll have some
comments on that too by the time I'm up tomorrow :)

-Saravana

>
> >                         ret = -EPROBE_DEFER;
> >                         break;
> >                 }
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
